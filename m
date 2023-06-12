Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1CA72D04C
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jun 2023 22:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjFLUQI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jun 2023 16:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjFLUQI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Jun 2023 16:16:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7A51730
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 13:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686600906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k6A2HRHGWSXD5CIezZWWElmM7BTn5F71Z8aBhhJxrMU=;
        b=XOFEyrUvQMfCQTsY+2YXhVJ9UtQykZ0hKGzO1Fj7Pt3GCCYyLbcb8+PGyODIntsl/2GDHO
        ST7yMmAPOFMCcXpNmYeC4d1kbI/1JJuoJEmMM8pQAWqK5U4lBpI6AoNfaRSvocDD6h69ah
        tAU7MO0oLZM/RSKzJ2Mt2+K1IEKGn1g=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-RVI1qmwzOFuNrMyELm9_2Q-1; Mon, 12 Jun 2023 16:15:05 -0400
X-MC-Unique: RVI1qmwzOFuNrMyELm9_2Q-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1a667546e8bso558060fac.1
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 13:15:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686600904; x=1689192904;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k6A2HRHGWSXD5CIezZWWElmM7BTn5F71Z8aBhhJxrMU=;
        b=DDuEipmwan7KnAysCUXKTGe2p+LNxRUeaXB/4/+mXGoDqSESYp5lfWXjD6tQlm+G9j
         XUTC1D0iwg/cNLLPo7FGh5aJA1sTO4ckQyo5YhK51Vvc0rzWUaM2AMfZRP8GFa22mMmC
         dal3+lv3nKnaofILvFvpKhCUz6JbNMqruxhfEMNqbzXWdKVz156kalEm4SYc/HdQeXFT
         ZNm/9JcQfXax4gmd/+Kh0iiAXUZmS0/TCU3TA/iG+XsbORdCL3DAyMteMRAsonuUON5o
         WTFAkTYFaDfusN4IMKgJXwQ1qv+8V/aKR+K5F1GBYnEytDBV1TAJWATZ/ue+Y1OGTq1P
         bBRQ==
X-Gm-Message-State: AC+VfDxSU5O6MPflxvBS/ULxINmluj0qhwDE5d4LGgDRlXubdYFOVzp4
        SKRs9AMtOWGv+q6PHMa2bn7i5MKBL/F31EBCecoJOIUndcpDXGc918eD82wIrNQQeuIF/A5U3Wu
        qaFCdedE4nge9+7W/72Pr
X-Received: by 2002:a05:6870:c092:b0:199:c25b:f966 with SMTP id c18-20020a056870c09200b00199c25bf966mr8881120oad.2.1686600904766;
        Mon, 12 Jun 2023 13:15:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6qJcTBI59VLuY8y2S0eiH33xNolCmKr3kRDo4dDJyC+OCGxBO7wKqT1l5/K5QNbSp/7gYuqA==
X-Received: by 2002:a05:6870:c092:b0:199:c25b:f966 with SMTP id c18-20020a056870c09200b00199c25bf966mr8881096oad.2.1686600904506;
        Mon, 12 Jun 2023 13:15:04 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.249.84])
        by smtp.gmail.com with ESMTPSA id p12-20020ae9f30c000000b0075ecdc93806sm3132465qkg.35.2023.06.12.13.15.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 13:15:03 -0700 (PDT)
Message-ID: <f8924549-f25b-00a6-cdd6-a6dc47d1f5ed@redhat.com>
Date:   Mon, 12 Jun 2023 16:15:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] support/reexport: guard dlfcn.h include with HAVE_DLFCN_H
Content-Language: en-US
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        linux-nfs@vger.kernel.org
Cc:     Bernd Kuhls <bernd.kuhls@t-online.de>
References: <20230611174506.3432934-1-giulio.benetti@benettiengineering.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20230611174506.3432934-1-giulio.benetti@benettiengineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 6/11/23 1:45 PM, Giulio Benetti wrote:
> From: Bernd Kuhls <bernd.kuhls@t-online.de>
> 
> Signed-off-by: Bernd Kuhls <bernd.kuhls@t-online.de>
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
Committed... (tag: nfs-utils-2-6-4-rc2)

steved.
> ---
>   support/reexport/fsidd.c    | 2 ++
>   support/reexport/reexport.c | 2 ++
>   2 files changed, 4 insertions(+)
> 
> diff --git a/support/reexport/fsidd.c b/support/reexport/fsidd.c
> index 37649d06..d4b245e8 100644
> --- a/support/reexport/fsidd.c
> +++ b/support/reexport/fsidd.c
> @@ -3,7 +3,9 @@
>   #endif
>   
>   #include <assert.h>
> +#ifdef HAVE_DLFCN_H
>   #include <dlfcn.h>
> +#endif
>   #include <event2/event.h>
>   #include <limits.h>
>   #include <stdint.h>
> diff --git a/support/reexport/reexport.c b/support/reexport/reexport.c
> index d597a2f7..d9a700af 100644
> --- a/support/reexport/reexport.c
> +++ b/support/reexport/reexport.c
> @@ -2,7 +2,9 @@
>   #include <config.h>
>   #endif
>   
> +#ifdef HAVE_DLFCN_H
>   #include <dlfcn.h>
> +#endif
>   #include <stdint.h>
>   #include <stdio.h>
>   #include <sys/random.h>

