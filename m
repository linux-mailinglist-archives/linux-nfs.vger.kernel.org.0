Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D02817C251
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Mar 2020 16:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgCFP4o (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Mar 2020 10:56:44 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:53314 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgCFP4o (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Mar 2020 10:56:44 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 026Fs0Mk132456;
        Fri, 6 Mar 2020 15:56:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=GA2JMjUKfPoqn20Q0YPtUNc/T/Qbw8z3YI92LT2a/QI=;
 b=Ed8PAyOvzqwYYOSfalkR+z/afTYP5YKwzHBNE4orT3/UlJD+8WIqFAQ174T7lEr1XW9M
 7y4pMutvE+j486TCUMYkmwlcO+QLxoJOUB0RkN3StLhrQnbI18lMdUwbuGR+48MQ2671
 /UxZTrWDcJsJMY3o/J9I9TYI0oq70bqdoX5AxXoHMogI9d52iKE0NMZTLurSyIqphLUb
 YNLADKZ9NZ5NFjpMRriC3J409xkZ9348uj6CrEtYItXvR3mqnEMoBnu06qpDz0wuGu5a
 Av4q2DcaOg+Wo/id6RoGOVXDeRx2qpeIawtyaOTpwCcL4N9x0seOJ7y/I32zlERJYrVe 8g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2ykgys2nqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Mar 2020 15:56:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 026Fh06e091781;
        Fri, 6 Mar 2020 15:56:29 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2yg1s11anw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Mar 2020 15:56:28 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 026FuQgQ005020;
        Fri, 6 Mar 2020 15:56:26 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 06 Mar 2020 07:56:26 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] NFSD: Fix NFS server build errors
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <631f52a1-b557-9137-0a7c-f493ac3339af@huawei.com>
Date:   Fri, 6 Mar 2020 10:56:24 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <734C2816-BB0C-4E6B-9894-67C9754DC071@oracle.com>
References: <20200305233433.14530.61315.stgit@klimt.1015granger.net>
 <631f52a1-b557-9137-0a7c-f493ac3339af@huawei.com>
To:     Yuehaibing <yuehaibing@huawei.com>,
        Olga Kornievskaia <kolga@netapp.com>,
        Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9552 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003060109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9552 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 lowpriorityscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0 phishscore=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003060109
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 5, 2020, at 9:14 PM, Yuehaibing <yuehaibing@huawei.com> wrote:
> 
> On 2020/3/6 7:38, Chuck Lever wrote:
>> yuehaibing@huawei.com reports the following build errors arise when
>> CONFIG_NFSD_V4_2_INTER_SSC is set and the NFS client is not built
>> into the kernel:
>> 
>> fs/nfsd/nfs4proc.o: In function `nfsd4_do_copy':
>> nfs4proc.c:(.text+0x23b7): undefined reference to `nfs42_ssc_close'
>> fs/nfsd/nfs4proc.o: In function `nfsd4_copy':
>> nfs4proc.c:(.text+0x5d2a): undefined reference to `nfs_sb_deactive'
>> fs/nfsd/nfs4proc.o: In function `nfsd4_do_async_copy':
>> nfs4proc.c:(.text+0x61d5): undefined reference to `nfs42_ssc_open'
>> nfs4proc.c:(.text+0x6389): undefined reference to `nfs_sb_deactive'
>> 
>> The new inter-server copy code invokes client functions. Until the
>> NFS server has infrastructure to load the appropriate NFS client
>> modules to handle inter-server copy requests, let's constrain the
>> way this feature is built.
>> 
>> Reported-by: YueHaibing <yuehaibing@huawei.com>
>> Fixes: ce0887ac96d3 ("NFSD add nfs4 inter ssc to nfsd4_copy")
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> fs/nfsd/Kconfig |    2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> Yue - does this work for you? The dependency is easier for me to
>> understand.
> 
> It works for me.
> 
> Tested-by: YueHaibing <yuehaibing@huawei.com> # build-tested

Thanks, I've added this tag and pushed to nfsd-5.7-testing.

Bruce and Olga, you can still veto this approach until I push into
linux-next. It will be a couple of weeks at least.


>> Bruce and Olga - OK with this temporary solution?
>> 
>> diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
>> index f368f3215f88..99d2cae91bd6 100644
>> --- a/fs/nfsd/Kconfig
>> +++ b/fs/nfsd/Kconfig
>> @@ -136,7 +136,7 @@ config NFSD_FLEXFILELAYOUT
>> 
>> config NFSD_V4_2_INTER_SSC
>> 	bool "NFSv4.2 inter server to server COPY"
>> -	depends on NFSD_V4 && NFS_V4_1 && NFS_V4_2
>> +	depends on NFSD_V4 && NFS_V4_1 && NFS_V4_2 && NFS_FS=y
>> 	help
>> 	  This option enables support for NFSv4.2 inter server to
>> 	  server copy where the destination server calls the NFSv4.2

--
Chuck Lever



