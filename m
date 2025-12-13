Return-Path: <linux-nfs+bounces-17083-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5F6CBB435
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Dec 2025 22:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D386530062E1
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Dec 2025 21:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CD61A2C0B;
	Sat, 13 Dec 2025 21:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBXMASTX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9534273F9;
	Sat, 13 Dec 2025 21:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765662445; cv=none; b=IbkAgHBR+/OjME5vpfTBX3z8DR2SYLMSEXNycUWNxgdpTNHYNBDCpKKuzir9KobyUK/lV5U9cB+IzIPC0ccE7d3IRBsoqbFDqCC5fa3l8Jvgzqgk1xWGpRxFNLJ1Si8Bn6Mm4Rp+PokUKGFrFUptvPQBA6MZpP+FKxKF5AD5qME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765662445; c=relaxed/simple;
	bh=o9wmk44jPKyQzAZEM9CFRG19A+667jzE35flShzjVAE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XEsYTMEMag9l2iWmaTFDGjD8Gz7WIxd/S+XGpyCRSxmuOH03mBZVDvduhiURSwg33nX2L30cKsFUihp5HdmHHr5mwcIwOubishLG3lP8djli4einWXbdSwyubVudQUZ0le6htxLvMXusJF2WE9Q3cV7n6g/VEt6n5tctLW3rgzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBXMASTX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BD3C4CEF7;
	Sat, 13 Dec 2025 21:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765662445;
	bh=o9wmk44jPKyQzAZEM9CFRG19A+667jzE35flShzjVAE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=NBXMASTXHpinf70hKk2wRYdKiFCaA4iLYZ7mLZVpbWIQEYLKYw6bDWiM2MCwrgxPa
	 rtWz6jAEhnWhDC0tH/wUxsU41qsVeyKk7sNhFf96yR1HFljqfCSIMDTqyTuI+0CisF
	 ndCKfF6B3/Sqov70ojG/dp/3+wRfd3KljXTBBHZFH6fqf0FHGc3GEiO7Z6O/VSBMsc
	 7l/YhTnGg2YVbdBhIDTZCX/H0Z0ySFfNdPfrz8Kq5OyLzEzBqAVpIadfNbPOeQbHnH
	 329ZqzwT9+WuHWWQVg9WnPxW3MOUF0pUkQUX7dVNwU0kt4ZCGf5DYQDCR8ZQbwERNw
	 pJ+5zT31sl3vg==
Message-ID: <fb148cf880aac410bf487a40a458acfe6a257a84.camel@kernel.org>
Subject: Re: [PATCH RFC 6/6] nfsd: add controls to set the minimum number of
 threads per pool
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <cel@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai
 Ngo <Dai.Ngo@oracle.com>,  Tom Talpey <tom@talpey.com>, Trond Myklebust
 <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 14 Dec 2025 06:47:21 +0900
In-Reply-To: <476dcf18-242c-40b2-8afa-ca2128fe4895@app.fastmail.com>
References: <20251213-nfsd-dynathread-v1-0-de755e59cbc4@kernel.org>
	 <20251213-nfsd-dynathread-v1-6-de755e59cbc4@kernel.org>
	 <476dcf18-242c-40b2-8afa-ca2128fe4895@app.fastmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-12-13 at 16:10 -0500, Chuck Lever wrote:
>=20
> On Fri, Dec 12, 2025, at 5:39 PM, Jeff Layton wrote:
> > Add a new "min_threads" variable to the nfsd_net, along with the
> > corresponding nfsdfs and netlink interfaces to set that value from
> > userland. Pass that value to svc_set_pool_threads() and
> > svc_set_num_threads().
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  Documentation/netlink/specs/nfsd.yaml |  5 ++++
> >  fs/nfsd/netlink.c                     |  5 ++--
> >  fs/nfsd/netns.h                       |  6 +++++
> >  fs/nfsd/nfsctl.c                      | 50 +++++++++++++++++++++++++++=
++++++++
> >  fs/nfsd/nfssvc.c                      |  8 +++---
> >  fs/nfsd/trace.h                       | 19 +++++++++++++
> >  include/uapi/linux/nfsd_netlink.h     |  1 +
> >  7 files changed, 88 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/Documentation/netlink/specs/nfsd.yaml=20
> > b/Documentation/netlink/specs/nfsd.yaml
> > index=20
> > 100363029e82aed87295e34a008ab771a95d508c..badb2fe57c9859c6932c621a589da=
694782b0272=20
> > 100644
> > --- a/Documentation/netlink/specs/nfsd.yaml
> > +++ b/Documentation/netlink/specs/nfsd.yaml
> > @@ -78,6 +78,9 @@ attribute-sets:
> >        -
> >          name: scope
> >          type: string
> > +      -
> > +        name: min-threads
> > +        type: u32
> >    -
> >      name: version
> >      attributes:
> > @@ -159,6 +162,7 @@ operations:
> >              - gracetime
> >              - leasetime
> >              - scope
> > +            - min-threads
> >      -
> >        name: threads-get
> >        doc: get the number of running threads
> > @@ -170,6 +174,7 @@ operations:
> >              - gracetime
> >              - leasetime
> >              - scope
> > +            - min-threads
> >      -
> >        name: version-set
> >        doc: set nfs enabled versions
> > diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
> > index=20
> > ac51a44e1065ec3f1d88165f70a831a828b58394..887525964451e640304371e33aa4f=
415b4ff2848=20
> > 100644
> > --- a/fs/nfsd/netlink.c
> > +++ b/fs/nfsd/netlink.c
> > @@ -24,11 +24,12 @@ const struct nla_policy=20
> > nfsd_version_nl_policy[NFSD_A_VERSION_ENABLED + 1] =3D {
> >  };
> >=20
> >  /* NFSD_CMD_THREADS_SET - do */
> > -static const struct nla_policy=20
> > nfsd_threads_set_nl_policy[NFSD_A_SERVER_SCOPE + 1] =3D {
> > +static const struct nla_policy=20
> > nfsd_threads_set_nl_policy[NFSD_A_SERVER_MIN_THREADS + 1] =3D {
> >  	[NFSD_A_SERVER_THREADS] =3D { .type =3D NLA_U32, },
> >  	[NFSD_A_SERVER_GRACETIME] =3D { .type =3D NLA_U32, },
> >  	[NFSD_A_SERVER_LEASETIME] =3D { .type =3D NLA_U32, },
> >  	[NFSD_A_SERVER_SCOPE] =3D { .type =3D NLA_NUL_STRING, },
> > +	[NFSD_A_SERVER_MIN_THREADS] =3D { .type =3D NLA_U32, },
> >  };
> >=20
> >  /* NFSD_CMD_VERSION_SET - do */
> > @@ -57,7 +58,7 @@ static const struct genl_split_ops nfsd_nl_ops[] =3D =
{
> >  		.cmd		=3D NFSD_CMD_THREADS_SET,
> >  		.doit		=3D nfsd_nl_threads_set_doit,
> >  		.policy		=3D nfsd_threads_set_nl_policy,
> > -		.maxattr	=3D NFSD_A_SERVER_SCOPE,
> > +		.maxattr	=3D NFSD_A_SERVER_MIN_THREADS,
> >  		.flags		=3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> >  	},
> >  	{
> > diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> > index=20
> > 3e2d0fde80a7ce434ef2cce9f1666c2bd16ab2eb..1c3449810eaefea8167ddd284af7b=
d66cac7e211=20
> > 100644
> > --- a/fs/nfsd/netns.h
> > +++ b/fs/nfsd/netns.h
> > @@ -128,6 +128,12 @@ struct nfsd_net {
> >  	seqlock_t writeverf_lock;
> >  	unsigned char writeverf[8];
> >=20
> > +	/*
> > +	 * Minimum number of threads to run per pool.  If 0 then the
> > +	 * min =3D=3D max requested number of threads.
> > +	 */
> > +	unsigned int min_threads;
> > +
> >  	u32 clientid_base;
> >  	u32 clientid_counter;
> >  	u32 clverifier_counter;
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index=20
> > 206534fccf36a992026669fee6533adff1062c36..a5401015e62499d07150cde8822f1=
e7dd0515dfe=20
> > 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -48,6 +48,7 @@ enum {
> >  	NFSD_Versions,
> >  	NFSD_Ports,
> >  	NFSD_MaxBlkSize,
> > +	NFSD_MinThreads,
> >  	NFSD_Filecache,
> >  	NFSD_Leasetime,
> >  	NFSD_Gracetime,
> > @@ -67,6 +68,7 @@ static ssize_t write_pool_threads(struct file *file,=
=20
> > char *buf, size_t size);
> >  static ssize_t write_versions(struct file *file, char *buf, size_t=20
> > size);
> >  static ssize_t write_ports(struct file *file, char *buf, size_t size);
> >  static ssize_t write_maxblksize(struct file *file, char *buf, size_t=
=20
> > size);
> > +static ssize_t write_minthreads(struct file *file, char *buf, size_t=
=20
> > size);
> >  #ifdef CONFIG_NFSD_V4
> >  static ssize_t write_leasetime(struct file *file, char *buf, size_t=
=20
> > size);
> >  static ssize_t write_gracetime(struct file *file, char *buf, size_t=
=20
> > size);
> > @@ -85,6 +87,7 @@ static ssize_t (*const write_op[])(struct file *,=20
> > char *, size_t) =3D {
> >  	[NFSD_Versions] =3D write_versions,
> >  	[NFSD_Ports] =3D write_ports,
> >  	[NFSD_MaxBlkSize] =3D write_maxblksize,
> > +	[NFSD_MinThreads] =3D write_minthreads,
> >  #ifdef CONFIG_NFSD_V4
> >  	[NFSD_Leasetime] =3D write_leasetime,
> >  	[NFSD_Gracetime] =3D write_gracetime,
> > @@ -899,6 +902,46 @@ static ssize_t write_maxblksize(struct file *file,=
=20
> > char *buf, size_t size)
> >  							nfsd_max_blksize);
> >  }
> >=20
> > +/*
> > + * write_minthreads - Set or report the current min number of threads
> > + *
> > + * Input:
> > + *			buf:		ignored
> > + *			size:		zero
> > + * OR
> > + *
> > + * Input:
> > + *			buf:		C string containing an unsigned
> > + *					integer value representing the new
> > + *					max number of threads
>=20
> s/max number of threads/min number of threads
>=20

Will fix.

>=20
> > + *			size:		non-zero length of C string in @buf
> > + * Output:
> > + *	On success:	passed-in buffer filled with '\n'-terminated C string
> > + *			containing numeric value of min_threads setting
> > + *			for this net namespace;
> > + *			return code is the size in bytes of the string
> > + *	On error:	return code is zero or a negative errno value
> > + */
> > +static ssize_t write_minthreads(struct file *file, char *buf, size_t=
=20
> > size)
> > +{
> > +	char *mesg =3D buf;
> > +	struct nfsd_net *nn =3D net_generic(netns(file), nfsd_net_id);
> > +	unsigned int minthreads =3D nn->min_threads;
> > +
> > +	if (size > 0) {
>=20
> What if @size is a very large number?
>=20

Then it'll basically be ignored and you'll get a static "threads" count
of threads.

>=20
> > +		int rv =3D get_uint(&mesg, &minthreads);
> > +
> > +		if (rv)
> > +			return rv;
> > +		trace_nfsd_ctl_minthreads(netns(file), minthreads);
> > +		mutex_lock(&nfsd_mutex);
> > +		nn->min_threads =3D minthreads;
> > +		mutex_unlock(&nfsd_mutex);
> > +	}
> > +
> > +	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%u\n", minthreads);
> > +}
> > +
> >  #ifdef CONFIG_NFSD_V4
> >  static ssize_t __nfsd4_write_time(struct file *file, char *buf, size_t=
=20
> > size,
> >  				  time64_t *time, struct nfsd_net *nn)
> > @@ -1292,6 +1335,7 @@ static int nfsd_fill_super(struct super_block=20
> > *sb, struct fs_context *fc)
> >  		[NFSD_Versions] =3D {"versions", &transaction_ops, S_IWUSR|S_IRUSR},
> >  		[NFSD_Ports] =3D {"portlist", &transaction_ops, S_IWUSR|S_IRUGO},
> >  		[NFSD_MaxBlkSize] =3D {"max_block_size", &transaction_ops,=20
> > S_IWUSR|S_IRUGO},
> > +		[NFSD_MinThreads] =3D {"min_threads", &transaction_ops,=20
> > S_IWUSR|S_IRUGO},
> >  		[NFSD_Filecache] =3D {"filecache", &nfsd_file_cache_stats_fops,=20
> > S_IRUGO},
> >  #ifdef CONFIG_NFSD_V4
> >  		[NFSD_Leasetime] =3D {"nfsv4leasetime", &transaction_ops,=20
> > S_IWUSR|S_IRUSR},
> > @@ -1636,6 +1680,10 @@ int nfsd_nl_threads_set_doit(struct sk_buff=20
> > *skb, struct genl_info *info)
> >  			scope =3D nla_data(attr);
> >  	}
> >=20
> > +	attr =3D info->attrs[NFSD_A_SERVER_MIN_THREADS];
> > +	if (attr)
> > +		nn->min_threads =3D nla_get_u32(attr);
> > +
> >  	ret =3D nfsd_svc(nrpools, nthreads, net, get_current_cred(), scope);
> >  	if (ret > 0)
> >  		ret =3D 0;
> > @@ -1675,6 +1723,8 @@ int nfsd_nl_threads_get_doit(struct sk_buff *skb,=
=20
> > struct genl_info *info)
> >  			  nn->nfsd4_grace) ||
> >  	      nla_put_u32(skb, NFSD_A_SERVER_LEASETIME,
> >  			  nn->nfsd4_lease) ||
> > +	      nla_put_u32(skb, NFSD_A_SERVER_MIN_THREADS,
> > +			  nn->min_threads) ||
> >  	      nla_put_string(skb, NFSD_A_SERVER_SCOPE,
> >  			  nn->nfsd_name);
> >  	if (err)
> > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > index=20
> > 26c3a6cb1f400f1b757d26f6ba77e27deb7e8ee2..d6120dd843ac1b6a42f0ef331700f=
4d6d70d8c38=20
> > 100644
> > --- a/fs/nfsd/nfssvc.c
> > +++ b/fs/nfsd/nfssvc.c
> > @@ -594,7 +594,7 @@ void nfsd_shutdown_threads(struct net *net)
> >  	}
> >=20
> >  	/* Kill outstanding nfsd threads */
> > -	svc_set_num_threads(serv, 0, 0);
> > +	svc_set_num_threads(serv, 0, nn->min_threads);
>=20
> Seems like this could actually /start/ threads during NFSD shutdown.
> At the very least it needs an explanatory comment.
>=20

I can add a comment, but if min-threads > threads, then min-threads
will have no effect.

>=20
> >  	nfsd_destroy_serv(net);
> >  	mutex_unlock(&nfsd_mutex);
> >  }
> > @@ -704,7 +704,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct=
=20
> > net *net)
> >=20
> >  	/* Special case: When n =3D=3D 1, distribute threads equally among po=
ols. */
> >  	if (n =3D=3D 1)
> > -		return svc_set_num_threads(nn->nfsd_serv, nthreads[0], 0);
> > +		return svc_set_num_threads(nn->nfsd_serv, nthreads[0], nn->min_threa=
ds);
> >=20
> >  	if (n > nn->nfsd_serv->sv_nrpools)
> >  		n =3D nn->nfsd_serv->sv_nrpools;
> > @@ -732,7 +732,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct=
=20
> > net *net)
> >  	for (i =3D 0; i < n; i++) {
> >  		err =3D svc_set_pool_threads(nn->nfsd_serv,
> >  					   &nn->nfsd_serv->sv_pools[i],
> > -					   nthreads[i], 0);
> > +					   nthreads[i], nn->min_threads);
> >  		if (err)
> >  			goto out;
> >  	}
> > @@ -741,7 +741,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct=
=20
> > net *net)
> >  	for (i =3D n; i < nn->nfsd_serv->sv_nrpools; ++i) {
> >  		err =3D svc_set_pool_threads(nn->nfsd_serv,
> >  					   &nn->nfsd_serv->sv_pools[i],
> > -					   0, 0);
> > +					   0, nn->min_threads);
> >  		if (err)
> >  			goto out;
> >  	}
> > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > index=20
> > 8885fd9bead98ebf55379d68ab9c3701981a5150..d1d0b0dd054588a8c20e3386356df=
a4e9632b8e0=20
> > 100644
> > --- a/fs/nfsd/trace.h
> > +++ b/fs/nfsd/trace.h
> > @@ -2164,6 +2164,25 @@ TRACE_EVENT(nfsd_ctl_maxblksize,
> >  	)
> >  );
> >=20
> > +TRACE_EVENT(nfsd_ctl_minthreads,
> > +	TP_PROTO(
> > +		const struct net *net,
> > +		int minthreads
> > +	),
> > +	TP_ARGS(net, minthreads),
> > +	TP_STRUCT__entry(
> > +		__field(unsigned int, netns_ino)
> > +		__field(int, minthreads)
> > +	),
> > +	TP_fast_assign(
> > +		__entry->netns_ino =3D net->ns.inum;
> > +		__entry->minthreads =3D minthreads
> > +	),
> > +	TP_printk("minthreads=3D%d",
> > +		__entry->minthreads
> > +	)
> > +);
> > +
> >  TRACE_EVENT(nfsd_ctl_time,
> >  	TP_PROTO(
> >  		const struct net *net,
> > diff --git a/include/uapi/linux/nfsd_netlink.h=20
> > b/include/uapi/linux/nfsd_netlink.h
> > index=20
> > e157e2009ea8c1ef805301261d536c82677821ef..e9efbc9e63d83ed25fcd790b7a877=
c0023638f15=20
> > 100644
> > --- a/include/uapi/linux/nfsd_netlink.h
> > +++ b/include/uapi/linux/nfsd_netlink.h
> > @@ -35,6 +35,7 @@ enum {
> >  	NFSD_A_SERVER_GRACETIME,
> >  	NFSD_A_SERVER_LEASETIME,
> >  	NFSD_A_SERVER_SCOPE,
> > +	NFSD_A_SERVER_MIN_THREADS,
> >=20
> >  	__NFSD_A_SERVER_MAX,
> >  	NFSD_A_SERVER_MAX =3D (__NFSD_A_SERVER_MAX - 1)
> >=20
> > --=20
> > 2.52.0
>=20
> Thanks, Neil and Jeff, for pulling all this together. It's good to
> have something we can noodle on now.
>=20

Definitely. Neil's patches were a great start to this.
--=20
Jeff Layton <jlayton@kernel.org>

