Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A02601AD1FF
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2020 23:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgDPVjb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Apr 2020 17:39:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgDPVjb (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 16 Apr 2020 17:39:31 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D0F3221F9;
        Thu, 16 Apr 2020 21:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587073171;
        bh=vT1282yyyejk8G/Ee89lBGCkVNIcKwl2iVRTwWKUBPU=;
        h=From:To:Cc:Subject:Date:From;
        b=C3/WQX6UVxo0XoW/VKUBtcpxEpg+CoCSpe+hB23HwkPKhUqAfFCjq2z6bKFVTeJJW
         ISllS091ZgJ/WSemQZG/jjPOgWw++tC3yp4NW/4zUJKlgNcaJicdi8wb9rKBJrL3vc
         8RjQLzXHCTb/V27pOqRpXfseSz4CV3Um+OJntRGY=
From:   trondmy@kernel.org
To:     Steve Dickson <SteveD@redhat.com>
Cc:     Lance Shelton <lance.shelton@hammerspace.com>,
        linux-nfs@vger.kernel.org
Subject: [PATCH] mountd: Preserve special characters in refer and replica path options
Date:   Thu, 16 Apr 2020 17:37:22 -0400
Message-Id: <20200416213722.80201-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Lance Shelton <lance.shelton@hammerspace.com>

Allow referral paths to contain special character by adding an
escaping mechanism.

Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 support/nfs/exports.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/support/nfs/exports.c b/support/nfs/exports.c
index 8fbb6b15c299..97eb31837816 100644
--- a/support/nfs/exports.c
+++ b/support/nfs/exports.c
@@ -247,23 +247,28 @@ void secinfo_show(FILE *fp, struct exportent *ep)
 	}
 }
 
+static void
+fprintpath(FILE *fp, const char *path)
+{
+	int i;
+	for (i=0; path[i]; i++)
+		if (iscntrl(path[i]) || path[i] == '"' || path[i] == '\\' || path[i] == '#' || isspace(path[i]))
+			fprintf(fp, "\\%03o", path[i]);
+		else
+			fprintf(fp, "%c", path[i]);
+}
+
 void
 putexportent(struct exportent *ep)
 {
 	FILE	*fp;
 	int	*id, i;
-	char	*esc=ep->e_path;
 
 	if (!efp)
 		return;
 
 	fp = efp->x_fp;
-	for (i=0; esc[i]; i++)
-	        if (iscntrl(esc[i]) || esc[i] == '"' || esc[i] == '\\' || esc[i] == '#' || isspace(esc[i]))
-			fprintf(fp, "\\%03o", esc[i]);
-		else
-			fprintf(fp, "%c", esc[i]);
-
+	fprintpath(fp, ep->e_path);
 	fprintf(fp, "\t%s(", ep->e_hostname);
 	fprintf(fp, "%s,", (ep->e_flags & NFSEXP_READONLY)? "ro" : "rw");
 	fprintf(fp, "%ssync,", (ep->e_flags & NFSEXP_ASYNC)? "a" : "");
@@ -302,10 +307,14 @@ putexportent(struct exportent *ep)
 	case FSLOC_NONE:
 		break;
 	case FSLOC_REFER:
-		fprintf(fp, "refer=%s,", ep->e_fslocdata);
+		fprintf(fp, "refer=");
+		fprintpath(fp, ep->e_fslocdata);
+		fprintf(fp, ",");
 		break;
 	case FSLOC_REPLICA:
-		fprintf(fp, "replicas=%s,", ep->e_fslocdata);
+		fprintf(fp, "replicas=");
+		fprintpath(fp, ep->e_fslocdata);
+		fprintf(fp, ",");
 		break;
 #ifdef DEBUG
 	case FSLOC_STUB:
-- 
2.25.2

