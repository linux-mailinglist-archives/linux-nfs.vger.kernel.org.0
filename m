Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9BA756F1C
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jul 2023 23:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjGQVtJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Jul 2023 17:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGQVtI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Jul 2023 17:49:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAECC18C
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jul 2023 14:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689630498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K+EyE2QbRkAvOrPfcyegLMwUxP5zgW6KdyG5negjf1g=;
        b=bEkiBd+JWvb+mWznU8llJ0GZzJroFJ9PnwzTj6X7+/hZ78zeQGQuyHyo1zDUhmHEojYtRD
        kpWxrk67yUBbgTZM0CkF86zi9LaD09PVYZeUuSOxUdM9OjL6WNnKWL7OtWAVd1RGMxn96V
        E1IO/7tyo0A3EsXNA0d6G4Lr2HwgXXE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-RmFcROKcNX6Do7IEV3HYMw-1; Mon, 17 Jul 2023 17:48:16 -0400
X-MC-Unique: RmFcROKcNX6Do7IEV3HYMw-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-401e1fc831fso9028371cf.1
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jul 2023 14:48:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689630495; x=1692222495;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K+EyE2QbRkAvOrPfcyegLMwUxP5zgW6KdyG5negjf1g=;
        b=LHJ3RkFompgrmW07346M6FPltU9qyrxS1gL7KThyfhM/6yAUILGwwZ3d4CQkBqg0CF
         uKDCDEl3PAgGxjuF5ZKJVkgYPY8nMnTnV1zUsFjzH/BSx2Ztz4INhOHOLltpfaZkToF0
         rGfpy4Hhb9UrdKlgsHm6R2GmBA1xjBAHHRh4Ag7nBS5F4ewUDdI0jGOBv7heH4OOf7VD
         vhMX6JbA8p3cOUmthyZSdfXWN/+6B7HalSfIIdGcZ0N0/lvwBQowsfJzw+HNzvndFDPf
         Lirmxp6uZcvCOdniiXAsUdfNWOjYFVXsAtrkr4bEQXO2kt+mDw9wHxVRO57j0SEJ15Tf
         iHeQ==
X-Gm-Message-State: ABy/qLaKhM8ymZTj8vVuwZUMcSWCXEdDAiPfcUTnzD722U6EZp3Kg+LU
        77v5+EhRC3AuQBi/eCfDLLnkJvwZR//I57kFUj5LuJpFHStGxlHijYqUK21AIxJ4MIkejP5GYS4
        f5B8x+Vtv2Us/8fOWaLvCiIZhYP/T
X-Received: by 2002:a05:622a:1884:b0:400:aaa0:a4ef with SMTP id v4-20020a05622a188400b00400aaa0a4efmr9043927qtc.6.1689630495622;
        Mon, 17 Jul 2023 14:48:15 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHstyCvWGjdoDMceawBR8xdSBPawalrQ8SeJH8VNrHPdzXhc3mpC5hBKaL3L/I/MMbS/qT9YQ==
X-Received: by 2002:a05:622a:1884:b0:400:aaa0:a4ef with SMTP id v4-20020a05622a188400b00400aaa0a4efmr9043919qtc.6.1689630495404;
        Mon, 17 Jul 2023 14:48:15 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.251.231])
        by smtp.gmail.com with ESMTPSA id k10-20020ac8474a000000b004033c3948f9sm163946qtp.42.2023.07.17.14.48.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 14:48:14 -0700 (PDT)
Message-ID: <fd91b129-b383-9b1d-0978-032a7ff92dbb@redhat.com>
Date:   Mon, 17 Jul 2023 17:48:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/2] Mitigate startup race between DNS resolution and
 idmapd
Content-Language: en-US
To:     Aram Akhavan <github@aram.nubmail.ca>, linux-nfs@vger.kernel.org
References: <20230613034625.498132-1-github@aram.nubmail.ca>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20230613034625.498132-1-github@aram.nubmail.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 6/12/23 11:46 PM, Aram Akhavan wrote:
> idmapd needs DNS resolution on startup if a domain isn't specified by
> config file. This isn't trivial since even with systemd's
> network-online.target, DNS resolution isn't guaranteed. On Debian,
> for example (in part due to some lingering bugs), adding the
> target, and even enabling the not-well-documented
> ifupdown-wait-online.service is not enough. These two patches aim to
> improve the startup behavior in common setup scenarios.
> 
> Aram Akhavan (2):
>    nfs-idmapd.service: add network-online.target to Wants= and After=
>    libnfsidmap: try to get the domain directly from hostname if the DNS
>      lookup fails and always show the log message if the domain can't be
>      determined
> 
>   support/nfsidmap/libnfsidmap.c | 15 ++++++++++-----
>   systemd/nfs-idmapd.service     |  3 ++-
>   2 files changed, 12 insertions(+), 6 deletions(-)
> 
Both committed... (Tag nfs-utils-2-6-4-rc3)

steved

