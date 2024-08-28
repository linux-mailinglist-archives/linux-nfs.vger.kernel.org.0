Return-Path: <linux-nfs+bounces-5876-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C911396314D
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 21:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0131528238A
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 19:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325DF1AB51B;
	Wed, 28 Aug 2024 19:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fi/Dbc9S"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828D41A76D8
	for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2024 19:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724874704; cv=none; b=cW/pZdZ7oe/0jB6VXXSPbfilIGvAy6srsz40EyeF2J1xpQUkggyQDZeyjsSB8SID91CCyzNXLEj2bTKjiiIVISz+rbEYtCRmqZS8NMFBgmhCxdjhCEWHo0bRKXHKpagW04Qx1yopYj6dXDAIVqvVwK5aBSwCGSkAQhi3qe+UWjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724874704; c=relaxed/simple;
	bh=dcfs79Py3IiTUswzTqPUpxe7itKSx/JZtH4hytm1mr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XHLHrsPzUCypI3J8WmVlL11HyXZUx70KemZztAeT9X5v5/xZAUNuptTTUmUyjPVptnR1M1jUn4jf96vowcGuIxWk9vQGnN4O/7Son5hRE7AQStYDOo1wt+NDJTcrkEh82OpXZWuNrnSpvjpE0pFzwEVJ9OmVdNpkxec2nHll0Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fi/Dbc9S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724874701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0F3ItvTgPtSCXGOH+vouvcZZHknz9c5kzizQF3HT/1k=;
	b=fi/Dbc9SgOKlh3qeN5O6OMISXwSiF1tuLNA8lj3vzP+SQC5K3LmUf1lymW9XnZ6ZCeblr+
	eojKpzwhC4gQX2rv4hxQmqEjlGDLtdEzz/1vORA3svu0GIQE27W/0/K/nGP8jqWSAO/Bku
	k7iiLlBXSRl72rT/9m47QtEWqt+78Vk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-9Ls7UntyMpCvaZ4eJBXTBg-1; Wed,
 28 Aug 2024 15:51:34 -0400
X-MC-Unique: 9Ls7UntyMpCvaZ4eJBXTBg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 713AD1955D50;
	Wed, 28 Aug 2024 19:51:32 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.9.161])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD8461955BED;
	Wed, 28 Aug 2024 19:51:31 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id E08181F0956;
	Wed, 28 Aug 2024 15:51:29 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: paul@paul-moore.com,
	stephen.smalley.work@gmail.com,
	casey@schaufler-ca.com
Cc: chuck.lever@oracle.com,
	marek.gresko@protonmail.com,
	selinux@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] selinux,smack: don't bypass permissions check in inode_setsecctx hook
Date: Wed, 28 Aug 2024 15:51:29 -0400
Message-ID: <20240828195129.223395-2-smayhew@redhat.com>
In-Reply-To: <20240828195129.223395-1-smayhew@redhat.com>
References: <20240828195129.223395-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Marek Gresko reports that the root user on an NFS client is able to
change the security labels on files on an NFS filesystem that is
exported with root squashing enabled.

The end of the kerneldoc comment for __vfs_setxattr_noperm() states:

 *  This function requires the caller to lock the inode's i_mutex before it
 *  is executed. It also assumes that the caller will make the appropriate
 *  permission checks.

nfsd_setattr() does do permissions checking via fh_verify() and
nfsd_permission(), but those don't do all the same permissions checks
that are done by security_inode_setxattr() and its related LSM hooks do.

Since nfsd_setattr() is the only consumer of security_inode_setsecctx(),
simplest solution appears to be to replace the call to
__vfs_setxattr_noperm() with a call to __vfs_setxattr_locked().  This
fixes the above issue and has the added benefit of causing nfsd to
recall conflicting delegations on a file when a client tries to change
its security label.

Reported-by: Marek Gresko <marek.gresko@protonmail.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218809
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 security/selinux/hooks.c   | 4 ++--
 security/smack/smack_lsm.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index bfa61e005aac..400eca4ad0fb 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6660,8 +6660,8 @@ static int selinux_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen
  */
 static int selinux_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 {
-	return __vfs_setxattr_noperm(&nop_mnt_idmap, dentry, XATTR_NAME_SELINUX,
-				     ctx, ctxlen, 0);
+	return __vfs_setxattr_locked(&nop_mnt_idmap, dentry, XATTR_NAME_SELINUX,
+				     ctx, ctxlen, 0, NULL);
 }
 
 static int selinux_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 4164699cd4f6..002a1b9ed83a 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4880,8 +4880,8 @@ static int smack_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
 
 static int smack_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 {
-	return __vfs_setxattr_noperm(&nop_mnt_idmap, dentry, XATTR_NAME_SMACK,
-				     ctx, ctxlen, 0);
+	return __vfs_setxattr_locked(&nop_mnt_idmap, dentry, XATTR_NAME_SMACK,
+				     ctx, ctxlen, 0, NULL);
 }
 
 static int smack_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
-- 
2.46.0


