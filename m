Return-Path: <linux-nfs+bounces-22243-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dL8KOWBqIGqG3AAAu9opvQ
	(envelope-from <linux-nfs+bounces-22243-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 19:54:40 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F5D63A4F6
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 19:54:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="dpW8Xr+/";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22243-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22243-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D854301257D
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jun 2026 17:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0098637E2E6;
	Wed,  3 Jun 2026 17:51:04 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DE737D12F;
	Wed,  3 Jun 2026 17:51:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780509063; cv=none; b=vAH1R6L7wrNfRj6RdD6n1Lw+AIUbbZ+EniH5fkgjJ3RyjZxbpqp1BebiwGb2CFoLYfMhRx/Hti4imtiC+ZWvti//7HnC1dZnaX6phk1zNb2o5QOABAGq66HgUR3HKW9zhAdVFO3C3IsB1yLFSudncaF4iQkch7H29N4DhflR25Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780509063; c=relaxed/simple;
	bh=nUrqDS+L1UAWZtLkW3LsUbouh95raAX5Fwc7StERDjo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wa/K0EPRjI6M79Zw7zMP6lX/vKFJIUSNecZVOnY7gsy5cSvGd7sZb0KabrizDB9HTS1aPih9MyVg8d0cY3Ksv1X2vRQ5YFu+ZNHFP0pUt8DhFWAdyf4w0tXe/260waGTDpDDI8hu7qBgF82x7WC60R8LNtdyJJVrul1yy3vU/Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpW8Xr+/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A261F00893;
	Wed,  3 Jun 2026 17:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780509062;
	bh=yAXJjs9JysOjgfdPHvXlo0VkKuGjTlALmLC1+MuNoyA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dpW8Xr+/EyRn67yATZuT1TDpD1bDJXSeBFMXGNSS47XHGYpiijE5ZNPCLRjN+EE/d
	 ac8Yx/W+2ReaPQyY/Bsl9DpBo1iaZMdPT73YKr7+aXgiJDAym2dIs3ciwt5RSJ36cv
	 1yUKJchhIiicJEIXNVrcAE1ZwRT1pN4KlDhmVS1RxnPucafQy6LJramOzxVRVmcm7K
	 La0/00oTF2gsabcYrDbf7ZFbgJ7MXyLqLdfX8KiQuJ8jwWl9v0ZzUsJMidRPVfTqB+
	 KtVAMEPK3GkSFeO/4Xq5scFjJDH59XGqsk/xkOrPkpN7oMqP91yDAm3k+kackiqMqK
	 FCV3DCesfGWjQ==
Message-ID: <fc86e230bf1962840c9b045680600f67378f7126.camel@kernel.org>
Subject: Re: [PATCH v2 8/9] nfsd: hold net namespace reference for
 delayed-dispose nfsd_files
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <cel@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai
 Ngo <Dai.Ngo@oracle.com>,  Tom Talpey <tom@talpey.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Anna Schumaker	 <anna.schumaker@oracle.com>, Trond
 Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Mike
 Snitzer <snitzer@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Chris Mason <clm@meta.com>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, Trond Myklebust
	 <trond.myklebust@hammerspace.com>
Date: Wed, 03 Jun 2026 13:50:58 -0400
In-Reply-To: <efb19b50-6535-480d-9630-37f53a8de3cd@app.fastmail.com>
References: <20260602-nfsd-testing-v2-0-e4ea62e3cd5c@kernel.org>
	 <20260602-nfsd-testing-v2-8-e4ea62e3cd5c@kernel.org>
	 <efb19b50-6535-480d-9630-37f53a8de3cd@app.fastmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:lorenzo@kernel.org,m:anna.schumaker@oracle.com,m:trondmy@kernel.org,m:anna@kernel.org,m:snitzer@kernel.org,m:viro@zeniv.linux.org.uk,m:clm@meta.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:trond.myklebust@hammerspace.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-22243-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E2F5D63A4F6

On Wed, 2026-06-03 at 10:33 -0700, Chuck Lever wrote:
>=20
> On Tue, Jun 2, 2026, at 9:23 AM, Jeff Layton wrote:
> > Take a net-namespace reference in nfsd_file_dispose_list_delayed()
> > (get_net) and release it in nfsd_file_free() (put_net), so that
> > nf_net is always valid for files that the GC or shrinker has isolated
> > from the hash table and LRU -- which __nfsd_file_cache_purge() cannot
> > see.
> >=20
> > Without this, nf_net can dangle for in-flight files whose net namespace
> > is torn down concurrently, causing a use-after-free when
> > nfsd_file_dispose_list_delayed() calls net_generic(nf->nf_net, ...).
> >=20
> > Only files entering the delayed-dispose path need the net reference;
> > files freed synchronously (non-GC stateful opens, purge, direct put)
> > are always freed while the net namespace is still alive, so they skip
> > get_net()/put_net() entirely.  A new NFSD_FILE_NET_HELD flag tracks
> > whether a given nfsd_file holds a net reference.
> >=20
> > Because nfsd_file_free() may now call put_net(nf->nf_net), the old
> > nfsd_file_put_local() pattern of returning nf->nf_net after
> > nfsd_file_put() is unsafe -- put_net() could theoretically drop the
> > last net namespace reference, leaving the returned pointer stale.
> > Fix this by moving the nfsd_net_put() call into nfsd_file_put_local()
> > itself, before the nfsd_file_put() that may trigger nfsd_file_free().
> > The function now returns void and the caller no longer needs to handle
> > the net reference.
> >=20
> > Fixes: 43fd953fa7e2 ("nfsd: simplify the delayed disposal list code")
> > Assisted-by: Claude:claude-opus-4-6
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/nfsd/filecache.c        | 34 ++++++++++++++++++++++++++--------
> >  fs/nfsd/filecache.h        |  3 ++-
> >  fs/nfsd/localio.c          |  4 ++--
> >  include/linux/nfslocalio.h |  9 ++-------
> >  4 files changed, 32 insertions(+), 18 deletions(-)
> >=20
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index 03f01a0beced..957fe57be063 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -295,6 +295,9 @@ nfsd_file_free(struct nfsd_file *nf)
> >  	if (WARN_ON_ONCE(!list_empty(&nf->nf_lru)))
> >  		return;
> >=20
> > +	if (test_bit(NFSD_FILE_NET_HELD, &nf->nf_flags))
> > +		put_net(nf->nf_net);
> > +
> >  	call_rcu(&nf->nf_rcu, nfsd_file_slab_free);
> >  }
> >=20
> > @@ -375,24 +378,28 @@ nfsd_file_put(struct nfsd_file *nf)
> >  }
> >=20
> >  /**
> > - * nfsd_file_put_local - put nfsd_file reference and arm nfsd_net_put =
in caller
> > + * nfsd_file_put_local - put nfsd_file reference and release nfsd_net =
ref
> >   * @pnf: nfsd_file of which to put the reference
> >   *
> > - * First save the associated net to return to caller, then put
> > - * the reference of the nfsd_file.
> > + * Drops both the nfsd_file reference and the associated nfsd_net
> > + * reference.  The nfsd_net ref is released before the file ref so
> > + * that put_net() inside nfsd_file_free() cannot drop the last net
> > + * namespace reference while the caller still needs it.
> >   */
> > -struct net *
> > +void
> >  nfsd_file_put_local(struct nfsd_file __rcu **pnf)
> >  {
> >  	struct nfsd_file *nf;
> > -	struct net *net =3D NULL;
> >=20
> >  	nf =3D unrcu_pointer(xchg(pnf, NULL));
> >  	if (nf) {
> > -		net =3D nf->nf_net;
> > +		struct net *net =3D nf->nf_net;
> > +
> > +		rcu_read_lock();
> > +		nfsd_net_put(net);
> > +		rcu_read_unlock();
> >  		nfsd_file_put(nf);
> >  	}
> > -	return net;
> >  }
> >=20
> >  /**
> > @@ -433,9 +440,20 @@ nfsd_file_dispose_list_delayed(struct list_head *d=
ispose)
> >  	while (!list_empty(dispose)) {
> >  		struct nfsd_file *nf =3D list_first_entry(dispose,
> >  						struct nfsd_file, nf_gc);
> > -		struct nfsd_net *nn =3D net_generic(nf->nf_net, nfsd_net_id);
> > +		struct nfsd_net *nn;
> >  		struct svc_serv *serv;
> >=20
> > +		/*
> > +		 * Pin the net namespace so nf_net stays valid while the
> > +		 * file sits on the per-net dispose list.  Callers (the GC
> > +		 * worker, shrinker, and fsnotify callbacks) always run
> > +		 * before nfsd_net_exit(), so nf_net is still live here.
> > +		 * The matching put_net() is in nfsd_file_free().
> > +		 */
> > +		get_net(nf->nf_net);
> > +		set_bit(NFSD_FILE_NET_HELD, &nf->nf_flags);
> > +
> > +		nn =3D net_generic(nf->nf_net, nfsd_net_id);
> >  		spin_lock(&nn->fcache_dispose_lock);
> >  		list_move_tail(&nf->nf_gc, &nn->fcache_dispose_list);
> >  		spin_unlock(&nn->fcache_dispose_lock);
> > diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> > index 683b6437cacc..7ae3c0ea0a2a 100644
> > --- a/fs/nfsd/filecache.h
> > +++ b/fs/nfsd/filecache.h
> > @@ -45,6 +45,7 @@ struct nfsd_file {
> >  #define NFSD_FILE_REFERENCED	(2)
> >  #define NFSD_FILE_GC		(3)
> >  #define NFSD_FILE_RECENT	(4)
> > +#define NFSD_FILE_NET_HELD	(5)
> >  	unsigned long		nf_flags;
> >  	refcount_t		nf_ref;
> >  	unsigned char		nf_may;
> > @@ -66,7 +67,7 @@ void nfsd_file_cache_shutdown(void);
> >  int nfsd_file_cache_start_net(struct net *net);
> >  void nfsd_file_cache_shutdown_net(struct net *net);
> >  void nfsd_file_put(struct nfsd_file *nf);
> > -struct net *nfsd_file_put_local(struct nfsd_file __rcu **nf);
> > +void nfsd_file_put_local(struct nfsd_file __rcu **nf);
> >  struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
> >  struct file *nfsd_file_file(struct nfsd_file *nf);
> >  void nfsd_file_close_inode_sync(struct inode *inode);
> > diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> > index c3eb0557b3e1..e3295bae75a4 100644
> > --- a/fs/nfsd/localio.c
> > +++ b/fs/nfsd/localio.c
> > @@ -40,8 +40,8 @@
> >   * avoid all the NFS overhead with reads, writes and commits.
> >   *
> >   * On successful return, returned nfsd_file will have its nf_net membe=
r
> > - * set. Caller (NFS client) is responsible for calling nfsd_net_put an=
d
> > - * nfsd_file_put (via nfs_to_nfsd_file_put_local).
> > + * set. Caller (NFS client) is responsible for calling nfsd_file_put
> > + * (via nfs_to_nfsd_file_put_local), which also releases the nfsd_net=
=20
> > ref.
> >   */
> >  static struct nfsd_file *
> >  nfsd_open_local_fh(struct net *net, struct auth_domain *dom,
> > diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
> > index 3d91043254e6..7267a69092d1 100644
> > --- a/include/linux/nfslocalio.h
> > +++ b/include/linux/nfslocalio.h
> > @@ -62,7 +62,7 @@ struct nfsd_localio_operations {
> >  						const struct nfs_fh *,
> >  						struct nfsd_file __rcu **pnf,
> >  						const fmode_t);
> > -	struct net *(*nfsd_file_put_local)(struct nfsd_file __rcu **);
> > +	void (*nfsd_file_put_local)(struct nfsd_file __rcu **);
> >  	struct file *(*nfsd_file_file)(struct nfsd_file *);
> >  	void (*nfsd_file_dio_alignment)(struct nfsd_file *,
> >  					u32 *, u32 *, u32 *);
> > @@ -96,12 +96,7 @@ static inline void nfs_to_nfsd_file_put_local(struct=
=20
> > nfsd_file __rcu **localio)
> >  	 * must prevent nfsd shutdown from completing as nfs_close_local_fh()
> >  	 * does by blocking the nfs_uuid from being finally put.
> >  	 */
> > -	struct net *net;
> > -
> > -	net =3D nfs_to->nfsd_file_put_local(localio);
> > -
> > -	if (net)
> > -		nfs_to_nfsd_net_put(net);
> > +	nfs_to->nfsd_file_put_local(localio);
> >  }
> >=20
> >  #else   /* CONFIG_NFS_LOCALIO */
> >=20
> > --=20
> > 2.54.0
>=20
> It seems that all of the LLM reviewers have difficulty with this patch.
> This is a consolidated review of the issue from Claude and Codex:
>=20
> > The reordering in nfsd_file_put_local() -- nfsd_net_put() before
> > nfsd_file_put() -- introduces a shutdown race.
> >=20
> > The nfsd_net_ref percpu refcount is taken only by LOCALIO
> > (nfsd_open_local_fh() and nfs_open_local_fh()). The drain wait in
> > nfsd_shutdown_net() (wait_for_completion(&nn->nfsd_net_free_done))
> > is what holds off percpu_ref_exit() and nfsd_shutdown_generic() --
> > and through the latter, nfsd_file_cache_shutdown(), which runs
> > rcu_barrier() and then destroys nfsd_file_slab, nfsd_file_mark_slab,
> > the fsnotify groups, and the rhltable.
> >=20
> > Per-I/O references are not covered by the nfs_uuid handshake. Each
> > pgio call takes its own nfsd_file ref plus a paired nfsd_net ref
> > (fs/nfs/pagelist.c, nfs_local_open_fh), stores it in iocb->localio,
> > and releases it at completion through nfsd_file_put_local(). An
> > iocb is not on nfs_uuid->files, so nfs_localio_invalidate_clients()
> > does not wait for it; only the drain wait does. Meanwhile
> > __nfsd_file_cache_purge() has already unhashed the nfsd_file but
> > cannot free it (the iocb ref keeps refcount elevated in
> > nfsd_file_cond_queue()).
> >=20
> > So with one I/O in flight when the server is stopped: the shutdown
> > thread parks at the drain wait; the I/O completion thread enters
> > nfsd_file_put_local() and drops the last nfsd_net ref, which runs
> > complete() before nfsd_file_put() has executed. The shutdown thread
> > then proceeds through nfsd_file_cache_shutdown() concurrently with
> > the final nfsd_file_free(): the call_rcu() is queued after the
> > rcu_barrier(), so nfsd_file_slab_free() does kmem_cache_free() into
> > a destroyed cache, and nfsd_file_mark_put() runs against a destroyed
> > fsnotify group. kmem_cache_destroy() also fires "objects remaining"
> > because the nfsd_file is still allocated.
> >=20
> > The old ordering was the mechanism that prevented this: the caller
> > held its paired nfsd_net ref across nfsd_file_put(), and percpu_ref
> > guarantees the release callback runs only after every ref is
> > dropped, so global teardown strictly followed the file free and the
> > rcu_barrier() flushed its call_rcu().
> >=20
> > The hazard the commit message cites for the reorder cannot occur on
> > this path: NFSD_FILE_NET_HELD is set only in
> > nfsd_file_dispose_list_delayed(), reachable only through
> > refcount_dec_if_one() in nfsd_file_lru_cb(), i.e. at refcount =3D=3D 1.
> > A file with an outstanding LOCALIO reference has refcount >=3D 2, so
> > a file whose final put arrives via nfsd_file_put_local() never has
> > NET_HELD set and its nfsd_file_free() never calls put_net().
> >=20
> > Suggest keeping the void API but restoring the put order:
> >=20
> >       nf =3D unrcu_pointer(xchg(pnf, NULL));
> >       if (nf) {
> >               struct net *net =3D nf->nf_net;
> >=20
> >               nfsd_file_put(nf);
> >               rcu_read_lock();
> >               nfsd_net_put(net);
> >               rcu_read_unlock();
> >       }
> >=20
> > with the kdoc comment and the commit message paragraph about the
> > old ordering being unsafe adjusted to match.
>=20


I had claude review this and it says:

=E2=97=8F This is the same concern I just addressed for the previous patch'=
s Finding 3, restated as a
  critical bug. The answer is the same: this is a false positive.

  The reviewer's scenario requires:

  1. The global shrinker unhashes and isolates an nfsd_file onto a local di=
spose list
  2. The net namespace teardown completes and struct net is freed
  3. The shrinker resumes and calls get_net() on freed memory

  Step 2 cannot happen before step 3. Here's why:

  The net namespace struct net is reference-counted. It isn't freed when nf=
sd_net_exit() runs --
  nfsd_net_exit() is a pernet subsys callback that runs during net namespac=
e teardown, but the
  struct net itself stays alive until its own refcount drops to zero. The s=
truct net outlives all
  pernet exit callbacks.

  More importantly, nfsd_file_dispose_list_delayed() is called from exactly=
 three places:
  - nfsd_file_gc() -- the GC delayed work
  - nfsd_file_lru_scan() -- the shrinker
  - nfsd_file_close_inode() -- fsnotify

  All three isolate items and call nfsd_file_dispose_list_delayed() in a si=
ngle, synchronous
  function call. There's no point where a local dispose list sits around wa=
iting while the net
  namespace is torn down. The isolation and the get_net() happen in the sam=
e execution context.

  The shrinker and GC worker are global and remain registered until nfsd_fi=
le_cache_shutdown()
  (global teardown). Per-net teardown via nfsd_file_cache_shutdown_net() do=
es not unregister them.
  But the files they process were allocated while the net namespace was ali=
ve, and nf->nf_net was
  set at allocation time in nfsd_file_alloc(). The struct net cannot have a=
 zero refcount while nfsd
  files referencing it still exist in the LRU -- the nfsd server itself hol=
ds net references
  through its operation.

  The get_net() here is not protecting against the current dereference bein=
g unsafe. It's ensuring
  that nf_net remains valid for the arbitrarily long time the file sits on =
the per-net dispose list
  waiting for an nfsd thread to close it. That's exactly the right pattern.

  Verdict: False positive. The get_net() placement is correct and the struc=
t net is guaranteed to be
  live at this point.

--=20
Jeff Layton <jlayton@kernel.org>

