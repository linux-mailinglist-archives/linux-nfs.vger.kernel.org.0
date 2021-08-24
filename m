Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689813F61CF
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Aug 2021 17:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238284AbhHXPjE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Aug 2021 11:39:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:43774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234546AbhHXPjE (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 24 Aug 2021 11:39:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7830D61151;
        Tue, 24 Aug 2021 15:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629819499;
        bh=kz5dpKm3mk2Yt7edtfvSS17rQvTHBQ4kcZeU64c03Qg=;
        h=From:To:Cc:Subject:Date:From;
        b=GIHMb5feSOnGC+Au3p2g9x+vNrXRx8Njs9yj8OhIjkfr/ElENjEMaedMeN4Gb/fuH
         tkxiXf7/pwRgw7sgMBvs3A4Zu+cQO5mlRNmYZe42Ltd/1ICmTpO75iz4qgct+/+hRA
         TT2AFmqadzhjo5xRFu08CRl6LCr73LYcVJC7YuMEmxSbT7g1YhX/gzJ97RFVb2s+oQ
         Hu6z07eWrvsvLJzFWFwzpTFCkqPLI/ph8vBfFam3cDifhGozkLIXuCWtrjpvosn1Uk
         9cYi8y3g0w7GOeLIsvfYmQk0iqNEwfJsGTXNIt/Lp01MMRS+o1TfSoLk8tkGfMf1QJ
         luiqD1brEZDVw==
From:   trondmy@kernel.org
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] SUNRPC: Simplify socket shutdown when not reusing TCP ports
Date:   Tue, 24 Aug 2021 11:38:17 -0400
Message-Id: <20210824153818.322833-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If we're not required to reuse the TCP port, then we can just
immediately close the socket, and leave the cleanup details to the TCP
layer.

Fixes: e6237b6feb37 ("NFSv4.1: Don't rebind to the same source port when reconnecting to the server")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/xprtsock.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index e573dcecdd66..7e94f1d17edb 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2099,6 +2099,10 @@ static void xs_tcp_shutdown(struct rpc_xprt *xprt)
 
 	if (sock == NULL)
 		return;
+	if (!xprt->reuseport) {
+		xs_close(xprt);
+		return;
+	}
 	switch (skst) {
 	default:
 		kernel_sock_shutdown(sock, SHUT_RDWR);
-- 
2.31.1

