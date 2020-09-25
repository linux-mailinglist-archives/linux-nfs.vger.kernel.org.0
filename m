Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADC5278AB5
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Sep 2020 16:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgIYOSS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Sep 2020 10:18:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46448 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728808AbgIYOSS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Sep 2020 10:18:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08PEEqT6190220;
        Fri, 25 Sep 2020 14:18:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=n/BvEuHZVDBdtnSdX2B4vVYB0oJ48+7GsWwwApvPpC0=;
 b=Eon2HeaVxXhkhx6yjN6nBOM0gDsePlFpatO26AWjj3MSMd8p0/6NGEd9nZ866B8WuiLv
 mEuB3ogAO9AfNbKCsiFED4Hhb3sqR+C5PdoagvLqgnJ/nsv9EVxFCpBaYxRrbxO1XCU/
 bstepH9emGTRz13jtCFMD5RpJsdCrJ9cTyn3cF5NjmReDk8fbVXWhN5U7vXomTRxDe8/
 52h0k4cKKNZA6Lq7dQ4USUw028c+oz8N9K3d0aBF2CrF7GO5wLGZcnKPO8H/qmAS39er
 IkGd7VMhpEqlwYSvMqs051PoRuvNg5r3r2tq4330CZMOquY6KK1vCvlNszZz8iwS/IhL fQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 33ndnux0e4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Sep 2020 14:18:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08PEGX3D151303;
        Fri, 25 Sep 2020 14:18:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 33nurxuyu8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Sep 2020 14:18:14 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08PEIDIt008436;
        Fri, 25 Sep 2020 14:18:13 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Sep 2020 07:18:13 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH v2 26/27] NFSD: Add tracepoints in the NFS dispatcher
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <801F3A94-4668-4DF6-9CAF-27171EEBA17A@oracle.com>
Date:   Fri, 25 Sep 2020 10:18:11 -0400
Cc:     Bill Baker <Bill.Baker@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6E5F70FA-00CB-4C17-84C2-0A3BFA34D081@oracle.com>
References: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
 <160071198717.1468.14262284967190973528.stgit@klimt.1015granger.net>
 <20200924234526.GB12407@fieldses.org>
 <801F3A94-4668-4DF6-9CAF-27171EEBA17A@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009250101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9755 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009250100
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 25, 2020, at 9:59 AM, Chuck Lever <chuck.lever@oracle.com> =
wrote:
>=20
>=20
>=20
>> On Sep 24, 2020, at 7:45 PM, J. Bruce Fields <bfields@fieldses.org> =
wrote:
>>=20
>> On Mon, Sep 21, 2020 at 02:13:07PM -0400, Chuck Lever wrote:
>>> This is follow-on work to the tracepoints added in the NFS server's
>>> duplicate reply cache. Here, tracepoints are introduced that report
>>> replies from cache as well as encoding and decoding errors.
>>>=20
>>> The NFSv2, v3, and v4 dispatcher requirements have diverged over
>>> time, leaving us with a little bit of technical debt. In addition,
>>> I wanted to add a tracepoint for NFSv2 and NFSv3 similar to the
>>> nfsd4_compound/compoundstatus tracepoints. Lastly, removing some
>>> conditional branches from this hot path helps optimize CPU
>>> utilization. So, I've duplicated the nfsd_dispatcher function.
>>=20
>> Comparing current nfsd_dispatch to the nfsv2/v3 nfsd_dispatch: the =
only
>> thing I spotted removed from the v2/v3-specific dispatch is the
>> rq_lease_breaker =3D NULL.  (I think that's not correct, actually.  =
We
>> could remove the need for that to be set in the v2/v3 case, but with =
the
>> current code it does need to be set.)
>=20
> Noted with thanks.
>=20
>=20
>> Comparing current nfsd_dispatch to the nfsv4 nfsd4_dispatch, the
>> v4-specific dispatch does away with nfs_request_too_big() and the
>> v2-specific shortcut in the error encoding case.
>>=20
>> So these still look *very* similar.  I don't feel like we're getting =
a
>> lot of benefit out of splitting these out.
>=20
> I don't disagree with that at all. At this point I'm just noodling
> to see what's possible. I'm now toying with other ways to add high-
> value tracing in the legacy ULPs. In the end I might end up avoiding
> significant changes in the dispatchers in order to add tracing.
>=20
> However, a few thoughts I had while learning how the dispatcher
> code works.
>=20
> There are some opportunities for reducing instruction path length
> and the number of conditional branches in here. It's a hot path,
> so I think we should consider some careful micro-optimizations
> even if they don't add significant new features or do add some
> code duplication.
>=20
> In user space, the library (iirc) assumes each ULP provides it's
> own dispatcher function. I'd consider duplicating and removing
> svc_generic_dispatcher() to simplify the pasta in svc_process(),
> again as a micro-optimization and for better code legibility.
>=20
> lockd's pc_func returns an RPC accept_stat, but the NFSD pc_func
> methods return an NFS status. The latter feels like a layering
> violation for the sake of reducing a small amount of code
> duplication. I'd rather see encoding of the NFS status handled in
> the NFS Reply encoders, since that is an XDR function, and because
> that logic seems slightly different for NFSv2, support for which
> we'd like to deprecate at some point.

I misremembered this. nfsd_dispatch simply doesn't set *statp
in the success case, which seems strange.


> Note also that *statp in nfsd_dispatch is never explicitly set to
> rpc_success in the normal execution flow. It relies on the
> equivalence of rpc_success and nfs_ok, which is convenient, but
> confusing to read. It might be cleaner if *statp was made an enum
> to make it explicit what set of values go in that return variable.
>=20
>=20
>> By the way, the combination of copying a bunch of code, doing some
>> common cleanup, and dropping version-specific stuff makes it a little
>> hard to sort out what's going on.  If it were me, I'd do this as:
>>=20
>> 	- one patch to do common cleanup (dropping some redundant
>> 	  comments, using argv/resv variables to cleanup calculations,
>> 	  etc.)
>> 	- a second patch that just duplicates the one nfsd_dispatch into
>> 	  nfsd_dispatch and nfsd4_dispatch
>> 	- a third patch that just removes the stuff we don't need from
>> 	  the newly duplicated dispatchers.
>>=20
>> and then it'd be obvious what's changed.
>=20
> Good points. The series is still immature, and I tend to maintain
> larger checkpoint patches that get broken down over time to make
> it more obvious what is changing and why. I'll keep your comments
> in mind as this work evolves. Feel free to make similar suggestions
> about my future work.
>=20
>=20
>> --b.
>>=20
>>>=20
>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>> ---
>>> fs/nfsd/nfs2acl.c  |    2 -
>>> fs/nfsd/nfs3acl.c  |    2 -
>>> fs/nfsd/nfs4proc.c |    2 -
>>> fs/nfsd/nfsd.h     |    1=20
>>> fs/nfsd/nfssvc.c   |  198 =
++++++++++++++++++++++++++++++++++------------------
>>> fs/nfsd/trace.h    |   50 +++++++++++++
>>> 6 files changed, 183 insertions(+), 72 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
>>> index 54e597918822..894b8f0594e2 100644
>>> --- a/fs/nfsd/nfs2acl.c
>>> +++ b/fs/nfsd/nfs2acl.c
>>> @@ -416,6 +416,6 @@ const struct svc_version nfsd_acl_version2 =3D {
>>> 	.vs_nproc	=3D 5,
>>> 	.vs_proc	=3D nfsd_acl_procedures2,
>>> 	.vs_count	=3D nfsd_acl_count2,
>>> -	.vs_dispatch	=3D nfsd_dispatch,
>>> +	.vs_dispatch	=3D nfsd4_dispatch,
>>> 	.vs_xdrsize	=3D NFS3_SVC_XDRSIZE,
>>> };
>>> diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
>>> index 7f512dec7460..924ebb19c59c 100644
>>> --- a/fs/nfsd/nfs3acl.c
>>> +++ b/fs/nfsd/nfs3acl.c
>>> @@ -282,7 +282,7 @@ const struct svc_version nfsd_acl_version3 =3D {
>>> 	.vs_nproc	=3D 3,
>>> 	.vs_proc	=3D nfsd_acl_procedures3,
>>> 	.vs_count	=3D nfsd_acl_count3,
>>> -	.vs_dispatch	=3D nfsd_dispatch,
>>> +	.vs_dispatch	=3D nfsd4_dispatch,
>>> 	.vs_xdrsize	=3D NFS3_SVC_XDRSIZE,
>>> };
>>>=20
>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>> index 49109645af24..61302641f651 100644
>>> --- a/fs/nfsd/nfs4proc.c
>>> +++ b/fs/nfsd/nfs4proc.c
>>> @@ -3320,7 +3320,7 @@ const struct svc_version nfsd_version4 =3D {
>>> 	.vs_nproc		=3D 2,
>>> 	.vs_proc		=3D nfsd_procedures4,
>>> 	.vs_count		=3D nfsd_count3,
>>> -	.vs_dispatch		=3D nfsd_dispatch,
>>> +	.vs_dispatch		=3D nfsd4_dispatch,
>>> 	.vs_xdrsize		=3D NFS4_SVC_XDRSIZE,
>>> 	.vs_rpcb_optnl		=3D true,
>>> 	.vs_need_cong_ctrl	=3D true,
>>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>>> index cb742e17e04a..7fa4b19dd2f7 100644
>>> --- a/fs/nfsd/nfsd.h
>>> +++ b/fs/nfsd/nfsd.h
>>> @@ -78,6 +78,7 @@ extern const struct seq_operations nfs_exports_op;
>>> */
>>> int		nfsd_svc(int nrservs, struct net *net, const struct cred =
*cred);
>>> int		nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp);
>>> +int		nfsd4_dispatch(struct svc_rqst *rqstp, __be32 =
*statp);
>>>=20
>>> int		nfsd_nrthreads(struct net *);
>>> int		nfsd_nrpools(struct net *);
>>> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
>>> index f7f6473578af..d626eea1c78a 100644
>>> --- a/fs/nfsd/nfssvc.c
>>> +++ b/fs/nfsd/nfssvc.c
>>> @@ -28,6 +28,7 @@
>>> #include "vfs.h"
>>> #include "netns.h"
>>> #include "filecache.h"
>>> +#include "trace.h"
>>>=20
>>> #define NFSDDBG_FACILITY	NFSDDBG_SVC
>>>=20
>>> @@ -964,7 +965,7 @@ static __be32 map_new_errors(u32 vers, __be32 =
nfserr)
>>> {
>>> 	if (nfserr =3D=3D nfserr_jukebox && vers =3D=3D 2)
>>> 		return nfserr_dropit;
>>> -	if (nfserr =3D=3D nfserr_wrongsec && vers < 4)
>>> +	if (nfserr =3D=3D nfserr_wrongsec)
>>> 		return nfserr_acces;
>>> 	return nfserr;
>>> }
>>> @@ -980,18 +981,6 @@ static __be32 map_new_errors(u32 vers, __be32 =
nfserr)
>>> static bool nfs_request_too_big(struct svc_rqst *rqstp,
>>> 				const struct svc_procedure *proc)
>>> {
>>> -	/*
>>> -	 * The ACL code has more careful bounds-checking and is not
>>> -	 * susceptible to this problem:
>>> -	 */
>>> -	if (rqstp->rq_prog !=3D NFS_PROGRAM)
>>> -		return false;
>>> -	/*
>>> -	 * Ditto NFSv4 (which can in theory have argument and reply both
>>> -	 * more than a page):
>>> -	 */
>>> -	if (rqstp->rq_vers >=3D 4)
>>> -		return false;
>>> 	/* The reply will be small, we're OK: */
>>> 	if (proc->pc_xdrressize > 0 &&
>>> 	    proc->pc_xdrressize < XDR_QUADLEN(PAGE_SIZE))
>>> @@ -1000,81 +989,152 @@ static bool nfs_request_too_big(struct =
svc_rqst *rqstp,
>>> 	return rqstp->rq_arg.len > PAGE_SIZE;
>>> }
>>>=20
>>> -int
>>> -nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
>>> +/**
>>> + * nfsd_dispatch - Process an NFSv2 or NFSv3 request
>>> + * @rqstp: incoming NFS request
>>> + * @statp: OUT: RPC accept_stat value
>>> + *
>>> + * Return values:
>>> + *  %0: Processing complete; do not send a Reply
>>> + *  %1: Processing complete; send a Reply
>>> + */
>>> +int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
>>> {
>>> -	const struct svc_procedure *proc;
>>> -	__be32			nfserr;
>>> -	__be32			*nfserrp;
>>> -
>>> -	dprintk("nfsd_dispatch: vers %d proc %d\n",
>>> -				rqstp->rq_vers, rqstp->rq_proc);
>>> -	proc =3D rqstp->rq_procinfo;
>>> -
>>> -	if (nfs_request_too_big(rqstp, proc)) {
>>> -		dprintk("nfsd: NFSv%d argument too large\n", =
rqstp->rq_vers);
>>> -		*statp =3D rpc_garbage_args;
>>> -		return 1;
>>> +	const struct svc_procedure *proc =3D rqstp->rq_procinfo;
>>> +	struct kvec *argv =3D &rqstp->rq_arg.head[0];
>>> +	struct kvec *resv =3D &rqstp->rq_res.head[0];
>>> +	__be32 nfserr, *nfserrp;
>>> +
>>> +	if (nfs_request_too_big(rqstp, proc))
>>> +		goto out_too_large;
>>> +
>>> +	if (proc->pc_decode && !procp->pc_decode(rqstp, argv->iov_base))
>>> +		goto out_decode_err;
>>> +
>>> +	rqstp->rq_cachetype =3D proc->pc_cachetype;
>>> +	switch (nfsd_cache_lookup(rqstp)) {
>>> +	case RC_DROPIT:
>>> +		goto out_dropit;
>>> +	case RC_REPLY:
>>> +		goto out_cached_reply;
>>> +	case RC_DOIT:
>>> +		break;
>>> 	}
>>> -	rqstp->rq_lease_breaker =3D NULL;
>>> +
>>> +	nfserrp =3D resv->iov_base + resv->iov_len;
>>> +	resv->iov_len +=3D sizeof(__be32);
>>> +	nfserr =3D proc->pc_func(rqstp);
>>> +	nfserr =3D map_new_errors(rqstp->rq_vers, nfserr);
>>> +	if (nfserr =3D=3D nfserr_dropit || test_bit(RQ_DROPME, =
&rqstp->rq_flags))
>>> +		goto out_update_drop;
>>> +	if (rqstp->rq_proc)
>>> +		*nfserrp++ =3D nfserr;
>>> +
>>> +	/* For NFSv2, additional info is never returned in case of an =
error. */
>>> +	if (!(nfserr && rqstp->rq_vers =3D=3D 2))
>>> +		if (proc->pc_encode && !proc->pc_encode(rqstp, nfserrp))
>>> +			goto out_encode_err;
>>> +
>>> +	nfsd_cache_update(rqstp, proc->pc_cachetype, statp + 1);
>>> +	trace_nfsd_svc_status(rqstp, proc, nfserr);
>>> +	return 1;
>>> +
>>> +out_too_large:
>>> +	trace_nfsd_svc_too_large_err(rqstp);
>>> +	*statp =3D rpc_garbage_args;
>>> +	return 1;
>>> +
>>> +out_decode_err:
>>> +	trace_nfsd_svc_decode_err(rqstp);
>>> +	*statp =3D rpc_garbage_args;
>>> +	return 1;
>>> +
>>> +out_update_drop:
>>> +	nfsd_cache_update(rqstp, RC_NOCACHE, NULL);
>>> +out_dropit:
>>> +	trace_nfsd_svc_dropit(rqstp);
>>> +	return 0;
>>> +
>>> +out_cached_reply:
>>> +	trace_nfsd_svc_cached_reply(rqstp);
>>> +	return 1;
>>> +
>>> +out_encode_err:
>>> +	trace_nfsd_svc_encode_err(rqstp);
>>> +	nfsd_cache_update(rqstp, RC_NOCACHE, NULL);
>>> +	*statp =3D rpc_system_err;
>>> +	return 1;
>>> +}
>>> +
>>> +/**
>>> + * nfsd4_dispatch - Process an NFSv4 or NFSACL request
>>> + * @rqstp: incoming NFS request
>>> + * @statp: OUT: RPC accept_stat value
>>> + *
>>> + * Return values:
>>> + *  %0: Processing complete; do not send a Reply
>>> + *  %1: Processing complete; send a Reply
>>> + */
>>> +int nfsd4_dispatch(struct svc_rqst *rqstp, __be32 *statp)
>>> +{
>>> +	const struct svc_procedure *proc =3D rqstp->rq_procinfo;
>>> +	struct kvec *argv =3D &rqstp->rq_arg.head[0];
>>> +	struct kvec *resv =3D &rqstp->rq_res.head[0];
>>> +	__be32 nfserr, *nfserrp;
>>> +
>>> 	/*
>>> 	 * Give the xdr decoder a chance to change this if it wants
>>> 	 * (necessary in the NFSv4.0 compound case)
>>> 	 */
>>> 	rqstp->rq_cachetype =3D proc->pc_cachetype;
>>> -	/* Decode arguments */
>>> -	if (proc->pc_decode &&
>>> -	    !proc->pc_decode(rqstp, =
(__be32*)rqstp->rq_arg.head[0].iov_base)) {
>>> -		dprintk("nfsd: failed to decode arguments!\n");
>>> -		*statp =3D rpc_garbage_args;
>>> -		return 1;
>>> -	}
>>> +	rqstp->rq_lease_breaker =3D NULL;
>>> +
>>> +	if (proc->pc_decode && !procp->pc_decode(rqstp, argv->iov_base))
>>> +		goto out_decode_err;
>>>=20
>>> -	/* Check whether we have this call in the cache. */
>>> 	switch (nfsd_cache_lookup(rqstp)) {
>>> 	case RC_DROPIT:
>>> -		return 0;
>>> +		goto out_dropit;
>>> 	case RC_REPLY:
>>> -		return 1;
>>> -	case RC_DOIT:;
>>> -		/* do it */
>>> +		goto out_cached_reply;
>>> +	case RC_DOIT:
>>> +		break;
>>> 	}
>>>=20
>>> -	/* need to grab the location to store the status, as
>>> -	 * nfsv4 does some encoding while processing=20
>>> -	 */
>>> -	nfserrp =3D rqstp->rq_res.head[0].iov_base
>>> -		+ rqstp->rq_res.head[0].iov_len;
>>> -	rqstp->rq_res.head[0].iov_len +=3D sizeof(__be32);
>>> -
>>> -	/* Now call the procedure handler, and encode NFS status. */
>>> +	nfserrp =3D resv->iov_base + resv->iov_len;
>>> +	resv->iov_len +=3D sizeof(__be32);
>>> 	nfserr =3D proc->pc_func(rqstp);
>>> -	nfserr =3D map_new_errors(rqstp->rq_vers, nfserr);
>>> -	if (nfserr =3D=3D nfserr_dropit || test_bit(RQ_DROPME, =
&rqstp->rq_flags)) {
>>> -		dprintk("nfsd: Dropping request; may be revisited =
later\n");
>>> -		nfsd_cache_update(rqstp, RC_NOCACHE, NULL);
>>> -		return 0;
>>> -	}
>>> -
>>> -	if (rqstp->rq_proc !=3D 0)
>>> +	if (test_bit(RQ_DROPME, &rqstp->rq_flags))
>>> +		goto out_update_drop;
>>> +	if (rqstp->rq_proc)
>>> 		*nfserrp++ =3D nfserr;
>>>=20
>>> -	/* Encode result.
>>> -	 * For NFSv2, additional info is never returned in case of an =
error.
>>> -	 */
>>> -	if (!(nfserr && rqstp->rq_vers =3D=3D 2)) {
>>> -		if (proc->pc_encode && !proc->pc_encode(rqstp, nfserrp)) =
{
>>> -			/* Failed to encode result. Release cache entry =
*/
>>> -			dprintk("nfsd: failed to encode result!\n");
>>> -			nfsd_cache_update(rqstp, RC_NOCACHE, NULL);
>>> -			*statp =3D rpc_system_err;
>>> -			return 1;
>>> -		}
>>> -	}
>>> +	if (proc->pc_encode && !proc->pc_encode(rqstp, nfserrp))
>>> +		goto out_encode_err;
>>>=20
>>> -	/* Store reply in cache. */
>>> 	nfsd_cache_update(rqstp, rqstp->rq_cachetype, statp + 1);
>>> 	return 1;
>>> +
>>> +out_decode_err:
>>> +	trace_nfsd_svc_decode_err(rqstp);
>>> +	*statp =3D rpc_garbage_args;
>>> +	return 1;
>>> +
>>> +out_update_drop:
>>> +	nfsd_cache_update(rqstp, RC_NOCACHE, NULL);
>>> +out_dropit:
>>> +	trace_nfsd_svc_dropit(rqstp);
>>> +	return 0;
>>> +
>>> +out_cached_reply:
>>> +	trace_nfsd_svc_cached_reply(rqstp);
>>> +	return 1;
>>> +
>>> +out_encode_err:
>>> +	trace_nfsd_svc_encode_err(rqstp);
>>> +	nfsd_cache_update(rqstp, RC_NOCACHE, NULL);
>>> +	*statp =3D rpc_system_err;
>>> +	return 1;
>>> }
>>>=20
>>> int nfsd_pool_stats_open(struct inode *inode, struct file *file)
>>> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
>>> index 53115fbc00b2..50ab4a84c25f 100644
>>> --- a/fs/nfsd/trace.h
>>> +++ b/fs/nfsd/trace.h
>>> @@ -32,6 +32,56 @@
>>> 		{ NFSD_MAY_READ_IF_EXEC,	"READ_IF_EXEC" },	=
\
>>> 		{ NFSD_MAY_64BIT_COOKIE,	"64BIT_COOKIE" })
>>>=20
>>> +DECLARE_EVENT_CLASS(nfsd_simple_class,
>>> +	TP_PROTO(
>>> +		const struct svc_rqst *rqstp
>>> +	),
>>> +	TP_ARGS(rqstp),
>>> +	TP_STRUCT__entry(
>>> +		__field(u32, xid)
>>> +	),
>>> +	TP_fast_assign(
>>> +		__entry->xid =3D be32_to_cpu(rqstp->rq_xid);
>>> +	),
>>> +	TP_printk("xid=3D0x%08x", __entry->xid)
>>> +);
>>> +
>>> +#define DEFINE_NFSD_SIMPLE_EVENT(name)			\
>>> +DEFINE_EVENT(nfsd_simple_class, nfsd_##name,		\
>>> +	TP_PROTO(const struct svc_rqst *rqstp),		\
>>> +	TP_ARGS(rqstp))
>>> +
>>> +DEFINE_NFSD_SIMPLE_EVENT(svc_too_large_err);
>>> +DEFINE_NFSD_SIMPLE_EVENT(svc_decode_err);
>>> +DEFINE_NFSD_SIMPLE_EVENT(svc_dropit);
>>> +DEFINE_NFSD_SIMPLE_EVENT(svc_cached_reply);
>>> +DEFINE_NFSD_SIMPLE_EVENT(svc_encode_err);
>>> +
>>> +TRACE_EVENT(nfsd_svc_status,
>>> +	TP_PROTO(
>>> +		const struct svc_rqst *rqstp,
>>> +		const struct svc_procedure *proc,
>>> +		__be32 status
>>> +	),
>>> +	TP_ARGS(rqstp, proc, status),
>>> +	TP_STRUCT__entry(
>>> +		__field(u32, xid)
>>> +		__field(u32, version)
>>> +		__field(unsigned long, status)
>>> +		__string(procedure, rqstp->rq_procinfo->pc_name)
>>> +	),
>>> +	TP_fast_assign(
>>> +		__entry->xid =3D be32_to_cpu(rqstp->rq_xid);
>>> +		__entry->version =3D rqstp->rq_vers;
>>> +		__entry->status =3D be32_to_cpu(status);
>>> +		__assign_str(procedure, rqstp->rq_procinfo->pc_name);
>>> +	),
>>> +	TP_printk("xid=3D0x%08x version=3D%u procedure=3D%s status=3D%s",
>>> +		__entry->xid, __entry->version, __get_str(procedure),
>>> +		show_nfs_status(__entry->status)
>>> +	)
>>> +);
>>> +
>>> TRACE_EVENT(nfsd_access,
>>> 	TP_PROTO(
>>> 		const struct svc_rqst *rqstp,
>>>=20
>=20
> --
> Chuck Lever

--
Chuck Lever



