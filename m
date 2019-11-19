Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF08102FB6
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2019 00:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfKSXJ6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Nov 2019 18:09:58 -0500
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:38043 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725978AbfKSXJ5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Nov 2019 18:09:57 -0500
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <nazard@nazar.ca>)
        id 1iXCd8-0004SY-P6; Tue, 19 Nov 2019 17:09:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=h93OXKw9UP6l7obeWoGjtNQfoXWGsgT7AUNxsd7EKLM=; b=drncYVvzUbXABya1uGz5iMjiTO
        O3M9UuFdL2uFARC2XoKpwNxi2iz3e80lU1w+OMLFrdBy6ucMI3u8AjEYm++2u6Ym99jaErY/Q2RGd
        fsczAYR6gIsD8+tmXS+zachHBqhABPCpLxHLzBwxsjkqBxeVUGuEa82XrT+ueumTIJZLoedM0uZow
        C0FsbSsM88l7etekQ3EzDAD2m0IQ3I4tIi9+02NE3WFS/Wh4gJKYx/zZrcH/IdsNyZB1wDif6QjBH
        R9rbt0eMjMg9U5C+KqC7Yqi26YRi8knO/u9+60mRiRvs4VheSsJfp56dWIxMMVIMFpVCsQbGcwUy2
        FA7oGBIQ==;
Received: from [24.114.55.59] (port=33918 helo=wraith.dragoninc.ca)
        by nyc006.hawkhost.com with esmtpa (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1iXCd8-0001ks-DB; Tue, 19 Nov 2019 18:09:54 -0500
From:   Doug Nazar <nazard@nazar.ca>
To:     linux-nfs@vger.kernel.org
Cc:     Steve Dickson <steved@redhat.com>, Doug Nazar <nazard@nazar.ca>
Subject: [PATCH] nfsdcld: Fix printf format strings on 32bit
Date:   Tue, 19 Nov 2019 18:09:20 -0500
Message-Id: <20191119230920.10994-1-nazard@nazar.ca>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AuthUser: nazard@nazar.ca
X-Originating-IP: 172.96.186.142
X-SpamExperts-Domain: nyc006.hawkhost.com
X-SpamExperts-Username: relay
Authentication-Results: arandomserver.com; auth=pass (login) smtp.auth=relay@nyc006.hawkhost.com
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.02)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0fIjBzH0XxYvWQgWH/ix0mSpSDasLI4SayDByyq9LIhVU8UijYqaTRPN
 KhbnWV5pKkTNWdUk1Ol2OGx3IfrIJKyP9eGNFz9TW9u+Jt8z2T3K5r8HtW+i+zOSEp4G6/nKTh5H
 bSAV/Mx/EYvM1H4+en0AxUtRo2eo7JXmMD/kBY54TX+DNB8zzxX/4FjqtJmb5KeKVzNFf0spXIfv
 M+OoYXMBzS5fPHINUJxVzZg1ZLp9gmsYntIZvASFzmmwEK8xkpmNQB3hWTYq/vzakcc65ZBQkiNC
 3M7Pj/MY9gGLjh/nwB5YOcnLTEWr5QFxf29u2b0ZFs7AIGlqJcSMQo9hh7aOmrbMWhZFkvyjvYIF
 be8tdb9BwqvSI91oKEKHszPrHLIoTCzQ7XvYo5qydvprZHcSCR22vShmebXILNDFNYkR6LCtYz5o
 yWoRpE2M2XALSMDT9ZG0CmXc0v4tKHsUSjuO8OL3MKmWpyx7GTPK+LOWY5R6BpcvGp3jcY/qUcse
 gxHyS9oTCOMgg0kq/x8Q8jegKor5vGLGjUegAaOB9ePyJLFZV2VsWrEXxYzPJvIeyCEnVSsgPP/M
 gqSGMx92qX+/Ib/3gD1xdv4OjYexFN7ik4oYRgdX/aeSLw4ZD+8uTG/yF5Sslr7rjwGaoPhs3lTa
 WCqKeKkWBPM5hMmx+s12kDzLsegeIf5jR5PNTlF6ReCprMAKLZ9Vvl2XZc6+7+zUzX99k5ROK7DU
 2cuVvM4pN2jrzuqNLgr3QpfT+A5/9mbzroJXjH7wQNY/kO3yis9UoFIvD3sIcP1fhJPM6B/8jNfM
 b+ffhI0dLA2KZNu18ZDLMs+LenTcUN4hdMuJYJwxcfxmM3wdGChc6hHRfRowObH2LW6BIAQW76wb
 eBOhgzcKVNeVJ9BXyu9+ceCqThQaHAwskslMOiSjwnYcoQfxx57gE89ByJNnvoZD/j4xXaiZ9OGv
 SyF6jGxmwlE+D33NBz6C+Mu+hGpwr7PBqmKnubcolFl/rX+2ReQklqJDAdqlKemfur/8qYsUn20e
 BeH3y8h6dUrDs43Vm7LtiRHY
X-Report-Abuse-To: spam@se001.arandomserver.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Doug Nazar <nazard@nazar.ca>
---
 utils/nfsdcld/nfsdcld.c | 14 +++++++-------
 utils/nfsdcld/sqlite.c  |  6 +++---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/utils/nfsdcld/nfsdcld.c b/utils/nfsdcld/nfsdcld.c
index b064336d..9297df51 100644
--- a/utils/nfsdcld/nfsdcld.c
+++ b/utils/nfsdcld/nfsdcld.c
@@ -378,7 +378,7 @@ cld_not_implemented(struct cld_client *clnt)
 	bsize = cld_message_size(cmsg);
 	wsize = atomicio((void *)write, clnt->cl_fd, cmsg, bsize);
 	if (wsize != bsize)
-		xlog(L_ERROR, "%s: problem writing to cld pipe (%ld): %m",
+		xlog(L_ERROR, "%s: problem writing to cld pipe (%zd): %m",
 			 __func__, wsize);
 
 	/* reopen pipe, just to be sure */
@@ -409,7 +409,7 @@ cld_get_version(struct cld_client *clnt)
 	xlog(D_GENERAL, "Doing downcall with status %d", cmsg->cm_status);
 	wsize = atomicio((void *)write, clnt->cl_fd, cmsg, bsize);
 	if (wsize != bsize) {
-		xlog(L_ERROR, "%s: problem writing to cld pipe (%ld): %m",
+		xlog(L_ERROR, "%s: problem writing to cld pipe (%zd): %m",
 			 __func__, wsize);
 		ret = cld_pipe_open(clnt);
 		if (ret) {
@@ -459,7 +459,7 @@ reply:
 	xlog(D_GENERAL, "Doing downcall with status %d", cmsg->cm_status);
 	wsize = atomicio((void *)write, clnt->cl_fd, cmsg, bsize);
 	if (wsize != bsize) {
-		xlog(L_ERROR, "%s: problem writing to cld pipe (%ld): %m",
+		xlog(L_ERROR, "%s: problem writing to cld pipe (%zd): %m",
 			 __func__, wsize);
 		ret = cld_pipe_open(clnt);
 		if (ret) {
@@ -498,7 +498,7 @@ reply:
 			cmsg->cm_status);
 	wsize = atomicio((void *)write, clnt->cl_fd, cmsg, bsize);
 	if (wsize != bsize) {
-		xlog(L_ERROR, "%s: problem writing to cld pipe (%ld): %m",
+		xlog(L_ERROR, "%s: problem writing to cld pipe (%zd): %m",
 			 __func__, wsize);
 		ret = cld_pipe_open(clnt);
 		if (ret) {
@@ -548,7 +548,7 @@ reply:
 			cmsg->cm_status);
 	wsize = atomicio((void *)write, clnt->cl_fd, cmsg, bsize);
 	if (wsize != bsize) {
-		xlog(L_ERROR, "%s: problem writing to cld pipe (%ld): %m",
+		xlog(L_ERROR, "%s: problem writing to cld pipe (%zd): %m",
 			 __func__, wsize);
 		ret = cld_pipe_open(clnt);
 		if (ret) {
@@ -607,7 +607,7 @@ reply:
 	xlog(D_GENERAL, "Doing downcall with status %d", cmsg->cm_status);
 	wsize = atomicio((void *)write, clnt->cl_fd, cmsg, bsize);
 	if (wsize != bsize) {
-		xlog(L_ERROR, "%s: problem writing to cld pipe (%ld): %m",
+		xlog(L_ERROR, "%s: problem writing to cld pipe (%zd): %m",
 			 __func__, wsize);
 		ret = cld_pipe_open(clnt);
 		if (ret) {
@@ -667,7 +667,7 @@ reply:
 	xlog(D_GENERAL, "Doing downcall with status %d", cmsg->cm_status);
 	wsize = atomicio((void *)write, clnt->cl_fd, cmsg, bsize);
 	if (wsize != bsize) {
-		xlog(L_ERROR, "%s: problem writing to cld pipe (%ld): %m",
+		xlog(L_ERROR, "%s: problem writing to cld pipe (%zd): %m",
 			 __func__, wsize);
 		ret = cld_pipe_open(clnt);
 		if (ret) {
diff --git a/utils/nfsdcld/sqlite.c b/utils/nfsdcld/sqlite.c
index 23be7971..09518e22 100644
--- a/utils/nfsdcld/sqlite.c
+++ b/utils/nfsdcld/sqlite.c
@@ -512,7 +512,7 @@ sqlite_startup_query_grace(void)
 	current_epoch = tcur;
 	recovery_epoch = trec;
 	ret = 0;
-	xlog(D_GENERAL, "%s: current_epoch=%lu recovery_epoch=%lu",
+	xlog(D_GENERAL, "%s: current_epoch=%"PRIu64" recovery_epoch=%"PRIu64,
 		__func__, current_epoch, recovery_epoch);
 out:
 	sqlite3_finalize(stmt);
@@ -1223,7 +1223,7 @@ sqlite_grace_start(void)
 
 	current_epoch = tcur;
 	recovery_epoch = trec;
-	xlog(D_GENERAL, "%s: current_epoch=%lu recovery_epoch=%lu",
+	xlog(D_GENERAL, "%s: current_epoch=%"PRIu64" recovery_epoch=%"PRIu64,
 		__func__, current_epoch, recovery_epoch);
 
 out:
@@ -1282,7 +1282,7 @@ sqlite_grace_done(void)
 	}
 
 	recovery_epoch = 0;
-	xlog(D_GENERAL, "%s: current_epoch=%lu recovery_epoch=%lu",
+	xlog(D_GENERAL, "%s: current_epoch=%"PRIu64" recovery_epoch=%"PRIu64,
 		__func__, current_epoch, recovery_epoch);
 
 out:
-- 
2.23.0

