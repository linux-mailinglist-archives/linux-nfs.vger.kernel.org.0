Return-Path: <linux-nfs+bounces-2887-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC1F8A8B95
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 20:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D5821C23ACB
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 18:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C90D1CAA4;
	Wed, 17 Apr 2024 18:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MICxYg+J"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83250F51B
	for <linux-nfs@vger.kernel.org>; Wed, 17 Apr 2024 18:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713379779; cv=none; b=cdwZqPPSQvsL5vU7Ix8T8rhte6RcRVEqR4UnGgqgTjlWFWtrKrqm4NIZ7KlWnHFF88tPWG8Jn9/ccSAHy3A/JgnquWUu4Oo6bYgoiMAEV2fKab+wJC+hg36axiMrQIX7vhJLe00fGsCrhBwhSU+ir3DcrayJk4KrxVJ/+CbkU04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713379779; c=relaxed/simple;
	bh=Y9TeZVxWnfMqfsz+fyP1d0/Wz8RFvLbo9BwdxoQ38fE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rQV6lhQOX4fUgFAvNup48Txk1glh9Yj7E+nBscYxN9t5FtIQs2bFQSJDwLAwolC9BX267M+BClnh8t1utoILhDnnL5gQdVBygPMhbFaw3Zmncq2g/SLI6V1XGGwBC9tX3IEQn1/M5PWt+VtznyvNJdrbiGMNUVcoYlV6dStibn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MICxYg+J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713379776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=i3X1dyAvaNqQYaLw/p9movMkY4FZxYASCymsh6y5T4U=;
	b=MICxYg+JEXO35fRDCH/NYl7ZqgpUQAPNV1kLjjs4Q3fYQbnbuw03CYUWIFPia4c4+I3fnf
	mxD7fE5HVHX1QlebnF4W+AKpCEhbZ8A08x9yCUKG5d6mFZkUBOSfTDFvzH9soM6smJDWzW
	f6vuYkgjEcZjUT8NXBuDgdUi2pxRvNM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-eG2kak9UOh-g16Ni19iIyw-1; Wed,
 17 Apr 2024 14:49:30 -0400
X-MC-Unique: eG2kak9UOh-g16Ni19iIyw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 70AA03C1E9C4;
	Wed, 17 Apr 2024 18:49:30 +0000 (UTC)
Received: from bcodding.csb.redhat.com (ovpn-0-6.rdu2.redhat.com [10.22.0.6])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C78533543A;
	Wed, 17 Apr 2024 18:49:29 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trond.myklebust@primarydata.com>,
	Anna Schumaker <anna.schumaker@netapp.com>,
	Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] NFSv4: Fixup smatch warning for ambiguous return
Date: Wed, 17 Apr 2024 14:49:29 -0400
Message-ID: <b1577a24c58a9b0605a4540c8be5c411a07cb04c.1713379239.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Dan Carpenter reports smatch warning for nfs4_try_migration() when a memory
allocation failure results in a zero return value.  In this case, a
transient allocation failure error will likely be retried the next time the
server responds with NFS4ERR_MOVED.

We can fixup the smatch warning with a small refactor: attempt all three
allocations before testing and returning on a failure.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Fixes: c3ed222745d9 ("NFSv4: Fix free of uninitialized nfs4_label on referral lookup.")
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
Chuck, does this look sane?  I don't have a simple way to test this at the
moment.  Also, I think the only result of returning -ENOMEM here instead
would be that we skip continuing to try to migrate for other filesystems on
this client, and we'd get a log message and trace output of the failure.

 fs/nfs/nfs4state.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 662e86ea3a2d..5b452411e8fd 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -2116,6 +2116,7 @@ static int nfs4_try_migration(struct nfs_server *server, const struct cred *cred
 {
 	struct nfs_client *clp = server->nfs_client;
 	struct nfs4_fs_locations *locations = NULL;
+	struct nfs_fattr *fattr;
 	struct inode *inode;
 	struct page *page;
 	int status, result;
@@ -2125,19 +2126,16 @@ static int nfs4_try_migration(struct nfs_server *server, const struct cred *cred
 			(unsigned long long)server->fsid.minor,
 			clp->cl_hostname);
 
-	result = 0;
 	page = alloc_page(GFP_KERNEL);
 	locations = kmalloc(sizeof(struct nfs4_fs_locations), GFP_KERNEL);
-	if (page == NULL || locations == NULL) {
-		dprintk("<-- %s: no memory\n", __func__);
-		goto out;
-	}
-	locations->fattr = nfs_alloc_fattr();
-	if (locations->fattr == NULL) {
+	fattr = nfs_alloc_fattr();
+	if (page == NULL || locations == NULL || fattr == NULL) {
 		dprintk("<-- %s: no memory\n", __func__);
+		result = 0;
 		goto out;
 	}
 
+	locations->fattr = fattr;
 	inode = d_inode(server->super->s_root);
 	result = nfs4_proc_get_locations(server, NFS_FH(inode), locations,
 					 page, cred);
-- 
2.44.0


