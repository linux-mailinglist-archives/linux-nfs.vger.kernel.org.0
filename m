Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A851530C715
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Feb 2021 18:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbhBBRKB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Feb 2021 12:10:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37138 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237041AbhBBRCa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Feb 2021 12:02:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612285264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sh/kxFx7YvgC5J+H/GrC1fpCk40PBfelmGH6dEnlR7s=;
        b=cvF27O0jYtaSu8o5hGBcIGBMcpH/xjy2F/OKDrAjG25I6Uuaq7lIh3Djggut5CSgtb3TwA
        AEAXHvbISS5Y8F7q1AeedUDIX5JdvuOiqtRY7khqISe2NDmPVFU3p3tH30XHH9kFXI6B0c
        3hRtx5+BH7QX+Mi/m+i9fhyea07gmEk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-8_MKVoJnPQyKNDZ2ORXKBQ-1; Tue, 02 Feb 2021 12:01:02 -0500
X-MC-Unique: 8_MKVoJnPQyKNDZ2ORXKBQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9884A801AC4
        for <linux-nfs@vger.kernel.org>; Tue,  2 Feb 2021 17:01:01 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-114-82.phx2.redhat.com [10.3.114.82])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 660985D9C6
        for <linux-nfs@vger.kernel.org>; Tue,  2 Feb 2021 17:01:01 +0000 (UTC)
Subject: Re: [PATCH 1/2] mountd: Cleanup how config options are read in
From:   Steve Dickson <SteveD@RedHat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20210201230147.45593-1-steved@redhat.com>
Message-ID: <07eea6eb-2164-8076-5c82-6005d827ec1d@RedHat.com>
Date:   Tue, 2 Feb 2021 12:02:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210201230147.45593-1-steved@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 2/1/21 6:01 PM, Steve Dickson wrote:
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed... (tag: nfs-utils-2-5-3-rc5)

steved.
> ---
>  utils/mountd/mountd.c | 49 +++++++++++++++++++++++++------------------
>  1 file changed, 29 insertions(+), 20 deletions(-)
> 
> diff --git a/utils/mountd/mountd.c b/utils/mountd/mountd.c
> index 07bcdc5a..988e51c5 100644
> --- a/utils/mountd/mountd.c
> +++ b/utils/mountd/mountd.c
> @@ -661,30 +661,17 @@ get_exportlist(void)
>  	return elist;
>  }
>  
> -int
> -main(int argc, char **argv)
> +int	vers;
> +int	port = 0;
> +int	descriptors = 0;
> +
> +inline static void 
> +read_mount_conf(char **argv)
>  {
> -	char	*progname;
>  	char	*s;
> -	unsigned int listeners = 0;
> -	int	foreground = 0;
> -	int	port = 0;
> -	int	descriptors = 0;
> -	int	c;
> -	int	vers;
> -	struct sigaction sa;
> -	struct rlimit rlim;
> -
> -	/* Set the basename */
> -	if ((progname = strrchr(argv[0], '/')) != NULL)
> -		progname++;
> -	else
> -		progname = argv[0];
> -
> -	/* Initialize logging. */
> -	xlog_open(progname);
>  
>  	conf_init_file(NFS_CONFFILE);
> +
>  	xlog_from_conffile("mountd");
>  	manage_gids = conf_get_bool("mountd", "manage-gids", manage_gids);
>  	descriptors = conf_get_num("mountd", "descriptors", descriptors);
> @@ -714,7 +701,29 @@ main(int argc, char **argv)
>  		else
>  			NFSCTL_VERUNSET(nfs_version, vers);
>  	}
> +}
> +
> +int
> +main(int argc, char **argv)
> +{
> +	char	*progname;
> +	unsigned int listeners = 0;
> +	int	foreground = 0;
> +	int	c;
> +	struct sigaction sa;
> +	struct rlimit rlim;
> +
> +	/* Set the basename */
> +	if ((progname = strrchr(argv[0], '/')) != NULL)
> +		progname++;
> +	else
> +		progname = argv[0];
> +
> +	/* Initialize logging. */
> +	xlog_open(progname);
>  
> +	/* Read in config setting */
> +	read_mount_conf(argv);
>  
>  	/* Parse the command line options and arguments. */
>  	opterr = 0;
> 

