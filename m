Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5C35533EA
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jun 2022 15:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351270AbiFUNn5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Jun 2022 09:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351858AbiFUNnu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Jun 2022 09:43:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9EE818348
        for <linux-nfs@vger.kernel.org>; Tue, 21 Jun 2022 06:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655819028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+IFXbdG+wR0rNZTi4GcUkSECLKFM2IYb+AQTxBSe4fk=;
        b=P9m4XvKPsMqZAKEGLG0ZzgMCYdPoGQ0L3PuROntzM1lsyY1oFCF7bCa4aiRKXGuv4Ocd6L
        uY8TAhhWcFfr6SejcPLJQ7DzDJaEI6mNcUBrQlSJ0/7vk7a3px5SugNcsxrYRNmlRIAbs4
        oUF5WtNhRkt4ZgyH+g0okHSfdi12E5c=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-62-X3cv0L3hMRO36dr7RtIFaw-1; Tue, 21 Jun 2022 09:43:47 -0400
X-MC-Unique: X3cv0L3hMRO36dr7RtIFaw-1
Received: by mail-qk1-f197.google.com with SMTP id k188-20020a37a1c5000000b006a6c4ce2623so16442634qke.6
        for <linux-nfs@vger.kernel.org>; Tue, 21 Jun 2022 06:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+IFXbdG+wR0rNZTi4GcUkSECLKFM2IYb+AQTxBSe4fk=;
        b=v4wOrrN0fyL5+USKI3VabefjZo2Bt8YS2a1/l5g/lYKpr+sotUHEpx4TyAfFyBo8Bo
         9Og6n49ewSQBo6hscMoy22jpd0D0gkb0ilJz7PpMM1e30gTxru7VRzKH+y6ZwDYkQo5u
         SMOTkj88miroEWXFoD+wsyvgEVWMpMRdZ6Mz07NtoJvK8CwilDkuh5t5xekbrBblShIA
         tm2Pemi2di+jvc+66cB4FdMFjuavV7uMj2+/XvkoajK8jJVbXdZVUAUeZeY49qrDKBnA
         74aKGE2/bJ7JIpbtkVTDHv7hUXmTOj3gH0DjBDVWqXzJ7JgAz0RVvV8uT6Tr8JnJqAKW
         FX0w==
X-Gm-Message-State: AJIora8S1zMvHIjCBRfMvLMpVXHa4HK0Ec3Ey7LVSoj/XfrJjKcCwbdP
        XqJXfrHzYffGOHqd2yvPZFA92AYnRzyanTGzwg3cQvjBDIaKDUpdojjtX5I7bcM5FPVOzYanf8m
        wA80HNhELD8FtbnZIH/I1
X-Received: by 2002:a05:620a:9c4:b0:6a6:9c07:c243 with SMTP id y4-20020a05620a09c400b006a69c07c243mr20307869qky.783.1655819027005;
        Tue, 21 Jun 2022 06:43:47 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uWzaMMO8yquZK4Jq+PP6oCscTY7k8nDJ3Z3p2iYoeiNbwUlfDB16WeV326i7G+cTTP/Rkuzg==
X-Received: by 2002:a05:620a:9c4:b0:6a6:9c07:c243 with SMTP id y4-20020a05620a09c400b006a69c07c243mr20307852qky.783.1655819026742;
        Tue, 21 Jun 2022 06:43:46 -0700 (PDT)
Received: from [172.31.1.6] ([70.109.186.229])
        by smtp.gmail.com with ESMTPSA id 74-20020a37044d000000b006a6539862f8sm13911578qke.40.2022.06.21.06.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 06:43:45 -0700 (PDT)
Message-ID: <b070ad50-08d7-a967-21f5-ecfbbd7105d9@redhat.com>
Date:   Tue, 21 Jun 2022 09:43:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/6] Allow nfs4-acl-tools to access 'dacl' and 'sacl'
Content-Language: en-US
To:     trondmy@kernel.org, "J.Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org
References: <20220514144436.4298-1-trondmy@kernel.org>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20220514144436.4298-1-trondmy@kernel.org>
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



On 5/14/22 10:44 AM, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> The following patch set matches the kernel patches to allow access to
> the NFSv4.1 'dacl' and 'sacl' attributes. The current patches are very
> basic, adding support for encoding/decoding the new attributes only when
> the user specifies the '--dacl' or '--sacl' flags on the command line.
> 
> Trond Myklebust (6):
>    libnfs4acl: Add helpers to set the dacl and sacl
>    libnfs4acl: Add support for the NFS4.1 ACE_INHERITED_ACE flag
>    The NFSv41 DACL and SACL prepend an extra field to the acl
>    nfs4_getacl: Add support for the --dacl and --sacl options
>    nfs4_setacl: Add support for the --dacl and --sacl options
>    Edit manpages to document the new --dacl, --sacl and inheritance
>      features
> 
>   include/libacl_nfs4.h             | 18 +++++++
>   include/nfs4.h                    |  6 +++
>   libnfs4acl/Makefile               |  2 +
>   libnfs4acl/acl_nfs4_copy_acl.c    |  2 +
>   libnfs4acl/acl_nfs4_xattr_load.c  | 14 +++++-
>   libnfs4acl/acl_nfs4_xattr_pack.c  | 22 ++++++--
>   libnfs4acl/nfs4_ace_from_string.c |  3 ++
>   libnfs4acl/nfs4_get_ace_flags.c   |  2 +
>   libnfs4acl/nfs4_getacl.c          | 84 +++++++++++++++++++++++++++++++
>   libnfs4acl/nfs4_new_acl.c         |  1 +
>   libnfs4acl/nfs4_setacl.c          | 49 ++++++++++++++++++
>   man/man1/nfs4_getfacl.1           | 14 ++++++
>   man/man1/nfs4_setfacl.1           |  8 +++
>   man/man5/nfs4_acl.5               | 10 ++++
>   nfs4_getfacl/nfs4_getfacl.c       | 73 ++++++++++++++++++++++++---
>   nfs4_setfacl/nfs4_setfacl.c       | 67 ++++++++++++++++++++++--
>   16 files changed, 359 insertions(+), 16 deletions(-)
>   create mode 100644 libnfs4acl/nfs4_getacl.c
>   create mode 100644 libnfs4acl/nfs4_setacl.c
> 
My apologies this took so long....

Committed (tag: nfs4-acl-tools-0.4.1-rc)

steved.

