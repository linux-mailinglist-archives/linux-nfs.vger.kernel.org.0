Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3661A7B7182
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Oct 2023 21:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjJCTFX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Oct 2023 15:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjJCTFW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Oct 2023 15:05:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAAFAB
        for <linux-nfs@vger.kernel.org>; Tue,  3 Oct 2023 12:05:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216D8C433C7;
        Tue,  3 Oct 2023 19:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696359918;
        bh=V+v7NLGKkdXEfY0BHeRyx+FLZpg0mjPZwGNRoOVcg7o=;
        h=From:To:Cc:Subject:Date:From;
        b=MaDbeYLqVD0Ng3Ll6fzTzziPydWzvFcltD+9b2iCIahrHDVrhwh/6JTB+lmAUXMfK
         JcW0XUc40ygB1nvV05tI6GIcK2up9Yb1t8p8e2VoFAa0VaGS5FaynmiBtsckwHXnYO
         rUxVI3ZqIQbgrV/UK750OpN4HYjUbtCohHZFkHs3rxwMtR9HnbBxjZLdlRwb3PZNss
         fSsWAJ/anN7fX8kfjsmMuzitYn76pf6jWKJsAjBDMguPQ4pMhmFqBuCzdHUhkI3Lyw
         bKhfhQDW6pyR+e9Lreiyz9u5KQ8ko/j59VG3RlOdwZgr9zYm6s2n7JT2Jd5MR5HPAC
         3Xq+MqvFGE01g==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, torvalds@linux-foundation.org
Cc:     anna@kernel.org
Subject: [GIT PULL] More NFS Client Bugfixes for Linux 6.6-rc
Date:   Tue,  3 Oct 2023 15:05:16 -0400
Message-ID: <20231003190516.117507-1-anna@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus,

The following changes since commit 6465e260f48790807eef06b583b38ca9789b6072:

  Linux 6.6-rc3 (2023-09-24 14:31:13 -0700)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.6-3

for you to fetch changes up to dd1b2026323a2d075ac553cecfd7a0c23c456c59:

  nfs: decrement nrequests counter before releasing the req (2023-09-28 12:22:25 -0400)

----------------------------------------------------------------
More NFS Client Bugfixes for Linux 6.6-rc

Stable Fix:
  * Revert "SUNRPC dont update timeout value on connection reset"
  * NFSv4: Fix a state manager thread deadlock regression

Bugfixes:
  * Fix a potential NULL pointer dereference in nfs_inode_remove_request()
  * Fix a rare NULL pointer dereference in xs_tcp_tls_setup_socket()
  * Fix long delay before failing a TLS mount when server does not support TLS
  * Fix various NFS state manager issues

Thanks,
Anna

----------------------------------------------------------------
Anna Schumaker (1):
      SUNRPC/TLS: Lock the lower_xprt during the tls handshake

Chuck Lever (1):
      SUNRPC: Fail quickly when server does not recognize TLS

Jeff Layton (1):
      nfs: decrement nrequests counter before releasing the req

Trond Myklebust (3):
      NFSv4: Fix a nfs4_state_manager() race
      NFSv4: Fix a state manager thread deadlock regression
      Revert "SUNRPC dont update timeout value on connection reset"

 fs/nfs/nfs4proc.c     |  4 +++-
 fs/nfs/nfs4state.c    | 45 +++++++++++++++++++++++++++++++++------------
 fs/nfs/write.c        |  2 +-
 net/sunrpc/auth.c     | 11 ++++++++---
 net/sunrpc/auth_tls.c |  4 ++--
 net/sunrpc/clnt.c     | 13 ++++++++++---
 net/sunrpc/xprtsock.c |  6 ++++++
 7 files changed, 63 insertions(+), 22 deletions(-)
