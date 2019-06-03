Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7286338E3
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jun 2019 21:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfFCTIe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jun 2019 15:08:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37436 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfFCTIe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Jun 2019 15:08:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x53J48WR001158;
        Mon, 3 Jun 2019 19:08:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=rgCzRf70Ou+ZvsF8smaABJBbf7J4vUjF99dB6hWx8dA=;
 b=bhahQh2Kp5R1pyUW/gKEeKQQC1K9PdDnoYhwUBryHRxDuFZ9FTDx2bIr5AUuzTAnh/5/
 ChAXdKA1Fy8z6r15P3reNveCryVkUL17cJRLtycG4ULBs9MMxXnmdH3+EPJNnhm/4hh+
 /6+xFejNczAWwbnQRKRDWKQsE4s6VBLPyY1AlxLgulKbPcAiIY6r6eL9Vh53LExJctoW
 dc6NNxfuXBVBtGtYbXuZ56Szc4VfGBgRxynxeMeFGLyhh5F3iItPJKaKSEOI9IBXVFs7
 LYZG8L6x0DagouNOqzNR/RQ7KtSwGnOnfLkQxT8cKsZnX/5wh5vpASxpSDkRi5nJLRzP Sw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2suj0q8u2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jun 2019 19:08:11 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x53J7wOB081453;
        Mon, 3 Jun 2019 19:08:11 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2svbbv9rck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jun 2019 19:08:11 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x53J8AZS028285;
        Mon, 3 Jun 2019 19:08:10 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Jun 2019 12:08:10 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 3/3] SUNRPC: Count ops completing with tk_status < 0
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <1aa781ed6185ea61bed1efb7c8012dc543e3dc3f.camel@redhat.com>
Date:   Mon, 3 Jun 2019 15:08:08 -0400
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4891A3DA-0814-4657-A61B-FAC23E132EF0@oracle.com>
References: <20190523201351.12232-1-dwysocha@redhat.com>
 <20190523201351.12232-3-dwysocha@redhat.com>
 <20190530213857.GA24802@fieldses.org>
 <9B9F0C9B-C493-44F5-ABD1-6B2B4BAA2F08@oracle.com>
 <20190530223314.GA25368@fieldses.org>
 <CD3B0503-ABA0-4670-9A76-0B9DF0AE5B5C@oracle.com>
 <f7976bde9979e8b763c0009b523331ab5ce6b6ed.camel@redhat.com>
 <5CE8A68E-F5C2-4321-8F57-451F5E5AF789@oracle.com>
 <1aa781ed6185ea61bed1efb7c8012dc543e3dc3f.camel@redhat.com>
To:     Dave Wysochanski <dwysocha@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9277 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906030129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9277 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906030129
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 3, 2019, at 3:05 PM, Dave Wysochanski <dwysocha@redhat.com> =
wrote:
>=20
> On Mon, 2019-06-03 at 14:56 -0400, Chuck Lever wrote:
>>> On Jun 3, 2019, at 2:53 PM, Dave Wysochanski <dwysocha@redhat.com>
>>> wrote:
>>>=20
>>> On Fri, 2019-05-31 at 09:25 -0400, Chuck Lever wrote:
>>>>> On May 30, 2019, at 6:33 PM, Bruce Fields <bfields@fieldses.org
>>>>>>=20
>>>>> wrote:
>>>>>=20
>>>>> On Thu, May 30, 2019 at 06:19:54PM -0400, Chuck Lever wrote:
>>>>>>=20
>>>>>>=20
>>>>>>> On May 30, 2019, at 5:38 PM, bfields@fieldses.org wrote:
>>>>>>>=20
>>>>>>> On Thu, May 23, 2019 at 04:13:50PM -0400, Dave Wysochanski
>>>>>>> wrote:
>>>>>>>> We often see various error conditions with NFS4.x that
>>>>>>>> show
>>>>>>>> up with
>>>>>>>> a very high operation count all completing with tk_status
>>>>>>>> < 0
>>>>>>>> in a
>>>>>>>> short period of time.  Add a count to rpc_iostats to
>>>>>>>> record
>>>>>>>> on a
>>>>>>>> per-op basis the ops that complete in this manner, which
>>>>>>>> will
>>>>>>>> enable lower overhead diagnostics.
>>>>>>>=20
>>>>>>> Looks like a good idea to me.
>>>>>>>=20
>>>>>>> It's too bad we can't distinguish the errors.  (E.g. ESTALE
>>>>>>> on
>>>>>>> a lookup
>>>>>>> call is a lot more interesting than ENOENT.)  But
>>>>>>> understood
>>>>>>> that
>>>>>>> maintaining (number of possible errors) * (number of
>>>>>>> possible
>>>>>>> ops)
>>>>>>> counters is probably overkill, so just counting the number
>>>>>>> of
>>>>>>> errors
>>>>>>> seems like a good start.
>>>>>>=20
>>>>>> We now have trace points that can do that too.
>>>>>=20
>>>>> You mean, that can report every error (and its value)?
>>>>=20
>>>> Yes, the nfs_xdr_status trace point reports the error by value
>>>> and
>>>> symbolic name.
>>>>=20
>>>=20
>>> The tracepoint is very useful I agree.  I don't think it will show:
>>> a) the mount
>>> b) the opcode
>>>=20
>>> Or am I mistaken and there's a way to get those with a filter or
>>> another tracepoint?
>>=20
>> The opcode can be exposed by another trace point, but the link
>> between
>> the two trace points is tenuous and could be improved.
>>=20
>=20
> I think the number is there but it's not decoded!  This was for a =
WRITE
> completing with BAD_STATEID - very nice:
>=20
>   kworker/u16:0-31130 [006] .... 949028.602298: nfs4_xdr_status: =
operation 38: nfs status -10025 (BAD_STATEID)

OK, I'm smarter than I look. This shows the NFS operation,
not the RPC procedure (which would be NFS4 COMPOUND), which
is the right thing to do.


>> I don't believe any of the NFS trace points expose the mount. My
>> testing
>> is largely on a single mount so my imagination stopped there.
>>=20
>=20
> Ok thanks for the confirmation.

Well, it's something worth thinking carefully about: if
you see a slick way to make that information available,
have at it.


>>>>> I assume having these statistics in mountstats is still useful,
>>>>> though.
>>>>>=20
>>>>> --b.
>>>>>=20
>>>>>>=20
>>>>>>=20
>>>>>>> --b.
>>>>>>>=20
>>>>>>>>=20
>>>>>>>> Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
>>>>>>>> ---
>>>>>>>> include/linux/sunrpc/metrics.h | 7 ++++++-
>>>>>>>> net/sunrpc/stats.c             | 8 ++++++--
>>>>>>>> 2 files changed, 12 insertions(+), 3 deletions(-)
>>>>>>>>=20
>>>>>>>> diff --git a/include/linux/sunrpc/metrics.h
>>>>>>>> b/include/linux/sunrpc/metrics.h
>>>>>>>> index 1b3751327575..0ee3f7052846 100644
>>>>>>>> --- a/include/linux/sunrpc/metrics.h
>>>>>>>> +++ b/include/linux/sunrpc/metrics.h
>>>>>>>> @@ -30,7 +30,7 @@
>>>>>>>> #include <linux/ktime.h>
>>>>>>>> #include <linux/spinlock.h>
>>>>>>>>=20
>>>>>>>> -#define RPC_IOSTATS_VERS	"1.0"
>>>>>>>> +#define RPC_IOSTATS_VERS	"1.1"
>>>>>>>>=20
>>>>>>>> struct rpc_iostats {
>>>>>>>> 	spinlock_t		om_lock;
>>>>>>>> @@ -66,6 +66,11 @@ struct rpc_iostats {
>>>>>>>> 	ktime_t			om_queue,	/* queued
>>>>>>>> for
>>>>>>>> xmit */
>>>>>>>> 				om_rtt,		/* RPC
>>>>>>>> RTT */
>>>>>>>> 				om_execute;	/* RPC
>>>>>>>> execution */
>>>>>>>> +	/*
>>>>>>>> +	 * The count of operations that complete with tk_status
>>>>>>>> < 0.
>>>>>>>> +	 * These statuses usually indicate error conditions.
>>>>>>>> +	 */
>>>>>>>> +	unsigned long           om_error_status;
>>>>>>>> } ____cacheline_aligned;
>>>>>>>>=20
>>>>>>>> struct rpc_task;
>>>>>>>> diff --git a/net/sunrpc/stats.c b/net/sunrpc/stats.c
>>>>>>>> index 8b2d3c58ffae..737414247ca7 100644
>>>>>>>> --- a/net/sunrpc/stats.c
>>>>>>>> +++ b/net/sunrpc/stats.c
>>>>>>>> @@ -176,6 +176,8 @@ void rpc_count_iostats_metrics(const
>>>>>>>> struct rpc_task *task,
>>>>>>>>=20
>>>>>>>> 	execute =3D ktime_sub(now, task->tk_start);
>>>>>>>> 	op_metrics->om_execute =3D ktime_add(op_metrics-
>>>>>>>>> om_execute, execute);
>>>>>>>>=20
>>>>>>>> +	if (task->tk_status < 0)
>>>>>>>> +		op_metrics->om_error_status++;
>>>>>>>>=20
>>>>>>>> 	spin_unlock(&op_metrics->om_lock);
>>>>>>>>=20
>>>>>>>> @@ -218,13 +220,14 @@ static void _add_rpc_iostats(struct
>>>>>>>> rpc_iostats *a, struct rpc_iostats *b)
>>>>>>>> 	a->om_queue =3D ktime_add(a->om_queue, b->om_queue);
>>>>>>>> 	a->om_rtt =3D ktime_add(a->om_rtt, b->om_rtt);
>>>>>>>> 	a->om_execute =3D ktime_add(a->om_execute, b-
>>>>>>>>> om_execute);
>>>>>>>>=20
>>>>>>>> +	a->om_error_status +=3D b->om_error_status;
>>>>>>>> }
>>>>>>>>=20
>>>>>>>> static void _print_rpc_iostats(struct seq_file *seq,
>>>>>>>> struct
>>>>>>>> rpc_iostats *stats,
>>>>>>>> 			       int op, const struct
>>>>>>>> rpc_procinfo *procs)
>>>>>>>> {
>>>>>>>> 	_print_name(seq, op, procs);
>>>>>>>> -	seq_printf(seq, "%lu %lu %lu %llu %llu %llu %llu
>>>>>>>> %llu\n",
>>>>>>>> +	seq_printf(seq, "%lu %lu %lu %llu %llu %llu %llu %llu
>>>>>>>> %lu\n",
>>>>>>>> 		   stats->om_ops,
>>>>>>>> 		   stats->om_ntrans,
>>>>>>>> 		   stats->om_timeouts,
>>>>>>>> @@ -232,7 +235,8 @@ static void _print_rpc_iostats(struct
>>>>>>>> seq_file *seq, struct rpc_iostats *stats,
>>>>>>>> 		   stats->om_bytes_recv,
>>>>>>>> 		   ktime_to_ms(stats->om_queue),
>>>>>>>> 		   ktime_to_ms(stats->om_rtt),
>>>>>>>> -		   ktime_to_ms(stats->om_execute));
>>>>>>>> +		   ktime_to_ms(stats->om_execute),
>>>>>>>> +		   stats->om_error_status);
>>>>>>>> }
>>>>>>>>=20
>>>>>>>> void rpc_clnt_show_stats(struct seq_file *seq, struct
>>>>>>>> rpc_clnt *clnt)
>>>>>>>> --=20
>>>>>>>> 2.20.1
>>>>>>=20
>>>>>> --
>>>>>> Chuck Lever
>>>>=20
>>>> --
>>>> Chuck Lever
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



