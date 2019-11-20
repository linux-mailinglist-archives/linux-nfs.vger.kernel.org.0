Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCB981043B0
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2019 19:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfKTSvu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Nov 2019 13:51:50 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:59518 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfKTSvu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Nov 2019 13:51:50 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAKIn4Hb022089;
        Wed, 20 Nov 2019 18:51:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=qqIin8fcQlKAwpzfeJihq8wB6hk19XNrkrR1lrmGd5o=;
 b=jJIAdhpJA8bJsTGeII4cJvDbNGHvPd+LNgz4GK20ZMWeoQQ9MjYMR/VNAm9h9aIY6Bbt
 +IZjCpc9yT9J3FKIyba/WJ1ucPaFz87196HvczpIYVdkTbh1SyLs7u5wEo48qq5lgIeJ
 mcmHvsLpUP04PeZSyPCEYljQ47v+ytVUkwWZdmxsRC30wKiAn8QmuoVzTdODCfCQcJDo
 zNfrAHSdCdt/uilnwRxKHf0+e1BavPI5M1MzUy+S2WPNnYQZoBNyf6tINnGDGpKyCE2z
 4dVc7LqpG0vzK5dM7xBY0CWXoUbNgYig2RnQo87InWZLdg6cwrMnUJ4MyZ+whPm//Nai gw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2wa8htyhns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Nov 2019 18:51:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAKImqsw153088;
        Wed, 20 Nov 2019 18:51:41 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2wda04kf01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Nov 2019 18:51:41 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAKIpeeg015787;
        Wed, 20 Nov 2019 18:51:40 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Nov 2019 10:51:39 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [nfs-utils PATCH 1/1] mount: Do not overwrite /etc/mtab if it's
 symlink
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20191120183529.29366-1-petr.vorel@gmail.com>
Date:   Wed, 20 Nov 2019 13:51:38 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Joey Hess <joeyh@debian.org>, Steve Dickson <steved@redhat.com>
Content-Transfer-Encoding: 7bit
Message-Id: <C92F18A6-711E-4791-B140-F59595F89C22@oracle.com>
References: <20191120183529.29366-1-petr.vorel@gmail.com>
To:     Petr Vorel <petr.vorel@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9447 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911200155
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9447 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911200155
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 20, 2019, at 1:35 PM, Petr Vorel <petr.vorel@gmail.com> wrote:
> 
> From: Joey Hess <joeyh@debian.org>
> 
> Some systems have /etc/mtab symlink to /proc/mounts. In that case
> mount.nfs complains:
> Can't set permissions on mtab: Operation not permitted
> 
> See https://bugs.debian.org/476577
> 
> This change makes mount.nfs handle symlinked /etc/mtab the way
> umount.nfs and util- linux handle it.
> 
> Cc: Chuck Lever <chuck.lever@oracle.com>

No objection from me.


> Signed-off-by: Joey Hess <joeyh@debian.org>
> [ pvorel: took patch from Debian, rebased for 2.4.3-rc1 and created commit
> message. Patch is also used in Gentoo. ]
> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
> ---
> Hi,
> 
> if you merge, please keep Joey as the author in git :).
> 
> Kind regards,
> Petr
> 
> utils/mount/fstab.c | 2 +-
> utils/mount/fstab.h | 1 +
> utils/mount/mount.c | 7 +++++++
> 3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/utils/mount/fstab.c b/utils/mount/fstab.c
> index 8b0aaf1a..146d8f40 100644
> --- a/utils/mount/fstab.c
> +++ b/utils/mount/fstab.c
> @@ -61,7 +61,7 @@ mtab_does_not_exist(void) {
> 	return var_mtab_does_not_exist;
> }
> 
> -static int
> +int
> mtab_is_a_symlink(void) {
>         get_mtab_info();
>         return var_mtab_is_a_symlink;
> diff --git a/utils/mount/fstab.h b/utils/mount/fstab.h
> index 313bf9b3..8676c8c2 100644
> --- a/utils/mount/fstab.h
> +++ b/utils/mount/fstab.h
> @@ -7,6 +7,7 @@
> #define _PATH_FSTAB "/etc/fstab"
> #endif
> 
> +int mtab_is_a_symlink(void);
> int mtab_is_writable(void);
> int mtab_does_not_exist(void);
> void reset_mtab_info(void);
> diff --git a/utils/mount/mount.c b/utils/mount/mount.c
> index 91f10877..92a0dfe4 100644
> --- a/utils/mount/mount.c
> +++ b/utils/mount/mount.c
> @@ -204,6 +204,13 @@ create_mtab (void) {
> 	int flags;
> 	mntFILE *mfp;
> 
> +	/* Avoid writing if the mtab is a symlink to /proc/mounts, since
> +	   that would create a file /proc/mounts in case the proc filesystem
> +	   is not mounted, and the fchmod below would also fail. */
> +	if (mtab_is_a_symlink()) {
> +		return EX_SUCCESS;
> +	}
> +
> 	lock_mtab();
> 
> 	mfp = nfs_setmntent (MOUNTED, "a+");
> -- 
> 2.24.0
> 

--
Chuck Lever



