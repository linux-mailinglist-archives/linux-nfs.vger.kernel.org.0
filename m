Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8150F5532F8
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jun 2022 15:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiFUNKD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Jun 2022 09:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiFUNKD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Jun 2022 09:10:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4AB5F1147
        for <linux-nfs@vger.kernel.org>; Tue, 21 Jun 2022 06:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655817000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ex28JFKWw/z0wCocAEwiD4Y/yi+bTkGfPguNxlLNawg=;
        b=cxkroHh3THEXPsg/WpQre0cN8eMRqKCUzokO9fteatbnjqMENtEPoJfcWWT+mZFQgQAnNN
        FrY+ir1u6kJSU65mtDqMxomUNHRgZ58cuSzCJQuvbJIOLyLBQtMUtD93vvc2LhHAPx3g+7
        N4wT7lpkCq3wcd4q3/GL4ldpo/OTUT0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-152-JzwDYTI6Nie7P5GsPi7x7w-1; Tue, 21 Jun 2022 09:09:58 -0400
X-MC-Unique: JzwDYTI6Nie7P5GsPi7x7w-1
Received: by mail-qv1-f70.google.com with SMTP id e10-20020a0ce3ca000000b004702b8819beso10318784qvl.4
        for <linux-nfs@vger.kernel.org>; Tue, 21 Jun 2022 06:09:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=ex28JFKWw/z0wCocAEwiD4Y/yi+bTkGfPguNxlLNawg=;
        b=1QAP6sVGPqZOWpY9P6rbuJi265C3L4KrL8I5m32wKRLnsgQKiET1VblHdEL84/GACd
         RRt7J1JOmKplsor367r3CXoOMQk4yH01Ox7D9KD/jLs5fbPx92qVQt7F1Ru3Zup20RHU
         fP3GTv1xX4a4UO4a32uSqRuZCZhnZGZYNblliNuZYBqmI3n3FGvwGXf4uNucdTiJnV2V
         38V0qeuOFBvgKmnEXE+jIAqN9DLU7vPkQHnbKXRNJRTOg2iRKU67h2y8bpso4ZE+DZ8N
         v54rpF6LZ8h+ByjmwFZFfxIGuaxGa7+SOAE8djeRAobFMbxUOgfEVOapIEtcyY/08TPh
         W2bQ==
X-Gm-Message-State: AJIora8uv85wcg9t3FrjG8tOn9yLLQKbAlhtOdd0c3GTJYC5I64S6QMc
        SCtXIlQXvzLbXqO20v4kdDConcIPsy4xyAI0I9kJwwPeGndT+U9E8jtxPKdf6h/wkfVGgFImulR
        2RXRPyhGeLNomheGnEIdbf6legmlxVEUMjis+Hm2m4YMLsoZidOEIa2SdGkuiRtIMAfVRxw==
X-Received: by 2002:a05:620a:4310:b0:6ac:f9df:178d with SMTP id u16-20020a05620a431000b006acf9df178dmr7676556qko.773.1655816997198;
        Tue, 21 Jun 2022 06:09:57 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tWZbnJsIJsdVzSm410QjsaCwo4y6D6keoISyDbxnMBZxluTzWbO63B+y4LiHizOannEjLORw==
X-Received: by 2002:a05:620a:4310:b0:6ac:f9df:178d with SMTP id u16-20020a05620a431000b006acf9df178dmr7676494qko.773.1655816996434;
        Tue, 21 Jun 2022 06:09:56 -0700 (PDT)
Received: from [172.31.1.6] ([70.109.186.229])
        by smtp.gmail.com with ESMTPSA id bz9-20020a05622a1e8900b00307beda5c6esm12080966qtb.26.2022.06.21.06.09.55
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 06:09:55 -0700 (PDT)
Message-ID: <a612568f-ca58-9cc2-784f-3b07791edb8e@redhat.com>
Date:   Tue, 21 Jun 2022 09:09:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/4] Makefile: Added the creation of config.guess and
 config.sub
Content-Language: en-US
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20220616202902.53969-1-steved@redhat.com>
In-Reply-To: <20220616202902.53969-1-steved@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

all 4 patches committed...

On 6/16/22 4:28 PM, Steve Dickson wrote:
> Signed-off-by: Steve Dickson <steved@redhat.com>
> ---
>   .gitignore | 2 ++
>   Makefile   | 3 +++
>   2 files changed, 5 insertions(+)
> 
> diff --git a/.gitignore b/.gitignore
> index df58159..72bdb22 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -6,6 +6,8 @@
>   aclocal.m4
>   autom4te.cache/
>   config.log
> +config.guess
> +config.sub
>   config.status
>   configure
>   include/builddefs
> diff --git a/Makefile b/Makefile
> index 5302e11..be7454d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -60,6 +60,7 @@ clean:	# if configure hasn't run, nothing to clean
>   endif
>   
>   $(CONFIGURE): aclocal.m4
> +	autoreconf --install
>   	autoconf
>   	./configure \
>   		--prefix=/ \
> @@ -96,3 +97,5 @@ install-lib: default
>   realclean distclean: clean
>   	rm -f $(LDIRT) $(CONFIGURE)
>   	rm -rf autom4te.cache Logs
> +	rm -rf config.guess config.sub configure~
> +

