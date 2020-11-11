Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22ED52AE82D
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Nov 2020 06:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbgKKFgB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Nov 2020 00:36:01 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:56813 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725468AbgKKFf5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Nov 2020 00:35:57 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UEx51DX_1605072945;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UEx51DX_1605072945)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 11 Nov 2020 13:35:46 +0800
Subject: Re: [PATCH] fs/nfsd: remove unused NFSDDBG_FACILITY to tame gcc
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1604634457-3954-2-git-send-email-alex.shi@linux.alibaba.com>
 <202011110421.9Eyhaskz-lkp@intel.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <1efed1ed-c408-5f82-3adc-12275ea793cf@linux.alibaba.com>
Date:   Wed, 11 Nov 2020 13:35:11 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <202011110421.9Eyhaskz-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I had a recall email for this patch https://www.spinics.net/lists/linux-nfs/msg80135.html
seem your robot just omit it. :)

Thanks

在 2020/11/11 上午4:55, kernel test robot 写道:
> Hi Alex,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v5.10-rc3 next-20201110]
> [cannot apply to nfsd/nfsd-next cel/for-next linux/master]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Alex-Shi/fs-nfsd-remove-unused-NFSDDBG_FACILITY-to-tame-gcc/20201106-115002
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 521b619acdc8f1f5acdac15b84f81fd9515b2aff
> config: x86_64-rhel (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/0day-ci/linux/commit/c817df999b061443f75af7b3ffe502bf289b0e03
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Alex-Shi/fs-nfsd-remove-unused-NFSDDBG_FACILITY-to-tame-gcc/20201106-115002
>         git checkout c817df999b061443f75af7b3ffe502bf289b0e03
>         # save the attached .config to linux build tree
>         make W=1 ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from fs/nfsd/nfssvc.c:26:
>    fs/nfsd/nfssvc.c: In function 'nfsd_inetaddr_event':
>>> fs/nfsd/nfsd.h:32:42: error: 'NFSDDBG_FACILITY' undeclared (first use in this function); did you mean 'NFSDDBG_FILEOP'?
>       32 | # define ifdebug(flag)  if (nfsd_debug & NFSDDBG_##flag)
>          |                                          ^~~~~~~~
>    include/linux/sunrpc/debug.h:39:2: note: in expansion of macro 'ifdebug'
>       39 |  ifdebug(fac)       \
>          |  ^~~~~~~
>    include/linux/sunrpc/debug.h:25:2: note: in expansion of macro 'dfprintk'
>       25 |  dfprintk(FACILITY, fmt, ##__VA_ARGS__)
>          |  ^~~~~~~~
>    fs/nfsd/nfssvc.c:451:3: note: in expansion of macro 'dprintk'
>      451 |   dprintk("nfsd_inetaddr_event: removed %pI4\n", &ifa->ifa_local);
>          |   ^~~~~~~
>    fs/nfsd/nfsd.h:32:42: note: each undeclared identifier is reported only once for each function it appears in
>       32 | # define ifdebug(flag)  if (nfsd_debug & NFSDDBG_##flag)
>          |                                          ^~~~~~~~
>    include/linux/sunrpc/debug.h:39:2: note: in expansion of macro 'ifdebug'
>       39 |  ifdebug(fac)       \
>          |  ^~~~~~~
>    include/linux/sunrpc/debug.h:25:2: note: in expansion of macro 'dfprintk'
>       25 |  dfprintk(FACILITY, fmt, ##__VA_ARGS__)
>          |  ^~~~~~~~
>    fs/nfsd/nfssvc.c:451:3: note: in expansion of macro 'dprintk'
>      451 |   dprintk("nfsd_inetaddr_event: removed %pI4\n", &ifa->ifa_local);
>          |   ^~~~~~~
>    fs/nfsd/nfssvc.c: In function 'nfsd_inet6addr_event':
>>> fs/nfsd/nfsd.h:32:42: error: 'NFSDDBG_FACILITY' undeclared (first use in this function); did you mean 'NFSDDBG_FILEOP'?
>       32 | # define ifdebug(flag)  if (nfsd_debug & NFSDDBG_##flag)
>          |                                          ^~~~~~~~
>    include/linux/sunrpc/debug.h:39:2: note: in expansion of macro 'ifdebug'
>       39 |  ifdebug(fac)       \
>          |  ^~~~~~~
>    include/linux/sunrpc/debug.h:25:2: note: in expansion of macro 'dfprintk'
>       25 |  dfprintk(FACILITY, fmt, ##__VA_ARGS__)
>          |  ^~~~~~~~
>    fs/nfsd/nfssvc.c:482:3: note: in expansion of macro 'dprintk'
>      482 |   dprintk("nfsd_inet6addr_event: removed %pI6\n", &ifa->addr);
>          |   ^~~~~~~
>    fs/nfsd/nfssvc.c: In function 'set_max_drc':
>>> fs/nfsd/nfsd.h:32:42: error: 'NFSDDBG_FACILITY' undeclared (first use in this function); did you mean 'NFSDDBG_FILEOP'?
>       32 | # define ifdebug(flag)  if (nfsd_debug & NFSDDBG_##flag)
>          |                                          ^~~~~~~~
>    include/linux/sunrpc/debug.h:39:2: note: in expansion of macro 'ifdebug'
>       39 |  ifdebug(fac)       \
>          |  ^~~~~~~
>    include/linux/sunrpc/debug.h:25:2: note: in expansion of macro 'dfprintk'
>       25 |  dfprintk(FACILITY, fmt, ##__VA_ARGS__)
>          |  ^~~~~~~~
>    fs/nfsd/nfssvc.c:570:2: note: in expansion of macro 'dprintk'
>      570 |  dprintk("%s nfsd_drc_max_mem %lu \n", __func__, nfsd_drc_max_mem);
>          |  ^~~~~~~
>    fs/nfsd/nfssvc.c: In function 'nfsd_svc':
>>> fs/nfsd/nfsd.h:32:42: error: 'NFSDDBG_FACILITY' undeclared (first use in this function); did you mean 'NFSDDBG_FILEOP'?
>       32 | # define ifdebug(flag)  if (nfsd_debug & NFSDDBG_##flag)
>          |                                          ^~~~~~~~
>    include/linux/sunrpc/debug.h:39:2: note: in expansion of macro 'ifdebug'
>       39 |  ifdebug(fac)       \
>          |  ^~~~~~~
>    include/linux/sunrpc/debug.h:25:2: note: in expansion of macro 'dfprintk'
>       25 |  dfprintk(FACILITY, fmt, ##__VA_ARGS__)
>          |  ^~~~~~~~
>    fs/nfsd/nfssvc.c:746:2: note: in expansion of macro 'dprintk'
>      746 |  dprintk("nfsd: creating service\n");
>          |  ^~~~~~~
>    fs/nfsd/nfssvc.c: In function 'nfsd_dispatch':
>>> fs/nfsd/nfsd.h:32:42: error: 'NFSDDBG_FACILITY' undeclared (first use in this function); did you mean 'NFSDDBG_FILEOP'?
>       32 | # define ifdebug(flag)  if (nfsd_debug & NFSDDBG_##flag)
>          |                                          ^~~~~~~~
>    include/linux/sunrpc/debug.h:39:2: note: in expansion of macro 'ifdebug'
>       39 |  ifdebug(fac)       \
>          |  ^~~~~~~
>    include/linux/sunrpc/debug.h:25:2: note: in expansion of macro 'dfprintk'
>       25 |  dfprintk(FACILITY, fmt, ##__VA_ARGS__)
>          |  ^~~~~~~~
>    fs/nfsd/nfssvc.c:1010:2: note: in expansion of macro 'dprintk'
>     1010 |  dprintk("nfsd_dispatch: vers %d proc %d\n",
>          |  ^~~~~~~
> --
>    In file included from fs/nfsd/xdr.h:8,
>                     from fs/nfsd/nfsproc.c:11:
>    fs/nfsd/nfsproc.c: In function 'nfsd_proc_getattr':
>>> fs/nfsd/nfsd.h:32:42: error: 'NFSDDBG_FACILITY' undeclared (first use in this function); did you mean 'NFSDDBG_FILEOP'?
>       32 | # define ifdebug(flag)  if (nfsd_debug & NFSDDBG_##flag)
>          |                                          ^~~~~~~~
>    include/linux/sunrpc/debug.h:39:2: note: in expansion of macro 'ifdebug'
>       39 |  ifdebug(fac)       \
>          |  ^~~~~~~
>    include/linux/sunrpc/debug.h:25:2: note: in expansion of macro 'dfprintk'
>       25 |  dfprintk(FACILITY, fmt, ##__VA_ARGS__)
>          |  ^~~~~~~~
>    fs/nfsd/nfsproc.c:30:2: note: in expansion of macro 'dprintk'
>       30 |  dprintk("nfsd: GETATTR  %s\n", SVCFH_fmt(&argp->fh));
>          |  ^~~~~~~
>    fs/nfsd/nfsd.h:32:42: note: each undeclared identifier is reported only once for each function it appears in
>       32 | # define ifdebug(flag)  if (nfsd_debug & NFSDDBG_##flag)
>          |                                          ^~~~~~~~
>    include/linux/sunrpc/debug.h:39:2: note: in expansion of macro 'ifdebug'
>       39 |  ifdebug(fac)       \
>          |  ^~~~~~~
>    include/linux/sunrpc/debug.h:25:2: note: in expansion of macro 'dfprintk'
>       25 |  dfprintk(FACILITY, fmt, ##__VA_ARGS__)
>          |  ^~~~~~~~
>    fs/nfsd/nfsproc.c:30:2: note: in expansion of macro 'dprintk'
>       30 |  dprintk("nfsd: GETATTR  %s\n", SVCFH_fmt(&argp->fh));
>          |  ^~~~~~~
>    fs/nfsd/nfsproc.c: In function 'nfsd_proc_setattr':
>>> fs/nfsd/nfsd.h:32:42: error: 'NFSDDBG_FACILITY' undeclared (first use in this function); did you mean 'NFSDDBG_FILEOP'?
>       32 | # define ifdebug(flag)  if (nfsd_debug & NFSDDBG_##flag)
>          |                                          ^~~~~~~~
>    include/linux/sunrpc/debug.h:39:2: note: in expansion of macro 'ifdebug'
>       39 |  ifdebug(fac)       \
>          |  ^~~~~~~
>    include/linux/sunrpc/debug.h:25:2: note: in expansion of macro 'dfprintk'
>       25 |  dfprintk(FACILITY, fmt, ##__VA_ARGS__)
>          |  ^~~~~~~~
>    fs/nfsd/nfsproc.c:54:2: note: in expansion of macro 'dprintk'
>       54 |  dprintk("nfsd: SETATTR  %s, valid=%x, size=%ld\n",
>          |  ^~~~~~~
>    fs/nfsd/nfsproc.c: In function 'nfsd_proc_lookup':
>>> fs/nfsd/nfsd.h:32:42: error: 'NFSDDBG_FACILITY' undeclared (first use in this function); did you mean 'NFSDDBG_FILEOP'?
>       32 | # define ifdebug(flag)  if (nfsd_debug & NFSDDBG_##flag)
>          |                                          ^~~~~~~~
>    include/linux/sunrpc/debug.h:39:2: note: in expansion of macro 'ifdebug'
>       39 |  ifdebug(fac)       \
>          |  ^~~~~~~
>    include/linux/sunrpc/debug.h:25:2: note: in expansion of macro 'dfprintk'
>       25 |  dfprintk(FACILITY, fmt, ##__VA_ARGS__)
>          |  ^~~~~~~~
>    fs/nfsd/nfsproc.c:129:2: note: in expansion of macro 'dprintk'
>      129 |  dprintk("nfsd: LOOKUP   %s %.*s\n",
>          |  ^~~~~~~
>    fs/nfsd/nfsproc.c: In function 'nfsd_proc_readlink':
>>> fs/nfsd/nfsd.h:32:42: error: 'NFSDDBG_FACILITY' undeclared (first use in this function); did you mean 'NFSDDBG_FILEOP'?
>       32 | # define ifdebug(flag)  if (nfsd_debug & NFSDDBG_##flag)
>          |                                          ^~~~~~~~
>    include/linux/sunrpc/debug.h:39:2: note: in expansion of macro 'ifdebug'
>       39 |  ifdebug(fac)       \
>          |  ^~~~~~~
>    include/linux/sunrpc/debug.h:25:2: note: in expansion of macro 'dfprintk'
>       25 |  dfprintk(FACILITY, fmt, ##__VA_ARGS__)
>          |  ^~~~~~~~
>    fs/nfsd/nfsproc.c:153:2: note: in expansion of macro 'dprintk'
>      153 |  dprintk("nfsd: READLINK %s\n", SVCFH_fmt(&argp->fh));
>          |  ^~~~~~~
>    fs/nfsd/nfsproc.c: In function 'nfsd_proc_read':
>>> fs/nfsd/nfsd.h:32:42: error: 'NFSDDBG_FACILITY' undeclared (first use in this function); did you mean 'NFSDDBG_FILEOP'?
>       32 | # define ifdebug(flag)  if (nfsd_debug & NFSDDBG_##flag)
>          |                                          ^~~~~~~~
>    include/linux/sunrpc/debug.h:39:2: note: in expansion of macro 'ifdebug'
>       39 |  ifdebug(fac)       \
>          |  ^~~~~~~
>    include/linux/sunrpc/debug.h:25:2: note: in expansion of macro 'dfprintk'
>       25 |  dfprintk(FACILITY, fmt, ##__VA_ARGS__)
>          |  ^~~~~~~~
>    fs/nfsd/nfsproc.c:174:2: note: in expansion of macro 'dprintk'
>      174 |  dprintk("nfsd: READ    %s %d bytes at %d\n",
>          |  ^~~~~~~
>    fs/nfsd/nfsproc.c: In function 'nfsd_proc_write':
>>> fs/nfsd/nfsd.h:32:42: error: 'NFSDDBG_FACILITY' undeclared (first use in this function); did you mean 'NFSDDBG_FILEOP'?
>       32 | # define ifdebug(flag)  if (nfsd_debug & NFSDDBG_##flag)
>          |                                          ^~~~~~~~
>    include/linux/sunrpc/debug.h:39:2: note: in expansion of macro 'ifdebug'
>       39 |  ifdebug(fac)       \
>          |  ^~~~~~~
>    include/linux/sunrpc/debug.h:25:2: note: in expansion of macro 'dfprintk'
>       25 |  dfprintk(FACILITY, fmt, ##__VA_ARGS__)
>          |  ^~~~~~~~
>    fs/nfsd/nfsproc.c:224:2: note: in expansion of macro 'dprintk'
>      224 |  dprintk("nfsd: WRITE    %s %d bytes at %d\n",
>          |  ^~~~~~~
>    fs/nfsd/nfsproc.c: In function 'nfsd_proc_create':
>>> fs/nfsd/nfsd.h:32:42: error: 'NFSDDBG_FACILITY' undeclared (first use in this function); did you mean 'NFSDDBG_FILEOP'?
>       32 | # define ifdebug(flag)  if (nfsd_debug & NFSDDBG_##flag)
>          |                                          ^~~~~~~~
>    include/linux/sunrpc/debug.h:39:2: note: in expansion of macro 'ifdebug'
>       39 |  ifdebug(fac)       \
>          |  ^~~~~~~
>    include/linux/sunrpc/debug.h:25:2: note: in expansion of macro 'dfprintk'
>       25 |  dfprintk(FACILITY, fmt, ##__VA_ARGS__)
>          |  ^~~~~~~~
>    fs/nfsd/nfsproc.c:266:2: note: in expansion of macro 'dprintk'
>      266 |  dprintk("nfsd: CREATE   %s %.*s\n",
>          |  ^~~~~~~
>    fs/nfsd/nfsproc.c: In function 'nfsd_proc_remove':
>>> fs/nfsd/nfsd.h:32:42: error: 'NFSDDBG_FACILITY' undeclared (first use in this function); did you mean 'NFSDDBG_FILEOP'?
>       32 | # define ifdebug(flag)  if (nfsd_debug & NFSDDBG_##flag)
>          |                                          ^~~~~~~~
>    include/linux/sunrpc/debug.h:39:2: note: in expansion of macro 'ifdebug'
>       39 |  ifdebug(fac)       \
>          |  ^~~~~~~
>    include/linux/sunrpc/debug.h:25:2: note: in expansion of macro 'dfprintk'
>       25 |  dfprintk(FACILITY, fmt, ##__VA_ARGS__)
>          |  ^~~~~~~~
>    fs/nfsd/nfsproc.c:419:2: note: in expansion of macro 'dprintk'
>      419 |  dprintk("nfsd: REMOVE   %s %.*s\n", SVCFH_fmt(&argp->fh),
>          |  ^~~~~~~
>    fs/nfsd/nfsproc.c: In function 'nfsd_proc_rename':
>>> fs/nfsd/nfsd.h:32:42: error: 'NFSDDBG_FACILITY' undeclared (first use in this function); did you mean 'NFSDDBG_FILEOP'?
>       32 | # define ifdebug(flag)  if (nfsd_debug & NFSDDBG_##flag)
>          |                                          ^~~~~~~~
>    include/linux/sunrpc/debug.h:39:2: note: in expansion of macro 'ifdebug'
>       39 |  ifdebug(fac)       \
>          |  ^~~~~~~
>    include/linux/sunrpc/debug.h:25:2: note: in expansion of macro 'dfprintk'
>       25 |  dfprintk(FACILITY, fmt, ##__VA_ARGS__)
>          |  ^~~~~~~~
>    fs/nfsd/nfsproc.c:435:2: note: in expansion of macro 'dprintk'
>      435 |  dprintk("nfsd: RENAME   %s %.*s -> \n",
>          |  ^~~~~~~
>    fs/nfsd/nfsproc.c: In function 'nfsd_proc_link':
>>> fs/nfsd/nfsd.h:32:42: error: 'NFSDDBG_FACILITY' undeclared (first use in this function); did you mean 'NFSDDBG_FILEOP'?
>       32 | # define ifdebug(flag)  if (nfsd_debug & NFSDDBG_##flag)
>          |                                          ^~~~~~~~
>    include/linux/sunrpc/debug.h:39:2: note: in expansion of macro 'ifdebug'
>       39 |  ifdebug(fac)       \
>          |  ^~~~~~~
>    include/linux/sunrpc/debug.h:25:2: note: in expansion of macro 'dfprintk'
>       25 |  dfprintk(FACILITY, fmt, ##__VA_ARGS__)
>          |  ^~~~~~~~
>    fs/nfsd/nfsproc.c:453:2: note: in expansion of macro 'dprintk'
>      453 |  dprintk("nfsd: LINK     %s ->\n",
>          |  ^~~~~~~
>    fs/nfsd/nfsproc.c: In function 'nfsd_proc_symlink':
>>> fs/nfsd/nfsd.h:32:42: error: 'NFSDDBG_FACILITY' undeclared (first use in this function); did you mean 'NFSDDBG_FILEOP'?
>       32 | # define ifdebug(flag)  if (nfsd_debug & NFSDDBG_##flag)
>          |                                          ^~~~~~~~
>    include/linux/sunrpc/debug.h:39:2: note: in expansion of macro 'ifdebug'
>       39 |  ifdebug(fac)       \
>          |  ^~~~~~~
>    include/linux/sunrpc/debug.h:25:2: note: in expansion of macro 'dfprintk'
>       25 |  dfprintk(FACILITY, fmt, ##__VA_ARGS__)
>          |  ^~~~~~~~
>    fs/nfsd/nfsproc.c:487:2: note: in expansion of macro 'dprintk'
>      487 |  dprintk("nfsd: SYMLINK  %s %.*s -> %.*s\n",
>          |  ^~~~~~~
>    fs/nfsd/nfsproc.c: In function 'nfsd_proc_mkdir':
>>> fs/nfsd/nfsd.h:32:42: error: 'NFSDDBG_FACILITY' undeclared (first use in this function); did you mean 'NFSDDBG_FILEOP'?
>       32 | # define ifdebug(flag)  if (nfsd_debug & NFSDDBG_##flag)
>          |                                          ^~~~~~~~
>    include/linux/sunrpc/debug.h:39:2: note: in expansion of macro 'ifdebug'
>       39 |  ifdebug(fac)       \
>          |  ^~~~~~~
>    include/linux/sunrpc/debug.h:25:2: note: in expansion of macro 'dfprintk'
>       25 |  dfprintk(FACILITY, fmt, ##__VA_ARGS__)
>          |  ^~~~~~~~
>    fs/nfsd/nfsproc.c:512:2: note: in expansion of macro 'dprintk'
>      512 |  dprintk("nfsd: MKDIR    %s %.*s\n", SVCFH_fmt(&argp->fh), argp->len, argp->name);
>          |  ^~~~~~~
>    fs/nfsd/nfsproc.c: In function 'nfsd_proc_rmdir':
>>> fs/nfsd/nfsd.h:32:42: error: 'NFSDDBG_FACILITY' undeclared (first use in this function); did you mean 'NFSDDBG_FILEOP'?
>       32 | # define ifdebug(flag)  if (nfsd_debug & NFSDDBG_##flag)
>          |                                          ^~~~~~~~
>    include/linux/sunrpc/debug.h:39:2: note: in expansion of macro 'ifdebug'
>       39 |  ifdebug(fac)       \
>          |  ^~~~~~~
>    include/linux/sunrpc/debug.h:25:2: note: in expansion of macro 'dfprintk'
>       25 |  dfprintk(FACILITY, fmt, ##__VA_ARGS__)
>          |  ^~~~~~~~
>    fs/nfsd/nfsproc.c:541:2: note: in expansion of macro 'dprintk'
>      541 |  dprintk("nfsd: RMDIR    %s %.*s\n", SVCFH_fmt(&argp->fh), argp->len, argp->name);
>          |  ^~~~~~~
>    fs/nfsd/nfsproc.c: In function 'nfsd_proc_readdir':
>>> fs/nfsd/nfsd.h:32:42: error: 'NFSDDBG_FACILITY' undeclared (first use in this function); did you mean 'NFSDDBG_FILEOP'?
>       32 | # define ifdebug(flag)  if (nfsd_debug & NFSDDBG_##flag)
>          |                                          ^~~~~~~~
>    include/linux/sunrpc/debug.h:39:2: note: in expansion of macro 'ifdebug'
>       39 |  ifdebug(fac)       \
>          |  ^~~~~~~
>    include/linux/sunrpc/debug.h:25:2: note: in expansion of macro 'dfprintk'
>       25 |  dfprintk(FACILITY, fmt, ##__VA_ARGS__)
>          |  ^~~~~~~~
>    fs/nfsd/nfsproc.c:560:2: note: in expansion of macro 'dprintk'
>      560 |  dprintk("nfsd: READDIR  %s %d bytes at %d\n",
>          |  ^~~~~~~
>    fs/nfsd/nfsproc.c: In function 'nfsd_proc_statfs':
>>> fs/nfsd/nfsd.h:32:42: error: 'NFSDDBG_FACILITY' undeclared (first use in this function); did you mean 'NFSDDBG_FILEOP'?
>       32 | # define ifdebug(flag)  if (nfsd_debug & NFSDDBG_##flag)
>          |                                          ^~~~~~~~
>    include/linux/sunrpc/debug.h:39:2: note: in expansion of macro 'ifdebug'
>       39 |  ifdebug(fac)       \
>          |  ^~~~~~~
>    include/linux/sunrpc/debug.h:25:2: note: in expansion of macro 'dfprintk'
>       25 |  dfprintk(FACILITY, fmt, ##__VA_ARGS__)
>          |  ^~~~~~~~
>    fs/nfsd/nfsproc.c:598:2: note: in expansion of macro 'dprintk'
>      598 |  dprintk("nfsd: STATFS   %s\n", SVCFH_fmt(&argp->fh));
>          |  ^~~~~~~
> --
>    In file included from fs/nfsd/nfsfh.c:14:
>    fs/nfsd/nfsfh.c: In function 'nfsd_acceptable':
>>> fs/nfsd/nfsd.h:32:42: error: 'NFSDDBG_FACILITY' undeclared (first use in this function); did you mean 'NFSDDBG_FILEOP'?
>       32 | # define ifdebug(flag)  if (nfsd_debug & NFSDDBG_##flag)
>          |                                          ^~~~~~~~
>    include/linux/sunrpc/debug.h:39:2: note: in expansion of macro 'ifdebug'
>       39 |  ifdebug(fac)       \
>          |  ^~~~~~~
>    include/linux/sunrpc/debug.h:25:2: note: in expansion of macro 'dfprintk'
>       25 |  dfprintk(FACILITY, fmt, ##__VA_ARGS__)
>          |  ^~~~~~~~
>    fs/nfsd/nfsfh.c:50:3: note: in expansion of macro 'dprintk'
>       50 |   dprintk("nfsd_acceptable failed at %p %pd\n", tdentry, tdentry);
>          |   ^~~~~~~
>    fs/nfsd/nfsd.h:32:42: note: each undeclared identifier is reported only once for each function it appears in
>       32 | # define ifdebug(flag)  if (nfsd_debug & NFSDDBG_##flag)
>          |                                          ^~~~~~~~
>    include/linux/sunrpc/debug.h:39:2: note: in expansion of macro 'ifdebug'
>       39 |  ifdebug(fac)       \
>          |  ^~~~~~~
>    include/linux/sunrpc/debug.h:25:2: note: in expansion of macro 'dfprintk'
>       25 |  dfprintk(FACILITY, fmt, ##__VA_ARGS__)
>          |  ^~~~~~~~
>    fs/nfsd/nfsfh.c:50:3: note: in expansion of macro 'dprintk'
>       50 |   dprintk("nfsd_acceptable failed at %p %pd\n", tdentry, tdentry);
>          |   ^~~~~~~
>    fs/nfsd/nfsfh.c: In function 'nfsd_setuser_and_check_port':
>>> fs/nfsd/nfsd.h:32:42: error: 'NFSDDBG_FACILITY' undeclared (first use in this function); did you mean 'NFSDDBG_FILEOP'?
>       32 | # define ifdebug(flag)  if (nfsd_debug & NFSDDBG_##flag)
>          |                                          ^~~~~~~~
>    include/linux/sunrpc/debug.h:39:2: note: in expansion of macro 'ifdebug'
>       39 |  ifdebug(fac)       \
>          |  ^~~~~~~
>    include/linux/sunrpc/debug.h:25:2: note: in expansion of macro 'dfprintk'
>       25 |  dfprintk(FACILITY, fmt, ##__VA_ARGS__)
>          |  ^~~~~~~~
>    fs/nfsd/nfsfh.c:107:3: note: in expansion of macro 'dprintk'
>      107 |   dprintk("nfsd: request from insecure port %s!\n",
>          |   ^~~~~~~
>    fs/nfsd/nfsfh.c: In function 'fh_verify':
>>> fs/nfsd/nfsd.h:32:42: error: 'NFSDDBG_FACILITY' undeclared (first use in this function); did you mean 'NFSDDBG_FILEOP'?
>       32 | # define ifdebug(flag)  if (nfsd_debug & NFSDDBG_##flag)
>          |                                          ^~~~~~~~
>    include/linux/sunrpc/debug.h:39:2: note: in expansion of macro 'ifdebug'
>       39 |  ifdebug(fac)       \
>          |  ^~~~~~~
>    include/linux/sunrpc/debug.h:25:2: note: in expansion of macro 'dfprintk'
>       25 |  dfprintk(FACILITY, fmt, ##__VA_ARGS__)
>          |  ^~~~~~~~
>    fs/nfsd/nfsfh.c:332:2: note: in expansion of macro 'dprintk'
>      332 |  dprintk("nfsd: fh_verify(%s)\n", SVCFH_fmt(fhp));
>          |  ^~~~~~~
>    fs/nfsd/nfsfh.c: In function 'fh_compose':
>>> fs/nfsd/nfsd.h:32:42: error: 'NFSDDBG_FACILITY' undeclared (first use in this function); did you mean 'NFSDDBG_FILEOP'?
>       32 | # define ifdebug(flag)  if (nfsd_debug & NFSDDBG_##flag)
>          |                                          ^~~~~~~~
>    include/linux/sunrpc/debug.h:39:2: note: in expansion of macro 'ifdebug'
>       39 |  ifdebug(fac)       \
>          |  ^~~~~~~
>    include/linux/sunrpc/debug.h:25:2: note: in expansion of macro 'dfprintk'
>       25 |  dfprintk(FACILITY, fmt, ##__VA_ARGS__)
>          |  ^~~~~~~~
>    fs/nfsd/nfsfh.c:548:2: note: in expansion of macro 'dprintk'
>      548 |  dprintk("nfsd: fh_compose(exp %02x:%02x/%ld %pd2, ino=%ld)\n",
>          |  ^~~~~~~
> ..
> 
> vim +32 fs/nfsd/nfsd.h
> 
> d430e8d530e900c Christoph Hellwig 2014-05-06  29  
> 6f226e2ab1b895c Christoph Hellwig 2014-05-06  30  #undef ifdebug
> 135dd002c23054a Mark Salter       2015-04-06  31  #ifdef CONFIG_SUNRPC_DEBUG
> 6f226e2ab1b895c Christoph Hellwig 2014-05-06 @32  # define ifdebug(flag)		if (nfsd_debug & NFSDDBG_##flag)
> 6f226e2ab1b895c Christoph Hellwig 2014-05-06  33  #else
> 6f226e2ab1b895c Christoph Hellwig 2014-05-06  34  # define ifdebug(flag)		if (0)
> 6f226e2ab1b895c Christoph Hellwig 2014-05-06  35  #endif
> 6f226e2ab1b895c Christoph Hellwig 2014-05-06  36  
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
