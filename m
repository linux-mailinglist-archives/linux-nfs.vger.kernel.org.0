Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09C5B12FE80
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2020 22:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbgACV5u (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Jan 2020 16:57:50 -0500
Received: from smtpcmd0997.aruba.it ([62.149.156.97]:36892 "EHLO
        smtpcmd0997.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728645AbgACV5t (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Jan 2020 16:57:49 -0500
Received: from ubuntu.localdomain ([89.164.7.165])
        by smtpcmd09.ad.aruba.it with bizsmtp
        id lxqg2101g3ZeEr501xqkeJ; Fri, 03 Jan 2020 22:50:44 +0100
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     linux-nfs@vger.kernel.org
Cc:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [nfs-utils PATCH 3/7] rpcgen: rpc_util: add findval args to prototype
Date:   Fri,  3 Jan 2020 22:50:35 +0100
Message-Id: <20200103215039.27471-4-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200103215039.27471-1-giulio.benetti@benettiengineering.com>
References: <20200103215039.27471-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aruba.it; s=a1;
        t=1578088244; bh=LndOWQbqWbE+/mh+Q/OA/ILl2X9Qt+5deLE0twnuW1o=;
        h=From:To:Subject:Date:MIME-Version;
        b=kaeyVWbu1lhrtBeO+Gu44xTuz+179ny+G2CqOZ1rlfTMqkh4UzOcz7GqN+5YDi6rX
         BIJ3K0WqnC5+ykj6Ttttkakj+BpnLycNZ0qziaaaNdxmwUcj+mjwuppnCYXhekG34O
         3GBwnYsetDqWFt7d2KfvowcL52wF3P1vvaVdQmh4wCLihfgl3GUIokLgJuEXe3Er6C
         Dkjm59s9Kd2+oU7DHi6Z66Mk3eYi1a71VdglDNEhI/+pIw75qBG41aARwPHVsOWR/p
         4NU0Df6hKnCdf0v5rV4dLQQaLRFEDeaMczykHEv+Mirq7+h3AiiE7em8PEPLtI9izo
         EIhA3WdXrQVng==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

findval() prototype has no arguments and this can cause warnings during
building. Let's add its arguments to prototype according to its
implementation.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 tools/rpcgen/rpc_util.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/rpcgen/rpc_util.h b/tools/rpcgen/rpc_util.h
index bd7b15ca..97b87f2b 100644
--- a/tools/rpcgen/rpc_util.h
+++ b/tools/rpcgen/rpc_util.h
@@ -96,7 +96,7 @@ void storeval(list **, definition *);
 #define STOREVAL(list,item)	\
 	storeval(list,item)
 
-definition *findval();
+definition *findval(list *, char *, int (*)(definition *, char *));
 
 #define FINDVAL(list,item,finder) \
 	findval(list, item, finder)
-- 
2.20.1

