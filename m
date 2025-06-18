Return-Path: <linux-nfs+bounces-12566-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A32ADF808
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jun 2025 22:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D82A43AD57F
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jun 2025 20:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961F2218845;
	Wed, 18 Jun 2025 20:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zXbkfa5H";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ug69qLpX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zXbkfa5H";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ug69qLpX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E8B1B78F3
	for <linux-nfs@vger.kernel.org>; Wed, 18 Jun 2025 20:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750279567; cv=none; b=oUzmZn/sUkKJe/NavFJcZZ4in09aZzU2OjHplJpoBgVsl4Y2tpkJbFx7WPd15xQgothb+d3o7QI6NL5nykQqeXoEKvxG7U2Nmh0rm6bRciYxJn0+uHEHwSf4+Yezz5Z4JVi21CAjp5tLoH1gRDzH/JQi4OcPsB/DJpaM0IhcaMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750279567; c=relaxed/simple;
	bh=upTWfgUNh/R3QWdYJ6KPryr73XbFNHV0Oq3Ueun/XIo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=fLUQSavsFSJcct+II0Ea1aJBY7QGpafbPOacfSd9XtVs0P7AabxJwB0ETsHlqIyL/pK+BG0gdeL9MaClybfzq2atLaezTUQndiLH1fWUU8tjTlwspy6KLHtlk6WkZzoJT4gIxlXVefnFRY3daMRHSJFp9EQ5cBFz33qPfOupyxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zXbkfa5H; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ug69qLpX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zXbkfa5H; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ug69qLpX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 37EA41F7CC;
	Wed, 18 Jun 2025 20:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750279563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ga2nNIH1cudOUE4s4PGh5DlXNtn3xZ/TuzmWBOVdTyk=;
	b=zXbkfa5HQR/cqr8ZHORclm4Vp07kI54HVfzdPfQSd0zZMugaVwHoQpVfcq8LqqQyu2MYwz
	BOLzkHNRr+YwTvPxJJVxghSLlZJDw7Dc3tde1tIfrbjHIPI40aw4MkyoC5WgR4e9WOpl+p
	aMPQey6+wSZMoFH104J0vabnM0fod4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750279563;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ga2nNIH1cudOUE4s4PGh5DlXNtn3xZ/TuzmWBOVdTyk=;
	b=ug69qLpXMaSDJ29HHmKiM2vZ9ZhK44Ya8QKX2nX9KSVQhF2vwd1PZ+RtACl0V2L/nHBg29
	xzGx7ipoNM6EnOBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750279563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ga2nNIH1cudOUE4s4PGh5DlXNtn3xZ/TuzmWBOVdTyk=;
	b=zXbkfa5HQR/cqr8ZHORclm4Vp07kI54HVfzdPfQSd0zZMugaVwHoQpVfcq8LqqQyu2MYwz
	BOLzkHNRr+YwTvPxJJVxghSLlZJDw7Dc3tde1tIfrbjHIPI40aw4MkyoC5WgR4e9WOpl+p
	aMPQey6+wSZMoFH104J0vabnM0fod4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750279563;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ga2nNIH1cudOUE4s4PGh5DlXNtn3xZ/TuzmWBOVdTyk=;
	b=ug69qLpXMaSDJ29HHmKiM2vZ9ZhK44Ya8QKX2nX9KSVQhF2vwd1PZ+RtACl0V2L/nHBg29
	xzGx7ipoNM6EnOBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ABEBD13721;
	Wed, 18 Jun 2025 20:45:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id umdPFoYlU2hCcAAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 18 Jun 2025 20:45:58 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Li Lingfeng" <lilingfeng3@huawei.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, okorniev@redhat.com,
 Dai.Ngo@oracle.com, tom@talpey.com, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com, houtao1@huawei.com,
 yi.zhang@huawei.com, yangerkun@huawei.com, lilingfeng@huaweicloud.com,
 lilingfeng3@huawei.com
Subject: Re: [PATCH v2] nfsd: Invoke tracking callbacks only after
 initialization is complete
In-reply-to: <20250612035506.3651985-1-lilingfeng3@huawei.com>
References: <20250612035506.3651985-1-lilingfeng3@huawei.com>
Date: Thu, 19 Jun 2025 06:45:46 +1000
Message-id: <175027954652.608730.4269159020202114034@noble.neil.brown.name>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.30

On Thu, 12 Jun 2025, Li Lingfeng wrote:
> Checking whether tracking callbacks can be called based on whether
> nn->client_tracking_ops is NULL may lead to callbacks being invoked
> before tracking initialization completes, causing resource access
> violations (UAF, NULL pointer dereference). Examples:
>=20
> 1) nfsd4_client_tracking_init
>    // set nn->client_tracking_ops
>    nfsd4_cld_tracking_init
>     nfs4_cld_state_init
>      nn->reclaim_str_hashtbl =3D kmalloc_array
>     ... // error path, goto err
>     nfs4_cld_state_shutdown
>      kfree(nn->reclaim_str_hashtbl)
>                                       write_v4_end_grace

I suspect the problem here is that write_v4_end_grace() is one of the
few write_op functions which doesn't take nfsd_mutex.  It should hold
that lock while testing ->nfsd_serv and calling nfsd4_end_grace()

write_filehandle(), write_unlock_ip(), and write_unlock_fs() also don't
take that lock.  They don't even check if nfsd_serv is NULL.  I suspect
they all should.

NeilBrown


>                                        nfsd4_end_grace
>                                         nfsd4_record_grace_done
>                                          nfsd4_cld_grace_done
>                                           nfs4_release_reclaim
>                                            nn->reclaim_str_hashtbl[i]
>                                            // UAF
>    // clear nn->client_tracking_ops
>=20
> 2) nfsd4_client_tracking_init
>    // set nn->client_tracking_ops
>    nfsd4_cld_tracking_init
>                                       write_v4_end_grace
>                                        nfsd4_end_grace
>                                         nfsd4_record_grace_done
>                                          nfsd4_cld_grace_done
>                                           alloc_cld_upcall
>                                            cn =3D nn->cld_net
>                                            spin_lock // cn->cn_lock
>                                            // NULL deref
>    // error path, skip init pipe
>    __nfsd4_init_cld_pipe
>     cn =3D kzalloc
>     nn->cld_net =3D cn
>    // clear nn->client_tracking_ops
>=20
> After nfsd mounts, users can trigger grace_done callbacks via
> /proc/fs/nfsd/v4_end_grace. If resources are uninitialized or freed
> in error paths, this causes access violations.
>=20
> Resolve the issue by leveraging nfsd_mutex to prevent concurrency.
>=20
> Fixes: 52e19c09a183 ("nfsd: make reclaim_str_hashtbl allocated per net")
> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> ---
>   Changes in v2:
>     Use nfsd_mutex instead of adding a new flag to prevent concurrency.
>  fs/nfsd/nfs4recover.c | 8 ++++++++
>  fs/nfsd/nfs4state.c   | 4 ++++
>  fs/nfsd/nfsctl.c      | 2 ++
>  3 files changed, 14 insertions(+)
>=20
> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> index 82785db730d9..8ac089f8134c 100644
> --- a/fs/nfsd/nfs4recover.c
> +++ b/fs/nfsd/nfs4recover.c
> @@ -162,7 +162,9 @@ legacy_recdir_name_error(struct nfs4_client *clp, int e=
rror)
>  	if (error =3D=3D -ENOENT) {
>  		printk(KERN_ERR "NFSD: disabling legacy clientid tracking. "
>  			"Reboot recovery will not function correctly!\n");
> +		mutex_lock(&nfsd_mutex);
>  		nfsd4_client_tracking_exit(clp->net);
> +		mutex_unlock(&nfsd_mutex);
>  	}
>  }
> =20
> @@ -2083,8 +2085,10 @@ nfsd4_client_record_create(struct nfs4_client *clp)
>  {
>  	struct nfsd_net *nn =3D net_generic(clp->net, nfsd_net_id);
> =20
> +	mutex_lock(&nfsd_mutex);
>  	if (nn->client_tracking_ops)
>  		nn->client_tracking_ops->create(clp);
> +	mutex_unlock(&nfsd_mutex);
>  }
> =20
>  void
> @@ -2092,8 +2096,10 @@ nfsd4_client_record_remove(struct nfs4_client *clp)
>  {
>  	struct nfsd_net *nn =3D net_generic(clp->net, nfsd_net_id);
> =20
> +	mutex_lock(&nfsd_mutex);
>  	if (nn->client_tracking_ops)
>  		nn->client_tracking_ops->remove(clp);
> +	mutex_unlock(&nfsd_mutex);
>  }
> =20
>  int
> @@ -2101,8 +2107,10 @@ nfsd4_client_record_check(struct nfs4_client *clp)
>  {
>  	struct nfsd_net *nn =3D net_generic(clp->net, nfsd_net_id);
> =20
> +	mutex_lock(&nfsd_mutex);
>  	if (nn->client_tracking_ops)
>  		return nn->client_tracking_ops->check(clp);
> +	mutex_unlock(&nfsd_mutex);
> =20
>  	return -EOPNOTSUPP;
>  }
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index d5694987f86f..2794fdc8b678 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2529,7 +2529,9 @@ static void inc_reclaim_complete(struct nfs4_client *=
clp)
>  			nn->reclaim_str_hashtbl_size) {
>  		printk(KERN_INFO "NFSD: all clients done reclaiming, ending NFSv4 grace =
period (net %x)\n",
>  				clp->net->ns.inum);
> +		mutex_lock(&nfsd_mutex);
>  		nfsd4_end_grace(nn);
> +		mutex_unlock(&nfsd_mutex);
>  	}
>  }
> =20
> @@ -6773,7 +6775,9 @@ nfs4_laundromat(struct nfsd_net *nn)
>  		lt.new_timeo =3D 0;
>  		goto out;
>  	}
> +	mutex_lock(&nfsd_mutex);
>  	nfsd4_end_grace(nn);
> +	mutex_unlock(&nfsd_mutex);
> =20
>  	spin_lock(&nn->s2s_cp_lock);
>  	idr_for_each_entry(&nn->s2s_cp_stateids, cps_t, i) {
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 3f3e9f6c4250..649850b4bb60 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1085,7 +1085,9 @@ static ssize_t write_v4_end_grace(struct file *file, =
char *buf, size_t size)
>  			if (!nn->nfsd_serv)
>  				return -EBUSY;
>  			trace_nfsd_end_grace(netns(file));
> +			mutex_lock(&nfsd_mutex);
>  			nfsd4_end_grace(nn);
> +			mutex_lock(&nfsd_mutex);
>  			break;
>  		default:
>  			return -EINVAL;
> --=20
> 2.46.1
>=20
>=20


