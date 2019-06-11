Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A07123D583
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2019 20:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbfFKSbZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 14:31:25 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34130 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729074AbfFKSbZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jun 2019 14:31:25 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5BIT4vG089312;
        Tue, 11 Jun 2019 18:31:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=tDT1Jfsk8MR+m2Wu/KqLX9YtwjD4PHm2HFsyFwtkdHc=;
 b=2XqsDyOReFG3SRqwEaCHm1EH9ngPrkHqQQDZJPyhXR5bxoMJbpuyMA/pblIyEnuHGDFr
 js1D8HLhdUplcEDYRPSbpSdRYQDui0d/pF0TrUkraCMErF4LjfUzJ2lCxs3rniCsn35b
 lZ49ZRo5BzCZD6evGsJr3tDgCkbKLFR8KZKGGGe2Ml4j5NJQrEnHtEyCPljpCpHTdGlB
 n4lOGcn0hScIWu3NJ4mnJt1yZCyqb9V0OEgl/Z4C58gCryIPxAXC5rBtMtkUgz2lM5rS
 F6QIh8CbxAJvfwpvJiI8Wh3190SZTrDfSRUfmQU7xWe9OsRjGtUiRrW2nmiE8gVDVeU7 bg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2t04etq0v0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 18:31:23 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5BIUvVm052489;
        Tue, 11 Jun 2019 18:31:22 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2t1jphkmwu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 18:31:22 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5BIVMnF032351;
        Tue, 11 Jun 2019 18:31:22 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Jun 2019 11:31:21 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 0/3] Cache consistency updates
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20190611182511.120074-1-trond.myklebust@hammerspace.com>
Date:   Tue, 11 Jun 2019 14:31:20 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <B29E9170-287F-4E10-B1AE-4E12303435B3@oracle.com>
References: <20190611182511.120074-1-trond.myklebust@hammerspace.com>
To:     Trond Myklebust <trondmy@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906110117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906110118
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 11, 2019, at 2:25 PM, Trond Myklebust <trondmy@gmail.com> wrote:
> 
> Add a 'deferred cache invalidation' mode that we can use when we thing
> the NFS cache may have been changed on the server, but the file in
> question is already open and is cached on the client. In order to avoid
> performance issues due to false positive detection of server changes,
> we defer invalidating the cache until the file has been closed, and
> the cached data is no longer in active use.
> 
> Trond Myklebust (3):
>  NFS: Fix up ftrace printout of the cache invalidation flags
>  NFS: Fix up ftrace logging of nfs_inode flags

I also fixed these items in my for-5.3 patch series, but
my patches add TRACE_DEFINE_ENUM definitions.


>  NFS: Add deferred cache invalidation for close-to-open consistency
>    violations
> 
> fs/nfs/dir.c           |  4 ++++
> fs/nfs/inode.c         | 15 +++++++++++----
> fs/nfs/nfstrace.h      | 22 ++++++++++++++--------
> include/linux/nfs_fs.h |  2 ++
> 4 files changed, 31 insertions(+), 12 deletions(-)
> 
> -- 
> 2.21.0
> 

--
Chuck Lever



