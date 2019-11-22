Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC001107530
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Nov 2019 16:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfKVPt0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Nov 2019 10:49:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27053 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726546AbfKVPtZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Nov 2019 10:49:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574437764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cHM8qSivLaVgJ93w5exNqPwhavT4W01ZjSyTWkcdftk=;
        b=XQVRiY78Q9tWRkp95oAx/RPx+lV/8sVNam/Dff3HhnG0nqSuuiPdFi8Wk1qgeMaeheEMyV
        SBuDUmlVdrSHzpQOdRYGgMRNJwIMnLEvWCn4QGEa6RI14wP+g5BPWSUs0n42iyu1Fnt9Gr
        NPhrqiB/dY42wIidWRD5Ha0slhJhrxo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-p05zpBIfMYOojWnxjteEeQ-1; Fri, 22 Nov 2019 10:49:20 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A438E477;
        Fri, 22 Nov 2019 15:49:19 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-117-36.phx2.redhat.com [10.3.117.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2F95110027B1;
        Fri, 22 Nov 2019 15:49:19 +0000 (UTC)
Subject: Re: [nfs-utils PATCH 1/1] mount: Do not overwrite /etc/mtab if it's
 symlink
To:     Petr Vorel <petr.vorel@gmail.com>, linux-nfs@vger.kernel.org
Cc:     Joey Hess <joeyh@debian.org>, Chuck Lever <chuck.lever@oracle.com>
References: <20191120183529.29366-1-petr.vorel@gmail.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <938c3cf9-0584-d6b9-b3a1-ec12795761c5@RedHat.com>
Date:   Fri, 22 Nov 2019 10:49:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191120183529.29366-1-petr.vorel@gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: p05zpBIfMYOojWnxjteEeQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 11/20/19 1:35 PM, Petr Vorel wrote:
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
> Signed-off-by: Joey Hess <joeyh@debian.org>
> [ pvorel: took patch from Debian, rebased for 2.4.3-rc1 and created commit
> message. Patch is also used in Gentoo. ]
> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
Committed... (tag: nfs-utils-2-4-3-rc2)

steved.
> ---
> Hi,
> 
> if you merge, please keep Joey as the author in git :).
> 
> Kind regards,
> Petr
> 
>  utils/mount/fstab.c | 2 +-
>  utils/mount/fstab.h | 1 +
>  utils/mount/mount.c | 7 +++++++
>  3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/utils/mount/fstab.c b/utils/mount/fstab.c
> index 8b0aaf1a..146d8f40 100644
> --- a/utils/mount/fstab.c
> +++ b/utils/mount/fstab.c
> @@ -61,7 +61,7 @@ mtab_does_not_exist(void) {
>  	return var_mtab_does_not_exist;
>  }
>  
> -static int
> +int
>  mtab_is_a_symlink(void) {
>          get_mtab_info();
>          return var_mtab_is_a_symlink;
> diff --git a/utils/mount/fstab.h b/utils/mount/fstab.h
> index 313bf9b3..8676c8c2 100644
> --- a/utils/mount/fstab.h
> +++ b/utils/mount/fstab.h
> @@ -7,6 +7,7 @@
>  #define _PATH_FSTAB "/etc/fstab"
>  #endif
>  
> +int mtab_is_a_symlink(void);
>  int mtab_is_writable(void);
>  int mtab_does_not_exist(void);
>  void reset_mtab_info(void);
> diff --git a/utils/mount/mount.c b/utils/mount/mount.c
> index 91f10877..92a0dfe4 100644
> --- a/utils/mount/mount.c
> +++ b/utils/mount/mount.c
> @@ -204,6 +204,13 @@ create_mtab (void) {
>  	int flags;
>  	mntFILE *mfp;
>  
> +	/* Avoid writing if the mtab is a symlink to /proc/mounts, since
> +	   that would create a file /proc/mounts in case the proc filesystem
> +	   is not mounted, and the fchmod below would also fail. */
> +	if (mtab_is_a_symlink()) {
> +		return EX_SUCCESS;
> +	}
> +
>  	lock_mtab();
>  
>  	mfp = nfs_setmntent (MOUNTED, "a+");
> 

