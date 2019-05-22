Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E382269BD
	for <lists+linux-nfs@lfdr.de>; Wed, 22 May 2019 20:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbfEVSTk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 May 2019 14:19:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32984 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729003AbfEVSTk (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 22 May 2019 14:19:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E4DB959463
        for <linux-nfs@vger.kernel.org>; Wed, 22 May 2019 18:19:39 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (madhat.boston.devel.redhat.com [10.19.60.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A136A4E6D7
        for <linux-nfs@vger.kernel.org>; Wed, 22 May 2019 18:19:39 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] sqlite.c: Use PRIx64 macro to print 64-bit integers
Date:   Wed, 22 May 2019 14:19:36 -0400
Message-Id: <20190522181936.6017-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 22 May 2019 18:19:39 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 32 bit machines, using "%016lx" format throws out
an format error due to the -Werror=format=2
compiler option. On 64 bit machines using that
format is correct.

So use the PRIx64 macro to have the correct
format defined on the different machines.

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 utils/nfsdcld/sqlite.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/utils/nfsdcld/sqlite.c b/utils/nfsdcld/sqlite.c
index faa62f9..cd658ef 100644
--- a/utils/nfsdcld/sqlite.c
+++ b/utils/nfsdcld/sqlite.c
@@ -59,6 +59,7 @@
 #include <limits.h>
 #include <sqlite3.h>
 #include <linux/limits.h>
+#include <inttypes.h>
 
 #include "xlog.h"
 #include "sqlite.h"
@@ -535,7 +536,7 @@ sqlite_copy_cltrack_records(int *num_rec)
 		xlog(L_ERROR, "Unable to begin transaction: %s", err);
 		goto rollback;
 	}
-	ret = snprintf(buf, sizeof(buf), "DELETE FROM \"rec-%016lx\";",
+	ret = snprintf(buf, sizeof(buf), "DELETE FROM \"rec-%" PRIx64 "\";",
 			current_epoch);
 	if (ret < 0) {
 		xlog(L_ERROR, "sprintf failed!");
@@ -550,7 +551,7 @@ sqlite_copy_cltrack_records(int *num_rec)
 		xlog(L_ERROR, "Unable to clear records from current epoch: %s", err);
 		goto rollback;
 	}
-	ret = snprintf(buf, sizeof(buf), "INSERT INTO \"rec-%016lx\" "
+	ret = snprintf(buf, sizeof(buf), "INSERT INTO \"rec-%" PRIx64 "\" "
 				"SELECT id FROM attached.clients;",
 				current_epoch);
 	if (ret < 0) {
@@ -703,7 +704,7 @@ sqlite_insert_client(const unsigned char *clname, const size_t namelen)
 	int ret;
 	sqlite3_stmt *stmt = NULL;
 
-	ret = snprintf(buf, sizeof(buf), "INSERT OR REPLACE INTO \"rec-%016lx\" "
+	ret = snprintf(buf, sizeof(buf), "INSERT OR REPLACE INTO \"rec-%" PRIx64 "\" "
 				"VALUES (?);", current_epoch);
 	if (ret < 0) {
 		xlog(L_ERROR, "sprintf failed!");
@@ -748,7 +749,7 @@ sqlite_remove_client(const unsigned char *clname, const size_t namelen)
 	int ret;
 	sqlite3_stmt *stmt = NULL;
 
-	ret = snprintf(buf, sizeof(buf), "DELETE FROM \"rec-%016lx\" "
+	ret = snprintf(buf, sizeof(buf), "DELETE FROM \"rec-%" PRIx64 "\" "
 				"WHERE id==?;", current_epoch);
 	if (ret < 0) {
 		xlog(L_ERROR, "sprintf failed!");
@@ -798,7 +799,7 @@ sqlite_check_client(const unsigned char *clname, const size_t namelen)
 	int ret;
 	sqlite3_stmt *stmt = NULL;
 
-	ret = snprintf(buf, sizeof(buf), "SELECT count(*) FROM  \"rec-%016lx\" "
+	ret = snprintf(buf, sizeof(buf), "SELECT count(*) FROM  \"rec-%" PRIx64 "\" "
 				"WHERE id==?;", recovery_epoch);
 	if (ret < 0) {
 		xlog(L_ERROR, "sprintf failed!");
@@ -873,7 +874,7 @@ sqlite_grace_start(void)
 		tcur++;
 
 		ret = snprintf(buf, sizeof(buf), "UPDATE grace "
-				"SET current = %ld, recovery = %ld;",
+				"SET current = %" PRId64 ", recovery = %" PRId64 ";",
 				(int64_t)tcur, (int64_t)trec);
 		if (ret < 0) {
 			xlog(L_ERROR, "sprintf failed!");
@@ -891,7 +892,7 @@ sqlite_grace_start(void)
 			goto rollback;
 		}
 
-		ret = snprintf(buf, sizeof(buf), "CREATE TABLE \"rec-%016lx\" "
+		ret = snprintf(buf, sizeof(buf), "CREATE TABLE \"rec-%" PRIx64 "\" "
 				"(id BLOB PRIMARY KEY);",
 				tcur);
 		if (ret < 0) {
@@ -915,7 +916,7 @@ sqlite_grace_start(void)
 		 * values in the grace table, just clear out the records for
 		 * the current reboot epoch.
 		 */
-		ret = snprintf(buf, sizeof(buf), "DELETE FROM \"rec-%016lx\";",
+		ret = snprintf(buf, sizeof(buf), "DELETE FROM \"rec-%" PRIx64 "\";",
 				tcur);
 		if (ret < 0) {
 			xlog(L_ERROR, "sprintf failed!");
@@ -976,7 +977,7 @@ sqlite_grace_done(void)
 		goto rollback;
 	}
 
-	ret = snprintf(buf, sizeof(buf), "DROP TABLE \"rec-%016lx\";",
+	ret = snprintf(buf, sizeof(buf), "DROP TABLE \"rec-%" PRIx64 "\";",
 		recovery_epoch);
 	if (ret < 0) {
 		xlog(L_ERROR, "sprintf failed!");
@@ -1027,7 +1028,7 @@ sqlite_iterate_recovery(int (*cb)(struct cld_client *clnt), struct cld_client *c
 		return -EINVAL;
 	}
 
-	ret = snprintf(buf, sizeof(buf), "SELECT * FROM \"rec-%016lx\";",
+	ret = snprintf(buf, sizeof(buf), "SELECT * FROM \"rec-%" PRIx64 "\";",
 		recovery_epoch);
 	if (ret < 0) {
 		xlog(L_ERROR, "sprintf failed!");
-- 
2.20.1

