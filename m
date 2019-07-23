Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7E5A711E1
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jul 2019 08:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbfGWG1Y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Jul 2019 02:27:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41160 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728180AbfGWG1Y (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 23 Jul 2019 02:27:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 207A0356D2;
        Tue, 23 Jul 2019 06:27:24 +0000 (UTC)
Received: from localhost (dhcp-12-152.nay.redhat.com [10.66.12.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8E5A55C28C;
        Tue, 23 Jul 2019 06:27:23 +0000 (UTC)
From:   Yongcheng Yang <yongcheng.yang@gmail.com>
To:     "J . Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org,
        Yongcheng Yang <yongcheng.yang@gmail.com>
Subject: [PATCH 2/2] nfs4_getfacl: revise the Usage format as new options added
Date:   Tue, 23 Jul 2019 14:27:13 +0800
Message-Id: <20190723062713.20570-2-yongcheng.yang@gmail.com>
In-Reply-To: <20190723062713.20570-1-yongcheng.yang@gmail.com>
References: <20190723062713.20570-1-yongcheng.yang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 23 Jul 2019 06:27:24 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Yongcheng Yang <yongcheng.yang@gmail.com>
---
 nfs4_getfacl/nfs4_getfacl.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/nfs4_getfacl/nfs4_getfacl.c b/nfs4_getfacl/nfs4_getfacl.c
index 2f57866..e068095 100644
--- a/nfs4_getfacl/nfs4_getfacl.c
+++ b/nfs4_getfacl/nfs4_getfacl.c
@@ -135,7 +135,16 @@ static void usage(int label)
 {
 	if (label)
 		fprintf(stderr, "%s %s -- get NFSv4 file or directory access control lists.\n", execname, VERSION);
-	fprintf(stderr, "Usage: %s [-R] file ...\n  -H, --more-help\tdisplay ACL format information\n  -h, --help\tdisplay this help text\n  -R --recursive\trecurse into subdirectories\n  -c, --omit-header\tDo not display the comment header (Do not print filename)\n", execname);
+
+	static const char *gfusage = \
+	"Usage: %s [OPTIONS] file ...\n"
+	" .. where OPTIONS is any (or none) of:\n"
+	"   -H, --more-help	 display ACL format information\n"
+	"   -h, --help		 display this help text\n"
+	"   -R, --recursive	 recurse into subdirectories\n"
+	"   -c, --omit-header	 Do not display the comment header (Do not print filename)\n";
+
+	fprintf(stderr, gfusage, execname);
 }
 
 static void more_help()
-- 
2.20.1

