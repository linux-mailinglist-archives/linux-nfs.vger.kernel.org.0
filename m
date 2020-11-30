Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4272C9029
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Nov 2020 22:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgK3Vmy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 16:42:54 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:52122 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgK3Vmy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Nov 2020 16:42:54 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AULPAnm085219;
        Mon, 30 Nov 2020 21:42:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=FxkIWxed4Z6EOqVgfV9O82ACErkv0NhvYCwBeix+Ajc=;
 b=Kbh3Vth/1gr82Wd+x05iN1lvMBwjLqi8rAtXwOO/6EbYd7DV7PzYpw83D5NDK/x7oVX/
 bH+s8b0fu777DF0oV4th497h3drYH0gB4vnLVQ/AMlbi1vka7Qw0nO+KR64Fmm9YYRO2
 QJUTuw2UAnYAJDJFX9hRlo2BIvlSLknPhE/3PJyj5GDSkWCi9n3no6QE6P+SeY2vUugi
 p1lUH5Cer34khNu7McMfdwX56GIo9v5HpqC5yzHU7k8EEW8gqEFrV3+NrYdmEk6JOqdt
 0m8i+ppb4b+yj/9Xsm4ZjAjO1nyF1GkKHPvFJHV6pqAZmZThwPlHWy28MvcLoFR6uMZg 4w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 353dyqfh5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Nov 2020 21:42:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AULPHiX160786;
        Mon, 30 Nov 2020 21:40:09 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 3540fvt9br-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Nov 2020 21:40:08 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AULe8UH013940;
        Mon, 30 Nov 2020 21:40:08 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Nov 2020 13:40:07 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 0/6] Patches to support NFS re-exporting
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201130212455.254469-1-trondmy@kernel.org>
Date:   Mon, 30 Nov 2020 16:40:06 -0500
Cc:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <C98E8BA2-EB93-40EC-80B3-4D1C8E16D9CA@oracle.com>
References: <20201130212455.254469-1-trondmy@kernel.org>
To:     trondmy@kernel.org
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9821 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=1
 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011300135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9821 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 clxscore=1015 mlxscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=1 lowpriorityscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011300135
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond-

> On Nov 30, 2020, at 4:24 PM, trondmy@kernel.org wrote:
> 
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> These patches fix a number of issues that Hammerspace has hit when doing
> re-exporting of NFS.

These do not apply on top of Bruce's changes in the same area.
I've prepared a tree that you can apply onto.

See the cel-next topic branch in this repo:

git://git.linux-nfs.org/projects/cel/cel-2.6.git


> Jeff Layton (3):
>  nfsd: add a new EXPORT_OP_NOWCC flag to struct export_operations
>  nfsd: allow filesystems to opt out of subtree checking
>  nfsd: close cached files prior to a REMOVE or RENAME that would
>    replace target
> 
> Trond Myklebust (3):
>  exportfs: Add a function to return the raw output from fh_to_dentry()
>  nfsd: Fix up nfsd to ensure that timeout errors don't result in ESTALE
>  nfsd: Set PF_LOCAL_THROTTLE on local filesystems only
> 
> Documentation/filesystems/nfs/exporting.rst | 52 +++++++++++++++++++++
> fs/exportfs/expfs.c                         | 32 +++++++++----
> fs/nfs/export.c                             |  2 +
> fs/nfsd/export.c                            |  6 +++
> fs/nfsd/nfs3xdr.c                           |  7 ++-
> fs/nfsd/nfsfh.c                             | 30 ++++++++++--
> fs/nfsd/nfsfh.h                             |  2 +-
> fs/nfsd/vfs.c                               | 29 ++++++++----
> include/linux/exportfs.h                    | 10 ++++
> 9 files changed, 146 insertions(+), 24 deletions(-)
> 
> -- 
> 2.28.0
> 

--
Chuck Lever



