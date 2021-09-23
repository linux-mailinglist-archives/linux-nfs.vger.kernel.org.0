Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBFA441636D
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Sep 2021 18:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbhIWQib (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Sep 2021 12:38:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51226 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232056AbhIWQib (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Sep 2021 12:38:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632415019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xk56gO3TpoBFlToyz4b/nxk9oTefmH6r059wyP0p+tw=;
        b=Ci/LogNo8JhfSzCqn6ck29LvpdBOSNCWy+OrqBPxwvidJuebGtc+w5BvEBWYUCGV/NjTzy
        VHcsOVzPenxXQZLodbcgwJHhDUtVvaUWRdlgH1judDKPhIBZqN2h5dUTJE+WiOkogAYm6g
        n908KPGRNozUsb0rPsWvsJSa9LzCX8U=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-oEXaF305PrK0fr5ilmEh1A-1; Thu, 23 Sep 2021 12:36:58 -0400
X-MC-Unique: oEXaF305PrK0fr5ilmEh1A-1
Received: by mail-qv1-f70.google.com with SMTP id e8-20020a0cf348000000b0037a350958f2so20960416qvm.7
        for <linux-nfs@vger.kernel.org>; Thu, 23 Sep 2021 09:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xk56gO3TpoBFlToyz4b/nxk9oTefmH6r059wyP0p+tw=;
        b=LZbp60bHK0mF4cfpVj+cnhet7tJoF+4XFOgODxVtn9xU8SkyM7940TcS/q82o7R/fC
         O+Fzphy06qNaZxrfTlr5xw0kmkr4AG+KbwLdYNyBN0eOADVTVb1kCd/tPHQBBzSNL107
         2OiiuR46jsUwMt7JuP4pm4bOLWwoFSP5dvkXYTJ3ytN9t2hHV5y/MSf6v5Is3l7qC9ql
         /OUKfo5jSy3NifoGalXPdfTJHQDFHwmZmI7bG6qYMKIYYG8L0tp+HBvOWCEgKlLpHQOe
         2s1loc110HsvQuTsmhk6KXlfGekG+uK4Dl2Dbcoj26M/iVb7QtNRCrCKT4+gHMsUAAr4
         Cyrg==
X-Gm-Message-State: AOAM533/U9k5kfN5lfcMj9TE2M/Jx/DkvyxksLKEc6pGC+Qgtz+kcCDK
        j+j+f/nLqCU6S9x91+Rh6CoWkRA/H3B0P7qAWNtHRLyeVMsu9FTB4lFvvjB6Iv3bHB1tH9Ux18f
        fn0SWSmbTNwuMJ/OzUIC9f8TTZcT1K+5HW9SDJwbC02OCqtuHs7jd9VETSzH8UnJmyqYZCg==
X-Received: by 2002:a05:620a:52c:: with SMTP id h12mr5662158qkh.518.1632415017543;
        Thu, 23 Sep 2021 09:36:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuftSzIANTduEsZ3AYX5YXIt2rGhPtswmc2B6WLdHovGZBA6k8TFkYk3WsfPTsK/pCJL8UCw==
X-Received: by 2002:a05:620a:52c:: with SMTP id h12mr5662136qkh.518.1632415017252;
        Thu, 23 Sep 2021 09:36:57 -0700 (PDT)
Received: from madhat.boston.devel.redhat.com ([70.105.255.190])
        by smtp.gmail.com with ESMTPSA id x4sm4339318qkx.62.2021.09.23.09.36.56
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 09:36:56 -0700 (PDT)
Subject: Re: [PATCH 1/2] Move version.h into a common include directory
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20210922153610.60548-1-steved@redhat.com>
Message-ID: <cf5f0890-d848-add4-6a3d-358ed81cf00e@redhat.com>
Date:   Thu, 23 Sep 2021 12:36:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210922153610.60548-1-steved@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 9/22/21 11:36 AM, Steve Dickson wrote:
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed... (tag: nfs-utils-2-5-5-rc3)

steved.
> ---
>   support/include/version.h | 1 +
>   utils/gssd/svcgssd_krb5.c | 2 +-
>   utils/nfsd/nfssvc.c       | 2 +-
>   utils/nfsdcld/nfsdcld.c   | 2 +-
>   4 files changed, 4 insertions(+), 3 deletions(-)
>   create mode 120000 support/include/version.h
> 
> diff --git a/support/include/version.h b/support/include/version.h
> new file mode 120000
> index 00000000..b7db0bbb
> --- /dev/null
> +++ b/support/include/version.h
> @@ -0,0 +1 @@
> +../../utils/mount/version.h
> \ No newline at end of file
> diff --git a/utils/gssd/svcgssd_krb5.c b/utils/gssd/svcgssd_krb5.c
> index 305d4751..2503c384 100644
> --- a/utils/gssd/svcgssd_krb5.c
> +++ b/utils/gssd/svcgssd_krb5.c
> @@ -46,7 +46,7 @@
>   #include "gss_oids.h"
>   #include "err_util.h"
>   #include "svcgssd_krb5.h"
> -#include "../mount/version.h"
> +#include "version.h"
>   
>   #define MYBUFLEN 1024
>   
> diff --git a/utils/nfsd/nfssvc.c b/utils/nfsd/nfssvc.c
> index 720bdd97..46452d97 100644
> --- a/utils/nfsd/nfssvc.c
> +++ b/utils/nfsd/nfssvc.c
> @@ -25,7 +25,7 @@
>   #include "nfslib.h"
>   #include "xlog.h"
>   #include "nfssvc.h"
> -#include "../mount/version.h"
> +#include "version.h"
>   
>   #ifndef NFSD_FS_DIR
>   #define NFSD_FS_DIR	  "/proc/fs/nfsd"
> diff --git a/utils/nfsdcld/nfsdcld.c b/utils/nfsdcld/nfsdcld.c
> index 636c3983..dbc7a57f 100644
> --- a/utils/nfsdcld/nfsdcld.c
> +++ b/utils/nfsdcld/nfsdcld.c
> @@ -45,7 +45,7 @@
>   #include "cld.h"
>   #include "cld-internal.h"
>   #include "sqlite.h"
> -#include "../mount/version.h"
> +#include "version.h"
>   #include "conffile.h"
>   #include "legacy.h"
>   
> 

