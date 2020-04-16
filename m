Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1C61AD2A2
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Apr 2020 00:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbgDPWPF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Apr 2020 18:15:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729205AbgDPWPE (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 16 Apr 2020 18:15:04 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB8B022202;
        Thu, 16 Apr 2020 22:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587075304;
        bh=TxjuFdblTE83Xqokj0V9LEHx2yuzl+bFcMMPFlaotck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MzPrOadT3SnE/NcE+lUyA7xCwtwrGCg+R3HLk793mYyy3IEwspcHvR2cbmplhwe5f
         P/vhcKkofK4qNNqs6QixRJqOhaQZdN8KC9ebZ8Fsjx54wtgow3xiqC0k44GatnA6Rp
         0w8SvSGUOqjkoGNFAlIw6lToaxMW5ciymCWgVLns=
From:   trondmy@kernel.org
To:     Steve Dickson <SteveD@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 7/7] mountd: Check the stat() return values in match_fsid()
Date:   Thu, 16 Apr 2020 18:12:52 -0400
Message-Id: <20200416221252.82102-8-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200416221252.82102-7-trondmy@kernel.org>
References: <20200416221252.82102-1-trondmy@kernel.org>
 <20200416221252.82102-2-trondmy@kernel.org>
 <20200416221252.82102-3-trondmy@kernel.org>
 <20200416221252.82102-4-trondmy@kernel.org>
 <20200416221252.82102-5-trondmy@kernel.org>
 <20200416221252.82102-6-trondmy@kernel.org>
 <20200416221252.82102-7-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Propagate errors from the stat() calls in match_fsid() so that the
caller can be more careful about how they are handled.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 utils/mountd/cache.c | 45 +++++++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/utils/mountd/cache.c b/utils/mountd/cache.c
index 79d3ee085a90..6cba2883026f 100644
--- a/utils/mountd/cache.c
+++ b/utils/mountd/cache.c
@@ -659,55 +659,66 @@ static int parse_fsid(int fsidtype, int fsidlen, char *fsid,
 	return 0;
 }
 
-static bool match_fsid(struct parsed_fsid *parsed, nfs_export *exp, char *path)
+static int match_fsid(struct parsed_fsid *parsed, nfs_export *exp, char *path)
 {
 	struct stat stb;
 	int type;
 	char u[16];
 
 	if (nfsd_path_stat(path, &stb) != 0)
-		return false;
+		goto path_error;
 	if (!S_ISDIR(stb.st_mode) && !S_ISREG(stb.st_mode))
-		return false;
+		goto nomatch;
 
 	switch (parsed->fsidtype) {
 	case FSID_DEV:
 	case FSID_MAJOR_MINOR:
 	case FSID_ENCODE_DEV:
 		if (stb.st_ino != parsed->inode)
-			return false;
+			goto nomatch;
 		if (parsed->major != major(stb.st_dev) ||
 		    parsed->minor != minor(stb.st_dev))
-			return false;
-		return true;
+			goto nomatch;
+		goto match;
 	case FSID_NUM:
 		if (((exp->m_export.e_flags & NFSEXP_FSID) == 0 ||
 		     exp->m_export.e_fsid != parsed->fsidnum))
-			return false;
-		return true;
+			goto nomatch;
+		goto match;
 	case FSID_UUID4_INUM:
 	case FSID_UUID16_INUM:
 		if (stb.st_ino != parsed->inode)
-			return false;
+			goto nomatch;
 		goto check_uuid;
 	case FSID_UUID8:
 	case FSID_UUID16:
-		if (!is_mountpoint(path))
-			return false;
+		errno = 0;
+		if (!is_mountpoint(path)) {
+			if (!errno)
+				goto nomatch;
+			goto path_error;
+		}
 	check_uuid:
 		if (exp->m_export.e_uuid) {
 			get_uuid(exp->m_export.e_uuid, parsed->uuidlen, u);
 			if (memcmp(u, parsed->fhuuid, parsed->uuidlen) == 0)
-				return true;
+				goto match;
 		}
 		else
 			for (type = 0;
 			     uuid_by_path(path, type, parsed->uuidlen, u);
 			     type++)
 				if (memcmp(u, parsed->fhuuid, parsed->uuidlen) == 0)
-					return true;
+					goto match;
 	}
-	return false;
+nomatch:
+	return 0;
+match:
+	return 1;
+path_error:
+	if (path_lookup_error(errno))
+		goto nomatch;
+	return -1;
 }
 
 static struct addrinfo *lookup_client_addr(char *dom)
@@ -815,8 +826,12 @@ static void nfsd_fh(int f)
 					   exp->m_export.e_path))
 				dev_missing ++;
 
-			if (!match_fsid(&parsed, exp, path))
+			switch(match_fsid(&parsed, exp, path)) {
+			case 0:
 				continue;
+			case -1:
+				goto out;
+			}
 			if (is_ipaddr_client(dom)
 					&& !ipaddr_client_matches(exp, ai))
 				continue;
-- 
2.25.2

