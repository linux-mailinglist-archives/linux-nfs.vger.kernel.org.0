Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AEB6FFA96
	for <lists+linux-nfs@lfdr.de>; Thu, 11 May 2023 21:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239447AbjEKTlR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 11 May 2023 15:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239446AbjEKTkr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 11 May 2023 15:40:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC811981
        for <linux-nfs@vger.kernel.org>; Thu, 11 May 2023 12:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683833949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c4y9ehrg743FuJsYRQgdFBgKVGOgrzengkNpj2cvWQc=;
        b=XZAx9SlIp8CuLqJflZm/y+OJrcgAs7HtKrxb/MdKVnwArLnreTmcNTjjUTaIP5Ptr41kQL
        dniftJhduIZy3G+wKxeDk/7j3o1lFVJIdIhc39MW4TOtP4OBkhswbM1c9+uYBcoiSFP25H
        P0xBR/rKfGy2uP0X1vvWBQ5dIkK4cMk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-qGWMNa5_NdamXgUJwSJVCg-1; Thu, 11 May 2023 15:39:07 -0400
X-MC-Unique: qGWMNa5_NdamXgUJwSJVCg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-757829463dfso14235285a.0
        for <linux-nfs@vger.kernel.org>; Thu, 11 May 2023 12:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683833946; x=1686425946;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c4y9ehrg743FuJsYRQgdFBgKVGOgrzengkNpj2cvWQc=;
        b=YvzhxTfD2AHPOTU7QXLb3lh7kbObSixlA8pANhJBhiR32IeXaVRAaH36OSmMZyoeBW
         KSL0IlWYtUebMLebyDCJeF9D8SdUXsJOSE9OfFv23cu+yQn8N/7I+msS7z7iBdH20KMw
         RpcI34ygCrNc8JSAddo72yeKA5AfCItZtPnHKft6Yy77QGoJu0RG5K2p865t3zzo3blV
         d3D30boxokn3/augGThGRrj9CeXF32h6E0+kipq8a0jAMavda17QW/dPY1mNO6AsB1WD
         S9FHdWxuyV4jOcqwv7nY3GzBO08JGN5HdqudjAlfuPDx85zvq6zWsVyp8ZYdOWxgT8Q8
         YYqg==
X-Gm-Message-State: AC+VfDyMKJHnjQFlAyVLKTTqfx95uPFHGXYwru2bDBIvf8kJm7HnBGNS
        i8VOrSQ8j8ndyBQjqoSFJEVwCRdzt3UFE01kfGmaRQgbl/YeCQIQbmHQDkyD/NsjgxNHjfNZ9zN
        Rt//SO1oot4OqkhvU2AoDArAYz+c1
X-Received: by 2002:a05:622a:1807:b0:3f3:98b7:7df with SMTP id t7-20020a05622a180700b003f398b707dfmr16413880qtc.6.1683833945832;
        Thu, 11 May 2023 12:39:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7aHeIWbtUoals9FIqz9ilrOsO0y1l04VsF+6e/JtEMO/JHaR7Q55dqMQryZntFaBv4YwHGyg==
X-Received: by 2002:a05:622a:1807:b0:3f3:98b7:7df with SMTP id t7-20020a05622a180700b003f398b707dfmr16413858qtc.6.1683833945554;
        Thu, 11 May 2023 12:39:05 -0700 (PDT)
Received: from [10.19.60.48] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z29-20020ac8431d000000b003f3941ba4d9sm2494515qtm.32.2023.05.11.12.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 12:39:04 -0700 (PDT)
Message-ID: <9914d172-986f-7c86-fe03-4378e64383f1@redhat.com>
Date:   Thu, 11 May 2023 15:39:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/2] Minor improvements for fsidd in nfs-utils
Content-Language: en-US
To:     NeilBrown <neilb@suse.de>, Richard Weinberger <richard@nod.at>
Cc:     linux-nfs@vger.kernel.org
References: <168352657591.17279.393573102599959056.stgit@noble.brown>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <168352657591.17279.393573102599959056.stgit@noble.brown>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 5/8/23 2:19 AM, NeilBrown wrote:
> nfs-utils in openSUSE was recently updated to a version with fsidd and a
> routine security audit was performed.  No real security issues were
> found but a couple of oddities were highlighted.  The follow two patches
> propose ways to clean up these oddities.
> 
> NeilBrown
> 
> 
> ---
> 
> NeilBrown (2):
>        fsidd: don't use assert() on expr with side-effect.
>        fsidd: provide better default socket name.
> 
> 
>   support/reexport/fsidd.c    | 38 +++++++++++++++++++++----------------
>   support/reexport/reexport.c |  3 +++
>   support/reexport/reexport.h |  2 +-
>   3 files changed, 26 insertions(+), 17 deletions(-)
> 
> --
> Signature
> 
Committed... (tag: nfs-utils-2-6-4-rc1)

steved

