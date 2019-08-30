Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72DE6A3C14
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2019 18:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfH3QdU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Aug 2019 12:33:20 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53032 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbfH3QdU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 30 Aug 2019 12:33:20 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7UGX6Cg022227;
        Fri, 30 Aug 2019 16:33:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=7F9jX+3JTIa1zj/Hv1wR+TjKUvAq2ErBXof15YLfvH8=;
 b=B4E034NE7xCCqU2TL6QzXdbuiPGZjMgLvmXmEwq/+0GL6ow88KFbcl3pugUWE1vhsblA
 OlhGjoSlr0wS3BDpSfrLs0rVkFb8GMA9syHQ161ICvw8UV0zzNeednUNBgmqq/E+rGqh
 +yRyBfsoQLOEK2DhFNKn/KpcbLYSvUPHfx5wNHUqNe7YuStdUvlqz8ZLkVEtGBeZ5jg+
 2LOOtnulTqK9w4KKWI562xlnCoAxUw5KTm8YGPc44SYEwXCpor0lGlLI9SZ5QycLMD4q
 rQ7liGDvh/7ZUITcwFBgnvdFZHJcpCkkZzmINxm2Gz+5w00y6sVQajBPC5Igb9WbRb5T iw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2uq7dng01c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Aug 2019 16:33:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7UGWum5145599;
        Fri, 30 Aug 2019 16:33:07 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2upxabgq23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Aug 2019 16:33:03 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7UGWpw4004525;
        Fri, 30 Aug 2019 16:32:51 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 30 Aug 2019 09:32:51 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 0/2] nfsd: add principal to the data being tracked by
 nfsdcld
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20190830162631.13195-1-smayhew@redhat.com>
Date:   Fri, 30 Aug 2019 12:32:50 -0400
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Simo Sorce <simo@redhat.com>
Content-Transfer-Encoding: 7bit
Message-Id: <A732539C-837A-4764-8281-C26E4203DE25@oracle.com>
References: <20190830162631.13195-1-smayhew@redhat.com>
To:     Scott Mayhew <smayhew@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9365 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908300163
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9365 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908300163
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Simo, any comments or questions?

Patches can be found here:

https://marc.info/?l=linux-nfs&m=156718239314526&w=2

https://marc.info/?l=linux-nfs&m=156718239414527&w=2


> On Aug 30, 2019, at 12:26 PM, Scott Mayhew <smayhew@redhat.com> wrote:
> 
> At the spring bakeathon, Chuck suggested that we should store the
> kerberos principal in addition to the client id string in nfsdcld.  The
> idea is to prevent an illegitimate client from reclaiming another
> client's opens by supplying that client's id string.
> 
> The first patch lays some groundwork for supporting multiple message
> versions for the nfsdcld upcalls, adding fields for version and message
> length to the nfsd4_client_tracking_ops (these fields are only used for
> the nfsdcld upcalls and ignored for the other tracking methods), as well
> as an upcall to get the maximum version supported by the userspace
> daemon.
> 
> The second patch actually adds the v2 message, which adds the principal
> (actually just the first 1024 bytes) to the Cld_Create upcall and to the
> Cld_GraceStart downcall (which is what loads the data in the
> reclaim_str_hashtbl). I couldn't really figure out what the maximum length
> of a kerberos principal actually is (looking at krb5.h the length field in
> the struct krb5_data is an unsigned int, so I guess it can be pretty big).
> I don't think the principal will be that large in practice, and even if
> it is the first 1024 bytes should be sufficient for our purposes.
> 
> Scott Mayhew (2):
>  nfsd: add a "GetVersion" upcall for nfsdcld
>  nfsd: add support for upcall version 2
> 
> fs/nfsd/nfs4recover.c         | 332 +++++++++++++++++++++++++++-------
> fs/nfsd/nfs4state.c           |   6 +-
> fs/nfsd/state.h               |   3 +-
> include/uapi/linux/nfsd/cld.h |  37 +++-
> 4 files changed, 311 insertions(+), 67 deletions(-)
> 
> -- 
> 2.17.2
> 

--
Chuck Lever



