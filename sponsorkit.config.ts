import { defineConfig, tierPresets } from 'sponsorkit';

export default defineConfig({
	github: {
		login: 'ryoppippi',
		type: 'user',
	},
	outputDir: import.meta.dirname,
	prorateOnetime: true,
	formats: ['svg', 'png'],
	width: 800,
	name: 'sponsors',
	tiers: [
		{
			title: 'Past Sponsors',
			monthlyDollars: -1,
			preset: tierPresets.xs,
			composeBefore: (composer) => {
				composer.addSpan(32);
			},
		},
		{
			title: '❤️ Backers',
			preset: tierPresets.xs,
		},
		{
			title: '☕️ Sponsors',
			monthlyDollars: 4,
			preset: tierPresets.small,
		},
		{
			title: '🦾 Sponsors',
			monthlyDollars: 8,
			preset: tierPresets.base,
		},
		{
			title: '🫶 Sponsors',
			monthlyDollars: 16,
			preset: tierPresets.medium,
		},
		{
			title: '🪀 Sponsors',
			monthlyDollars: 32,
			preset: tierPresets.large,
		},
		{
			title: '🎊 Sponsors',
			monthlyDollars: 64,
			preset: tierPresets.xl,
		},
		{
			title: '🎉 Sponsors',
			monthlyDollars: 128,
			preset: tierPresets.xl,
		},
		{
			title: '😱 Sponsors',
			monthlyDollars: 512,
			preset: tierPresets.xl,
		},
	],
	renders: [
		{
			name: 'sponsors',
			renderer: 'tiers',
			includePastSponsors: false,
		},
		{
			name: 'sponsors.wide',
			width: 1000,
			includePastSponsors: false,
		},
		{
			name: 'sponsors.circles',
			renderer: 'circles',
			includePastSponsors: true,
		},
		{
			name: 'sponsors.past',
			includePastSponsors: true,
		},
	],
	async onSponsorsReady(sponsors) {
		await Bun.write(
			'sponsors.json',
			JSON.stringify(
				sponsors
					.filter((i) => i.privacyLevel !== 'PRIVATE')
					.map((i) => {
						return {
							name: i.sponsor.name,
							login: i.sponsor.login,
							avatar: i.sponsor.avatarUrl,
							amount: i.monthlyDollars,
							link: i.sponsor.linkUrl || i.sponsor.websiteUrl,
							org: i.sponsor.type === 'Organization',
						};
					})
					.sort((a, b) => b.amount - a.amount),
				null,
				2,
			),
		);
	},
});
