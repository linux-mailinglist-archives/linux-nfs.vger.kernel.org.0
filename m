Return-Path: <linux-nfs+bounces-11145-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8399BA9079A
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Apr 2025 17:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D2EC3A6A55
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Apr 2025 15:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF79218C32C;
	Wed, 16 Apr 2025 15:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EuF5JX7+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D15D2080D2
	for <linux-nfs@vger.kernel.org>; Wed, 16 Apr 2025 15:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744817028; cv=none; b=EBjvJFWjcZI9rHxGBqktpF40R9crbQBhf2mjEE4MLRAW2p8PgE4Dr8xVq/vufEhYaw5Un8ykgiNWl/YKO4ByBtFVTfkSjEgXATFWue6IM0K1eX2D5Hk2lUO3b0XI/KYj4ZR4nbDXDc6UGoP9h9rTgstfX4G4qJVQpbAsDyrJ5QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744817028; c=relaxed/simple;
	bh=mN0WHbhfKIUCxidFoyjjJRsRujTMRi9hIp/f3wcY9NE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sXaYuNQzbSWFCPNOoGWklRLVo4DbH5gPjyHK0q7aHrPrmkRqpgeDpyXZlc7U4ZocX9jfDcpQjQL3zEGjSFnToMSrsRh1T9uR+MtlJeN2blrmXoJ08wq/a6z8XfqVYsffotZMaeqEwydnbD53jbcKDiVpH+6CjqGn/4DWrAbDycE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EuF5JX7+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744817026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=48VIjcc0oSg5rlReRfyA1Q58PckxJW4sgUEltzYtX9g=;
	b=EuF5JX7+3n13YROhfzLK9O0/qD+GoksrTXIqmoVkwND7LHIC2yr8BXvlkQLPvtYE0tvcG/
	F7xmJ1KRQe5nTIFHeKrPhg26EnDvmSya5BxhYbYJNZJCVgAZN2GMZYH554NksHDd17f6jI
	/SZL4wRCdWMCN+gfiP1oeAzJuJS2H5E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-D0Anc6pVPim8u6n0GhpwCA-1; Wed,
 16 Apr 2025 11:23:43 -0400
X-MC-Unique: D0Anc6pVPim8u6n0GhpwCA-1
X-Mimecast-MFC-AGG-ID: D0Anc6pVPim8u6n0GhpwCA_1744817020
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A40AD1800ECA;
	Wed, 16 Apr 2025 15:23:40 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.64.98])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 375AC30001A1;
	Wed, 16 Apr 2025 15:23:40 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 9984D3411C2;
	Wed, 16 Apr 2025 11:23:38 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2] NFSv4: xattr handlers should check for absent nfs filehandles
Date: Wed, 16 Apr 2025 11:23:38 -0400
Message-ID: <20250416152338.3279639-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The nfs inodes for referral anchors that have not yet been followed have
their filehandles zeroed out.

Attempting to call getxattr() on one of these will cause the nfs client
to send a GETATTR to the nfs server with the preceding PUTFH sans
filehandle.  The server will reply NFS4ERR_NOFILEHANDLE, leading to -EIO
being returned to the application.

For example:

$ strace -e trace=getxattr getfattr -n system.nfs4_acl /mnt/t/ref
getxattr("/mnt/t/ref", "system.nfs4_acl", NULL, 0) = -1 EIO (Input/output error)
/mnt/t/ref: system.nfs4_acl: Input/output error
+++ exited with 1 +++

Have the xattr handlers return -ENODATA instead.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfs/nfs4proc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 970f28dbf253..1b0fd3cc9e02 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6202,6 +6202,8 @@ static ssize_t nfs4_proc_get_acl(struct inode *inode, void *buf, size_t buflen,
 	struct nfs_server *server = NFS_SERVER(inode);
 	int ret;
 
+	if (unlikely(NFS_FH(inode)->size == 0))
+		return -ENODATA;
 	if (!nfs4_server_supports_acls(server, type))
 		return -EOPNOTSUPP;
 	ret = nfs_revalidate_inode(inode, NFS_INO_INVALID_CHANGE);
@@ -6276,6 +6278,9 @@ static int nfs4_proc_set_acl(struct inode *inode, const void *buf,
 {
 	struct nfs4_exception exception = { };
 	int err;
+
+	if (unlikely(NFS_FH(inode)->size == 0))
+		return -ENODATA;
 	do {
 		err = __nfs4_proc_set_acl(inode, buf, buflen, type);
 		trace_nfs4_set_acl(inode, err);
-- 
2.48.1


