Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E180720B468
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2020 17:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbgFZPWo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Jun 2020 11:22:44 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45716 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgFZPWn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Jun 2020 11:22:43 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05QFC1fC137807;
        Fri, 26 Jun 2020 15:22:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=VRXjSgwILCb0XZqesktrKdC3K2n3l6DDbQpIiLTByoI=;
 b=jDKtJBQKKVRi10mA7pxTeIGNrG6cybgBawUpSs0AVLO8My8kjuuhg+u/zr1CmyOfqt/q
 pfzpHuM0XorsqoQjgkMnD7x/3YQkO7E+2iUQdcmEEpgpOzJZYbzSe0uKug67MKhVD+ya
 Rmul9NsI7Ci/rJgWV+WXLItu/hLMZnEkyBAG0nM8tM7vMR3a37COTW6YL3x3zPxHCkhl
 2zAIOmAZ3ISPcGK7c9a0zwHREcj9kIuXi5VqCPopXwYNoki15CUQ/lDYMlQabhn8WuB6
 z/g//BpFy5p/j1RGzSadMc7j2qauO9VQkevKti9igmtwqP7w+y96bDJI2g3T29sJcNvh RQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 31uusu6phm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Jun 2020 15:22:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05QFDYBh111843;
        Fri, 26 Jun 2020 15:22:40 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 31uuru9vt5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Jun 2020 15:22:40 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05QFMdY4000438;
        Fri, 26 Jun 2020 15:22:39 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 26 Jun 2020 15:22:39 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: [PATCH] xprtrdma: fix EP destruction logic
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200626151052.6cckaquyu7k3nd6b@gmail.com>
Date:   Fri, 26 Jun 2020 11:22:37 -0400
Cc:     linux-rdma@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <9A5CDAC4-69AF-45F2-8574-F749499CA500@oracle.com>
References: <0E2AA9D9-2503-462C-952D-FC0DD5111BD1@oracle.com>
 <20200626071034.34805-1-dan@kernelim.com>
 <FEB41A86-87EB-44BD-BEC4-6EAB3723B426@oracle.com>
 <20200626151052.6cckaquyu7k3nd6b@gmail.com>
To:     Dan Aloni <dan@kernelim.com>
X-Mailer: Apple Mail (2.3445.104.14)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9664 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006260107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9664 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 cotscore=-2147483648 malwarescore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006260107
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 26, 2020, at 11:10 AM, Dan Aloni <dan@kernelim.com> wrote:
> 
> On Fri, Jun 26, 2020 at 08:56:41AM -0400, Chuck Lever wrote:
>>> On Jun 26, 2020, at 3:10 AM, Dan Aloni <dan@kernelim.com> wrote:
> [..]
>>> - Add a mutex in `rpcrdma_ep_destroy` to guard against concurrent calls
>>> to `rpcrdma_xprt_disconnect` coming from either `rpcrdma_xprt_connect`
>>> or `xprt_rdma_close`.
>> 
>> NAK. The RPC client provides appropriate exclusion, please let's not
>> add more serialization that can introduce further deadlocks.
> 
> It appeared to me that this exclusion does not works well. As for my
> considerations, if I am not mistaken from analyzing crashes I've
> seen:
> 
>   -> xprt_autoclose (running on xprtiod)
>     -> xprt->ops->close
>       -> xprt_rdma_close
>         -> rpcrdma_xprt_disconnect
> 
> and:
> 
>    -> xprt_rdma_connect_worker (running on xprtiod)
>      -> rpcrdma_xprt_connect
> 	-> rpcrdma_xprt_disconnect
> 
> I understand the rationale or at least the aim that `close` and
> `connect` ops should not be concurrent on the same `xprt`, however:
> 
> * `xprt_force_disconnect`, is called from various places, queues
>  a call to `xprt_autoclose` to the background on `xprtiod` workqueue item,
>  conditioned that `!XPRT_LOCKED` which is the case for connect that went
>  to the background.
> * `xprt_rdma_connect` also sends `xprt_rdma_connect_worker` as an `xprtiod`
>  workqueue item, unconditionally.
> 
> So we have two work items that can run in parallel, and I don't see
> clear gating on this from the code.

If close and connect are being called concurrently on the same xprt,
then there is a bug in the generic RPC xprt code. I don't believe
that to be the case here.

If xprtrdma invokes force_disconnect during connect processing,
XPRT_LOCKED should be held and the close should be delayed.


> Maybe there's a simpler fix for this. Perhaps a
> `cancel_delayed_work_sync(&r_xprt->rx_connect_worker);` is appropriate
> in `xprt_rdma_close`?

There are simpler, less deadlock-prone, and more justifiable fixes.
Please stand by, I will take care of this today.

--
Chuck Lever



