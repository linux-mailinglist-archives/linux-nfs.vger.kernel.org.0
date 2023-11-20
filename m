Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4600B7F0ABF
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Nov 2023 03:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjKTC5S (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Nov 2023 21:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjKTC5R (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Nov 2023 21:57:17 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DD812D
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 18:57:14 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c6eac9c053so11532161fa.1
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 18:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1700449033; x=1701053833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kEwo5TnWwj4z7rW/hk01zG7pXRzlHOHfm0+nkZUAB+Y=;
        b=sDOoepdaX9BeHnjRBpGfVMdyWVwvTwIBXjTSSryBzckRTut+IS5iPi7nhfPptsg7kX
         ObucCVrCvcsjQfemN5/Ons8ooHlK1TxywfDYHyyJN+cXRrklAxq8gPXegh36nrO9PYf+
         RBdt6vYtQLrhzO2UF8kimD7/bfGBxSDj2YYWfvvGVpdoee4HzeXRJRM3kBh1aV8PwfeQ
         yKhhLR8pNtu8d57K/pcedmgDIMTv06rPMDGdxUHhCkhYbuH4bgnpNSscOGlqCcvJAEUt
         LFlclvfAbJJYuUOL+BwrrkkVRczopsNuv3CyrjMCNbQYSlrTb00961Lsk5M2ony+u91a
         B3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700449033; x=1701053833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kEwo5TnWwj4z7rW/hk01zG7pXRzlHOHfm0+nkZUAB+Y=;
        b=bpq8FzK09UNZXoNITbv27E82hgptu53vLy5z3VoU2NdEc6s3n9Vvi7gQXiJksIOd1y
         gtDfieTXoguCPsMsO19rEvXwG/PTwMffkWmVaky5X+mgqgm8ZngyFeF575RlT9+johdh
         LudIcXKJMWDpxoNdtOKBZU7I7cGK3YLmRMKFhhT6l2KHYd12eriKZoOUaMaXEdTc7q6s
         ISSfFt3qO2cRHKkQ1d4Qq7ov4ofX3FX3+s7BJvCsFOfaNRfEmxEryi3F8gdmBKluY48F
         HxWfAl8kzBtqR4s3E7kqIvMgAwcMCXV+K55wtPWJu2/hUpSWHofs6zR0yMBNEnM9kytW
         Q35Q==
X-Gm-Message-State: AOJu0YyiN8setP4E0VhzAKR9VTrVVmaU5lyihQw7JNml6hdvrgnkjLMs
        m5lYvUwjcEOe+OAXDU5EgIR/2+i2FQGhWYpaKOKnhvhP
X-Google-Smtp-Source: AGHT+IGMctzMU6HzIqsywvzQPAbKRRmjXHMv6z1QIpueSGRxIllkWnc/kTwOm6rvc3F+4BK+YjonZl8nZn/SZQjhJYs=
X-Received: by 2002:a2e:b809:0:b0:2c8:38b2:2c33 with SMTP id
 u9-20020a2eb809000000b002c838b22c33mr3086501ljo.3.1700449032436; Sun, 19 Nov
 2023 18:57:12 -0800 (PST)
MIME-Version: 1.0
References: <CALXu0Uc7zHasg2damr4nhRZZF7xBbFc0ghdjop87+5vHa8bBHg@mail.gmail.com>
In-Reply-To: <CALXu0Uc7zHasg2damr4nhRZZF7xBbFc0ghdjop87+5vHa8bBHg@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Sun, 19 Nov 2023 16:57:00 -1000
Message-ID: <CAN-5tyFBZibge52iZtjnz5j6S2GrTXTWdzaDxLVQcr+G8HegvQ@mail.gmail.com>
Subject: Re: TCP_KEEPALIVE for Linux NFS client?
To:     Cedric Blancher <cedric.blancher@gmail.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Ced,

Why do you think it doesn't use it? Have you looked at a network trace
of an idle connection? I seem to recall seeing keep-alive being used.

On Fri, Nov 17, 2023 at 8:02=E2=80=AFPM Cedric Blancher
<cedric.blancher@gmail.com> wrote:
>
> Good morning!
>
> Why does the Linux NFS client not use TCP_KEEPALIVE for its TCP
> connections? What are the pro and cons of using that for NFS TCP
> connections?
>
> Ced
> --
> Cedric Blancher <cedric.blancher@gmail.com>
> [https://plus.google.com/u/0/+CedricBlancher/]
> Institute Pasteur
