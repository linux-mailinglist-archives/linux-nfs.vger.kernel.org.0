Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C889A3BFB
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2019 18:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbfH3Q10 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Aug 2019 12:27:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48956 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728173AbfH3Q1Z (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 30 Aug 2019 12:27:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 39D1AA36EE1
        for <linux-nfs@vger.kernel.org>; Fri, 30 Aug 2019 16:27:25 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-121-35.rdu2.redhat.com [10.10.121.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F015D5C1D4;
        Fri, 30 Aug 2019 16:27:24 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id A281920AC8; Fri, 30 Aug 2019 12:27:24 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH v2 2/4] nfsdcld: add support for upcall version 2
Date:   Fri, 30 Aug 2019 12:27:22 -0400
Message-Id: <20190830162724.13862-3-smayhew@redhat.com>
In-Reply-To: <20190830162724.13862-1-smayhew@redhat.com>
References: <20190830162724.13862-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Fri, 30 Aug 2019 16:27:25 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Version 2 upcalls will allow the nfsd to include the kerberos principal
string (actually the first 1024 bytes of it) in the Cld_Create upcall.
If present, the principal will be stored along with the client id string
in the database, and will be included in the Cld_GraceStart downcall
whenever nfsd restarts.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 support/include/cld.h        |  26 +++-
 utils/nfsdcld/cld-internal.h |  11 +-
 utils/nfsdcld/nfsdcld.c      |  97 +++++++++++---
 utils/nfsdcld/sqlite.c       | 236 +++++++++++++++++++++++++++++------
 utils/nfsdcld/sqlite.h       |   2 +
 5 files changed, 316 insertions(+), 56 deletions(-)

diff --git a/support/include/cld.h b/support/include/cld.h
index 00a40da..c58efda 100644
--- a/support/include/cld.h
+++ b/support/include/cld.h
@@ -23,7 +23,7 @@
 #define _NFSD_CLD_H
 
 /* latest upcall version available */
-#define CLD_UPCALL_VERSION 1
+#define CLD_UPCALL_VERSION 2
 
 /* defined by RFC3530 */
 #define NFS4_OPAQUE_LIMIT 1024
@@ -43,6 +43,17 @@ struct cld_name {
 	unsigned char	cn_id[NFS4_OPAQUE_LIMIT];	/* client-provided */
 } __attribute__((packed));
 
+/* principal of the form servicetype@hostname */
+struct cld_principal {
+	uint16_t	cp_len;				/* length of cp_data */
+	unsigned char	cp_data[NFS4_OPAQUE_LIMIT];	/* princ from cred */
+} __attribute__((packed));
+
+struct cld_clntinfo {
+	struct cld_name		cc_name;
+	struct cld_principal	cc_principal;
+} __attribute__((packed));
+
 /* message struct for communication with userspace */
 struct cld_msg {
 	uint8_t		cm_vers;		/* upcall version */
@@ -56,6 +67,19 @@ struct cld_msg {
 	} __attribute__((packed)) cm_u;
 } __attribute__((packed));
 
+/* version 2 message includes the principal */
+struct cld_msg_v2 {
+	uint8_t		cm_vers;		/* upcall version */
+	uint8_t		cm_cmd;			/* upcall command */
+	int16_t		cm_status;		/* return code */
+	uint32_t	cm_xid;			/* transaction id */
+	union {
+		struct cld_name	cm_name;
+		uint8_t		cm_version;	/* for getting max version */
+		struct cld_clntinfo cm_clntinfo; /* name & princ */
+	} __attribute__((packed)) cm_u;
+} __attribute__((packed));
+
 struct cld_msg_hdr {
 	uint8_t		cm_vers;		/* upcall version */
 	uint8_t		cm_cmd;			/* upcall command */
diff --git a/utils/nfsdcld/cld-internal.h b/utils/nfsdcld/cld-internal.h
index f33cb04..05f01be 100644
--- a/utils/nfsdcld/cld-internal.h
+++ b/utils/nfsdcld/cld-internal.h
@@ -18,11 +18,20 @@
 #ifndef _CLD_INTERNAL_H_
 #define _CLD_INTERNAL_H_
 
+#if CLD_UPCALL_VERSION >= 2
+#define UPCALL_VERSION		2
+#else
+#define UPCALL_VERSION		1
+#endif
+
 struct cld_client {
 	int			cl_fd;
 	struct event		cl_event;
 	union {
-		struct cld_msg	cl_msg;
+		struct cld_msg		cl_msg;
+#if UPCALL_VERSION >= 2
+		struct cld_msg_v2	cl_msg_v2;
+#endif
 	} cl_u;
 };
 
diff --git a/utils/nfsdcld/nfsdcld.c b/utils/nfsdcld/nfsdcld.c
index aa5594b..07d9ec2 100644
--- a/utils/nfsdcld/nfsdcld.c
+++ b/utils/nfsdcld/nfsdcld.c
@@ -60,8 +60,6 @@
 
 #define NFSD_END_GRACE_FILE "/proc/fs/nfsd/v4_end_grace"
 
-#define UPCALL_VERSION		1
-
 /* private data structures */
 
 /* global variables */
@@ -338,20 +336,46 @@ cld_check_grace_period(void)
 	return ret;
 }
 
+#if UPCALL_VERSION >= 2
+static ssize_t cld_message_size(void *msg)
+{
+	struct cld_msg_hdr *hdr = (struct cld_msg_hdr *)msg;
+
+	switch (hdr->cm_vers) {
+	case 1:
+		return sizeof(struct cld_msg);
+	case 2:
+		return sizeof(struct cld_msg_v2);
+	default:
+		xlog(L_FATAL, "%s invalid upcall version %d", __func__,
+		     hdr->cm_vers);
+		exit(-EINVAL);
+	}
+}
+#else
+static ssize_t cld_message_size(void *UNUSED(msg))
+{
+	return sizeof(struct cld_msg);
+}
+#endif
+
 static void
 cld_not_implemented(struct cld_client *clnt)
 {
 	int ret;
 	ssize_t bsize, wsize;
+#if UPCALL_VERSION >= 2
+	struct cld_msg_v2 *cmsg = &clnt->cl_u.cl_msg_v2;
+#else
 	struct cld_msg *cmsg = &clnt->cl_u.cl_msg;
+#endif
 
 	xlog(D_GENERAL, "%s: downcalling with not implemented error", __func__);
 
 	/* set up reply */
 	cmsg->cm_status = -EOPNOTSUPP;
 
-	bsize = sizeof(*cmsg);
-
+	bsize = cld_message_size(cmsg);
 	wsize = atomicio((void *)write, clnt->cl_fd, cmsg, bsize);
 	if (wsize != bsize)
 		xlog(L_ERROR, "%s: problem writing to cld pipe (%ld): %m",
@@ -370,15 +394,18 @@ cld_get_version(struct cld_client *clnt)
 {
 	int ret;
 	ssize_t bsize, wsize;
+#if UPCALL_VERSION >= 2
+	struct cld_msg_v2 *cmsg = &clnt->cl_u.cl_msg_v2;
+#else
 	struct cld_msg *cmsg = &clnt->cl_u.cl_msg;
+#endif
 
 	xlog(D_GENERAL, "%s: version = %u.", __func__, UPCALL_VERSION);
 
 	cmsg->cm_u.cm_version = UPCALL_VERSION;
 	cmsg->cm_status = 0;
 
-	bsize = sizeof(*cmsg);
-
+	bsize = cld_message_size(cmsg);
 	xlog(D_GENERAL, "Doing downcall with status %d", cmsg->cm_status);
 	wsize = atomicio((void *)write, clnt->cl_fd, cmsg, bsize);
 	if (wsize != bsize) {
@@ -398,7 +425,11 @@ cld_create(struct cld_client *clnt)
 {
 	int ret;
 	ssize_t bsize, wsize;
+#if UPCALL_VERSION >= 2
+	struct cld_msg_v2 *cmsg = &clnt->cl_u.cl_msg_v2;
+#else
 	struct cld_msg *cmsg = &clnt->cl_u.cl_msg;
+#endif
 
 	ret = cld_check_grace_period();
 	if (ret)
@@ -406,15 +437,25 @@ cld_create(struct cld_client *clnt)
 
 	xlog(D_GENERAL, "%s: create client record.", __func__);
 
-
+#if UPCALL_VERSION >= 2
+	if (cmsg->cm_vers >= 2)
+		ret = sqlite_insert_client_and_princ(
+					cmsg->cm_u.cm_clntinfo.cc_name.cn_id,
+					cmsg->cm_u.cm_clntinfo.cc_name.cn_len,
+					cmsg->cm_u.cm_clntinfo.cc_principal.cp_data,
+					cmsg->cm_u.cm_clntinfo.cc_principal.cp_len);
+	else
+		ret = sqlite_insert_client(cmsg->cm_u.cm_name.cn_id,
+					   cmsg->cm_u.cm_name.cn_len);
+#else
 	ret = sqlite_insert_client(cmsg->cm_u.cm_name.cn_id,
 				   cmsg->cm_u.cm_name.cn_len);
+#endif
 
 reply:
 	cmsg->cm_status = ret ? -EREMOTEIO : ret;
 
-	bsize = sizeof(*cmsg);
-
+	bsize = cld_message_size(cmsg);
 	xlog(D_GENERAL, "Doing downcall with status %d", cmsg->cm_status);
 	wsize = atomicio((void *)write, clnt->cl_fd, cmsg, bsize);
 	if (wsize != bsize) {
@@ -434,7 +475,11 @@ cld_remove(struct cld_client *clnt)
 {
 	int ret;
 	ssize_t bsize, wsize;
+#if UPCALL_VERSION >= 2
+	struct cld_msg_v2 *cmsg = &clnt->cl_u.cl_msg_v2;
+#else
 	struct cld_msg *cmsg = &clnt->cl_u.cl_msg;
+#endif
 
 	ret = cld_check_grace_period();
 	if (ret)
@@ -448,8 +493,7 @@ cld_remove(struct cld_client *clnt)
 reply:
 	cmsg->cm_status = ret ? -EREMOTEIO : ret;
 
-	bsize = sizeof(*cmsg);
-
+	bsize = cld_message_size(cmsg);
 	xlog(D_GENERAL, "%s: downcall with status %d", __func__,
 			cmsg->cm_status);
 	wsize = atomicio((void *)write, clnt->cl_fd, cmsg, bsize);
@@ -470,7 +514,11 @@ cld_check(struct cld_client *clnt)
 {
 	int ret;
 	ssize_t bsize, wsize;
+#if UPCALL_VERSION >= 2
+	struct cld_msg_v2 *cmsg = &clnt->cl_u.cl_msg_v2;
+#else
 	struct cld_msg *cmsg = &clnt->cl_u.cl_msg;
+#endif
 
 	/*
 	 * If we get a check upcall at all, it means we're talking to an old
@@ -495,8 +543,7 @@ reply:
 	/* set up reply */
 	cmsg->cm_status = ret ? -EACCES : ret;
 
-	bsize = sizeof(*cmsg);
-
+	bsize = cld_message_size(cmsg);
 	xlog(D_GENERAL, "%s: downcall with status %d", __func__,
 			cmsg->cm_status);
 	wsize = atomicio((void *)write, clnt->cl_fd, cmsg, bsize);
@@ -517,7 +564,11 @@ cld_gracedone(struct cld_client *clnt)
 {
 	int ret;
 	ssize_t bsize, wsize;
+#if UPCALL_VERSION >= 2
+	struct cld_msg_v2 *cmsg = &clnt->cl_u.cl_msg_v2;
+#else
 	struct cld_msg *cmsg = &clnt->cl_u.cl_msg;
+#endif
 
 	/*
 	 * If we got a "gracedone" upcall while we're not in grace, then
@@ -552,8 +603,7 @@ reply:
 	/* set up reply: downcall with 0 status */
 	cmsg->cm_status = ret ? -EREMOTEIO : ret;
 
-	bsize = sizeof(*cmsg);
-
+	bsize = cld_message_size(cmsg);
 	xlog(D_GENERAL, "Doing downcall with status %d", cmsg->cm_status);
 	wsize = atomicio((void *)write, clnt->cl_fd, cmsg, bsize);
 	if (wsize != bsize) {
@@ -571,12 +621,15 @@ reply:
 static int
 gracestart_callback(struct cld_client *clnt) {
 	ssize_t bsize, wsize;
+#if UPCALL_VERSION >= 2
+	struct cld_msg_v2 *cmsg = &clnt->cl_u.cl_msg_v2;
+#else
 	struct cld_msg *cmsg = &clnt->cl_u.cl_msg;
+#endif
 
 	cmsg->cm_status = -EINPROGRESS;
 
-	bsize = sizeof(struct cld_msg);
-
+	bsize = cld_message_size(cmsg);
 	xlog(D_GENERAL, "Sending client %.*s",
 			cmsg->cm_u.cm_name.cn_len, cmsg->cm_u.cm_name.cn_id);
 	wsize = atomicio((void *)write, clnt->cl_fd, cmsg, bsize);
@@ -590,7 +643,11 @@ cld_gracestart(struct cld_client *clnt)
 {
 	int ret;
 	ssize_t bsize, wsize;
+#if UPCALL_VERSION >= 2
+	struct cld_msg_v2 *cmsg = &clnt->cl_u.cl_msg_v2;
+#else
 	struct cld_msg *cmsg = &clnt->cl_u.cl_msg;
+#endif
 
 	xlog(D_GENERAL, "%s: updating grace epochs", __func__);
 
@@ -606,7 +663,7 @@ reply:
 	/* set up reply: downcall with 0 status */
 	cmsg->cm_status = ret ? -EREMOTEIO : ret;
 
-	bsize = sizeof(struct cld_msg);
+	bsize = cld_message_size(cmsg);
 	xlog(D_GENERAL, "Doing downcall with status %d", cmsg->cm_status);
 	wsize = atomicio((void *)write, clnt->cl_fd, cmsg, bsize);
 	if (wsize != bsize) {
@@ -626,7 +683,11 @@ cldcb(int UNUSED(fd), short which, void *data)
 {
 	ssize_t len;
 	struct cld_client *clnt = data;
+#if UPCALL_VERSION >= 2
+	struct cld_msg_v2 *cmsg = &clnt->cl_u.cl_msg_v2;
+#else
 	struct cld_msg *cmsg = &clnt->cl_u.cl_msg;
+#endif
 
 	if (which != EV_READ)
 		goto out;
diff --git a/utils/nfsdcld/sqlite.c b/utils/nfsdcld/sqlite.c
index 6525fc1..2450c9a 100644
--- a/utils/nfsdcld/sqlite.c
+++ b/utils/nfsdcld/sqlite.c
@@ -37,8 +37,9 @@
  *        them in the database.
  *
  * rec-CCCCCCCCCCCCCCCC (where C is the hex representation of the epoch value):
- *        a single "id" column containing a BLOB with the long-form clientid
- *        as sent by the client.
+ *        an "id" column containing a BLOB with the long-form clientid
+ *        as sent by the client, and a "principal" column containing a BLOB
+ *        with the first 1024 bytes of the kerberos principal (if available).
  */
 
 #ifdef HAVE_CONFIG_H
@@ -69,7 +70,7 @@
 #include "legacy.h"
 #include "nfslib.h"
 
-#define CLD_SQLITE_LATEST_SCHEMA_VERSION 3
+#define CLD_SQLITE_LATEST_SCHEMA_VERSION 4
 #define CLTRACK_DEFAULT_STORAGEDIR NFS_STATEDIR "/nfsdcltrack"
 
 /* in milliseconds */
@@ -173,35 +174,56 @@ out:
 }
 
 static int
-sqlite_maindb_update_schema(int oldversion)
+sqlite_add_princ_col_cb(void *UNUSED(arg), int ncols, char **cols,
+			    char **UNUSED(colnames))
 {
-	int ret, ret2;
+	int ret;
 	char *err;
 
-	/* begin transaction */
-	ret = sqlite3_exec(dbh, "BEGIN EXCLUSIVE TRANSACTION;", NULL, NULL,
-				&err);
+	if (ncols > 1)
+		return -EINVAL;
+	ret = snprintf(buf, sizeof(buf), "ALTER TABLE \"%s\" "
+			"ADD COLUMN principal BLOB;", cols[0]);
+	if (ret < 0) {
+		xlog(L_ERROR, "sprintf failed!");
+		return -EINVAL;
+	} else if ((size_t)ret >= sizeof(buf)) {
+		xlog(L_ERROR, "sprintf output too long! (%d chars)", ret);
+		return -EINVAL;
+	}
+	ret = sqlite3_exec(dbh, (const char *)buf, NULL, NULL, &err);
 	if (ret != SQLITE_OK) {
-		xlog(L_ERROR, "Unable to begin transaction: %s", err);
-		goto rollback;
+		xlog(L_ERROR, "Unable to add principal column to table %s: %s",
+		     cols[0], err);
+		goto out;
 	}
+	xlog(D_GENERAL, "Added principal column to table %s", cols[0]);
+out:
+	sqlite3_free(err);
+	return ret;
+}
 
-	/*
-	 * Check schema version again. This time, under an exclusive
-	 * transaction to guard against racing DB setup attempts
-	 */
-	ret = sqlite_query_schema_version();
-	if (ret != oldversion) {
-		if (ret == CLD_SQLITE_LATEST_SCHEMA_VERSION)
-			/* Someone else raced in and set it up */
-			ret = 0;
-		else
-			/* Something went wrong -- fail! */
-			ret = -EINVAL;
-		goto rollback;
+static int
+sqlite_maindb_update_v3_to_v4(void)
+{
+	int ret;
+	char *err;
+
+	ret = sqlite3_exec(dbh, "SELECT name FROM sqlite_master "
+			   "WHERE type=\"table\" AND name LIKE \"%rec-%\";",
+			   sqlite_add_princ_col_cb, NULL, &err);
+	if (ret != SQLITE_OK) {
+		xlog(L_ERROR, "%s: Failed to update tables!: %s", __func__, err);
 	}
+	sqlite3_free(err);
+	return ret;
+}
 
-	/* Still at old version -- do conversion */
+static int
+sqlite_maindb_update_v1v2_to_v4(void)
+{
+	int ret;
+	char *err;
 
 	/* create grace table */
 	ret = sqlite3_exec(dbh, "CREATE TABLE grace "
@@ -209,7 +231,7 @@ sqlite_maindb_update_schema(int oldversion)
 				NULL, NULL, &err);
 	if (ret != SQLITE_OK) {
 		xlog(L_ERROR, "Unable to create grace table: %s", err);
-		goto rollback;
+		goto out;
 	}
 
 	/* insert initial epochs into grace table */
@@ -218,26 +240,26 @@ sqlite_maindb_update_schema(int oldversion)
 				NULL, NULL, &err);
 	if (ret != SQLITE_OK) {
 		xlog(L_ERROR, "Unable to set initial epochs: %s", err);
-		goto rollback;
+		goto out;
 	}
 
 	/* create recovery table for current epoch */
 	ret = sqlite3_exec(dbh, "CREATE TABLE \"rec-0000000000000001\" "
-				"(id BLOB PRIMARY KEY);",
+				"(id BLOB PRIMARY KEY, principal BLOB);",
 				NULL, NULL, &err);
 	if (ret != SQLITE_OK) {
 		xlog(L_ERROR, "Unable to create recovery table "
 				"for current epoch: %s", err);
-		goto rollback;
+		goto out;
 	}
 
 	/* copy records from old clients table */
-	ret = sqlite3_exec(dbh, "INSERT INTO \"rec-0000000000000001\" "
+	ret = sqlite3_exec(dbh, "INSERT INTO \"rec-0000000000000001\" (id) "
 				"SELECT id FROM clients;",
 				NULL, NULL, &err);
 	if (ret != SQLITE_OK) {
 		xlog(L_ERROR, "Unable to copy client records: %s", err);
-		goto rollback;
+		goto out;
 	}
 
 	/* drop the old clients table */
@@ -245,9 +267,57 @@ sqlite_maindb_update_schema(int oldversion)
 				NULL, NULL, &err);
 	if (ret != SQLITE_OK) {
 		xlog(L_ERROR, "Unable to drop old clients table: %s", err);
+	}
+out:
+	sqlite3_free(err);
+	return ret;
+}
+
+static int
+sqlite_maindb_update_schema(int oldversion)
+{
+	int ret, ret2;
+	char *err;
+
+	/* begin transaction */
+	ret = sqlite3_exec(dbh, "BEGIN EXCLUSIVE TRANSACTION;", NULL, NULL,
+				&err);
+	if (ret != SQLITE_OK) {
+		xlog(L_ERROR, "Unable to begin transaction: %s", err);
+		goto rollback;
+	}
+
+	/*
+	 * Check schema version again. This time, under an exclusive
+	 * transaction to guard against racing DB setup attempts
+	 */
+	ret = sqlite_query_schema_version();
+	if (ret != oldversion) {
+		if (ret == CLD_SQLITE_LATEST_SCHEMA_VERSION)
+			/* Someone else raced in and set it up */
+			ret = 0;
+		else
+			/* Something went wrong -- fail! */
+			ret = -EINVAL;
 		goto rollback;
 	}
 
+	/* Still at old version -- do conversion */
+
+	switch (oldversion) {
+	case 3:
+	case 2:
+		ret = sqlite_maindb_update_v3_to_v4();
+		break;
+	case 1:
+		ret = sqlite_maindb_update_v1v2_to_v4();
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	if (ret != SQLITE_OK)
+		goto rollback;
+
 	ret = snprintf(buf, sizeof(buf), "UPDATE parameters SET value = %d "
 			"WHERE key = \"version\";",
 			CLD_SQLITE_LATEST_SCHEMA_VERSION);
@@ -300,7 +370,7 @@ rollback:
  * transaction. On any error, rollback the transaction.
  */
 static int
-sqlite_maindb_init_v3(void)
+sqlite_maindb_init_v4(void)
 {
 	int ret, ret2;
 	char *err = NULL;
@@ -360,7 +430,7 @@ sqlite_maindb_init_v3(void)
 
 	/* create recovery table for current epoch */
 	ret = sqlite3_exec(dbh, "CREATE TABLE \"rec-0000000000000001\" "
-				"(id BLOB PRIMARY KEY);",
+				"(id BLOB PRIMARY KEY, principal BLOB);",
 				NULL, NULL, &err);
 	if (ret != SQLITE_OK) {
 		xlog(L_ERROR, "Unable to create recovery table "
@@ -675,7 +745,7 @@ sqlite_copy_cltrack_records(int *num_rec)
 		xlog(L_ERROR, "Unable to clear records from current epoch: %s", err);
 		goto rollback;
 	}
-	ret = snprintf(buf, sizeof(buf), "INSERT INTO \"rec-%016" PRIx64 "\" "
+	ret = snprintf(buf, sizeof(buf), "INSERT INTO \"rec-%016" PRIx64 "\" (id) "
 				"SELECT id FROM attached.clients;",
 				current_epoch);
 	if (ret < 0) {
@@ -763,6 +833,12 @@ sqlite_prepare_dbh(const char *topdir)
 		/* DB is already set up. Do nothing */
 		ret = 0;
 		break;
+	case 3:
+		/* Old DB -- update to new schema */
+		ret = sqlite_maindb_update_schema(3);
+		if (ret)
+			goto out_close;
+		break;
 	case 2:
 		/* Old DB -- update to new schema */
 		ret = sqlite_maindb_update_schema(2);
@@ -778,7 +854,7 @@ sqlite_prepare_dbh(const char *topdir)
 		break;
 	case 0:
 		/* Query failed -- try to set up new DB */
-		ret = sqlite_maindb_init_v3();
+		ret = sqlite_maindb_init_v4();
 		if (ret)
 			goto out_close;
 		break;
@@ -835,7 +911,62 @@ sqlite_insert_client(const unsigned char *clname, const size_t namelen)
 	int ret;
 	sqlite3_stmt *stmt = NULL;
 
-	ret = snprintf(buf, sizeof(buf), "INSERT OR REPLACE INTO \"rec-%016" PRIx64 "\" "
+	ret = snprintf(buf, sizeof(buf), "INSERT OR REPLACE INTO \"rec-%016" PRIx64 "\" (id) "
+				"VALUES (?);", current_epoch);
+	if (ret < 0) {
+		xlog(L_ERROR, "sprintf failed!");
+		return ret;
+	} else if ((size_t)ret >= sizeof(buf)) {
+		xlog(L_ERROR, "sprintf output too long! (%d chars)", ret);
+		return -EINVAL;
+	}
+
+	ret = sqlite3_prepare_v2(dbh, buf, -1, &stmt, NULL);
+	if (ret != SQLITE_OK) {
+		xlog(L_ERROR, "%s: insert statement prepare failed: %s",
+			__func__, sqlite3_errmsg(dbh));
+		return ret;
+	}
+
+	ret = sqlite3_bind_blob(stmt, 1, (const void *)clname, namelen,
+				SQLITE_STATIC);
+	if (ret != SQLITE_OK) {
+		xlog(L_ERROR, "%s: bind blob failed: %s", __func__,
+				sqlite3_errmsg(dbh));
+		goto out_err;
+	}
+
+	ret = sqlite3_step(stmt);
+	if (ret == SQLITE_DONE)
+		ret = SQLITE_OK;
+	else
+		xlog(L_ERROR, "%s: unexpected return code from insert: %s",
+				__func__, sqlite3_errmsg(dbh));
+
+out_err:
+	xlog(D_GENERAL, "%s: returning %d", __func__, ret);
+	sqlite3_finalize(stmt);
+	return ret;
+}
+
+#if UPCALL_VERSION >= 2
+/*
+ * Create a client record including the principal
+ *
+ * Returns a non-zero sqlite error code, or SQLITE_OK (aka 0)
+ */
+int
+sqlite_insert_client_and_princ(const unsigned char *clname, const size_t namelen,
+		const unsigned char *clprinc, const size_t princlen)
+{
+	int ret;
+	sqlite3_stmt *stmt = NULL;
+
+	if (princlen > 0)
+		ret = snprintf(buf, sizeof(buf), "INSERT OR REPLACE INTO \"rec-%016" PRIx64 "\" "
+				"VALUES (?, ?);", current_epoch);
+	else
+		ret = snprintf(buf, sizeof(buf), "INSERT OR REPLACE INTO \"rec-%016" PRIx64 "\" (id) "
 				"VALUES (?);", current_epoch);
 	if (ret < 0) {
 		xlog(L_ERROR, "sprintf failed!");
@@ -860,6 +991,16 @@ sqlite_insert_client(const unsigned char *clname, const size_t namelen)
 		goto out_err;
 	}
 
+	if (princlen > 0) {
+		ret = sqlite3_bind_blob(stmt, 2, (const void *)clprinc, princlen,
+					SQLITE_STATIC);
+		if (ret != SQLITE_OK) {
+			xlog(L_ERROR, "%s: bind blob failed: %s", __func__,
+					sqlite3_errmsg(dbh));
+			goto out_err;
+		}
+	}
+
 	ret = sqlite3_step(stmt);
 	if (ret == SQLITE_DONE)
 		ret = SQLITE_OK;
@@ -872,6 +1013,14 @@ out_err:
 	sqlite3_finalize(stmt);
 	return ret;
 }
+#else
+int
+sqlite_insert_client_and_princ(const unsigned char *clname, const size_t namelen,
+		const unsigned char *clprinc, const size_t princlen)
+{
+	return -EINVAL;
+}
+#endif
 
 /* Remove a client record */
 int
@@ -1024,7 +1173,7 @@ sqlite_grace_start(void)
 		}
 
 		ret = snprintf(buf, sizeof(buf), "CREATE TABLE \"rec-%016" PRIx64 "\" "
-				"(id BLOB PRIMARY KEY);",
+				"(id BLOB PRIMARY KEY, principal blob);",
 				tcur);
 		if (ret < 0) {
 			xlog(L_ERROR, "sprintf failed!");
@@ -1152,7 +1301,11 @@ sqlite_iterate_recovery(int (*cb)(struct cld_client *clnt), struct cld_client *c
 {
 	int ret;
 	sqlite3_stmt *stmt = NULL;
+#if UPCALL_VERSION >= 2
+	struct cld_msg_v2 *cmsg = &clnt->cl_u.cl_msg_v2;
+#else
 	struct cld_msg *cmsg = &clnt->cl_u.cl_msg;
+#endif
 
 	if (recovery_epoch == 0) {
 		xlog(D_GENERAL, "%s: not in grace!", __func__);
@@ -1177,9 +1330,20 @@ sqlite_iterate_recovery(int (*cb)(struct cld_client *clnt), struct cld_client *c
 	}
 
 	while ((ret = sqlite3_step(stmt)) == SQLITE_ROW) {
+#if UPCALL_VERSION >= 2
+		memcpy(&cmsg->cm_u.cm_clntinfo.cc_name.cn_id,
+			sqlite3_column_blob(stmt, 0), NFS4_OPAQUE_LIMIT);
+		cmsg->cm_u.cm_clntinfo.cc_name.cn_len = sqlite3_column_bytes(stmt, 0);
+		if (sqlite3_column_bytes(stmt, 1) > 0) {
+			memcpy(&cmsg->cm_u.cm_clntinfo.cc_principal.cp_data,
+				sqlite3_column_blob(stmt, 1), NFS4_OPAQUE_LIMIT);
+			cmsg->cm_u.cm_clntinfo.cc_principal.cp_len = sqlite3_column_bytes(stmt, 1);
+		}
+#else
 		memcpy(&cmsg->cm_u.cm_name.cn_id, sqlite3_column_blob(stmt, 0),
 			NFS4_OPAQUE_LIMIT);
 		cmsg->cm_u.cm_name.cn_len = sqlite3_column_bytes(stmt, 0);
+#endif
 		cb(clnt);
 	}
 	if (ret == SQLITE_DONE)
diff --git a/utils/nfsdcld/sqlite.h b/utils/nfsdcld/sqlite.h
index 7741382..aa52189 100644
--- a/utils/nfsdcld/sqlite.h
+++ b/utils/nfsdcld/sqlite.h
@@ -24,6 +24,8 @@ struct cld_client;
 
 int sqlite_prepare_dbh(const char *topdir);
 int sqlite_insert_client(const unsigned char *clname, const size_t namelen);
+int sqlite_insert_client_and_princ(const unsigned char *clname, const size_t namelen,
+		const unsigned char *clprinc, const size_t princlen);
 int sqlite_remove_client(const unsigned char *clname, const size_t namelen);
 int sqlite_check_client(const unsigned char *clname, const size_t namelen);
 int sqlite_grace_start(void);
-- 
2.17.2

