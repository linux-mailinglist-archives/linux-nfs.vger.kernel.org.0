Return-Path: <linux-nfs+bounces-13198-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 890EFB0E522
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jul 2025 22:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC34E547BE0
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jul 2025 20:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690C01F4190;
	Tue, 22 Jul 2025 20:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N8t426pH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1665D157A67
	for <linux-nfs@vger.kernel.org>; Tue, 22 Jul 2025 20:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753217814; cv=none; b=MpcVrmNWRXVr462v+lmCeQ3uyKz9N7FloIHmNdwnRWjFm78T2nShQs2PTAkQkoS/nnxsgalUjQ/ck1HGrVEgZlsaMpG51D1tKVXzoDxQCHDKatAC8W1kYqpOvFESH0GGNS7YpZGXFQNyF9Gk/yHxXDK/FfO2+iProf6FveOJEwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753217814; c=relaxed/simple;
	bh=Qhw/TqXcB5+qcTcghonO6WtNbdsu5gG+lOBsDb08mlE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OvUs09N7m6Se59HF2YHafayk9VbhV4sijUgBUV8uzegUAAWXYpvv2HL6kDWt7/GZUJSXxWpHd/2PApWabOnntYOtF3KFCi2iIHYvrJsXfivPmzexkDuB1vrsU/QBLygEh+W1BowHUnN8BTXAt4+A2A6g43WawP6yW9/YA9C7tbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N8t426pH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753217810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3Tvuj0RoK78h6iqJFQFLDN0I04wCb2Eg8C0b7UezWOE=;
	b=N8t426pH1b0xN74FkJk4YQjM5qpi8T147YS5JjhSmyyBwa3lojAk2a1S482ZDxTh0fHkNL
	JHwl0u7iyRnsEPo+/R8NvTGx98rF8tjHJP9IJGoLKJAbxqqRXNdU5obGDkC7SuBF3Isk4Y
	Uk7F8LZT/gr7bIMLG8pod73VGsqmMfQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-qBZwL8Y_Mwq8C5Ho-0xN5Q-1; Tue,
 22 Jul 2025 16:56:47 -0400
X-MC-Unique: qBZwL8Y_Mwq8C5Ho-0xN5Q-1
X-Mimecast-MFC-AGG-ID: qBZwL8Y_Mwq8C5Ho-0xN5Q_1753217806
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8406F195FD02;
	Tue, 22 Jul 2025 20:56:46 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.65.185])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 55150195608D;
	Tue, 22 Jul 2025 20:56:44 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: trond.myklebust@hammerspace.com,
	anna.schumaker@oracle.com
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH 1/1] NFSv4.2: another fix for listxattr
Date: Tue, 22 Jul 2025 16:56:41 -0400
Message-Id: <20250722205641.79394-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Currently, when the server supports NFS4.1 security labels then
security.selinux label in included twice. Instead, only add it
when the server doesn't possess security label support.

Fixes: 243fea134633 ("NFSv4.2: fix listxattr to return selinux security label")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfs/nfs4proc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 341740fa293d..811892cdb5a3 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10867,7 +10867,7 @@ const struct nfs4_minor_version_ops *nfs_v4_minor_ops[] = {
 
 static ssize_t nfs4_listxattr(struct dentry *dentry, char *list, size_t size)
 {
-	ssize_t error, error2, error3, error4;
+	ssize_t error, error2, error3, error4 = 0;
 	size_t left = size;
 
 	error = generic_listxattr(dentry, list, left);
@@ -10895,9 +10895,11 @@ static ssize_t nfs4_listxattr(struct dentry *dentry, char *list, size_t size)
 		left -= error3;
 	}
 
-	error4 = security_inode_listsecurity(d_inode(dentry), list, left);
-	if (error4 < 0)
-		return error4;
+	if (!nfs_server_capable(d_inode(dentry), NFS_CAP_SECURITY_LABEL)) {
+		error4 = security_inode_listsecurity(d_inode(dentry), list, left);
+		if (error4 < 0)
+			return error4;
+	}
 
 	error += error2 + error3 + error4;
 	if (size && error > size)
-- 
2.47.1


