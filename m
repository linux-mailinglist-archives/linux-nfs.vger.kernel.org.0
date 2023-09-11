Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39EB79B552
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 02:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355463AbjIKV7x (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Sep 2023 17:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240183AbjIKOik (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Sep 2023 10:38:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B673F2;
        Mon, 11 Sep 2023 07:38:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04120C433C8;
        Mon, 11 Sep 2023 14:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694443113;
        bh=fx3d3McoLqJY93gfGI0mWuifrtOol2dbdQhxb2Lf8lo=;
        h=Subject:From:To:Cc:Date:From;
        b=AT458EAoGGf6HrVJ/qBUVIWquz3tCDAoAyBd9pI9m6wfU+2cgeQtsUujWT44AEQT4
         7af9+dvalEsFL6u4XA5tlL4B5IGdC1nevvhq0aHvN/Gag48YVWkh93XqZAaSJtDDw4
         NAhwAvGs26nQwsk35jZbDQ/zVCoWBpHTKe8EWlE0iNE248DBTVqAqKpppI7fH5qI/H
         mwZwZFTH76lPRm7I0fInGQ1oPC2is2rYCVNvBnB21inhGYoMFsqmbX7FxezSeqJJ2Y
         CdhTzDIkLik9qEyNyM1YCdm+HDa7sDiB8ff7uKseNMbdWsJDCpAPeVwvOEYK9rPyGq
         xy0uzz6+sdrQQ==
Subject: [PATCH v1 00/17] RPC service thread improvements
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Kees Cook <keescook@chromium.org>, NeilBrown <neilb@suse.de>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Date:   Mon, 11 Sep 2023 10:38:32 -0400
Message-ID: <169444233785.4327.4365499966926096681.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Here's the remaining set of RPC service thread improvements. This
series has been tested on v6.5.0 plus nfsd-next. The goal of this
work is to replace the current RPC service thread scheduler, which
walks a linked list to find an idle thread to wake, with a constant
time thread scheduler.

I've done some latency studies to measure the improvement. The
workload is fio on an NFSv3-over-TCP mount on 100GbE. The server
is running a v6.5.0 kernel with the v6.6 nfsd-next patches
applied. Server hardware is 4-core with 32GB of RAM and a tmpfs
export.

Latency measurements were generated with ktime_get() and recorded
via bespoke tracepoints added to svc_xprt_enqueue().

No patches applied (Linux 6.5.0-00057-g4c4f6d1271f1):
* 8 nfsd threads
    * 6682115 total RPCs
    * 32675206 svc_xprt_enqueue calls
    * 6683512 wake_idle calls (from svc_xprt_enqueue)
    * min/mean/max ns: 189/1601.83/6128677
* 32 nfsd threads
    * 6565439 total RPCs
    * 32136015 svc_xprt_enqueue calls
    * 6566486 wake_idle calls
    * min/mean/max ns: 373/1963.43/14027191
* 128 nfsd threads
    * 6434503 total RPCs
    * 31545411 svc_xprt_enqueue calls
    * 6435211 wake_idle calls
    * min/mean/max ns: 364/2289.3/24668201
* 512 nfsd threads
    * 6500600 total RPCs
    * 31798278 svc_xprt_enqueue calls
    * 6501659 wake_idle calls
    * min/mean/max ns: 371/2505.7/24983624

change-the-back-channel-to-use-lwq (Linux 6.5.0-00074-g5b9d1e90911d):
* 8 nfsd threads
    * 6643835 total RPCs
    * 32508906 svc_xprt_enqueue calls
    * 6644845 wake_idle calls (from svc_xprt_enqueue)
    * min/mean/max ns: 80/914.305/9785192
* 32 nfsd threads
    * 6679458 total RPCs
    * 32661542 svc_xprt_enqueue calls
    * 6680747 wake_idle calls
    * min/mean/max ns: 95/1194.38/10877985
* 128 nfsd threads
    * 6681268 total RPCs
    * 32674437 svc_xprt_enqueue calls
    * 6682497 wake_idle calls
    * min/mean/max ns: 95/1247.38/17284050
* 512 nfsd threads
    * 6700810 total RPCs
    * 32766457 svc_xprt_enqueue calls
    * 6702022 wake_idle calls
    * min/mean/max ns: 94/1265.88/14418874

And for dessert, a couple of latency histograms with Neil's patches
applied:

8 nfsd threads:
bin(centre) = freq
bin(150)    = 917305   14.3191%
bin(450)    = 643715   10.0483%
bin(750)    = 3285903  51.2927%
bin(1050)   = 537586    8.39168%
bin(1350)   = 359511    5.61194%
bin(1650)   = 330793    5.16366%
bin(1950)   = 125331    1.95641%
bin(2250)   = 55994     0.874062%
bin(2550)   = 33710     0.526211%
bin(2850)   = 24544     0.38313%

512 nfsd threads:
bin(centre) = freq
bin(150)    = 935030   14.5736%
bin(450)    = 636380    9.91876%
bin(750)    = 3268418  50.9423%
bin(1050)   = 542533    8.45604%
bin(1350)   = 367382    5.7261%
bin(1650)   = 334638    5.21574%
bin(1950)   = 125546    1.95679%
bin(2250)   = 55832     0.87021%
bin(2550)   = 33992     0.529807%
bin(2850)   = 25091     0.391074%

---

Chuck Lever (1):
      SUNRPC: Clean up bc_svc_process()

NeilBrown (16):
      SUNRPC: move all of xprt handling into svc_xprt_handle()
      SUNRPC: rename and refactor svc_get_next_xprt()
      SUNRPC: integrate back-channel processing with svc_recv()
      SUNRPC: change how svc threads are asked to exit.
      SUNRPC: add list of idle threads
      SUNRPC: discard SP_CONGESTED
      llist: add interface to check if a node is on a list.
      SUNRPC: change service idle list to be an llist
      llist: add llist_del_first_this()
      lib: add light-weight queuing mechanism.
      SUNRPC: rename some functions from rqst_ to svc_thread_
      SUNRPC: only have one thread waking up at a time
      SUNRPC: use lwq for sp_sockets - renamed to sp_xprts
      SUNRPC: change sp_nrthreads to atomic_t
      SUNRPC: discard sp_lock
      SUNRPC: change the back-channel queue to lwq


 fs/lockd/svc.c                    |   5 +-
 fs/lockd/svclock.c                |   5 +-
 fs/nfs/callback.c                 |  46 +-----
 fs/nfsd/nfs4proc.c                |   8 +-
 fs/nfsd/nfssvc.c                  |  13 +-
 include/linux/llist.h             |  46 ++++++
 include/linux/lockd/lockd.h       |   2 +-
 include/linux/lwq.h               | 120 +++++++++++++++
 include/linux/sunrpc/svc.h        |  44 ++++--
 include/linux/sunrpc/svc_xprt.h   |   2 +-
 include/linux/sunrpc/xprt.h       |   3 +-
 include/trace/events/sunrpc.h     |   1 -
 lib/Kconfig                       |   5 +
 lib/Makefile                      |   2 +-
 lib/llist.c                       |  28 ++++
 lib/lwq.c                         | 151 +++++++++++++++++++
 net/sunrpc/backchannel_rqst.c     |  13 +-
 net/sunrpc/svc.c                  | 146 +++++++++---------
 net/sunrpc/svc_xprt.c             | 236 ++++++++++++++----------------
 net/sunrpc/xprtrdma/backchannel.c |   6 +-
 20 files changed, 590 insertions(+), 292 deletions(-)
 create mode 100644 include/linux/lwq.h
 create mode 100644 lib/lwq.c

--
Chuck Lever

