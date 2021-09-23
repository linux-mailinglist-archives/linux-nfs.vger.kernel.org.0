Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2831A41636F
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Sep 2021 18:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbhIWQjN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Sep 2021 12:39:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32478 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229913AbhIWQjN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Sep 2021 12:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632415061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L2jbsvq6ThplQkE3QbouPBbTYHJLT+j/7dQ1YqfWeP4=;
        b=S0Bp3xq+6ZyhY5q4BU45eF4aCduQBJ/HwJGZpYbHHLTWUt8K+Zf3RR+gK8tEet8H5561ER
        mH+JL7sLAChXe3s1asspAEdEghKPdzo9srUdiHN3nlQG5hBdBZfUpTewlSb+dUNLTJSMwa
        mqjcQoHbHSk09/MrhX2Y55RxQJvqunM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-dPmp7RSfOdOz1t6jJ3YGWg-1; Thu, 23 Sep 2021 12:37:39 -0400
X-MC-Unique: dPmp7RSfOdOz1t6jJ3YGWg-1
Received: by mail-qk1-f197.google.com with SMTP id g8-20020a05620a40c800b0045ce49e5340so11073738qko.14
        for <linux-nfs@vger.kernel.org>; Thu, 23 Sep 2021 09:37:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L2jbsvq6ThplQkE3QbouPBbTYHJLT+j/7dQ1YqfWeP4=;
        b=WY2flsrmFPmVOBWlgf1WKk38f4UWMPMHmAIn9+cjM5xipzgQoraamlGv/lKjBfsuV5
         jJtOz9cqkTtXvac6QSBelyHQHRiqC0k5DtZyi/2IrzLPtu9bXkiJS4uhKYfD0HChHAMa
         MLIhwHKRmdbYcB7/TV8EYmhooPlyCufDjgxne3BnZbp7+VwXWWXJDdWci/z8av/JqIVi
         i9tWNoTyY+FWgrCB8h2IhauOfHEvQKOcee2AHsQVjkR0uQCcivyrCzIRPDOiEXA00/v0
         tjkTs3cCEtllszn2u87zLjEwX4altMkzAELxY/pLDmmXX+CCeelbJaKE667T5Nc1xyvA
         6bDQ==
X-Gm-Message-State: AOAM530b9A37+v7/ZQB/Jm5Gmmadivcrc+v3DQInydHUC0PKTymX42OO
        SsmAIOA4knxBDJgO0fymlSnEl0RzeqWNUhZoY/P26YviSlw0Btg5JhTmF8fixGwnQ7th2wF03Dn
        sdrvfdcZ/dGH6/EXFdpKjlfep5xa/PYrnVOFOdakdTTX1UowXhw8QCvJ9MRKsFVczsCKQjg==
X-Received: by 2002:ac8:7482:: with SMTP id v2mr5636701qtq.235.1632415059330;
        Thu, 23 Sep 2021 09:37:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwjEz1s+Q7ZUPxjvZcsQNrEC8cgSsLhd4sfx7DdC5dPQUD3ZdCzls9JqlmEI+8ZIurhJ6MwA==
X-Received: by 2002:ac8:7482:: with SMTP id v2mr5636687qtq.235.1632415059077;
        Thu, 23 Sep 2021 09:37:39 -0700 (PDT)
Received: from madhat.boston.devel.redhat.com ([70.105.255.190])
        by smtp.gmail.com with ESMTPSA id t17sm3581405qtq.56.2021.09.23.09.37.38
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 09:37:38 -0700 (PDT)
Subject: Re: [PATCH 2/2] mountd: only do NFSv4 logging on supported kernels.
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20210922153610.60548-1-steved@redhat.com>
 <20210922153610.60548-2-steved@redhat.com>
Message-ID: <8b1f3031-f288-851d-a656-4e95092358a1@redhat.com>
Date:   Thu, 23 Sep 2021 12:37:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210922153610.60548-2-steved@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 9/22/21 11:36 AM, Steve Dickson wrote:
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1979816
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed... (tag: nfs-utils-2-5-5-rc3)

steved.

> ---
>   support/export/v4clients.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/support/export/v4clients.c b/support/export/v4clients.c
> index dd985463..5e4f1058 100644
> --- a/support/export/v4clients.c
> +++ b/support/export/v4clients.c
> @@ -10,6 +10,7 @@
>   #include <sys/inotify.h>
>   #include <errno.h>
>   #include "export.h"
> +#include "version.h"
>   
>   /* search.h declares 'struct entry' and nfs_prot.h
>    * does too.  Easiest fix is to trick search.h into
> @@ -23,6 +24,8 @@ static int clients_fd = -1;
>   
>   void v4clients_init(void)
>   {
> +	if (linux_version_code() < MAKE_VERSION(5, 3, 0))
> +		return;
>   	if (clients_fd >= 0)
>   		return;
>   	clients_fd = inotify_init1(IN_NONBLOCK);
> 

