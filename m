Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3D29154FE
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2019 22:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfEFUlT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 May 2019 16:41:19 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49760 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfEFUlT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 May 2019 16:41:19 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x46KECIj180846;
        Mon, 6 May 2019 20:41:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=JJqAZWjiBTobp4vOUZ+RlztycpqXDR0i4y3uUC0xlxE=;
 b=gdldZwU7GMTYRqjQMWTqKtNjILIqOJFeIdMCpCYC99eSLhEycALDfCihD8yrPVAUdm/R
 CUh78OmyeDIVqDOv6H9t+Kvyw6rFjm8v3frCbMV/wDJdf1BByiItNdV9oscLQ+77RC0k
 hD9YLoTXJ9/1/sL2vHrs8Uo6Sf6y2BOiiM3PwP0BQeSKpg3hq5A5me+nssg9zZBIrCjM
 MvY0ANkkf9o68xESBZtjlLApoF9ZEDkdTHHIvdTWpltm0WT0abzgeobz5UTJFsuNu+K9
 NYoHEW0YtVYVHQYYzDpOC+b6qXe7gCu2TmKxeqNJVc5zqxnRIAj4dFpB4A+2rVtEWkOy wA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2s94b0h3k6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 May 2019 20:41:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x46Kevqm040072;
        Mon, 6 May 2019 20:41:16 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2s94b93shq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 May 2019 20:41:16 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x46KfFuo010404;
        Mon, 6 May 2019 20:41:15 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 May 2019 13:41:15 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [RFC PATCH 5/5] SUNRPC: Reduce the priority of the xprtiod queue
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20190503111841.4391-6-trond.myklebust@hammerspace.com>
Date:   Mon, 6 May 2019 16:41:14 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <65D12050-BF24-4922-A287-3A4D981BD635@oracle.com>
References: <20190503111841.4391-1-trond.myklebust@hammerspace.com>
 <20190503111841.4391-2-trond.myklebust@hammerspace.com>
 <20190503111841.4391-3-trond.myklebust@hammerspace.com>
 <20190503111841.4391-4-trond.myklebust@hammerspace.com>
 <20190503111841.4391-5-trond.myklebust@hammerspace.com>
 <20190503111841.4391-6-trond.myklebust@hammerspace.com>
To:     Trond Myklebust <trondmy@gmail.com>
X-Mailer: Apple Mail (2.3445.104.8)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9249 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905060164
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9249 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905060164
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On May 3, 2019, at 7:18 AM, Trond Myklebust <trondmy@gmail.com> wrote:
> 
> Allow more time for softirqd

Have you thought about performance tests for this one?


> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
> net/sunrpc/sched.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
> index c7e81336620c..6b37c9a4b48f 100644
> --- a/net/sunrpc/sched.c
> +++ b/net/sunrpc/sched.c
> @@ -1253,7 +1253,7 @@ static int rpciod_start(void)
> 		goto out_failed;
> 	rpciod_workqueue = wq;
> 	/* Note: highpri because network receive is latency sensitive */

The above comment should be deleted as well.


> -	wq = alloc_workqueue("xprtiod", WQ_UNBOUND|WQ_MEM_RECLAIM|WQ_HIGHPRI, 0);
> +	wq = alloc_workqueue("xprtiod", WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
> 	if (!wq)
> 		goto free_rpciod;
> 	xprtiod_workqueue = wq;

--
Chuck Lever



