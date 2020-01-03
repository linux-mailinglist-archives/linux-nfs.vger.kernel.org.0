Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32F1D12FE83
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2020 22:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgACV5v (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Jan 2020 16:57:51 -0500
Received: from smtpcmd0997.aruba.it ([62.149.156.97]:57371 "EHLO
        smtpcmd0997.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728711AbgACV5u (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Jan 2020 16:57:50 -0500
Received: from ubuntu.localdomain ([89.164.7.165])
        by smtpcmd09.ad.aruba.it with bizsmtp
        id lxqg2101g3ZeEr501xqjeE; Fri, 03 Jan 2020 22:50:44 +0100
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     linux-nfs@vger.kernel.org
Cc:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [nfs-utils PATCH 2/7] rpcgen: rpc_util: add storeval args to prototype
Date:   Fri,  3 Jan 2020 22:50:34 +0100
Message-Id: <20200103215039.27471-3-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200103215039.27471-1-giulio.benetti@benettiengineering.com>
References: <20200103215039.27471-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aruba.it; s=a1;
        t=1578088244; bh=IpcO46TGeUmpVcbjgafphEj0IzPX776wcDD92508DLg=;
        h=From:To:Subject:Date:MIME-Version;
        b=ld71bdkZ3EJUVCx+xzolO4g2IZtdj/NOeZD4jxPQBiglu7Wc+P6yK/JMvPBOg+sla
         hlxnTTIeFRDS/kxRm0eBtSzV3d2HFxD5fEKRw1ohlQ7bRfl0KomwZJPrzlLwA1ERDM
         ahjzywHZe0cV1nyFKpg3I6I+/gnqUzOOqpey8qedQIXSS7CwQIA/Nn+CKm63aiDpg7
         stcjletpeXdg2SkER7kB/LeaXnUQv+LHRdjwHqTzrMWRI7y1Hl02cBgOryK+rXdIl8
         qkekgWKpEhuuYb56SdijTPe1wP2NtbZEt+fplmkCCSWHoqH6eY0R5tS6cNR2gyNa/s
         cxrGY4NlHMZrQ==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

storeval() prototype has no arguments and this can cause warnings during
building. Let's add its arguments to prototype according to its
implementation.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 tools/rpcgen/rpc_util.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/rpcgen/rpc_util.h b/tools/rpcgen/rpc_util.h
index fa115bee..bd7b15ca 100644
--- a/tools/rpcgen/rpc_util.h
+++ b/tools/rpcgen/rpc_util.h
@@ -91,7 +91,7 @@ extern int nonfatalerrors;
 /*
  * rpc_util routines 
  */
-void storeval();
+void storeval(list **, definition *);
 
 #define STOREVAL(list,item)	\
 	storeval(list,item)
-- 
2.20.1

