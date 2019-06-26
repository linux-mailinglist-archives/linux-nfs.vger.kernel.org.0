Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49BAE57143
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2019 21:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfFZTEh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Jun 2019 15:04:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42310 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfFZTEh (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 26 Jun 2019 15:04:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 77FB2223879
        for <linux-nfs@vger.kernel.org>; Wed, 26 Jun 2019 19:04:36 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-122-53.rdu2.redhat.com [10.10.122.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48EDC600CC;
        Wed, 26 Jun 2019 19:04:36 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id E4EEB20435; Wed, 26 Jun 2019 15:04:32 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH 2/2] sqlite.c: Add a simple database health check
Date:   Wed, 26 Jun 2019 15:04:32 -0400
Message-Id: <20190626190432.16257-2-smayhew@redhat.com>
In-Reply-To: <20190626190432.16257-1-smayhew@redhat.com>
References: <20190626190432.16257-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 26 Jun 2019 19:04:36 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Commit a8133e1fd1742 removed the zero-padding from the table names and
broke grace period handling.  Add a simple health check for the database
to try to detect and fix these.  Other checks could be added in the
future if the database schema changes.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 utils/nfsdcld/sqlite.c | 131 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/utils/nfsdcld/sqlite.c b/utils/nfsdcld/sqlite.c
index 5d78d24..fa81df8 100644
--- a/utils/nfsdcld/sqlite.c
+++ b/utils/nfsdcld/sqlite.c
@@ -67,6 +67,7 @@
 #include "cld-internal.h"
 #include "conffile.h"
 #include "legacy.h"
+#include "nfslib.h"
 
 #define CLD_SQLITE_LATEST_SCHEMA_VERSION 3
 #define CLTRACK_DEFAULT_STORAGEDIR NFS_STATEDIR "/nfsdcltrack"
@@ -448,6 +449,129 @@ out:
 	return ret;
 }
 
+/*
+ * Helper for renaming a recovery table to fix the padding.
+ */
+static int
+sqlite_fix_table_name(const char *name)
+{
+	int ret;
+	uint64_t val;
+	char *err;
+
+	if (sscanf(name, "rec-%" PRIx64, &val) != 1)
+		return -EINVAL;
+	ret = snprintf(buf, sizeof(buf), "ALTER TABLE \"%s\" "
+			"RENAME TO \"rec-%016" PRIx64 "\";",
+			name, val);
+	if (ret < 0) {
+		xlog(L_ERROR, "sprintf failed!");
+		return -EINVAL;
+	} else if ((size_t)ret >= sizeof(buf)) {
+		xlog(L_ERROR, "sprintf output too long! (%d chars)", ret);
+		return -EINVAL;
+	}
+	ret = sqlite3_exec(dbh, (const char *)buf, NULL, NULL, &err);
+	if (ret != SQLITE_OK) {
+		xlog(L_ERROR, "Unable to fix table for epoch %d: %s",
+		     val, err);
+		goto out;
+	}
+	xlog(D_GENERAL, "Renamed table %s to rec-%016" PRIx64, name, val);
+out:
+	sqlite3_free(err);
+	return ret;
+}
+
+/*
+ * Callback for the sqlite_exec statement in sqlite_check_table_names.
+ * If the epoch encoded in the table name matches either the current
+ * epoch or the recovery epoch, then try to fix the padding.  Otherwise,
+ * we bail.
+ */
+static int
+sqlite_check_table_names_cb(void *UNUSED(arg), int ncols, char **cols,
+			    char **UNUSED(colnames))
+{
+	int ret = SQLITE_OK;
+	uint64_t val;
+
+	if (ncols > 1)
+		return -EINVAL;
+	if (sscanf(cols[0], "rec-%" PRIx64, &val) != 1)
+		return -EINVAL;
+	if (val == current_epoch || val == recovery_epoch) {
+		xlog(D_GENERAL, "found invalid table name %s for %s epoch",
+		     cols[0], val == current_epoch ? "current" : "recovery");
+		ret = sqlite_fix_table_name(cols[0]);
+	} else {
+		xlog(L_ERROR, "found invalid table name %s for unknown epoch %"
+		     PRId64, cols[0], val);
+		return -EINVAL;
+	}
+	return ret;
+}
+
+/*
+ * Look for recovery table names where the epoch isn't zero-padded
+ */
+static int
+sqlite_check_table_names(void)
+{
+	int ret;
+	char *err;
+
+	ret = sqlite3_exec(dbh, "SELECT name FROM sqlite_master "
+			   "WHERE type=\"table\" AND name LIKE \"%rec-%\" "
+			   "AND length(name) < 20;",
+			   sqlite_check_table_names_cb, NULL, &err);
+	if (ret != SQLITE_OK) {
+		xlog(L_ERROR, "Table names check failed: %s", err);
+	}
+	sqlite3_free(err);
+	return ret;
+}
+
+/*
+ * Simple db health check.  For now we're just making sure that the recovery
+ * table names are of the format "rec-CCCCCCCCCCCCCCCC" (where C is the hex
+ * representation of the epoch value) and that epoch value matches either
+ * the current epoch or the recovery epoch.
+ */
+static int
+sqlite_check_db_health(void)
+{
+	int ret, ret2;
+	char *err;
+
+	ret = sqlite3_exec(dbh, "BEGIN EXCLUSIVE TRANSACTION;", NULL, NULL,
+				&err);
+	if (ret != SQLITE_OK) {
+		xlog(L_ERROR, "Unable to begin transaction: %s", err);
+		goto rollback;
+	}
+
+	ret = sqlite_check_table_names();
+	if (ret != SQLITE_OK)
+		goto rollback;
+
+	ret = sqlite3_exec(dbh, "COMMIT TRANSACTION;", NULL, NULL, &err);
+	if (ret != SQLITE_OK) {
+		xlog(L_ERROR, "Unable to commit transaction: %s", err);
+		goto rollback;
+	}
+
+cleanup:
+	sqlite3_free(err);
+	xlog(D_GENERAL, "%s: returning %d", __func__, ret);
+	return ret;
+rollback:
+	ret2 = sqlite3_exec(dbh, "ROLLBACK TRANSACTION;", NULL, NULL, &err);
+	if (ret2 != SQLITE_OK)
+		xlog(L_ERROR, "Unable to rollback transaction: %s", err);
+	goto cleanup;
+}
+
 static int
 sqlite_attach_db(const char *path)
 {
@@ -673,6 +797,13 @@ sqlite_prepare_dbh(const char *topdir)
 	if (ret)
 		goto out_close;
 
+	ret = sqlite_check_db_health();
+	if (ret) {
+		xlog(L_ERROR, "Database health check failed! "
+			"Database must be fixed manually.");
+		goto out_close;
+	}
+
 	/* one-time "upgrade" from older client tracking methods */
 	if (first_time) {
 		sqlite_copy_cltrack_records(&num_cltrack_records);
-- 
2.17.2

