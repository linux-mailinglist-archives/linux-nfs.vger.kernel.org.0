Return-Path: <linux-nfs+bounces-335-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0A68056EA
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Dec 2023 15:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 094D41C20F78
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Dec 2023 14:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B28E61FCA;
	Tue,  5 Dec 2023 14:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SM8g0vXg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD68A19F
	for <linux-nfs@vger.kernel.org>; Tue,  5 Dec 2023 06:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701785548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JPGfzHqlo357oRYfBXaut/FurUkgeu5VDfyF70luaZs=;
	b=SM8g0vXgXgoAnRVQFFQ8LR6S1j2hVn5wWNKLvUnBu8c63AuqGKwui3DOs5vVBnqeROTinZ
	lBjEJMN2PPUB1fxvZEX4/n2B7c03roYaIIBhtOf0M1v1yF0Bob4euu2q48LA7r8GDTUn56
	NVBKMBSsdv9YTI7r+1Ln4AqpJDV7L8U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-wnzRVV8gN5SH-TfWWpJWRg-1; Tue, 05 Dec 2023 09:10:56 -0500
X-MC-Unique: wnzRVV8gN5SH-TfWWpJWRg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C1D82185A792;
	Tue,  5 Dec 2023 14:10:55 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.32.220])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A3641121312;
	Tue,  5 Dec 2023 14:10:55 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 10831EB05E;
	Tue,  5 Dec 2023 09:10:55 -0500 (EST)
From: Scott Mayhew <smayhew@redhat.com>
To: trond.myklebust@hammerspace.com,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH RFC 1/1] NFS: Use parent's objective cred in nfs_access_login_time()
Date: Tue,  5 Dec 2023 09:10:54 -0500
Message-ID: <20231205141054.1759563-2-smayhew@redhat.com>
In-Reply-To: <20231205141054.1759563-1-smayhew@redhat.com>
References: <20231205141054.1759563-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

The subjective cred (task->cred) can potentially be overridden and
subsquently freed in non-RCU context, which could lead to a panic if we
try to use it in cred_fscmp().  Use __task_cred(), which returns the
objective cred (task->real_cred) instead.

Fixes: 0eb43812c027 ("NFS: Clear the file access cache upon login")
Fixes: 5e9a7b9c2ea1 ("NFS: Fix up a sparse warning")

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 13dffe4201e6..273c0b68abf4 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2963,7 +2963,7 @@ static u64 nfs_access_login_time(const struct task_struct *task,
 	rcu_read_lock();
 	for (;;) {
 		parent = rcu_dereference(task->real_parent);
-		pcred = rcu_dereference(parent->cred);
+		pcred = __task_cred(parent);
 		if (parent == task || cred_fscmp(pcred, cred) != 0)
 			break;
 		task = parent;
-- 
2.41.0


