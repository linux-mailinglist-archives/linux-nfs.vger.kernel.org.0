Return-Path: <linux-nfs+bounces-3687-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B95904AAB
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 07:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B1B11F21740
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 05:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D0528DD1;
	Wed, 12 Jun 2024 05:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vZjRJZh/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Z7Q440C4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AXibarAE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yyRG1u5A"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A092CCB4
	for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 05:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718169159; cv=none; b=MqbdwhVFuZ/DSWbpngORvfp1qX/gPBoAs+OS9YvIIJnIvhMB7dV02Qr6znkK4NShNe5iRMe0NElNqVU5XoJXP2yNEvFNm8dFWMUXmUd310bGxpQ06lW9avLR0MbUvtU6WDUfD44tVRG2+U6w8AzLLNv2KXwV7kzcTB1cf+nmuO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718169159; c=relaxed/simple;
	bh=vBdM/Ye75Qw1T043UeF9Lvlty95qz8z03txAY9G9iRk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=IaBnk6luRwo0DMtBwaOy5Z73Q7dM9Wev06QgrZ4iN1RoVtMgw4NhjxDCihNTR8Oypq+6Cug9HBg2tBd2sEmJ67d3xy9kJtABUkZqThqpVq/B4TO+pLQIYbiQG05GK8MT65VEhtuEXZ3k49CqvutXJCQPLNNB+Lozk3+s4CA22nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vZjRJZh/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Z7Q440C4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AXibarAE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yyRG1u5A; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 93EE933EC4;
	Wed, 12 Jun 2024 05:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718169155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PgIBUf3Eh80KR4DTjpu9OuJUOdd5bk3tXDVe3ox8OrE=;
	b=vZjRJZh/+KLXvEWLzoi2YsI3F8QlQrwBgovDXgB+aa65QXrtlmsFxyxZYksQsdR8Pel3pq
	RlNpmUacGbfI9VMdFvMiYOpT7JN3P3tGLb7TyFXs+/Odbu/0oNKdPH2AqtZn/N0xgkquYe
	Kp5AGfWwN112ZSFqr80dSh8b4XixtUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718169155;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PgIBUf3Eh80KR4DTjpu9OuJUOdd5bk3tXDVe3ox8OrE=;
	b=Z7Q440C4tIyD5fPD/kKS0lIXupGRe+eopRzpFZx3+TlTfx6satBx/i2aQqqQCZDwblmGL8
	5Aef4LRizJEVfZDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AXibarAE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yyRG1u5A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718169154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PgIBUf3Eh80KR4DTjpu9OuJUOdd5bk3tXDVe3ox8OrE=;
	b=AXibarAEMLQI57x2vV+HabTYhfJNUygRVCB/SpyiFmG0qBq1PlU/V5zsRtE8KSAfaG4K9Y
	6Rh0L/Lv3+K6gaapafV3Ap8uqExMQpXpfah8in2sEKyhYFf9DJk5sv6LkqT3oZCoQXbJng
	RR7FhjzNtoOM83jsKhx/I9tmLjEd5Sw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718169154;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PgIBUf3Eh80KR4DTjpu9OuJUOdd5bk3tXDVe3ox8OrE=;
	b=yyRG1u5A/TLc6M0vcD5arY4xctbIbJlI92eZJNwVRG8l7h/jiecGIYXCvkWrUhJBcbHpOV
	vUeXu4NA+N73XSBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F2D16137DF;
	Wed, 12 Jun 2024 05:12:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VkkmJT8uaWZNKAAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 12 Jun 2024 05:12:31 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Mike Snitzer" <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Trond Myklebust" <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [RFC PATCH v2 09/15] NFS: Enable localio for non-pNFS I/O
In-reply-to: <20240612030752.31754-10-snitzer@kernel.org>
References: <20240612030752.31754-1-snitzer@kernel.org>,
 <20240612030752.31754-10-snitzer@kernel.org>
Date: Wed, 12 Jun 2024 15:12:28 +1000
Message-id: <171816914830.14261.13610752851419538459@noble.neil.brown.name>
X-Rspamd-Queue-Id: 93EE933EC4
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Wed, 12 Jun 2024, Mike Snitzer wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> Try a local open of the file we're writing to, and if it succeeds, then
> do local I/O.
>=20
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfs/pagelist.c | 19 ++++++++++---------
>  fs/nfs/write.c    |  7 ++++++-
>  2 files changed, 16 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
> index b08420b8e664..3ee78da5ebc4 100644
> --- a/fs/nfs/pagelist.c
> +++ b/fs/nfs/pagelist.c
> @@ -1063,6 +1063,7 @@ EXPORT_SYMBOL_GPL(nfs_generic_pgio);
>  static int nfs_generic_pg_pgios(struct nfs_pageio_descriptor *desc)
>  {
>  	struct nfs_pgio_header *hdr;
> +	struct file *filp;
>  	int ret;
>  	unsigned short task_flags =3D 0;
> =20
> @@ -1074,18 +1075,18 @@ static int nfs_generic_pg_pgios(struct nfs_pageio_d=
escriptor *desc)
>  	nfs_pgheader_init(desc, hdr, nfs_pgio_header_free);
>  	ret =3D nfs_generic_pgio(desc, hdr);
>  	if (ret =3D=3D 0) {
> +		struct nfs_client *clp =3D NFS_SERVER(hdr->inode)->nfs_client;
> +
> +		filp =3D nfs_local_file_open(clp, hdr->cred, hdr->args.fh,
> +					   hdr->args.context);
> +
>  		if (NFS_SERVER(hdr->inode)->nfs_client->cl_minorversion)
>  			task_flags =3D RPC_TASK_MOVEABLE;
> -		ret =3D nfs_initiate_pgio(desc,
> -					NFS_SERVER(hdr->inode)->nfs_client,
> -					NFS_CLIENT(hdr->inode),
> -					hdr,
> -					hdr->cred,
> -					NFS_PROTO(hdr->inode),
> -					desc->pg_rpc_callops,
> -					desc->pg_ioflags,
> +		ret =3D nfs_initiate_pgio(desc, clp, NFS_CLIENT(hdr->inode),
> +					hdr, hdr->cred, NFS_PROTO(hdr->inode),
> +					desc->pg_rpc_callops, desc->pg_ioflags,
>  					RPC_TASK_CRED_NOREF | task_flags,
> -					NULL);
> +					filp);

Is this rearrangement really an improvement?  I guess it is personal
taste question, but in this case it makes the patch a little harder to
read.

At first glance it looks like filp doesn't get closed, but I guess it is
getting stored in 'desc' and gets closed when 'desc' is freed.

NeilBrown

