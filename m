Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0867BC645
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Oct 2023 10:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbjJGI6a (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 7 Oct 2023 04:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjJGI63 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 7 Oct 2023 04:58:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EB5B9;
        Sat,  7 Oct 2023 01:58:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3BDC433C7;
        Sat,  7 Oct 2023 08:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696669107;
        bh=63/dX8Mo5xru8ooy9lCm1E4eme6V3fkD4TYeT7/GxT8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l1i/NIDAMmZft2wxUCk+uo6l9YM0hOIgb4Ksq3nEmXl7j8swBvb1Th5UI1cO+oYFi
         Mgc3JIhYrOjNZIIjl/JaMbWo7w5X+M7j/N9LdJ3OWL3toXnmtH2hC/t3/sP57Rit/R
         g7QNjJ1hxzMZrMDUM8TmaY7ZVatkHKPDyQsOCEAk=
Date:   Sat, 7 Oct 2023 10:58:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
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
Subject: Re: [PATCH 6.1 000/259] 6.1.56-rc1 review
Message-ID: <2023100755-livestock-barcode-fe41@gregkh>
References: <20231004175217.404851126@linuxfoundation.org>
 <CA+G9fYsqbZhSQnEi-qSc7n+4d7nPap8HWcdbZGWLfo3mTH-L7A@mail.gmail.com>
 <CAEUSe78O-Ho=22nTeioT4eqPRoDNfcWCpc=5O=B59eaMvOkzpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEUSe78O-Ho=22nTeioT4eqPRoDNfcWCpc=5O=B59eaMvOkzpg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Oct 06, 2023 at 12:42:04PM -0600, Daniel Díaz wrote:
> Hello!
> 
> On Thu, 5 Oct 2023 at 10:40, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > On Wed, 4 Oct 2023 at 23:41, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This is the start of the stable review cycle for the 6.1.56 release.
> > > There are 259 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.56-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > Results from Linaro’s test farm.
> > Regressions on arm64 bcm2711-rpi-4-b device running LTP dio tests on
> > NFS mounted rootfs.
> > and LTP hugetlb hugemmap11 test case failed on x86 and arm64 bcm2711-rpi-4-b.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > LTP hugetlb tests failed log
> >   tst_hugepage.c:83: TINFO: 1 hugepage(s) reserved
> >   tst_test.c:1558: TINFO: Timeout per run is 0h 05m 00s
> >   hugemmap11.c:47: TFAIL: Memory mismatch after Direct-IO write
> >
> > LTP dio tests failed log
> >   compare_file: char mismatch: infile offset 4096: 0x01 .   outfile
> > offset 4096: 0x00 .
> >   diotest01    1  TFAIL  :  diotest1.c:158: file compare failed for
> > infile and outfile
> 
> Bisection led to "NFS: Fix O_DIRECT locking issues" (upstream commit
> 7c6339322ce0c6128acbe36aacc1eeb986dd7bf1). Reverting that patch and
> "NFS: Fix error handling for O_DIRECT write scheduling" (upstream
> commit 954998b60caa8f2a3bf3abe490de6f08d283687a) (not a clean revert
> this one) made ltp-dio pass again.

So this is also an issue in Linus's tree?  Or is it only on the 6.1.y
tree.

thanks,

greg k-h
