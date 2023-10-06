Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D049A7BBED5
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Oct 2023 20:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbjJFSmV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Oct 2023 14:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbjJFSmU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Oct 2023 14:42:20 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65C1B6
        for <linux-nfs@vger.kernel.org>; Fri,  6 Oct 2023 11:42:18 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-690bc3f82a7so2185020b3a.0
        for <linux-nfs@vger.kernel.org>; Fri, 06 Oct 2023 11:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696617738; x=1697222538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUg2EZ7t6QbVRPnDWD48q594BNWRx78W4j0XN10BHAI=;
        b=COFnebuGpXUEXOKvaz8l/Ib116z2d85QKzH+mJ2/+DsnaJWs7uMzjM9WoxvkuQcFpX
         Km5yxrmJ9Ez0JXnsjDG1o+z0x6Xhg+mMM5/CTgDD9AUNo+ypaynoxR1c4qSFYhZBin3H
         t0KM4nXcazDf6t7bBZ6fT5Hw54aCIbSqvKKqrbgTRUwT9phk49UhevLoT2PvoytOEeZp
         FvjU77/q8/vRB2/mJo7VcJDTcKWSKuujZ5ydayTAliSvt0lIIT4sqv1R39lPxaOdvHl5
         TG4bP6CVFJs+JGO10IhtXZmuVob/pPEpJs9pYNZuXAAYCIKW2Pmvx75hzQib3LJx7QYB
         g2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696617738; x=1697222538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UUg2EZ7t6QbVRPnDWD48q594BNWRx78W4j0XN10BHAI=;
        b=S+XrD8lUZXB7Qvz6Ffkm3qNPeyQMQwHXV5XETJN2ikVy4PL60NFiMKcmimf8s+pC+e
         9muNXMGwx4eeN07sWLSbTWQLCUsAHIr72+JyRpn6sfmX7Vvl5s3yM9sRqjTLr1yd/AUg
         cIDoKMRfCdO9JIa/CZ4DjlQnYIrNc1D1FEcfoAEEoqAikpdhGpP3FUzGwWUbWNLyP703
         FPdYfyqJmDnJ6B4S2vrdrOu5I+1KgFRJ2RmyRhfsEBTjclPFBBfOH0PRzf5llsRpyMUr
         bcO3WXEnXIYNLItxEpUfVZYHxB20bRaq3UkKJ7HhkLHd1LTPt4imtrk2mdqD1EnAHsrB
         1yLw==
X-Gm-Message-State: AOJu0YyPibBRCSRXQ5lbvTM9eGwgqrPAg0Fj3rRX35Vk7+q33tZma/WX
        P1z8uxcqq3j1Eh/Lzz2yWJeYuIZVAhN2jtpVf2VQMw==
X-Google-Smtp-Source: AGHT+IHUgHZyUTaGNx4dt+tc7IETfj4Jd3vKuta+Ow98vKSTFqxL8VKDeSZBqnX6bo8pJV9HXU1eh1GpPub4W8AU5JA=
X-Received: by 2002:aa7:88ce:0:b0:690:b8b1:7b9e with SMTP id
 k14-20020aa788ce000000b00690b8b17b9emr8463628pff.0.1696617738312; Fri, 06 Oct
 2023 11:42:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231004175217.404851126@linuxfoundation.org> <CA+G9fYsqbZhSQnEi-qSc7n+4d7nPap8HWcdbZGWLfo3mTH-L7A@mail.gmail.com>
In-Reply-To: <CA+G9fYsqbZhSQnEi-qSc7n+4d7nPap8HWcdbZGWLfo3mTH-L7A@mail.gmail.com>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Fri, 6 Oct 2023 12:42:04 -0600
Message-ID: <CAEUSe78O-Ho=22nTeioT4eqPRoDNfcWCpc=5O=B59eaMvOkzpg@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/259] 6.1.56-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-nfs@vger.kernel.org, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Olga Kornievskaia <kolga@netapp.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        LTP List <ltp@lists.linux.it>, Petr Vorel <pvorel@suse.cz>,
        Richard Palethorpe <rpalethorpe@suse.com>,
        Eryu Guan <eguan@redhat.com>, chrubis <chrubis@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello!

On Thu, 5 Oct 2023 at 10:40, Naresh Kamboju <naresh.kamboju@linaro.org> wro=
te:
> On Wed, 4 Oct 2023 at 23:41, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.1.56 release.
> > There are 259 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patc=
h-6.1.56-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git linux-6.1.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
> Results from Linaro=E2=80=99s test farm.
> Regressions on arm64 bcm2711-rpi-4-b device running LTP dio tests on
> NFS mounted rootfs.
> and LTP hugetlb hugemmap11 test case failed on x86 and arm64 bcm2711-rpi-=
4-b.
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> LTP hugetlb tests failed log
>   tst_hugepage.c:83: TINFO: 1 hugepage(s) reserved
>   tst_test.c:1558: TINFO: Timeout per run is 0h 05m 00s
>   hugemmap11.c:47: TFAIL: Memory mismatch after Direct-IO write
>
> LTP dio tests failed log
>   compare_file: char mismatch: infile offset 4096: 0x01 .   outfile
> offset 4096: 0x00 .
>   diotest01    1  TFAIL  :  diotest1.c:158: file compare failed for
> infile and outfile

Bisection led to "NFS: Fix O_DIRECT locking issues" (upstream commit
7c6339322ce0c6128acbe36aacc1eeb986dd7bf1). Reverting that patch and
"NFS: Fix error handling for O_DIRECT write scheduling" (upstream
commit 954998b60caa8f2a3bf3abe490de6f08d283687a) (not a clean revert
this one) made ltp-dio pass again.

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
