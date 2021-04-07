Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B7E357509
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Apr 2021 21:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345628AbhDGTif (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Apr 2021 15:38:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26475 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345465AbhDGTie (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Apr 2021 15:38:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617824304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3jaPMA8xwQjDyRwUPHsxSRsI2SiE+GKpxq0URpBiKs4=;
        b=B3tTe4a0xdWMOWEwX4bsO6fX9grc83a4g3i+rhHaiVevAuH8MduNXRiiPezkM2ko+6Dj1p
        9Kwz5b8Ly3iGOTFsiJAajIKcHJTCnR8MxT+6eYDBwkXwigWGUn72qyTaKOacOPnvGFStBI
        oXjHzD57rf2Atk3uAi5fch5kWOZfYb4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-wThOgd1SOy6rSx-omID-rQ-1; Wed, 07 Apr 2021 15:38:22 -0400
X-MC-Unique: wThOgd1SOy6rSx-omID-rQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D444C107ACC7
        for <linux-nfs@vger.kernel.org>; Wed,  7 Apr 2021 19:38:21 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-148.phx2.redhat.com [10.3.112.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A27BE39A5F
        for <linux-nfs@vger.kernel.org>; Wed,  7 Apr 2021 19:38:21 +0000 (UTC)
Subject: Re: [PATCH] NFS server should enable RDMA by default
From:   Steve Dickson <SteveD@RedHat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20210407141810.33710-1-steved@redhat.com>
Message-ID: <9ae5a73c-7435-471b-a14b-e673bdf77c14@RedHat.com>
Date:   Wed, 7 Apr 2021 15:40:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210407141810.33710-1-steved@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 4/7/21 10:18 AM, Steve Dickson wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Product is shipped with NFS/RDMA disabled by default.
> An extra step is needed when setting up an NFS server
> to support NFS/RDMA clients.
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1931565
> 
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed... (tag: nfs-utils-2-5-4-rc2)

steved.
> ---
>  nfs.conf | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/nfs.conf b/nfs.conf
> index 9042d27d..31994f61 100644
> --- a/nfs.conf
> +++ b/nfs.conf
> @@ -72,9 +72,9 @@
>  # vers4.0=y
>  # vers4.1=y
>  # vers4.2=y
> -# rdma=n
> -# rdma-port=20049
> -#
> +rdma=y
> +rdma-port=20049
> +
>  [statd]
>  # debug=0
>  # port=0
> 

