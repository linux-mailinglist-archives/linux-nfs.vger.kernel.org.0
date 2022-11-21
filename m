Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8AFD631ECC
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Nov 2022 11:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiKUKxd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Nov 2022 05:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKUKxb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Nov 2022 05:53:31 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4571EEE7
        for <linux-nfs@vger.kernel.org>; Mon, 21 Nov 2022 02:53:30 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id f18so27610078ejz.5
        for <linux-nfs@vger.kernel.org>; Mon, 21 Nov 2022 02:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oVR9zxWFI/yiTfyZ4zmDueQDkqj32nHPs9Uh0PG4vPE=;
        b=KOwk43K2prxMCTWU5zSDoD7OjmzMBpZe59DoyncDt6F+Tc+Qtsvgf+G5R0i17IT+Nj
         3gvfVY0T0UI3OCVP31Cq8Ar0xgsEjJD4bJn5jEFhuvh0dEd7Z0nFgvwKuA6na0brxsD4
         YoLyr+iMi5GVBqKJsZYB1KlyEU41+29Va65MF/LNUJq3dEJA2A0PSFCdO1UnYKiKH8TK
         A1o6q7JMNuSS3kDcOWAHOUt3HLy6qmD3lSiknCa1sZtShQ0PMymnlJxVg1/gfvzGsVIs
         kCydES3mx6bQxzdRK2QcZgTLQLu68suH5cg2TxcFPmrtS7oFhHTx4ZIoeyyF9xHVJA7E
         1yMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oVR9zxWFI/yiTfyZ4zmDueQDkqj32nHPs9Uh0PG4vPE=;
        b=730M6LCHp5kX7uC7u2BC+ycIfivI+EzxkCitULY7DA7mvt5U+Rsj0LjSnLAn5yRUEb
         cAJaZoN+mdMHpXh8I/zwOO9GagTDqLlvG7yhcpOjv5OIdJW3ugbb4/Zh0kBqT7mjw7XL
         vTecNArAcmnSrZIkOv54XKOoXuGUftxUtV3/y6jQcQ/AvPxwIwKWXykVvzp2FseIK5db
         yDssdnA1orY2DXxVGYFHOlbo75hEKXX5AnMebVUv60DG+y6f7LQsOiiqBZWLCZ8GceZd
         0dS+T9IjHmriyWJdLM7S38/UwW5bZLY/bkjo9Bgn97rKQ05rqJF+NDNSRxrcVV4Q9WDr
         L5gg==
X-Gm-Message-State: ANoB5pkwT9XJB/zC7KExPCZYmR0syHKD4oHjvSklTlAgY1xEy8Q6s/tt
        gDngiKDw2iDL40+ldzTfw2KsgrX+LF3zGkgg
X-Google-Smtp-Source: AA0mqf70BnFvfvb0IuSIgQsK2SzIyUkBrZLyuZoXrSWjPOnvQcHmbXrvzYpC3wtlID8hDdv5F+6kMg==
X-Received: by 2002:a17:906:81c4:b0:78d:9858:e538 with SMTP id e4-20020a17090681c400b0078d9858e538mr15153542ejx.502.1669028008557;
        Mon, 21 Nov 2022 02:53:28 -0800 (PST)
Received: from [192.168.0.161] (79-100-144-200.ip.btc-net.bg. [79.100.144.200])
        by smtp.gmail.com with ESMTPSA id i17-20020aa7c9d1000000b004638ba0ea96sm4962888edt.97.2022.11.21.02.53.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 02:53:25 -0800 (PST)
Message-ID: <a153b239-26f4-9813-beb8-bf74d19808ef@blackwall.org>
Date:   Mon, 21 Nov 2022 12:53:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 1/5] kobject: make kobject_get_ownership() take a constant
 kobject *
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Roopa Prabhu <roopa@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org
References: <20221121094649.1556002-1-gregkh@linuxfoundation.org>
From:   Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20221121094649.1556002-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 21/11/2022 11:46, Greg Kroah-Hartman wrote:
> The call, kobject_get_ownership(), does not modify the kobject passed
> into it, so make it const.  This propagates down into the kobj_type
> function callbacks so make the kobject passed into them also const,
> ensuring that nothing in the kobject is being changed here.
> 
> This helps make it more obvious what calls and callbacks do, and do not,
> modify structures passed to them.
> 
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
> Cc: Anna Schumaker <anna@kernel.org>
> Cc: Roopa Prabhu <roopa@nvidia.com>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Chuck Lever <chuck.lever@oracle.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: linux-nfs@vger.kernel.org
> Cc: bridge@lists.linux-foundation.org
> Cc: netdev@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/base/class.c    | 2 +-
>  drivers/base/core.c     | 8 ++++----
>  fs/nfs/sysfs.c          | 4 ++--
>  include/linux/kobject.h | 8 ++++----
>  lib/kobject.c           | 4 ++--
>  net/bridge/br_if.c      | 2 +-
>  net/core/net-sysfs.c    | 8 ++++----
>  net/sunrpc/sysfs.c      | 8 ++++----
>  8 files changed, 22 insertions(+), 22 deletions(-)
> 

For the bridge:
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


