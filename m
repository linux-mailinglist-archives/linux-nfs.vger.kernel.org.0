Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D750E701B3B
	for <lists+linux-nfs@lfdr.de>; Sun, 14 May 2023 04:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjENCpO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 13 May 2023 22:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjENCpN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 13 May 2023 22:45:13 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268572130;
        Sat, 13 May 2023 19:45:11 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3075e802738so10442829f8f.1;
        Sat, 13 May 2023 19:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684032309; x=1686624309;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xiDC0hqmGuu+AWr5snDs4ZPvEx68CUxrNjBnyoH2q44=;
        b=pn7FoYNXIRIn+E6c/q/BzNQKgEbwP2xC+wezOpYznB/K8GjzF1FT3VugccVZPnMxkE
         LpvZxGt9UG5VcSZ0/5UjpDaE3Cth+cDa5alaVQlJKSe6ZVsyQuOo15rF4Y/IhbUzOPZQ
         Iv1l1fX7r3Z1AEszt5bDlQCLXetZ97earWrayxpN4z5+3KtZkTkFFzo0bgEOgTt2wfXp
         oGQ9Rvm+qzPdPasQrDlfiD2emQr49Sg7nKj/MwQQyJdQiVYVL3VVPXmdy3p2A2GjYW9x
         AJYqyfgDkarQtztCU7uFmaHIm5XBm5kPjq0gH7/03EjWgIK/c57HIURWolYs0I4BPXt+
         3nyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684032309; x=1686624309;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xiDC0hqmGuu+AWr5snDs4ZPvEx68CUxrNjBnyoH2q44=;
        b=ILwCD3kfNycihauJI6hmGG3KBCaaOfCSVzv4Hny2Qvagm2p6pW2+ZZS7YHSJbmhirO
         FTBYwMMcsSwZM4nKj0nnPtlvCVwzxpcRzvwkFw+ufcZ8VKpPzHNe7SiKifFEvRmvkPSk
         IFZWOrEGd6IzBiJfpDy8nhY4KftV7rPkoD7ZWs1e0JCpfP4wMQXj3CA1PFItyMFMRtn7
         N7gwEAD9McoJRyBGKID/qmBYxQiGPm25tk+zTvgIZSRRXZuuTaLAkuN7h2jUsZ/K6P9t
         2yosZsseGQg9/RH0WsqmeObQZYg1Yscij8ppAtHJuI6mamRpKXsuxrgL5Vl6MRJBcN6K
         Xokw==
X-Gm-Message-State: AC+VfDzp8AdN/86FTGWzrxe5nlKj26IfjvfsdKWjlt/Dxc4qfeXVObPE
        YIROEokPOejOlK0Du+jjUv0PRM360iIrrm9iw8sihnpK
X-Google-Smtp-Source: ACHHUZ4f1IZlUKwLOpGbFa5n+MOs72ZdOHLfYT31ZZxfcrNQW9xC8W6go1Y2ySbHoKKjxKANAmpYnoyLbnXhF/tcrog=
X-Received: by 2002:a5d:42c9:0:b0:306:2d45:a8e0 with SMTP id
 t9-20020a5d42c9000000b003062d45a8e0mr21121582wrr.15.1684032309206; Sat, 13
 May 2023 19:45:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230512145356.396567-1-azeemshaikh38@gmail.com>
 <109A2974-3AE0-48C6-8EE3-FADE95E8EF30@oracle.com> <5E054593-8995-46FF-824E-55B18BF53BE2@oracle.com>
 <CADmuW3UQ-wqobay34PY+myyk1Pr7s-cf7b-U7TUCnarEf+jsxg@mail.gmail.com> <A1414FC8-9CE0-4B8C-ABB1-2365E2F62B10@oracle.com>
In-Reply-To: <A1414FC8-9CE0-4B8C-ABB1-2365E2F62B10@oracle.com>
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
Date:   Sat, 13 May 2023 22:44:58 -0400
Message-ID: <CADmuW3UkNrSqwQPgZVqRc46hZPK9J6jGYNfU4iS1bQKmEib8bQ@mail.gmail.com>
Subject: Re: [PATCH v2] NFSD: Remove all occurences of strlcpy
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> > No, I plan to land this patch before attempting to fix __assign_str itself.
> > Let me know if the below description looks good to you and I'll send
> > over a v3 patch:
> >
> > [PATCH v3] NFSD: Remove open coding of string copy
> >
> > Instead of open coding a __dynamic_array(), use the __string() and
> > __assign_str()
> > helper macros that exist for this kind of use case.
> >
> > Part of an effort to remove deprecated strlcpy() [1] completely from the
> > kernel[2].
> >
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> > [2] https://github.com/KSPP/linux/issues/89
> >
> > Fixes: 3c92fba557c6 ("NFSD: Enhance the nfsd_cb_setup tracepoint")
> > Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
>
> This looks good to me. So you'd like me to take this through
> the nfsd tree, possibly for 6.4-rc ?
>

This is my first week contributing to the Linux kernel so I might be
miscommunicating :)
By "land this patch", I meant to get this patch into to the nfsd tree.
I'll leave it up to you when you push it through to the mainline tree.
Although, it would be great to get this through to 6.4-rc if that's at
all possible.
