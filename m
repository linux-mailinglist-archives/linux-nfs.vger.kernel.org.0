Return-Path: <linux-nfs+bounces-10471-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E712A4F766
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Mar 2025 07:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C338188DF93
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Mar 2025 06:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71B8156F44;
	Wed,  5 Mar 2025 06:45:44 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA0B1EA7F8
	for <linux-nfs@vger.kernel.org>; Wed,  5 Mar 2025 06:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741157144; cv=none; b=jlms6Qjif7KaDqxBW0Zmn0wDxgW92pTtORdZuOzUUx63Szcp+alTJqm89GMyHruTZ/ECJnyOuOF7LIEK2Yrg4207RCuc6/4UE0t4KyzqKLX5PE1pr4aBdj2dlRflkb5KEKC1Lrgh3vJgedCdomlO3Hs+sQZsb1eLcTg2Sse8BpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741157144; c=relaxed/simple;
	bh=8oYKz/ewRr6nzZPNk/FwObgnHQ43xtf+deaFsgsQjiY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tufryp6VGNqkJJCbfGz/bfHv0DW/90nQI5C8KtTRUVMbtKD4nMVnQ4ZqrHgAGZstdMiFUn+1l3XQpWlw9bOyQUdH4uzub9Xfchh6wnjKyST0hOVh67xTTp0/oR6yS+xoyslb/xf2PpMgF3HUIZI1qoFHf2sfvDoF7IlrPwmHBds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Z72yG4KSdz2Dkky;
	Wed,  5 Mar 2025 14:41:26 +0800 (CST)
Received: from kwepemp200004.china.huawei.com (unknown [7.202.195.99])
	by mail.maildlp.com (Postfix) with ESMTPS id 0C27A1400DC;
	Wed,  5 Mar 2025 14:45:39 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemp200004.china.huawei.com
 (7.202.195.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 5 Mar
 2025 14:45:38 +0800
From: zhangjian <zhangjian496@huawei.com>
To: <sorenson@redhat.com>, <s.ikarashi@fujitsu.com>, <jlayton@kernel.org>,
	<steved@redhat.com>, <smayhew@redhat.com>
CC: <lilingfeng3@huawei.com>, <linux-nfs@vger.kernel.org>
Subject: [PATCH V4] nfsdcld: fix cld pipe read size
Date: Thu, 6 Mar 2025 08:00:08 +0800
Message-ID: <20250306000008.721274-1-zhangjian496@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemp200004.china.huawei.com (7.202.195.99)

When nfsd inits failed for detecting cld version in
nfsd4_client_tracking_init, kernel may assume nfsdcld support version 1
message format and try to upcall with v1 message size to nfsdcld.
There exists one error case in the following process, causeing nfsd
hunging for nfsdcld replay:

kernel write to pipe->msgs (v1 msg length)
    |--------- first msg --------|-------- second message -------|

nfsdcld read from pipe->msgs (v2 msg length)
    |------------ first msg --------------|---second message-----|
    |  valid message             | ignore |     wrong message    |

When two nfsd kernel thread add two upcall messages to cld pipe with v1
version cld_msg (size == 1034) concurrently，but nfsdcld reads with v2
version size(size == 1067), 33 bytes of the second message will be read
and merged with first message. The 33 bytes in second message will be
ignored. Nfsdcld will then read 1001 bytes in second message, which cause
FATAL in cld_messaged_size checking. Nfsd kernel thread will hang for
it forever until nfs server restarts.

Signed-off-by: zhangjian <zhangjian496@huawei.com>
Reviewed-by: Scott Mayhew <smayhew@redhat.com>
---
 utils/nfsdcld/nfsdcld.c | 65 ++++++++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 20 deletions(-)

diff --git a/utils/nfsdcld/nfsdcld.c b/utils/nfsdcld/nfsdcld.c
index dbc7a57..f7737d9 100644
--- a/utils/nfsdcld/nfsdcld.c
+++ b/utils/nfsdcld/nfsdcld.c
@@ -716,35 +716,60 @@ reply:
 	}
 }
 
-static void
-cldcb(int UNUSED(fd), short which, void *data)
+static int
+cld_pipe_read_msg(struct cld_client *clnt)
 {
-	ssize_t len;
-	struct cld_client *clnt = data;
-#if UPCALL_VERSION >= 2
-	struct cld_msg_v2 *cmsg = &clnt->cl_u.cl_msg_v2;
-#else
-	struct cld_msg *cmsg = &clnt->cl_u.cl_msg;
-#endif
+	ssize_t len, left_len;
+	ssize_t hdr_len = sizeof(struct cld_msg_hdr);
+	struct cld_msg_hdr *hdr = (struct cld_msg_hdr *)&clnt->cl_u;
 
-	if (which != EV_READ)
-		goto out;
+	len = atomicio(read, clnt->cl_fd, hdr, hdr_len);
 
-	len = atomicio(read, clnt->cl_fd, cmsg, sizeof(*cmsg));
 	if (len <= 0) {
 		xlog(L_ERROR, "%s: pipe read failed: %m", __func__);
-		cld_pipe_open(clnt);
-		goto out;
+		goto fail_read;
 	}
 
-	if (cmsg->cm_vers > UPCALL_VERSION) {
+	switch (hdr->cm_vers) {
+	case 1:
+		left_len = sizeof(struct cld_msg) - hdr_len;
+		break;
+	case 2:
+		left_len = sizeof(struct cld_msg_v2) - hdr_len;
+		break;
+	default:
 		xlog(L_ERROR, "%s: unsupported upcall version: %hu",
-				__func__, cmsg->cm_vers);
-		cld_pipe_open(clnt);
-		goto out;
+			__func__, hdr->cm_vers);
+		goto fail_read;
 	}
 
-	switch(cmsg->cm_cmd) {
+	len = atomicio(read, clnt->cl_fd, hdr + 1, left_len);
+
+	if (len <= 0) {
+		xlog(L_ERROR, "%s: pipe read failed: %m", __func__);
+		goto fail_read;
+	}
+
+	return 0;
+
+fail_read:
+	cld_pipe_open(clnt);
+	return -1;
+}
+
+static void
+cldcb(int UNUSED(fd), short which, void *data)
+{
+	struct cld_client *clnt = data;
+	struct cld_msg_hdr *hdr = (struct cld_msg_hdr *)&clnt->cl_u;
+
+	if (which != EV_READ)
+		goto out;
+
+	if (cld_pipe_read_msg(clnt) < 0)
+		goto out;
+
+	switch (hdr->cm_cmd) {
 	case Cld_Create:
 		cld_create(clnt);
 		break;
@@ -765,7 +790,7 @@ cldcb(int UNUSED(fd), short which, void *data)
 		break;
 	default:
 		xlog(L_WARNING, "%s: command %u is not yet implemented",
-				__func__, cmsg->cm_cmd);
+				__func__, hdr->cm_cmd);
 		cld_not_implemented(clnt);
 	}
 out:
-- 
2.33.0


