Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFCF12FE84
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2020 22:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgACV5x (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Jan 2020 16:57:53 -0500
Received: from smtpcmd0997.aruba.it ([62.149.156.97]:36892 "EHLO
        smtpcmd0997.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728687AbgACV5x (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Jan 2020 16:57:53 -0500
Received: from ubuntu.localdomain ([89.164.7.165])
        by smtpcmd09.ad.aruba.it with bizsmtp
        id lxqg2101g3ZeEr501xqnea; Fri, 03 Jan 2020 22:50:47 +0100
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     linux-nfs@vger.kernel.org
Cc:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [nfs-utils PATCH 6/7] rpcgen: rpc_hout: fix potential -Wformat-security warning
Date:   Fri,  3 Jan 2020 22:50:38 +0100
Message-Id: <20200103215039.27471-7-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200103215039.27471-1-giulio.benetti@benettiengineering.com>
References: <20200103215039.27471-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aruba.it; s=a1;
        t=1578088247; bh=HJCLC7zorNQ4sSP6DKe+6nRgQRhpIZr7UMLE4eDaAyc=;
        h=From:To:Subject:Date:MIME-Version;
        b=h+sPkL+GTOkLwbhpKS9N5fogkeVDzVN+mrHX3yBzcvzhDArkC1Hu2QdRwxod2/iIx
         3bNArfbV+nrSQBS9veQ9NHo49l5j1AFos9+nTVKwvGC5UB9jXTvi9hHiVVHVGwcWCa
         HFalRbEMWizXqgOmJ2Ewm1wAU+idqfJCAWgTYxIgqhBpijm5p2xmxxBTN85wrMZiYz
         EnRC96Ceqw74InqT6IWx7JON4xr8Cm/WZQ0DHswQE0XQlrUTQW8JhF/FDRtdCJ4lz2
         OzSGVabWUUfVHA/gp37a/CEvoIEUtakhWcybctN8w+niqZMdtHzYeE7H0aD+aHyeYo
         RmiknN6jsky5g==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

f_print()'s argument "separator" is not known because it's passed as an
argument and with -Wformat-security will cause a useless warning. Let's
ignore by adding "#pragma GCC diagnostic ignored/warning" before and
after f_print().

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 tools/rpcgen/rpc_hout.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/rpcgen/rpc_hout.c b/tools/rpcgen/rpc_hout.c
index ea1cb24f..999c061f 100644
--- a/tools/rpcgen/rpc_hout.c
+++ b/tools/rpcgen/rpc_hout.c
@@ -467,7 +467,9 @@ pdeclaration(char *name, declaration *dec, int tab, char *separator)
 			break;
 		}
 	}
+#pragma GCC diagnostic ignored "-Wformat-security"
 	f_print(fout, separator );
+#pragma GCC diagnostic warning "-Wformat-security"
 }
 
 static int
-- 
2.20.1

