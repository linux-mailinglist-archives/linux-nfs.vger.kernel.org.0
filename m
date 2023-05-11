Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D49A6FFADB
	for <lists+linux-nfs@lfdr.de>; Thu, 11 May 2023 21:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239011AbjEKTvm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 11 May 2023 15:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238620AbjEKTvl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 11 May 2023 15:51:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7253219AE
        for <linux-nfs@vger.kernel.org>; Thu, 11 May 2023 12:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683834601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0PHzhoOBn/ABK7cWRQa4+LAWWY5a6aj+OEBRCst7IPY=;
        b=cQbJ+D5/nvxD8IVGPyif6EAU1O5aMmvapu8SQ/Vnr7r9/qC/U4TMpRXdgawLdF2CFKo3f2
        xgrPNq0uPDXMm70C9SOjhSiKV87BtLN7smOKboiX3RsgYAl0sUE6TAqyLfbMTVqB8+Vb1P
        /XwXuau9hOubI8MNS0IPRNcpYQhivWY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-8OOUXv9nNBWOwMJm74UCtA-1; Thu, 11 May 2023 15:39:41 -0400
X-MC-Unique: 8OOUXv9nNBWOwMJm74UCtA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-61b636b5f90so9117026d6.1
        for <linux-nfs@vger.kernel.org>; Thu, 11 May 2023 12:39:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683833980; x=1686425980;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0PHzhoOBn/ABK7cWRQa4+LAWWY5a6aj+OEBRCst7IPY=;
        b=QdwfYH0DUh7NXn4D6g5hMT54qd08elnBzL6ELeTrB8r/qbSuOxT6n+5Nvq2KvzWNge
         XQfF1vbEdD2zuJ+Xl4H9Lx7dA7ByEUXLgc0W4iHO8eGDqhlkbeo/b8TQA8Jif3eufsr+
         hXaFucfV+HB81xqbYodZxaTEVi9DOvB/dq08TPJzlEAZU9KIcBxVlGyLPPDXTi/wqK2l
         ZDbn15LDAfeWqmgddglSKa8gtktKoCulpwv0vtAbF3GYNxaEqb7fi3ZiU10AWeBz++t/
         s4HC6svzDGdyGA4rOTam1qmLLmrJF3X8dE/nn/CLBGIE2AaFf6Hfi0oAsb9XF2QHGL7C
         M8bA==
X-Gm-Message-State: AC+VfDyTW5sFwIYWOcwXvsMCUV7zPz2K6ka/efOw/TAJ7ELHWnQm70Gx
        fIIpu77ofWcFrZmE/FL3kwo8Ddasjf94LXxbpJL+RS6ZW/WOE7ECua9EOy5xYBFwG+spfh5La6G
        C+2k157HFud3HF7uSMY4GGWu7T56v
X-Received: by 2002:a05:6214:3001:b0:61b:c013:ef4e with SMTP id ke1-20020a056214300100b0061bc013ef4emr31278134qvb.2.1683833980113;
        Thu, 11 May 2023 12:39:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Bh508xsH+/KSqBeK9RF5c8RKGq7V1ICwW7h4+9A2XzX3SeOKn0uaktdkDbmxyDoqeoTS8Sg==
X-Received: by 2002:a05:6214:3001:b0:61b:c013:ef4e with SMTP id ke1-20020a056214300100b0061bc013ef4emr31278104qvb.2.1683833979811;
        Thu, 11 May 2023 12:39:39 -0700 (PDT)
Received: from [10.19.60.48] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id f10-20020a05622a114a00b003f4e1cf23easm996405qty.73.2023.05.11.12.39.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 12:39:39 -0700 (PDT)
Message-ID: <f7c668bd-9c04-39e2-6b35-54a131b85f34@redhat.com>
Date:   Thu, 11 May 2023 15:39:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] libevent and libsqlite3 checked when nfsv4 is disabled
Content-Language: en-US
To:     Wiktor Jaskulski <wikjas97@gmail.com>, linux-nfs@vger.kernel.org
Cc:     wjaskulski <wjaskulski@adva.com>
References: <20230510115637.29271-1-wjaskulski@adva.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20230510115637.29271-1-wjaskulski@adva.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 5/10/23 7:56 AM, Wiktor Jaskulski wrote:
> From: wjaskulski <wjaskulski@adva.com>
> 
> Even if nfsv4 is disabled component fsidd has libevent and libsqlite3 as dependencies.
> 
> Problems with compilation and error logs can be found at:
> https://github.com/gentoo/gentoo/pull/30789
> https://bugs.gentoo.org/904718
> 
> Signed-off-by: Wiktor Jaskulski <wjaskulski@adva.com>
Committed... (tag: nfs-utils-2-6-4-rc1)

steved
> ---
>   configure.ac | 38 +++++++++++++++-----------------------
>   1 file changed, 15 insertions(+), 23 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 4ade528d..519cacbf 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -335,42 +335,34 @@ AC_CHECK_HEADER(rpc/rpc.h, ,
>                   AC_MSG_ERROR([Header file rpc/rpc.h not found - maybe try building with --enable-tirpc]))
>   CPPFLAGS="${nfsutils_save_CPPFLAGS}"
>   
> +dnl check for libevent libraries and headers
> +AC_LIBEVENT
> +
> +dnl Check for sqlite3
> +AC_SQLITE3_VERS
> +
> +case $libsqlite3_cv_is_recent in
> +yes) ;;
> +unknown)
> +   dnl do not fail when cross-compiling
> +   AC_MSG_WARN([assuming sqlite is at least v3.3]) ;;
> +*)
> +   AC_MSG_ERROR([nfsdcld requires sqlite-devel]) ;;
> +esac
> +
>   if test "$enable_nfsv4" = yes; then
> -  dnl check for libevent libraries and headers
> -  AC_LIBEVENT
>   
>     dnl check for the keyutils libraries and headers
>     AC_KEYUTILS
>   
> -  dnl Check for sqlite3
> -  AC_SQLITE3_VERS
> -
>     if test "$enable_nfsdcld" = "yes"; then
>   	AC_CHECK_HEADERS([libgen.h sys/inotify.h], ,
>   		AC_MSG_ERROR([Cannot find header needed for nfsdcld]))
> -
> -    case $libsqlite3_cv_is_recent in
> -    yes) ;;
> -    unknown)
> -      dnl do not fail when cross-compiling
> -      AC_MSG_WARN([assuming sqlite is at least v3.3]) ;;
> -    *)
> -      AC_MSG_ERROR([nfsdcld requires sqlite-devel]) ;;
> -    esac
>     fi
>   
>     if test "$enable_nfsdcltrack" = "yes"; then
>   	AC_CHECK_HEADERS([libgen.h sys/inotify.h], ,
>   		AC_MSG_ERROR([Cannot find header needed for nfsdcltrack]))
> -
> -    case $libsqlite3_cv_is_recent in
> -    yes) ;;
> -    unknown)
> -      dnl do not fail when cross-compiling
> -      AC_MSG_WARN([assuming sqlite is at least v3.3]) ;;
> -    *)
> -      AC_MSG_ERROR([nfsdcltrack requires sqlite-devel]) ;;
> -    esac
>     fi
>   
>   else

