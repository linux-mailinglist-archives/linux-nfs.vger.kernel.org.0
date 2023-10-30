Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3027DC341
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Oct 2023 00:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjJ3Xmy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Oct 2023 19:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjJ3Xmw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Oct 2023 19:42:52 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA1AC2
        for <linux-nfs@vger.kernel.org>; Mon, 30 Oct 2023 16:42:49 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9c603e2354fso1036077966b.1
        for <linux-nfs@vger.kernel.org>; Mon, 30 Oct 2023 16:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698709368; x=1699314168; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e5N724rwDHXZ7JYVD8hn/Em5XUesdSK4Pl1fcV5KWlA=;
        b=LdNZRe9kaCiZwpUBKZ/zv3T9Lxjoif6Rq6L4NTspFfhQ9wvWZswkWmXoAqwhQbMoZq
         wMjhwW7yUNuC0caCT2QKeVpWym963DJNsNzPoZLRn6Z9suonoV5Glr1YoH2Z3nPm28yH
         x9tbzNxZcjfpCzTV8AE/Vh8k0yBabXwPhCHdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698709368; x=1699314168;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e5N724rwDHXZ7JYVD8hn/Em5XUesdSK4Pl1fcV5KWlA=;
        b=bJcNdxdgdRO+tudzG9DqbMXbh/tfer/4u/BU+aDTQ0kzcZcdTgYNQY2bdQBHxgX7zk
         vHqqkVV11pi1vZ3T/G7cYD6r8jZCCdrWTGqz8x5hdfsEPfPEVHwRYjEUrf8Vcew+uZXw
         +dcZHX9JQtvr63/5kEnYOJRgzP3UYb/y4bjdUxsLEEYYq2ROkUx/AsZhbju9RRKwqWmz
         fqEedM4XJlJBZzV8Fzy1FRUNGwO+thVDTpGjx+2P1zUMU+qpXb3xIb0S23pFGw3SxWxG
         1tJG3aoh0TPKsB71MvqhflCS3uZJch4+7kjrmPfYoNVZrnyjwr4bMu91RAGdh/qss0WX
         bGTQ==
X-Gm-Message-State: AOJu0YxiI1B7gVseTHz8mqFL8vRSOB7Fu9BDeqZ7zkKkZi6v0Pfe01T9
        zYraAtbCRL0P0HhS0gPJ8vmtZexLCSNR115OmPaXsA==
X-Google-Smtp-Source: AGHT+IFMzPpStx0aW9L2ugt0REOek7kTw1kfcCYfV6W6b5QVMLL1ou+TgRUG/8VUVzzvGXkoHDD2Iw==
X-Received: by 2002:a17:906:af99:b0:9aa:206d:b052 with SMTP id mj25-20020a170906af9900b009aa206db052mr881930ejb.27.1698709368209;
        Mon, 30 Oct 2023 16:42:48 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id i21-20020a170906251500b0098921e1b064sm41742ejb.181.2023.10.30.16.42.47
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 16:42:47 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-9c603e2354fso1036075966b.1
        for <linux-nfs@vger.kernel.org>; Mon, 30 Oct 2023 16:42:47 -0700 (PDT)
X-Received: by 2002:a17:906:ef02:b0:9be:85c9:43f1 with SMTP id
 f2-20020a170906ef0200b009be85c943f1mr839873ejs.7.1698709367234; Mon, 30 Oct
 2023 16:42:47 -0700 (PDT)
MIME-Version: 1.0
References: <34E014FF-351E-4977-B694-060A5DADD35A@oracle.com>
 <CAHk-=wifhiJ-QbcwrH0RzPaKeZv93GKDQuBUth18ay=sLu5CVA@mail.gmail.com> <96800661-0F30-4F9E-89E4-C0B032EFDEB9@oracle.com>
In-Reply-To: <96800661-0F30-4F9E-89E4-C0B032EFDEB9@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Oct 2023 13:42:30 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgyD3=63P=xewgmzSxcMmfj9LPakdVBDWnzR1EwUUOctQ@mail.gmail.com>
Message-ID: <CAHk-=wgyD3=63P=xewgmzSxcMmfj9LPakdVBDWnzR1EwUUOctQ@mail.gmail.com>
Subject: Re: [GIT PULL] nfsd changes for v6.7 (early)
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 30 Oct 2023 at 13:21, Chuck Lever III <chuck.lever@oracle.com> wrote:
>
> Do you need a refreshed PR with the testing bit removed,
> or can you live with Neil or me sending a subsequent
> fix-up later in the merge window?

Oh, I've pulled it, I just haven't pushed out my recent merges yet.

I realize that my complaints are nit-picky and they don't hold up pull
requests. It's just that bad Kconfig questions are a pet peeve of
mine.

But being a pet peeve doesn't make it a showstopper..

          Linus
