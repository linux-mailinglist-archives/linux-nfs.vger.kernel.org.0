Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFCD155B6A
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2020 17:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgBGQIk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 Feb 2020 11:08:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48594 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726951AbgBGQIk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 7 Feb 2020 11:08:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581091719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YKvjhULmr+LF3DwK5KgfHphqS7dKLkNYxxG/KmcfJjg=;
        b=OkLq129cQt1PXS1XwHOJCbFyylCErb+k4W4Ka+K3pfA3Nb0HIpU8yqAvbsi44/SvLvScqF
        /UgZ+8s5dhRchGGCg6PuZXMvwOexGJ3atTDH4JBUk+Hly3hr+MzbzzVCHUYOQnMmyRwN+b
        yNeAlPToC34W3OUjzOrldLNOFqCiLZI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-sfcW38qVOMKhQZjX0GNYyg-1; Fri, 07 Feb 2020 11:08:37 -0500
X-MC-Unique: sfcW38qVOMKhQZjX0GNYyg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70AB28010F5
        for <linux-nfs@vger.kernel.org>; Fri,  7 Feb 2020 16:08:36 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-117-141.phx2.redhat.com [10.3.117.141])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4176E7FB60
        for <linux-nfs@vger.kernel.org>; Fri,  7 Feb 2020 16:08:36 +0000 (UTC)
Subject: Re: [PATCH 1/2] manpage: Add a description of the 'nconnect' mount
 option
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20200129154703.6204-1-steved@redhat.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <d1a3745e-cda0-d84c-3cff-47d23df105cb@RedHat.com>
Date:   Fri, 7 Feb 2020 11:08:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200129154703.6204-1-steved@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 1/29/20 10:47 AM, Steve Dickson wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> Add a description of the 'nconnect' mount option on the 'nfs' generic
> manpage.
> 
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed... (tag: nfs-utils-2-4-3-rc7)

steved.
> ---
>  utils/mount/nfs.man | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
> index 6ba9cef..84462cd 100644
> --- a/utils/mount/nfs.man
> +++ b/utils/mount/nfs.man
> @@ -369,6 +369,23 @@ using an automounter (refer to
>  .BR automount (8)
>  for details).
>  .TP 1.5i
> +.BR nconnect= n
> +When using a connection oriented protocol such as TCP, it may
> +sometimes be advantageous to set up multiple connections between
> +the client and server. For instance, if your clients and/or servers
> +are equipped with multiple network interface cards (NICs), using multiple
> +connections to spread the load may improve overall performance.
> +In such cases, the
> +.BR nconnect
> +option allows the user to specify the number of connections
> +that should be established between the client and server up to
> +a limit of 16.
> +.IP
> +Note that the
> +.BR nconnect
> +option may also be used by some pNFS drivers to decide how many
> +connections to set up to the data servers.
> +.TP 1.5i
>  .BR rdirplus " / " nordirplus
>  Selects whether to use NFS v3 or v4 READDIRPLUS requests.
>  If this option is not specified, the NFS client uses READDIRPLUS requests
> 

