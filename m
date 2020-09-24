Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C1C27661A
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Sep 2020 03:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgIXB44 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Sep 2020 21:56:56 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56708 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIXB4z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Sep 2020 21:56:55 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08O1niue171639
        for <linux-nfs@vger.kernel.org>; Thu, 24 Sep 2020 01:57:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=/gGsIMKIkCxqNfCwyV+iU59njUfs2imFA4wjzj47rKA=;
 b=L6epNEAXA7liXG6dnZsT6Ixnodzj4m3a+5ugVZdY24nfBbMTDzNd8NJcnlrTUTGDM2S6
 1T3J95mtdrnZA786jNS26bzBTCqCabEybVN+A7WhgwTcHGIGUgvbOzKlaekDY4Sx2pmY
 KAT6o8ikn0DELLZFlAOyRjq70osbygAgOSGMkpYFTEgGK9ebl1DLM0Z5dTWIIaXEceGh
 205ESvzvsrnsOd2YWxCpOxCqSZuHDfHGpoOltzdAxiH2NP4EEHp7qcDP2AlTBkjdztsJ
 3IIUGOhB+jKk9JMMXrLCrHH70Yw4RyjdqW/B5CsuiSEF4mqoo57nJbwbxdqxKotKmg+4 Mw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 33q5rgkxk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-nfs@vger.kernel.org>; Thu, 24 Sep 2020 01:57:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08O1uegB145295
        for <linux-nfs@vger.kernel.org>; Thu, 24 Sep 2020 01:57:07 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 33nurvhsab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Thu, 24 Sep 2020 01:57:07 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08O1v687001987
        for <linux-nfs@vger.kernel.org>; Thu, 24 Sep 2020 01:57:06 GMT
Received: from dhcp-10-154-115-235.vpn.oracle.com (/10.154.115.235)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 23 Sep 2020 18:57:06 -0700
Subject: Re: [PATCH 0/1] NFSv4.2: Fix NFS4ERR_STALE with inter server copy
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
References: <20200923230606.63904-1-dai.ngo@oracle.com>
 <3DC24A5C-81BB-4F70-B123-3A737DB10F81@oracle.com>
From:   Dai Ngo <dai.ngo@oracle.com>
Message-ID: <43606759-0ae9-1bf6-3ac0-7c5ed14e9bfe@oracle.com>
Date:   Wed, 23 Sep 2020 18:57:05 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <3DC24A5C-81BB-4F70-B123-3A737DB10F81@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=3
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240013
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 impostorscore=0
 clxscore=1015 suspectscore=3 phishscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240012
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Oops, sorry about that Chuck!

-Dai

On 9/23/20 4:29 PM, Chuck Lever wrote:
> Dai, the tables are still backwards! 😄
>
> --
> Chuck Lever
>
>> On Sep 23, 2020, at 7:06 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>> ﻿This patch provides a temporarily relief for inter copy to work with
>> some common configs.  For long term solution, I think Trond's suggestion
>> of using fs/nfs/nfs_common to store an op table that server can use to
>> access the client code is the way to go.
>>
>> fs/nfsd/Kconfig | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>>
>> Below are the results of my testing of upstream mainline without and with the fix.
>>
>> Upstream version used for testing:  5.9-rc5
>>
>> 1. Upstream mainline (existing code: NFS_FS=y)
>>
>>
>> |----------------------------------------------------------------------------------------|
>> |  NFSD  |  NFS_FS  |  NFS_V4  |               RESULTS                                   |
>> |----------------------------------------------------------------------------------------|
>> |   y    |    y     |    m     | Build errors: nfs42_ssc_open/close                      |
>> |----------------------------------------------------------------------------------------|
>> |   y    |    m     |    m     | Build OK, inter server copy failed with NFS4ERR_STALE   |
>> |        |          |          | See NOTE1.                                              |
>> |----------------------------------------------------------------------------------------|
>> |   y    |    m     |   y (m)  | Build OK, inter server copy failed with NFS4ERR_STALE   |
>> |        |          |          | See NOTE2.                                              |
>> |----------------------------------------------------------------------------------------|
>> |   y    |    y     |    y     | Build OK, inter server copy OK                          |
>> |----------------------------------------------------------------------------------------|
>>
>>
>> |----------------------------------------------------------------------------------------|
>> |  NFSD  |  NFS_FS  |  NFS_V4  |               RESULTS                                   |
>> |----------------------------------------------------------------------------------------|
>> |   m    |    y     |    m     | Build OK, inter server copy OK                          |
>> |----------------------------------------------------------------------------------------|
>> |   m    |    m     |    m     | Build OK, inter server copy failed with NFS4ERR_STALE   |
>> |----------------------------------------------------------------------------------------|
>> |   m    |    m     |   y (m)  | Build OK, inter server copy failed with NFS4ERR_STALE   |
>> |----------------------------------------------------------------------------------------|
>> |   m    |    y     |    y     | Build OK, inter server copy OK                          |
>> |----------------------------------------------------------------------------------------|
>>
>> 2. Upstream mainline (with the fix:  !(NFSD=y && (NFS_FS=m || NFS_V4=m))
>>
>>
>> |----------------------------------------------------------------------------------------|
>> |  NFSD  |  NFS_FS  |  NFS_V4  |               RESULTS                                   |
>> |----------------------------------------------------------------------------------------|
>> |   m    |    y     |    m     | Build OK, inter server copy OK                          |
>> |----------------------------------------------------------------------------------------|
>> |   m    |    m     |    m     | Build OK, inter server copy OK                          |
>> |----------------------------------------------------------------------------------------|
>> |   m    |    m     |   y (m)  | Build OK, inter server copy OK                          |
>> |----------------------------------------------------------------------------------------|
>> |   m    |    y     |    y     | Build OK, inter server copy OK                          |
>> |----------------------------------------------------------------------------------------|
>>
>>
>> |----------------------------------------------------------------------------------------|
>> |  NFSD  |  NFS_FS  |  NFS_V4  |               RESULTS                                   |
>> |----------------------------------------------------------------------------------------|
>> |   y    |    y     |    m     | Build OK, inter server copy failed with NFS4ERR_STALE   |
>> |----------------------------------------------------------------------------------------|
>> |   y    |    m     |    m     | Build OK, inter server copy failed with NFS4ERR_STALE   |
>> |----------------------------------------------------------------------------------------|
>> |   y    |    m     |   y (m)  | Build OK, inter server copy failed with NFS4ERR_STALE   |
>> |----------------------------------------------------------------------------------------|
>> |   y    |    y     |    y     | Build OK, inter server copy OK                          |
>> |----------------------------------------------------------------------------------------|
>>
>> NOTE1:
>> BUG:  When inter server copy fails with NFS4ERR_STALE, it left the file
>> created with size of 0!
>>
>> NOTE2:
>> When NFS_V4=y and NFS_FS=m, the build process automatically builds with NFS_V4=m
>> and ignores the setting NFS_V4=y in the config file.
>>
>> This probably due to NFS_V4 in fs/nfs/Kconfig is configured to depend on NFS_FS.
>>
