Return-Path: <linux-nfs+bounces-11252-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE86A9975B
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 20:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC7F31B653AD
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 18:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4F410957;
	Wed, 23 Apr 2025 17:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="chhPgOR4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C8528D834
	for <linux-nfs@vger.kernel.org>; Wed, 23 Apr 2025 17:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745431196; cv=none; b=Kys5ac4QouDOCbPywnsIaSpPSjE7cJe3MUdgtj4QrrKeltwAcmopQJKo5NOt28VE9yu0ffMTWcg2YJHlFtNIWD4ln/AJ+ne4UM/9zSQlLC3Sjn0++hFWy+zHPOV08qJIZulCfxAa9JsnMJ5ywqXkTad4ao/LG63SuwKpDd4aMaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745431196; c=relaxed/simple;
	bh=UPEai1Ac9Cid99a8IrxbD+eu5d5klaKZ9Tn29qLvhUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VfgXQqqENlcAD93L+sv0GUi65aAq6+VsTUcNQiCaY3Zc8CgYAVG4R8tGCzMlf900DxY1/GWy6/Bd5XmAreuPKmcfsMgbPRnZd3owqMZvy3nuUqkqUpgTQ50Yk93CnZjlsILzL15HCG41RdK2L5EEChyNA25KbVWhxAPHUJqgP5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=chhPgOR4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745431192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7E3dzDkr5Q7efPGP63dsExiObFlqhe1+zIwkcCw/g9w=;
	b=chhPgOR4vbB5/cEue0/m6mdFVgIR5Wjlb6L5BcBnKSR1+knXJvJC4rHNtm9vDQMqJB8m9E
	yOyCuZu9vuIimW/UhMUgwzOPXGodiY1AV7BvkWN2GWHgyEZzKcY1fZGdCIA5WqHTb6vKzw
	BeVJ6Vb2GfyZeH32v+njODM8TIYKhUE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-bFMowhK4OQ2CtOtI3zgpbw-1; Wed,
 23 Apr 2025 13:59:45 -0400
X-MC-Unique: bFMowhK4OQ2CtOtI3zgpbw-1
X-Mimecast-MFC-AGG-ID: bFMowhK4OQ2CtOtI3zgpbw_1745431184
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 553621956086;
	Wed, 23 Apr 2025 17:59:44 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.74.16])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8523A180045C;
	Wed, 23 Apr 2025 17:59:43 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] NFSv4: Ensure test_and_free_stateid callers use private memory
Date: Wed, 23 Apr 2025 13:59:40 -0400
Message-ID: <eb9c88aacce78595a079c2f248395af3e823239f.1745430006.git.bcodding@redhat.com>
In-Reply-To: <cover.1745430006.git.bcodding@redhat.com>
References: <cover.1745430006.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

A follow-up patch intends to signal the success or failure of FREE_STATEID
by modifying the nfs4_stateid's type which requires the const qualifier for
the nfs4_stateid to be dropped.  Since it will no longer safe to operate
directly on shared stateid objects in this path, ensure that callers send a
copy.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/nfs4proc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 6e95db6c17e9..bfb9e980d662 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2990,6 +2990,7 @@ static void nfs41_delegation_recover_stateid(struct nfs4_state *state)
 static int nfs41_check_expired_locks(struct nfs4_state *state)
 {
 	int status, ret = NFS_OK;
+	nfs4_stateid stateid;
 	struct nfs4_lock_state *lsp, *prev = NULL;
 	struct nfs_server *server = NFS_SERVER(state->inode);
 
@@ -3007,9 +3008,9 @@ static int nfs41_check_expired_locks(struct nfs4_state *state)
 			nfs4_put_lock_state(prev);
 			prev = lsp;
 
+			nfs4_stateid_copy(&stateid, &lsp->ls_stateid);
 			status = nfs41_test_and_free_expired_stateid(server,
-					&lsp->ls_stateid,
-					cred);
+					&stateid, cred);
 			trace_nfs4_test_lock_stateid(state, lsp, status);
 			if (status == -NFS4ERR_EXPIRED ||
 			    status == -NFS4ERR_BAD_STATEID) {
@@ -3042,17 +3043,18 @@ static int nfs41_check_expired_locks(struct nfs4_state *state)
 static int nfs41_check_open_stateid(struct nfs4_state *state)
 {
 	struct nfs_server *server = NFS_SERVER(state->inode);
-	nfs4_stateid *stateid = &state->open_stateid;
+	nfs4_stateid stateid;
 	const struct cred *cred = state->owner->so_cred;
 	int status;
 
 	if (test_bit(NFS_OPEN_STATE, &state->flags) == 0)
 		return -NFS4ERR_BAD_STATEID;
-	status = nfs41_test_and_free_expired_stateid(server, stateid, cred);
+	nfs4_stateid_copy(&stateid, &state->open_stateid);
+	status = nfs41_test_and_free_expired_stateid(server, &stateid, cred);
 	trace_nfs4_test_open_stateid(state, NULL, status);
 	if (status == -NFS4ERR_EXPIRED || status == -NFS4ERR_BAD_STATEID) {
 		nfs_state_clear_open_state_flags(state);
-		stateid->type = NFS4_INVALID_STATEID_TYPE;
+		state->open_stateid.type = NFS4_INVALID_STATEID_TYPE;
 		return status;
 	}
 	if (nfs_open_stateid_recover_openmode(state))
-- 
2.47.0


