Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3453ED8265
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Oct 2019 23:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbfJOVr2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Oct 2019 17:47:28 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39942 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730502AbfJOVr2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Oct 2019 17:47:28 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9FLi2D4102951;
        Tue, 15 Oct 2019 21:47:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=LM5YlxAv7edP6JGIQstLDLPuXjKfybFDj2i0eQIKfJs=;
 b=oJHPbqRzGPe0fnbfbS1OmBl+KOHD95gw0WBc40XFce/+lDSNO6NoxsPZAQM9PJcac6c4
 4+XVhJ+bGHImLeOZn3fzMvcv5Ezk/Pm+yauYeiwsjkwRbjnR0l26RhT/xiNs8av069pg
 jysSVEmB/8oe2/z3AesXodIT733ebd3ehxQCa+VZ9q62Y1Q0Lm4LWxdjR2X5aMtwl71u
 D6iUCf0krvBQPSMO/V7LUIWIsSiBtBqPuGTTibo0Y9Aq458An9sAciLpSumFSP7DUMLE
 KleJ+2lWfL5W25JqD4Gnxyy4mjFnGnv0gBIew+SvY/gTLbi/5ovWxSBef+349HA+UP5C 1Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2vk68uk1d1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Oct 2019 21:47:19 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9FLhHFo068097;
        Tue, 15 Oct 2019 21:47:19 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2vn7197199-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Oct 2019 21:47:18 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9FLlBYj027424;
        Tue, 15 Oct 2019 21:47:13 GMT
Received: from dhcp-50.nfsv4bat.org (/66.187.232.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Oct 2019 14:47:11 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] SUNRPC: backchannel RPC request must reference XPRT
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <711ebfa5340c6e29ff640e855db5ad8e41a09a60.camel@hammerspace.com>
Date:   Tue, 15 Oct 2019 17:47:09 -0400
Cc:     Bruce Fields <bfields@fieldses.org>, Neil Brown <neilb@suse.de>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <94FD3327-AEE7-4160-87E4-4E7569FB8D18@oracle.com>
References: <87tv8iqz3b.fsf@notabene.neil.brown.name>
 <20191011165603.GD19318@fieldses.org>
 <87imoqrjb8.fsf@notabene.neil.brown.name>
 <711ebfa5340c6e29ff640e855db5ad8e41a09a60.camel@hammerspace.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9411 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=975
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910150186
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9411 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910150186
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 15, 2019, at 5:16 PM, Trond Myklebust <trondmy@hammerspace.com> =
wrote:
>=20
> Hi Neil,
>=20
> On Tue, 2019-10-15 at 10:36 +1100, NeilBrown wrote:
>> The backchannel RPC requests - that are queued waiting
>> for the reply to be sent by the "NFSv4 callback" thread -
>> have a pointer to the xprt, but it is not reference counted.
>> It is possible for the xprt to be freed while there are
>> still queued requests.
>>=20
>> I think this has been a problem since
>> Commit fb7a0b9addbd ("nfs41: New backchannel helper routines")
>> when the code was introduced, but I suspect it became more of
>> a problem after
>> Commit 80b14d5e61ca ("SUNRPC: Add a structure to track multiple
>> transports")
>> (or there abouts).
>> Before this second patch, the nfs client would hold a reference to
>> the xprt to keep it alive.  After multipath was introduced,
>> a client holds a reference to a swtich, and the switch can have
>> multiple
>> xprts which can be added and removed.
>>=20
>> I'm not sure of all the causal issues, but this patch has
>> fixed a customer problem were an NFSv4.1 client would run out
>> of memory with tens of thousands of backchannel rpc requests
>> queued for an xprt that had been freed.  This was a 64K-page
>> machine so each rpc_rqst consumed more than 128K of memory.
>>=20
>> Fixes: 80b14d5e61ca ("SUNRPC: Add a structure to track multiple
>> transports")
>> cc: stable@vger.kernel.org (v4.6)
>> Signed-off-by: NeilBrown <neilb@suse.de>
>> ---
>> net/sunrpc/backchannel_rqst.c | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/net/sunrpc/backchannel_rqst.c
>> b/net/sunrpc/backchannel_rqst.c
>> index 339e8c077c2d..c95ca39688b6 100644
>> --- a/net/sunrpc/backchannel_rqst.c
>> +++ b/net/sunrpc/backchannel_rqst.c
>> @@ -61,6 +61,7 @@ static void xprt_free_allocation(struct rpc_rqst
>> *req)
>> 	free_page((unsigned long)xbufp->head[0].iov_base);
>> 	xbufp =3D &req->rq_snd_buf;
>> 	free_page((unsigned long)xbufp->head[0].iov_base);
>> +	xprt_put(req->rq_xprt);
>> 	kfree(req);
>> }
>=20
> Would it perhaps make better sense to move the xprt_get() to
> xprt_lookup_bc_request() and to release it in xprt_free_bc_rqst()?

/me wonders if the same problem exists for the RPC/RDMA backchannel....


> Otherwise as far as I can tell, we will have freed slots on the xprt-
>> bc_pa_list that hold a reference to the transport itself, meaning =
that
> the latter never gets released.
>=20
>>=20
>> @@ -85,7 +86,7 @@ struct rpc_rqst *xprt_alloc_bc_req(struct rpc_xprt
>> *xprt, gfp_t gfp_flags)
>> 	if (req =3D=3D NULL)
>> 		return NULL;
>>=20
>> -	req->rq_xprt =3D xprt;
>> +	req->rq_xprt =3D xprt_get(xprt);
>> 	INIT_LIST_HEAD(&req->rq_bc_list);
>>=20
>> 	/* Preallocate one XDR receive buffer */
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com

--
Chuck Lever



