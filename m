Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045C11B64AC
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2020 21:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgDWToA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Apr 2020 15:44:00 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33304 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgDWToA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Apr 2020 15:44:00 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03NJIgSL134304;
        Thu, 23 Apr 2020 19:43:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=3NkQHJR+uQIhXOgJg2kzFK8YY1ZbqU+ENJdRg3kjx64=;
 b=yMUdbFr3kOnwS7hLcmxN5m1PQ8LA4SWc1IanMRhn0xMOh6Ejrfz9Sj/yuwpfq0HogQ3D
 7fQIMAEMSOAh/qm7DcGYwe0PTVPlbsiPPacFnRrUIpDcLQPgGdMMD1vdoWE4IlWCeb01
 Ix2ybHrztVgtWrlr819630cW7ouxOEqwAhN/G6xwfxdaOyNPjUZsVIYrjsh4GB98fnU4
 0QE6hyvGzfMOIDfgDpTbn6VZgH7xokDSj4qj0lWfgUP9++mUacuMAciuNOMG2t2LCj38
 6mQRuMhjaLuh1EcFAECj2zz/sK5YeJW9GC0GikoXnhkGyaQs6xGYvEXjekmA6cQ6XdsD +g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 30ketdgume-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Apr 2020 19:43:56 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03NJfhxT167468;
        Thu, 23 Apr 2020 19:43:55 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 30gb3w59ga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Apr 2020 19:43:55 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03NJhsPb019773;
        Thu, 23 Apr 2020 19:43:54 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 23 Apr 2020 12:43:54 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH RFC2 2/2] sunrpc: Ensure signalled RPC tasks exit
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200423194317.7849.3375.stgit@manet.1015granger.net>
Date:   Thu, 23 Apr 2020 15:43:53 -0400
Cc:     trondmy@hammerspace.com,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <D66F6DAA-CAB4-42A3-8E2D-38EB53055654@oracle.com>
References: <20200423194311.7849.36326.stgit@manet.1015granger.net>
 <20200423194317.7849.3375.stgit@manet.1015granger.net>
To:     Chuck Lever <chuck.lever@oracle.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9600 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004230147
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9600 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004230146
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Sigh.

I forgot to set the command line flag to compose a cover letter.
Let me get to that.


> On Apr 23, 2020, at 3:43 PM, Chuck Lever <chuck.lever@oracle.com> wrote:
> 
> If an RPC task is signaled while it is running and the transport is
> not connected, it will never sleep and never be terminated. This can
> happen when a RPC transport is shut down: the remaining tasks are
> signalled, but the transport is disconnected.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
> include/linux/sunrpc/sched.h |    3 ++-
> net/sunrpc/sched.c           |   14 ++++++--------
> 2 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
> index df696efdd675..9f5e48f154c5 100644
> --- a/include/linux/sunrpc/sched.h
> +++ b/include/linux/sunrpc/sched.h
> @@ -170,7 +170,8 @@ struct rpc_task_setup {
> 
> #define RPC_IS_ACTIVATED(t)	test_bit(RPC_TASK_ACTIVE, &(t)->tk_runstate)
> 
> -#define RPC_SIGNALLED(t)	test_bit(RPC_TASK_SIGNALLED, &(t)->tk_runstate)
> +#define RPC_SIGNALLED(t)	\
> +	unlikely(test_bit(RPC_TASK_SIGNALLED, &(t)->tk_runstate) != 0)
> 
> /*
>  * Task priorities.
> diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
> index 7eba20a88438..99b7b834a110 100644
> --- a/net/sunrpc/sched.c
> +++ b/net/sunrpc/sched.c
> @@ -912,6 +912,12 @@ static void __rpc_execute(struct rpc_task *task)
> 		trace_rpc_task_run_action(task, do_action);
> 		do_action(task);
> 
> +		if (RPC_SIGNALLED(task)) {
> +			task->tk_rpc_status = -ERESTARTSYS;
> +			rpc_exit(task, -ERESTARTSYS);
> +			break;
> +		}
> +
> 		/*
> 		 * Lockless check for whether task is sleeping or not.
> 		 */
> @@ -919,14 +925,6 @@ static void __rpc_execute(struct rpc_task *task)
> 			continue;
> 
> 		/*
> -		 * Signalled tasks should exit rather than sleep.
> -		 */
> -		if (RPC_SIGNALLED(task)) {
> -			task->tk_rpc_status = -ERESTARTSYS;
> -			rpc_exit(task, -ERESTARTSYS);
> -		}
> -
> -		/*
> 		 * The queue->lock protects against races with
> 		 * rpc_make_runnable().
> 		 *
> 

--
Chuck Lever



