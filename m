Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69562542421
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jun 2022 08:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiFHCzq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Jun 2022 22:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448223AbiFHCxu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Jun 2022 22:53:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1E8231911
        for <linux-nfs@vger.kernel.org>; Tue,  7 Jun 2022 13:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654635180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dDw+DFbo1nylc/ZiLyMhKBIGXqJWaoeV1uhIrGfNhiQ=;
        b=ds3bn5iIf88DceNdjuRFD9hZTq7uAnrTDJ3rPJtgzulT6N+EemM6QKX/onKC5l6lm+pM1u
        8uUzYidCe8TSI2b4M/wXV68v/k49p7X2mtwADlUIi1oDGo4uHmS9n+rkCSsId33H3xGccy
        WEzp+NpEr3kkDx+idBYooqV13Tw7KKk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-434-SqYdQk-cMMqEwHv7GE2dzQ-1; Tue, 07 Jun 2022 16:52:59 -0400
X-MC-Unique: SqYdQk-cMMqEwHv7GE2dzQ-1
Received: by mail-qt1-f199.google.com with SMTP id f22-20020ac859d6000000b00304bf4dba7fso14851775qtf.3
        for <linux-nfs@vger.kernel.org>; Tue, 07 Jun 2022 13:52:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dDw+DFbo1nylc/ZiLyMhKBIGXqJWaoeV1uhIrGfNhiQ=;
        b=joQOCC/vVhjYYJ4DD5bobS9xhNJYOojtt3kiqw9JXzr0wxVyz2/J5+qlL4gLaxcxP0
         jotmfnH31xyfPoXI6I+I20xvNM1z9Hnno/wA9sv7uw7IK0exJG56lxQUtsVt680UR7wU
         r0NLBAWWQ0jBJeQCwl/1D+cWDv+8rSUNNXGvAyc/8psxYYYc+Kc1pJQFMRWVamrMXIyB
         wr2KVk7HNybhpX1nLJys/wu4JBToBiTHz45+nwL4cdYPwZ8p0/nAALUZa4wSn8EF0tnR
         +Tc63iwz7VPWo6FTEzprWsKvs1jzzIG6M1KoF/EVi1TnbJTkIVG0CbGkrN8VgRCm/RFf
         UwUg==
X-Gm-Message-State: AOAM532w/rf81rhBRYQPJJzn4O5qNvc/GGFu2H4rPa/JSoVz1xSJoSsh
        BkoHap0+lSxp/FywYJj9x8mwfa6lFKvNa102Q0H+t3oPFBuRIsCYVXX9YguSklgDsVqSYloJnDv
        2PaWzdSOYg9KcGdLEfb6m
X-Received: by 2002:a05:620a:469e:b0:6a6:d363:813b with SMTP id bq30-20020a05620a469e00b006a6d363813bmr5225249qkb.621.1654635179190;
        Tue, 07 Jun 2022 13:52:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx46flULz7YMo6mFAEAxPTn6DL11v0DHTPy6HME2mKrSX/ulqJ2gBAbtvcNaaJ4cc/CJIAxbw==
X-Received: by 2002:a05:620a:469e:b0:6a6:d363:813b with SMTP id bq30-20020a05620a469e00b006a6d363813bmr5225238qkb.621.1654635178924;
        Tue, 07 Jun 2022 13:52:58 -0700 (PDT)
Received: from [172.31.1.6] ([71.161.96.106])
        by smtp.gmail.com with ESMTPSA id d22-20020a05620a241600b006a6b1630e95sm8461606qkn.45.2022.06.07.13.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 13:52:58 -0700 (PDT)
Message-ID: <86b11317-f663-602b-0459-129aa2101ba1@redhat.com>
Date:   Tue, 7 Jun 2022 16:52:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH nfs-utils] autoconf: change tirpc to check for a file, not
 for an include
Content-Language: en-US
To:     NeilBrown <neilb@suse.de>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <165352672998.11129.5573262612495384287@noble.neil.brown.name>
 <165352679825.11129.7422243280120268766@noble.neil.brown.name>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <165352679825.11129.7422243280120268766@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 5/25/22 8:59 PM, NeilBrown wrote:
> 
> Recent autoconf don't like variables in AC_CHECK_INCLUDE so we get a
> warning.
> In libtirpc.m4 we only need to check for the existence of a file, we
> don't need to extra  support for includes, such as defining HAVE_TIRPC_H
> or whatever.
> 
> So change from AC_CHECK_INCLUDE to AC_CHECK_FILE.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
Committed... (tag: nfs-utils-2-6-2-rc6)

steved.
> ---
>   aclocal/libtirpc.m4 | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/aclocal/libtirpc.m4 b/aclocal/libtirpc.m4
> index f7de5193c177..bddae0226931 100644
> --- a/aclocal/libtirpc.m4
> +++ b/aclocal/libtirpc.m4
> @@ -49,9 +49,9 @@ AC_DEFUN([AC_LIBTIRPC_OLD], [
>     dnl Also must have the headers installed where we expect
>     dnl to look for headers; add -I compiler option if found
>     AS_IF([test "$has_libtirpc" = "yes"],
> -        [AC_CHECK_HEADERS([${tirpc_header_dir}/netconfig.h],
> -                          [AC_SUBST([AM_CPPFLAGS], ["-I${tirpc_header_dir}"])],
> -                          [has_libtirpc="no"])])
> +        [AC_CHECK_FILE([${tirpc_header_dir}/netconfig.h],
> +                       [AC_SUBST([AM_CPPFLAGS], ["-I${tirpc_header_dir}"])],
> +                       [has_libtirpc="no"])])
>   
>     dnl Now set $LIBTIRPC accordingly
>     AS_IF([test "$has_libtirpc" = "yes"],

