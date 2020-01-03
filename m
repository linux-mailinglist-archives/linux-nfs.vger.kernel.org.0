Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B56EC12FE86
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2020 22:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbgACV5y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Jan 2020 16:57:54 -0500
Received: from smtpcmd0997.aruba.it ([62.149.156.97]:60290 "EHLO
        smtpcmd0997.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728721AbgACV5x (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Jan 2020 16:57:53 -0500
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Jan 2020 16:57:48 EST
Received: from ubuntu.localdomain ([89.164.7.165])
        by smtpcmd09.ad.aruba.it with bizsmtp
        id lxqg2101g3ZeEr501xqmeU; Fri, 03 Jan 2020 22:50:46 +0100
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     linux-nfs@vger.kernel.org
Cc:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [nfs-utils PATCH 5/7] rpcgen: rpc_cout: fix potential -Wformat-nonliteral warning
Date:   Fri,  3 Jan 2020 22:50:37 +0100
Message-Id: <20200103215039.27471-6-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200103215039.27471-1-giulio.benetti@benettiengineering.com>
References: <20200103215039.27471-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aruba.it; s=a1;
        t=1578088246; bh=1jMLJeansiaM1gzNPiE3UcK3x2BfjS24fO6axf3XLl8=;
        h=From:To:Subject:Date:MIME-Version;
        b=hYuLg/ESNRPZSphnquikYioS4liuob/oVdKIjXjZse/ohK8Lw2HsFXdDW+4AstGvX
         Q2n+rQwcRrTeDdK5csMZ7nO3fVQQS6uvKFeRvG8EqxZPip9Ud6CqDB4lFBP1utXmOo
         C9J7CW1+7VumvGkNsQ09hknzMujEiEu2ZeFfBJMZ+7JKAZy0R3qobIb33WiLr6EEf0
         FN+6pUZQy4GSnvs/2DZ6ngqnbk41I/tHIT+gZe3iDs+Ap9Pup9Gkg6XKnCwLonkk88
         uS+tcJ1bX0qe2wUlhLdx8EA4Tf/EvPMr61LfMruKyEOAa9mIvbtS3LvmVXOisLHa8v
         R3lq3oQj2h/dg==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

format and vecformat must be declared as "char * const" to be really
treated as constant when building with -Werror=format-nonliteral,
otherwise compiler will consider them subject to change throughout the
function.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 tools/rpcgen/rpc_cout.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/rpcgen/rpc_cout.c b/tools/rpcgen/rpc_cout.c
index f806a86a..df2609c4 100644
--- a/tools/rpcgen/rpc_cout.c
+++ b/tools/rpcgen/rpc_cout.c
@@ -319,8 +319,8 @@ emit_union(definition *def)
   case_list *cl;
   declaration *cs;
   char *object;
-  char *vecformat = "objp->%s_u.%s";
-  char *format = "&objp->%s_u.%s";
+  char * const vecformat = "objp->%s_u.%s";
+  char * const format = "&objp->%s_u.%s";
 
   print_stat(1,&def->def.un.enum_decl);
   f_print(fout, "\tswitch (objp->%s) {\n", def->def.un.enum_decl.name);
-- 
2.20.1

