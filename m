Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6961E7BA7FF
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Oct 2023 19:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjJER2f (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Oct 2023 13:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjJER2G (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Oct 2023 13:28:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2E82D4C;
        Thu,  5 Oct 2023 10:24:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 804C81F853;
        Thu,  5 Oct 2023 17:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696526696;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IKAizuYlvOnj5WV3IhJ1fnzYcOePdzxWANDIs7Jk9tY=;
        b=Q2pLlPKoo6aJzUGmti+EuZrU7zOr8OOCF0LustR22L7yfzTxOagYwMmmDCm7c4XRME1fiR
        E3XKH4iqtVNr5lk+6yMapTqiFuILwyx1WGPCvABCWqzNHvLhIYcGeOUZyeKaFgUBt1x4V2
        EqbHMYe2reGJWuI0NRZjycjYFOHnA0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696526696;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IKAizuYlvOnj5WV3IhJ1fnzYcOePdzxWANDIs7Jk9tY=;
        b=zmllGG7/BnQA2rKu+FgfHNjkfZ6a8ZAmlA3H+vA5GABqmxB/1hq2DsySVJGDn31B+m9nT+
        dxtDnEEMYBbWXxBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D8A2313438;
        Thu,  5 Oct 2023 17:24:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id P7mBMWbxHmUzEQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 05 Oct 2023 17:24:54 +0000
Date:   Thu, 5 Oct 2023 19:24:48 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        LTP List <ltp@lists.linux.it>,
        Richard Palethorpe <rpalethorpe@suse.com>,
        Eryu Guan <eguan@redhat.com>, chrubis <chrubis@suse.cz>
Subject: Re: [PATCH 6.1 000/259] 6.1.56-rc1 review
Message-ID: <20231005172448.GA161140@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20231004175217.404851126@linuxfoundation.org>
 <CA+G9fYsqbZhSQnEi-qSc7n+4d7nPap8HWcdbZGWLfo3mTH-L7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYsqbZhSQnEi-qSc7n+4d7nPap8HWcdbZGWLfo3mTH-L7A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Naresh,

> On Wed, 4 Oct 2023 at 23:41, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:

> > This is the start of the stable review cycle for the 6.1.56 release.
> > There are 259 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.

> > Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
> > Anything received after that time might be too late.

> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.56-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > and the diffstat can be found below.

> > thanks,

> > greg k-h

> Results from Linaro’s test farm.
> Regressions on arm64 bcm2711-rpi-4-b device running LTP dio tests on
Could you please note in your reports also LTP version?
FYI the best LTP release is always the latest release or git master branch.

Kind regards,
Petr

> NFS mounted rootfs.
> and LTP hugetlb hugemmap11 test case failed on x86 and arm64 bcm2711-rpi-4-b.

> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

> LTP hugetlb tests failed log
>   tst_hugepage.c:83: TINFO: 1 hugepage(s) reserved
>   tst_test.c:1558: TINFO: Timeout per run is 0h 05m 00s
>   hugemmap11.c:47: TFAIL: Memory mismatch after Direct-IO write

> LTP dio tests failed log
>   compare_file: char mismatch: infile offset 4096: 0x01 .   outfile
> offset 4096: 0x00 .
>   diotest01    1  TFAIL  :  diotest1.c:158: file compare failed for
> infile and outfile

> ## Build
> * kernel: 6.1.56-rc1
> * git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
> * git branch: linux-6.1.y
> * git commit: 0353a7bfd2b60c5e42c8651eb3fa4cc48159db5f
> * git describe: v6.1.55-260-g0353a7bfd2b6
> * test details:
> https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.55-260-g0353a7bfd2b6

> ## Test Regressions (compared to v6.1.55)
> * x86_64-clang, ltp-hugetlb
> * bcm2711-rpi-4-b, ltp-hugetlb
> * bcm2711-rpi-4-b-clang, ltp-hugetlb
> * bcm2711-rpi-4-b-64k_page_size, ltp-hugetlb
>   - hugemmap11

> Test log:
> --------
>   tst_hugepage.c:83: TINFO: 1 hugepage(s) reserved
>   tst_test.c:1558: TINFO: Timeout per run is 0h 05m 00s
>   hugemmap11.c:47: TFAIL: Memory mismatch after Direct-IO write

> Links:
>   - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.55-260-g0353a7bfd2b6/testrun/20259639/suite/ltp-hugetlb/test/hugemmap11/log
>   - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.55-260-g0353a7bfd2b6/testrun/20260457/suite/ltp-hugetlb/test/hugemmap11/history/

> * bcm2711-rpi-4-b, ltp-dio
> * bcm2711-rpi-4-b-clang, ltp-dio
> * bcm2711-rpi-4-b-64k_page_size, ltp-dio
>   - dio01
>   - dio02
>   - dio03
>   - dio05
>   - dio06
>   - dio07
>   - dio08
>   - dio09
>   - dio11

> Test log:
> --------
>   compare_file: char mismatch: infile offset 4096: 0x01 .   outfile
> offset 4096: 0x00 .
>   diotest01    1  TFAIL  :  diotest1.c:158: file compare failed for
> infile and outfile
>   bufcmp: offset 0: Expected: 0x1, got 0x0
>   bufcmp: offset 0: Expected: 0x1, got 0x0
>   diotest02    1  TPASS  :  Read with Direct IO, Write without
>   diotest02    2  TFAIL  :  diotest2.c:119: read/write comparision failed
>   diotest02    3  TFAIL  :  diotest2.c:210: Write with Direct IO, Read without
>   diotest02    4  TFAIL  :  diotest2.c:119: read/write comparision failed
>   diotest02    5  TFAIL  :  diotest2.c:231: Read, Write with Direct IO
>   diotest02    0  TINFO  :  2/3 testblocks failed
>   bufcmp: offset 0: Expected: 0x1, got 0x0
>   diotest03    1  TPASS  :  Read with Direct IO, Write without
>   diotest03    2  TFAIL  :  diotest3.c:136: comparsion failed; child=0 offset=0
>   diotest03    3  TFAIL  :  diotest3.c:189: Write Direct-child 0 failed
>   bufcmp: offset 0: Expected: 0x1, got 0x0
>   diotest03    1  TPASS  :  Read with Direct IO, Write without
>   diotest03    2  TFAIL  :  diotest3.c:306: Write with Direct IO, Read without
>   diotest03    3  TFAIL  :  diotest3.c:136: comparsion failed; child=0 offset=0
>   diotest03    4  TFAIL  :  diotest3.c:210: RDWR Direct-child 0 failed
>   diotest03    1  TPASS  :  Read with Direct IO, Write without
>   diotest03    2  TFAIL  :  diotest3.c:306: Write with Direct IO, Read without
>   diotest03    3  TFAIL  :  diotest3.c:323: Read, Write with Direct IO
>   ...
>   diotest05    1  TPASS  :  Read with Direct IO, Write without
>   diotest05    2  TFAIL  :  diotest5.c:141: readv/writev comparision failed
>   diotest05    3  TFAIL  :  diotest5.c:250: Write with Direct IO, Read without
>   diotest05    4  TFAIL  :  diotest5.c:141: readv/writev comparision failed
>   diotest05    5  TFAIL  :  diotest5.c:271: Read, Write with Direct IO
>   diotest05    0  TINFO  :  2/3 testblocks failed

> Links:
>   - https://lkft.validation.linaro.org/scheduler/job/6842177#L1666
>   - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.55-260-g0353a7bfd2b6/testrun/20260389/suite/ltp-dio/test/dio01/history/

> ## Metric Regressions (compared to v6.1.55)

> ## Test Fixes (compared to v6.1.55)

> ## Metric Fixes (compared to v6.1.55)

> ## Test result summary
> total: 121166, pass: 102582, fail: 2234, skip: 16177, xfail: 173

> ## Build Summary
> * arc: 4 total, 4 passed, 0 failed
> * arm: 140 total, 140 passed, 0 failed
> * arm64: 49 total, 49 passed, 0 failed
> * i386: 33 total, 33 passed, 0 failed
> * mips: 24 total, 24 passed, 0 failed
> * parisc: 3 total, 3 passed, 0 failed
> * powerpc: 34 total, 34 passed, 0 failed
> * riscv: 12 total, 12 passed, 0 failed
> * s390: 12 total, 12 passed, 0 failed
> * sh: 11 total, 11 passed, 0 failed
> * sparc: 6 total, 6 passed, 0 failed
> * x86_64: 40 total, 40 passed, 0 failed

> ## Test suites summary
> * boot
> * kselftest-android
> * kselftest-arm64
> * kselftest-breakpoints
> * kselftest-capabilities
> * kselftest-cgroup
> * kselftest-clone3
> * kselftest-core
> * kselftest-cpu-hotplug
> * kselftest-cpufreq
> * kselftest-drivers-dma-buf
> * kselftest-efivarfs
> * kselftest-exec
> * kselftest-filesystems
> * kselftest-filesystems-binderfs
> * kselftest-filesystems-epoll
> * kselftest-firmware
> * kselftest-fpu
> * kselftest-ftrace
> * kselftest-futex
> * kselftest-gpio
> * kselftest-intel_pstate
> * kselftest-ipc
> * kselftest-ir
> * kselftest-kcmp
> * kselftest-kexec
> * kselftest-kvm
> * kselftest-lib
> * kselftest-membarrier
> * kselftest-memfd
> * kselftest-memory-hotplug
> * kselftest-mincore
> * kselftest-mount
> * kselftest-mqueue
> * kselftest-net
> * kselftest-net-forwarding
> * kselftest-net-mptcp
> * kselftest-netfilter
> * kselftest-nsfs
> * kselftest-openat2
> * kselftest-pid_namespace
> * kselftest-pidfd
> * kselftest-proc
> * kselftest-pstore
> * kselftest-ptrace
> * kselftest-rseq
> * kselftest-rtc
> * kselftest-seccomp
> * kselftest-sigaltstack
> * kselftest-size
> * kselftest-splice
> * kselftest-static_keys
> * kselftest-sync
> * kselftest-sysctl
> * kselftest-tc-testing
> * kselftest-timens
> * kselftest-tmpfs
> * kselftest-tpm2
> * kselftest-user
> * kselftest-user_events
> * kselftest-vDSO
> * kselftest-vm
> * kselftest-watchdog
> * kselftest-x86
> * kselftest-zram
> * kunit
> * kvm-unit-tests
> * libgpiod
> * log-parser-boot
> * log-parser-test
> * ltp-cap_bounds
> * ltp-commands
> * ltp-containers
> * ltp-controllers
> * ltp-cpuhotplug
> * ltp-crypto
> * ltp-cve
> * ltp-dio
> * ltp-fcntl-locktests
> * ltp-filecaps
> * ltp-fs
> * ltp-fs_bind
> * ltp-fs_perms_simple
> * ltp-fsx
> * ltp-hugetlb
> * ltp-io
> * ltp-ipc
> * ltp-math
> * ltp-mm
> * ltp-nptl
> * ltp-pty
> * ltp-sched
> * ltp-securebits
> * ltp-smoke
> * ltp-syscalls
> * ltp-tracing
> * network-basic-tests
> * perf
> * rcutorture
> * v4l2-compliance
