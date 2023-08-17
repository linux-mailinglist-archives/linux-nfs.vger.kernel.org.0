Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86A077F9A7
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Aug 2023 16:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352277AbjHQOu2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Aug 2023 10:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352288AbjHQOuB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Aug 2023 10:50:01 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4922D7D
        for <linux-nfs@vger.kernel.org>; Thu, 17 Aug 2023 07:49:57 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4ff882397ecso4550076e87.3
        for <linux-nfs@vger.kernel.org>; Thu, 17 Aug 2023 07:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1692283795; x=1692888595;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qPKIf1c5VLgWM12jpFOQJTrws/cH5kcxIi4RhufSrew=;
        b=Y9EiYYZC9ZflNxWOTITi3phhdzzPYQr7TcoA1GKuD9yPPc4Cs5k95d/RvZ3D12nE5m
         kiHRJyZe4X0IGMfVEr+AgT9a2+78oWQf3Z6tEtcIakoNWnpgCEO3LvrY9onZmwaxb/y1
         NAjw25jgRbjpzOc03ucL/B8u6O8BvdHK0462I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692283795; x=1692888595;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qPKIf1c5VLgWM12jpFOQJTrws/cH5kcxIi4RhufSrew=;
        b=GE+6XoXpqtju8ryQO/rOCeyXWWbbLqzDHGVtqygXViV3/JcPeUoRAvz8YyXWYt2M1I
         5I8T7107ICupTES+kTGhF6ly370ghxY07TsMWuP1HYWezZuU6oi4O1PCRVNUvCUwY6Lo
         oRbkZNiUh8tK3IZXeR6Rc8CVdNEbt3QcSrA4HaqqlwYG61fnO727aKv6PTtL2C5dr6aq
         ZXoDAixFkOoISCwbDsf9lYrUjZDyqzYwUQbRcf1U6///e0sY5JLlY1bvjgeDjCwgRZO4
         0rYTHE08zFuo+OggDJr3UcVKv4lmIdpyVoHb/gR0CpIH2PLnaS9Jxs1Mj+UjI1pvVZ8i
         EBtA==
X-Gm-Message-State: AOJu0YyAcQdYEcsD4vu2Tf1YkwvMK0KM+0+YzkVEicmImQU3zC5AC7lm
        Qy/n9oBKf67hlv6S06qTW/8FRq1zLMxMlk+stxsmYubS
X-Google-Smtp-Source: AGHT+IFzjLzDEkQt7zIwFkaw/cJjnyKKft87jBE+1yY3x66E+IiWEFCVfzfZCKw0dTW9EVQ/lUDiNw==
X-Received: by 2002:a05:6512:39d4:b0:4f9:5396:ed1b with SMTP id k20-20020a05651239d400b004f95396ed1bmr4854206lfu.28.1692283795415;
        Thu, 17 Aug 2023 07:49:55 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id x27-20020ac2489b000000b004fe7011072fsm3426926lfc.58.2023.08.17.07.49.54
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 07:49:54 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2bbac8ec902so4029311fa.1
        for <linux-nfs@vger.kernel.org>; Thu, 17 Aug 2023 07:49:54 -0700 (PDT)
X-Received: by 2002:a05:651c:22c:b0:2b7:2ea:33c3 with SMTP id
 z12-20020a05651c022c00b002b702ea33c3mr4781874ljn.22.1692283794124; Thu, 17
 Aug 2023 07:49:54 -0700 (PDT)
MIME-Version: 1.0
References: <499058D2-E924-464F-BBFE-C15EE6028787@oracle.com>
In-Reply-To: <499058D2-E924-464F-BBFE-C15EE6028787@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Aug 2023 16:49:37 +0200
X-Gmail-Original-Message-ID: <CAHk-=whnm7RyZfy2s4BOdkMz=dMrPJRnH79KVH8rtC1vrV9G1w@mail.gmail.com>
Message-ID: <CAHk-=whnm7RyZfy2s4BOdkMz=dMrPJRnH79KVH8rtC1vrV9G1w@mail.gmail.com>
Subject: Re: [GIT PULL] one more nfsd fix for 6.5-rc
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 17 Aug 2023 at 16:11, Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.5-4

I've pulled this, but...

> Jeff Layton (1):
>       sunrpc: set the bv_offset of first bvec in svc_tcp_sendmsg

.. what an odd place to set bv_offset that is.

I'm sure it's right, but it really smells odd to set that initial
offset not when the bvec is created, but long afterwards, just before
it is used.

Is there some reason why 'bv_offset' isn't initialized when the bvec is created?

             Linus
