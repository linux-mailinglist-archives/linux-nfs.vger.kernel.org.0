Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7DE2A3BFA
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2019 18:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbfH3Q10 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Aug 2019 12:27:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53052 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728181AbfH3Q1Z (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 30 Aug 2019 12:27:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 662D93090FCC
        for <linux-nfs@vger.kernel.org>; Fri, 30 Aug 2019 16:27:25 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-121-35.rdu2.redhat.com [10.10.121.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3775A5C207;
        Fri, 30 Aug 2019 16:27:25 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 953E920A3B; Fri, 30 Aug 2019 12:27:24 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH v2 1/4] nfsdcld: add a "GetVersion" upcall
Date:   Fri, 30 Aug 2019 12:27:21 -0400
Message-Id: <20190830162724.13862-2-smayhew@redhat.com>
In-Reply-To: <20190830162724.13862-1-smayhew@redhat.com>
References: <20190830162724.13862-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 30 Aug 2019 16:27:25 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add a "GetVersion" upcall to allow the kernel to determine the maximum
upcall version that nfsdcld supports.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 support/include/cld.h        | 11 ++++++++-
 utils/nfsdcld/cld-internal.h |  4 ++-
 utils/nfsdcld/nfsdcld.c      | 47 ++++++++++++++++++++++++++++++------
 utils/nfsdcld/sqlite.c       |  2 +-
 4 files changed, 53 insertions(+), 11 deletions(-)

diff --git a/support/include/cld.h b/support/include/cld.h
index c1f5b70..00a40da 100644
--- a/support/include/cld.h
+++ b/support/include/cld.h
@@ -33,7 +33,8 @@ enum cld_command {
 	Cld_Remove,		/* remove record of this cm_id */
 	Cld_Check,		/* is this cm_id allowed? */
 	Cld_GraceDone,		/* grace period is complete */
-	Cld_GraceStart,
+	Cld_GraceStart,		/* grace start (upload client records) */
+	Cld_GetVersion,		/* query max supported upcall version */
 };
 
 /* representation of long-form NFSv4 client ID */
@@ -51,7 +52,15 @@ struct cld_msg {
 	union {
 		int64_t		cm_gracetime;	/* grace period start time */
 		struct cld_name	cm_name;
+		uint8_t		cm_version;	/* for getting max version */
 	} __attribute__((packed)) cm_u;
 } __attribute__((packed));
 
+struct cld_msg_hdr {
+	uint8_t		cm_vers;		/* upcall version */
+	uint8_t		cm_cmd;			/* upcall command */
+	int16_t		cm_status;		/* return code */
+	uint32_t	cm_xid;			/* transaction id */
+} __attribute__((packed));
+
 #endif /* !_NFSD_CLD_H */
diff --git a/utils/nfsdcld/cld-internal.h b/utils/nfsdcld/cld-internal.h
index 76e97db..f33cb04 100644
--- a/utils/nfsdcld/cld-internal.h
+++ b/utils/nfsdcld/cld-internal.h
@@ -21,7 +21,9 @@
 struct cld_client {
 	int			cl_fd;
 	struct event		cl_event;
-	struct cld_msg	cl_msg;
+	union {
+		struct cld_msg	cl_msg;
+	} cl_u;
 };
 
 uint64_t current_epoch;
diff --git a/utils/nfsdcld/nfsdcld.c b/utils/nfsdcld/nfsdcld.c
index cbf71fc..aa5594b 100644
--- a/utils/nfsdcld/nfsdcld.c
+++ b/utils/nfsdcld/nfsdcld.c
@@ -343,7 +343,7 @@ cld_not_implemented(struct cld_client *clnt)
 {
 	int ret;
 	ssize_t bsize, wsize;
-	struct cld_msg *cmsg = &clnt->cl_msg;
+	struct cld_msg *cmsg = &clnt->cl_u.cl_msg;
 
 	xlog(D_GENERAL, "%s: downcalling with not implemented error", __func__);
 
@@ -365,12 +365,40 @@ cld_not_implemented(struct cld_client *clnt)
 	}
 }
 
+static void
+cld_get_version(struct cld_client *clnt)
+{
+	int ret;
+	ssize_t bsize, wsize;
+	struct cld_msg *cmsg = &clnt->cl_u.cl_msg;
+
+	xlog(D_GENERAL, "%s: version = %u.", __func__, UPCALL_VERSION);
+
+	cmsg->cm_u.cm_version = UPCALL_VERSION;
+	cmsg->cm_status = 0;
+
+	bsize = sizeof(*cmsg);
+
+	xlog(D_GENERAL, "Doing downcall with status %d", cmsg->cm_status);
+	wsize = atomicio((void *)write, clnt->cl_fd, cmsg, bsize);
+	if (wsize != bsize) {
+		xlog(L_ERROR, "%s: problem writing to cld pipe (%ld): %m",
+			 __func__, wsize);
+		ret = cld_pipe_open(clnt);
+		if (ret) {
+			xlog(L_FATAL, "%s: unable to reopen pipe: %d",
+					__func__, ret);
+			exit(ret);
+		}
+	}
+}
+
 static void
 cld_create(struct cld_client *clnt)
 {
 	int ret;
 	ssize_t bsize, wsize;
-	struct cld_msg *cmsg = &clnt->cl_msg;
+	struct cld_msg *cmsg = &clnt->cl_u.cl_msg;
 
 	ret = cld_check_grace_period();
 	if (ret)
@@ -406,7 +434,7 @@ cld_remove(struct cld_client *clnt)
 {
 	int ret;
 	ssize_t bsize, wsize;
-	struct cld_msg *cmsg = &clnt->cl_msg;
+	struct cld_msg *cmsg = &clnt->cl_u.cl_msg;
 
 	ret = cld_check_grace_period();
 	if (ret)
@@ -442,7 +470,7 @@ cld_check(struct cld_client *clnt)
 {
 	int ret;
 	ssize_t bsize, wsize;
-	struct cld_msg *cmsg = &clnt->cl_msg;
+	struct cld_msg *cmsg = &clnt->cl_u.cl_msg;
 
 	/*
 	 * If we get a check upcall at all, it means we're talking to an old
@@ -489,7 +517,7 @@ cld_gracedone(struct cld_client *clnt)
 {
 	int ret;
 	ssize_t bsize, wsize;
-	struct cld_msg *cmsg = &clnt->cl_msg;
+	struct cld_msg *cmsg = &clnt->cl_u.cl_msg;
 
 	/*
 	 * If we got a "gracedone" upcall while we're not in grace, then
@@ -543,7 +571,7 @@ reply:
 static int
 gracestart_callback(struct cld_client *clnt) {
 	ssize_t bsize, wsize;
-	struct cld_msg *cmsg = &clnt->cl_msg;
+	struct cld_msg *cmsg = &clnt->cl_u.cl_msg;
 
 	cmsg->cm_status = -EINPROGRESS;
 
@@ -562,7 +590,7 @@ cld_gracestart(struct cld_client *clnt)
 {
 	int ret;
 	ssize_t bsize, wsize;
-	struct cld_msg *cmsg = &clnt->cl_msg;
+	struct cld_msg *cmsg = &clnt->cl_u.cl_msg;
 
 	xlog(D_GENERAL, "%s: updating grace epochs", __func__);
 
@@ -598,7 +626,7 @@ cldcb(int UNUSED(fd), short which, void *data)
 {
 	ssize_t len;
 	struct cld_client *clnt = data;
-	struct cld_msg *cmsg = &clnt->cl_msg;
+	struct cld_msg *cmsg = &clnt->cl_u.cl_msg;
 
 	if (which != EV_READ)
 		goto out;
@@ -633,6 +661,9 @@ cldcb(int UNUSED(fd), short which, void *data)
 	case Cld_GraceStart:
 		cld_gracestart(clnt);
 		break;
+	case Cld_GetVersion:
+		cld_get_version(clnt);
+		break;
 	default:
 		xlog(L_WARNING, "%s: command %u is not yet implemented",
 				__func__, cmsg->cm_cmd);
diff --git a/utils/nfsdcld/sqlite.c b/utils/nfsdcld/sqlite.c
index fa81df8..6525fc1 100644
--- a/utils/nfsdcld/sqlite.c
+++ b/utils/nfsdcld/sqlite.c
@@ -1152,7 +1152,7 @@ sqlite_iterate_recovery(int (*cb)(struct cld_client *clnt), struct cld_client *c
 {
 	int ret;
 	sqlite3_stmt *stmt = NULL;
-	struct cld_msg *cmsg = &clnt->cl_msg;
+	struct cld_msg *cmsg = &clnt->cl_u.cl_msg;
 
 	if (recovery_epoch == 0) {
 		xlog(D_GENERAL, "%s: not in grace!", __func__);
-- 
2.17.2

