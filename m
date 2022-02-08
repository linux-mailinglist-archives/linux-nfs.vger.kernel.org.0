Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369FA4AE074
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Feb 2022 19:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384686AbiBHSNo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Feb 2022 13:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234806AbiBHSNn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Feb 2022 13:13:43 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9680C061579;
        Tue,  8 Feb 2022 10:13:40 -0800 (PST)
Received: from [192.168.0.2] (ip5f5aebc2.dynamic.kabel-deutschland.de [95.90.235.194])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 01AE361E6478B;
        Tue,  8 Feb 2022 19:13:37 +0100 (CET)
Message-ID: <0235e04a-18aa-ccbf-f520-38a2d55e8b54@molgen.mpg.de>
Date:   Tue, 8 Feb 2022 19:13:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [Regression 5.17-rc2] Symlink on NFS mount to directory on other
 NFS mount not resolved on first access
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Cc:     Lyu Tao <tao.lyu@epfl.ch>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, it+linux-nfs@molgen.mpg.de,
        regressions@lists.linux.dev
References: <bd2075f0-2343-5bfa-83bf-0e916303727d@molgen.mpg.de>
In-Reply-To: <bd2075f0-2343-5bfa-83bf-0e916303727d@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Dear Linux folks,


Am 08.02.22 um 15:36 schrieb Paul Menzel:
> #regzbot introduced: ac795161c93699d600db16c1a8cc23a65a1eceaf


> Commit ac795161c936 (NFSv4: Handle case where the lookup of a directory 
> fails) [1], part of Linux since 5.17-rc2, introduced a regression, where 
> a symbolic link on an NFS mount to a directory on another NFS does not 
> resolve(?) the first time it is accessed:

I forgot to include, that we are using autofs/automount for these 
directories.

> ```
> $ ls -dl /src/mariux/beeroot/build-archives
> lrwxrwxrwx 1 root root 39 May  5  2021 /src/mariux/beeroot/build-archives -> /src/mariux_data/beeroot/build-archives
> $ df /src/mariux{,_data}
> Filesystem                                           1K-blocks Used   Available Use% Mounted on
> macheteinfach:/amd/macheteinfach/1/src/mariux      17575970816 2930189312 14645781504  17% /src/mariux
> macheteinfach:/amd/macheteinfach/1/src/mariux_data 17575970816 2930189312 14645781504  17% /src/mariux_data
> 
> $ sudo umount /src/mariux /src/mariux_data
> $ echo /src/mariux/beeroot/build-archives/*5.17*
> /src/mariux/beeroot/build-archives/*5.17*
> $ strace -e openat echo /src/mariux/beeroot/build-archives/*5.17*
> openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
> openat(AT_FDCWD, "/lib/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
> openat(AT_FDCWD, "/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) = 3
> /src/mariux/beeroot/build-archives/*5.17*
> +++ exited with 0 +++
> $ echo /src/mariux/beeroot/build-archives/*5.17*
> /src/mariux/beeroot/build-archives/linux-5.17_rc1-423.x86_64.beebuild.tar.bz2 
> /src/mariux/beeroot/build-archives/linux-5.17_rc2-424.x86_64.beebuild.tar.bz2 
> /src/mariux/beeroot/build-archives/linux-5.17_rc3-426.x86_64.beebuild.tar.bz2 
> /src/mariux/beeroot/build-archives/mariux64-caret_R-3.0.2-5.17_7-0.x86_64.beebuild.tar.bz2 
> 
> 
> Using a dot in the path works around the issue:
> 
> ```
> $ sudo umount /src/mariux /src/mariux_data
> $ strace -e openat echo /src/mariux/beeroot/build-archives/./*5.17*
> openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
> openat(AT_FDCWD, "/lib/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
> openat(AT_FDCWD, "/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) = 3
> /src/mariux/beeroot/build-archives/./linux-5.17_rc1-423.x86_64.beebuild.tar.bz2 
> /src/mariux/beeroot/build-archives/./linux-5.17_rc2-424.x86_64.beebuild.tar.bz2 
> /src/mariux/beeroot/build-archives/./linux-5.17_rc3-426.x86_64.beebuild.tar.bz2 
> /src/mariux/beeroot/build-archives/./mariux64-caret_R-3.0.2-5.17_7-0.x86_64.beebuild.tar.bz2 
> 
> +++ exited with 0 +++
> ```


Kind regards,

Paul


> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ac795161c93699d600db16c1a8cc23a65a1eceaf 
