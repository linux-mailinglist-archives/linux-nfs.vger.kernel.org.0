Return-Path: <linux-nfs+bounces-7836-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A979C35C9
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 02:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD5D8B20920
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 01:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0792E9479;
	Mon, 11 Nov 2024 01:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="swgjgwVG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="amPkC0vP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="swgjgwVG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="amPkC0vP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06384C66
	for <linux-nfs@vger.kernel.org>; Mon, 11 Nov 2024 01:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731286879; cv=none; b=ucziH33mWnS+aDIOyxtG6F7JV/S080LVgpGGcRiT1hmxe0R0mErBDbIOMJXM8bsw2mUS6LhlQ70blmOXOUI7t8gMc5EQ6qu8Pg2riAeWukyZGhREJm53cAAYDovHKMElIsWCyy6Y67aXm0MUsrIcsNbax6M+QPCxnP2sERw/kC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731286879; c=relaxed/simple;
	bh=kNrcSMMP1IhRHNwwr9z87wpGGVg9q/lajfzluoE/c/A=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=GdP5nqg1W/+UkV/qfHG4Ei2HE0uR1yc9T37f163c1jq7EhCTtWfoezN8pTkdH2GA/DA1t7DJy6kwfDbgfqUsFJtLAN0gpjd25Bib0Qay55OnXWdrWVkWkYK7vrSFdu6mcvn6KDm/E4ORF+nYu20bqZWsUt/nKYmR2DE8jTneLNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=swgjgwVG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=amPkC0vP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=swgjgwVG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=amPkC0vP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2D4201F38E;
	Mon, 11 Nov 2024 01:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731286876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bwR0ehIXNHqM41YJ34TtgFY5rSBk1ZXOHtvK6zRX6+U=;
	b=swgjgwVGmy/hZm8oVVUwSCZe6YruReFEZmm7etb13n+TmmZnZAwjRZLIyfKSC31sdZ3z6Z
	Siww7EYrw7uUzak8LTaugrd4YsBFZbozyi6vUqgVDavmSyjLZU/kXu+P0pe4t5X6oaPsFp
	ZozgYFZDcNTeV9+o3o/n+YcZC9s3sZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731286876;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bwR0ehIXNHqM41YJ34TtgFY5rSBk1ZXOHtvK6zRX6+U=;
	b=amPkC0vPXl9RDvdWnDT+M9mP7a+IJ1lFjcElNXOlZLM4IECfmSeTa3TvXAKTw0AwH42lHd
	qNDOCuFEflKVRBAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=swgjgwVG;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=amPkC0vP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731286876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bwR0ehIXNHqM41YJ34TtgFY5rSBk1ZXOHtvK6zRX6+U=;
	b=swgjgwVGmy/hZm8oVVUwSCZe6YruReFEZmm7etb13n+TmmZnZAwjRZLIyfKSC31sdZ3z6Z
	Siww7EYrw7uUzak8LTaugrd4YsBFZbozyi6vUqgVDavmSyjLZU/kXu+P0pe4t5X6oaPsFp
	ZozgYFZDcNTeV9+o3o/n+YcZC9s3sZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731286876;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bwR0ehIXNHqM41YJ34TtgFY5rSBk1ZXOHtvK6zRX6+U=;
	b=amPkC0vPXl9RDvdWnDT+M9mP7a+IJ1lFjcElNXOlZLM4IECfmSeTa3TvXAKTw0AwH42lHd
	qNDOCuFEflKVRBAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 25193137FB;
	Mon, 11 Nov 2024 01:01:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id x5OXM1lXMWdDdQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 11 Nov 2024 01:01:13 +0000
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
Subject: Re: [for-6.13 PATCH 02/19] nfs_common: must not hold RCU while
 calling nfsd_file_put_local
In-reply-to: <20241108234002.16392-3-snitzer@kernel.org>
References: <20241108234002.16392-1-snitzer@kernel.org>,
 <20241108234002.16392-3-snitzer@kernel.org>
Date: Mon, 11 Nov 2024 12:01:07 +1100
Message-id: <173128686712.1734440.8865018900138806859@noble.neil.brown.name>
X-Rspamd-Queue-Id: 2D4201F38E
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,noble.neil.brown.name:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Sat, 09 Nov 2024, Mike Snitzer wrote:
> Move holding the RCU from nfs_to_nfsd_file_put_local to
> nfs_to_nfsd_net_put.  It is the call to nfs_to->nfsd_serv_put that
> requires the RCU anyway (the puts for nfsd_file and netns were
> combined to avoid an extra indirect reference but that
> micro-optimization isn't possible now).
>=20
> This fixes xfstests generic/013 and it triggering:
>=20
> "Voluntary context switch within RCU read-side critical section!"

I'm surprised it got that far.  For me, the might_sleep() at the top of
nfsd_file_put() always warns that there is a problem here.

The fix is good though.

Reviewed-by: NeilBrown <neilb@suse.de>

NeilBrown


>=20
> [  143.545738] Call Trace:
> [  143.546206]  <TASK>
> [  143.546625]  ? show_regs+0x6d/0x80
> [  143.547267]  ? __warn+0x91/0x140
> [  143.547951]  ? rcu_note_context_switch+0x496/0x5d0
> [  143.548856]  ? report_bug+0x193/0x1a0
> [  143.549557]  ? handle_bug+0x63/0xa0
> [  143.550214]  ? exc_invalid_op+0x1d/0x80
> [  143.550938]  ? asm_exc_invalid_op+0x1f/0x30
> [  143.551736]  ? rcu_note_context_switch+0x496/0x5d0
> [  143.552634]  ? wakeup_preempt+0x62/0x70
> [  143.553358]  __schedule+0xaa/0x1380
> [  143.554025]  ? _raw_spin_unlock_irqrestore+0x12/0x40
> [  143.554958]  ? try_to_wake_up+0x1fe/0x6b0
> [  143.555715]  ? wake_up_process+0x19/0x20
> [  143.556452]  schedule+0x2e/0x120
> [  143.557066]  schedule_preempt_disabled+0x19/0x30
> [  143.557933]  rwsem_down_read_slowpath+0x24d/0x4a0
> [  143.558818]  ? xfs_efi_item_format+0x50/0xc0 [xfs]
> [  143.559894]  down_read+0x4e/0xb0
> [  143.560519]  xlog_cil_commit+0x1b2/0xbc0 [xfs]
> [  143.561460]  ? _raw_spin_unlock+0x12/0x30
> [  143.562212]  ? xfs_inode_item_precommit+0xc7/0x220 [xfs]
> [  143.563309]  ? xfs_trans_run_precommits+0x69/0xd0 [xfs]
> [  143.564394]  __xfs_trans_commit+0xb5/0x330 [xfs]
> [  143.565367]  xfs_trans_roll+0x48/0xc0 [xfs]
> [  143.566262]  xfs_defer_trans_roll+0x57/0x100 [xfs]
> [  143.567278]  xfs_defer_finish_noroll+0x27a/0x490 [xfs]
> [  143.568342]  xfs_defer_finish+0x1a/0x80 [xfs]
> [  143.569267]  xfs_bunmapi_range+0x4d/0xb0 [xfs]
> [  143.570208]  xfs_itruncate_extents_flags+0x13d/0x230 [xfs]
> [  143.571353]  xfs_free_eofblocks+0x12e/0x190 [xfs]
> [  143.572359]  xfs_file_release+0x12d/0x140 [xfs]
> [  143.573324]  __fput+0xe8/0x2d0
> [  143.573922]  __fput_sync+0x1d/0x30
> [  143.574574]  nfsd_filp_close+0x33/0x60 [nfsd]
> [  143.575430]  nfsd_file_free+0x96/0x150 [nfsd]
> [  143.576274]  nfsd_file_put+0xf7/0x1a0 [nfsd]
> [  143.577104]  nfsd_file_put_local+0x18/0x30 [nfsd]
> [  143.578070]  nfs_close_local_fh+0x101/0x110 [nfs_localio]
> [  143.579079]  __put_nfs_open_context+0xc9/0x180 [nfs]
> [  143.580031]  nfs_file_clear_open_context+0x4a/0x60 [nfs]
> [  143.581038]  nfs_file_release+0x3e/0x60 [nfs]
> [  143.581879]  __fput+0xe8/0x2d0
> [  143.582464]  __fput_sync+0x1d/0x30
> [  143.583108]  __x64_sys_close+0x41/0x80
> [  143.583823]  x64_sys_call+0x189a/0x20d0
> [  143.584552]  do_syscall_64+0x64/0x170
> [  143.585240]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  143.586185] RIP: 0033:0x7f3c5153efd7
>=20
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfs_common/nfslocalio.c |  8 +++-----
>  fs/nfsd/filecache.c        | 14 +++++++-------
>  fs/nfsd/filecache.h        |  2 +-
>  include/linux/nfslocalio.h | 18 +++++++++++++++---
>  4 files changed, 26 insertions(+), 16 deletions(-)
>=20
> diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
> index 09404d142d1a..a74ec08f6c96 100644
> --- a/fs/nfs_common/nfslocalio.c
> +++ b/fs/nfs_common/nfslocalio.c
> @@ -155,11 +155,9 @@ struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *uuid,
>  	/* We have an implied reference to net thanks to nfsd_serv_try_get */
>  	localio =3D nfs_to->nfsd_open_local_fh(net, uuid->dom, rpc_clnt,
>  					     cred, nfs_fh, fmode);
> -	if (IS_ERR(localio)) {
> -		rcu_read_lock();
> -		nfs_to->nfsd_serv_put(net);
> -		rcu_read_unlock();
> -	}
> +	if (IS_ERR(localio))
> +		nfs_to_nfsd_net_put(net);
> +
>  	return localio;
>  }
>  EXPORT_SYMBOL_GPL(nfs_open_local_fh);
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index c16671135d17..9a62b4da89bb 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -391,19 +391,19 @@ nfsd_file_put(struct nfsd_file *nf)
>  }
> =20
>  /**
> - * nfsd_file_put_local - put the reference to nfsd_file and local nfsd_serv
> - * @nf: nfsd_file of which to put the references
> + * nfsd_file_put_local - put nfsd_file reference and arm nfsd_serv_put in =
caller
> + * @nf: nfsd_file of which to put the reference
>   *
> - * First put the reference of the nfsd_file and then put the
> - * reference to the associated nn->nfsd_serv.
> + * First save the associated net to return to caller, then put
> + * the reference of the nfsd_file.
>   */
> -void
> -nfsd_file_put_local(struct nfsd_file *nf) __must_hold(rcu)
> +struct net *
> +nfsd_file_put_local(struct nfsd_file *nf)
>  {
>  	struct net *net =3D nf->nf_net;
> =20
>  	nfsd_file_put(nf);
> -	nfsd_serv_put(net);
> +	return net;
>  }
> =20
>  /**
> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> index cadf3c2689c4..d5db6b34ba30 100644
> --- a/fs/nfsd/filecache.h
> +++ b/fs/nfsd/filecache.h
> @@ -55,7 +55,7 @@ void nfsd_file_cache_shutdown(void);
>  int nfsd_file_cache_start_net(struct net *net);
>  void nfsd_file_cache_shutdown_net(struct net *net);
>  void nfsd_file_put(struct nfsd_file *nf);
> -void nfsd_file_put_local(struct nfsd_file *nf);
> +struct net *nfsd_file_put_local(struct nfsd_file *nf);
>  struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
>  struct file *nfsd_file_file(struct nfsd_file *nf);
>  void nfsd_file_close_inode_sync(struct inode *inode);
> diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
> index 3982fea79919..9202f4b24343 100644
> --- a/include/linux/nfslocalio.h
> +++ b/include/linux/nfslocalio.h
> @@ -55,7 +55,7 @@ struct nfsd_localio_operations {
>  						const struct cred *,
>  						const struct nfs_fh *,
>  						const fmode_t);
> -	void (*nfsd_file_put_local)(struct nfsd_file *);
> +	struct net *(*nfsd_file_put_local)(struct nfsd_file *);
>  	struct file *(*nfsd_file_file)(struct nfsd_file *);
>  } ____cacheline_aligned;
> =20
> @@ -66,7 +66,7 @@ struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *,
>  		   struct rpc_clnt *, const struct cred *,
>  		   const struct nfs_fh *, const fmode_t);
> =20
> -static inline void nfs_to_nfsd_file_put_local(struct nfsd_file *localio)
> +static inline void nfs_to_nfsd_net_put(struct net *net)
>  {
>  	/*
>  	 * Once reference to nfsd_serv is dropped, NFSD could be
> @@ -74,10 +74,22 @@ static inline void nfs_to_nfsd_file_put_local(struct nf=
sd_file *localio)
>  	 * by always taking RCU.
>  	 */
>  	rcu_read_lock();
> -	nfs_to->nfsd_file_put_local(localio);
> +	nfs_to->nfsd_serv_put(net);
>  	rcu_read_unlock();
>  }
> =20
> +static inline void nfs_to_nfsd_file_put_local(struct nfsd_file *localio)
> +{
> +	/*
> +	 * Must not hold RCU otherwise nfsd_file_put() can easily trigger:
> +	 * "Voluntary context switch within RCU read-side critical section!"
> +	 * by scheduling deep in underlying filesystem (e.g. XFS).
> +	 */
> +	struct net *net =3D nfs_to->nfsd_file_put_local(localio);
> +
> +	nfs_to_nfsd_net_put(net);
> +}
> +
>  #else   /* CONFIG_NFS_LOCALIO */
>  static inline void nfsd_localio_ops_init(void)
>  {
> --=20
> 2.44.0
>=20
>=20


