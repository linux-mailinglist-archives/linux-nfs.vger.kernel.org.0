Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811597C4FA6
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Oct 2023 12:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbjJKKIs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Oct 2023 06:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346078AbjJKKId (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Oct 2023 06:08:33 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5283171B
        for <linux-nfs@vger.kernel.org>; Wed, 11 Oct 2023 03:07:25 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:b72e:818:7fe2:593d])
        by xavier.telenet-ops.be with bizsmtp
        id wa7L2A00W56sUls01a7LSi; Wed, 11 Oct 2023 12:07:22 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qqW7a-00648i-RP;
        Wed, 11 Oct 2023 12:07:20 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qqW7c-00HQrM-DG;
        Wed, 11 Oct 2023 12:07:20 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] sunrpc: Use no_printk() in dfprintk*() dummies
Date:   Wed, 11 Oct 2023 12:07:19 +0200
Message-Id: <707e5e6dd0db9a663cf443564d1f8ee1c10a0086.1697018818.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
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

All these are due to variables that are set uncontionally, but are used
only when debugging is enabled.

Fix this by changing the dfprintk*() dummy macros from empty loops to
calls to the no_printk() helper.  This informs the compiler that the
passed debug parameters are actually used, and enables format specifier
checking as a bonus.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/linux/sunrpc/debug.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

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

