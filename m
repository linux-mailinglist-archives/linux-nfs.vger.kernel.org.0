Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C29B78923D
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Aug 2023 01:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjHYXL6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Aug 2023 19:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjHYXL5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Aug 2023 19:11:57 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1AE2118
        for <linux-nfs@vger.kernel.org>; Fri, 25 Aug 2023 16:11:54 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-26f51625d96so853465a91.1
        for <linux-nfs@vger.kernel.org>; Fri, 25 Aug 2023 16:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693005114; x=1693609914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKbdTnaP/s1h+dHX9LHgk8lGsLM5JbGooSkMgQ6xNIE=;
        b=QYCN9l2u5Gpvi4njDbJSNhp3BJTVMbKFxIhc7OIG/2+s92DYNU9TWo4wg+LmWjpmWY
         RqQR1ko7NwjsHwEPfAUzB6U4fInmPv1SKMi26hTcek6845GINnmgM+bqF1zJKq/VwJMP
         r/BWIOM0mXvAdmA+YMioyJsPI1ApVJBHa33xcSsllS9Zj8FxckU7PoNXul0PwpQVAw6f
         91DlmlqPEy5y+QgoU76ZkPZki1e6+AMiuSvmdw7RH4FC2She6F0gwuxBTAI0jdMjSzCc
         u/H9ujOpCLFE3M/f3iFAXO8F8oiQ2y1U7vQmv7i6NFjCapj+Ta+9MyIuPpAagmJEkDy4
         uxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693005114; x=1693609914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kKbdTnaP/s1h+dHX9LHgk8lGsLM5JbGooSkMgQ6xNIE=;
        b=SJAOkssfqHhIew0JBj6v7UWujOGKNujoMWZNpAmBTNixx4P1NXVPK4ir9pVSPyZ3xt
         7WhryXGcvajrQ4Z4Caz7gn2BVqIh2h2qCxcTK4mAUEdIfFA3GLTPJ9lxezpgkfEB2/Ld
         6DvuOewypbvCYoLuqY0mB+nxNHudvbwyQIfP5tUqM4Px4q6VaiuoPlkQRT4xO5s4n0qS
         PtZ5S/XfWGKs3Del6trorOsJS0BsWSbLwM0podTksrCpuZF8gBzds8Zlrj/NZWyBGQvO
         qckXvjasnFpJOPQlA9FqIuHihSn/yeeeY/3vLpDXpjnuNsvu6pjFPW+kZ6m3bEnxFnaE
         DUqg==
X-Gm-Message-State: AOJu0YyxlXb0Gs10z9YYs9vjszVG+luuEcWwnIIC9YjPFZ6RuzDZY8xJ
        T8qQsbaTAGIPtH1q/PjnqU3GAPHZwMeAafXxgB+X/w==
X-Google-Smtp-Source: AGHT+IE5GlJjhe6XSI+bjx5Hf4kX7Cyp2m8+rAU5r5oCH1MFC8q6DL3qus3eQYhyC0cmUzUutFp1bUoS0y/q29BdMz4=
X-Received: by 2002:a17:90b:396:b0:26b:6095:bc3f with SMTP id
 ga22-20020a17090b039600b0026b6095bc3fmr16298424pjb.33.1693005113947; Fri, 25
 Aug 2023 16:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230825161603.371792-1-harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230825161603.371792-1-harshit.m.mogalapalli@oracle.com>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Fri, 25 Aug 2023 17:11:42 -0600
Message-ID: <CAEUSe7_L2UtPi3Lcr4owKC83FO2zhCYDzNaWn-PKgfn9USNPvg@mail.gmail.com>
Subject: Re: [PATCH 6.1.y 0/2] Address ltp nfs test failure.
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     brauner@kernel.org, chuck.lever@oracle.com, bfields@fieldses.org,
        stable@vger.kernel.org, linux-nfs@vger.kernel.org,
        gregkh@linuxfoundation.org, hch@lst.de, jlayton@kernel.org,
        vegard.nossum@oracle.com, naresh.kamboju@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello!

On Fri, 25 Aug 2023 at 10:17, Harshit Mogalapalli
<harshit.m.mogalapalli@oracle.com> wrote:
> These two are backports for 6.1.y. Conflict resolution in done in
> both patches.
> I have tested LTP-nfs fchown02 and chown02 on 6.1.y with below patches
> applied. The tests passed.

I have given this a go but did not see better results.

On 6.1.48-rc1, without any extra patches:
  https://lkft.validation.linaro.org/scheduler/job/6685964#L3814
  https://storage.tuxsuite.com/public/linaro/lkft/builds/2UR2OCpseRQ0lu76ph=
KZBw6l2xf/

On 6.1.48-rc1 plus this series of patches:
  https://lkft.validation.linaro.org/scheduler/job/6692637#L3832
  https://lkft.validation.linaro.org/scheduler/job/6692642#L3818
  https://storage.tuxsuite.com/public/linaro/daniel/builds/2UUHtMsTAQeuei3g=
GM32NWZx82w/

In both cases:
  chown02.c:46: TPASS: chown(testfile1, 0, 0) passed
  chown02.c:46: TPASS: chown(testfile2, 0, 0) passed
  chown02.c:58: TFAIL: testfile2: wrong mode permissions 0100700,
expected 0102700
[...]
  fchown02.c:57: TPASS: fchown(3, 0, 0) passed
  fchown02.c:57: TPASS: fchown(4, 0, 0) passed
  fchown02.c:67: TFAIL: testfile2: wrong mode permissions 0100700,
expected 0102700

The exact same thing happened with the 5.15 patch series.

I'll be glad to test more patches.

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org


> I would like to have a review as I am not familiar with this code.
>
> Thanks to Vegard for helping me with this.
>
> Thanks,
> Harshit
>
> Christian Brauner (2):
>   nfs: use vfs setgid helper
>   nfsd: use vfs setgid helper
>
>  fs/attr.c          | 1 +
>  fs/internal.h      | 2 --
>  fs/nfs/inode.c     | 4 +---
>  fs/nfsd/vfs.c      | 4 +++-
>  include/linux/fs.h | 2 ++
>  5 files changed, 7 insertions(+), 6 deletions(-)
>
> --
> 2.34.1
>
