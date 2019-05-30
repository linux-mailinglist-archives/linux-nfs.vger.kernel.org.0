Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3A7D304B5
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2019 00:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfE3WWN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 May 2019 18:22:13 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:50942 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfE3WWN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 May 2019 18:22:13 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4UMET6r185179;
        Thu, 30 May 2019 22:21:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=GcMESSnAQ+HniH7Gh+0pgmkIRfYwte4nAquaNE+N9ZY=;
 b=L6i48P4oe1Edbarn9wa5aU5p+yeANpbqmzHf8TPGG8ZTKxxg6KpMN7Qlr7XPKdmR1SdY
 tAca4mSJAQCe+u5sK9AE6tNFzUsHeew/1OIl6Sn4QvNWI9JpT5lOr+i//Y6JQ3bETxhE
 7urZTwttuohtdUHXDQpCEu5FE9dSL/3bZLaGSC/F8hjXRf+OyU3maXr6eQlATAepcSZO
 kqc92odnC3cRLzIypWl/ZOSWksGKrgimP0qr7BG7TXE9HMQjGmhGAEP/byKLoiAeohWb
 JrzCRD3BfhnnrbJbSKbMoNEI1WSGQ7cdd2vjUhwGII9CV18JZ36q2iYdZKPwbP6kpZxg yQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2spu7du6tg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 22:21:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4UMJZek065489;
        Thu, 30 May 2019 22:19:57 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2ss1fpb4e6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 22:19:57 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4UMJuAk031854;
        Thu, 30 May 2019 22:19:56 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 May 2019 15:19:56 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 3/3] SUNRPC: Count ops completing with tk_status < 0
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20190530213857.GA24802@fieldses.org>
Date:   Thu, 30 May 2019 18:19:54 -0400
Cc:     Dave Wysochanski <dwysocha@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9B9F0C9B-C493-44F5-ABD1-6B2B4BAA2F08@oracle.com>
References: <20190523201351.12232-1-dwysocha@redhat.com>
 <20190523201351.12232-3-dwysocha@redhat.com>
 <20190530213857.GA24802@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9273 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905300155
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9273 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905300155
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 30, 2019, at 5:38 PM, bfields@fieldses.org wrote:
>=20
> On Thu, May 23, 2019 at 04:13:50PM -0400, Dave Wysochanski wrote:
>> We often see various error conditions with NFS4.x that show up with
>> a very high operation count all completing with tk_status < 0 in a
>> short period of time.  Add a count to rpc_iostats to record on a
>> per-op basis the ops that complete in this manner, which will
>> enable lower overhead diagnostics.
>=20
> Looks like a good idea to me.
>=20
> It's too bad we can't distinguish the errors.  (E.g. ESTALE on a =
lookup
> call is a lot more interesting than ENOENT.)  But understood that
> maintaining (number of possible errors) * (number of possible ops)
> counters is probably overkill, so just counting the number of errors
> seems like a good start.

We now have trace points that can do that too.


> --b.
>=20
>>=20
>> Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
>> ---
>> include/linux/sunrpc/metrics.h | 7 ++++++-
>> net/sunrpc/stats.c             | 8 ++++++--
>> 2 files changed, 12 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/include/linux/sunrpc/metrics.h =
b/include/linux/sunrpc/metrics.h
>> index 1b3751327575..0ee3f7052846 100644
>> --- a/include/linux/sunrpc/metrics.h
>> +++ b/include/linux/sunrpc/metrics.h
>> @@ -30,7 +30,7 @@
>> #include <linux/ktime.h>
>> #include <linux/spinlock.h>
>>=20
>> -#define RPC_IOSTATS_VERS	"1.0"
>> +#define RPC_IOSTATS_VERS	"1.1"
>>=20
>> struct rpc_iostats {
>> 	spinlock_t		om_lock;
>> @@ -66,6 +66,11 @@ struct rpc_iostats {
>> 	ktime_t			om_queue,	/* queued for xmit */
>> 				om_rtt,		/* RPC RTT */
>> 				om_execute;	/* RPC execution */
>> +	/*
>> +	 * The count of operations that complete with tk_status < 0.
>> +	 * These statuses usually indicate error conditions.
>> +	 */
>> +	unsigned long           om_error_status;
>> } ____cacheline_aligned;
>>=20
>> struct rpc_task;
>> diff --git a/net/sunrpc/stats.c b/net/sunrpc/stats.c
>> index 8b2d3c58ffae..737414247ca7 100644
>> --- a/net/sunrpc/stats.c
>> +++ b/net/sunrpc/stats.c
>> @@ -176,6 +176,8 @@ void rpc_count_iostats_metrics(const struct =
rpc_task *task,
>>=20
>> 	execute =3D ktime_sub(now, task->tk_start);
>> 	op_metrics->om_execute =3D ktime_add(op_metrics->om_execute, =
execute);
>> +	if (task->tk_status < 0)
>> +		op_metrics->om_error_status++;
>>=20
>> 	spin_unlock(&op_metrics->om_lock);
>>=20
>> @@ -218,13 +220,14 @@ static void _add_rpc_iostats(struct rpc_iostats =
*a, struct rpc_iostats *b)
>> 	a->om_queue =3D ktime_add(a->om_queue, b->om_queue);
>> 	a->om_rtt =3D ktime_add(a->om_rtt, b->om_rtt);
>> 	a->om_execute =3D ktime_add(a->om_execute, b->om_execute);
>> +	a->om_error_status +=3D b->om_error_status;
>> }
>>=20
>> static void _print_rpc_iostats(struct seq_file *seq, struct =
rpc_iostats *stats,
>> 			       int op, const struct rpc_procinfo *procs)
>> {
>> 	_print_name(seq, op, procs);
>> -	seq_printf(seq, "%lu %lu %lu %llu %llu %llu %llu %llu\n",
>> +	seq_printf(seq, "%lu %lu %lu %llu %llu %llu %llu %llu %lu\n",
>> 		   stats->om_ops,
>> 		   stats->om_ntrans,
>> 		   stats->om_timeouts,
>> @@ -232,7 +235,8 @@ static void _print_rpc_iostats(struct seq_file =
*seq, struct rpc_iostats *stats,
>> 		   stats->om_bytes_recv,
>> 		   ktime_to_ms(stats->om_queue),
>> 		   ktime_to_ms(stats->om_rtt),
>> -		   ktime_to_ms(stats->om_execute));
>> +		   ktime_to_ms(stats->om_execute),
>> +		   stats->om_error_status);
>> }
>>=20
>> void rpc_clnt_show_stats(struct seq_file *seq, struct rpc_clnt *clnt)
>> --=20
>> 2.20.1

--
Chuck Lever



