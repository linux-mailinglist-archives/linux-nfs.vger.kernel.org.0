Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2530215EEF
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jul 2020 20:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbgGFSlj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jul 2020 14:41:39 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:32870 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729569AbgGFSlj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jul 2020 14:41:39 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 066IfQQU142946;
        Mon, 6 Jul 2020 18:41:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=3S4xP6KupOf6p3yAQkJLtEBOo72VsNyZ22XVQ8SARng=;
 b=qSHvHPCw/a30B853cvcAM6zV3DfvdBXgNam79vnI5wJqBP0o9IV2CtL8rbSkVijMfkGf
 n1yDoZ8aY32IW/nXXy41UqqCqh+QKWQnLAiNhapcwMAxFSf4/4RUozeCy2VlLQDMIgWN
 szGllK+adQESeFpYQQNx4nbVeXqBhtDMldJL5/RvHxBggoRgPzvgDdIUqPJlARmyRUEs
 2sVGuDEflia7xqQ7k9djz4eEv35h54/Cf9Z/KFfe8EpzokycHSvGRoSG2BAsGmmi3BDB
 y/ib6D8TwRocwi/GKwTwP9NObCti0TrUjIMo79WuhRWwW1nBa3AbGiC/0yosvWN40b+b og== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 323sxxmf8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 06 Jul 2020 18:41:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 066IdLJZ034892;
        Mon, 6 Jul 2020 18:41:35 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 3233p0jy9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jul 2020 18:41:35 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 066IfYxZ027479;
        Mon, 6 Jul 2020 18:41:34 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Jul 2020 11:41:34 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: [PATCH v1 0/4] Fix more issues in new connect logic
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200627162911.22826.34426.stgit@manet.1015granger.net>
Date:   Mon, 6 Jul 2020 14:41:33 -0400
Cc:     Dan Aloni <dan@kernelim.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <441C4FBC-31AF-4F29-B77F-C67814DA7957@oracle.com>
References: <20200627162911.22826.34426.stgit@manet.1015granger.net>
To:     Anna Schumaker <anna.schumaker@netapp.com>
X-Mailer: Apple Mail (2.3445.104.14)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9674 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 mlxlogscore=999
 mlxscore=0 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007060128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9674 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 adultscore=0 cotscore=-2147483648 phishscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 suspectscore=2 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007060128
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Anna, I haven't found any additional issues with this series that
can't wait until 5.9 or later. Can you see that it gets into 5.8-rc ?
Thanks!


> On Jun 27, 2020, at 12:34 PM, Chuck Lever <chuck.lever@oracle.com> wrote:
> 
> This series addresses several more flaws in the recent overhaul of
> the client's RPC/RDMA connect logic. More testing is called for,
> but these are ready for review. They apply on the fixes that were
> pulled into Linus' tree yesterday.
> 
> See also the "cel-testing" topic branch in my kernel repo:
> 
>  git://git.linux-nfs.org/projects/cel/cel-2.6.git
> 
> ---
> 
> Chuck Lever (4):
>      xprtrdma: Fix double-free in rpcrdma_ep_create()
>      xprtrdma: Fix recursion into rpcrdma_xprt_disconnect()
>      xprtrdma: Fix return code from rpcrdma_xprt_connect()
>      xprtrdma: Fix handling of connect errors
> 
> 
> net/sunrpc/xprtrdma/transport.c |  5 +++++
> net/sunrpc/xprtrdma/verbs.c     | 28 ++++++++++++++--------------
> 2 files changed, 19 insertions(+), 14 deletions(-)
> 
> --
> Chuck Lever

--
Chuck Lever



