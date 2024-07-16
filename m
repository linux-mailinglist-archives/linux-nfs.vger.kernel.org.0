Return-Path: <linux-nfs+bounces-4946-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B5E93248C
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jul 2024 13:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E7A9B22558
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jul 2024 11:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F0813D8B6;
	Tue, 16 Jul 2024 11:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBFDmLP3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB1D3DBB7
	for <linux-nfs@vger.kernel.org>; Tue, 16 Jul 2024 11:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721127657; cv=none; b=M91/juMk2i/54HpvTnZVwNvQMRmx2VXxgxi/+Yn+jVcISd+v0pC3yZN5hALzDRVkUiev7Yk57FWAvkP6/stwlkvYgT9TxWb3iLOPkr1wlIZRYjApWW9QmslMOyCGMCrMG/1z/ESLo8bcq+3U4ej+HA8APyhQprM8hXg1ZJcXSrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721127657; c=relaxed/simple;
	bh=9QVyTp2LRNGTR/4nZfKUHwhdq0+VjiNLYWFnRoZcBbo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c9wrmGPCMqWLyTRzefc8R02TpPHwiWO2V080hzKdoLKXpAbn2p5VZwSGBErRNr5Uj4tv0RjBGdBLpM5OlAZEKMBbs733ptpmSums04MVP8zA66xUmb/BIGpwUKxyUH3LDZXNRTZ//fGPhbtbmOu7ezhvZf5QACKnoTnGOMgRqQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBFDmLP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B3FC116B1;
	Tue, 16 Jul 2024 11:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721127657;
	bh=9QVyTp2LRNGTR/4nZfKUHwhdq0+VjiNLYWFnRoZcBbo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=QBFDmLP3VLTt/f20IYje+7P90MzHKBwzjqUimyFQC7/N5EHseqgAYafCnOmtrqouR
	 07AWWKUAW0U17mvkH0eQVGJBhGFyW3shXMjPfiDcBurhcgTkuWjDE9M2ZXaw00kZdM
	 wV9npS0nY5vUBF6X18NwoAEwO63NZTcNRxobM4YZpANxoU9MkQDprH8CpsvCFkgu2F
	 q+tTFlpIftpvc0NR363IPcG5/0WVWQ2kOHl/qzodELDn+Plr1bQtMdkikNNBwzEI3S
	 Mg6zbE+MiE//o+EbLuTtFoYiJBhTL3OpPvNi1x/BYWwtsG5poXtWwXMoskngVDCfDX
	 kTFk4HtjQ68ow==
Message-ID: <27b282045253419857b67f3240ab8ec5f585cf40.camel@kernel.org>
Subject: Re: [PATCH 13/14] nfsd: introduce concept of a maximum number of
 threads.
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, Olga
 Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>, Steve Dickson <steved@redhat.com>
Date: Tue, 16 Jul 2024 07:00:55 -0400
In-Reply-To: <172110007383.15471.14744199179662433209@noble.neil.brown.name>
References: <>, <f12bdd8dde21de4473d38fada67b60ef5883e8dc.camel@kernel.org>
	 <172110007383.15471.14744199179662433209@noble.neil.brown.name>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40app2) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-16 at 13:21 +1000, NeilBrown wrote:
> On Tue, 16 Jul 2024, Jeff Layton wrote:
> > On Mon, 2024-07-15 at 17:14 +1000, NeilBrown wrote:
> > > A future patch will allow the number of threads in each nfsd pool to
> > > vary dynamically.
> > > The lower bound will be the number explicit requested via
> > > /proc/fs/nfsd/threads or /proc/fs/nfsd/pool_threads
> > >=20
> > > The upper bound can be set in each net-namespace by writing
> > > /proc/fs/nfsd/max_threads.=C2=A0 This upper bound applies across all =
pools,
> > > there is no per-pool upper limit.
> > >=20
> > > If no upper bound is set, then one is calculated.=C2=A0 A global uppe=
r limit
> > > is chosen based on amount of memory.=C2=A0 This limit only affects dy=
namic
> > > changes. Static configuration can always over-ride it.
> > >=20
> > > We track how many threads are configured in each net namespace, with =
the
> > > max or the min.=C2=A0 We also track how many net namespaces have nfsd
> > > configured with only a min, not a max.
> > >=20
> > > The difference between the calculated max and the total allocation is
> > > available to be shared among those namespaces which don't have a maxi=
mum
> > > configured.=C2=A0 Within a namespace, the available share is distribu=
ted
> > > equally across all pools.
> > >=20
> > > In the common case there is one namespace and one pool.=C2=A0 A small=
 number
> > > of threads are configured as a minimum and no maximum is set.=C2=A0 I=
n this
> > > case the effective maximum will be directly based on total memory.
> > > Approximately 8 per gigabyte.
> > >=20
> >=20
> >=20
> > Some of this may come across as bikeshedding, but I'd probably prefer
> > that this work a bit differently:
> >=20
> > 1/ I don't think we should enable this universally -- at least not
> > initially. What I'd prefer to see is a new pool_mode for the dynamic
> > threadpools (maybe call it "dynamic"). That gives us a clear opt-in
> > mechanism. Later once we're convinced it's safe, we can make "dynamic"
> > the default instead of "global".
> >=20
> > 2/ Rather than specifying a max_threads value separately, why not allow
> > the old threads/pool_threads interface to set the max and just have a
> > reasonable minimum setting (like the current default of 8). Since we're
> > growing the threadpool dynamically, I don't see why we need to have a
> > real configurable minimum.
> >=20
> > 3/ the dynamic pool-mode should probably be layered on top of the
> > pernode pool mode. IOW, in a NUMA configuration, we should split the
> > threads across NUMA nodes.
>=20
> Maybe we should start by discussing the goal.  What do we want
> configuration to look like when we finish?
>=20
> I think we want it to be transparent.  Sysadmin does nothing, and it all
> works perfectly.  Or as close to that as we can get.
>=20

That's a nice eventual goal, but what do we do if we make this change
and it's not behaving for them? We need some way for them to revert to
traditional behavior if the new mode isn't working well.

> So I think the "nproc" option to rpc.nfsd should eventually be ignored
> except for whether it is zero or non-zero.  If it is non-zero we start 1
> thread on each NUMA node and let that grow with limits imposed primarily
> by memory pressure.
>=20
> We should probably change
>=20
> #define SVC_POOL_DEFAULT	SVC_POOL_GLOBAL
>=20
> to
>=20
> #define SVC_POOL_DEFAULT	SVC_POOL_AUTO
>=20
> about 10 years ago, but failing that, maybe change it tomorrow?
>=20

At this point, I wouldn't change the defaults until we're ready to make
dynamic mode the default.

> I'm not sure how
>     /proc/fs/nfsd/{threads,pool_threads}
> should be handled.=C2=A0
>=20

Technically, I'm fine with _not_ handling them here. We do have the new
netlink interfaces that are better suited for this. We could make the
opt-in for dynamic mode contingent on using that somehow.

> Like you I don't think it is really useful to have
> a configured minimum but I don't want them to be imposed as a maximum
> because I want servers with the current default (of 8) to be able to
> start more new threads if necessary without needing a config change.
> Maybe that outcome can be delayed until rpc.nfsd is updated?
>=20

That's a bit too aggressive for my tastes. I really do think we need to
allow people to opt-in for this at first. Once we've grown comfortable
with how it all works, we can consider changing the default then.

> I don't really like the idea of a dynamic pool mode.  I want the pool to
> *always* be dynamic.
>=20
>=20

I think that's a good eventual goal, but I think we need to proceed
with caution. Given that this is all based around heuristics, we'll
need a way for people to revert to more traditional behavior if it's
not working well for them. Making this into a pool-mode and allowing
people to opt-in initially seems like a simple way to do that.

I am fine with eventually discarding the pool-mode settings altogether
if we get dynamic mode working well enough. I'd just prefer a more
incremental approach to getting there.

>=20
> >=20
> >=20
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > ---
> > > =C2=A0fs/nfsd/netns.h=C2=A0 |=C2=A0 6 +++++
> > > =C2=A0fs/nfsd/nfsctl.c | 45 +++++++++++++++++++++++++++++++++++
> > > =C2=A0fs/nfsd/nfsd.h=C2=A0=C2=A0 |=C2=A0 4 ++++
> > > =C2=A0fs/nfsd/nfssvc.c | 61 +++++++++++++++++++++++++++++++++++++++++=
+++++++
> > > =C2=A0fs/nfsd/trace.h=C2=A0 | 19 +++++++++++++++
> > > =C2=A05 files changed, 135 insertions(+)
> > >=20
> > > diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> > > index 0d2ac15a5003..329484696a42 100644
> > > --- a/fs/nfsd/netns.h
> > > +++ b/fs/nfsd/netns.h
> > > @@ -133,6 +133,12 @@ struct nfsd_net {
> > > =C2=A0	 */
> > > =C2=A0	unsigned int max_connections;
> > > =C2=A0
> > > +	/*
> > > +	 * Maximum number of threads to auto-adjust up to.=C2=A0 If 0 then =
a
> > > +	 * share of nfsd_max_threads will be used.
> > > +	 */
> > > +	unsigned int max_threads;
> > > +
> > > =C2=A0	u32 clientid_base;
> > > =C2=A0	u32 clientid_counter;
> > > =C2=A0	u32 clverifier_counter;
> > > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > > index d85b6d1fa31f..37e9936567e9 100644
> > > --- a/fs/nfsd/nfsctl.c
> > > +++ b/fs/nfsd/nfsctl.c
> > > @@ -48,6 +48,7 @@ enum {
> > > =C2=A0	NFSD_Ports,
> > > =C2=A0	NFSD_MaxBlkSize,
> > > =C2=A0	NFSD_MaxConnections,
> > > +	NFSD_MaxThreads,
> > > =C2=A0	NFSD_Filecache,
> > > =C2=A0	NFSD_Leasetime,
> > > =C2=A0	NFSD_Gracetime,
> > > @@ -68,6 +69,7 @@ static ssize_t write_versions(struct file *file, ch=
ar *buf, size_t size);
> > > =C2=A0static ssize_t write_ports(struct file *file, char *buf, size_t=
 size);
> > > =C2=A0static ssize_t write_maxblksize(struct file *file, char *buf, s=
ize_t size);
> > > =C2=A0static ssize_t write_maxconn(struct file *file, char *buf, size=
_t size);
> > > +static ssize_t write_maxthreads(struct file *file, char *buf, size_t=
 size);
> > > =C2=A0#ifdef CONFIG_NFSD_V4
> > > =C2=A0static ssize_t write_leasetime(struct file *file, char *buf, si=
ze_t size);
> > > =C2=A0static ssize_t write_gracetime(struct file *file, char *buf, si=
ze_t size);
> > > @@ -87,6 +89,7 @@ static ssize_t (*const write_op[])(struct file *, c=
har *, size_t) =3D {
> > > =C2=A0	[NFSD_Ports] =3D write_ports,
> > > =C2=A0	[NFSD_MaxBlkSize] =3D write_maxblksize,
> > > =C2=A0	[NFSD_MaxConnections] =3D write_maxconn,
> > > +	[NFSD_MaxThreads] =3D write_maxthreads,
> > > =C2=A0#ifdef CONFIG_NFSD_V4
> > > =C2=A0	[NFSD_Leasetime] =3D write_leasetime,
> > > =C2=A0	[NFSD_Gracetime] =3D write_gracetime,
> > > @@ -939,6 +942,47 @@ static ssize_t write_maxconn(struct file *file, =
char *buf, size_t size)
> > > =C2=A0	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%u\n", maxcon=
n);
> > > =C2=A0}
> > > =C2=A0
> > > +/*
> > > + * write_maxthreads - Set or report the current max number threads
> > > + *
> > > + * Input:
> > > + *			buf:		ignored
> > > + *			size:		zero
> > > + * OR
> > > + *
> > > + * Input:
> > > + *			buf:		C string containing an unsigned
> > > + *					integer value representing the new
> > > + *					max number of threads
> > > + *			size:		non-zero length of C string in @buf
> > > + * Output:
> > > + *	On success:	passed-in buffer filled with '\n'-terminated C string
> > > + *			containing numeric value of max_threads setting
> > > + *			for this net namespace;
> > > + *			return code is the size in bytes of the string
> > > + *	On error:	return code is zero or a negative errno value
> > > + */
> > > +static ssize_t write_maxthreads(struct file *file, char *buf, size_t=
 size)
> > > +{
> > > +	char *mesg =3D buf;
> > > +	struct nfsd_net *nn =3D net_generic(netns(file), nfsd_net_id);
> > > +	unsigned int maxthreads =3D nn->max_threads;
> > > +
> > > +	if (size > 0) {
> > > +		int rv =3D get_uint(&mesg, &maxthreads);
> > > +
> > > +		if (rv)
> > > +			return rv;
> > > +		trace_nfsd_ctl_maxthreads(netns(file), maxthreads);
> > > +		mutex_lock(&nfsd_mutex);
> > > +		nn->max_threads =3D maxthreads;
> > > +		nfsd_update_nets();
> > > +		mutex_unlock(&nfsd_mutex);
> > > +	}
> > > +
> > > +	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%u\n", maxthreads)=
;
> > > +}
> > > +
> > > =C2=A0#ifdef CONFIG_NFSD_V4
> > > =C2=A0static ssize_t __nfsd4_write_time(struct file *file, char *buf,=
 size_t size,
> > > =C2=A0				=C2=A0 time64_t *time, struct nfsd_net *nn)
> > > @@ -1372,6 +1416,7 @@ static int nfsd_fill_super(struct super_block *=
sb, struct fs_context *fc)
> > > =C2=A0		[NFSD_Ports] =3D {"portlist", &transaction_ops, S_IWUSR|S_IRU=
GO},
> > > =C2=A0		[NFSD_MaxBlkSize] =3D {"max_block_size", &transaction_ops, S_=
IWUSR|S_IRUGO},
> > > =C2=A0		[NFSD_MaxConnections] =3D {"max_connections", &transaction_op=
s, S_IWUSR|S_IRUGO},
> > > +		[NFSD_MaxThreads] =3D {"max_threads", &transaction_ops, S_IWUSR|S_=
IRUGO},
> > > =C2=A0		[NFSD_Filecache] =3D {"filecache", &nfsd_file_cache_stats_fop=
s, S_IRUGO},
> > > =C2=A0#ifdef CONFIG_NFSD_V4
> > > =C2=A0		[NFSD_Leasetime] =3D {"nfsv4leasetime", &transaction_ops, S_I=
WUSR|S_IRUSR},
> > > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > > index e4c643255dc9..6874c2de670b 100644
> > > --- a/fs/nfsd/nfsd.h
> > > +++ b/fs/nfsd/nfsd.h
> > > @@ -156,6 +156,10 @@ int nfsd_create_serv(struct net *net);
> > > =C2=A0void nfsd_destroy_serv(struct net *net);
> > > =C2=A0
> > > =C2=A0extern int nfsd_max_blksize;
> > > +void nfsd_update_nets(void);
> > > +extern unsigned int	nfsd_max_threads;
> > > +extern unsigned long	nfsd_net_used;
> > > +extern unsigned int	nfsd_net_cnt;
> > > =C2=A0
> > > =C2=A0static inline int nfsd_v4client(struct svc_rqst *rq)
> > > =C2=A0{
> > > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > > index b005b2e2e6ad..75d78c17756f 100644
> > > --- a/fs/nfsd/nfssvc.c
> > > +++ b/fs/nfsd/nfssvc.c
> > > @@ -80,6 +80,21 @@ DEFINE_SPINLOCK(nfsd_drc_lock);
> > > =C2=A0unsigned long	nfsd_drc_max_mem;
> > > =C2=A0unsigned long	nfsd_drc_slotsize_sum;
> > > =C2=A0
> > > +/*
> > > + * nfsd_max_threads is auto-configured based on available ram.
> > > + * Each network namespace can configure a minimum number of threads
> > > + * and optionally a maximum.
> > > + * nfsd_net_used is the number of the max or min from each net names=
pace.
> > > + * nfsd_new_cnt is the number of net namespaces with a configured mi=
nimum
> > > + *=C2=A0=C2=A0=C2=A0 but no configured maximum.
> > > + * When nfsd_max_threads exceeds nfsd_net_used, the different is div=
ided
> > > + * by nfsd_net_cnt and this number gives the excess above the config=
ured minimum
> > > + * for all net namespaces without a configured maximum.
> > > + */
> > > +unsigned int	nfsd_max_threads;
> > > +unsigned long	nfsd_net_used;
> > > +unsigned int	nfsd_net_cnt;
> > > +
> > > =C2=A0#if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
> > > =C2=A0static const struct svc_version *nfsd_acl_version[] =3D {
> > > =C2=A0# if defined(CONFIG_NFSD_V2_ACL)
> > > @@ -130,6 +145,47 @@ struct svc_program		nfsd_program =3D {
> > > =C2=A0	.pg_rpcbind_set		=3D nfsd_rpcbind_set,
> > > =C2=A0};
> > > =C2=A0
> > > +void nfsd_update_nets(void)
> > > +{
> > > +	struct net *net;
> > > +
> > > +	if (nfsd_max_threads =3D=3D 0) {
> > > +		nfsd_max_threads =3D (nr_free_buffer_pages() >> 7) /
> > > +			(NFSSVC_MAXBLKSIZE >> PAGE_SHIFT);
> > > +	}
> > > +	nfsd_net_used =3D 0;
> > > +	nfsd_net_cnt =3D 0;
> > > +	down_read(&net_rwsem);
> > > +	for_each_net(net) {
> > > +		struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > > +
> > > +		if (!nn->nfsd_serv)
> > > +			continue;
> > > +		if (nn->max_threads > 0) {
> > > +			nfsd_net_used +=3D nn->max_threads;
> > > +		} else {
> > > +			nfsd_net_used +=3D nn->nfsd_serv->sv_nrthreads;
> > > +			nfsd_net_cnt +=3D 1;
> > > +		}
> > > +	}
> > > +	up_read(&net_rwsem);
> > > +}
> > > +
> > > +static inline int nfsd_max_pool_threads(struct svc_pool *p, struct n=
fsd_net *nn)
> > > +{
> > > +	int svthreads =3D nn->nfsd_serv->sv_nrthreads;
> > > +
> > > +	if (nn->max_threads > 0)
> > > +		return nn->max_threads;
> > > +	if (nfsd_net_cnt =3D=3D 0 || svthreads =3D=3D 0)
> > > +		return 0;
> > > +	if (nfsd_max_threads < nfsd_net_cnt)
> > > +		return p->sp_nrthreads;
> > > +	/* Share nfsd_max_threads among all net, then among pools in this n=
et. */
> > > +	return p->sp_nrthreads +
> > > +		nfsd_max_threads / nfsd_net_cnt * p->sp_nrthreads / svthreads;
> > > +}
> > > +
> > > =C2=A0bool nfsd_support_version(int vers)
> > > =C2=A0{
> > > =C2=A0	if (vers >=3D NFSD_MINVERS && vers <=3D NFSD_MAXVERS)
> > > @@ -474,6 +530,7 @@ void nfsd_destroy_serv(struct net *net)
> > > =C2=A0	spin_lock(&nfsd_notifier_lock);
> > > =C2=A0	nn->nfsd_serv =3D NULL;
> > > =C2=A0	spin_unlock(&nfsd_notifier_lock);
> > > +	nfsd_update_nets();
> > > =C2=A0
> > > =C2=A0	/* check if the notifier still has clients */
> > > =C2=A0	if (atomic_dec_return(&nfsd_notifier_refcount) =3D=3D 0) {
> > > @@ -614,6 +671,8 @@ int nfsd_create_serv(struct net *net)
> > > =C2=A0	nn->nfsd_serv =3D serv;
> > > =C2=A0	spin_unlock(&nfsd_notifier_lock);
> > > =C2=A0
> > > +	nfsd_update_nets();
> > > +
> > > =C2=A0	set_max_drc();
> > > =C2=A0	/* check if the notifier is already set */
> > > =C2=A0	if (atomic_inc_return(&nfsd_notifier_refcount) =3D=3D 1) {
> > > @@ -720,6 +779,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, stru=
ct net *net)
> > > =C2=A0			goto out;
> > > =C2=A0	}
> > > =C2=A0out:
> > > +	nfsd_update_nets();
> > > =C2=A0	return err;
> > > =C2=A0}
> > > =C2=A0
> > > @@ -759,6 +819,7 @@ nfsd_svc(int n, int *nthreads, struct net *net, c=
onst struct cred *cred, const c
> > > =C2=A0	error =3D nfsd_set_nrthreads(n, nthreads, net);
> > > =C2=A0	if (error)
> > > =C2=A0		goto out_put;
> > > +	nfsd_update_nets();
> > > =C2=A0	error =3D serv->sv_nrthreads;
> > > =C2=A0out_put:
> > > =C2=A0	if (serv->sv_nrthreads =3D=3D 0)
> > > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > > index 77bbd23aa150..92b888e178e8 100644
> > > --- a/fs/nfsd/trace.h
> > > +++ b/fs/nfsd/trace.h
> > > @@ -2054,6 +2054,25 @@ TRACE_EVENT(nfsd_ctl_maxconn,
> > > =C2=A0	)
> > > =C2=A0);
> > > =C2=A0
> > > +TRACE_EVENT(nfsd_ctl_maxthreads,
> > > +	TP_PROTO(
> > > +		const struct net *net,
> > > +		int maxthreads
> > > +	),
> > > +	TP_ARGS(net, maxthreads),
> > > +	TP_STRUCT__entry(
> > > +		__field(unsigned int, netns_ino)
> > > +		__field(int, maxthreads)
> > > +	),
> > > +	TP_fast_assign(
> > > +		__entry->netns_ino =3D net->ns.inum;
> > > +		__entry->maxthreads =3D maxthreads
> > > +	),
> > > +	TP_printk("maxthreads=3D%d",
> > > +		__entry->maxthreads
> > > +	)
> > > +);
> > > +
> > > =C2=A0TRACE_EVENT(nfsd_ctl_time,
> > > =C2=A0	TP_PROTO(
> > > =C2=A0		const struct net *net,
> >=20
> > --=20
> > Jeff Layton <jlayton@kernel.org>
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

