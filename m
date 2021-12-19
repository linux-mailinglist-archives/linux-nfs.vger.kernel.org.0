Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A646A47A29F
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Dec 2021 23:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236786AbhLSWZd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Dec 2021 17:25:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33410 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236784AbhLSWZd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Dec 2021 17:25:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639952732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eGQYNuYECfH4p8FHPRkB7VqqoZYM7W52L0TJzQ3+9bA=;
        b=NI/1U3zKte07CKu8fs7dqumgaamennCgkPWgZzXcWnmGOaYgspkBOioNe/NAfvQj4sJo10
        YyH4KgRGKaX0y6zAuUdCSdhPnWIiVHLhHwCn6ylnwCxa/iGlpWT1ivnwIDZi1WeYMCNl0I
        yP5sZgoZHKZygU69ju6mQEBET3LcTbE=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-85-u34TYwUZM8yVoFHuFZMFUA-1; Sun, 19 Dec 2021 17:25:31 -0500
X-MC-Unique: u34TYwUZM8yVoFHuFZMFUA-1
Received: by mail-io1-f69.google.com with SMTP id g23-20020a6be617000000b005e245747fb4so6091157ioh.15
        for <linux-nfs@vger.kernel.org>; Sun, 19 Dec 2021 14:25:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eGQYNuYECfH4p8FHPRkB7VqqoZYM7W52L0TJzQ3+9bA=;
        b=ToFzMMzv4sUKpeMWJWaTlAQY21T8X7mA0vVVCX6+W0MuRL3WI9pgflil0V6PvS+pRM
         XMIZoXI0rCFldXzlKLk5nUP/MdrBpp3bXny2JVn+ZO2VBEaXM24ibOaZAIlXjp0r3ti7
         s6U4u579uPRk1gjrnWtIFHSDnBTDyCmbrdD1Z06+ihpag7FxDXvOn4TlFAoEYNu5nVSe
         vKnVJCK/zH3Bti1T0sS8TEtMjv3NXbKkunPNY9SkUgaaAdQwTiCeSBfZhabYaKm+FwWw
         enp45KHOIWvwSijNVvd9Enn6W4OqgKOqJe9aoAEb973+0eqW6bv+5TWZDB3yhbafeoT2
         Be5A==
X-Gm-Message-State: AOAM531ZHvv+LAsJ8syoaY2+wcC+ii5u5dB4Hp3yJVfjyISWxZEZt1s0
        7M6tI9jtznwS8UeJFNlo4fG7QjuTcnBoOcZIo6AtxNG46k0Oop5g6gz3anjtqFlVTKWYhdsp6yz
        uOWOptL+oPCmv1Ikpc1lQJtENnBFlSvxi/hUQ
X-Received: by 2002:a05:6638:13c5:: with SMTP id i5mr8346230jaj.88.1639952730684;
        Sun, 19 Dec 2021 14:25:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJysETfzp7QoPvwMkPXKrTlyFLHD/UDdKvokhlGhfGOU2G/9toXoHLZEolsbPk45RjdwHteTka4yyDf0A3SiJsg=
X-Received: by 2002:a05:6638:13c5:: with SMTP id i5mr8346223jaj.88.1639952730501;
 Sun, 19 Dec 2021 14:25:30 -0800 (PST)
MIME-Version: 1.0
References: <20211217215046.40316-1-trondmy@kernel.org> <20211217215046.40316-2-trondmy@kernel.org>
 <20211217215046.40316-3-trondmy@kernel.org> <20211217215046.40316-4-trondmy@kernel.org>
 <20211217215046.40316-5-trondmy@kernel.org> <20211217215046.40316-6-trondmy@kernel.org>
 <CAPL3RVFaWgdWQnWOe5B_6=1pNGSOZXp=SVFOBs24aucXphi6wQ@mail.gmail.com> <3A406AE7-B088-4618-9FA1-63BA6E939578@oracle.com>
In-Reply-To: <3A406AE7-B088-4618-9FA1-63BA6E939578@oracle.com>
From:   Bruce Fields <bfields@redhat.com>
Date:   Sun, 19 Dec 2021 17:25:19 -0500
Message-ID: <CAPL3RVEXSa4RaWoOfC3dkcYm4k0pt72Cq2NNaShHr+5rZQjykg@mail.gmail.com>
Subject: Re: [PATCH 5/9] nfsd: NFSv3 should allow zero length writes
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     "trondmy@kernel.org" <trondmy@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Dec 18, 2021 at 1:42 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
> But it seems to me WRT4 should already tickle any problems
> with nfsd_vfs_write(), shouldn't it?

I was just taking Trond's word that this is NFSv3-specific, but it's
not clear to me why from the code, and I know that WRT4 is passing.
Something's weird.  I'm travelling or I'd test it.

--b.

