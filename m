Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5667882A1
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Aug 2023 10:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243922AbjHYItL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Aug 2023 04:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244047AbjHYIs6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Aug 2023 04:48:58 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BE11FFE
        for <linux-nfs@vger.kernel.org>; Fri, 25 Aug 2023 01:48:53 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-7a257fabae5so243827241.2
        for <linux-nfs@vger.kernel.org>; Fri, 25 Aug 2023 01:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692953332; x=1693558132;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sbZ3YR5SOTzvg9ICyWHf0Y3N1R2PQGKPLxJHSDkU0rM=;
        b=GYyfYLoayqEhg+1OxKxqtm2fRmYulcaLX4TTxSgt21+qkzsk1exT9j6tQjBpc6866n
         XEyJawRoUgLyEKmHa12McvnPjjYUb7Cd4nGCM8MsADBgoDSOwF/dulMelfLTUyrPluLO
         paCyyivUdXtYjN3IHnW74ErmR3kRj0s4vWJ+M0aA52GjyjOc2dLGmlJBCNXYd1VMkxDe
         1U7bfmMswXlUEBtQBDtUetBffAei96AJwh1jlNs5b2UMj4/O0ieJDqcipj5SV3IlDAPC
         JfHLPwIquqLbAzZDQJw+KPxHYgn+EXchOPo35A/dehuZvaif5wvZmrqEr87FFkkOXyeg
         h0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692953332; x=1693558132;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sbZ3YR5SOTzvg9ICyWHf0Y3N1R2PQGKPLxJHSDkU0rM=;
        b=lB2XeN4XYJWSqoQ6Ls34GJ18H13VQMze/LDJetFTV+us9fRx+GCJmxpsIf5D3sGqVu
         JfiWjrHwAadl8WbEyUEAvNbD7vzE9GhpimaaWldwNIM55Ik7zwO9lZi+h4bh0/8PWq0s
         iUYO+UoIPh45FidjYH31hyqY4sz801BdqHp+4ZYkyLl62LpHbh04Z6Hn0AwQuJrtsw19
         oZvp3z19U9p1Kd2yyST6q0D7OrWmEQCyqs3/YhmH/ENoo5nw8PFaCOP8iPd9ajaGbA08
         d0KjmWnROtP2AdBJ/xxcijK3qXMQU+PHKGrN1kAwfOyQhIhrJpnHL534ad0osPageVWg
         r/BQ==
X-Gm-Message-State: AOJu0YxYRIlsWSG0CAskXO6KbS++G7gDzXemuAG8Q61W3C2TWy3RM0TG
        zi3chIZcVm3bdOS++v+NeKlzPdduWSSny0d71icFbQ==
X-Google-Smtp-Source: AGHT+IHv9ZXZDpJ4MtbLFtoZRPbeXnm7kBLGoVbXuXoEwFv6MYdMhI1trUVN0f9Wn9gfMN6Tfn8L5YsvCtebNf///wI=
X-Received: by 2002:a67:f8cf:0:b0:44e:906d:58d with SMTP id
 c15-20020a67f8cf000000b0044e906d058dmr5548304vsp.13.1692953332138; Fri, 25
 Aug 2023 01:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230824141447.155846739@linuxfoundation.org> <CA+G9fYsPPpduLzJ4+GZe_18jgYw56=w5bQ2W1jnyWa-8krmOSw@mail.gmail.com>
 <2023082512-amusement-luncheon-8d8d@gregkh>
In-Reply-To: <2023082512-amusement-luncheon-8d8d@gregkh>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 25 Aug 2023 14:18:40 +0530
Message-ID: <CA+G9fYvVGxm0xOYp4LHepRJqccwmK7Zeg--2AhVk5T+T28Kk6A@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/15] 6.1.48-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Sherry Yang <sherry.yang@oracle.com>,
        LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 25 Aug 2023 at 13:57, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Aug 25, 2023 at 12:35:46PM +0530, Naresh Kamboju wrote:
> > + linux-nfs and more
> >
> > On Thu, 24 Aug 2023 at 19:45, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This is the start of the stable review cycle for the 6.1.48 release.
> > > There are 15 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Sat, 26 Aug 2023 14:14:28 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.48-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> >
> > Following test regression found on stable-rc 6.1.
> > Rpi4 is using NFS mount rootfs and running LTP syscalls testing.
> > chown02 tests creating testfile2 on NFS mounted and validating
> > the functionality and found that it was a failure.
> >
> > This is already been reported by others on lore and fix patch merged
> > into stable-rc linux-6.4.y [1] and [2].
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Odd, it's not a regression in this -rc cycle, so it was missed in the
> previous ones somehow?
>
> > Test log:
> > --------
> > chown02.c:46: TPASS: chown(testfile1, 0, 0) passed
> > chown02.c:46: TPASS: chown(testfile2, 0, 0) passed
> > chown02.c:58: TFAIL: testfile2: wrong mode permissions 0100700, expected 0102700
> >
> > fchown02.c:57: TPASS: fchown(3, 0, 0) passed
> > fchown02.c:57: TPASS: fchown(4, 0, 0) passed
> > fchown02.c:67: TFAIL: testfile2: wrong mode permissions 0100700,
> > expected 0102700
> >
> >
> > ## Build
> > * kernel: 6.1.48-rc1
> > * git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
> > * git branch: linux-6.1.y
> > * git commit: c079d0dd788ad4fe887ee6349fe89d23d72f7696
> > * git describe: v6.1.47-16-gc079d0dd788a
> > * test details:
> > https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.47-16-gc079d0dd788a
> >
> > ## Test Regressions (compared to v6.1.46)
> > * bcm2711-rpi-4-b, ltp-syscalls
> >   - chown02
> >   - fchown02
> >
> > * bcm2711-rpi-4-b-64k_page_size, ltp-syscalls
> >   - chown02
> >   - fchown02
> >
> > * bcm2711-rpi-4-b-clang, ltp-syscalls
> >   - chown02
> >   - fchown02
> >
> >
> >
> >
> > Do we need the following patch into stable-rc linux-6.1.y ?
> >
> > I see from mailing thread discussion, says that
> >
> > the above commit is backported to LTS kernels -- 5.10.y,5.15.y and 6.1.y.
>
> What "above commit"?

Sorry, s/above/below/
I copied that from another email thread as it is.

>
> And what commit should be backported?


  nfsd: use vfs setgid helper
    commit 2d8ae8c417db284f598dffb178cc01e7db0f1821 upstream.

Please refer this link,
 - https://lore.kernel.org/linux-nfs/20230502-agenda-regeln-04d2573bd0fd@brauner/


>
> confused,
>
> greg k-h
