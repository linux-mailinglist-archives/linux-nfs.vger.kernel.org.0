Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B844D48DCC6
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jan 2022 18:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiAMRUU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Jan 2022 12:20:20 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:42474 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiAMRUU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Jan 2022 12:20:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95E5CB8230A
        for <linux-nfs@vger.kernel.org>; Thu, 13 Jan 2022 17:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11887C36AE9;
        Thu, 13 Jan 2022 17:20:17 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/3] Minor clean-ups for v5.17
Date:   Thu, 13 Jan 2022 12:20:16 -0500
Message-Id:  <164209428615.12592.12164353310787172940.stgit@morisot.1015granger.net>
X-Mailer: git-send-email 2.34.0
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=931; h=from:subject:message-id; bh=q5nj43+7AYoEgTx6UkX8hO/kf6vjXUNsTE7C8+vHdOA=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBh4F9L4xOJIzAH84FbS+e/aaZOGLlyclCv8WMsupNS CT84fLCJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYeBfSwAKCRAzarMzb2Z/l0N2EA CMronIbMxQ0NuAThwpM40ksuLK3OtNCcJYfDXt+siimTbW32yeJgqtspPQnHSKs+p3/zyyWiuBXezE aEPNigmOK9qK5P0fGPEKMvvQUWW6A7KENXEf7a2LSIIzPlAyBzND5gjoHZ9dZjUFcUXwibMEeHxAx1 z3HnaG1fvDtG9W5hoEJ0h6gxl5yT/E9U2PEocKtUUsJvFTnT8Be9ugCFjAvKRKUH5OX2D8+Dcv6HaX KnGQAMfqYUVZ9foT+Tjz5A1OOUl08WzAqD0jL3u8irc5b+e3KCR4BhxEqIL0c0BSPFWe3fOd+me1mi nZedOlODVtBhH2DTtH+Y0JlZqpcw2C5299RdkSydm2zjkj5juxJa5yjMGDI5uZaW/bfnRBdUm6MEWQ eCQoY/9QprH4usya/U2O6AZ6iAIQd9oOsdiAuwlFVzw/UhOddVYTQAviOzzLTzy3mjPQ3JRXg1HFFh sMu/GSvT6WuDCoCatDyjn2DQzNG+f2Is0FdAU7EIZK9VDm5bLJ5WR6eP3JvOawZAt+uoO61qlIU4Xl vD0E3yzDlgivyFcD9M4s3Iysp33gPON5oQDXv4gKDFq84gROrR5YQch9WPK94R9Z0uT+AiwzuABRJ1 tKXGZXyE9BQK5NjwxYVZUSXAIQ6kXU7VOnUatdSzUu+d/K4PIYUrvBR1YfPQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Sorry, these seem to have gotten lost in the shuffle. They've been
in my client-miscellany branch on git.kernel.org since late
November. I must have forgotten to repost them for review.

Trond rejected "SUNRPC: Don't dereference xprt->snd_task if it's
a cookie" for v5.16, so I've recrafted it to hopefully address
his concerns.

---

Chuck Lever (3):
      xprtrdma: Remove final dprintk call sites from xprtrdma
      xprtrdma: Remove definitions of RPCDBG_FACILITY
      SUNRPC: Don't dereference xprt->snd_task if it's a cookie


 include/trace/events/sunrpc.h     | 18 +++++++++++++-----
 net/sunrpc/xprtrdma/backchannel.c |  4 ----
 net/sunrpc/xprtrdma/frwr_ops.c    |  4 ----
 net/sunrpc/xprtrdma/rpc_rdma.c    |  4 ----
 net/sunrpc/xprtrdma/transport.c   |  4 ----
 net/sunrpc/xprtrdma/verbs.c       | 23 -----------------------
 6 files changed, 13 insertions(+), 44 deletions(-)

--
Chuck Lever
