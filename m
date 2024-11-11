Return-Path: <linux-nfs+bounces-7840-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 091AA9C35DC
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 02:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E4D51F212D8
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 01:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785F2C8F0;
	Mon, 11 Nov 2024 01:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UYx6cxTh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="z45x1VQ7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UYx6cxTh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="z45x1VQ7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3F2AD58
	for <linux-nfs@vger.kernel.org>; Mon, 11 Nov 2024 01:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731288070; cv=none; b=upaKFRMKg8DfWYwBzGbQ9+eFg1W8LgpiR8CJeHMlgyZH1Npe/XYCBqvnnp0JfAdptxFz77X4RQ26TE1GviJRSBFEz8Eh+Mu9rWP65yPsF/EaVgG9teyODBMLGzz3TwY7MPk+h2UawphSvc6ReHcfyHsl8Ov8YlbFsUMVBvS5PTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731288070; c=relaxed/simple;
	bh=SVg430Vat3jHXMRRl7lTErNFuOFtoM7TcwIbSdZlCrI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=M1Z5clOAG8hsTg/YWr96KBDSJR09YqTQK2qOjZ8PIAq0RVKoRYbnyMKdMu4nO55TDe51IHZecavhR6WSC1GfQsNu5L9IflfP/88jguxRZyikIn3vFFAWnjCnG+SIJP7oDPF9WcOgJAkgz39X9U3U5L7jPqm+TTwNg3S7VZas3ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UYx6cxTh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=z45x1VQ7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UYx6cxTh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=z45x1VQ7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3202A219EA;
	Mon, 11 Nov 2024 01:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731288067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HHVyCeIMGHRPcj2kJZOQdIV0OXYyyzqsRAA5cFeVG/I=;
	b=UYx6cxTh8FBmoPXhpS9kDedHizJ9wyB+oQT4ZCyP7BySooahlaxGkhL0COiPuKuhEZrxTz
	sJVAWpDPKeCHg+EGufhMlUFqU7SxmjciAOMaQs+nPlA/aN6vLo3E4ezl1Z1wIzya8w/Zsu
	XLOYLhaVjVInT0Q62U/XI96pPc/52ic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731288067;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HHVyCeIMGHRPcj2kJZOQdIV0OXYyyzqsRAA5cFeVG/I=;
	b=z45x1VQ7rsHJDybyuD4M75S6mRKwlF9SCcDHS0MVZj+0XqDqdgqmAF/WZ1r8UGIxwytvg8
	yiZ/WHozbQsInxAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731288067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HHVyCeIMGHRPcj2kJZOQdIV0OXYyyzqsRAA5cFeVG/I=;
	b=UYx6cxTh8FBmoPXhpS9kDedHizJ9wyB+oQT4ZCyP7BySooahlaxGkhL0COiPuKuhEZrxTz
	sJVAWpDPKeCHg+EGufhMlUFqU7SxmjciAOMaQs+nPlA/aN6vLo3E4ezl1Z1wIzya8w/Zsu
	XLOYLhaVjVInT0Q62U/XI96pPc/52ic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731288067;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HHVyCeIMGHRPcj2kJZOQdIV0OXYyyzqsRAA5cFeVG/I=;
	b=z45x1VQ7rsHJDybyuD4M75S6mRKwlF9SCcDHS0MVZj+0XqDqdgqmAF/WZ1r8UGIxwytvg8
	yiZ/WHozbQsInxAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 14154137FB;
	Mon, 11 Nov 2024 01:21:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9pEALwBcMWcYegAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 11 Nov 2024 01:21:04 +0000
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
Cc: linux-nfs@vger.kernel.org, "Anna Schumaker" <anna@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [for-6.13 PATCH 06/19] nfs/localio: eliminate need for
 nfs_local_fsync_work forward declaration
In-reply-to: <20241108234002.16392-7-snitzer@kernel.org>
References: <20241108234002.16392-1-snitzer@kernel.org>,
 <20241108234002.16392-7-snitzer@kernel.org>
Date: Mon, 11 Nov 2024 12:21:02 +1100
Message-id: <173128806214.1734440.5510419942732122862@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, 09 Nov 2024, Mike Snitzer wrote:
> Move nfs_local_fsync_ctx_alloc() after nfs_local_fsync_work().
>=20
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>

Nice.
Reviewed-by: NeilBrown <neilb@suse.de>

Thanks,
NeilBrown


> ---
>  fs/nfs/localio.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
>=20
> diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> index a77ac7e8a05c..4b8618cf114c 100644
> --- a/fs/nfs/localio.c
> +++ b/fs/nfs/localio.c
> @@ -44,7 +44,6 @@ struct nfs_local_fsync_ctx {
>  	struct work_struct	work;
>  	struct completion	*done;
>  };
> -static void nfs_local_fsync_work(struct work_struct *work);
> =20
>  static bool localio_enabled __read_mostly =3D true;
>  module_param(localio_enabled, bool, 0644);
> @@ -684,21 +683,6 @@ nfs_local_release_commit_data(struct nfsd_file *locali=
o,
>  	call_ops->rpc_release(data);
>  }
> =20
> -static struct nfs_local_fsync_ctx *
> -nfs_local_fsync_ctx_alloc(struct nfs_commit_data *data,
> -			  struct nfsd_file *localio, gfp_t flags)
> -{
> -	struct nfs_local_fsync_ctx *ctx =3D kmalloc(sizeof(*ctx), flags);
> -
> -	if (ctx !=3D NULL) {
> -		ctx->localio =3D localio;
> -		ctx->data =3D data;
> -		INIT_WORK(&ctx->work, nfs_local_fsync_work);
> -		ctx->done =3D NULL;
> -	}
> -	return ctx;
> -}
> -
>  static void
>  nfs_local_fsync_ctx_free(struct nfs_local_fsync_ctx *ctx)
>  {
> @@ -723,6 +707,21 @@ nfs_local_fsync_work(struct work_struct *work)
>  	nfs_local_fsync_ctx_free(ctx);
>  }
> =20
> +static struct nfs_local_fsync_ctx *
> +nfs_local_fsync_ctx_alloc(struct nfs_commit_data *data,
> +			  struct nfsd_file *localio, gfp_t flags)
> +{
> +	struct nfs_local_fsync_ctx *ctx =3D kmalloc(sizeof(*ctx), flags);
> +
> +	if (ctx !=3D NULL) {
> +		ctx->localio =3D localio;
> +		ctx->data =3D data;
> +		INIT_WORK(&ctx->work, nfs_local_fsync_work);
> +		ctx->done =3D NULL;
> +	}
> +	return ctx;
> +}
> +
>  int nfs_local_commit(struct nfsd_file *localio,
>  		     struct nfs_commit_data *data,
>  		     const struct rpc_call_ops *call_ops, int how)
> --=20
> 2.44.0
>=20
>=20


