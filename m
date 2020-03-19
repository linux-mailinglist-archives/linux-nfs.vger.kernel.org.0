Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE0518BB35
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2020 16:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbgCSPfN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Mar 2020 11:35:13 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55604 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbgCSPfN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Mar 2020 11:35:13 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02JFNvnD045847;
        Thu, 19 Mar 2020 15:35:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=up+CkQo2rV3kNRJyC5fW1JKGnrOHXKI8/MDnRFQKtiU=;
 b=AcIjai3j6rog+JGkFUnh4zhJZD86U+8LZi557PlgVrSKfg22jzF8eSvWhwaBLjftA+0C
 Un4aRxlfKuV3wViivxtDpE4rO8t2muyfI0n7lPui2VaWm3S6JcJRw0UUUpc931IBp7ay
 D7rFLBILP1zg+HAT9PiyWRQRUv7YOP8mDiMgMVhQeX3KY8F0TzgPjKJXtjbqSsB5OgXP
 NLWSnqSi8/hLQ5fbO49YkGXvm9fhBikbZna82GFZcykDEQI0axKIjOvhtT6cDx9FrG4m
 os4qEpCKOnJujOssCz082j70t4Vndp+wMG6H3Brd6ggXz0A/6uMYYDJ4UMePRFgJhwIf xQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2yub278vp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Mar 2020 15:35:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02JFMmJS075036;
        Thu, 19 Mar 2020 15:35:10 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2ys8rmd8ku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Mar 2020 15:35:10 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02JFZ9Iw008578;
        Thu, 19 Mar 2020 15:35:09 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Mar 2020 08:35:09 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] nfsd: fsnotify on rmdir under nfsd/clients/
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200319153038.GA2624@fieldses.org>
Date:   Thu, 19 Mar 2020 11:35:08 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <7B681219-E253-46ED-BDE5-0D0C1606685E@oracle.com>
References: <20200319153038.GA2624@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9565 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003190068
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9565 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003190068
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 19, 2020, at 11:30 AM, bfields@fieldses.org wrote:
> 
> From: "J. Bruce Fields" <bfields@redhat.com>
> 
> Userspace should be able to monitor nfsd/clients/ to see when clients
> come and go, but we're failing to send fsnotify events.
> 
> Cc: stable@kernel.org
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>

Applied to nfsd-5.7, thanks!


> ---
> fs/nfsd/nfsctl.c | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index e109a1007704..3bb2db947d29 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1333,6 +1333,7 @@ void nfsd_client_rmdir(struct dentry *dentry)
> 	dget(dentry);
> 	ret = simple_rmdir(dir, dentry);
> 	WARN_ON_ONCE(ret);
> +	fsnotify_rmdir(dir, dentry);
> 	d_delete(dentry);
> 	inode_unlock(dir);
> }
> -- 
> 2.25.1
> 

--
Chuck Lever



