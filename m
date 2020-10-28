Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A40729DBF8
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Oct 2020 01:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389217AbgJ1Wq2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Oct 2020 18:46:28 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38418 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731941AbgJ1WqS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 28 Oct 2020 18:46:18 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09SDF41u074989;
        Wed, 28 Oct 2020 13:16:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=wQUg/GZkTUQAeSzoaSQ/B3TZAArCLD8hsniSi+QGrHs=;
 b=yTlkqmuoj3e6X3wHVKT8hten1EXXDRSdJuGHEwrpmzgXucY9bRrPTYkyDBMRm18y2bJ2
 bxD27HbXRD9EbRW/ils88WHhjsPJ4sgl63N2oE+gfmWQA9P5cwoeHXhqzCtwXWa/QD78
 Stw1FMCT4nz/heIsZaCrAv5wD8PytuhYr14TISt3bhDzihVTsTMzGoTXlRIPAn++QjGI
 ctvRCS3nKBPnJTuycYTV4tQo0/P4aL4DUagoXtCPJQttnsfHEv21Qn11Q7LSxmJsUptV
 GHW8/Xrw+OOk6qYwg9J8WZAtA35FTwh1EsIljAl1maIc3Gum9BGzeIptIHlBxlUU5zYB kQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 34cc7kyb3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Oct 2020 13:16:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09SDAKGo179833;
        Wed, 28 Oct 2020 13:16:13 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 34cx1ryexu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Oct 2020 13:16:13 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09SDGCRj006626;
        Wed, 28 Oct 2020 13:16:12 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Oct 2020 06:16:12 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 04/20] SUNRPC: Rename svc_encode_read_payload()
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201027205327.GC4697@fieldses.org>
Date:   Wed, 28 Oct 2020 09:16:11 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D74674A4-7296-4DB6-B66B-119150D1FC71@oracle.com>
References: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
 <160373845420.1886.3075276814923041440.stgit@klimt.1015granger.net>
 <20201027205327.GC4697@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=2 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010280089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=2
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010280089
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 27, 2020, at 4:53 PM, bfields@fieldses.org wrote:
>=20
> On Mon, Oct 26, 2020 at 02:54:14PM -0400, Chuck Lever wrote:
>> Clean up: "result payload" is a less confusing name for these
>> payloads. "READ payload" reflects only the NFS usage.
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> fs/nfsd/nfs4xdr.c                        |    2 +-
>> include/linux/sunrpc/svc.h               |    6 +++---
>> include/linux/sunrpc/svc_rdma.h          |    4 ++--
>> include/linux/sunrpc/svc_xprt.h          |    4 ++--
>> net/sunrpc/svc.c                         |   11 ++++++-----
>> net/sunrpc/svcsock.c                     |    8 ++++----
>> net/sunrpc/xprtrdma/svc_rdma_sendto.c    |    8 ++++----
>> net/sunrpc/xprtrdma/svc_rdma_transport.c |    2 +-
>> 8 files changed, 23 insertions(+), 22 deletions(-)
>>=20
>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>> index 833a2c64dfe8..7e24fb3ca36e 100644
>> --- a/fs/nfsd/nfs4xdr.c
>> +++ b/fs/nfsd/nfs4xdr.c
>> @@ -3829,7 +3829,7 @@ static __be32 nfsd4_encode_readv(struct =
nfsd4_compoundres *resp,
>> 	read->rd_length =3D maxcount;
>> 	if (nfserr)
>> 		return nfserr;
>> -	if (svc_encode_read_payload(resp->rqstp, starting_len + 8, =
maxcount))
>> +	if (svc_encode_result_payload(resp->rqstp, starting_len + 8, =
maxcount))
>> 		return nfserr_io;
>=20
> Why does this call check for an error return while the
> svc_encode_result_payload() calls in the next patch don't?

Very likely an oversight. I will ensure the next patch
properly incorporates return code checking.


>=20
> --b.
>=20
>> 	xdr_truncate_encode(xdr, starting_len + 8 + =
xdr_align_size(maxcount));
>>=20
>> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
>> index 386628b36bc7..c220b734fa69 100644
>> --- a/include/linux/sunrpc/svc.h
>> +++ b/include/linux/sunrpc/svc.h
>> @@ -519,9 +519,9 @@ void		   svc_wake_up(struct svc_serv =
*);
>> void		   svc_reserve(struct svc_rqst *rqstp, int space);
>> struct svc_pool *  svc_pool_for_cpu(struct svc_serv *serv, int cpu);
>> char *		   svc_print_addr(struct svc_rqst *, char *, =
size_t);
>> -int		   svc_encode_read_payload(struct svc_rqst *rqstp,
>> -					   unsigned int offset,
>> -					   unsigned int length);
>> +int		   svc_encode_result_payload(struct svc_rqst *rqstp,
>> +					     unsigned int offset,
>> +					     unsigned int length);
>> unsigned int	   svc_fill_write_vector(struct svc_rqst *rqstp,
>> 					 struct page **pages,
>> 					 struct kvec *first, size_t =
total);
>> diff --git a/include/linux/sunrpc/svc_rdma.h =
b/include/linux/sunrpc/svc_rdma.h
>> index 9dc3a3b88391..2b870a3f391b 100644
>> --- a/include/linux/sunrpc/svc_rdma.h
>> +++ b/include/linux/sunrpc/svc_rdma.h
>> @@ -207,8 +207,8 @@ extern void svc_rdma_send_error_msg(struct =
svcxprt_rdma *rdma,
>> 				    struct svc_rdma_recv_ctxt *rctxt,
>> 				    int status);
>> extern int svc_rdma_sendto(struct svc_rqst *);
>> -extern int svc_rdma_read_payload(struct svc_rqst *rqstp, unsigned =
int offset,
>> -				 unsigned int length);
>> +extern int svc_rdma_result_payload(struct svc_rqst *rqstp, unsigned =
int offset,
>> +				   unsigned int length);
>>=20
>> /* svc_rdma_transport.c */
>> extern struct svc_xprt_class svc_rdma_class;
>> diff --git a/include/linux/sunrpc/svc_xprt.h =
b/include/linux/sunrpc/svc_xprt.h
>> index aca35ab5cff2..92455e0d5244 100644
>> --- a/include/linux/sunrpc/svc_xprt.h
>> +++ b/include/linux/sunrpc/svc_xprt.h
>> @@ -21,8 +21,8 @@ struct svc_xprt_ops {
>> 	int		(*xpo_has_wspace)(struct svc_xprt *);
>> 	int		(*xpo_recvfrom)(struct svc_rqst *);
>> 	int		(*xpo_sendto)(struct svc_rqst *);
>> -	int		(*xpo_read_payload)(struct svc_rqst *, unsigned =
int,
>> -					    unsigned int);
>> +	int		(*xpo_result_payload)(struct svc_rqst *, =
unsigned int,
>> +					      unsigned int);
>> 	void		(*xpo_release_rqst)(struct svc_rqst *);
>> 	void		(*xpo_detach)(struct svc_xprt *);
>> 	void		(*xpo_free)(struct svc_xprt *);
>> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
>> index c211b607239e..b41500645c3f 100644
>> --- a/net/sunrpc/svc.c
>> +++ b/net/sunrpc/svc.c
>> @@ -1622,7 +1622,7 @@ u32 svc_max_payload(const struct svc_rqst =
*rqstp)
>> EXPORT_SYMBOL_GPL(svc_max_payload);
>>=20
>> /**
>> - * svc_encode_read_payload - mark a range of bytes as a READ payload
>> + * svc_encode_result_payload - mark a range of bytes as a result =
payload
>>  * @rqstp: svc_rqst to operate on
>>  * @offset: payload's byte offset in rqstp->rq_res
>>  * @length: size of payload, in bytes
>> @@ -1630,12 +1630,13 @@ EXPORT_SYMBOL_GPL(svc_max_payload);
>>  * Returns zero on success, or a negative errno if a permanent
>>  * error occurred.
>>  */
>> -int svc_encode_read_payload(struct svc_rqst *rqstp, unsigned int =
offset,
>> -			    unsigned int length)
>> +int svc_encode_result_payload(struct svc_rqst *rqstp, unsigned int =
offset,
>> +			      unsigned int length)
>> {
>> -	return rqstp->rq_xprt->xpt_ops->xpo_read_payload(rqstp, offset, =
length);
>> +	return rqstp->rq_xprt->xpt_ops->xpo_result_payload(rqstp, =
offset,
>> +							   length);
>> }
>> -EXPORT_SYMBOL_GPL(svc_encode_read_payload);
>> +EXPORT_SYMBOL_GPL(svc_encode_result_payload);
>>=20
>> /**
>>  * svc_fill_write_vector - Construct data argument for VFS write call
>> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
>> index c2752e2b9ce3..b248f2349437 100644
>> --- a/net/sunrpc/svcsock.c
>> +++ b/net/sunrpc/svcsock.c
>> @@ -181,8 +181,8 @@ static void svc_set_cmsg_data(struct svc_rqst =
*rqstp, struct cmsghdr *cmh)
>> 	}
>> }
>>=20
>> -static int svc_sock_read_payload(struct svc_rqst *rqstp, unsigned =
int offset,
>> -				 unsigned int length)
>> +static int svc_sock_result_payload(struct svc_rqst *rqstp, unsigned =
int offset,
>> +				   unsigned int length)
>> {
>> 	return 0;
>> }
>> @@ -635,7 +635,7 @@ static const struct svc_xprt_ops svc_udp_ops =3D =
{
>> 	.xpo_create =3D svc_udp_create,
>> 	.xpo_recvfrom =3D svc_udp_recvfrom,
>> 	.xpo_sendto =3D svc_udp_sendto,
>> -	.xpo_read_payload =3D svc_sock_read_payload,
>> +	.xpo_result_payload =3D svc_sock_result_payload,
>> 	.xpo_release_rqst =3D svc_udp_release_rqst,
>> 	.xpo_detach =3D svc_sock_detach,
>> 	.xpo_free =3D svc_sock_free,
>> @@ -1123,7 +1123,7 @@ static const struct svc_xprt_ops svc_tcp_ops =3D =
{
>> 	.xpo_create =3D svc_tcp_create,
>> 	.xpo_recvfrom =3D svc_tcp_recvfrom,
>> 	.xpo_sendto =3D svc_tcp_sendto,
>> -	.xpo_read_payload =3D svc_sock_read_payload,
>> +	.xpo_result_payload =3D svc_sock_result_payload,
>> 	.xpo_release_rqst =3D svc_tcp_release_rqst,
>> 	.xpo_detach =3D svc_tcp_sock_detach,
>> 	.xpo_free =3D svc_sock_free,
>> diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c =
b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
>> index c3d588b149aa..c8411b4f3492 100644
>> --- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
>> +++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
>> @@ -979,19 +979,19 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
>> }
>>=20
>> /**
>> - * svc_rdma_read_payload - special processing for a READ payload
>> + * svc_rdma_result_payload - special processing for a result payload
>>  * @rqstp: svc_rqst to operate on
>>  * @offset: payload's byte offset in @xdr
>>  * @length: size of payload, in bytes
>>  *
>>  * Returns zero on success.
>>  *
>> - * For the moment, just record the xdr_buf location of the READ
>> + * For the moment, just record the xdr_buf location of the result
>>  * payload. svc_rdma_sendto will use that location later when
>>  * we actually send the payload.
>>  */
>> -int svc_rdma_read_payload(struct svc_rqst *rqstp, unsigned int =
offset,
>> -			  unsigned int length)
>> +int svc_rdma_result_payload(struct svc_rqst *rqstp, unsigned int =
offset,
>> +			    unsigned int length)
>> {
>> 	struct svc_rdma_recv_ctxt *rctxt =3D rqstp->rq_xprt_ctxt;
>>=20
>> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c =
b/net/sunrpc/xprtrdma/svc_rdma_transport.c
>> index fb044792b571..afba4e9d5425 100644
>> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
>> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
>> @@ -80,7 +80,7 @@ static const struct svc_xprt_ops svc_rdma_ops =3D {
>> 	.xpo_create =3D svc_rdma_create,
>> 	.xpo_recvfrom =3D svc_rdma_recvfrom,
>> 	.xpo_sendto =3D svc_rdma_sendto,
>> -	.xpo_read_payload =3D svc_rdma_read_payload,
>> +	.xpo_result_payload =3D svc_rdma_result_payload,
>> 	.xpo_release_rqst =3D svc_rdma_release_rqst,
>> 	.xpo_detach =3D svc_rdma_detach,
>> 	.xpo_free =3D svc_rdma_free,
>>=20

--
Chuck Lever



