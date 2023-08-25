Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16F6788097
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Aug 2023 09:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbjHYHHA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Aug 2023 03:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241794AbjHYHGd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Aug 2023 03:06:33 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3F52699
        for <linux-nfs@vger.kernel.org>; Fri, 25 Aug 2023 00:06:11 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-44d5c49af07so295451137.2
        for <linux-nfs@vger.kernel.org>; Fri, 25 Aug 2023 00:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692947157; x=1693551957;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zAyx91j0d1SiPs3sA0vgKNpQ3W+EG6C0ragX4AchNBE=;
        b=uN2rEaDOxg/pvsgm9icIiIRITysW4eLMBpwqTl6ADtfVuemglwESF1ebt1WQUqa2eH
         MaMHvubqXFo7kxYZkeKKL9BrOO4FMCgGlWmq1m7t9NpbLsiI6b0JuzPNyIJBCpca6cL5
         4OLCC6NxZ42tEJYGwDn8Lwzb3xUJsi/IChumX8xNSHvgSPJ2rgYENoMTjDxoV5/KtTZV
         s2lb9srRDXWRSs+2PE1gvDDqBj9liwPo4ZmjrZXnZxRomZg1R8yPiEQKRyJQbrN6I+MN
         V0aQR68lzM4EAqwcIQnAyuNR1BIkbZKMKILMmoKgUZL8YXLydFBGa0Yv1jLbaBK5mBUa
         iRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692947157; x=1693551957;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zAyx91j0d1SiPs3sA0vgKNpQ3W+EG6C0ragX4AchNBE=;
        b=F/OiQdXMUj9kkxzWBKIS3vsZcKHkbr4oXuCUss7JcnvcFOVA6DDRRaadolaFxDl7Bx
         zWCBAGkTRKTHC+NfTyRqoM7gPqHR+Azq9oh3XVrWPP5taQgehp28imxF+khfZ8dJd9qw
         l0+u+ERNzqEyeDv+h2vv8Yj9l8NDgxogeOkyqCwymQIMihzELOCISb3rMcTHk0sJbW3E
         ZP5Qr9tId3BJvinoC3HhRsuGGVySABAPOpJ4oDmVVx7NGHL0mw4wqa5MnVSuH2r70fwe
         GbsauGOIu87RC2dUW7fFOLY0IJUylYqFdrxzYKv1FkxcD7Y9UV/fc/jnROUBCmXTJU+c
         1MAQ==
X-Gm-Message-State: AOJu0YwWjkQo5davsYUMiHI1nP8mg0zjvwLVdI0UqcCus7sN0ACRQyQt
        faxNVHeLIjaTVcS0jcHWzcmQa6HpT75OKVJeZIwG9w==
X-Google-Smtp-Source: AGHT+IF2hKbfhy15wte1809kF7Hyk6ONBucrn4iHiZSvthzk5hzVmg8s0lNZHK6urLSSNHhlSLdD3/SCAArIH6tequQ=
X-Received: by 2002:a67:fe10:0:b0:449:6e24:be74 with SMTP id
 l16-20020a67fe10000000b004496e24be74mr15745478vsr.0.1692947157287; Fri, 25
 Aug 2023 00:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230824141447.155846739@linuxfoundation.org>
In-Reply-To: <20230824141447.155846739@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 25 Aug 2023 12:35:46 +0530
Message-ID: <CA+G9fYsPPpduLzJ4+GZe_18jgYw56=w5bQ2W1jnyWa-8krmOSw@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/15] 6.1.48-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, Sherry Yang <sherry.yang@oracle.com>,
        LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

+ linux-nfs and more

On Thu, 24 Aug 2023 at 19:45, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.48 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 26 Aug 2023 14:14:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.48-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Following test regression found on stable-rc 6.1.
Rpi4 is using NFS mount rootfs and running LTP syscalls testing.
chown02 tests creating testfile2 on NFS mounted and validating
the functionality and found that it was a failure.

This is already been reported by others on lore and fix patch merged
into stable-rc linux-6.4.y [1] and [2].

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Test log:
--------
chown02.c:46: TPASS: chown(testfile1, 0, 0) passed
chown02.c:46: TPASS: chown(testfile2, 0, 0) passed
chown02.c:58: TFAIL: testfile2: wrong mode permissions 0100700, expected 0102700

fchown02.c:57: TPASS: fchown(3, 0, 0) passed
fchown02.c:57: TPASS: fchown(4, 0, 0) passed
fchown02.c:67: TFAIL: testfile2: wrong mode permissions 0100700,
expected 0102700


## Build
* kernel: 6.1.48-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: c079d0dd788ad4fe887ee6349fe89d23d72f7696
* git describe: v6.1.47-16-gc079d0dd788a
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.47-16-gc079d0dd788a

## Test Regressions (compared to v6.1.46)
* bcm2711-rpi-4-b, ltp-syscalls
  - chown02
  - fchown02

* bcm2711-rpi-4-b-64k_page_size, ltp-syscalls
  - chown02
  - fchown02

* bcm2711-rpi-4-b-clang, ltp-syscalls
  - chown02
  - fchown02




Do we need the following patch into stable-rc linux-6.1.y ?

I see from mailing thread discussion, says that

the above commit is backported to LTS kernels -- 5.10.y,5.15.y and 6.1.y.


----

nfsd: use vfs setgid helper
commit 2d8ae8c417db284f598dffb178cc01e7db0f1821 upstream.

We've aligned setgid behavior over multiple kernel releases. The details
can be found in commit cf619f891971 ("Merge tag 'fs.ovl.setgid.v6.2' of
git://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping") and
commit 426b4ca2d6a5 ("Merge tag 'fs.setgid.v6.0' of
git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux").
Consistent setgid stripping behavior is now encapsulated in the
setattr_should_drop_sgid() helper which is used by all filesystems that
strip setgid bits outside of vfs proper. Usually ATTR_KILL_SGID is
raised in e.g., chown_common() and is subject to the
setattr_should_drop_sgid() check to determine whether the setgid bit can
be retained. Since nfsd is raising ATTR_KILL_SGID unconditionally it
will cause notify_change() to strip it even if the caller had the
necessary privileges to retain it. Ensure that nfsd only raises
ATR_KILL_SGID if the caller lacks the necessary privileges to retain the
setgid bit.

Without this patch the setgid stripping tests in LTP will fail:

> As you can see, the problem is S_ISGID (0002000) was dropped on a
> non-group-executable file while chown was invoked by super-user, while

[...]

> fchown02.c:66: TFAIL: testfile2: wrong mode permissions 0100700, expected 0102700

[...]

> chown02.c:57: TFAIL: testfile2: wrong mode permissions 0100700, expected 0102700

With this patch all tests pass.

Reported-by: Sherry Yang <sherry.yang@oracle.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


[1] https://lore.kernel.org/linux-nfs/20230502-agenda-regeln-04d2573bd0fd@brauner/
[2] https://lore.kernel.org/all/202210091600.dbe52cbf-yujie.liu@intel.com/
--
Linaro LKFT
https://lkft.linaro.org
