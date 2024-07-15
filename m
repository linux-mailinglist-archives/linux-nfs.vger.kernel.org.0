Return-Path: <linux-nfs+bounces-4931-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C1A9318F1
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 19:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 461CFB2152C
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 17:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBC02C181;
	Mon, 15 Jul 2024 17:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdfikzQT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085DD23749
	for <linux-nfs@vger.kernel.org>; Mon, 15 Jul 2024 17:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721063202; cv=none; b=R5VUN3re6hFPoe1RJW7KjPqM9PVJkwZd5lpDz7zSxL+XYMe21qGeCfhxM1mSVtlYpcPYFoiCLkP7rzSjvq2XE7jcSjodTI6XK8i9l6gMzJ1W8+qywF0Q87DZn3hChFccjPHiEyulUBRFdDSxYbRCRnApR0HtQiq+Bv2HX96Z/us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721063202; c=relaxed/simple;
	bh=7+mw9uLJzt+UuXkSiebUN+nqO0A3GDA3X3LaTwWAwV0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UUbIUtKMeEmC2FE1Vf2328mLy5R8oGf25GkHgVsc19x05QZsYvoibW197gD82rJ40Htn+izqZc8UrmFyDGF6IAlvtPGqYaxiA+FcfcAXlN6snDa6aUynbZT1x68fGF/h3CikiOfTSLVqADl3emf/qzIKWkCixNzPQDUHq0qXq3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdfikzQT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2642C32782;
	Mon, 15 Jul 2024 17:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721063201;
	bh=7+mw9uLJzt+UuXkSiebUN+nqO0A3GDA3X3LaTwWAwV0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=VdfikzQTyDM1IC29qzG/euJQtRCRK5wNsSV6FCO6N/5YT9R6/eBPO3RxaycRIDE8R
	 +U3yhnsxpJITtNy2JPww+Jf/W2AH2Sf6OTHxYBcqG94hg1HUrA8kJU4h2Vk51A2yYR
	 7n1+wSYm7KnxNtTNUn43c56Jfcgp35myZjwrq9aHFqG8PMDlET9KqtDq1Nxx5XN3XM
	 t5GGN97gAsC5iu+ZyIfp/XvM/PrDre4rmBjllPzLnaaTcHex8HVpyxg4fi0R9L7h39
	 ZznFCNtdwCxuyQWBqGtuphadLVZd7YlDmzPsX+Itnk/CNZ/lM1vSWSjDorBY2khArL
	 CZWui/lOk8iNQ==
Message-ID: <f12bdd8dde21de4473d38fada67b60ef5883e8dc.camel@kernel.org>
Subject: Re: [PATCH 13/14] nfsd: introduce concept of a maximum number of
 threads.
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
	 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Steve Dickson
	 <steved@redhat.com>
Date: Mon, 15 Jul 2024 13:06:39 -0400
In-Reply-To: <20240715074657.18174-14-neilb@suse.de>
References: <20240715074657.18174-1-neilb@suse.de>
	 <20240715074657.18174-14-neilb@suse.de>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-15 at 17:14 +1000, NeilBrown wrote:
> A future patch will allow the number of threads in each nfsd pool to
> vary dynamically.
> The lower bound will be the number explicit requested via
> /proc/fs/nfsd/threads or /proc/fs/nfsd/pool_threads
>=20
> The upper bound can be set in each net-namespace by writing
> /proc/fs/nfsd/max_threads.=C2=A0 This upper bound applies across all pool=
s,
> there is no per-pool upper limit.
>=20
> If no upper bound is set, then one is calculated.=C2=A0 A global upper li=
mit
> is chosen based on amount of memory.=C2=A0 This limit only affects dynami=
c
> changes. Static configuration can always over-ride it.
>=20
> We track how many threads are configured in each net namespace, with the
> max or the min.=C2=A0 We also track how many net namespaces have nfsd
> configured with only a min, not a max.
>=20
> The difference between the calculated max and the total allocation is
> available to be shared among those namespaces which don't have a maximum
> configured.=C2=A0 Within a namespace, the available share is distributed
> equally across all pools.
>=20
> In the common case there is one namespace and one pool.=C2=A0 A small num=
ber
> of threads are configured as a minimum and no maximum is set.=C2=A0 In th=
is
> case the effective maximum will be directly based on total memory.
> Approximately 8 per gigabyte.
>=20


Some of this may come across as bikeshedding, but I'd probably prefer
that this work a bit differently:

1/ I don't think we should enable this universally -- at least not
initially. What I'd prefer to see is a new pool_mode for the dynamic
threadpools (maybe call it "dynamic"). That gives us a clear opt-in
mechanism. Later once we're convinced it's safe, we can make "dynamic"
the default instead of "global".

2/ Rather than specifying a max_threads value separately, why not allow
the old threads/pool_threads interface to set the max and just have a
reasonable minimum setting (like the current default of 8). Since we're
growing the threadpool dynamically, I don't see why we need to have a
real configurable minimum.

3/ the dynamic pool-mode should probably be layered on top of the
pernode pool mode. IOW, in a NUMA configuration, we should split the
threads across NUMA nodes.


> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> =C2=A0fs/nfsd/netns.h=C2=A0 |=C2=A0 6 +++++
> =C2=A0fs/nfsd/nfsctl.c | 45 +++++++++++++++++++++++++++++++++++
> =C2=A0fs/nfsd/nfsd.h=C2=A0=C2=A0 |=C2=A0 4 ++++
> =C2=A0fs/nfsd/nfssvc.c | 61 +++++++++++++++++++++++++++++++++++++++++++++=
+++
> =C2=A0fs/nfsd/trace.h=C2=A0 | 19 +++++++++++++++
> =C2=A05 files changed, 135 insertions(+)
>=20
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index 0d2ac15a5003..329484696a42 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -133,6 +133,12 @@ struct nfsd_net {
> =C2=A0	 */
> =C2=A0	unsigned int max_connections;
> =C2=A0
> +	/*
> +	 * Maximum number of threads to auto-adjust up to.=C2=A0 If 0 then a
> +	 * share of nfsd_max_threads will be used.
> +	 */
> +	unsigned int max_threads;
> +
> =C2=A0	u32 clientid_base;
> =C2=A0	u32 clientid_counter;
> =C2=A0	u32 clverifier_counter;
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index d85b6d1fa31f..37e9936567e9 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -48,6 +48,7 @@ enum {
> =C2=A0	NFSD_Ports,
> =C2=A0	NFSD_MaxBlkSize,
> =C2=A0	NFSD_MaxConnections,
> +	NFSD_MaxThreads,
> =C2=A0	NFSD_Filecache,
> =C2=A0	NFSD_Leasetime,
> =C2=A0	NFSD_Gracetime,
> @@ -68,6 +69,7 @@ static ssize_t write_versions(struct file *file, char *=
buf, size_t size);
> =C2=A0static ssize_t write_ports(struct file *file, char *buf, size_t siz=
e);
> =C2=A0static ssize_t write_maxblksize(struct file *file, char *buf, size_=
t size);
> =C2=A0static ssize_t write_maxconn(struct file *file, char *buf, size_t s=
ize);
> +static ssize_t write_maxthreads(struct file *file, char *buf, size_t siz=
e);
> =C2=A0#ifdef CONFIG_NFSD_V4
> =C2=A0static ssize_t write_leasetime(struct file *file, char *buf, size_t=
 size);
> =C2=A0static ssize_t write_gracetime(struct file *file, char *buf, size_t=
 size);
> @@ -87,6 +89,7 @@ static ssize_t (*const write_op[])(struct file *, char =
*, size_t) =3D {
> =C2=A0	[NFSD_Ports] =3D write_ports,
> =C2=A0	[NFSD_MaxBlkSize] =3D write_maxblksize,
> =C2=A0	[NFSD_MaxConnections] =3D write_maxconn,
> +	[NFSD_MaxThreads] =3D write_maxthreads,
> =C2=A0#ifdef CONFIG_NFSD_V4
> =C2=A0	[NFSD_Leasetime] =3D write_leasetime,
> =C2=A0	[NFSD_Gracetime] =3D write_gracetime,
> @@ -939,6 +942,47 @@ static ssize_t write_maxconn(struct file *file, char=
 *buf, size_t size)
> =C2=A0	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%u\n", maxconn);
> =C2=A0}
> =C2=A0
> +/*
> + * write_maxthreads - Set or report the current max number threads
> + *
> + * Input:
> + *			buf:		ignored
> + *			size:		zero
> + * OR
> + *
> + * Input:
> + *			buf:		C string containing an unsigned
> + *					integer value representing the new
> + *					max number of threads
> + *			size:		non-zero length of C string in @buf
> + * Output:
> + *	On success:	passed-in buffer filled with '\n'-terminated C string
> + *			containing numeric value of max_threads setting
> + *			for this net namespace;
> + *			return code is the size in bytes of the string
> + *	On error:	return code is zero or a negative errno value
> + */
> +static ssize_t write_maxthreads(struct file *file, char *buf, size_t siz=
e)
> +{
> +	char *mesg =3D buf;
> +	struct nfsd_net *nn =3D net_generic(netns(file), nfsd_net_id);
> +	unsigned int maxthreads =3D nn->max_threads;
> +
> +	if (size > 0) {
> +		int rv =3D get_uint(&mesg, &maxthreads);
> +
> +		if (rv)
> +			return rv;
> +		trace_nfsd_ctl_maxthreads(netns(file), maxthreads);
> +		mutex_lock(&nfsd_mutex);
> +		nn->max_threads =3D maxthreads;
> +		nfsd_update_nets();
> +		mutex_unlock(&nfsd_mutex);
> +	}
> +
> +	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%u\n", maxthreads);
> +}
> +
> =C2=A0#ifdef CONFIG_NFSD_V4
> =C2=A0static ssize_t __nfsd4_write_time(struct file *file, char *buf, siz=
e_t size,
> =C2=A0				=C2=A0 time64_t *time, struct nfsd_net *nn)
> @@ -1372,6 +1416,7 @@ static int nfsd_fill_super(struct super_block *sb, =
struct fs_context *fc)
> =C2=A0		[NFSD_Ports] =3D {"portlist", &transaction_ops, S_IWUSR|S_IRUGO},
> =C2=A0		[NFSD_MaxBlkSize] =3D {"max_block_size", &transaction_ops, S_IWUS=
R|S_IRUGO},
> =C2=A0		[NFSD_MaxConnections] =3D {"max_connections", &transaction_ops, S=
_IWUSR|S_IRUGO},
> +		[NFSD_MaxThreads] =3D {"max_threads", &transaction_ops, S_IWUSR|S_IRUG=
O},
> =C2=A0		[NFSD_Filecache] =3D {"filecache", &nfsd_file_cache_stats_fops, S=
_IRUGO},
> =C2=A0#ifdef CONFIG_NFSD_V4
> =C2=A0		[NFSD_Leasetime] =3D {"nfsv4leasetime", &transaction_ops, S_IWUSR=
|S_IRUSR},
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index e4c643255dc9..6874c2de670b 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -156,6 +156,10 @@ int nfsd_create_serv(struct net *net);
> =C2=A0void nfsd_destroy_serv(struct net *net);
> =C2=A0
> =C2=A0extern int nfsd_max_blksize;
> +void nfsd_update_nets(void);
> +extern unsigned int	nfsd_max_threads;
> +extern unsigned long	nfsd_net_used;
> +extern unsigned int	nfsd_net_cnt;
> =C2=A0
> =C2=A0static inline int nfsd_v4client(struct svc_rqst *rq)
> =C2=A0{
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index b005b2e2e6ad..75d78c17756f 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -80,6 +80,21 @@ DEFINE_SPINLOCK(nfsd_drc_lock);
> =C2=A0unsigned long	nfsd_drc_max_mem;
> =C2=A0unsigned long	nfsd_drc_slotsize_sum;
> =C2=A0
> +/*
> + * nfsd_max_threads is auto-configured based on available ram.
> + * Each network namespace can configure a minimum number of threads
> + * and optionally a maximum.
> + * nfsd_net_used is the number of the max or min from each net namespace=
.
> + * nfsd_new_cnt is the number of net namespaces with a configured minimu=
m
> + *=C2=A0=C2=A0=C2=A0 but no configured maximum.
> + * When nfsd_max_threads exceeds nfsd_net_used, the different is divided
> + * by nfsd_net_cnt and this number gives the excess above the configured=
 minimum
> + * for all net namespaces without a configured maximum.
> + */
> +unsigned int	nfsd_max_threads;
> +unsigned long	nfsd_net_used;
> +unsigned int	nfsd_net_cnt;
> +
> =C2=A0#if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
> =C2=A0static const struct svc_version *nfsd_acl_version[] =3D {
> =C2=A0# if defined(CONFIG_NFSD_V2_ACL)
> @@ -130,6 +145,47 @@ struct svc_program		nfsd_program =3D {
> =C2=A0	.pg_rpcbind_set		=3D nfsd_rpcbind_set,
> =C2=A0};
> =C2=A0
> +void nfsd_update_nets(void)
> +{
> +	struct net *net;
> +
> +	if (nfsd_max_threads =3D=3D 0) {
> +		nfsd_max_threads =3D (nr_free_buffer_pages() >> 7) /
> +			(NFSSVC_MAXBLKSIZE >> PAGE_SHIFT);
> +	}
> +	nfsd_net_used =3D 0;
> +	nfsd_net_cnt =3D 0;
> +	down_read(&net_rwsem);
> +	for_each_net(net) {
> +		struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> +
> +		if (!nn->nfsd_serv)
> +			continue;
> +		if (nn->max_threads > 0) {
> +			nfsd_net_used +=3D nn->max_threads;
> +		} else {
> +			nfsd_net_used +=3D nn->nfsd_serv->sv_nrthreads;
> +			nfsd_net_cnt +=3D 1;
> +		}
> +	}
> +	up_read(&net_rwsem);
> +}
> +
> +static inline int nfsd_max_pool_threads(struct svc_pool *p, struct nfsd_=
net *nn)
> +{
> +	int svthreads =3D nn->nfsd_serv->sv_nrthreads;
> +
> +	if (nn->max_threads > 0)
> +		return nn->max_threads;
> +	if (nfsd_net_cnt =3D=3D 0 || svthreads =3D=3D 0)
> +		return 0;
> +	if (nfsd_max_threads < nfsd_net_cnt)
> +		return p->sp_nrthreads;
> +	/* Share nfsd_max_threads among all net, then among pools in this net. =
*/
> +	return p->sp_nrthreads +
> +		nfsd_max_threads / nfsd_net_cnt * p->sp_nrthreads / svthreads;
> +}
> +
> =C2=A0bool nfsd_support_version(int vers)
> =C2=A0{
> =C2=A0	if (vers >=3D NFSD_MINVERS && vers <=3D NFSD_MAXVERS)
> @@ -474,6 +530,7 @@ void nfsd_destroy_serv(struct net *net)
> =C2=A0	spin_lock(&nfsd_notifier_lock);
> =C2=A0	nn->nfsd_serv =3D NULL;
> =C2=A0	spin_unlock(&nfsd_notifier_lock);
> +	nfsd_update_nets();
> =C2=A0
> =C2=A0	/* check if the notifier still has clients */
> =C2=A0	if (atomic_dec_return(&nfsd_notifier_refcount) =3D=3D 0) {
> @@ -614,6 +671,8 @@ int nfsd_create_serv(struct net *net)
> =C2=A0	nn->nfsd_serv =3D serv;
> =C2=A0	spin_unlock(&nfsd_notifier_lock);
> =C2=A0
> +	nfsd_update_nets();
> +
> =C2=A0	set_max_drc();
> =C2=A0	/* check if the notifier is already set */
> =C2=A0	if (atomic_inc_return(&nfsd_notifier_refcount) =3D=3D 1) {
> @@ -720,6 +779,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct n=
et *net)
> =C2=A0			goto out;
> =C2=A0	}
> =C2=A0out:
> +	nfsd_update_nets();
> =C2=A0	return err;
> =C2=A0}
> =C2=A0
> @@ -759,6 +819,7 @@ nfsd_svc(int n, int *nthreads, struct net *net, const=
 struct cred *cred, const c
> =C2=A0	error =3D nfsd_set_nrthreads(n, nthreads, net);
> =C2=A0	if (error)
> =C2=A0		goto out_put;
> +	nfsd_update_nets();
> =C2=A0	error =3D serv->sv_nrthreads;
> =C2=A0out_put:
> =C2=A0	if (serv->sv_nrthreads =3D=3D 0)
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 77bbd23aa150..92b888e178e8 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -2054,6 +2054,25 @@ TRACE_EVENT(nfsd_ctl_maxconn,
> =C2=A0	)
> =C2=A0);
> =C2=A0
> +TRACE_EVENT(nfsd_ctl_maxthreads,
> +	TP_PROTO(
> +		const struct net *net,
> +		int maxthreads
> +	),
> +	TP_ARGS(net, maxthreads),
> +	TP_STRUCT__entry(
> +		__field(unsigned int, netns_ino)
> +		__field(int, maxthreads)
> +	),
> +	TP_fast_assign(
> +		__entry->netns_ino =3D net->ns.inum;
> +		__entry->maxthreads =3D maxthreads
> +	),
> +	TP_printk("maxthreads=3D%d",
> +		__entry->maxthreads
> +	)
> +);
> +
> =C2=A0TRACE_EVENT(nfsd_ctl_time,
> =C2=A0	TP_PROTO(
> =C2=A0		const struct net *net,

--=20
Jeff Layton <jlayton@kernel.org>

