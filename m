Return-Path: <linux-nfs+bounces-3543-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2248FB6E3
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jun 2024 17:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C21AC1F220C7
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jun 2024 15:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BA013C827;
	Tue,  4 Jun 2024 15:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGMKRuMq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00570C13B
	for <linux-nfs@vger.kernel.org>; Tue,  4 Jun 2024 15:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717514667; cv=none; b=GGq9xJALnXewA2wDutr5KyBp32HMndCDoVkhCib9r7fpue9H4j0GBgRucYTq/DWUgquBjE/j731RazqyqEOjmdApUYhMXCy59Lk6YI8ZW8aBYWSUW7xb8hEDi4+uuh8h3+HUrvc+SMwTspZSQtiiaqnKzpgwgoRLLBcbeyYmmW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717514667; c=relaxed/simple;
	bh=HK5hthz3f5t2H7oXoqW6cvGHxAY3+5RmnJvJweqf2mc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eECZI6nVyrYEDYsMlRVYWdSJr73vgBCiWnjHa1V+V23WmOIR9xBKPTtrAa56juV+YAkEm6965fwLWXRuh/gMvRj7zaQRKQtnWAW7GvfxkiJaOiCYbMBvEDjj6W76I2Oj7Q6+684Hhe+807GFGBJhPQRzD7gjsMAa+C91k5MfoYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGMKRuMq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2826AC2BBFC;
	Tue,  4 Jun 2024 15:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717514666;
	bh=HK5hthz3f5t2H7oXoqW6cvGHxAY3+5RmnJvJweqf2mc=;
	h=From:To:Cc:Subject:Date:From;
	b=ZGMKRuMqr29OBf+xEX06lMeLK3pP2szC5j0O1H6/q57dFKWzFpTU5tYfmZbqEWGun
	 iOOCUD5WFLyMv/RzE8RFOc+6pf5HSFSccBw96lGUPffVDq5j5Q3UxbJPzaPluH7kru
	 2ex3ZQZLCdjNRcC5uHvX6eH2tmRlK0ohaoTx2BDdMpWbqdt58abaG1P9pj/t0hffh1
	 VQNPwGRCDSdmwruXZ0QXYt1S+P549JwUZQRmYEa6PhZr82a60rbGXBOWPKaxO2alwQ
	 JR1E9FBk7tvCFey++zuO61TlomdaRXygvWr/niHdvhb7mi4tyDfLKCqw93uS6nQwDb
	 ecvmINXKW6f6A==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [RFC PATCH] NFSD: Fix nfsdcld warning
Date: Tue,  4 Jun 2024 11:24:00 -0400
Message-ID: <20240604152359.8662-2-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1806; i=chuck.lever@oracle.com; h=from:subject; bh=hLIhx0zIMsb3afdDWrC9oxonITQl2RV1JLT6HPKJkZM=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmXzGQDqyO5n4wT/x/dL/3atGlKOO80KP3ShT+c 4enouCLDQCJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZl8xkAAKCRAzarMzb2Z/ lxViEAC2NcjAhmMDrklHDJJVBb4v8QzsDOxuJ6tvksef8eYJ5u1iHlZshmPeNrGtvS2ydRRZWR7 S+kAT1XCwc2ctX/D5974eyLdN2mNYokQPSAF6pfzSXfclj+rjH3A9h2TUJRi/utP/6XuF2rLNtH CVLz3+MgOx9oFPmNTZ7EPO7gFKcPu8BFJFTaKrR2YadXFvyY/KRfIJSPA3Tf0xKHURUkRVllUa2 +yPUW0I3QhJ/OQ3OII5vfei6nvkHBkn7JxoqDmj+A7GTnW5A2iK2yL3hMOnOYu+fzKzi6JV4SD5 3R15LRR+kuwaEdKdL/ZLPuugRAwgtLmhILUPQA8oeqPt15xLp1J+Lv8ZtM6OHf8qznhprWCk3ir k+d1avgqmVWX2oUAuczRMk0IoQA3hC/WAqG3Ur/2vmUz4JNT5nmCLcQomZk+wkRjDcXPdwBmvo3 WjWDPrNKfbUzBvQKyjqzbdlGtl4oD8UrWffrn8yZEnQGCIFbvvu3wHtQWmhvkQkwX7Jl+JjYFix Vn6RLj4lAFTm76HfWsgnad3zmINeSpuxGRto629OTPp8rWoQhiEeuWCYtfFArEpcccLgyWxnfVv PXgQBGP1LAlzE46g+lyOKyBagPuGTHJRU8DAxVuh5B+gOWk0zYv3AAWXITtxPI+P0xpQu3aw5oq I13tFIxJRX6ZGJg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Since CONFIG_NFSD_LEGACY_CLIENT_TRACKING is a new config option, its
initial default setting should have been Y (if we are to follow the
common practice of "default Y, wait, default N, wait, remove code").

Paul also suggested adding a clearer remedy action to the warning
message.

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Message-Id: <d2ab4ee7-ba0f-44ac-b921-90c8fa5a04d2@molgen.mpg.de>
Fixes: 74fd48739d04 ("nfsd: new Kconfig option for legacy client tracking")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/Kconfig       | 2 +-
 fs/nfsd/nfs4recover.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index 272ab8d5c4d7..ec2ab6429e00 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -162,7 +162,7 @@ config NFSD_V4_SECURITY_LABEL
 config NFSD_LEGACY_CLIENT_TRACKING
 	bool "Support legacy NFSv4 client tracking methods (DEPRECATED)"
 	depends on NFSD_V4
-	default n
+	default y
 	help
 	  The NFSv4 server needs to store a small amount of information on
 	  stable storage in order to handle state recovery after reboot. Most
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 2c060e0b1604..67d8673a9391 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -2086,8 +2086,8 @@ nfsd4_client_tracking_init(struct net *net)
 	status = nn->client_tracking_ops->init(net);
 out:
 	if (status) {
-		printk(KERN_WARNING "NFSD: Unable to initialize client "
-				    "recovery tracking! (%d)\n", status);
+		pr_warn("NFSD: Unable to initialize client recovery tracking! (%d)\n", status);
+		pr_warn("NFSD: Is nfsdcld running? If not, enable CONFIG_NFSD_LEGACY_CLIENT_TRACKING.\n");
 		nn->client_tracking_ops = NULL;
 	}
 	return status;
-- 
2.45.1


