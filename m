Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4AEE139658
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2020 17:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgAMQ3Z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Jan 2020 11:29:25 -0500
Received: from smtpcmd0756.aruba.it ([62.149.156.56]:51008 "EHLO
        smtpcmd0756.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729239AbgAMQ3W (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Jan 2020 11:29:22 -0500
Received: from ubuntu.localdomain ([212.103.203.10])
        by smtpcmd07.ad.aruba.it with bizsmtp
        id psVJ210130DySFo01sVLzZ; Mon, 13 Jan 2020 17:29:20 +0100
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     Steve Dickson <SteveD@RedHat.com>
Cc:     linux-nfs@vger.kernel.org,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [nfs-utils PATCH 2/3] rpcgen: rpc_cout: silence format-nonliteral
Date:   Mon, 13 Jan 2020 17:29:17 +0100
Message-Id: <20200113162918.77144-3-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200113162918.77144-1-giulio.benetti@benettiengineering.com>
References: <20200113162918.77144-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aruba.it; s=a1;
        t=1578932960; bh=oZq5foPSuzT4W9KRbABmy1Mqj8TVMtNKxFlptBRS7Eo=;
        h=From:To:Subject:Date:MIME-Version;
        b=X4ns9TNxPh3tHutw72kTF30jME9l3sOCudulZ01Ryzq7uQPdtvMsk4obmTpCObCtG
         JPOc97Iu0WplSygKE15tZPCDLjetxCFTLdCcSRBtMRVyxh0RwnwrUo7zfYwNVCmXCE
         uK/4zT558Dv6vUuM+rQ0prcPpt7lIzvGPAbviTKLnn4RkUQNJ+Alu0EaD5O4T7NEIa
         jO5xBzsd+YJHLoJE9uEksrVocQsVI9bIWDIj4i2GRIiwR2h5b8Qs++B7KyXHQvTLU/
         iDf0J6Q4IhY6yh+/hoe663vZflKeLu1NG6MMsDwpFNyRBgKnzc3W5C3+1mPyhlWZVB
         wr9itEtGsExew==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Silence format-nonliteral warning with #pragma GCC diagnostic ignored.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 tools/rpcgen/rpc_cout.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/rpcgen/rpc_cout.c b/tools/rpcgen/rpc_cout.c
index db7b571b..4627110d 100644
--- a/tools/rpcgen/rpc_cout.c
+++ b/tools/rpcgen/rpc_cout.c
@@ -353,6 +353,7 @@ emit_program (const definition * def)
       }
 }
 
+#pragma GCC diagnostic ignored "-Wformat-nonliteral"
 static void
 emit_union (const definition * def)
 {
@@ -430,6 +431,7 @@ emit_union (const definition * def)
 
   f_print (fout, "\t}\n");
 }
+#pragma GCC diagnostic warning "-Wformat-nonliteral"
 
 static void
 inline_struct (definition *def, int flag)
-- 
2.20.1

