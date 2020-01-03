Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81FF212FE81
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2020 22:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbgACV5v (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Jan 2020 16:57:51 -0500
Received: from smtpcmd0997.aruba.it ([62.149.156.97]:53995 "EHLO
        smtpcmd0997.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728698AbgACV5u (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Jan 2020 16:57:50 -0500
Received: from ubuntu.localdomain ([89.164.7.165])
        by smtpcmd09.ad.aruba.it with bizsmtp
        id lxqg2101g3ZeEr501xqleL; Fri, 03 Jan 2020 22:50:46 +0100
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     linux-nfs@vger.kernel.org
Cc:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [nfs-utils PATCH 4/7] rpcgen: rpc_parse: add get_definition() void argument
Date:   Fri,  3 Jan 2020 22:50:36 +0100
Message-Id: <20200103215039.27471-5-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200103215039.27471-1-giulio.benetti@benettiengineering.com>
References: <20200103215039.27471-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aruba.it; s=a1;
        t=1578088246; bh=s0/vXAJf5ErPcbRliVgrliOraulwcqeXI6IUq9DwmCc=;
        h=From:To:Subject:Date:MIME-Version;
        b=J1JupHu1xBJUOOP5dTV2vlIU7qv8tmfSVyGmsksaeSI/0NHf9+wRZsWZPQjTCqPpl
         jlDkGp+/41BCFdfyy8Hr61PC1f/qmriBazUM/f5wNcZL3sZqaJpKYXFW9eBQBRLSRz
         fckffpa9nwacVuCR0YZFBnNk+ObFUyMJ4KqFRONWnXXsf29UqAZ2usA1WIsZkMb72v
         klg2Zi1xbW0ct8mkLmtGtQ4w5e5GW8emmvSrMhxuxTQlPCa4iQfOhEdal1xxzch/x2
         JrwjXNVn5+kwxIByKegeWwjvc8RXXc8ll6pP1NHnmD+tZtm8hZwqCxclbiTFpQeo+k
         FyPTFSCnkSi7w==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

get_definition() prototype has no arguments and this can cause warnings
during building. Let's add void argument to prototype according to its
implementation.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 tools/rpcgen/rpc_parse.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/rpcgen/rpc_parse.h b/tools/rpcgen/rpc_parse.h
index 2afae104..6c134dd8 100644
--- a/tools/rpcgen/rpc_parse.h
+++ b/tools/rpcgen/rpc_parse.h
@@ -153,7 +153,7 @@ struct definition {
 };
 typedef struct definition definition;
 
-definition *get_definition();
+definition *get_definition(void);
 
 
 struct bas_type
-- 
2.20.1

