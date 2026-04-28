Return-Path: <linux-nfs+bounces-21259-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBKmNHwJ8WnUcAEAu9opvQ
	(envelope-from <linux-nfs+bounces-21259-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 21:24:44 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F6248B1C5
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 21:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 674A430A4F0E
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 19:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FB647CC9E;
	Tue, 28 Apr 2026 19:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AjpyRrIV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9022609E3
	for <linux-nfs@vger.kernel.org>; Tue, 28 Apr 2026 19:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777404089; cv=none; b=BP7zIpw6oyCZjGst7SDEZ7BX2CVnZJGCdLOKz4AbIfpl+pLaDp7pWShsmR4gQwRQjnoivcAk/ONFrdwoWtzfgNYqvqCK8dkNvdlCttOMxgppvjGsJzRnWqNjxLBYtLpxPyqEOKXfKqVxYAjxMFY9QFwky1NeKqR/Nu3dEsaE1io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777404089; c=relaxed/simple;
	bh=rADsMyQZW7KYZ4YfdbvpqFxHzHaQXlVKJ1dK2uBWxRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J56P6crw9RiVjDxaYGYIpiJG06ZJG4shgQI3jb/3xpEA584opPP1QZz5+I7NV8TZl/Kz+VGATGBfZmeS7cC0Eu/ARP/+dL+ZLtYd7CcvfizdixqozsBYxp+BhCdOyzJyQrwoOYAL/rQAfs0Cr+XxDJs5nFrH2S/c7c6TiTrp9Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AjpyRrIV; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8ef45a6d9dfso858924885a.0
        for <linux-nfs@vger.kernel.org>; Tue, 28 Apr 2026 12:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777404085; x=1778008885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7HsRQzwddKIQadLpTvf+1Rg5IrK/BcQTm8bGEwPFxUs=;
        b=AjpyRrIV8EAauo76IpD94fxmP8PgxZwLOa9Vua4I3n8fU9kr6nSInXHyYhMHOitS9J
         AFfF+c7bJ2Y8v9IHBC+DbmdkJtSXfT/E2RC3CyAPcKsnC3ftO5LG452FeXaNtf28VXcu
         6KmYmqExqbUqP2zseOyAFiyHHMe3e91Nf7g2+yT+SvMzYEhKJKCZ5C/WwGAyAlDOh2t4
         aX2nQIxENNGZNlSwkCJT6Ye99JY4D6ggW5GgSgXgk5vxpaCIPSmPg+abyK6a0o3vmlKR
         mikf7f5DYKYQaoRp+MXwM/fnkLeP4r343YS0EF3id0lQfgNidb761CVD58pCoffy2GKQ
         wRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777404085; x=1778008885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7HsRQzwddKIQadLpTvf+1Rg5IrK/BcQTm8bGEwPFxUs=;
        b=HlCOWuWF5HsATFf+zJrkjXETX4cBUKzouuB1YzSK/lM5BqzEddFXC48wSgO20JjLNp
         OBnNxbXB3sfLYCbDtx7gCSm3qU9A1DlVbZhRpU4yRDusnokovPdxScHaVqzSlFyr5KoZ
         wGEHGAoj2Kl1749h4cGwTF859xCuvaYAI6DT0QcV0+jgXlUUZre805QQeR/ab0i3H8Qs
         rwbtPL4CSUKv+1bwc6BKolI99feYBbG4k2L/PPewzAEKgBlNFoOwhyP34tAmGOYFLozs
         JIY/o2AB1eEvdwFqK9ZconQsZ0sWfpioSqimW1TmH7DIGdC2cez2y+oLkqfD2i7/blQy
         pkKA==
X-Forwarded-Encrypted: i=1; AFNElJ9Cz5NL+3tQ82UwDViW/E/2wE3jHQ7YafUJ2/mi0W57PdGKn/QP8TJSWk28WWDPOM/thM8/tEchUFc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk2T/MkFF/TUriTOTLmBLMtowKNLhK48nMMg1Y4ZE6zrneA90T
	iz/bofOWWvKbtZ6HLsGAwulMAQO1gwaZZe5mM5aJD2LEi+D5knizU7kGphCSsH2i5w==
X-Gm-Gg: AeBDies9PvQBG5ArS6nyXQMFlEXJlmqRZ5rjuOiolPa2t3ydemtjpEWacMJqRCrDHs5
	Nv+ANV5tUggIxsRJ9KIYSarqE49BrV8tyyqMXKnJ61pfnyXz6IDfnrwg4Qgp2z9f6fA24byOB4U
	B1aSMcEmFXfDZKFypAe2rSBQs8q/f7zBUJBECZ2sEpOgTlmkhrzT+41HKEGS/+1i3hrnxyBZM+Y
	QTyifB1xOoXw29rYzpacqfYve/4Ku48cVtWF2kUVoggYpNTDUdyB2yt664nx/2EDgRddw1v1d5c
	DqYd7KewJlTMECLUOr0yYcWGykepGsnNxf31yKOB8Rfyc/y7erom9wp6KMVExw/CJM5l4loHqIM
	Pe3YvZeD8nSi1ZVXrOQSAe4lAYPBmc2VDJ4KjX0rjQ7NKZy20yc2iECE8aNkZPA10heEfl8VqYn
	vEkXDXUTxH4D6uMRdwzQnXjMJ2dmhQl/H4+EfyVFHeUu8YJ5tDsQ5tTfmQZMuV4jw3LJted0FKh
	atpzYc=
X-Received: by 2002:a05:620a:4456:b0:8d6:bd01:a67a with SMTP id af79cd13be357-8f7d7e171a8mr634934685a.26.1777404084901;
        Tue, 28 Apr 2026 12:21:24 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f7c84b1d92sm263877485a.38.2026.04.28.12.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 12:21:23 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Cc: stephen.smalley.work@gmail.com
Subject: [PATCH ported/repost v2] security,fs,nfs,net: update security_inode_listsecurity() interface
Date: Tue, 28 Apr 2026 15:21:20 -0400
Message-ID: <20260428192119.226244-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20250428195022.24587-2-stephen.smalley.work@gmail.com>
References: <20250428195022.24587-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7674; i=paul@paul-moore.com; h=from:subject; bh=TIBYVxpxKKE5XNqm2t5t5Zkc1qweb5gcM/rYatRhygg=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBp8Qivtdaz8kIJzR5ih/0JRGEl15mQnHjbbXmKU Vd1awybi5uJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCafEIrwAKCRDqIPLalzeJ c39KD/0QmxerRTCNDDzPUzdXuWLg0P0l7CVvmGWX5e/vy0NKGMNoVoY0Bk7iW9cGIjR7xjQH40h oAvirMrk2niZSjVWCjT88PyzeIZxkbKM4eVBA2swvkssSdKC53MPMS/eJTpVIA17X+23Z+Vi8LM 4/neLwI3AYZgDxdGP1E0UQ0ZlWzzode+fR6qOEzWvTLMmtfn9Nd/RB/5tKxno9uC5k83lfP+SZD ptADRIgGSQsiqOUtbCjkAAOyUG4u83Xb545DVQtdYP/ULVwkAgsDxCbfvCY6CJumTCgiZSUnHTS uoAACC/zM5m/ikPD3sQCj60R0zNQPKCNs5TZ2uqEJmD1m5NoJ+8uOKRqZyTOtnBaOSKWGcrPZ/U NbfLLcN62Jcgom4ac9vtnfBZmv8LhrI3DzlHSMPmrSEyfZidxVqcXPG3Ger0sTQLVUPxGfHxp0u Ed4GeJeuN9vipb6pVf6mXueJaVp50sZWE+9CIW5InxEsW5ZohGrjsl2zLn1cpW3Iur4F/YkAQul wfffjgvcZQkcfXo6dUpCPQPyNx6/BcimCZV5tUGiYFWyn10JlaRQ0YEIJUVFaO6c522I6UpydDF n0ccg2sBWPlVrv++GSjfWp1Ss/DumQDrUBsWzkX/dqSI02nRNuA7Fk5VJ/gM/5nwDILWvHMOXAW BLtroLvFvBsoslQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 58F6248B1C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21259-lists,linux-nfs=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,paul-moore.com:email,paul-moore.com:dkim,paul-moore.com:mid]

From: Stephen Smalley <stephen.smalley.work@gmail.com>

Update the security_inode_listsecurity() interface to allow
use of the xattr_list_one() helper and update the hook
implementations.

Link: https://lore.kernel.org/selinux/20250424152822.2719-1-stephen.smalley.work@gmail.com
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
[PM: forward porting to bring this patch up to v7.1-rc1+]
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 fs/nfs/nfs4proc.c             |  7 ++-----
 fs/xattr.c                    | 11 +++++++----
 include/linux/lsm_hook_defs.h |  4 ++--
 include/linux/security.h      |  5 +++--
 security/security.c           | 16 ++++++++--------
 security/selinux/hooks.c      | 10 +++-------
 security/smack/smack_lsm.c    | 13 ++++---------
 7 files changed, 29 insertions(+), 37 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index a9b8d482d289..a16342056ae5 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10562,13 +10562,10 @@ static ssize_t nfs4_listxattr(struct dentry *dentry, char *list, size_t size)
 		left -= error;
 	}
 
-	error2 = security_inode_listsecurity(d_inode(dentry), list, left);
+	error2 = security_inode_listsecurity(d_inode(dentry), &list, &left);
 	if (error2 < 0)
 		return error2;
-	if (list) {
-		list += error2;
-		left -= error2;
-	}
+	error2 = size - error - left;
 
 	error3 = nfs4_listxattr_nfs4_user(d_inode(dentry), list, left);
 	if (error3 < 0)
diff --git a/fs/xattr.c b/fs/xattr.c
index 09ecbaaa1660..0bc3b47e6936 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -510,9 +510,12 @@ vfs_listxattr(struct dentry *dentry, char *list, size_t size)
 	if (inode->i_op->listxattr) {
 		error = inode->i_op->listxattr(dentry, list, size);
 	} else {
-		error = security_inode_listsecurity(inode, list, size);
-		if (size && error > size)
-			error = -ERANGE;
+		ssize_t remaining = size;
+
+		error = security_inode_listsecurity(inode, &list, &remaining);
+		if (error)
+			return error;
+		error = size - remaining;
 	}
 	return error;
 }
@@ -1540,7 +1543,7 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
 	if (err)
 		return err;
 
-	err = security_inode_listsecurity(inode, buffer, remaining_size);
+	err = security_inode_listsecurity(inode, &buffer, &remaining_size);
 	if (err < 0)
 		return err;
 
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 2b8dfb35caed..65c9609ec207 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -176,8 +176,8 @@ LSM_HOOK(int, -EOPNOTSUPP, inode_getsecurity, struct mnt_idmap *idmap,
 	 struct inode *inode, const char *name, void **buffer, bool alloc)
 LSM_HOOK(int, -EOPNOTSUPP, inode_setsecurity, struct inode *inode,
 	 const char *name, const void *value, size_t size, int flags)
-LSM_HOOK(int, 0, inode_listsecurity, struct inode *inode, char *buffer,
-	 size_t buffer_size)
+LSM_HOOK(int, 0, inode_listsecurity, struct inode *inode, char **buffer,
+	 ssize_t *remaining_size)
 LSM_HOOK(void, LSM_RET_VOID, inode_getlsmprop, struct inode *inode,
 	 struct lsm_prop *prop)
 LSM_HOOK(int, 0, inode_copy_up, struct dentry *src, struct cred **new)
diff --git a/include/linux/security.h b/include/linux/security.h
index 41d7367cf403..153e9043058f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -459,7 +459,7 @@ int security_inode_getsecurity(struct mnt_idmap *idmap,
 			       struct inode *inode, const char *name,
 			       void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
-int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
+int security_inode_listsecurity(struct inode *inode, char **buffer, ssize_t *remaining_size);
 void security_inode_getlsmprop(struct inode *inode, struct lsm_prop *prop);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(struct dentry *src, const char *name);
@@ -1097,7 +1097,8 @@ static inline int security_inode_setsecurity(struct inode *inode, const char *na
 	return -EOPNOTSUPP;
 }
 
-static inline int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size)
+static inline int security_inode_listsecurity(struct inode *inode,
+					char **buffer, ssize_t *remaining_size)
 {
 	return 0;
 }
diff --git a/security/security.c b/security/security.c
index 4e999f023651..71aea8fdf014 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2258,22 +2258,22 @@ int security_inode_setsecurity(struct inode *inode, const char *name,
 /**
  * security_inode_listsecurity() - List the xattr security label names
  * @inode: inode
- * @buffer: buffer
- * @buffer_size: size of buffer
+ * @buffer: pointer to buffer
+ * @remaining_size: pointer to remaining size of buffer
  *
  * Copy the extended attribute names for the security labels associated with
- * @inode into @buffer.  The maximum size of @buffer is specified by
- * @buffer_size.  @buffer may be NULL to request the size of the buffer
- * required.
+ * @inode into *(@buffer).  The remaining size of @buffer is specified by
+ * *(@remaining_size).  *(@buffer) may be NULL to request the size of the
+ * buffer required. Updates *(@buffer) and *(@remaining_size).
  *
- * Return: Returns number of bytes used/required on success.
+ * Return: Returns 0 on success, or -errno on failure.
  */
 int security_inode_listsecurity(struct inode *inode,
-				char *buffer, size_t buffer_size)
+				char **buffer, ssize_t *remaining_size)
 {
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
-	return call_int_hook(inode_listsecurity, inode, buffer, buffer_size);
+	return call_int_hook(inode_listsecurity, inode, buffer, remaining_size);
 }
 EXPORT_SYMBOL(security_inode_listsecurity);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 97801966bf32..4ae736755557 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3684,16 +3684,12 @@ static int selinux_inode_setsecurity(struct inode *inode, const char *name,
 	return 0;
 }
 
-static int selinux_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size)
+static int selinux_inode_listsecurity(struct inode *inode, char **buffer,
+				ssize_t *remaining_size)
 {
-	const int len = sizeof(XATTR_NAME_SELINUX);
-
 	if (!selinux_initialized())
 		return 0;
-
-	if (buffer && len <= buffer_size)
-		memcpy(buffer, XATTR_NAME_SELINUX, len);
-	return len;
+	return xattr_list_one(buffer, remaining_size, XATTR_NAME_SELINUX);
 }
 
 static void selinux_inode_getlsmprop(struct inode *inode, struct lsm_prop *prop)
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 3f9ae05039a2..ff115068c5c0 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1665,17 +1665,12 @@ static int smack_inode_getsecurity(struct mnt_idmap *idmap,
  * smack_inode_listsecurity - list the Smack attributes
  * @inode: the object
  * @buffer: where they go
- * @buffer_size: size of buffer
+ * @remaining_size: size of buffer
  */
-static int smack_inode_listsecurity(struct inode *inode, char *buffer,
-				    size_t buffer_size)
+static int smack_inode_listsecurity(struct inode *inode, char **buffer,
+				    ssize_t *remaining_size)
 {
-	int len = sizeof(XATTR_NAME_SMACK);
-
-	if (buffer != NULL && len <= buffer_size)
-		memcpy(buffer, XATTR_NAME_SMACK, len);
-
-	return len;
+	return xattr_list_one(buffer, remaining_size, XATTR_NAME_SMACK);
 }
 
 /**
-- 
2.54.0


