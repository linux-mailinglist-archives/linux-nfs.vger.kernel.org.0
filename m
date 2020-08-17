Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C701246E3C
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Aug 2020 19:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389807AbgHQR0R (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Aug 2020 13:26:17 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33928 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390061AbgHQR0H (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Aug 2020 13:26:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07HHMAqE183413;
        Mon, 17 Aug 2020 17:25:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=yJnm27QNs3bXTn5r/vqDmrcKyhoK1fjjWPz5rTHbnsk=;
 b=X7dcva2AzmRVXS+VMTWHZHGtcHHm+b847eqx/dwezOtAHJKP4Kxd8rrX3yyrdIZNjbOh
 MKPGces/+9+GHL/dZp24e9ywACEdwlGtfshUw+aDruKTVchcgHB9F1GJvYpqoqzTVoTZ
 5csuCtBveMRp1OOtWNg7Y+austubFcZJGp5IvA6lc55bnBinss6k49HPXrz79d5sxQq7
 VJy79YO0vbd8A6WkXGgWEferA8MEffSwK+ERnDaYIaylFRk/HuXIGG/gysvUColG/zQx
 JT/P/0tfhjkHenokaicWoYVJdhnFcIGrFamIAUxRMYyC38+xTAYQcy7PZ0vSfFMrA6xb xg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 32x74r07uh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Aug 2020 17:25:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07HHMtIX163387;
        Mon, 17 Aug 2020 17:25:47 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 32xsmw6f0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Aug 2020 17:25:47 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07HHPenK027269;
        Mon, 17 Aug 2020 17:25:46 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 17 Aug 2020 10:25:40 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH v1 00/22] SUNRPC: Replace dprintk calls with tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200708200121.22129.92375.stgit@manet.1015granger.net>
Date:   Mon, 17 Aug 2020 13:25:38 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <242E6FB6-6C7F-4529-A4B4-B8248152F448@oracle.com>
References: <20200708200121.22129.92375.stgit@manet.1015granger.net>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9716 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008170126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9716 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008170126
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Jul 8, 2020, at 4:08 PM, Chuck Lever <chuck.lever@oracle.com> wrote:
> 
> Hi-
> 
> This series replaces many client-side RPC dprintk call sites with
> tracepoints. The goals of this series are:
> 
> - Replace chatty dprintk call sites with tracepoints, which can
>  handle a higher event rate, and won't get rate-limited.
> 
> - At some later point, expand the 0-64K range of RPC task IDs.
>  Task IDs would be displayed only by tracepoints as 32-bit unsigned
>  integers.
> 
> - Eliminate redundant tracepoints in the transport implementations.

None of the patches in this series made it into v5.9. I don't recall
seeing any feedback on these either. Can they be considered for v5.10?


> ---
> 
> Chuck Lever (22):
>      SUNRPC: Remove trace_xprt_complete_rqst()
>      SUNRPC: Hoist trace_xprtrdma_op_allocate into generic code
>      SUNRPC: Remove debugging instrumentation from xprt_release
>      SUNRPC: Update debugging instrumentation in xprt_do_reserve()
>      SUNRPC: Replace dprintk() call site in xprt_prepare_transmit
>      SUNRPC: Replace dprintk() call site in xs_nospace()
>      SUNRPC: Remove the dprint_status() macro
>      SUNRPC: Remove dprintk call site in call_start()
>      SUNRPC: Replace connect dprintk call sites with a tracepoint
>      SUNRPC: Mitigate cond_resched() in xprt_transmit()
>      SUNRPC: Add trace_rpc_timeout_status()
>      SUNRPC: Trace call_refresh events
>      SUNRPC: Remove dprintk call site in call_decode
>      SUNRPC: Clean up call_bind_status() observability
>      SUNRPC: Remove rpcb_getport_async dprintk call sites
>      SUNRPC: Hoist trace_xprtrdma_op_setport into generic code
>      SUNRPC: Remove dprintk call sites in rpcbind XDR functions
>      SUNRPC: Remove more dprintks in rpcb_clnt.c
>      SUNRPC: Replace rpcbind dprintk call sites with tracepoints
>      SUNRPC: Clean up RPC scheduler tracepoints
>      SUNRPC: Remove dprintk call sites in RPC queuing functions
>      SUNRPC: Remove remaining dprintks from sched.c
> 
> 
> include/trace/events/rpcrdma.h  |  63 -------
> include/trace/events/sunrpc.h   | 285 ++++++++++++++++++++++++++++----
> net/sunrpc/clnt.c               |  75 ++-------
> net/sunrpc/rpcb_clnt.c          | 129 +++------------
> net/sunrpc/sched.c              |  52 +-----
> net/sunrpc/xprt.c               |  22 +--
> net/sunrpc/xprtrdma/transport.c |   7 -
> net/sunrpc/xprtsock.c           |   5 +-
> 8 files changed, 304 insertions(+), 334 deletions(-)
> 
> --
> Chuck Lever

--
Chuck Lever



