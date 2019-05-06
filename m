Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6F371538E
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2019 20:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfEFSW0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 May 2019 14:22:26 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48372 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfEFSW0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 May 2019 14:22:26 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x46IJIN1085600;
        Mon, 6 May 2019 18:22:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=oDbwnI3l1K0MIOPjeGab0oahGhi5Gz+Po8dE8jMLnCo=;
 b=z2gQjW+CUfOWVfW+0Wb7c6WP2fm7pg8/8udUEDUmpZh2GIvebjisWRK2S+l/567s0tts
 vG/LAWI21JVEqd3NKhAlBLCrcgn2QYyCfwOBylwj9jPrO5OSl9gzZxqzVW4vf9RXbaND
 USDDGwnJ572DdaFRRMeTUHpnQdVaJ2pQnBVCZRmaJBI6hM4l1hSMAEkzSOcJS5wURl+B
 TwBwUPIwUi7jBw/HAYUnXVtm44/D3P08JkNp68j8G96GCZUPs0vl9vOb8oyKxVz2+hqH
 Xq1JbVuTOecHXTVGRKN9+f9gQpJ3mgH+QLF2154hVdGy1nueEN7Xrl26G4pX5k6zM32W xQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2s94b0gdku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 May 2019 18:22:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x46ILr11131036;
        Mon, 6 May 2019 18:22:23 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2sagytgjtw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 May 2019 18:22:23 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x46IMMie007130;
        Mon, 6 May 2019 18:22:22 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 May 2019 11:22:22 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [RFC PATCH 0/5] bh-safe lock removal for SUNRPC
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20190503111841.4391-1-trond.myklebust@hammerspace.com>
Date:   Mon, 6 May 2019 14:22:21 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <39608ABA-9E3F-443A-9F4C-7B91B885C7DD@oracle.com>
References: <20190503111841.4391-1-trond.myklebust@hammerspace.com>
To:     Trond Myklebust <trondmy@gmail.com>
X-Mailer: Apple Mail (2.3445.104.8)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9249 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905060153
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9249 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905060153
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond-

> On May 3, 2019, at 7:18 AM, Trond Myklebust <trondmy@gmail.com> wrote:
> 
> This patchset aims to remove the bh-safe locks on the client side.
> At this time it should be seen as a toy/strawman effort in order to
> help the community figure out whether or not there are setups out
> there that are actually seeing performance bottlenecks resulting
> from taking bh-safe locks inside other spinlocks.

What kernel does this patch set apply to? I've tried both v5.0 and
v5.1, but there appear to be some changes that I'm missing. The
first patch does not apply cleanly.


> Trond Myklebust (5):
>  SUNRPC: Replace the queue timer with a delayed work function
>  SUNRPC: Replace direct task wakeups from softirq context
>  SUNRPC: Remove the bh-safe lock requirement on xprt->transport_lock
>  SUNRPC: Remove the bh-safe lock requirement on the
>    rpc_wait_queue->lock
>  SUNRPC: Reduce the priority of the xprtiod queue
> 
> include/linux/sunrpc/sched.h               |   3 +-
> include/linux/sunrpc/xprtsock.h            |   5 +
> net/sunrpc/sched.c                         |  76 +++++++++-------
> net/sunrpc/xprt.c                          |  61 ++++++-------
> net/sunrpc/xprtrdma/rpc_rdma.c             |   4 +-
> net/sunrpc/xprtrdma/svc_rdma_backchannel.c |   4 +-
> net/sunrpc/xprtrdma/svc_rdma_transport.c   |   8 +-
> net/sunrpc/xprtsock.c                      | 101 +++++++++++++++++----
> 8 files changed, 168 insertions(+), 94 deletions(-)
> 
> -- 
> 2.21.0
> 

--
Chuck Lever



