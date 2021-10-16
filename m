Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A85430521
	for <lists+linux-nfs@lfdr.de>; Sun, 17 Oct 2021 00:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244667AbhJPWE3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 16 Oct 2021 18:04:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235312AbhJPWE2 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 16 Oct 2021 18:04:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C9F060E98;
        Sat, 16 Oct 2021 22:02:19 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 0/7] Update RPC task pid as displayed by tracepoints
Date:   Sat, 16 Oct 2021 18:02:18 -0400
Message-Id:  <163442096873.1585.8967342784030733636.stgit@morisot.1015granger.net>
X-Mailer: git-send-email 2.33.0
User-Agent: StGit/1.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1866; h=from:subject:message-id; bh=zxv6h3jkU60Xa4opXKNnXUljyBAso0Zb1hfUMo72epo=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBha0vkTSHtY5H5/7webaGq150vYWPANCIOe5YPpqbu zP+2o3OJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYWtL5AAKCRAzarMzb2Z/l0bzEA CA/mPGoGdvCmzGmie/JUigJOxsKdF5JCK7QocWhH0IqkBtxAg5CEeByXp5OxRAYLQ8LqAzc6zg2fGQ ATw0WBb79LoZ6TvOUcQOQXjClEoPEUw1SstbxaXUV0aS4gXo0jXH9zx2GmmZmf9ksxw02he7cuBVIq PweHuQmyxswxrLl1d2PrDZojzxFksACJLZr7LEKUCQv7629vlGfBXMkHJTlV1RfzvfS8aCS5jIuf63 IBCNX79XvW/9zl0g3Pso+PxSM+NsAC3+C8OTrqPD+O8HwV1qNZ8pv73an6B/hEwQtpN1USyL4xA45S 2q5jVMgDv7MoDVc4cKn8t2U3Byv+qeryWS/GCcnvEy42N6v1fCwzs4ydxEUN17Rv7MYavnEkruOPAd 0p01CdjUrhSKHf0ZAwsc5x0sapoicR9kLLLczj09L+1ZvEQhMP6sGPstiH2ZbkhnFucoXrE/kKaM6s p6+w8GLM1RCYton/Sb0qpv/IpINAcwl2uo06D54FScSLYa+/UmEusMjszyOF6HVTBnNpokd4y6HErK ki3oTXBf47fHEX83j2CgsLroEcb2D9ih4RzHU9dagOYjIC5GjkpLBCLdVkseZQllLQbUugfXbN/Hst 7NtACgUvpqeS5h0auKqWk48FhdpZgisuZ1bE3g33fCzJCMrPs7UsFHLADYlA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Reposting this series:

https://lore.kernel.org/linux-nfs/163345354511.524558.1980332041837428746.stgit@morisot.1015granger.net/

with the final patch in that series was updated as it was here:

https://lore.kernel.org/linux-nfs/163370502469.515303.12254136133220397877.stgit@morisot.1015granger.net/

Changes since v3:
- Repost entire series with updated 5/5
- Include two more tracepoint-related clean up patches

---

Chuck Lever (7):
      SUNRPC: Tracepoints should display tk_pid and cl_clid as a fixed-size field
      SUNRPC: Avoid NULL pointer dereferences in tracepoints
      SUNRPC: Use BIT() macro in rpc_show_xprt_state()
      SUNRPC: Don't dereference xprt->snd_task if it's a cookie
      NFS: Replace dprintk callsites in nfs_readpage(s)
      SUNRPC: Trace calls to .rpc_call_done
      NFS: Remove --> and <-- dprintk call sites


 fs/lockd/clntproc.c                    |   3 -
 fs/lockd/svc4proc.c                    |   2 -
 fs/lockd/svcproc.c                     |   2 -
 fs/nfs/filelayout/filelayout.c         |   2 -
 fs/nfs/flexfilelayout/flexfilelayout.c |   2 -
 fs/nfs/nfs4proc.c                      |  54 +-------
 fs/nfs/nfs4trace.h                     |  17 +--
 fs/nfs/nfstrace.h                      | 155 ++++++++++++++++++++-
 fs/nfs/pagelist.c                      |   3 -
 fs/nfs/read.c                          |  11 +-
 fs/nfs/write.c                         |   3 -
 include/trace/events/rpcgss.h          |  36 ++---
 include/trace/events/rpcrdma.h         | 104 ++++++--------
 include/trace/events/sunrpc.h          | 183 +++++++++++--------------
 include/trace/events/sunrpc_base.h     |  42 ++++++
 net/sunrpc/sched.c                     |   1 +
 16 files changed, 351 insertions(+), 269 deletions(-)
 create mode 100644 include/trace/events/sunrpc_base.h

--
Chuck Lever
