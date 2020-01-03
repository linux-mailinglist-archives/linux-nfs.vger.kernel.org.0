Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0E9112FE82
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2020 22:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgACV5v (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Jan 2020 16:57:51 -0500
Received: from smtpcmd0997.aruba.it ([62.149.156.97]:38623 "EHLO
        smtpcmd0997.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728687AbgACV5v (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Jan 2020 16:57:51 -0500
Received: from ubuntu.localdomain ([89.164.7.165])
        by smtpcmd09.ad.aruba.it with bizsmtp
        id lxqg2101g3ZeEr501xqie8; Fri, 03 Jan 2020 22:50:43 +0100
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     linux-nfs@vger.kernel.org
Cc:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [nfs-utils PATCH 1/7] rpcgen: rpc_cout: silence unused def parameter
Date:   Fri,  3 Jan 2020 22:50:33 +0100
Message-Id: <20200103215039.27471-2-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200103215039.27471-1-giulio.benetti@benettiengineering.com>
References: <20200103215039.27471-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aruba.it; s=a1;
        t=1578088243; bh=8+hIwXb7lCaAPNVVeeu2ue3i/EAnwhm8pWB2k3aLIvc=;
        h=From:To:Subject:Date:MIME-Version;
        b=eGC4nYXQbGS7oNfLXr0ROZsW6javEAsmdFwGsXuc69WiZZpmn89IZwx1opsMJt6Ne
         DcX5CVch+JGta+NIS/LjPsmoZ64LvhqV/YnrWYuWzopS9VyZQBZZNttvhXWyoLn/HM
         5qLZ6OVxrOffk5/VS5gdOUBwGcMrZAlX34HS5EO5TevldyNGwWvC6Zg+F5S5C7qDVW
         r3Kj8wwLkAVIHC9OgnkCKk9ECqdv91SRA2uWT/W9oprgbDf2huYY7ekIFZQNEtGNzO
         s+kI4WA/8KANqdex+1k2tew1JGprWtaoWyP2IJhmBmwPuOpUKJSGAlOnQJV0j5ZgNW
         y5QlxU5pBaUTA==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In emit_enum() argument def is not used and can cause a warning. So
let's mark it with __attribute__((unused)).

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 tools/rpcgen/rpc_cout.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/rpcgen/rpc_cout.c b/tools/rpcgen/rpc_cout.c
index a61214fd..f806a86a 100644
--- a/tools/rpcgen/rpc_cout.c
+++ b/tools/rpcgen/rpc_cout.c
@@ -53,7 +53,7 @@ static void	print_ifsizeof(char *prefix, char *type);
 static void	print_ifclose(int indent);
 static void	print_ifstat(int indent, char *prefix, char *type, relation rel,
 			char *amax, char *objname, char *name);
-static void	emit_enum(definition *def);
+static void	emit_enum(__attribute__((unused)) definition *def);
 static void	emit_program(definition *def);
 static void	emit_union(definition *def);
 static void	emit_struct(definition *def);
@@ -286,7 +286,7 @@ print_ifstat(int indent, char *prefix, char *type, relation rel,
 }
 
 static void
-emit_enum(definition *def)
+emit_enum(__attribute__((unused)) definition *def)
 {
 	print_ifopen(1, "enum");
 	print_ifarg("(enum_t *)objp");
-- 
2.20.1

