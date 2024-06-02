module.exports = {
	apps: [
		{
			name: 'config-management',
			script: 'bundle',
			args: 'exec puma -C config/puma.rb',
			interpreter: 'bash',
			cwd: '/home/viapulsa/certbot/simpul-chat-server',
			env: {
				RAILS_ENV: 'production',
				PORT: 8006,
			},
		},
	],
};
