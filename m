Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A420F1A35FB
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Apr 2020 16:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbgDIOdk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Apr 2020 10:33:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37290 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbgDIOdj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Apr 2020 10:33:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 039ESRjt034767;
        Thu, 9 Apr 2020 14:33:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=CTK5K77z6Hpr8cDPWFsjpnm6LfnfL3Go0+q6yJOxAEw=;
 b=hhLXQwv8+ehqjGBRWioG0cjO1pLcMStNDpt0e8f+ak6HkmvUy0g/iV53NdXyCFW0aTMi
 Rhc/yJc5EC6ZVqR0QFmifW+j4TQ1nxQpMx7+sEH5hu06N7zmnKdO80nadE82GDA2R0/J
 Wi9Ywl2lQzbJbYAX6M+ef4BXu5v2eRQhFPhLjc079VtLbYwB63bl6qvXJgKrmzFkVNYf
 59v0W7dzWsCMxCswJW17BF9PHYYH1CWw6FlkDaiJrF35q0extX/rTd5jTXQt0ZesbSAV
 twc7LLPuMdTBkyuVlEsw4snzqI8sZMFsC8kdRbo6HRWgDvlKz2DsElkH7aJmvTS7rMae Ew== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 3091m3hux5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Apr 2020 14:33:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 039EWd8u049056;
        Thu, 9 Apr 2020 14:33:36 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 309gdbuek2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Apr 2020 14:33:35 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 039EXYfD018410;
        Thu, 9 Apr 2020 14:33:34 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 Apr 2020 07:33:34 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v1 3/3] svcrdma: Fix leak of svc_rdma_recv_ctxt objects
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200408060242.GB3310@unreal>
Date:   Thu, 9 Apr 2020 10:33:32 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D3CFDCAA-589C-4B3F-B769-099BF775D098@oracle.com>
References: <20200407190938.24045.64947.stgit@klimt.1015granger.net>
 <20200407191106.24045.88035.stgit@klimt.1015granger.net>
 <20200408060242.GB3310@unreal>
To:     Leon Romanovsky <leon@kernel.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9586 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004090114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9586 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004090113
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Leon-

> On Apr 8, 2020, at 2:02 AM, Leon Romanovsky <leon@kernel.org> wrote:
>=20
> On Tue, Apr 07, 2020 at 03:11:06PM -0400, Chuck Lever wrote:
>> Utilize the xpo_release_rqst transport method to ensure that each
>> rqstp's svc_rdma_recv_ctxt object is released even when the server
>> cannot return a Reply for that rqstp.
>>=20
>> Without this fix, each RPC whose Reply cannot be sent leaks one
>> svc_rdma_recv_ctxt. This is a 2.5KB structure, a 4KB DMA-mapped
>> Receive buffer, and any pages that might be part of the Reply
>> message.
>>=20
>> The leak is infrequent unless the network fabric is unreliable or
>> Kerberos is in use, as GSS sequence window overruns, which result
>> in connection loss, are more common on fast transports.
>>=20
>> Fixes: 3a88092ee319 ("svcrdma: Preserve Receive buffer until ... ")
>=20
> Chuck,
>=20
> Can you please don't mangle the Fixes line?

I've read e-mail from others that advocate this form of mangling
instead of using commit message lines that are too long.


> A lot of automatization is relying on the fact that this line is =
canonical,
> both in format and in the actual content.

Understood, but checkpatch.pl does not complain about it. Perhaps,
therefore, it is the automation that is not correct.

The commit ID is what automation should key off of. The short
description is only for human consumption. In fact, the short
description can easily be reconstituted from the commit ID. The
reverse cannot be done reliably.

I'm not interested in bike-shedding this, however, so I will try
to remember to use complete short descriptions when posting to
linux-rdma.


> Thanks
>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> include/linux/sunrpc/svc_rdma.h          |    1 +
>> net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  |   22 =
++++++++++++++++++++++
>> net/sunrpc/xprtrdma/svc_rdma_sendto.c    |   13 +++----------
>> net/sunrpc/xprtrdma/svc_rdma_transport.c |    5 -----
>> 4 files changed, 26 insertions(+), 15 deletions(-)
>>=20
>> diff --git a/include/linux/sunrpc/svc_rdma.h =
b/include/linux/sunrpc/svc_rdma.h
>> index 78fe2ac6dc6c..cbcfbd0521e3 100644
>> --- a/include/linux/sunrpc/svc_rdma.h
>> +++ b/include/linux/sunrpc/svc_rdma.h
>> @@ -170,6 +170,7 @@ extern bool svc_rdma_post_recvs(struct =
svcxprt_rdma *rdma);
>> extern void svc_rdma_recv_ctxt_put(struct svcxprt_rdma *rdma,
>> 				   struct svc_rdma_recv_ctxt *ctxt);
>> extern void svc_rdma_flush_recv_queues(struct svcxprt_rdma *rdma);
>> +extern void svc_rdma_release_rqst(struct svc_rqst *rqstp);
>> extern int svc_rdma_recvfrom(struct svc_rqst *);
>>=20
>> /* svc_rdma_rw.c */
>> diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c =
b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
>> index 54469b72b25f..efa5fcb5793f 100644
>> --- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
>> +++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
>> @@ -223,6 +223,26 @@ void svc_rdma_recv_ctxt_put(struct svcxprt_rdma =
*rdma,
>> 		svc_rdma_recv_ctxt_destroy(rdma, ctxt);
>> }
>>=20
>> +/**
>> + * svc_rdma_release_rqst - Release transport-specific per-rqst =
resources
>> + * @rqstp: svc_rqst being released
>> + *
>> + * Ensure that the recv_ctxt is released whether or not a Reply
>> + * was sent. For example, the client could close the connection,
>> + * or svc_process could drop an RPC, before the Reply is sent.
>> + */
>> +void svc_rdma_release_rqst(struct svc_rqst *rqstp)
>> +{
>> +	struct svc_rdma_recv_ctxt *ctxt =3D rqstp->rq_xprt_ctxt;
>> +	struct svc_xprt *xprt =3D rqstp->rq_xprt;
>> +	struct svcxprt_rdma *rdma =3D
>> +		container_of(xprt, struct svcxprt_rdma, sc_xprt);
>> +
>> +	rqstp->rq_xprt_ctxt =3D NULL;
>> +	if (ctxt)
>> +		svc_rdma_recv_ctxt_put(rdma, ctxt);
>> +}
>> +
>> static int __svc_rdma_post_recv(struct svcxprt_rdma *rdma,
>> 				struct svc_rdma_recv_ctxt *ctxt)
>> {
>> @@ -820,6 +840,8 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
>> 	__be32 *p;
>> 	int ret;
>>=20
>> +	rqstp->rq_xprt_ctxt =3D NULL;
>> +
>> 	spin_lock(&rdma_xprt->sc_rq_dto_lock);
>> 	ctxt =3D =
svc_rdma_next_recv_ctxt(&rdma_xprt->sc_read_complete_q);
>> 	if (ctxt) {
>> diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c =
b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
>> index 6a87a2379e91..b6c8643867f2 100644
>> --- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
>> +++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
>> @@ -926,12 +926,7 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
>> 	ret =3D svc_rdma_send_reply_msg(rdma, sctxt, rctxt, rqstp);
>> 	if (ret < 0)
>> 		goto err1;
>> -	ret =3D 0;
>> -
>> -out:
>> -	rqstp->rq_xprt_ctxt =3D NULL;
>> -	svc_rdma_recv_ctxt_put(rdma, rctxt);
>> -	return ret;
>> +	return 0;
>>=20
>>  err2:
>> 	if (ret !=3D -E2BIG && ret !=3D -EINVAL)
>> @@ -940,16 +935,14 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
>> 	ret =3D svc_rdma_send_error_msg(rdma, sctxt, rqstp);
>> 	if (ret < 0)
>> 		goto err1;
>> -	ret =3D 0;
>> -	goto out;
>> +	return 0;
>>=20
>>  err1:
>> 	svc_rdma_send_ctxt_put(rdma, sctxt);
>>  err0:
>> 	trace_svcrdma_send_failed(rqstp, ret);
>> 	set_bit(XPT_CLOSE, &xprt->xpt_flags);
>> -	ret =3D -ENOTCONN;
>> -	goto out;
>> +	return -ENOTCONN;
>> }
>>=20
>> /**
>> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c =
b/net/sunrpc/xprtrdma/svc_rdma_transport.c
>> index 8bb99980ae85..ea54785db4f8 100644
>> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
>> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
>> @@ -71,7 +71,6 @@ static struct svc_xprt *svc_rdma_create(struct =
svc_serv *serv,
>> 					struct sockaddr *sa, int salen,
>> 					int flags);
>> static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt);
>> -static void svc_rdma_release_rqst(struct svc_rqst *);
>> static void svc_rdma_detach(struct svc_xprt *xprt);
>> static void svc_rdma_free(struct svc_xprt *xprt);
>> static int svc_rdma_has_wspace(struct svc_xprt *xprt);
>> @@ -552,10 +551,6 @@ static struct svc_xprt *svc_rdma_accept(struct =
svc_xprt *xprt)
>> 	return NULL;
>> }
>>=20
>> -static void svc_rdma_release_rqst(struct svc_rqst *rqstp)
>> -{
>> -}
>> -
>> /*
>>  * When connected, an svc_xprt has at least two references:
>>  *

--
Chuck Lever



