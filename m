Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 618B12D76E7
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Dec 2020 14:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391176AbgLKNt2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Dec 2020 08:49:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44044 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732259AbgLKNtF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Dec 2020 08:49:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607694458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F+FkAY3KxamJquQJIxVOlpsbHYQMMTGokOlH4mm//Tc=;
        b=HLiBBnHSPIZrPhMU6lIJXuv3KvfWmol8zGeNazYyt6TV7skbwgEK1aPwkQMcum9/KDUzlh
        ohUg22ZylYwdERabMbi1pTJq34VuXXQYE2XtqTF5Pc49AZIvRosHeuVE4Fk3R27QWQb5TV
        fz7MltKva/h7C4N69FennF0vdw8Fbts=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-Gs1BCy3EOTKazBkOlUDnNA-1; Fri, 11 Dec 2020 08:47:36 -0500
X-MC-Unique: Gs1BCy3EOTKazBkOlUDnNA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67A5410054FF
        for <linux-nfs@vger.kernel.org>; Fri, 11 Dec 2020 13:47:35 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-115-15.phx2.redhat.com [10.3.115.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 36AE36F982
        for <linux-nfs@vger.kernel.org>; Fri, 11 Dec 2020 13:47:35 +0000 (UTC)
Subject: Re: [PATCH] exports.man: Remove some outdated verbiage
From:   Steve Dickson <SteveD@RedHat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20201210191040.21901-1-steved@redhat.com>
Message-ID: <a9b27e8e-5ba4-b412-b5c2-35c9c84be0e3@RedHat.com>
Date:   Fri, 11 Dec 2020 08:48:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201210191040.21901-1-steved@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 12/10/20 2:10 PM, Steve Dickson wrote:
> Years ago, commit 6a7d90cea765 removed the warning
> this verbiage was talking about, but was never
> removed from the man page.
> 
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed (tag: nfs-utils-2-5-3-rc2)

steved.
> ---
>  utils/exportfs/exports.man | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
> index 1d17184..54b3f87 100644
> --- a/utils/exportfs/exports.man
> +++ b/utils/exportfs/exports.man
> @@ -169,13 +169,6 @@ default.  In all releases after 1.0.0,
>  is the default, and
>  .I async
>  must be explicitly requested if needed.
> -To help make system administrators aware of this change,
> -.B exportfs
> -will issue a warning if neither
> -.I sync
> -nor
> -.I async
> -is specified.
>  .TP
>  .IR no_wdelay
>  This option has no effect if
> 

