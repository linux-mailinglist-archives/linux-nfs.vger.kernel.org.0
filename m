Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97AD2ED3E1
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Jan 2021 17:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbhAGQDl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Jan 2021 11:03:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36582 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728372AbhAGQDk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Jan 2021 11:03:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610035334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HiGyEcSMzvsRvPyubTsGoWxp+GS0lXaauZP0QWTraeU=;
        b=BCHrsZzdTpn++IlcPm0jnmo99N0YTGQUf6UH0LkHeCVR84+OjtZrVgvQevBxTUoxhZQfph
        TlrzDQM5bV5yB3dJthY0dsdYFp97bKqhDCMuwWlLnoW3SbGLwamTXyEDkeuGcyrSyYZR7m
        1hSVVm39r00QBDf/0/cPaS7ABzS27FM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-cW1BAi_MMdyRQOOHgM5DLw-1; Thu, 07 Jan 2021 11:02:12 -0500
X-MC-Unique: cW1BAi_MMdyRQOOHgM5DLw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF7FD809DD6
        for <linux-nfs@vger.kernel.org>; Thu,  7 Jan 2021 16:02:11 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-139.phx2.redhat.com [10.3.113.139])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F6245D9DC
        for <linux-nfs@vger.kernel.org>; Thu,  7 Jan 2021 16:02:11 +0000 (UTC)
Subject: Re: [PATCH] mount: parse default values correctly
From:   Steve Dickson <SteveD@RedHat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20210106184028.150925-1-steved@redhat.com>
Message-ID: <3b8cecf2-3f15-a05d-13f0-2cc5b2d50c79@RedHat.com>
Date:   Thu, 7 Jan 2021 11:03:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210106184028.150925-1-steved@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 1/6/21 1:40 PM, Steve Dickson wrote:
> Commit 88c22f92 converted the configfile.c routines
> to use the parse_opt interfaces which broke how
> default values from nfsmount.conf are managed.
> 
> Default values can not be added to the mount string
> handed to the kernel. They must be interpreted into
> the correct mount options then passed to the kernel.
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1912877
> 
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed... (tag: nfs-utils-2-5-3-rc4)

steved.
> ---
>  utils/mount/configfile.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/utils/mount/configfile.c b/utils/mount/configfile.c
> index 7934f4f..e865998 100644
> --- a/utils/mount/configfile.c
> +++ b/utils/mount/configfile.c
> @@ -277,8 +277,10 @@ conf_parse_mntopts(char *section, char *arg, struct mount_options *options)
>  		}
>  		if (buf[0] == '\0')
>  			continue;
> +		if (default_value(buf))
> +			continue;
> +
>  		po_append(options, buf);
> -		default_value(buf);
>  	}
>  	conf_free_list(list);
>  }
> 

