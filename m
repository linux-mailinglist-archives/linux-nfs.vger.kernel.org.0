Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE6D665FCD
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jan 2023 16:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbjAKP4B (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Jan 2023 10:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236455AbjAKPzl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Jan 2023 10:55:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DC8B57
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 07:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673452495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=knkMRpMQBZXPMwjvYhj/NadjEbP7QhBbMbAV79j383A=;
        b=ZPNNqjDPQ0/028+41R7IRkNi6T3xR/Nn/1k/nskcMjiFPhmbTi4LFznAEhIeE4fV3xkSlF
        NhNAttGcU4ILZd/cgEvSkTH/Ovrh+fbL/WkO0udDseo6FI6UVJ2clf4AwHGhvGDcdz/A1r
        bapRKgi2ufCa8bLltr5XjIe+qTMVGHA=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-642-jzX70oPlM_C7uNiuUV3VPQ-1; Wed, 11 Jan 2023 10:54:54 -0500
X-MC-Unique: jzX70oPlM_C7uNiuUV3VPQ-1
Received: by mail-vk1-f198.google.com with SMTP id x22-20020a1f3116000000b003c67dc01d12so4743689vkx.17
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 07:54:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=knkMRpMQBZXPMwjvYhj/NadjEbP7QhBbMbAV79j383A=;
        b=7eUGzZSOtZ1ByBMQezxs6i6rV2Petb0KvUa7ZyDx17F1g7myBLN+yIx/7bazx8cAWb
         tU7hOioJSUAwdDK0gI+PFHZ0Jqak6suyxC6ssNjXnAI0y/vlNJvVN7//arLF8EjxdgKO
         OG01J1b6s5EvcqGlM2tyOUGwj2mPzKWuP3A+dCLHj4Y36I+iyt+WPhE9MhjWdXbPhsuQ
         /nyhZhUCUxbzhLYSeeoPnowDHoo5BtVrlUj7hvt/LZZPV8zb0xFWoLcHzvquCOZWO6ap
         bHVGMswAxE8v7sOE5QaFIsEc5j6H9Mp2CJday6H4JhnSrgdoZjYQ+7G4ATzWdFLUaYi/
         OWSg==
X-Gm-Message-State: AFqh2kp84zKPp6xcxY5oXdsSzxl7s9Z2T/6Cb9TV5n8stnXx8SdqEEC3
        YMuerCRNyrw/vbYlYnnPlp6xpzLKB9Gc5+8vmsufBgY2SjgEwuquktronnIBwiq5F+ymlHECa09
        DoZaX8e3cnw8NKBUbF1Bg
X-Received: by 2002:a1f:19ca:0:b0:3d0:f9d5:637f with SMTP id 193-20020a1f19ca000000b003d0f9d5637fmr36606605vkz.0.1673452493525;
        Wed, 11 Jan 2023 07:54:53 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv3rKLhKurvHBKKCosFw3eUhnedMaKJ2pSrpHILeIPjnL+eANf9DtDLjtBN/QWKncm9PFjL6A==
X-Received: by 2002:a1f:19ca:0:b0:3d0:f9d5:637f with SMTP id 193-20020a1f19ca000000b003d0f9d5637fmr36606586vkz.0.1673452493237;
        Wed, 11 Jan 2023 07:54:53 -0800 (PST)
Received: from [172.31.1.6] ([70.109.130.165])
        by smtp.gmail.com with ESMTPSA id w19-20020a05620a445300b006fc3fa1f589sm9154154qkp.114.2023.01.11.07.54.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 07:54:52 -0800 (PST)
Message-ID: <158626f0-33ef-a458-26a5-2ab792b00b0c@redhat.com>
Date:   Wed, 11 Jan 2023 10:54:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] systemd: Don't degrade system state for nfs-clients when
 krb5 keytab present but not containing the nfs/<FQDN> principal.
Content-Language: en-US
To:     Joachim Falk <joachim.falk@gmx.de>, linux-nfs@vger.kernel.org
Cc:     Salvatore Bonaccorso <carnil@debian.org>
References: <20221207202841.525930-1-joachim.falk@gmx.de>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20221207202841.525930-1-joachim.falk@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 12/7/22 3:28 PM, Joachim Falk wrote:
> The nfs-client.target requires the auth-rpcgss-module.service, which in
> turn requires the rpc-svcgssd.service. However, the rpc.svcgssd daemon
> is unnecessary for an NFS client, even when using Kerberos security.
> Moreover, starting this daemon with its default configuration will fail
> when no nfs/<host>@REALM principal is in the Kerberos keytab. Thus,
> resulting in a degraded system state for NFS client configurations
> without nfs/<host>@REALM principal in the Kerberos keytab. However, this
> is a perfectly valid NFS client configuration as the nfs/<host>@REALM
> principal is not required for mounting NFS file systems. This is even
> the case when Kerberos security is enabled for the mount!
> 
> Installing the gssproxy package hides this problem as this disables the
> rpc-svcgssd.service.
> 
> Link: http://bugs.debian.org/985002
> Link: https://salsa.debian.org/kernel-team/nfs-utils/-/merge_requests/23
> 
> Signed-off-by: Joachim Falk <joachim.falk@gmx.de>
Committed... (tag: nfs-utils-2-6-3-rc6)

steved
> ---
>   systemd/auth-rpcgss-module.service | 2 +-
>   systemd/nfs-server.service         | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/systemd/auth-rpcgss-module.service b/systemd/auth-rpcgss-module.service
> index 25c9de80..4a69a7b7 100644
> --- a/systemd/auth-rpcgss-module.service
> +++ b/systemd/auth-rpcgss-module.service
> @@ -8,7 +8,7 @@
>   Description=Kernel Module supporting RPCSEC_GSS
>   DefaultDependencies=no
>   Before=gssproxy.service rpc-svcgssd.service rpc-gssd.service
> -Wants=gssproxy.service rpc-svcgssd.service rpc-gssd.service
> +Wants=gssproxy.service rpc-gssd.service
>   ConditionPathExists=/etc/krb5.keytab
>   ConditionVirtualization=!container
> 
> diff --git a/systemd/nfs-server.service b/systemd/nfs-server.service
> index b432f910..2cdd7868 100644
> --- a/systemd/nfs-server.service
> +++ b/systemd/nfs-server.service
> @@ -15,7 +15,7 @@ After=nfsdcld.service
>   Before=rpc-statd-notify.service
> 
>   # GSS services dependencies and ordering
> -Wants=auth-rpcgss-module.service
> +Wants=auth-rpcgss-module.service rpc-svcgssd.service
>   After=rpc-gssd.service gssproxy.service rpc-svcgssd.service
> 
>   [Service]
> --
> 2.35.1
> 

