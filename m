Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259452459E4
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Aug 2020 00:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgHPW26 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 16 Aug 2020 18:28:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54696 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgHPW26 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 16 Aug 2020 18:28:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07GMSFe2068964;
        Sun, 16 Aug 2020 22:28:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=lVP8f/OKvfDTYVkq2QaiG5DPahnQ6Mj+iJnzUjW+Bco=;
 b=qx2UfwrqtV/q15E67Egd9deswtNd0iA+o4YCpGB1/6+jAJTzjDAmG1W2MTxPqs5A7UOo
 orromiO+ivWKT2Pe/0Wt1PlmketA5hSqBFpEKvFkILizSCdcbFtnqo5YCVxLXR9gmmHk
 xdaS2WFctaqfWDlizWlLSAwuXlq5Nz9B6E5N32HM2wwVLzeuTDdpGYl2hBbks7EvyUeE
 u42fCTWEkRosRDJ9044gJKdkKF8fN8S8gBP4QeuzlYvQ+9roVE5Zq6qonAAtbmZ/oYlz
 GffFBwmcDYFvL7nDpbQHx2mCtmUhuNaU/oP13B6n25EjW5nicW8oSqqY1JSgSCio0H/S IA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 32x74qus4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 16 Aug 2020 22:28:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07GMRc0B005423;
        Sun, 16 Aug 2020 22:28:54 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 32xskxepkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 16 Aug 2020 22:28:54 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07GMSrS8017593;
        Sun, 16 Aug 2020 22:28:53 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 16 Aug 2020 15:28:53 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] xprtrdma: make sure MRs are unmapped before freeing them
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200815054535.GA3337941@gmail.com>
Date:   Sun, 16 Aug 2020 18:28:51 -0400
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <7DBE9EA2-A700-498F-A713-652B19321F8B@oracle.com>
References: <20200814173734.3271600-1-dan@kernelim.com>
 <5B87C3B5-B73D-40FD-A813-B3929CDF7583@oracle.com>
 <20200814191056.GA3277556@gmail.com>
 <DA35C71E-101D-45F6-A5BE-23493F7119C0@oracle.com>
 <20200815054535.GA3337941@gmail.com>
To:     Dan Aloni <dan@kernelim.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9715 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008160187
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9715 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008160187
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 15, 2020, at 1:45 AM, Dan Aloni <dan@kernelim.com> wrote:
> 
> On Fri, Aug 14, 2020 at 04:21:54PM -0400, Chuck Lever wrote:
>> 
>> 
>>> On Aug 14, 2020, at 3:10 PM, Dan Aloni <dan@kernelim.com> wrote:
>>> 
>>> On Fri, Aug 14, 2020 at 02:12:48PM -0400, Chuck Lever wrote:
>>>> Hi Dan-
>>>> 
>>>>> On Aug 14, 2020, at 1:37 PM, Dan Aloni <dan@kernelim.com> wrote:
>>>>> 
>>>>> It was observed that on disconnections, these unmaps don't occur. The
>>>>> relevant path is rpcrdma_mrs_destroy(), being called from
>>>>> rpcrdma_xprt_disconnect().
>>>> 
>>>> MRs are supposed to be unmapped right after they are used, so
>>>> during disconnect they should all be unmapped already. How often
>>>> do you see a DMA mapped MR in this code path? Do you have a
>>>> reproducer I can try?
>>> 
>>> These are not graceful disconnections but abnormal ones, where many large
>>> IOs are still in flight, while the remote server suddenly breaks the
>>> connection, the remote IP is still reachable but refusing to accept new
>>> connections only for a few seconds.
>> 
>> Ideally that's not supposed to matter. I'll see if I can reproduce
>> with my usual tricks.
>> 
>> Why is your server behaving this way?
> 
> It's a dedicated storage cluster under a specific testing scenario,
> implementing floating IPs.  Haven't tried, but maybe the same scenario
> can be reproduced with a standard single Linux NFSv3 server by fiddling
> with nfsd open ports.

Hi Dan, I was able to reproduce the DMA-map leak with a simple server-side
disconnect injection test. I'll try some root cause analysis tomorrow.


--
Chuck Lever



