Return-Path: <linux-nfs+bounces-7838-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 057D69C35D5
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 02:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A9EA1F211BF
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 01:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F6D4C9D;
	Mon, 11 Nov 2024 01:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pv9G0IVu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0eqdxHuI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pv9G0IVu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0eqdxHuI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346F3A29
	for <linux-nfs@vger.kernel.org>; Mon, 11 Nov 2024 01:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731287722; cv=none; b=Rfl6jNfZJPNy3Uw6ZSd54a3pBGOYNLykvSK56fHFf6G9azLjAAKaNuCF5E/zlOa6WboAyru25bCiXMQTWLLXqHU79CJi9RGqt1RyolvF65DwLVc4mXQ4deSDmt3jd7xtUH5HsVqFSCWLeq9oZJdNmNrgxW0VA9Dus//1nIgDJak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731287722; c=relaxed/simple;
	bh=EA/dLA2WjK7wGaD8MHMkar2DkJAxcayHDwJMG6lM5Tk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=qHixsbprZhfR5yzDzqdedaMZPWEdXmx1cb/TrdYKUkQHUJhSjIhmygRWmsAJzHTGCHWiWdNuNxfjzhvs2ybUI6IaMecGDJDexNkhrZ6etFg2afuZ6o3RsxWyN0f8Pm0N9F0OKaqI3fR8Cn7kxQhNo49NefLegNNC9KKn7OjSSCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pv9G0IVu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0eqdxHuI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pv9G0IVu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0eqdxHuI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 54448219C6;
	Mon, 11 Nov 2024 01:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731287718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3H/YixkjFxES4W0gc+T2Efhmp0c82QptcIgs9pZmhPU=;
	b=pv9G0IVu6EvX/Y/U+sgVZDp9mVgpOH9n0lxOiPkU4+h36bZwe6hm2TSWDwW9cTkS6lWcOA
	Kd4bSOWMXn0G3zx7Jos/Sj0yy9h2odjTVch+J4ny6BvvA26LG84uWGWPonmUe03Lm6koC/
	KHdpS2A7dH2CUTU4p8fH541BsQQzxn8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731287718;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3H/YixkjFxES4W0gc+T2Efhmp0c82QptcIgs9pZmhPU=;
	b=0eqdxHuIauETuNjES9gFKMV/cR0eSw5R0MNIXPIHERfiwV6lSRf/Dem+wOIPHIrv/L4/BD
	gxvl3dRA4nq4qvDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731287718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3H/YixkjFxES4W0gc+T2Efhmp0c82QptcIgs9pZmhPU=;
	b=pv9G0IVu6EvX/Y/U+sgVZDp9mVgpOH9n0lxOiPkU4+h36bZwe6hm2TSWDwW9cTkS6lWcOA
	Kd4bSOWMXn0G3zx7Jos/Sj0yy9h2odjTVch+J4ny6BvvA26LG84uWGWPonmUe03Lm6koC/
	KHdpS2A7dH2CUTU4p8fH541BsQQzxn8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731287718;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3H/YixkjFxES4W0gc+T2Efhmp0c82QptcIgs9pZmhPU=;
	b=0eqdxHuIauETuNjES9gFKMV/cR0eSw5R0MNIXPIHERfiwV6lSRf/Dem+wOIPHIrv/L4/BD
	gxvl3dRA4nq4qvDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C424137FB;
	Mon, 11 Nov 2024 01:15:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id R3aPAaRaMWeyeAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 11 Nov 2024 01:15:16 +0000
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
Subject: Re: [for-6.13 PATCH 04/19] nfs/localio: eliminate unnecessary kref in
 nfs_local_fsync_ctx
In-reply-to: <20241108234002.16392-5-snitzer@kernel.org>
References: <20241108234002.16392-1-snitzer@kernel.org>,
 <20241108234002.16392-5-snitzer@kernel.org>
Date: Mon, 11 Nov 2024 12:15:13 +1100
Message-id: <173128771343.1734440.12075190560950327666@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Sat, 09 Nov 2024, Mike Snitzer wrote:
> nfs_local_commit() doesn't need async cleanup of nfs_local_fsync_ctx,
> so there is no need to use a kref.
>=20
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>

Reviewed-by: NeilBrown <neilb@suse.de>

thanks,
NeilBrown

> ---
>  fs/nfs/localio.c | 20 +++-----------------
>  1 file changed, 3 insertions(+), 17 deletions(-)
>=20
> diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> index 4b24933093b6..a7eb83a604d0 100644
> --- a/fs/nfs/localio.c
> +++ b/fs/nfs/localio.c
> @@ -42,7 +42,6 @@ struct nfs_local_fsync_ctx {
>  	struct nfsd_file	*localio;
>  	struct nfs_commit_data	*data;
>  	struct work_struct	work;
> -	struct kref		kref;
>  	struct completion	*done;
>  };
>  static void nfs_local_fsync_work(struct work_struct *work);
> @@ -689,30 +688,17 @@ nfs_local_fsync_ctx_alloc(struct nfs_commit_data *dat=
a,
>  		ctx->localio =3D localio;
>  		ctx->data =3D data;
>  		INIT_WORK(&ctx->work, nfs_local_fsync_work);
> -		kref_init(&ctx->kref);
>  		ctx->done =3D NULL;
>  	}
>  	return ctx;
>  }
> =20
> -static void
> -nfs_local_fsync_ctx_kref_free(struct kref *kref)
> -{
> -	kfree(container_of(kref, struct nfs_local_fsync_ctx, kref));
> -}
> -
> -static void
> -nfs_local_fsync_ctx_put(struct nfs_local_fsync_ctx *ctx)
> -{
> -	kref_put(&ctx->kref, nfs_local_fsync_ctx_kref_free);
> -}
> -
>  static void
>  nfs_local_fsync_ctx_free(struct nfs_local_fsync_ctx *ctx)
>  {
>  	nfs_local_release_commit_data(ctx->localio, ctx->data,
>  				      ctx->data->task.tk_ops);
> -	nfs_local_fsync_ctx_put(ctx);
> +	kfree(ctx);
>  }
> =20
>  static void
> @@ -745,7 +731,7 @@ int nfs_local_commit(struct nfsd_file *localio,
>  	}
> =20
>  	nfs_local_init_commit(data, call_ops);
> -	kref_get(&ctx->kref);
> +
>  	if (how & FLUSH_SYNC) {
>  		DECLARE_COMPLETION_ONSTACK(done);
>  		ctx->done =3D &done;
> @@ -753,6 +739,6 @@ int nfs_local_commit(struct nfsd_file *localio,
>  		wait_for_completion(&done);
>  	} else
>  		queue_work(nfsiod_workqueue, &ctx->work);
> -	nfs_local_fsync_ctx_put(ctx);
> +
>  	return 0;
>  }
> --=20
> 2.44.0
>=20
>=20


