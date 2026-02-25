Return-Path: <linux-nfs+bounces-19253-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNZRCCRBn2laZgQAu9opvQ
	(envelope-from <linux-nfs+bounces-19253-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Feb 2026 19:36:20 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC6D19C583
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Feb 2026 19:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2169C30A3B1B
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Feb 2026 18:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA1A2C15BE;
	Wed, 25 Feb 2026 18:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="E91lLZfR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7662DF6EA
	for <linux-nfs@vger.kernel.org>; Wed, 25 Feb 2026 18:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772044164; cv=pass; b=FjoscCLeogIB+5A0hSK/564RQBsRGos9lUWGklmR/zftBXDFQjdDyKElx0/xoAXroTsVI4phOjQFpY315jqfOyXt0KhXG5cQw5D3XUjbaVR+Sg+OuJYLDjWLUE481IKOFT4ugZ5/WJbg28QcTooVXSlcK7nUlmlbfrtJuK3Osa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772044164; c=relaxed/simple;
	bh=5EoLR8gLgiAloWrVNMFg/vA32MQpMr4hWNX0Zclc5tE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WUkEnz/+FoTPajATce1p881MI7xJ3ZkXycmD71MfWRZWoRUDFt966XMSw+Gu30QxXbqEdV5CtJ29mlxFLApOB6tGx8WQEZQTMw5SMOcqGapHD5SLZeyX07EpZw31eqrTb8AY3Nkkebyrqza7t0e4B04WlyUok98D3f8bJD8VSJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=E91lLZfR; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59e64657f0cso7833759e87.2
        for <linux-nfs@vger.kernel.org>; Wed, 25 Feb 2026 10:29:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772044161; cv=none;
        d=google.com; s=arc-20240605;
        b=WDoJ7T0oB0yLqWEvy7m7Ot1MSUzJlmeU3JAas9Fbrfpyx7qGUo3KhEIPdgDRWqdZc3
         vtZuCmzb6Abl+1IsQMzE38JXtuM+Xm7ZFudwICaDs3yrQwnc8gscFhdbNgTPlWGrhHQK
         TalvQeBpCT+3A4ZjC2nBql7SX4nDynfPfm5c0SUMXeKTy5JPM0v8ZrjQH3zApsrf+TmH
         v2FCsO3lDy0aOr9lNKaSd9El1lfs9qwN71k0bWQNuvex3aK4rKHWDRBejeOH7kZ7cRP+
         vVcYxR2BoX+ZLWaboXkXjnudVPMDP+NGhOok3A0rwok3bPaSSVmNDqs+G3fN1pXVPlhs
         2/0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UdEeKmTxiVEbBhnp1qEMRfPQD/51Y4cYHNem1ptQxlg=;
        fh=mLZph9Zhg5eAryhh6Il/Dpd1glVNP6KIMySgprm6PxU=;
        b=gqRNu+gYvaoiPeYbBeGodaBI6I50ezlFBJF9KFBONnWquczYr6dTbHnVGQldM0RtlF
         tSbxu+r0ZRxts/5N2p706aM297vUlFRlVzGdir0c69H0qOMPJg1oB3nZO5DBVLsqhwvO
         iIx953wG1RIzqoMANPWwF9D3sTl/bEBydwWafD3Jd9cvSM8zfgMcPA569JT/6uZSTknj
         1F+3nBg5094oroBp5FiiSsiev5XuDFELJqr8R9xdz1WdUCuKQxc6Log0X9EVUEfjrRHq
         qeB7zcHfnsoGslBl26cmztlqaH3JfcEC/FGmqy/4X2hdTQXsXKNW3FeWze0watNin2FA
         2LHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1772044161; x=1772648961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdEeKmTxiVEbBhnp1qEMRfPQD/51Y4cYHNem1ptQxlg=;
        b=E91lLZfRPNzevIBtWjl3YiiABEkBsIfZefhuo9EiMLtDhTj9DaFaF3SAj478uCmnJx
         czU1NfhfXqvTI/ZzMMBSWbcSYGg/cGh/ox2KXpWPsXuaQ/6NbQitWhXSDtCUdMy8lYov
         Zzgpsa/kAhPlrK3Rv5KN97mZJmgVXrXWl4O1/ZQWDb3zuw27Jwu3uvXG54fuz0eKm0Hb
         cTXuQprx9ZndFQuT0Lc2hPHVok5R7OV3NyC5DtyGQhSELVahQzx7JXkcX6JrYWwLS+eV
         Jv/LvbgNTHZ6BodeYdY/cc5ROPa4TsPa9/PJBC2Xu7hqVleAJhwIcMwxI/ukpCjKs8ev
         UGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772044161; x=1772648961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UdEeKmTxiVEbBhnp1qEMRfPQD/51Y4cYHNem1ptQxlg=;
        b=o+syDVohmLPYAi+26M0Zm/F2hshhJSwrUx6VS45oIoWbBYRvni6/qGhk38VZGpun/N
         tewNmsqKAsk/0Gr9kBuqC/NqEW4fYhCHezqaoSEpPVrn7r92uSg835pGq9AoZ+G4OtVb
         dNwdC21VHlbrmA8lge9gFnwW8QdavPtQskdfngDLpy9YOkKqWdC0k+pqTSGucTKwVT0S
         yuAy/FltdIQryRi5E3eS6wCJGnzvdJO8OAadtE02UyYS26I6YL8BfTkEBAuoIT8PV35H
         UYHbrNX6c3RqT1ndl7T/mnPXcGb9hLw6FhntNHIMxGd/sulIBUP/86jbgnNEue99v3KM
         dN9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVup3diYjRh6UzXNBtVSGvsqPTh7bFautJBldURPmo4ANgMYxckSaIvsJ5BQQN8nXRnd8AGWF8bvkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBqLH+wQ5ZQNED9ZeOLzZ0EuRcj95keTjkTjAcO62u2FG+KBEf
	SFeli5Tauuf/0p/9MPIGCCivqCB2OYvvrNXZweGrSCy8BhpY4MajiDemx3RED/ir36lYBqpnk7j
	JQn2OeTNgzpxUaUR9HjHfmhapwx+GDtoJH/wj
X-Gm-Gg: ATEYQzwIXscSZJqTXbYgUIYQXgtxjpYMTIgQkaZDd8I/lckEBVcZtFR8rzW1RnPvVaG
	UjHObNJH7auw/EX/dG4Piot4AoDp7y7GqqJPR3aKoJAN+xXXDLgkY6CKPdwGTv0xyua0H4Y/dtT
	X/Hwod3a7GoIlLIEMOn7jeWm++twW3YCYUsXneoinbkgB/PGTxzf+oMBCJ/uegbgpEFQiDBr/IL
	1++M5poTp6hB/94wsWg9oqAouz9flljUtVSZmwrFOaEYhlB8fPaB7lCxz4Pe3TqnOq2J2lHQdbF
	TB54WuoGoDyC3XWxEH9PPjzSNngomvg61dW6eXmE0w==
X-Received: by 2002:a2e:a99b:0:b0:384:9355:6a3c with SMTP id
 38308e7fff4ca-389ee2b3f72mr4452351fa.24.1772044160646; Wed, 25 Feb 2026
 10:29:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219215017.1769-1-cel@kernel.org> <20260219215017.1769-2-cel@kernel.org>
 <ae5f1ee0c43eda94f86bc60b1b223c86e0f24805.camel@kernel.org>
In-Reply-To: <ae5f1ee0c43eda94f86bc60b1b223c86e0f24805.camel@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Wed, 25 Feb 2026 13:29:07 -0500
X-Gm-Features: AaiRm51geK6rBX0tVLqNhbxmLqRfRn0W54cYcZ0fpSQBcNjYG0eeRTzBZQoydBo
Message-ID: <CAN-5tyGW=nt67ttmj+c79aDDpu6yfAfppC0ZZHQZSXCuf+CTeQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] NFSD: Defer sub-object cleanup in export put callbacks
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <cel@kernel.org>, misanjum@linux.ibm.com, NeilBrown <neilb@ownmail.net>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[umich.edu,none];
	R_DKIM_ALLOW(-0.20)[umich.edu:s=google-2016-06-03];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,ownmail.net,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-19253-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[umich.edu:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aglo@umich.edu,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CAC6D19C583
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 10:50=E2=80=AFAM Jeff Layton <jlayton@kernel.org> w=
rote:
>
> On Thu, 2026-02-19 at 16:50 -0500, Chuck Lever wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> >
> > svc_export_put() calls path_put() and auth_domain_put() immediately
> > when the last reference drops, before the RCU grace period. RCU
> > readers in e_show() and c_show() access both ex_path (via
> > seq_path/d_path) and ex_client->name (via seq_escape) without
> > holding a reference. If cache_clean removes the entry and drops the
> > last reference concurrently, the sub-objects are freed while still
> > in use, producing a NULL pointer dereference in d_path.
> >
> > Commit 2530766492ec ("nfsd: fix UAF when access ex_uuid or
> > ex_stats") moved kfree of ex_uuid and ex_stats into the
> > call_rcu callback, but left path_put() and auth_domain_put() running
> > before the grace period because both may sleep and call_rcu
> > callbacks execute in softirq context.
> >
> > Replace call_rcu/kfree_rcu with queue_rcu_work(), which defers the
> > callback until after the RCU grace period and executes it in process
> > context where sleeping is permitted. This allows path_put() and
> > auth_domain_put() to be moved into the deferred callback alongside
> > the other resource releases. Apply the same fix to expkey_put(),
> > which has the identical pattern with ek_path and ek_client.
> >
> > A dedicated workqueue scopes the shutdown drain to only NFSD
> > export release work items; flushing the shared
> > system_unbound_wq would stall on unrelated work from other
> > subsystems. nfsd_export_shutdown() uses rcu_barrier() followed
> > by flush_workqueue() to ensure all deferred release callbacks
> > complete before the export caches are destroyed.
> >
> > Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
> > Closes: https://lore.kernel.org/linux-nfs/dcd371d3a95815a84ba7de52cef44=
7b8@linux.ibm.com/
> > Fixes: c224edca7af0 ("nfsd: no need get cache ref when protected by rcu=
")
> > Fixes: 1b10f0b603c0 ("SUNRPC: no need get cache ref when protected by r=
cu")
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Tested-by: Olga Kornievskaia <okorniev@redhat.com>

I can reproduce the problem and verify that the 2 patches applied I no
longer see it.

> > ---
> >  fs/nfsd/export.c | 63 +++++++++++++++++++++++++++++++++++++++++-------
> >  fs/nfsd/export.h |  7 ++++--
> >  fs/nfsd/nfsctl.c |  8 +++++-
> >  3 files changed, 66 insertions(+), 12 deletions(-)
> >
> > diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> > index 04b18f0f402f..53fe66784ed2 100644
> > --- a/fs/nfsd/export.c
> > +++ b/fs/nfsd/export.c
> > @@ -36,19 +36,30 @@
> >   * second map contains a reference to the entry in the first map.
> >   */
> >
> > +static struct workqueue_struct *nfsd_export_wq;
> > +
> >  #define      EXPKEY_HASHBITS         8
> >  #define      EXPKEY_HASHMAX          (1 << EXPKEY_HASHBITS)
> >  #define      EXPKEY_HASHMASK         (EXPKEY_HASHMAX -1)
> >
> > -static void expkey_put(struct kref *ref)
> > +static void expkey_release(struct work_struct *work)
> >  {
> > -     struct svc_expkey *key =3D container_of(ref, struct svc_expkey, h=
.ref);
> > +     struct svc_expkey *key =3D container_of(to_rcu_work(work),
> > +                                           struct svc_expkey, ek_rwork=
);
> >
> >       if (test_bit(CACHE_VALID, &key->h.flags) &&
> >           !test_bit(CACHE_NEGATIVE, &key->h.flags))
> >               path_put(&key->ek_path);
> >       auth_domain_put(key->ek_client);
> > -     kfree_rcu(key, ek_rcu);
> > +     kfree(key);
> > +}
> > +
> > +static void expkey_put(struct kref *ref)
> > +{
> > +     struct svc_expkey *key =3D container_of(ref, struct svc_expkey, h=
.ref);
> > +
> > +     INIT_RCU_WORK(&key->ek_rwork, expkey_release);
> > +     queue_rcu_work(nfsd_export_wq, &key->ek_rwork);
> >  }
> >
> >  static int expkey_upcall(struct cache_detail *cd, struct cache_head *h=
)
> > @@ -353,11 +364,13 @@ static void export_stats_destroy(struct export_st=
ats *stats)
> >                                           EXP_STATS_COUNTERS_NUM);
> >  }
> >
> > -static void svc_export_release(struct rcu_head *rcu_head)
> > +static void svc_export_release(struct work_struct *work)
> >  {
> > -     struct svc_export *exp =3D container_of(rcu_head, struct svc_expo=
rt,
> > -                     ex_rcu);
> > +     struct svc_export *exp =3D container_of(to_rcu_work(work),
> > +                                           struct svc_export, ex_rwork=
);
> >
> > +     path_put(&exp->ex_path);
> > +     auth_domain_put(exp->ex_client);
> >       nfsd4_fslocs_free(&exp->ex_fslocs);
> >       export_stats_destroy(exp->ex_stats);
> >       kfree(exp->ex_stats);
> > @@ -369,9 +382,8 @@ static void svc_export_put(struct kref *ref)
> >  {
> >       struct svc_export *exp =3D container_of(ref, struct svc_export, h=
.ref);
> >
> > -     path_put(&exp->ex_path);
> > -     auth_domain_put(exp->ex_client);
> > -     call_rcu(&exp->ex_rcu, svc_export_release);
> > +     INIT_RCU_WORK(&exp->ex_rwork, svc_export_release);
> > +     queue_rcu_work(nfsd_export_wq, &exp->ex_rwork);
> >  }
> >
> >  static int svc_export_upcall(struct cache_detail *cd, struct cache_hea=
d *h)
> > @@ -1481,6 +1493,36 @@ const struct seq_operations nfs_exports_op =3D {
> >       .show   =3D e_show,
> >  };
> >
> > +/**
> > + * nfsd_export_wq_init - allocate the export release workqueue
> > + *
> > + * Called once at module load. The workqueue runs deferred svc_export =
and
> > + * svc_expkey release work scheduled by queue_rcu_work() in the cache =
put
> > + * callbacks.
> > + *
> > + * Return values:
> > + *   %0: workqueue allocated
> > + *   %-ENOMEM: allocation failed
> > + */
> > +int nfsd_export_wq_init(void)
> > +{
> > +     nfsd_export_wq =3D alloc_workqueue("nfsd_export", WQ_UNBOUND, 0);
> > +     if (!nfsd_export_wq)
> > +             return -ENOMEM;
> > +     return 0;
> > +}
> > +
> > +/**
> > + * nfsd_export_wq_shutdown - drain and free the export release workque=
ue
> > + *
> > + * Called once at module unload. Per-namespace teardown in
> > + * nfsd_export_shutdown() has already drained all deferred work.
> > + */
> > +void nfsd_export_wq_shutdown(void)
> > +{
> > +     destroy_workqueue(nfsd_export_wq);
> > +}
> > +
> >  /*
> >   * Initialize the exports module.
> >   */
> > @@ -1542,6 +1584,9 @@ nfsd_export_shutdown(struct net *net)
> >
> >       cache_unregister_net(nn->svc_expkey_cache, net);
> >       cache_unregister_net(nn->svc_export_cache, net);
> > +     /* Drain deferred export and expkey release work. */
> > +     rcu_barrier();
> > +     flush_workqueue(nfsd_export_wq);
> >       cache_destroy_net(nn->svc_expkey_cache, net);
> >       cache_destroy_net(nn->svc_export_cache, net);
> >       svcauth_unix_purge(net);
> > diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
> > index d2b09cd76145..b05399374574 100644
> > --- a/fs/nfsd/export.h
> > +++ b/fs/nfsd/export.h
> > @@ -7,6 +7,7 @@
> >
> >  #include <linux/sunrpc/cache.h>
> >  #include <linux/percpu_counter.h>
> > +#include <linux/workqueue.h>
> >  #include <uapi/linux/nfsd/export.h>
> >  #include <linux/nfs4.h>
> >
> > @@ -75,7 +76,7 @@ struct svc_export {
> >       u32                     ex_layout_types;
> >       struct nfsd4_deviceid_map *ex_devid_map;
> >       struct cache_detail     *cd;
> > -     struct rcu_head         ex_rcu;
> > +     struct rcu_work         ex_rwork;
> >       unsigned long           ex_xprtsec_modes;
> >       struct export_stats     *ex_stats;
> >  };
> > @@ -92,7 +93,7 @@ struct svc_expkey {
> >       u32                     ek_fsid[6];
> >
> >       struct path             ek_path;
> > -     struct rcu_head         ek_rcu;
> > +     struct rcu_work         ek_rwork;
> >  };
> >
> >  #define EX_ISSYNC(exp)               (!((exp)->ex_flags & NFSEXP_ASYNC=
))
> > @@ -110,6 +111,8 @@ __be32 check_nfsd_access(struct svc_export *exp, st=
ruct svc_rqst *rqstp,
> >  /*
> >   * Function declarations
> >   */
> > +int                  nfsd_export_wq_init(void);
> > +void                 nfsd_export_wq_shutdown(void);
> >  int                  nfsd_export_init(struct net *);
> >  void                 nfsd_export_shutdown(struct net *);
> >  void                 nfsd_export_flush(struct net *);
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 664a3275c511..4166f59908f4 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -2308,9 +2308,12 @@ static int __init init_nfsd(void)
> >       if (retval)
> >               goto out_free_pnfs;
> >       nfsd_lockd_init();      /* lockd->nfsd callbacks */
> > +     retval =3D nfsd_export_wq_init();
> > +     if (retval)
> > +             goto out_free_lockd;
> >       retval =3D register_pernet_subsys(&nfsd_net_ops);
> >       if (retval < 0)
> > -             goto out_free_lockd;
> > +             goto out_free_export_wq;
> >       retval =3D register_cld_notifier();
> >       if (retval)
> >               goto out_free_subsys;
> > @@ -2339,6 +2342,8 @@ static int __init init_nfsd(void)
> >       unregister_cld_notifier();
> >  out_free_subsys:
> >       unregister_pernet_subsys(&nfsd_net_ops);
> > +out_free_export_wq:
> > +     nfsd_export_wq_shutdown();
> >  out_free_lockd:
> >       nfsd_lockd_shutdown();
> >       nfsd_drc_slab_free();
> > @@ -2359,6 +2364,7 @@ static void __exit exit_nfsd(void)
> >       nfsd4_destroy_laundry_wq();
> >       unregister_cld_notifier();
> >       unregister_pernet_subsys(&nfsd_net_ops);
> > +     nfsd_export_wq_shutdown();
> >       nfsd_drc_slab_free();
> >       nfsd_lockd_shutdown();
> >       nfsd4_free_slabs();
>
> Looks good.
>
> Reviwed-by: Jeff Layton <jlayton@kernel.org>
>

