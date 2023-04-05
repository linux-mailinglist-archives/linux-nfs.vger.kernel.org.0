Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3F06D83E9
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Apr 2023 18:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjDEQlC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Apr 2023 12:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjDEQlA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Apr 2023 12:41:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9FBA8
        for <linux-nfs@vger.kernel.org>; Wed,  5 Apr 2023 09:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680712817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gze+/zmDvL9jua4b7kzXJmGlwe0Way1JzAm4SbIpDiw=;
        b=aC81YXaVXMeZSRGyxhVDCnCk3iO4U/pd58iEFQX/eknv1+H7D+4GzHDb6tVNv8hFFC37z1
        wbseO6mUIfzq5XwyPGaHFkjem32haeYoN4MET76XemLLnz8rK1dzMM1EjZWjmEUf60+ToF
        eGJkfxnlHInLLHCSPjXTCsUWW9LoNEc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-IO6GggPSNC21TPy40BZvww-1; Wed, 05 Apr 2023 12:40:16 -0400
X-MC-Unique: IO6GggPSNC21TPy40BZvww-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-5e11d438c1aso594166d6.1
        for <linux-nfs@vger.kernel.org>; Wed, 05 Apr 2023 09:40:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680712816; x=1683304816;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gze+/zmDvL9jua4b7kzXJmGlwe0Way1JzAm4SbIpDiw=;
        b=J+rsCq7UzrzxnjWtlmmJnsIGDT3ZdQ8MzxO56r8JwK6eE4ts//9kIqgTyA2QJnLSzH
         Iu5PaOgZfkuwoxfzHNZ+jSf+Msf80zDZeGHp8qzQyJsQ21VWnTM+YCS2nef4OPM8URZO
         wx71UiCO4XaIhYKpOnX7vNUWC0fG/R+Vygo1aNAhLjpqO8nvc+IzG/LqFtHCIwoShNce
         BVtU3qFzdEva2YeMe1iffeTHr/RxFEvmCgodOD2QkhCnoNu8OJ628XhBC5tKM7hgCC2O
         rdVx96j5dDapjyb/5pad0jpL9LCArqGBfoS+TLcL1+AGatD4sDmtvbnWhKfXxc4tv1ED
         fpAg==
X-Gm-Message-State: AAQBX9cgCyT7RmIt4wIlFZm1QO5ord/+6+4tWgfm8LVNRNFB53RBDy+m
        JeCNp/SiMkDT0D7M6yUWRqvmXgjkhOdqwkUcwW59f4AWo3jDrIg16JddghKu7hp+BBNEfggnqMC
        V4ejat36KnKiXoYGX2YYd
X-Received: by 2002:a05:6214:301b:b0:56e:f7dd:47ad with SMTP id ke27-20020a056214301b00b0056ef7dd47admr4465470qvb.5.1680712815743;
        Wed, 05 Apr 2023 09:40:15 -0700 (PDT)
X-Google-Smtp-Source: AKy350adKIH0kcr8/KUDiCVePvJuTLVpxHg4L/jcNCGj3ryCKvBi7FXZQVxzJ0AzChSBprOvRPUfNg==
X-Received: by 2002:a05:6214:301b:b0:56e:f7dd:47ad with SMTP id ke27-20020a056214301b00b0056ef7dd47admr4465434qvb.5.1680712815332;
        Wed, 05 Apr 2023 09:40:15 -0700 (PDT)
Received: from [172.31.1.6] ([70.109.174.217])
        by smtp.gmail.com with ESMTPSA id 203-20020a3707d4000000b00742a23cada8sm4516818qkh.131.2023.04.05.09.40.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 09:40:14 -0700 (PDT)
Message-ID: <1c59beaf-63b6-ee39-b339-339a0c7e72b9@redhat.com>
Date:   Wed, 5 Apr 2023 12:40:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 0/4] nfs-utils changes for RPC-with-TLS
Content-Language: en-US
To:     Chuck Lever <cel@kernel.org>
Cc:     linux-nfs@vger.kernel.org, rick.macklem@gmail.com,
        kernel-tls-handshake@lists.linux.dev
References: <168009806320.2522.10415374334827613451.stgit@manet.1015granger.net>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <168009806320.2522.10415374334827613451.stgit@manet.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey Chuck,

On 3/29/23 10:08 AM, Chuck Lever wrote:
> Hi Steve-
> 
> This is client- and server-side nfs-utils support for RPC-with-TLS.
> The client side support at this point is only a man page update
> since the kernel handles mount option processing itself.
> 
> The server implementation can support both the opportunistic use of
> transport layer security (it will be used if the client cares to),
> and the required use of transport layer security (the server
> requires the client to use it to access a particular export).
> 
> Without any other user space componentry, this implementation is
> able to handle clients that request the use of RPC-with-TLS. To
> support security policies that restrict access to exports based on
> the client's use of TLS, modifications to exportfs and mountd are
> needed. These are contained in this post, and can also be found
> here:
> 
> git://git.linux-nfs.org/projects/cel/nfs-utils.git
> 
> The kernel patches, along with the handshake upcall, are carried in
> the topic-rpc-with-tls-upcall branch available from:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

Just wondering if these patch should wait until the kernel
patches reach mainline (aka rawhide)?

steved.

> 
> Soon I hope to compose a new man page in Section 7 that will provide
> an overview and quick set-up guidance for NFS's use of RPC-with-TLS.
> 
> 
> Changes since v1:
> - Addressed Jeff's review comments
> - Updated nfs.man as well
> 
> ---
> 
> Chuck Lever (4):
>        libexports: Fix whitespace damage in support/nfs/exports.c
>        exports: Add an xprtsec= export option
>        exports(5): Describe the xprtsec= export option
>        nfs(5): Document the new "xprtsec=" mount option
> 
> 
>   support/export/cache.c       |  15 ++++++
>   support/include/nfs/export.h |  14 +++++
>   support/include/nfslib.h     |  14 +++++
>   support/nfs/exports.c        | 100 ++++++++++++++++++++++++++++++++---
>   utils/exportfs/exportfs.c    |   1 +
>   utils/exportfs/exports.man   |  51 +++++++++++++++++-
>   utils/mount/nfs.man          |  34 +++++++++++-
>   7 files changed, 219 insertions(+), 10 deletions(-)
> 
> --
> Chuck Lever
> 

