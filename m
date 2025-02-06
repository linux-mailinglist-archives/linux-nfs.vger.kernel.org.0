Return-Path: <linux-nfs+bounces-9907-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD7BA2B134
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Feb 2025 19:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79DCA3A6F92
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Feb 2025 18:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C3119EEBF;
	Thu,  6 Feb 2025 18:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFRoFZqI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9691719E997;
	Thu,  6 Feb 2025 18:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738866577; cv=none; b=eh0oOlUoLIuqkEj28NG6l4248UMN/fvZ7GN7O0qkUVvuXpImpIws02OSuHm2Z1LcvvWo4iCNEM3Bm9Ab6RjR2LtzTRJZnI26IQuwnTKZ6hp1qzelIJQxhWHAwGGWvq7uJ/Yx8gfsv3u7qUM/uKrjczG6x981vTxQARb4AAsZtqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738866577; c=relaxed/simple;
	bh=bqkqVppprwv2/h3KLXNq5+ns9QVFkuJKls2nqG7a6IQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o9KERw+oj4RFQ9lWxqEL+WvLlsvH58yD82S4F8vicbJmHFtbRpiVIVhES+2vF+v5Iu4Fj7ASuBdTc6TGeDrTpNRM3aEezXz9yLss6dXlPe3BfS6GzflG2FWBNhK3Ftiv2Upq3iY7PlU4Vsvoqw1/CSFBjLO0KvPaNHNjHns6DhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFRoFZqI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2AF6C4CEE9;
	Thu,  6 Feb 2025 18:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738866576;
	bh=bqkqVppprwv2/h3KLXNq5+ns9QVFkuJKls2nqG7a6IQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=lFRoFZqIH7TfivJ41MygpaJPk5W6OFt6IxlEDdaeeV5GQ456DYZ9BEJCMGHC6PXtM
	 kQvILYiJDFPzdsxws1tnFQaMxBFzC9wBGtmQHRy28llvoJ7GJy8YMiKvttEQIPKkoZ
	 5c8rh64nFbm2zdeNEu8PB5TSrLrWsIZhaabpRqI+NmNoXgSMi4Y4I5eZZXX+cxBTlM
	 Y0NKePEK0JIACInkHU6Yj7Piail8hWKuuB4yJm8QsNjJCn38lhWFPyT9jt3F9KpzHx
	 M37cgaVDGmOL6JRMeS3mUwR3FhK2f4c70Nj9RCBqUW/rdzaG5dTd0Ji0GpWifsxepU
	 G4hjL2MKJUUNQ==
Message-ID: <232559042f0d52a858d02273a047a52282597d6b.camel@kernel.org>
Subject: Re: [PATCH] nfsd: don't ignore the return code of
 svc_proc_register()
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>, Josef Bacik	 <josef@toxicpanda.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+e34ad04f27991521104c@syzkaller.appspotmail.com
Date: Thu, 06 Feb 2025 13:29:34 -0500
In-Reply-To: <d6ecad5f-b2a5-435c-9209-d784a23b013c@oracle.com>
References: <20250206-nfsd-fixes-v1-1-c6647b92ca6f@kernel.org>
	 <d6ecad5f-b2a5-435c-9209-d784a23b013c@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-02-06 at 13:17 -0500, Chuck Lever wrote:
> On 2/6/25 1:12 PM, Jeff Layton wrote:
> > Currently, nfsd_proc_stat_init() ignores the return value of
> > svc_proc_register(). If the procfile creation fails, then the kernel
> > will WARN when it tries to remove the entry later.
> >=20
> > Fix nfsd_proc_stat_init() to return the same type of pointer as
> > svc_proc_register(), and fix up nfsd_net_init() to check that and fail
> > the nfsd_net construction if it occurs.
> >=20
> > svc_proc_register() can fail if the dentry can't be allocated, or if an
> > identical dentry already exists. The second case is pretty unlikely in
> > the nfsd_net construction codepath, so if this happens, return -ENOMEM.
> >=20
> > Fixes: 93483ac5fec6 ("nfsd: expose /proc/net/sunrpc/nfsd in net namespa=
ces")
> > Reported-by: syzbot+e34ad04f27991521104c@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/linux-nfs/67a47501.050a0220.19061f.05f9=
.GAE@google.com/
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > I looked at the console log from the report, and syzkaller is doing
> > fault injection on allocations. You can see the stack where the "nfsd"
> > directory under /proc failed to be created due to one. This is a pretty
> > unlikely bug under normal circumstances, but it's simple to fix. The
> > problem predates the patch in Fixes:, but it's not worth the effort to
> > backport this to anything earlier.
>=20
> I'd prefer to document this by labeling the actual commit that
> introduced the problem in the Fixes: tag, then using
>=20
> "Cc: stable # vN.M"
>=20
> to block automatic backporting to LTS kernels where this patch won't
> apply cleanly. I can derive the values of N and M from the commit you
> mention above, but do you happen to know the actual culprit commit?
>=20
>=20

Unfortunately this bug goes back to the initial 2.6.12 import into git.
I didn't look earlier.=C2=A0Note that nfsd is not alone here. Ignoring the
result of proc_create_data() is very common.

If you want to drop the Fixes: tag, and add the Cc: stable instead,
then that's fine with me. Whatever works best.


> > ---
> >  fs/nfsd/nfsctl.c | 9 ++++++++-
> >  fs/nfsd/stats.c  | 4 ++--
> >  fs/nfsd/stats.h  | 2 +-
> >  3 files changed, 11 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 95ea4393305bd38493b640fbaba2e8f57f5a501d..583eda0df54dca394de4bbe=
8d148be2892df39cb 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -2204,8 +2204,14 @@ static __net_init int nfsd_net_init(struct net *=
net)
> >  					  NFSD_STATS_COUNTERS_NUM);
> >  	if (retval)
> >  		goto out_repcache_error;
> > +
> >  	memset(&nn->nfsd_svcstats, 0, sizeof(nn->nfsd_svcstats));
> >  	nn->nfsd_svcstats.program =3D &nfsd_programs[0];
> > +	if (!nfsd_proc_stat_init(net)) {
> > +		retval =3D -ENOMEM;
> > +		goto out_proc_error;
> > +	}
> > +
> >  	for (i =3D 0; i < sizeof(nn->nfsd_versions); i++)
> >  		nn->nfsd_versions[i] =3D nfsd_support_version(i);
> >  	for (i =3D 0; i < sizeof(nn->nfsd4_minorversions); i++)
> > @@ -2215,12 +2221,13 @@ static __net_init int nfsd_net_init(struct net =
*net)
> >  	nfsd4_init_leases_net(nn);
> >  	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
> >  	seqlock_init(&nn->writeverf_lock);
> > -	nfsd_proc_stat_init(net);
> >  #if IS_ENABLED(CONFIG_NFS_LOCALIO)
> >  	INIT_LIST_HEAD(&nn->local_clients);
> >  #endif
> >  	return 0;
> > =20
> > +out_proc_error:
> > +	percpu_counter_destroy_many(nn->counter, NFSD_STATS_COUNTERS_NUM);
> >  out_repcache_error:
> >  	nfsd_idmap_shutdown(net);
> >  out_idmap_error:
> > diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
> > index bb22893f1157e4c159e123b6d8e25b8eab52e187..f7eaf95e20fc8758566f469=
c6c2de79119fea070 100644
> > --- a/fs/nfsd/stats.c
> > +++ b/fs/nfsd/stats.c
> > @@ -73,11 +73,11 @@ static int nfsd_show(struct seq_file *seq, void *v)
> > =20
> >  DEFINE_PROC_SHOW_ATTRIBUTE(nfsd);
> > =20
> > -void nfsd_proc_stat_init(struct net *net)
> > +struct proc_dir_entry *nfsd_proc_stat_init(struct net *net)
> >  {
> >  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > =20
> > -	svc_proc_register(net, &nn->nfsd_svcstats, &nfsd_proc_ops);
> > +	return svc_proc_register(net, &nn->nfsd_svcstats, &nfsd_proc_ops);
> >  }
> > =20
> >  void nfsd_proc_stat_shutdown(struct net *net)
> > diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
> > index 04aacb6c36e2576ba231ee481e3a3e9e9f255a61..e4efb0e4e56d467c13eaa5a=
1dd312c85dadeb4b8 100644
> > --- a/fs/nfsd/stats.h
> > +++ b/fs/nfsd/stats.h
> > @@ -10,7 +10,7 @@
> >  #include <uapi/linux/nfsd/stats.h>
> >  #include <linux/percpu_counter.h>
> > =20
> > -void nfsd_proc_stat_init(struct net *net);
> > +struct proc_dir_entry *nfsd_proc_stat_init(struct net *net);
> >  void nfsd_proc_stat_shutdown(struct net *net);
> > =20
> >  static inline void nfsd_stats_rc_hits_inc(struct nfsd_net *nn)
> >=20
> > ---
> > base-commit: ebbdc9429c39336a406b191cfe84bca2c12c2f73
> > change-id: 20250206-nfsd-fixes-8e61bdf66347
> >=20
> > Best regards,
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

