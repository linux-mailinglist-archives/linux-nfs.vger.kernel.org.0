Return-Path: <linux-nfs+bounces-19066-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFhoGs+CmGlMJQMAu9opvQ
	(envelope-from <linux-nfs+bounces-19066-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Feb 2026 16:50:39 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD4C1690D3
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Feb 2026 16:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEE233032F66
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Feb 2026 15:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E2E2D9EE4;
	Fri, 20 Feb 2026 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNQUnbth"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FEF2C11D0
	for <linux-nfs@vger.kernel.org>; Fri, 20 Feb 2026 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771602612; cv=none; b=edB6ORg6jQ21s8t1W0cp3vGp4LNmVysANY7qOcSF1uJnzAJuL6tej72y8YZVO8ZbiCJCTr2PLVwDdqlT8GoMIaAw4U97sEf7pGoJL8kYlOo+vlJU3xrXor3nRF/Ksnl4s9FcQH1wH5qjQhqAsZ9aR38ErTxh/rsCfMYgTwzBfYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771602612; c=relaxed/simple;
	bh=pUGU759SqhDyNWxNbsMJpk/4NspSuxO4zi98DaYeEK4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QGgAiunuGMJY3t0tmDT4i25X/1miYbu1wuyOHjwZMPrAKNH93KXHzP8huaIZC8ZX+ul0dkczC5DqJHyMPoh2vC7Y2jN/xrI4ILCimREhvuQPZ/m2sYX1nLRF0+BWDVgnY9plS3M+lID0UwoYd7CojTwyGpIKLody+h2xkaF9P9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNQUnbth; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11005C116C6;
	Fri, 20 Feb 2026 15:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771602611;
	bh=pUGU759SqhDyNWxNbsMJpk/4NspSuxO4zi98DaYeEK4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=qNQUnbthb0TLVVdSrfA7+YtcInd6/Sl+WjaQkeOPfbkcd+V8r4fa+wthf+MyPNyUB
	 wX40gPc2riOlieyZdNgFs/C0r9WvRGeEggW+UthhU3I0VFjW0PdPhFw4LBec/wU1Vh
	 wfZNxW6l0iNnbMzM7+JIAGfJOhKX1zUhMjfUYBqNu/x+1+KdkYjGagp3tpwjHoBJ7e
	 US+fOeXycHZz1bBUbAyc3qTdGDI2mjg1TN/jxlexKwZsmHFSxJuoHd9h+xg5Goh3Bz
	 ByPC+af/sTnpj29H5rjtPe+2iEWQ8Tvk+/hcw9mYGOkQX451n7aNbV1gSxAUd82nn9
	 hR4UViMOi8auw==
Message-ID: <ae5f1ee0c43eda94f86bc60b1b223c86e0f24805.camel@kernel.org>
Subject: Re: [PATCH v1 1/2] NFSD: Defer sub-object cleanup in export put
 callbacks
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <cel@kernel.org>, misanjum@linux.ibm.com, NeilBrown
	 <neilb@ownmail.net>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo
	 <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Date: Fri, 20 Feb 2026 10:50:09 -0500
In-Reply-To: <20260219215017.1769-2-cel@kernel.org>
References: <20260219215017.1769-1-cel@kernel.org>
	 <20260219215017.1769-2-cel@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19066-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,linux.ibm.com,ownmail.net,redhat.com,oracle.com,talpey.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: BAD4C1690D3
X-Rspamd-Action: no action

On Thu, 2026-02-19 at 16:50 -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> svc_export_put() calls path_put() and auth_domain_put() immediately
> when the last reference drops, before the RCU grace period. RCU
> readers in e_show() and c_show() access both ex_path (via
> seq_path/d_path) and ex_client->name (via seq_escape) without
> holding a reference. If cache_clean removes the entry and drops the
> last reference concurrently, the sub-objects are freed while still
> in use, producing a NULL pointer dereference in d_path.
>=20
> Commit 2530766492ec ("nfsd: fix UAF when access ex_uuid or
> ex_stats") moved kfree of ex_uuid and ex_stats into the
> call_rcu callback, but left path_put() and auth_domain_put() running
> before the grace period because both may sleep and call_rcu
> callbacks execute in softirq context.
>=20
> Replace call_rcu/kfree_rcu with queue_rcu_work(), which defers the
> callback until after the RCU grace period and executes it in process
> context where sleeping is permitted. This allows path_put() and
> auth_domain_put() to be moved into the deferred callback alongside
> the other resource releases. Apply the same fix to expkey_put(),
> which has the identical pattern with ek_path and ek_client.
>=20
> A dedicated workqueue scopes the shutdown drain to only NFSD
> export release work items; flushing the shared
> system_unbound_wq would stall on unrelated work from other
> subsystems. nfsd_export_shutdown() uses rcu_barrier() followed
> by flush_workqueue() to ensure all deferred release callbacks
> complete before the export caches are destroyed.
>=20
> Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
> Closes: https://lore.kernel.org/linux-nfs/dcd371d3a95815a84ba7de52cef447b=
8@linux.ibm.com/
> Fixes: c224edca7af0 ("nfsd: no need get cache ref when protected by rcu")
> Fixes: 1b10f0b603c0 ("SUNRPC: no need get cache ref when protected by rcu=
")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/export.c | 63 +++++++++++++++++++++++++++++++++++++++++-------
>  fs/nfsd/export.h |  7 ++++--
>  fs/nfsd/nfsctl.c |  8 +++++-
>  3 files changed, 66 insertions(+), 12 deletions(-)
>=20
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 04b18f0f402f..53fe66784ed2 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -36,19 +36,30 @@
>   * second map contains a reference to the entry in the first map.
>   */
> =20
> +static struct workqueue_struct *nfsd_export_wq;
> +
>  #define	EXPKEY_HASHBITS		8
>  #define	EXPKEY_HASHMAX		(1 << EXPKEY_HASHBITS)
>  #define	EXPKEY_HASHMASK		(EXPKEY_HASHMAX -1)
> =20
> -static void expkey_put(struct kref *ref)
> +static void expkey_release(struct work_struct *work)
>  {
> -	struct svc_expkey *key =3D container_of(ref, struct svc_expkey, h.ref);
> +	struct svc_expkey *key =3D container_of(to_rcu_work(work),
> +					      struct svc_expkey, ek_rwork);
> =20
>  	if (test_bit(CACHE_VALID, &key->h.flags) &&
>  	    !test_bit(CACHE_NEGATIVE, &key->h.flags))
>  		path_put(&key->ek_path);
>  	auth_domain_put(key->ek_client);
> -	kfree_rcu(key, ek_rcu);
> +	kfree(key);
> +}
> +
> +static void expkey_put(struct kref *ref)
> +{
> +	struct svc_expkey *key =3D container_of(ref, struct svc_expkey, h.ref);
> +
> +	INIT_RCU_WORK(&key->ek_rwork, expkey_release);
> +	queue_rcu_work(nfsd_export_wq, &key->ek_rwork);
>  }
> =20
>  static int expkey_upcall(struct cache_detail *cd, struct cache_head *h)
> @@ -353,11 +364,13 @@ static void export_stats_destroy(struct export_stat=
s *stats)
>  					    EXP_STATS_COUNTERS_NUM);
>  }
> =20
> -static void svc_export_release(struct rcu_head *rcu_head)
> +static void svc_export_release(struct work_struct *work)
>  {
> -	struct svc_export *exp =3D container_of(rcu_head, struct svc_export,
> -			ex_rcu);
> +	struct svc_export *exp =3D container_of(to_rcu_work(work),
> +					      struct svc_export, ex_rwork);
> =20
> +	path_put(&exp->ex_path);
> +	auth_domain_put(exp->ex_client);
>  	nfsd4_fslocs_free(&exp->ex_fslocs);
>  	export_stats_destroy(exp->ex_stats);
>  	kfree(exp->ex_stats);
> @@ -369,9 +382,8 @@ static void svc_export_put(struct kref *ref)
>  {
>  	struct svc_export *exp =3D container_of(ref, struct svc_export, h.ref);
> =20
> -	path_put(&exp->ex_path);
> -	auth_domain_put(exp->ex_client);
> -	call_rcu(&exp->ex_rcu, svc_export_release);
> +	INIT_RCU_WORK(&exp->ex_rwork, svc_export_release);
> +	queue_rcu_work(nfsd_export_wq, &exp->ex_rwork);
>  }
> =20
>  static int svc_export_upcall(struct cache_detail *cd, struct cache_head =
*h)
> @@ -1481,6 +1493,36 @@ const struct seq_operations nfs_exports_op =3D {
>  	.show	=3D e_show,
>  };
> =20
> +/**
> + * nfsd_export_wq_init - allocate the export release workqueue
> + *
> + * Called once at module load. The workqueue runs deferred svc_export an=
d
> + * svc_expkey release work scheduled by queue_rcu_work() in the cache pu=
t
> + * callbacks.
> + *
> + * Return values:
> + *   %0: workqueue allocated
> + *   %-ENOMEM: allocation failed
> + */
> +int nfsd_export_wq_init(void)
> +{
> +	nfsd_export_wq =3D alloc_workqueue("nfsd_export", WQ_UNBOUND, 0);
> +	if (!nfsd_export_wq)
> +		return -ENOMEM;
> +	return 0;
> +}
> +
> +/**
> + * nfsd_export_wq_shutdown - drain and free the export release workqueue
> + *
> + * Called once at module unload. Per-namespace teardown in
> + * nfsd_export_shutdown() has already drained all deferred work.
> + */
> +void nfsd_export_wq_shutdown(void)
> +{
> +	destroy_workqueue(nfsd_export_wq);
> +}
> +
>  /*
>   * Initialize the exports module.
>   */
> @@ -1542,6 +1584,9 @@ nfsd_export_shutdown(struct net *net)
> =20
>  	cache_unregister_net(nn->svc_expkey_cache, net);
>  	cache_unregister_net(nn->svc_export_cache, net);
> +	/* Drain deferred export and expkey release work. */
> +	rcu_barrier();
> +	flush_workqueue(nfsd_export_wq);
>  	cache_destroy_net(nn->svc_expkey_cache, net);
>  	cache_destroy_net(nn->svc_export_cache, net);
>  	svcauth_unix_purge(net);
> diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
> index d2b09cd76145..b05399374574 100644
> --- a/fs/nfsd/export.h
> +++ b/fs/nfsd/export.h
> @@ -7,6 +7,7 @@
> =20
>  #include <linux/sunrpc/cache.h>
>  #include <linux/percpu_counter.h>
> +#include <linux/workqueue.h>
>  #include <uapi/linux/nfsd/export.h>
>  #include <linux/nfs4.h>
> =20
> @@ -75,7 +76,7 @@ struct svc_export {
>  	u32			ex_layout_types;
>  	struct nfsd4_deviceid_map *ex_devid_map;
>  	struct cache_detail	*cd;
> -	struct rcu_head		ex_rcu;
> +	struct rcu_work		ex_rwork;
>  	unsigned long		ex_xprtsec_modes;
>  	struct export_stats	*ex_stats;
>  };
> @@ -92,7 +93,7 @@ struct svc_expkey {
>  	u32			ek_fsid[6];
> =20
>  	struct path		ek_path;
> -	struct rcu_head		ek_rcu;
> +	struct rcu_work		ek_rwork;
>  };
> =20
>  #define EX_ISSYNC(exp)		(!((exp)->ex_flags & NFSEXP_ASYNC))
> @@ -110,6 +111,8 @@ __be32 check_nfsd_access(struct svc_export *exp, stru=
ct svc_rqst *rqstp,
>  /*
>   * Function declarations
>   */
> +int			nfsd_export_wq_init(void);
> +void			nfsd_export_wq_shutdown(void);
>  int			nfsd_export_init(struct net *);
>  void			nfsd_export_shutdown(struct net *);
>  void			nfsd_export_flush(struct net *);
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 664a3275c511..4166f59908f4 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -2308,9 +2308,12 @@ static int __init init_nfsd(void)
>  	if (retval)
>  		goto out_free_pnfs;
>  	nfsd_lockd_init();	/* lockd->nfsd callbacks */
> +	retval =3D nfsd_export_wq_init();
> +	if (retval)
> +		goto out_free_lockd;
>  	retval =3D register_pernet_subsys(&nfsd_net_ops);
>  	if (retval < 0)
> -		goto out_free_lockd;
> +		goto out_free_export_wq;
>  	retval =3D register_cld_notifier();
>  	if (retval)
>  		goto out_free_subsys;
> @@ -2339,6 +2342,8 @@ static int __init init_nfsd(void)
>  	unregister_cld_notifier();
>  out_free_subsys:
>  	unregister_pernet_subsys(&nfsd_net_ops);
> +out_free_export_wq:
> +	nfsd_export_wq_shutdown();
>  out_free_lockd:
>  	nfsd_lockd_shutdown();
>  	nfsd_drc_slab_free();
> @@ -2359,6 +2364,7 @@ static void __exit exit_nfsd(void)
>  	nfsd4_destroy_laundry_wq();
>  	unregister_cld_notifier();
>  	unregister_pernet_subsys(&nfsd_net_ops);
> +	nfsd_export_wq_shutdown();
>  	nfsd_drc_slab_free();
>  	nfsd_lockd_shutdown();
>  	nfsd4_free_slabs();

Looks good.

Reviwed-by: Jeff Layton <jlayton@kernel.org>

