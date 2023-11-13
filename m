Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85D77EA184
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Nov 2023 17:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjKMQw2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Nov 2023 11:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMQw1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Nov 2023 11:52:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6BFD73
        for <linux-nfs@vger.kernel.org>; Mon, 13 Nov 2023 08:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699894294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cC8xE2018pGwjHEOueDIDfpBBGchT0cO3lVMboAKV0o=;
        b=aDbAHS65YlKoRnFm6FWXVIrTq9gj+Y67giCh7VpZpYrUXDX8ajlsfPan3R0x2vsPmZMWi+
        LdoTnLhvGeTRFOu0JjyxaO6gnUnz6jz2KOr3fgjusR0R4ldtxuxlo2psHIPvyMlbG6ZTwG
        38Bc/4bcBb1SSjxvlMZIJWL6jA+7pPA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-J8oCIOoiMomuecf--CSTGA-1; Mon, 13 Nov 2023 11:51:32 -0500
X-MC-Unique: J8oCIOoiMomuecf--CSTGA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-66d7b75c854so5043016d6.1
        for <linux-nfs@vger.kernel.org>; Mon, 13 Nov 2023 08:51:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699894292; x=1700499092;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cC8xE2018pGwjHEOueDIDfpBBGchT0cO3lVMboAKV0o=;
        b=VtG7z9WfTj0JfNhIoubuHjnFZfi9QAF3EuMI7UvrJT4WzXDXFt3VLtk75RLzYyULgu
         RlUS729hE4Ex+UKdOMY2Y99xT2qNu9UrODNi9Q5a316yPyU0Wm5xlDzIAImk/iWagftz
         RIve+KA71EY8IFyBbN4pRDSR1mXunDtehOQBX8IxcOfNTGyPnzEKsdWrd/7w5c4A1i8k
         bGj1PylZLtK0o5q2sd/UwUxy+UgBGvb+Qh2WxUSQFZj+Rdz3/MoVswsaEXlIHfz1baQF
         AswHOgZf7iBfPPOagMWJnrMLHucZPlFdjTWFAh2PuvONOdL1cVCrpb3lNRQnOTeQvqvF
         qyCw==
X-Gm-Message-State: AOJu0Yx4bedAipaC8uF+jS2ugdNqwLdAYCXHJhZLt7aQ8Ls5Okn83Y3O
        tA3wMPQgLzCMVNDk5dad7m0FQAQolGjPEz6s1illfd7ImbAMk/Zsj0jAZL4GkPwpTfG7ugfAwhB
        xVu1Q4w8a8WhWQ1qF/aun
X-Received: by 2002:a05:6214:2f05:b0:671:9945:7a36 with SMTP id od5-20020a0562142f0500b0067199457a36mr8228609qvb.1.1699894292446;
        Mon, 13 Nov 2023 08:51:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEj2neZ9jOwWA2rmArlU2IOB/GuZ9uDdZg8pqcB+RTAJO293uobYHH7jkH6hEq2mbNGLYFpOA==
X-Received: by 2002:a05:6214:2f05:b0:671:9945:7a36 with SMTP id od5-20020a0562142f0500b0067199457a36mr8228599qvb.1.1699894292202;
        Mon, 13 Nov 2023 08:51:32 -0800 (PST)
Received: from [172.31.1.12] ([70.105.251.235])
        by smtp.gmail.com with ESMTPSA id u6-20020a0ced26000000b0065b229ecb8dsm2189993qvq.3.2023.11.13.08.51.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 08:51:31 -0800 (PST)
Message-ID: <1360d937-1e54-4841-a40e-07077b8a3506@redhat.com>
Date:   Mon, 13 Nov 2023 11:51:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Add getrandom() fallback, cleanup headers
Content-Language: en-US
To:     Petr Vorel <pvorel@suse.cz>, linux-nfs@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>
References: <20231025194701.456031-1-pvorel@suse.cz>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20231025194701.456031-1-pvorel@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 10/25/23 3:46 PM, Petr Vorel wrote:
> Hi,
> 
> motivation to add this is to allow to compile reexport on systems with
> older libc. (getrandom() wrapper is supported on glibc 2.25+ and  musl
> 1.1.20+, uclibc-ng does
> not yet support it).
> 
> getrandom() syscall is supported Linux 3.17+ (old enough to bother with
> a check).
> 
> I also wonder why getrandom() syscall does not called with GRND_NONBLOCK
> flag. Is it ok/needed to block?
> 
> Kind regards,
> Petr
> 
> Petr Vorel (3):
>    reexport/fsidd.c: Remove unused headers
>    support/reexport.c: Remove unused headers
>    support/backend_sqlite.c: Add getrandom() fallback
> 
>   Makefile.am                       |  1 +
>   aclocal/getrandom.m4              | 16 ++++++++++++++++
>   configure.ac                      |  3 +++
>   support/reexport/backend_sqlite.c | 18 +++++++++++++++++-
>   support/reexport/fsidd.c          | 10 ----------
>   support/reexport/reexport.c       |  7 -------
>   6 files changed, 37 insertions(+), 18 deletions(-)
>   create mode 100644 aclocal/getrandom.m4
> 
Committed... (tag: nfs-utils-2-6-4-rc6)

steved.

