Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E4D2809A6
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Oct 2020 23:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbgJAVuP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Oct 2020 17:50:15 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47768 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbgJAVuP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Oct 2020 17:50:15 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 091LnHYF180057;
        Thu, 1 Oct 2020 21:50:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=fnrvyi8ew1rQLuffNfHg2JOLKKAsZebYSZ2vAc5l+0k=;
 b=yNTPjdIGv0UGkLHVe0Ye5WeegpqWZtqUTUf/lcgBkABOjZLL3NegQ5ct5+FSFjDCg6cE
 F4f4iFrwYxDQFeNeRulW/LeFnoIf4zxrl/eibQTeXVpTiAynrecsu+qpvvEOtDsah2Mj
 h4BjHD1QrG2REivJ7x3aHgZhcW7m5bPlhBMt7WApZhuRs6QgjArhbeC4kkC23j1Z7MbV
 xDdsjJ9MJ2p59+pjFb+NMWWvQBMROomK9Z30ckQEMcE6Om/zdGR60mFxRWdGzezTK1Ma
 nxKdfv6yRVxHmr8okDv67RcCNndBjBnRnsY9cxyUbjcmBXLQIcol+SwuZwQ7OcxQTXsC pA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 33sx9ngg79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 01 Oct 2020 21:50:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 091LV0Ue058349;
        Thu, 1 Oct 2020 21:48:12 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 33uv2hg2h1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Oct 2020 21:48:12 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 091Lm8x1032744;
        Thu, 1 Oct 2020 21:48:10 GMT
Received: from dhcp-10-154-97-134.vpn.oracle.com (/10.154.97.134)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 01 Oct 2020 14:48:08 -0700
Subject: Re: [PATCH 0/1] NFSv4.2: Fix NFS4ERR_STALE with inter server copy
To:     Bruce Fields <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org
References: <20200923230606.63904-1-dai.ngo@oracle.com>
 <e7e738c6-f6e7-0d04-07fa-8017da469b8a@oracle.com>
 <20201001205119.GI1496@fieldses.org>
From:   Dai Ngo <dai.ngo@oracle.com>
Message-ID: <9a60ba5b-aefe-d75b-683a-fa0f4db6ae24@oracle.com>
Date:   Thu, 1 Oct 2020 14:48:07 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201001205119.GI1496@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9761 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=3 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010010172
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9761 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=3
 phishscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010010173
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks Bruce for your comments,

On 10/1/20 1:51 PM, Bruce Fields wrote:
> On Tue, Sep 29, 2020 at 08:18:54PM -0700, Dai Ngo wrote:
>> Have you had chance to review this patch and if it's ok would it be
>> possible to include it in the 5.10 pull?
> I don't think the op table approach would be that difficult, I'd really
> rather see that.

I think if we do the op table approach then we should also try to solve
all other dependencies between various NFS client and server modules
and not just the SSC part. It might be a little involved so I'd like
to take some time to research before committing to the longer solution
which I plan to do. In the mean time, this small patch allows some of
us to use the inter server copy until the long term solution is available.

> Is this causing someone an immediate practical problem?

This causes inter server copy to fail with any kernel build with NFS_FS=m
which I think is a common config. And it also causes compile errors if
NFSD=y, NFS_FS=y and NFS_v4=m.

-Dai

>
> --b.
>
>> Thanks,
>>
>> -Dai
>>
>> On 9/23/20 4:06 PM, Dai Ngo wrote:
>>> This patch provides a temporarily relief for inter copy to work with
>>> some common configs.  For long term solution, I think Trond's suggestion
>>> of using fs/nfs/nfs_common to store an op table that server can use to
>>> access the client code is the way to go.
>>>
>>>   fs/nfsd/Kconfig | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>>
>>> Below are the results of my testing of upstream mainline without and with the fix.
>>>
>>> Upstream version used for testing:  5.9-rc5
>>>
>>> 1. Upstream mainline (existing code: NFS_FS=y)
>>>
>>>
>>> |----------------------------------------------------------------------------------------|
>>> |  NFSD  |  NFS_FS  |  NFS_V4  |               RESULTS                                   |
>>> |----------------------------------------------------------------------------------------|
>>> |   y    |    y     |    m     | Build errors: nfs42_ssc_open/close                      |
>>> |----------------------------------------------------------------------------------------|
>>> |   y    |    m     |    m     | Build OK, inter server copy failed with NFS4ERR_STALE   |
>>> |        |          |          | See NOTE1.                                              |
>>> |----------------------------------------------------------------------------------------|
>>> |   y    |    m     |   y (m)  | Build OK, inter server copy failed with NFS4ERR_STALE   |
>>> |        |          |          | See NOTE2.                                              |
>>> |----------------------------------------------------------------------------------------|
>>> |   y    |    y     |    y     | Build OK, inter server copy OK                          |
>>> |----------------------------------------------------------------------------------------|
>>>
>>>
>>> |----------------------------------------------------------------------------------------|
>>> |  NFSD  |  NFS_FS  |  NFS_V4  |               RESULTS                                   |
>>> |----------------------------------------------------------------------------------------|
>>> |   m    |    y     |    m     | Build OK, inter server copy OK                          |
>>> |----------------------------------------------------------------------------------------|
>>> |   m    |    m     |    m     | Build OK, inter server copy failed with NFS4ERR_STALE   |
>>> |----------------------------------------------------------------------------------------|
>>> |   m    |    m     |   y (m)  | Build OK, inter server copy failed with NFS4ERR_STALE   |
>>> |----------------------------------------------------------------------------------------|
>>> |   m    |    y     |    y     | Build OK, inter server copy OK                          |
>>> |----------------------------------------------------------------------------------------|
>>>
>>> 2. Upstream mainline (with the fix:  !(NFSD=y && (NFS_FS=m || NFS_V4=m))
>>>
>>>
>>> |----------------------------------------------------------------------------------------|
>>> |  NFSD  |  NFS_FS  |  NFS_V4  |               RESULTS                                   |
>>> |----------------------------------------------------------------------------------------|
>>> |   m    |    y     |    m     | Build OK, inter server copy OK                          |
>>> |----------------------------------------------------------------------------------------|
>>> |   m    |    m     |    m     | Build OK, inter server copy OK                          |
>>> |----------------------------------------------------------------------------------------|
>>> |   m    |    m     |   y (m)  | Build OK, inter server copy OK                          |
>>> |----------------------------------------------------------------------------------------|
>>> |   m    |    y     |    y     | Build OK, inter server copy OK                          |
>>> |----------------------------------------------------------------------------------------|
>>>
>>>
>>> |----------------------------------------------------------------------------------------|
>>> |  NFSD  |  NFS_FS  |  NFS_V4  |               RESULTS                                   |
>>> |----------------------------------------------------------------------------------------|
>>> |   y    |    y     |    m     | Build OK, inter server copy failed with NFS4ERR_STALE   |
>>> |----------------------------------------------------------------------------------------|
>>> |   y    |    m     |    m     | Build OK, inter server copy failed with NFS4ERR_STALE   |
>>> |----------------------------------------------------------------------------------------|
>>> |   y    |    m     |   y (m)  | Build OK, inter server copy failed with NFS4ERR_STALE   |
>>> |----------------------------------------------------------------------------------------|
>>> |   y    |    y     |    y     | Build OK, inter server copy OK                          |
>>> |----------------------------------------------------------------------------------------|
>>>
>>> NOTE1:
>>> BUG:  When inter server copy fails with NFS4ERR_STALE, it left the file
>>> created with size of 0!
>>>
>>> NOTE2:
>>> When NFS_V4=y and NFS_FS=m, the build process automatically builds with NFS_V4=m
>>> and ignores the setting NFS_V4=y in the config file.
>>>
>>> This probably due to NFS_V4 in fs/nfs/Kconfig is configured to depend on NFS_FS.
>>>
