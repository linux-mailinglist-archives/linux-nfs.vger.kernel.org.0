Return-Path: <linux-nfs+bounces-19255-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGs0EU1Fn2m5ZgQAu9opvQ
	(envelope-from <linux-nfs+bounces-19255-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Feb 2026 19:54:05 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE2319C79D
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Feb 2026 19:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B9A643033643
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Feb 2026 18:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A962E7635;
	Wed, 25 Feb 2026 18:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnaYtIKa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846032C15BE
	for <linux-nfs@vger.kernel.org>; Wed, 25 Feb 2026 18:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772045638; cv=none; b=DU6miGXHMinrXydme3J0bhXEb4Y1zx8V4c9yVPhJ+PS08fuu1YJGsFChun1iioTbWv3saBpOwTjYMd/lKm9j0T0Vi2FbQ347UaUrSpRa5z9Xi9p5fac06gBQ9to/4SGY/IX5ayHSWsT8GJynWkCQXO9ls1tnvTusS2Vw3rxtWoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772045638; c=relaxed/simple;
	bh=tHdkOt4VdElvB0h10DewmlxpHcd3mjjIB1Tv1jJ0qmc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Yi4n0hX66u95PCRD1uUnnoOJV0odO/FtKSxMFjLE5MndtLGw6a9J+0rUbIGl0hBVvIz2q95QFXRWzkoWbiSM+GXWlOMEo3xt9zX453023oikXI9B3rl86W1y5LiNmdbkykWV3gZ3y5kStRcrmSjaTLXaWhFA0TTHPLBCMq8JmZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnaYtIKa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A2BC19421;
	Wed, 25 Feb 2026 18:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772045638;
	bh=tHdkOt4VdElvB0h10DewmlxpHcd3mjjIB1Tv1jJ0qmc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=MnaYtIKaHVh1vlpGyFP780GyPSo3MMHFxkPmVzg9igUCVMi8d/ZZVNEH6p/ICwggd
	 ai0g4ojxi59pYY37jh8pDFXTh1AX2FIhPPwlMMyWPrGD6/XKm2TASPoPPdc8gTlkh0
	 GrTG+c5yA69atT2eTl87rpL1UYVR1MU/asNN0twuJ8eNE80lSi+tvuDQ1+Vj12TEpd
	 rprFN9PgY+gQTRe/qJswh2aY8fEx+7UTMIDoE9jTP812hnj9BICFvqHAXnokhJ6zBQ
	 TilVwK1jd8DfnGQquWIhwgIIxJRYeutexpiAkO6Fe4pxmxE73A78O0oMXYHv6RVKmU
	 eKp+dPqtrPamw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id C7E70F4006E;
	Wed, 25 Feb 2026 13:53:56 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 25 Feb 2026 13:53:56 -0500
X-ME-Sender: <xms:REWfaWzgNj3pwPhLDdoiqPQ-6CPZyfKPKB5YwuEq2tAwAaQGvRSolg>
    <xme:REWfadFpHcX6UBSB7m47PfL1e5BIA1zBQPiG-b3do-oCQeAiL9m7PdTJXy_AKdfqs
    Ox2YM5rM-fbQHJGMrKXBgGuLdIYPWMa41q7MOG0PI0SKcV54712Asmm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeefkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpeegheduieeiveevheelheelueeghffhtddtheelhfdutddtheeileetkeelvedtjeen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheptghhuhgtkhhlvghvvghrodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdduieefgeelleelheelqdefvdelkeeggedvfedqtggvlh
    eppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthho
    peelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehmihhsrghnjhhumheslhhinhhugidrihgsmhdrtgho
    mhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtph
    htthhopegurghirdhnghhosehorhgrtghlvgdrtghomhdprhgtphhtthhopehnvghilhgs
    sehofihnmhgrihhlrdhnvghtpdhrtghpthhtohepohhkohhrnhhivghvsehrvgguhhgrth
    drtghomhdprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopegr
    ghhlohesuhhmihgthhdrvgguuhdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:REWfacDkD7lAgvlllp74J5cOX4EfVmLy0Jt_--n_LSnVwwj-iYSuRQ>
    <xmx:REWfae-b6oXGCwRiCjJdR2k2LRVxDXxZXX4QbHqSG0tVCQlnqX0xZA>
    <xmx:REWfaQQbWJi47VoS03gsRX2SDimTnSQcILdYHpVERXQswMqwc2OurA>
    <xmx:REWfaaX_RN3hinAEH9kfdryEPagcgKQdR2FGhuB_Sq4Z5RQV8__OJg>
    <xmx:REWfaSRQ0Wmqxc36vNsIXz5fWWnOZvV0rGUuFZL31FvxoLz3SZ2zt2FM>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9F15A780070; Wed, 25 Feb 2026 13:53:56 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AhF6pPLhmXU-
Date: Wed, 25 Feb 2026 13:53:36 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Olga Kornievskaia" <aglo@umich.edu>, "Jeff Layton" <jlayton@kernel.org>
Cc: misanjum@linux.ibm.com, NeilBrown <neilb@ownmail.net>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <d32d3b38-2e5c-4734-9cfa-f4a2973ca649@app.fastmail.com>
In-Reply-To: 
 <CAN-5tyGW=nt67ttmj+c79aDDpu6yfAfppC0ZZHQZSXCuf+CTeQ@mail.gmail.com>
References: <20260219215017.1769-1-cel@kernel.org>
 <20260219215017.1769-2-cel@kernel.org>
 <ae5f1ee0c43eda94f86bc60b1b223c86e0f24805.camel@kernel.org>
 <CAN-5tyGW=nt67ttmj+c79aDDpu6yfAfppC0ZZHQZSXCuf+CTeQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] NFSD: Defer sub-object cleanup in export put callbacks
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,ownmail.net,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19255-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5BE2319C79D
X-Rspamd-Action: no action



On Wed, Feb 25, 2026, at 1:29 PM, Olga Kornievskaia wrote:
> On Fri, Feb 20, 2026 at 10:50=E2=80=AFAM Jeff Layton <jlayton@kernel.o=
rg> wrote:
>>
>> On Thu, 2026-02-19 at 16:50 -0500, Chuck Lever wrote:
>> > From: Chuck Lever <chuck.lever@oracle.com>
>> >
>> > svc_export_put() calls path_put() and auth_domain_put() immediately
>> > when the last reference drops, before the RCU grace period. RCU
>> > readers in e_show() and c_show() access both ex_path (via
>> > seq_path/d_path) and ex_client->name (via seq_escape) without
>> > holding a reference. If cache_clean removes the entry and drops the
>> > last reference concurrently, the sub-objects are freed while still
>> > in use, producing a NULL pointer dereference in d_path.
>> >
>> > Commit 2530766492ec ("nfsd: fix UAF when access ex_uuid or
>> > ex_stats") moved kfree of ex_uuid and ex_stats into the
>> > call_rcu callback, but left path_put() and auth_domain_put() running
>> > before the grace period because both may sleep and call_rcu
>> > callbacks execute in softirq context.
>> >
>> > Replace call_rcu/kfree_rcu with queue_rcu_work(), which defers the
>> > callback until after the RCU grace period and executes it in process
>> > context where sleeping is permitted. This allows path_put() and
>> > auth_domain_put() to be moved into the deferred callback alongside
>> > the other resource releases. Apply the same fix to expkey_put(),
>> > which has the identical pattern with ek_path and ek_client.
>> >
>> > A dedicated workqueue scopes the shutdown drain to only NFSD
>> > export release work items; flushing the shared
>> > system_unbound_wq would stall on unrelated work from other
>> > subsystems. nfsd_export_shutdown() uses rcu_barrier() followed
>> > by flush_workqueue() to ensure all deferred release callbacks
>> > complete before the export caches are destroyed.
>> >
>> > Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
>> > Closes: https://lore.kernel.org/linux-nfs/dcd371d3a95815a84ba7de52c=
ef447b8@linux.ibm.com/
>> > Fixes: c224edca7af0 ("nfsd: no need get cache ref when protected by=
 rcu")
>> > Fixes: 1b10f0b603c0 ("SUNRPC: no need get cache ref when protected =
by rcu")
>> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>
> Tested-by: Olga Kornievskaia <okorniev@redhat.com>
>
> I can reproduce the problem and verify that the 2 patches applied I no
> longer see it.

Excellent, thank you!


>> > ---
>> >  fs/nfsd/export.c | 63 +++++++++++++++++++++++++++++++++++++++++---=
----
>> >  fs/nfsd/export.h |  7 ++++--
>> >  fs/nfsd/nfsctl.c |  8 +++++-
>> >  3 files changed, 66 insertions(+), 12 deletions(-)
>> >
>> > diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
>> > index 04b18f0f402f..53fe66784ed2 100644
>> > --- a/fs/nfsd/export.c
>> > +++ b/fs/nfsd/export.c
>> > @@ -36,19 +36,30 @@
>> >   * second map contains a reference to the entry in the first map.
>> >   */
>> >
>> > +static struct workqueue_struct *nfsd_export_wq;
>> > +
>> >  #define      EXPKEY_HASHBITS         8
>> >  #define      EXPKEY_HASHMAX          (1 << EXPKEY_HASHBITS)
>> >  #define      EXPKEY_HASHMASK         (EXPKEY_HASHMAX -1)
>> >
>> > -static void expkey_put(struct kref *ref)
>> > +static void expkey_release(struct work_struct *work)
>> >  {
>> > -     struct svc_expkey *key =3D container_of(ref, struct svc_expke=
y, h.ref);
>> > +     struct svc_expkey *key =3D container_of(to_rcu_work(work),
>> > +                                           struct svc_expkey, ek_r=
work);
>> >
>> >       if (test_bit(CACHE_VALID, &key->h.flags) &&
>> >           !test_bit(CACHE_NEGATIVE, &key->h.flags))
>> >               path_put(&key->ek_path);
>> >       auth_domain_put(key->ek_client);
>> > -     kfree_rcu(key, ek_rcu);
>> > +     kfree(key);
>> > +}
>> > +
>> > +static void expkey_put(struct kref *ref)
>> > +{
>> > +     struct svc_expkey *key =3D container_of(ref, struct svc_expke=
y, h.ref);
>> > +
>> > +     INIT_RCU_WORK(&key->ek_rwork, expkey_release);
>> > +     queue_rcu_work(nfsd_export_wq, &key->ek_rwork);
>> >  }
>> >
>> >  static int expkey_upcall(struct cache_detail *cd, struct cache_hea=
d *h)
>> > @@ -353,11 +364,13 @@ static void export_stats_destroy(struct expor=
t_stats *stats)
>> >                                           EXP_STATS_COUNTERS_NUM);
>> >  }
>> >
>> > -static void svc_export_release(struct rcu_head *rcu_head)
>> > +static void svc_export_release(struct work_struct *work)
>> >  {
>> > -     struct svc_export *exp =3D container_of(rcu_head, struct svc_=
export,
>> > -                     ex_rcu);
>> > +     struct svc_export *exp =3D container_of(to_rcu_work(work),
>> > +                                           struct svc_export, ex_r=
work);
>> >
>> > +     path_put(&exp->ex_path);
>> > +     auth_domain_put(exp->ex_client);
>> >       nfsd4_fslocs_free(&exp->ex_fslocs);
>> >       export_stats_destroy(exp->ex_stats);
>> >       kfree(exp->ex_stats);
>> > @@ -369,9 +382,8 @@ static void svc_export_put(struct kref *ref)
>> >  {
>> >       struct svc_export *exp =3D container_of(ref, struct svc_expor=
t, h.ref);
>> >
>> > -     path_put(&exp->ex_path);
>> > -     auth_domain_put(exp->ex_client);
>> > -     call_rcu(&exp->ex_rcu, svc_export_release);
>> > +     INIT_RCU_WORK(&exp->ex_rwork, svc_export_release);
>> > +     queue_rcu_work(nfsd_export_wq, &exp->ex_rwork);
>> >  }
>> >
>> >  static int svc_export_upcall(struct cache_detail *cd, struct cache=
_head *h)
>> > @@ -1481,6 +1493,36 @@ const struct seq_operations nfs_exports_op =3D=
 {
>> >       .show   =3D e_show,
>> >  };
>> >
>> > +/**
>> > + * nfsd_export_wq_init - allocate the export release workqueue
>> > + *
>> > + * Called once at module load. The workqueue runs deferred svc_exp=
ort and
>> > + * svc_expkey release work scheduled by queue_rcu_work() in the ca=
che put
>> > + * callbacks.
>> > + *
>> > + * Return values:
>> > + *   %0: workqueue allocated
>> > + *   %-ENOMEM: allocation failed
>> > + */
>> > +int nfsd_export_wq_init(void)
>> > +{
>> > +     nfsd_export_wq =3D alloc_workqueue("nfsd_export", WQ_UNBOUND,=
 0);
>> > +     if (!nfsd_export_wq)
>> > +             return -ENOMEM;
>> > +     return 0;
>> > +}
>> > +
>> > +/**
>> > + * nfsd_export_wq_shutdown - drain and free the export release wor=
kqueue
>> > + *
>> > + * Called once at module unload. Per-namespace teardown in
>> > + * nfsd_export_shutdown() has already drained all deferred work.
>> > + */
>> > +void nfsd_export_wq_shutdown(void)
>> > +{
>> > +     destroy_workqueue(nfsd_export_wq);
>> > +}
>> > +
>> >  /*
>> >   * Initialize the exports module.
>> >   */
>> > @@ -1542,6 +1584,9 @@ nfsd_export_shutdown(struct net *net)
>> >
>> >       cache_unregister_net(nn->svc_expkey_cache, net);
>> >       cache_unregister_net(nn->svc_export_cache, net);
>> > +     /* Drain deferred export and expkey release work. */
>> > +     rcu_barrier();
>> > +     flush_workqueue(nfsd_export_wq);
>> >       cache_destroy_net(nn->svc_expkey_cache, net);
>> >       cache_destroy_net(nn->svc_export_cache, net);
>> >       svcauth_unix_purge(net);
>> > diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
>> > index d2b09cd76145..b05399374574 100644
>> > --- a/fs/nfsd/export.h
>> > +++ b/fs/nfsd/export.h
>> > @@ -7,6 +7,7 @@
>> >
>> >  #include <linux/sunrpc/cache.h>
>> >  #include <linux/percpu_counter.h>
>> > +#include <linux/workqueue.h>
>> >  #include <uapi/linux/nfsd/export.h>
>> >  #include <linux/nfs4.h>
>> >
>> > @@ -75,7 +76,7 @@ struct svc_export {
>> >       u32                     ex_layout_types;
>> >       struct nfsd4_deviceid_map *ex_devid_map;
>> >       struct cache_detail     *cd;
>> > -     struct rcu_head         ex_rcu;
>> > +     struct rcu_work         ex_rwork;
>> >       unsigned long           ex_xprtsec_modes;
>> >       struct export_stats     *ex_stats;
>> >  };
>> > @@ -92,7 +93,7 @@ struct svc_expkey {
>> >       u32                     ek_fsid[6];
>> >
>> >       struct path             ek_path;
>> > -     struct rcu_head         ek_rcu;
>> > +     struct rcu_work         ek_rwork;
>> >  };
>> >
>> >  #define EX_ISSYNC(exp)               (!((exp)->ex_flags & NFSEXP_A=
SYNC))
>> > @@ -110,6 +111,8 @@ __be32 check_nfsd_access(struct svc_export *exp=
, struct svc_rqst *rqstp,
>> >  /*
>> >   * Function declarations
>> >   */
>> > +int                  nfsd_export_wq_init(void);
>> > +void                 nfsd_export_wq_shutdown(void);
>> >  int                  nfsd_export_init(struct net *);
>> >  void                 nfsd_export_shutdown(struct net *);
>> >  void                 nfsd_export_flush(struct net *);
>> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>> > index 664a3275c511..4166f59908f4 100644
>> > --- a/fs/nfsd/nfsctl.c
>> > +++ b/fs/nfsd/nfsctl.c
>> > @@ -2308,9 +2308,12 @@ static int __init init_nfsd(void)
>> >       if (retval)
>> >               goto out_free_pnfs;
>> >       nfsd_lockd_init();      /* lockd->nfsd callbacks */
>> > +     retval =3D nfsd_export_wq_init();
>> > +     if (retval)
>> > +             goto out_free_lockd;
>> >       retval =3D register_pernet_subsys(&nfsd_net_ops);
>> >       if (retval < 0)
>> > -             goto out_free_lockd;
>> > +             goto out_free_export_wq;
>> >       retval =3D register_cld_notifier();
>> >       if (retval)
>> >               goto out_free_subsys;
>> > @@ -2339,6 +2342,8 @@ static int __init init_nfsd(void)
>> >       unregister_cld_notifier();
>> >  out_free_subsys:
>> >       unregister_pernet_subsys(&nfsd_net_ops);
>> > +out_free_export_wq:
>> > +     nfsd_export_wq_shutdown();
>> >  out_free_lockd:
>> >       nfsd_lockd_shutdown();
>> >       nfsd_drc_slab_free();
>> > @@ -2359,6 +2364,7 @@ static void __exit exit_nfsd(void)
>> >       nfsd4_destroy_laundry_wq();
>> >       unregister_cld_notifier();
>> >       unregister_pernet_subsys(&nfsd_net_ops);
>> > +     nfsd_export_wq_shutdown();
>> >       nfsd_drc_slab_free();
>> >       nfsd_lockd_shutdown();
>> >       nfsd4_free_slabs();
>>
>> Looks good.
>>
>> Reviwed-by: Jeff Layton <jlayton@kernel.org>
>>

--=20
Chuck Lever

