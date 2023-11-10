Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F697E75C7
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Nov 2023 01:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbjKJAQm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Nov 2023 19:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234858AbjKJAQg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Nov 2023 19:16:36 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BCF6E92
        for <linux-nfs@vger.kernel.org>; Thu,  9 Nov 2023 16:06:06 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53e04b17132so2377404a12.0
        for <linux-nfs@vger.kernel.org>; Thu, 09 Nov 2023 16:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574765; x=1700179565; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UAdItF7ThE2Llx8nDycWwxl6uPZyLsg7vMsIE6/dq2k=;
        b=WSZFLyE0IAU0D8+4Ddj4VIJa7AE6aGn1h9pGALKdSJl13RJUL47Y+2ptYGRZdFMNRF
         09noeeY8Cb/pkpI3jEvMoZBoRvgcsWgGFYjhWh/Zfww6yGVmx1clp5nlNeeImnIE/dxt
         DVn8m2Kl08jzu+ltLIxkssdI+d7ppi4hDzuaVIxoGC0PFTxXROqpuztTqNw6ipnnBRrl
         TTVkGQmGBRryqHSDUp9tzpp15jspabVlpbXPWEM7FpHiiu2zIr8UjOVDjlbGUVv+SdSq
         IjtFq2ONgrCySY/qFwnr6sjiem58bq6XGPAVm0EjYTqq1mLMpZ3i8v8MvvaG+oeX2QLY
         60aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574765; x=1700179565;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UAdItF7ThE2Llx8nDycWwxl6uPZyLsg7vMsIE6/dq2k=;
        b=ShpKizHgyubf9G15qvn/3t8QNMCPe5TYQ2T4xNRQapAp5TUHqFSYZSlcCqS108Lm++
         jgl3P4jiuV0E/mTEEfXvUDhxpmLo8b6dKB80gdOLDRZBn2NNbmERaS+lACs3+3bIe1PC
         WUFOVPg++SwHcKwXxS05ZmDCF63Lzmb2og4cR3PHO/mCriKE/IIlbkcwkUzBwV9qTtiv
         eavBBlb5txn7EFPeBgHPi3YvkaiRJsyn7pIa5XhQAO2FsbVOV1FUqqzhnp6jGrkJEln4
         X/s+OlxrKzpaCAoDtZEFqUhFjePhS9+gFK32b8T7BB2sLoDUbl6g4bDyvroPdh+78Bps
         B5mg==
X-Gm-Message-State: AOJu0YwrWIY2VXj39PnWZW9bZcgob6c+I+VNM7Kox/IQMREeVygjiMg7
        PRG04jVepNXKcRwSShil80pTq8mizJKz8hUlX2cMnzuJ
X-Google-Smtp-Source: AGHT+IGV5LklRDWc/h9qdchIdnshyQDYCxMgoWl3KxwgDcdU7hfFHmZDNEHYWUflCA1avr1vReOStVjLUShyGpIyf3k=
X-Received: by 2002:a50:c31a:0:b0:540:1824:b8d0 with SMTP id
 a26-20020a50c31a000000b005401824b8d0mr5332893edb.3.1699574764586; Thu, 09 Nov
 2023 16:06:04 -0800 (PST)
MIME-Version: 1.0
References: <CALXu0UeGr80OzF7abqxwR5KFJFhpCuomy2_tdFESAKSiW70jfA@mail.gmail.com>
In-Reply-To: <CALXu0UeGr80OzF7abqxwR5KFJFhpCuomy2_tdFESAKSiW70jfA@mail.gmail.com>
From:   Cedric Blancher <cedric.blancher@gmail.com>
Date:   Fri, 10 Nov 2023 01:05:28 +0100
Message-ID: <CALXu0UcT4gG8xEVOvK1mshMDa_hKYu7rJK2biq8==ySOXdA3+w@mail.gmail.com>
Subject: BUG in exports(5), no example for refer= Re: Examples for refer= in /etc/exports?
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2 Nov 2023 at 10:51, Cedric Blancher <cedric.blancher@gmail.com> wrote:
>
> Good morning!
>
> Does anyone have examples of how to use the refer= option in /etc/exports?

Short answer:
To redirect an NFS mount from local machine /ref/baguette to
/export/home/baguette on host 134.49.22.111 add this to Linux
/etc/exports:

/ref *(no_root_squash,refer=/export/home@134.49.22.111)

This is basically an exports(5) manpage bug, which does not provide
ANY examples.

Plus, /ref must not be a dir controlled by the automounter, or a Linux
6.6 kernel will panic

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur
