Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED2978820A
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Aug 2023 10:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241276AbjHYI1M (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Aug 2023 04:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241520AbjHYI1E (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Aug 2023 04:27:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5764419A1;
        Fri, 25 Aug 2023 01:27:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB295619E4;
        Fri, 25 Aug 2023 08:27:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09DFC433C7;
        Fri, 25 Aug 2023 08:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692952021;
        bh=/0P/Vuu4CvmfjvkFoCAuWPAgUuDaHWfDtDf85MPvZxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q05XK44U5RagfHRVH0HdFvF60AQUL8F1lSh4qbFMj/4u21g+5OxK2QEgCC63YSqG3
         k7jQrPtv/h8eV9ROnJjknqx/dGefG+dblKD+BzZw3qBSYmJSnLtuMI0sko5lJqg3JL
         nUN210NrpBA3Xw/htCH1snORJ+3XyBpex2vJ0ejU=
Date:   Fri, 25 Aug 2023 10:10:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
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
Subject: Re: [PATCH 6.1 00/15] 6.1.48-rc1 review
Message-ID: <2023082512-amusement-luncheon-8d8d@gregkh>
References: <20230824141447.155846739@linuxfoundation.org>
 <CA+G9fYsPPpduLzJ4+GZe_18jgYw56=w5bQ2W1jnyWa-8krmOSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYsPPpduLzJ4+GZe_18jgYw56=w5bQ2W1jnyWa-8krmOSw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Aug 25, 2023 at 12:35:46PM +0530, Naresh Kamboju wrote:
> + linux-nfs and more
> 
> On Thu, 24 Aug 2023 at 19:45, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.1.48 release.
> > There are 15 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat, 26 Aug 2023 14:14:28 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.48-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> 
> Following test regression found on stable-rc 6.1.
> Rpi4 is using NFS mount rootfs and running LTP syscalls testing.
> chown02 tests creating testfile2 on NFS mounted and validating
> the functionality and found that it was a failure.
> 
> This is already been reported by others on lore and fix patch merged
> into stable-rc linux-6.4.y [1] and [2].
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Odd, it's not a regression in this -rc cycle, so it was missed in the
previous ones somehow?

> Test log:
> --------
> chown02.c:46: TPASS: chown(testfile1, 0, 0) passed
> chown02.c:46: TPASS: chown(testfile2, 0, 0) passed
> chown02.c:58: TFAIL: testfile2: wrong mode permissions 0100700, expected 0102700
> 
> fchown02.c:57: TPASS: fchown(3, 0, 0) passed
> fchown02.c:57: TPASS: fchown(4, 0, 0) passed
> fchown02.c:67: TFAIL: testfile2: wrong mode permissions 0100700,
> expected 0102700
> 
> 
> ## Build
> * kernel: 6.1.48-rc1
> * git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
> * git branch: linux-6.1.y
> * git commit: c079d0dd788ad4fe887ee6349fe89d23d72f7696
> * git describe: v6.1.47-16-gc079d0dd788a
> * test details:
> https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.47-16-gc079d0dd788a
> 
> ## Test Regressions (compared to v6.1.46)
> * bcm2711-rpi-4-b, ltp-syscalls
>   - chown02
>   - fchown02
> 
> * bcm2711-rpi-4-b-64k_page_size, ltp-syscalls
>   - chown02
>   - fchown02
> 
> * bcm2711-rpi-4-b-clang, ltp-syscalls
>   - chown02
>   - fchown02
> 
> 
> 
> 
> Do we need the following patch into stable-rc linux-6.1.y ?
> 
> I see from mailing thread discussion, says that
> 
> the above commit is backported to LTS kernels -- 5.10.y,5.15.y and 6.1.y.

What "above commit"?

And what commit should be backported?

confused,

greg k-h
