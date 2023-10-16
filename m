Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1189E7CA8D8
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Oct 2023 15:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjJPNJ2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Oct 2023 09:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233224AbjJPNJ1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Oct 2023 09:09:27 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C32EA
        for <linux-nfs@vger.kernel.org>; Mon, 16 Oct 2023 06:09:25 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:ce84:d8c0:f79a:fa0])
        by albert.telenet-ops.be with bizsmtp
        id yd9L2A00W0pDX7N06d9MDP; Mon, 16 Oct 2023 15:09:23 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qsNLR-006jYs-DZ;
        Mon, 16 Oct 2023 15:09:20 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qsNLU-00A9nT-Ox;
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
Subject: [PATCH -next v3 0/2] sunrpc: Fix W=1 compiler warnings
Date:   Mon, 16 Oct 2023 15:09:17 +0200
Message-Id: <cover.1697460614.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
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

	Hi all,

This patch series fixes W=1 compiler warnings in sunrpc, related to
variables that are used only when debugging is enabled.

Changes compared to v2:
  - New patch "sunrpc: Wrap read accesses to rpc_task.tk_pid",
  - Add Acked-by.

Changes compared to v1:
  - s/uncontionally/unconditionally/,
  - Drop CONFIG_SUNRPC_DEBUG check in fs/lockd/svclock.c to fix build
    failure.

Thanks for your comments!

Geert Uytterhoeven (2):
  sunrpc: Wrap read accesses to rpc_task.tk_pid
  sunrpc: Use no_printk() in dfprintk*() dummies

 fs/lockd/svclock.c                     |  2 --
 fs/nfs/filelayout/filelayout.c         | 12 ++++++------
 fs/nfs/flexfilelayout/flexfilelayout.c |  9 +++------
 include/linux/sunrpc/debug.h           |  6 +++---
 include/linux/sunrpc/sched.h           | 10 ++++++++++
 net/sunrpc/clnt.c                      |  2 +-
 net/sunrpc/debugfs.c                   |  2 +-
 7 files changed, 24 insertions(+), 19 deletions(-)

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
