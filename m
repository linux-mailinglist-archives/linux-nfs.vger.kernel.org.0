Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A243F244F23
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Aug 2020 22:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgHNUWA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Aug 2020 16:22:00 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42786 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbgHNUV7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Aug 2020 16:21:59 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07EKHLbV130254;
        Fri, 14 Aug 2020 20:21:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=DjWlbfsGkk4PZ5YJPYHUHaVDHzhnIr8SzeFiFx6WQXU=;
 b=tzHUdvpLkbV8OrTLgt9W7aeu1ODKd24f8zrgC7nVkMCd2/qeYUfSi+uVtWqtRalar4xl
 AcZpZjaXKbkQxkLyg5rTZ75gUidf/vA1BNwByuNovLtT04igHfdvj6Otemb/VgxPi8Xj
 tNsygHM+LXdP7RP4EoaE3Y3rXCKl4EPG5JivxTgJRohKiyC2aRPOQLS3RAd97MWGXHr3
 aFnaLbQC4vZ+/ZSqWalw1JmPvWnUjzzdvUudvn3Zl7CaePPR88Mh7mVZcfX+rwUmVlUx
 J6PoJHks3nueCAsjnIv4M2Pxjw1QSJqE34/O9Qc4KaXSjbWDO5lEPbbWxoRjbFSAmcQ1 9Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 32wvp11hv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Aug 2020 20:21:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07EKHxl6115081;
        Fri, 14 Aug 2020 20:21:57 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 32wvqjjrfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Aug 2020 20:21:56 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07EKLu4p017443;
        Fri, 14 Aug 2020 20:21:56 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 Aug 2020 20:21:55 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] xprtrdma: make sure MRs are unmapped before freeing them
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200814191056.GA3277556@gmail.com>
Date:   Fri, 14 Aug 2020 16:21:54 -0400
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <DA35C71E-101D-45F6-A5BE-23493F7119C0@oracle.com>
References: <20200814173734.3271600-1-dan@kernelim.com>
 <5B87C3B5-B73D-40FD-A813-B3929CDF7583@oracle.com>
 <20200814191056.GA3277556@gmail.com>
To:     Dan Aloni <dan@kernelim.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9713 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008140149
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9713 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008140149
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 14, 2020, at 3:10 PM, Dan Aloni <dan@kernelim.com> wrote:
> 
> On Fri, Aug 14, 2020 at 02:12:48PM -0400, Chuck Lever wrote:
>> Hi Dan-
>> 
>>> On Aug 14, 2020, at 1:37 PM, Dan Aloni <dan@kernelim.com> wrote:
>>> 
>>> It was observed that on disconnections, these unmaps don't occur. The
>>> relevant path is rpcrdma_mrs_destroy(), being called from
>>> rpcrdma_xprt_disconnect().
>> 
>> MRs are supposed to be unmapped right after they are used, so
>> during disconnect they should all be unmapped already. How often
>> do you see a DMA mapped MR in this code path? Do you have a
>> reproducer I can try?
> 
> These are not graceful disconnections but abnormal ones, where many large
> IOs are still in flight, while the remote server suddenly breaks the
> connection, the remote IP is still reachable but refusing to accept new
> connections only for a few seconds.

Ideally that's not supposed to matter. I'll see if I can reproduce
with my usual tricks.

Why is your server behaving this way?


> We may also need reconnection attempts in the background trying to
> recover the xprt, so that with short reconnect timeouts it may be enough
> for xprt_rdma_close() to be triggered from xprt_rdma_connect_worker(),
> leading up to rpcrdma_xprt_disconnect().

--
Chuck Lever



