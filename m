Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB322155B68
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2020 17:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgBGQIa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 Feb 2020 11:08:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28727 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726874AbgBGQIa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 7 Feb 2020 11:08:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581091709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lb7lVBbdd+H3WJRR/6dpzqnzjo5wKHlUHdtFe6yXNNU=;
        b=Hw8IDkyGZI3TifX7sxUNvl3anTpMAWE+3k0m0m8A7AQCREGV/rad4XcCa/wNDZbcrfduDh
        OVE8yLL90HqCgXb1IMmi/nSMAtZIw6eUL5UuAq1DPxfyq6O3EIdOT+cPsmvvk3e3yrXu9C
        TD74d44axMhLZEfqsLWPuTXvwno1AwE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-5IuYFQj_MVqZB63D5MFJQw-1; Fri, 07 Feb 2020 11:08:27 -0500
X-MC-Unique: 5IuYFQj_MVqZB63D5MFJQw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B34F800D6C
        for <linux-nfs@vger.kernel.org>; Fri,  7 Feb 2020 16:08:24 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-117-141.phx2.redhat.com [10.3.117.141])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD9F81000337
        for <linux-nfs@vger.kernel.org>; Fri,  7 Feb 2020 16:08:23 +0000 (UTC)
Subject: Re: [PATCH 2/2] manpage: Add a description of the 'softreval' /
 'nosoftreval' mount option
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20200129154703.6204-1-steved@redhat.com>
 <20200129154703.6204-2-steved@redhat.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <2747d2f9-037b-a4ba-7d9b-64dc3e303e08@RedHat.com>
Date:   Fri, 7 Feb 2020 11:08:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200129154703.6204-2-steved@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 1/29/20 10:47 AM, Steve Dickson wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> Add a description of the 'softreval' / 'nosoftreval' mount options on
> the 'nfs' generic manpage.
> 
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed... (tag: nfs-utils-2-4-3-rc7)

steved.

> ---
>  utils/mount/nfs.man | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
> index 84462cd..6f79c63 100644
> --- a/utils/mount/nfs.man
> +++ b/utils/mount/nfs.man
> @@ -121,6 +121,36 @@ option may mitigate some of the risks of using the
>  .B soft
>  option.
>  .TP 1.5i
> +.BR softreval " / " nosoftreval
> +In cases where the NFS server is down, it may be useful to
> +allow the NFS client to continue to serve up paths and
> +attributes from cache after
> +.B retrans
> +attempts to revalidate that cache have timed out.
> +This may, for instance, be helpful when trying to unmount a
> +filesystem tree from a server that is permanently down.
> +.IP
> +It is possible to combine
> +.BR softreval
> +with the
> +.B soft
> +mount option, in which case operations that cannot be served up
> +from cache will time out and return an error after
> +.B retrans
> +attempts. The combination with the default
> +.B hard
> +mount option implies those uncached operations will continue to
> +retry until a response is received from the server.
> +.IP
> +Note: the default mount option is
> +.BR nosoftreval
> +which disallows fallback to cache when revalidation fails, and
> +instead follows the behavior dictated by the
> +.B hard
> +or
> +.B soft
> +mount option.
> +.TP 1.5i
>  .BR intr " / " nointr
>  This option is provided for backward compatibility.
>  It is ignored after kernel 2.6.25.
> 

