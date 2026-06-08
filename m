Return-Path: <linux-nfs+bounces-22381-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NxatJTEhJ2pfsQIAu9opvQ
	(envelope-from <linux-nfs+bounces-22381-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 08 Jun 2026 22:08:17 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E557965A487
	for <lists+linux-nfs@lfdr.de>; Mon, 08 Jun 2026 22:08:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=AnLt7C1N;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22381-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22381-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8D493011C71
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jun 2026 20:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89B73D3CE3;
	Mon,  8 Jun 2026 20:08:14 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C6631F9B4;
	Mon,  8 Jun 2026 20:08:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780949294; cv=none; b=IkTyEppxWVOh5RpRNVT3MKTjROLO2HIBbBDRroNPneXNEU8h57qIapaY9Jucs9pVAZnfQp7TJMtmEzxinJePG0EhcOPBbSv2XqSaVEpKejsvQSp6iO7NbalEB3poAzVFZMMTXlv8R50/a/z1e0k/20BFw4nHebTW6+oAGbCQWOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780949294; c=relaxed/simple;
	bh=waUur4CucJO6qOjwL6GlEcvOwDg5YiIp/PXOTLj9UKk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rglVWnrf73BPO+/PFWvlpdHwlSTBLQcFJN0wf/7rfRyiyqFgo3EpsuhjuYFOy+raGtrdCjt5Mboix0TIy9l106FiMUWjZ4t8Jg2VZo6XbD3wEtGaHMxB1aotg/iuScYbvY31pd84vvjdVLttbm+pIUAj488QqXn4f3BH1nMxK8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnLt7C1N; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D9D1F00893;
	Mon,  8 Jun 2026 20:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780949293;
	bh=PKV9ey2fkieIe18ckC+tbTRLTOWdiRb4JQ7xkIPvkok=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AnLt7C1NTyLwJoldYhVdAOvUyWPbe0AewR1ubMhHVDLwmBzzlXF44Wmn67tkdwUJ7
	 obvZ9HnyYCkkgSQMe5omyRRnrDp47r26Z0QaUExMF5kENaCYjyYKrxNJCBSr3zGjok
	 dZw+kOq4aeS5sujORLPXC+a4E2EuqdEOFrdyRc7sgm6m4nipuy8jlB55IkkaU12FTp
	 7nhm5WYnA5HmMq/nRk+4wIi8TJDX7mp3jh1HNiWSil4XV+YD6w/RkHqM3mKOtX7dzs
	 gUBgh5hDne2d/v4Ly48F9boAQIXPIkZk+woQqYByGHo4Ub4gaLcZL9dB85qn32SceL
	 jtgEb/rulZcZw==
Message-ID: <b079350d0d15f7eee7f107a4bde8039358f56e25.camel@kernel.org>
Subject: Re: [PATCH] vfs: add FS_USERNS_DELEGATABLE flag and set it for NFS
From: Jeff Layton <jlayton@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>,  "Seth Forshee
 (DigitalOcean)"	 <sforshee@kernel.org>, Alexander Mikhalitsyn
 <alexander@mihalicyn.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Date: Mon, 08 Jun 2026 16:08:10 -0400
In-Reply-To: <20260129-twmount-v1-1-4874ed2a15c4@kernel.org>
References: <20260129-twmount-v1-1-4874ed2a15c4@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22381-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:sforshee@kernel.org,m:alexander@mihalicyn.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E557965A487

On Thu, 2026-01-29 at 16:47 -0500, Jeff Layton wrote:
> Commit e1c5ae59c0f2 ("fs: don't allow non-init s_user_ns for filesystems
> without FS_USERNS_MOUNT") prevents the mount of any filesystem inside a
> container that doesn't have FS_USERNS_MOUNT set.
>=20
> This broke NFS mounts in our containerized environment. We have a daemon
> somewhat like systemd-mountfsd running in the init_ns. A process does a
> fsopen() inside the container and passes it to the daemon via unix
> socket.
>=20
> The daemon then vets that the request is for an allowed NFS server and
> performs the mount. This now fails because the fc->user_ns is set to the
> value in the container and NFS doesn't set FS_USERNS_MOUNT.  We don't
> want to add FS_USERNS_MOUNT to NFS since that would allow the container
> to mount any NFS server (even malicious ones).
>=20
> Add a new FS_USERNS_DELEGATABLE flag, and enable it on NFS.
>=20
> Fixes: e1c5ae59c0f2 ("fs: don't allow non-init s_user_ns for filesystems =
without FS_USERNS_MOUNT")
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfs/fs_context.c |  8 ++++++--
>  fs/super.c          | 11 ++++++-----
>  include/linux/fs.h  |  1 +
>  3 files changed, 13 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> index b4679b7161b0968810e13f57c889052ea015bf56..128ebd48b4f4ba1c17e8b5b1b=
9dcefbd7a97db1a 100644
> --- a/fs/nfs/fs_context.c
> +++ b/fs/nfs/fs_context.c
> @@ -1768,7 +1768,9 @@ struct file_system_type nfs_fs_type =3D {
>  	.init_fs_context	=3D nfs_init_fs_context,
>  	.parameters		=3D nfs_fs_parameters,
>  	.kill_sb		=3D nfs_kill_super,
> -	.fs_flags		=3D FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
> +	.fs_flags		=3D FS_RENAME_DOES_D_MOVE	|
> +				  FS_BINARY_MOUNTDATA	|
> +				  FS_USERNS_DELEGATABLE,
>  };
>  MODULE_ALIAS_FS("nfs");
>  EXPORT_SYMBOL_GPL(nfs_fs_type);
> @@ -1780,7 +1782,9 @@ struct file_system_type nfs4_fs_type =3D {
>  	.init_fs_context	=3D nfs_init_fs_context,
>  	.parameters		=3D nfs_fs_parameters,
>  	.kill_sb		=3D nfs_kill_super,
> -	.fs_flags		=3D FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
> +	.fs_flags		=3D FS_RENAME_DOES_D_MOVE	|
> +				  FS_BINARY_MOUNTDATA	|
> +				  FS_USERNS_DELEGATABLE,
>  };
>  MODULE_ALIAS_FS("nfs4");
>  MODULE_ALIAS("nfs4");
> diff --git a/fs/super.c b/fs/super.c
> index 3d85265d14001d51524dbaec0778af8f12c048ac..b7f1bb2b679b43261fbdcd586=
971c551b85e8372 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -738,12 +738,13 @@ struct super_block *sget_fc(struct fs_context *fc,
>  	int err;
> =20
>  	/*
> -	 * Never allow s_user_ns !=3D &init_user_ns when FS_USERNS_MOUNT is
> -	 * not set, as the filesystem is likely unprepared to handle it.
> -	 * This can happen when fsconfig() is called from init_user_ns with
> -	 * an fs_fd opened in another user namespace.
> +	 * Never allow s_user_ns !=3D &init_user_ns when FS_USERNS_MOUNT or
> +	 * FS_USERNS_DELEGATABLE is not set, as the filesystem is likely
> +	 * unprepared to handle it. This can happen when fsconfig() is called
> +	 * from init_user_ns with an fs_fd opened in another user namespace.
>  	 */
> -	if (user_ns !=3D &init_user_ns && !(fc->fs_type->fs_flags & FS_USERNS_M=
OUNT)) {
> +	if (user_ns !=3D &init_user_ns &&
> +	    !(fc->fs_type->fs_flags & (FS_USERNS_MOUNT | FS_USERNS_DELEGATABLE)=
)) {
>  		errorfc(fc, "VFS: Mounting from non-initial user namespace is not allo=
wed");
>  		return ERR_PTR(-EPERM);
>  	}
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index a01621fa636a60764e1dfe83f2260caf50c4037e..94695ce5e25b5fbe4f321d547=
8172b8cb24e00d1 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2273,6 +2273,7 @@ struct file_system_type {
>  #define FS_MGTIME		64	/* FS uses multigrain timestamps */
>  #define FS_LBS			128	/* FS supports LBS */
>  #define FS_POWER_FREEZE		256	/* Always freeze on suspend/hibernate */
> +#define FS_USERNS_DELEGATABLE	512	/* Can be mounted inside userns from o=
utside */
>  #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during re=
name() internally. */
>  	int (*init_fs_context)(struct fs_context *);
>  	const struct fs_parameter_spec *parameters;
>=20
> ---
> base-commit: 8dfce8991b95d8625d0a1d2896e42f93b9d7f68d
> change-id: 20260129-twmount-114ddfd43420
>=20
> Best regards,

Ping?

I just realized that this patch never made it into -next or a release.
Any chance we can get this into the coming v7.3 merge window? (although
it looks like we'll need to renumber the bit since
FS_USERNS_MOUNT_RESTRICTED has gone in since then.

Thanks,
--=20
Jeff Layton <jlayton@kernel.org>

