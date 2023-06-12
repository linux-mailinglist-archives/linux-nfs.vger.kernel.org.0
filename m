Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85B072D01D
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jun 2023 22:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbjFLUFt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jun 2023 16:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237181AbjFLUFn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Jun 2023 16:05:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFB2186
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 13:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686600302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fO1ZuLJX1+g0LRifhG1Uoj9kHx5pU9L4ooeGptfkXiM=;
        b=Yrg69P8ol8XzcG19F5wMPe8qrDzYIJa8oJQ7pAV0qr4DzW/fACDwEQBqMV2VbKmloNacX1
        uejKZiUI21BVZWe/mdw4tX7TCvmLhcYlWXu184FfIgC+H+cKzSGxfzo3hdtsO/mBjKZrDd
        ttxO1Y1uTkzPxOp9LenGF9g9raxQ39k=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-QkaovoYMPoeSCvlfM8w2Xw-1; Mon, 12 Jun 2023 16:05:01 -0400
X-MC-Unique: QkaovoYMPoeSCvlfM8w2Xw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-62df51e64c2so93196d6.0
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 13:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686600299; x=1689192299;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fO1ZuLJX1+g0LRifhG1Uoj9kHx5pU9L4ooeGptfkXiM=;
        b=dwynejVKNOUrb1A9+NN7Qu3dl6Cg9WK0kycqpzaLp87fcVVSUsjCIdCi+dRosCSj5K
         W41VHWA0okWeuwe/9u8sCa3YiYmF9dQMMjNKOxLAiV5vAEfJlonSqIjRd9/yv/CCPDMS
         DqesdK00z67Zv2QLuD8QdffeqzjRGAdhhReBxREz7iKZtJ625/JZ72H26Dt5Qd7rXTB1
         X728/i0rcxf0pEm9vusKHPOHElZt3U4UakrvuGrW0nztKtwL45t7GkeqUi7UpnBQM2fm
         FECSJD3/Ue1CYFwx/qjZAEXG7IlPLPj4zVL09fsJLR2nfDkvxXitIwYyfdnBaXUhYu0j
         Dw8w==
X-Gm-Message-State: AC+VfDwAbrqho+3dNsDsCPI80g//qCN8IHcoGyiJKsnTRSQsM8uMlklF
        9BvzMHy5JO0m6/iJq4LdxNyVinJBF37T0hqPAYxPvMjCL2T3tTycMCZVCoXuRdrmozRAD3a/ly8
        H4PcLzFEz8t5EXdw4FwWKmIAvzj+G
X-Received: by 2002:ad4:5c4c:0:b0:62b:6a5e:e956 with SMTP id a12-20020ad45c4c000000b0062b6a5ee956mr12710608qva.5.1686600299693;
        Mon, 12 Jun 2023 13:04:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ543wabhsw76lFXMyxk7YfMDB+k/qUWAw8EWWu3U2H5qtxJm9Lj30S9mcw+z0IjqhaHAN9gGA==
X-Received: by 2002:ad4:5c4c:0:b0:62b:6a5e:e956 with SMTP id a12-20020ad45c4c000000b0062b6a5ee956mr12710590qva.5.1686600299464;
        Mon, 12 Jun 2023 13:04:59 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.249.84])
        by smtp.gmail.com with ESMTPSA id m1-20020a0ce6e1000000b006238b37fb05sm3470808qvn.119.2023.06.12.13.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 13:04:58 -0700 (PDT)
Message-ID: <13860fcd-f920-9ef1-4737-a8d87ebf9914@redhat.com>
Date:   Mon, 12 Jun 2023 16:04:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [nfs-utils PATCH 0/3] Add docs for some mount options missing
 from nfs(5)
Content-Language: en-US
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     linux-nfs@vger.kernel.org
References: <20230601194617.2174639-1-smayhew@redhat.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20230601194617.2174639-1-smayhew@redhat.com>
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



On 6/1/23 3:46 PM, Scott Mayhew wrote:
> Scott Mayhew (3):
>    nfs(5): Document the softerr mount option.
>    nfs(5): Document the write=lazy|eager|wait mount option.
>    nfs(5): Document the trunkdiscovery/notrunkdiscovery mount option.
> 
>   utils/mount/nfs.man | 84 +++++++++++++++++++++++++++++++++------------
>   1 file changed, 63 insertions(+), 21 deletions(-)
> 
Committed... (tag: nfs-utils-2-6-4-rc2)

steved.

