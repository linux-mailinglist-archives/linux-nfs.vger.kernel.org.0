Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50CD2C13E6
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 20:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730727AbgKWSwj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 13:52:39 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:36302 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729304AbgKWSwi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 13:52:38 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ANIYWWC163108;
        Mon, 23 Nov 2020 18:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=6BVgGew7DT8fUUKhyHTX4Mig+YRMagGexuXtb52bwb4=;
 b=sQBbvIww7nVh7IHIEU2mECXFMs+vv+XwddUEtp9fzvo68toMqKzLyE2aAm+9fdjGYgiK
 nDYgfD4mPmDagoDxRzo0SlQfzNkKyN/syoZS7VqPJDDeXdJT92SpU0kENiobgzHwYC53
 tGZPGoV9FX2KkoZpDeQFS+yyL0d7K1Ffbqc+0JcIj+rIr4cmAlV47l3veWLZ7slycdMm
 +OsfOURHHtCraUBupvaimHlDdrT3W2/DDf72n0e3rKmOf3cmlyEe250v7wEc5BxOFM0P
 pUXW8dAS7PRwokKhpj3nvS6BVoirkyHZT19HObCfEdezntrUEFVgEjvnvgvHoB0W7/m2 ZA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 34xrdapybm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Nov 2020 18:52:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ANIZoG2033429;
        Mon, 23 Nov 2020 18:52:36 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 34ycnrawyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Nov 2020 18:52:36 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0ANIqUKI020413;
        Mon, 23 Nov 2020 18:52:35 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 23 Nov 2020 10:52:30 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v2 003/118] SUNRPC: Prepare for xdr_stream-style decoding
 on the server-side
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201123184955.GG32599@fieldses.org>
Date:   Mon, 23 Nov 2020 13:52:28 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8772EA30-C460-4E24-9546-5138216AD3FB@oracle.com>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
 <160590444205.1340.4589231865882719752.stgit@klimt.1015granger.net>
 <20201123184955.GG32599@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9814 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=2
 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011230122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9814 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 adultscore=0 suspectscore=2 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011230122
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 23, 2020, at 1:49 PM, bfields@fieldses.org wrote:
>=20
> On Fri, Nov 20, 2020 at 03:34:02PM -0500, Chuck Lever wrote:
>> A "permanent" struct xdr_stream is allocated in struct svc_rqst so
>> that it is usable by all server-side decoders. A per-rqst scratch
>> buffer is also allocated to handle decoding XDR data items that
>> cross page boundaries.
>>=20
>> To demonstrate how it will be used, add the first call site for the
>> new svcxdr_init_decode() API.
>>=20
>> As an additional part of the overall conversion, add symbolic
>> constants for successful and failed XDR operations. Returning "0" is
>> overloaded. Sometimes it means something failed, but sometimes it
>> means success. To make it more clear when XDR decoding functions
>> succeed or fail, introduce symbolic constants.
>=20
> I'm not sure how I feel about that part.  Do you plan to change this
> everywhere?

Yes. But, I agree it is a little wordy.


> Maybe it'd be simpler or clearer to make pc_decode return bool?

That was my first thought. But true/false is just as overloaded
and meaningless as "1" and "0".

However, I'm open to opinions and better ideas.


> --b.
>=20
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> fs/nfsd/nfs4xdr.c          |    3 ++-
>> fs/nfsd/nfssvc.c           |    4 +++-
>> include/linux/sunrpc/svc.h |   16 ++++++++++++++++
>> include/linux/sunrpc/xdr.h |    5 +++++
>> net/sunrpc/svc.c           |    5 +++++
>> 5 files changed, 31 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>> index e3c6bea83bd6..66274ad05a9c 100644
>> --- a/fs/nfsd/nfs4xdr.c
>> +++ b/fs/nfsd/nfs4xdr.c
>> @@ -5321,7 +5321,8 @@ nfs4svc_decode_compoundargs(struct svc_rqst =
*rqstp, __be32 *p)
>> 	args->ops =3D args->iops;
>> 	args->rqstp =3D rqstp;
>>=20
>> -	return !nfsd4_decode_compound(args);
>> +	return nfsd4_decode_compound(args) =3D=3D nfs_ok ?	=
XDR_DECODE_DONE :
>> +							=
XDR_DECODE_FAILED;
>> }
>>=20
>> int
>> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
>> index 27b1ad136150..daeab72975a3 100644
>> --- a/fs/nfsd/nfssvc.c
>> +++ b/fs/nfsd/nfssvc.c
>> @@ -1020,7 +1020,9 @@ int nfsd_dispatch(struct svc_rqst *rqstp, =
__be32 *statp)
>> 	 * (necessary in the NFSv4.0 compound case)
>> 	 */
>> 	rqstp->rq_cachetype =3D proc->pc_cachetype;
>> -	if (!proc->pc_decode(rqstp, argv->iov_base))
>> +
>> +	svcxdr_init_decode(rqstp, argv->iov_base);
>> +	if (proc->pc_decode(rqstp, argv->iov_base) =3D=3D =
XDR_DECODE_FAILED)
>> 		goto out_decode_err;
>>=20
>> 	switch (nfsd_cache_lookup(rqstp)) {
>> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
>> index c220b734fa69..bb6c93283697 100644
>> --- a/include/linux/sunrpc/svc.h
>> +++ b/include/linux/sunrpc/svc.h
>> @@ -248,6 +248,8 @@ struct svc_rqst {
>> 	size_t			rq_xprt_hlen;	/* xprt header len */
>> 	struct xdr_buf		rq_arg;
>> 	struct xdr_buf		rq_res;
>> +	struct xdr_stream	rq_xdr_stream;
>> +	struct page		*rq_scratch_page;
>> 	struct page		*rq_pages[RPCSVC_MAXPAGES + 1];
>> 	struct page *		*rq_respages;	/* points into rq_pages =
*/
>> 	struct page *		*rq_next_page; /* next reply page to use =
*/
>> @@ -557,4 +559,18 @@ static inline void svc_reserve_auth(struct =
svc_rqst *rqstp, int space)
>> 	svc_reserve(rqstp, space + rqstp->rq_auth_slack);
>> }
>>=20
>> +/**
>> + * svcxdr_init_decode - Prepare an xdr_stream for svc Call decoding
>> + * @rqstp: controlling server RPC transaction context
>> + * @p: Starting position
>> + *
>> + */
>> +static inline void svcxdr_init_decode(struct svc_rqst *rqstp, __be32 =
*p)
>> +{
>> +	struct xdr_stream *xdr =3D &rqstp->rq_xdr_stream;
>> +
>> +	xdr_init_decode(xdr, &rqstp->rq_arg, p, NULL);
>> +	xdr_set_scratch_page(xdr, rqstp->rq_scratch_page);
>> +}
>> +
>> #endif /* SUNRPC_SVC_H */
>> diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
>> index 2729d2d6efce..abbb032de4e8 100644
>> --- a/include/linux/sunrpc/xdr.h
>> +++ b/include/linux/sunrpc/xdr.h
>> @@ -19,6 +19,11 @@
>> struct bio_vec;
>> struct rpc_rqst;
>>=20
>> +enum xdr_decode_result {
>> +	XDR_DECODE_FAILED =3D 0,
>> +	XDR_DECODE_DONE =3D 1,
>> +};
>> +
>> /*
>>  * Buffer adjustment
>>  */
>> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
>> index b41500645c3f..4187745887f0 100644
>> --- a/net/sunrpc/svc.c
>> +++ b/net/sunrpc/svc.c
>> @@ -614,6 +614,10 @@ svc_rqst_alloc(struct svc_serv *serv, struct =
svc_pool *pool, int node)
>> 	rqstp->rq_server =3D serv;
>> 	rqstp->rq_pool =3D pool;
>>=20
>> +	rqstp->rq_scratch_page =3D alloc_pages_node(node, GFP_KERNEL, =
0);
>> +	if (!rqstp->rq_scratch_page)
>> +		goto out_enomem;
>> +
>> 	rqstp->rq_argp =3D kmalloc_node(serv->sv_xdrsize, GFP_KERNEL, =
node);
>> 	if (!rqstp->rq_argp)
>> 		goto out_enomem;
>> @@ -842,6 +846,7 @@ void
>> svc_rqst_free(struct svc_rqst *rqstp)
>> {
>> 	svc_release_buffer(rqstp);
>> +	put_page(rqstp->rq_scratch_page);
>> 	kfree(rqstp->rq_resp);
>> 	kfree(rqstp->rq_argp);
>> 	kfree(rqstp->rq_auth_data);

--
Chuck Lever



