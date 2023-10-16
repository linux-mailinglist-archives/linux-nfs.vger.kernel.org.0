Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E771B7CA8D6
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Oct 2023 15:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbjJPNJ1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Oct 2023 09:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjJPNJ0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Oct 2023 09:09:26 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D20B4
        for <linux-nfs@vger.kernel.org>; Mon, 16 Oct 2023 06:09:24 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:ce84:d8c0:f79a:fa0])
        by xavier.telenet-ops.be with bizsmtp
        id yd9M2A0010pDX7N01d9Mei; Mon, 16 Oct 2023 15:09:23 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qsNLR-006jYw-EV;
        Mon, 16 Oct 2023 15:09:20 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qsNLU-00A9nZ-SG;
        Mon, 16 Oct 2023 15:09:20 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc:     linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH -next v3 2/2] sunrpc: Use no_printk() in dfprintk*() dummies
Date:   Mon, 16 Oct 2023 15:09:19 +0200
Message-Id: <180fd042261dcd4243fad90660b114b8f0a78dcd.1697460614.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1697460614.git.geert+renesas@glider.be>
References: <cover.1697460614.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When building NFS with W=1 and CONFIG_WERROR=y, but
CONFIG_SUNRPC_DEBUG=n:

    fs/nfs/nfs4proc.c: In function ‘nfs4_proc_create_session’:
    fs/nfs/nfs4proc.c:9276:19: error: variable ‘ptr’ set but not used [-Werror=unused-but-set-variable]
     9276 |         unsigned *ptr;
	  |                   ^~~
      CC      fs/nfs/callback.o
    fs/nfs/callback.c: In function ‘nfs41_callback_svc’:
    fs/nfs/callback.c:98:13: error: variable ‘error’ set but not used [-Werror=unused-but-set-variable]
       98 |         int error;
	  |             ^~~~~
      CC      fs/nfs/flexfilelayout/flexfilelayout.o
    fs/nfs/flexfilelayout/flexfilelayout.c: In function ‘ff_layout_io_track_ds_error’:
    fs/nfs/flexfilelayout/flexfilelayout.c:1230:13: error: variable ‘err’ set but not used [-Werror=unused-but-set-variable]
     1230 |         int err;
	  |             ^~~
      CC      fs/nfs/flexfilelayout/flexfilelayoutdev.o
    fs/nfs/flexfilelayout/flexfilelayoutdev.c: In function ‘nfs4_ff_alloc_deviceid_node’:
    fs/nfs/flexfilelayout/flexfilelayoutdev.c:55:16: error: variable ‘ret’ set but not used [-Werror=unused-but-set-variable]
       55 |         int i, ret = -ENOMEM;
	  |                ^~~

All these are due to variables that are set unconditionally, but are
used only when debugging is enabled.

Fix this by changing the dfprintk*() dummy macros from empty loops to
calls to the no_printk() helper.  This informs the compiler that the
passed debug parameters are actually used, and enables format specifier
checking as a bonus.

This requires removing the protection by CONFIG_SUNRPC_DEBUG of the
declaration of nlmdbg_cookie2a() in fs/lockd/svclock.c, as its reference
is now visible to the compiler, but optimized away.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Jeff Layton <jlayton@kernel.org>
---
v3:
  - Add Acked-by,

v2:
  - s/uncontionally/unconditionally/,
  - Drop CONFIG_SUNRPC_DEBUG check in fs/lockd/svclock.c to fix build
    failure.
---
 fs/lockd/svclock.c           | 2 --
 include/linux/sunrpc/debug.h | 6 +++---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index 43aeba9de55cbbc5..b80e0e143c5db16a 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -55,7 +55,6 @@ static const struct rpc_call_ops nlmsvc_grant_ops;
 static LIST_HEAD(nlm_blocked);
 static DEFINE_SPINLOCK(nlm_blocked_lock);
 
-#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 static const char *nlmdbg_cookie2a(const struct nlm_cookie *cookie)
 {
 	/*
@@ -82,7 +81,6 @@ static const char *nlmdbg_cookie2a(const struct nlm_cookie *cookie)
 
 	return buf;
 }
-#endif
 
 /*
  * Insert a blocked lock into the global list
diff --git a/include/linux/sunrpc/debug.h b/include/linux/sunrpc/debug.h
index f6aeed07fe04e3d5..76539c6673f2fb15 100644
--- a/include/linux/sunrpc/debug.h
+++ b/include/linux/sunrpc/debug.h
@@ -67,9 +67,9 @@ do {									\
 # define RPC_IFDEBUG(x)		x
 #else
 # define ifdebug(fac)		if (0)
-# define dfprintk(fac, fmt, ...)	do {} while (0)
-# define dfprintk_cont(fac, fmt, ...)	do {} while (0)
-# define dfprintk_rcu(fac, fmt, ...)	do {} while (0)
+# define dfprintk(fac, fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
+# define dfprintk_cont(fac, fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
+# define dfprintk_rcu(fac, fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
 # define RPC_IFDEBUG(x)
 #endif
 
-- 
2.34.1

