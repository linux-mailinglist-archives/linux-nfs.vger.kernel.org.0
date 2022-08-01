Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C25586F72
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Aug 2022 19:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiHARUm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Aug 2022 13:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiHARUi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Aug 2022 13:20:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1917960FC
        for <linux-nfs@vger.kernel.org>; Mon,  1 Aug 2022 10:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659374436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FKQxN7TtOsGr+d/F9mr9oy0WfMxN4tnk/xv9lOAv1xQ=;
        b=DgaXMgE2apY429FjZSeJ9/z1FCWMgjxDxlaM3koph/wO38MjRR2h0FG4RMFyqURHgrzSVY
        aKjSFutGGINrIfYgNchy4k1XTKXPL1yniac1g/dFrbdUam3iNvJwBZLeNrCICf8aS5tAIO
        AGjNy/MkkFHyGaaNmmCC39GzJRXtXhk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-OAgzLMSaPLOzicVcGzVeJw-1; Mon, 01 Aug 2022 13:20:30 -0400
X-MC-Unique: OAgzLMSaPLOzicVcGzVeJw-1
Received: by mail-qv1-f70.google.com with SMTP id er2-20020a056214190200b00474479acbcfso6868108qvb.23
        for <linux-nfs@vger.kernel.org>; Mon, 01 Aug 2022 10:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=FKQxN7TtOsGr+d/F9mr9oy0WfMxN4tnk/xv9lOAv1xQ=;
        b=ui84S0onAmvGeUZoBi/Oy9oWAveiIQsDLc+C4vIJqrWaguI5k97luZWvtI3L7XaTgO
         MWzTh56ZuP2xTb+o5Dx7luB5DdB3GDyQEwmbq6SkwF12vHyYoaAXtl2K5u3ezF+/eXq3
         HIW7TOJaEWKdVY5QnpqyIDHl6l5L1+Z0G+MHPVagNfb6rv9fNzBXnfqG4ye0r+p+fQno
         bF1jyFpYTVcbzHIIGhyg/k3Codvv8jML/0WH56bGmBo4UnO9/5GJeKo/MeYk+B9n/wud
         lQyxxKgTBopf04cP9tDJOm/8gWKR12N0KRkT58+iO2cp9nhAEQeMfQWZol123jkOsf3G
         +yuQ==
X-Gm-Message-State: ACgBeo3tZgpCAqQdsDfVJz87DqPbj2igwmTtzH6ekjSjBh4tFIYsot/A
        VipqWTMkAtfTVyuhiMPjvqeYmM4mgeCkJpCL5kAqdWYe6y2KwuP6/vcKpes6VP6Li5aooOuogw9
        eZzD6obYffNBV/jx9Sq7mZfP9Z/O+TEWhWfEUHSZZx8pMJ6dryocBzg+RW9rMtkzsPCQrvA==
X-Received: by 2002:a0c:8ec5:0:b0:473:f142:118b with SMTP id y5-20020a0c8ec5000000b00473f142118bmr14995576qvb.97.1659374429164;
        Mon, 01 Aug 2022 10:20:29 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6a77rKVZX+rDlhiKw5U5heMgh6A6gwpPcAUlacRJZihCTGGhstVooLje/juiXfodjTN8Z9Aw==
X-Received: by 2002:a0c:8ec5:0:b0:473:f142:118b with SMTP id y5-20020a0c8ec5000000b00473f142118bmr14995553qvb.97.1659374428693;
        Mon, 01 Aug 2022 10:20:28 -0700 (PDT)
Received: from [172.31.1.6] ([70.109.189.21])
        by smtp.gmail.com with ESMTPSA id e4-20020ac84904000000b0031ee01443b4sm7385361qtq.74.2022.08.01.10.20.27
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 10:20:28 -0700 (PDT)
Message-ID: <ad9ed180-7812-d077-c337-bc50e493b91a@redhat.com>
Date:   Mon, 1 Aug 2022 13:20:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] rpc-statd.service: Stop rpcbind and rpc.stat in an exit
 race
Content-Language: en-US
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20220727172441.6524-1-steved@redhat.com>
In-Reply-To: <20220727172441.6524-1-steved@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 7/27/22 1:24 PM, Steve Dickson wrote:
> Subject:
> [PATCH] rpc-statd.service: Stop rpcbind and rpc.stat in an exit race
> From:
> Steve Dickson <steved@redhat.com>
> Date:
> 7/27/22, 1:24 PM
> 
> To:
> Linux NFS Mailing list <linux-nfs@vger.kernel.org>
> 
> 
> From: Benjamin Coddington<bcodding@redhat.com>
> 
> When `systemctl stop rpcbind.socket` is run, the dependency means
> that systemd first sends SIGTERM to rpcbind, then sigterm to rpc.statd.
> 
> On SIGTERM, rpcbind tears down /var/run/rpcbind.sock.  However,
> rpc-statd on SIGTERM attempts to unregister from rpcbind
> 
> systemd needs to wait for rpc.statd to exit before sending
> SIGTERM to rpcbind
> 
> Fixes:https://bugzilla.redhat.com/show_bug.cgi?id=2100395
> Signed-off-by: Steve Dickson<steved@redhat.com>
Committed...

steved.
> ---
>   systemd/rpc-statd.service | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/systemd/rpc-statd.service b/systemd/rpc-statd.service
> index 095629f2..392750da 100644
> --- a/systemd/rpc-statd.service
> +++ b/systemd/rpc-statd.service
> @@ -5,7 +5,7 @@ Conflicts=umount.target
>   Requires=nss-lookup.target rpcbind.socket
>   Wants=network-online.target
>   Wants=rpc-statd-notify.service
> -After=network-online.target nss-lookup.target rpcbind.socket
> +After=network-online.target nss-lookup.target rpcbind.service
>   
>   PartOf=nfs-utils.service
>   IgnoreOnIsolate=yes
> -- 2.34.1
> 

