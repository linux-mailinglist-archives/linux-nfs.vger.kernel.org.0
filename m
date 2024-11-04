Return-Path: <linux-nfs+bounces-7638-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 490349BAC41
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Nov 2024 06:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3D7B281A5B
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Nov 2024 05:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E1E17D341;
	Mon,  4 Nov 2024 05:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wGhnZJsd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ajz2oum6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Y+5XAJCn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VEGr6nr6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3108E14E2FD
	for <linux-nfs@vger.kernel.org>; Mon,  4 Nov 2024 05:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730699571; cv=none; b=FjeBWKwBzA7RJQ/IQXEVV2Uzuw2hLURx2KHzdu2hNpLTxNWYNbxXYTyxE7zglu6JnCzWjSPW4Fh9WKmGbv2vGkH9LQ0YTuVkzq6XsoDQeUO4a19wh0pDCOyb1WEHQd8Xp7ceX0Z+cNvbKs2XCxHsDt0bPsn6Yh32usNxdiO9rTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730699571; c=relaxed/simple;
	bh=UUWRD+6FZ7e/LV2YbViD887XzmR65bx+kbOM76fezlY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=K/k0yjpVJB7ORIAlM8gQe1SNIRDTgVz8F2vlh7e2XMEMXVZ324hY/7C9hXcSjk2SW26SVe/i1Zt51dc3m3MgirG53ygRvR41Infu0BLVP+86NluGxOYzssxnVWs2mvDoRazYD+pVVD7AQpG/GsaOBujQOXRfna24F17vTwlDaY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wGhnZJsd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ajz2oum6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Y+5XAJCn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VEGr6nr6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 01C4221F4C;
	Mon,  4 Nov 2024 05:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730699568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hfYhDqSBjSMTzmy6tz0ZfG8qwCesOVfZ/H6OAk0oW+w=;
	b=wGhnZJsd9vWDaLEXSTmGqSSdBGiICENiqlKLqEBPVTTPT+oGbyU4Ar/Nerw1wcCxtV/osm
	m6Qtaz3gUAt7ywOl9nbgkAeOPpdJBCUxCEfiX0MfGdhKwnbDk6lZqd7IsBkt+7Q5p2dUrA
	MfV0uQi1qvMr3viQCEVLWaHmZUPfKrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730699568;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hfYhDqSBjSMTzmy6tz0ZfG8qwCesOVfZ/H6OAk0oW+w=;
	b=Ajz2oum6NJIW9JB20lB4CN2BO5lpeVGbOdUmU6E5wg/7iqfpOlx3MmVWGSor8BsGHiJ8tP
	xkvREs9vkQw2BNAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Y+5XAJCn;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VEGr6nr6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730699567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hfYhDqSBjSMTzmy6tz0ZfG8qwCesOVfZ/H6OAk0oW+w=;
	b=Y+5XAJCn4yVH4lccp/MKh33Mo5J4m4r46ynNY1m+nERd+Rwa0swGYOndaZgKtiMXQ3sYWs
	K+troMPJDBM6XU9VBNTppPewkkxK6Jj9nh6wKjP9TnhbRI3K/FEHu8bllPgNMsOX9UrumF
	EQ+IqAxNjL1xt1C1F3ak5jHbc/bvApE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730699567;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hfYhDqSBjSMTzmy6tz0ZfG8qwCesOVfZ/H6OAk0oW+w=;
	b=VEGr6nr6Wap5PYzRhIQ2iZr3JGWjQChq3k4r96R7SnHSDVwZJce7tA7KoAJY8dW6vo/4qS
	umc1HR4ZADpQ5nBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 774EF136D9;
	Mon,  4 Nov 2024 05:52:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id caVnCy1hKGdoXgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 04 Nov 2024 05:52:45 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Eryu Guan" <eguan@linux.alibaba.com>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFSv3: only use NFS timeout for MOUNT when protocols are
 compatible
In-reply-to: <172800404387.1692160.2013457390996721241@noble.neil.brown.name>
References: <172800404387.1692160.2013457390996721241@noble.neil.brown.name>
Date: Mon, 04 Nov 2024 16:52:34 +1100
Message-id: <173069955424.81717.4793602480386734333@noble.neil.brown.name>
X-Rspamd-Queue-Id: 01C4221F4C
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Fri, 04 Oct 2024, NeilBrown wrote:
> If a timeout is specified in the mount options, it currently applies to
> both the NFS protocol and (with v3) the MOUNT protocol.  This is
> sensible when they both use the same underlying protocol, or those
> protocols are compatible w.r.t timeouts as RDMA and TCP are.
>=20
> However if, for example, NFS is using TCP and MOUNT is using UDP then
> using the same timeout doesn't make much sense.
>=20
> If you
>    mount -o vers=3D3,proto=3Dtcp,mountproto=3Dudp,timeo=3D600,retrans=3D5 \
>       server:/path /mountpoint
>=20
> then the timeo=3D600 which was intended for the NFS/TCP request will
> apply to the MOUNT/UDP requests with the result that there will only be
> one request sent (because UDP has a maximum timeout of 60 seconds).
> This is not what a reasonable person might expect.
>=20
> This patch disables the sharing of timeout information in cases where
> the underlying protocols are not compatible.
>=20
> Fixes: c9301cb35b59 ("nfs: hornor timeo and retrans option when mounting NF=
Sv3")
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfs/super.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> index 9723b6c53397..ae5c5e39afa0 100644
> --- a/fs/nfs/super.c
> +++ b/fs/nfs/super.c
> @@ -885,7 +885,15 @@ static int nfs_request_mount(struct fs_context *fc,
>  	 * Now ask the mount server to map our export path
>  	 * to a file handle.
>  	 */
> -	status =3D nfs_mount(&request, ctx->timeo, ctx->retrans);
> +	if ((request.protocol =3D=3D XPRT_TRANSPORT_UDP) =3D=3D
> +	    !(ctx->flags & NFS_MOUNT_TCP))
> +		/*
> +		 * NFS protocol and mount protocol are both UDP or neither UDP
> +		 * so timeouts are compatible.  Use NFS timeouts for MOUNT
> +		 */
> +		status =3D nfs_mount(&request, ctx->timeo, ctx->retrans);
> +	else
> +		status =3D nfs_mount(&request, NFS_UNSPEC_TIMEO, NFS_UNSPEC_RETRANS);
>  	if (status !=3D 0) {
>  		dfprintk(MOUNT, "NFS: unable to mount server %s, error %d\n",
>  				request.hostname, status);
> --=20
> 2.46.0
>=20
>=20
>=20

Anna, Trond: have you had a chance to look at this yet?

Thanks,
NeilBrown

