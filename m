Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758F71C41C7
	for <lists+linux-nfs@lfdr.de>; Mon,  4 May 2020 19:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730283AbgEDRON (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 May 2020 13:14:13 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40966 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730275AbgEDROL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 May 2020 13:14:11 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044HDdl0088060;
        Mon, 4 May 2020 17:14:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=Qfd+YeVStkaTAf5e75gdXl4bjZBqR9/WaM+Ppmqc6Jg=;
 b=BBSfUQku/fOOcUitUBwOkfcuaixXfQTZn+OcwMMKBU6uUKnHuvG3Kb69AjTXWa48ijjd
 wAl9fPjT1i2m0dyM3bTmHnYPOR/HCkhcwDAljHamTXlJK61/t9EI/XoBwdeRJRC8J8Nt
 /j3GjigwJqwBOOADJvPBZHN4WtQoCyHmlbgiTUwv1EgA+SlAiqKMnYdO4jbJ6c8aXPwQ
 6VUwz1uO496FHg7wcLQ3RPkM2M6LmkdMv7WoIllfCa7ugHRQGCyB+7pBrRcrIEnbiBCW
 c5Zow8SOW7aJeqIF7b+ScVyyb1EfA7IBeyNnt+ZDF1Nis2DpKhHxgiM0M9YXWRvoQIa1 Cw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 30s1gn027w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 17:14:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044HBUWJ078093;
        Mon, 4 May 2020 17:12:07 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 30sjnb8t79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 17:12:06 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 044HC4UV026807;
        Mon, 4 May 2020 17:12:05 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 10:12:04 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v1 4/4] SUNRPC: Clean up request deferral tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200504160414.GA2757@fieldses.org>
Date:   Mon, 4 May 2020 13:12:02 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0A259214-3C62-46C2-842B-8CEBDA7B9256@oracle.com>
References: <20200501171750.3764.7676.stgit@klimt.1015granger.net>
 <20200501172227.3764.74938.stgit@klimt.1015granger.net>
 <20200504160414.GA2757@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040136
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 4, 2020, at 12:04 PM, bfields@fieldses.org wrote:
>=20
> On Fri, May 01, 2020 at 01:22:27PM -0400, Chuck Lever wrote:
>> - Rename these so they are easy to enable and search for as a set
>> - Move the tracepoints to get a more accurate sense of control flow
>> - Tracepoints should not fire on xprt shutdown
>> - Display memory address in case data structure had been corrupted
>> - Abandon dprintk in these paths
>>=20
>> I haven't ever gotten one of these tracepoints to trigger. I wonder
>> if we should simply remove them.
>=20
> It's definitely not dead code.

Sure. I'm just suggesting that maybe we could make do with just a single
tracepoint here (or maybe, no tracepoints) since these paths don't seem
to trigger often.


> But I forget the conditions required to
> hit those cases.  Looking.... So, we in cache_check we have a cache =
miss
> that requires an upcall, and call cache_defer_req, which will wait for =
a
> response 1 or 5 seconds (depending on how busy server threads are) and
> then calls svc_defer().

It would be valuable to have some stock test cases in our community =
tools
that would exercise these paths.


> --b.
>=20
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> include/trace/events/sunrpc.h |   11 ++++++++---
>> net/sunrpc/svc_xprt.c         |   12 ++++++------
>> 2 files changed, 14 insertions(+), 9 deletions(-)
>>=20
>> diff --git a/include/trace/events/sunrpc.h =
b/include/trace/events/sunrpc.h
>> index ffd2215950dc..3158b3f7e01e 100644
>> --- a/include/trace/events/sunrpc.h
>> +++ b/include/trace/events/sunrpc.h
>> @@ -1313,27 +1313,32 @@ DECLARE_EVENT_CLASS(svc_deferred_event,
>> 	TP_ARGS(dr),
>>=20
>> 	TP_STRUCT__entry(
>> +		__field(const void *, dr)
>> 		__field(u32, xid)
>> 		__string(addr, dr->xprt->xpt_remotebuf)
>> 	),
>>=20
>> 	TP_fast_assign(
>> +		__entry->dr =3D dr;
>> 		__entry->xid =3D be32_to_cpu(*(__be32 *)(dr->args +
>> 						       =
(dr->xprt_hlen>>2)));
>> 		__assign_str(addr, dr->xprt->xpt_remotebuf);
>> 	),
>>=20
>> -	TP_printk("addr=3D%s xid=3D0x%08x", __get_str(addr), =
__entry->xid)
>> +	TP_printk("addr=3D%s dr=3D%p xid=3D0x%08x", __get_str(addr), =
__entry->dr,
>> +		__entry->xid)
>> );
>> +
>> #define DEFINE_SVC_DEFERRED_EVENT(name) \
>> -	DEFINE_EVENT(svc_deferred_event, svc_##name##_deferred, \
>> +	DEFINE_EVENT(svc_deferred_event, svc_defer_##name, \
>> 			TP_PROTO( \
>> 				const struct svc_deferred_req *dr \
>> 			), \
>> 			TP_ARGS(dr))
>>=20
>> DEFINE_SVC_DEFERRED_EVENT(drop);
>> -DEFINE_SVC_DEFERRED_EVENT(revisit);
>> +DEFINE_SVC_DEFERRED_EVENT(queue);
>> +DEFINE_SVC_DEFERRED_EVENT(recv);
>>=20
>> DECLARE_EVENT_CLASS(cache_event,
>> 	TP_PROTO(
>> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
>> index 2284ff038dad..e12ec68cd0ff 100644
>> --- a/net/sunrpc/svc_xprt.c
>> +++ b/net/sunrpc/svc_xprt.c
>> @@ -1158,16 +1158,15 @@ static void svc_revisit(struct =
cache_deferred_req *dreq, int too_many)
>> 	set_bit(XPT_DEFERRED, &xprt->xpt_flags);
>> 	if (too_many || test_bit(XPT_DEAD, &xprt->xpt_flags)) {
>> 		spin_unlock(&xprt->xpt_lock);
>> -		dprintk("revisit canceled\n");
>> +		trace_svc_defer_drop(dr);
>> 		svc_xprt_put(xprt);
>> -		trace_svc_drop_deferred(dr);
>> 		kfree(dr);
>> 		return;
>> 	}
>> -	dprintk("revisit queued\n");
>> 	dr->xprt =3D NULL;
>> 	list_add(&dr->handle.recent, &xprt->xpt_deferred);
>> 	spin_unlock(&xprt->xpt_lock);
>> +	trace_svc_defer_queue(dr);
>> 	svc_xprt_enqueue(xprt);
>> 	svc_xprt_put(xprt);
>> }
>> @@ -1213,22 +1212,24 @@ static struct cache_deferred_req =
*svc_defer(struct cache_req *req)
>> 		memcpy(dr->args, rqstp->rq_arg.head[0].iov_base - skip,
>> 		       dr->argslen << 2);
>> 	}
>> +	trace_svc_defer(rqstp);
>> 	svc_xprt_get(rqstp->rq_xprt);
>> 	dr->xprt =3D rqstp->rq_xprt;
>> 	set_bit(RQ_DROPME, &rqstp->rq_flags);
>>=20
>> 	dr->handle.revisit =3D svc_revisit;
>> -	trace_svc_defer(rqstp);
>> 	return &dr->handle;
>> }
>>=20
>> /*
>>  * recv data from a deferred request into an active one
>>  */
>> -static int svc_deferred_recv(struct svc_rqst *rqstp)
>> +static noinline int svc_deferred_recv(struct svc_rqst *rqstp)
>> {
>> 	struct svc_deferred_req *dr =3D rqstp->rq_deferred;
>>=20
>> +	trace_svc_defer_recv(dr);
>> +
>> 	/* setup iov_base past transport header */
>> 	rqstp->rq_arg.head[0].iov_base =3D dr->args + =
(dr->xprt_hlen>>2);
>> 	/* The iov_len does not include the transport header bytes */
>> @@ -1259,7 +1260,6 @@ static struct svc_deferred_req =
*svc_deferred_dequeue(struct svc_xprt *xprt)
>> 				struct svc_deferred_req,
>> 				handle.recent);
>> 		list_del_init(&dr->handle.recent);
>> -		trace_svc_revisit_deferred(dr);
>> 	} else
>> 		clear_bit(XPT_DEFERRED, &xprt->xpt_flags);
>> 	spin_unlock(&xprt->xpt_lock);

--
Chuck Lever



