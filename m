Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A183172269
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Feb 2020 16:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbgB0PlR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Feb 2020 10:41:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60578 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729207AbgB0PlQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Feb 2020 10:41:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582818075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rXec1HYr9UtZqYek6mkk07qHK6eUSuJSbPE/pvfkRi4=;
        b=U5HcZiErc5Mfg7Ts0JtEaKiCWCYE+/7g1VDBRJtyMOE2f+cRz6EHP9BuBWwhFXM4mhRBu7
        oZM+6BL+3wEJ+e61v4jCoJwTP2HSwHvsYV7l82s5dw7uT8eIDWk3LNiwVQngrblL7qqvfi
        fM0OWSt8XFFT4En7LiWul/0ehFiRTAs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-Z_d7K2B9MN68H9IReM3llw-1; Thu, 27 Feb 2020 10:41:11 -0500
X-MC-Unique: Z_d7K2B9MN68H9IReM3llw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A35AE18B5FBB;
        Thu, 27 Feb 2020 15:41:10 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (madhat.boston.devel.redhat.com [10.19.60.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A1EC92999;
        Thu, 27 Feb 2020 15:41:08 +0000 (UTC)
Subject: Re: [PATCH] [nfs-utils] utils/mount/mount.c: fix args parse error
To:     "Jianhong.Yin" <yin-jianhong@163.com>
Cc:     linux-nfs@vger.kernel.org, jiyin@redhat.com
References: <20200224034336.9667-1-yin-jianhong@163.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <bd7cd204-64db-40e9-d646-74e5b26b94de@RedHat.com>
Date:   Thu, 27 Feb 2020 10:41:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200224034336.9667-1-yin-jianhong@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 2/23/20 10:43 PM, Jianhong.Yin wrote:
> From: Jianhong Yin <yin-jianhong@163.com>
> 
> argc number checking should be after getopt_long(), otherwise
> we'll get follow result:
> '''
> ~]# mount.nfs -V
> usage: mount.nfs remotetarget dir [-rvVwfnsh] [-o nfsoptions]
> options:
>         -r              Mount file system readonly
>         -v              Verbose
>         -V              Print version
>         -w              Mount file system read-write
>         -f              Fake mount, do not actually mount
>         -n              Do not update /etc/mtab
>         -s              Tolerate sloppy mount options rather than fail
>         -h              Print this help
>         nfsoptions      Refer to mount.nfs(8) or nfs(5)
> '''
> 
> after fix:
> '''
> ~]# mount.nfs -V
> mount.nfs: (linux nfs-utils 2.4.3)
> '''
> 
> Signed-off-by: Jianhong Yin <yin-jianhong@163.com>
Committed... 

steved.

> ---
>  utils/mount/mount.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/utils/mount/mount.c b/utils/mount/mount.c
> index 2be3dc2f..b98f9e00 100644
> --- a/utils/mount/mount.c
> +++ b/utils/mount/mount.c
> @@ -393,11 +393,6 @@ int main(int argc, char *argv[])
>  	if(!strncmp(progname, "umount", strlen("umount")))
>  		exit(nfsumount(argc, argv));
>  
> -	if ((argc < 3)) {
> -		mount_usage();
> -		exit(EX_USAGE);
> -	}
> -
>  	mount_config_init(progname);
>  
>  	while ((c = getopt_long(argc, argv, "rvVwfno:hs",
> @@ -437,6 +432,11 @@ int main(int argc, char *argv[])
>  		}
>  	}
>  
> +	if ((argc < 3)) {
> +		mount_usage();
> +		exit(EX_USAGE);
> +	}
> +
>  	/*
>  	 * Extra non-option words at the end are bogus...
>  	 */
> 

