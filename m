Return-Path: <linux-nfs+bounces-19087-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id B3+dMVsHm2nBqQMAu9opvQ
	(envelope-from <linux-nfs+bounces-19087-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Feb 2026 14:40:43 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 172D916F3F9
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Feb 2026 14:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF872300D14D
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Feb 2026 13:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4553F2236E3;
	Sun, 22 Feb 2026 13:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b="E6qEKAJi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA01AEACD
	for <linux-nfs@vger.kernel.org>; Sun, 22 Feb 2026 13:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771767641; cv=none; b=RGJYYsh/TOadPVHMTiMxwi8KMz4OP3094fA7cNPbmkDXdzFTjsaSZPEec05o6AXZig1Vqf38UfPBK22+z5q84PPyABEzQiMxP/VM2/mU1TKax8DCSREbJwUKrbddUrJM6yZXkEbAUohnm3Z6wpCwz7LkbpStiFj2Vmte2FNK7nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771767641; c=relaxed/simple;
	bh=XQRKxRQE10H7yg7a6G0mXTMDsK5YQfJYdmfTfnJRA2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UHdlGAf/XEVH9KUv3b9pgI91MmuBRjxnqp/zMPN+4X3x54eLINcB8eApooRo6PXpfehZPUbuXPCQiS1krr8V4TjouA7K8l7+dRrloAydocyQH0JKXyIIJlmQ8uLaeJ8PKc7YDXXxUPaDUD/JsyVHulMlrLtObWIq1nxh1dQyulg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com; spf=pass smtp.mailfrom=vastdata.com; dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b=E6qEKAJi; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vastdata.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-480706554beso41635865e9.1
        for <linux-nfs@vger.kernel.org>; Sun, 22 Feb 2026 05:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google; t=1771767638; x=1772372438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X5hTB7rp2v2Ky3DPucmsZgzTt1Xqw3GkUdh/l/h8Rmg=;
        b=E6qEKAJi1duusAqJpOv685BV2nHH3A38gYZgXDo/N2UEDCi6k10PtuvNK+AKqPH7Pr
         dVsaFggeWA9LO6SAU5HmWEL/W99gn8bQ5mTjgiRDzQ9J8Hu3fZrKXNFgjQaGUtfaPhZF
         RhRDwqR8swqPeou6+GrZy1VixtC5UNYZehgqn+0ps2uEkjhlrioexQmxD4PijMTSn3f8
         iMMT79Y1BfeRsCSupSu49rdDO4bniDw3+dEkMb8Axqy5Ksjkpa7TGzD2hup/llP5YJSM
         un8gba3FS3KOf5TZ1mx0JKazK3SeqyHzQh75Qh1ZYLTKw21fZc6qqXOg/0VrD7hxsV/C
         c+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771767638; x=1772372438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5hTB7rp2v2Ky3DPucmsZgzTt1Xqw3GkUdh/l/h8Rmg=;
        b=Q/0exPFa3uMSJyIQlY0D/9CSrWfPnvdyvRSI2r9cX2A8Rwr+V3raJGs5EM8+d39mWe
         hWY72V0hYOLNpmCy1T7vmDZNDN5nioZoidmHA+tDTNdOUIwzrDS+parXeLQEVN8hv9kI
         785tY4KpHouiH20t2GwIDsIsrYrhOum5Ya3p5xhIqUVVJYwhgeSURnkiV4br0CpPjt0H
         gvEQhrZGqlQFkLAJZXf3dMVp4T1cs8QlsAllfwGulFiGkr8oUVL0OTbkvNgtS9UwYSao
         idwgcnUIqEU3Y3QqSRlAHCXjnC8RgNIRG0DWpYaTMD6jirOM2mcyFlgQ5FiUAz8D+mpA
         L+Ig==
X-Gm-Message-State: AOJu0YxpvjypvK1rqgQidml7SQhNMclTdLaZ9YpHt087290WPsEl9H4m
	O/tg0kUTJBDLWElpdaOyQugJmceE9Sglyxi5fKxfwtud60RXiKE4hl1aOnk+0DYQ+ac=
X-Gm-Gg: AZuq6aJmCgLyPuVUawcVpUWgegm4nvbknt0ACcp/h9pJxzC/0zDikGt6IcV8v0EOWlJ
	bUCwTIsEqjkmXZa5dHBORrEmgvC3rBzswBBQHTolvJlBDTdeZR8fTjoQJmTJeQBblIAK9MkIdvH
	SRKRMejm5oVyqduMDvRUcXMBYoDz6TcpVrtptqH/2I0vLUSt9VhnDnnIK7wJRS0iQRgbbYclRS7
	B67aGmyA3SR4dJ9I4wy1VYJ8xjbxr/UtZx4wMSDsrTXd3v48se4g6CwGHSV3kRcmsuZK09yfo+j
	zoGa71ppMzFGBYqPRPr2qPx2XoGEsmS1jiqPOl8cfsXdIWkLM+XRw60nvMJvmby5Wd5SA3Th3Bg
	d3vd+C8dd8v7rPi3shhh/xsggQgGkVb4hyKSn+R4HzndPpnXcxGHA6y2ul2pzH0WlMLcQygc6HM
	nrU30jh37pMMm9UBQ62hKYF6x55aGsa17coYfy9yjdgTuCYxqcIWxswLHaVq20I+O7VEhet8Dxk
	LamGG09PqU5MQrhnVVJxqb2J3U/tVw2DnV4ykTPNJAxBFhwcOjFS311
X-Received: by 2002:a05:600c:8b63:b0:47e:e87f:4bba with SMTP id 5b1f17b1804b1-483a9637833mr86975115e9.29.1771767638156;
        Sun, 22 Feb 2026 05:40:38 -0800 (PST)
Received: from michaelstoler-MacBook-Pro.vastdata.com (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a42f3968sm75221035e9.19.2026.02.22.05.40.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Feb 2026 05:40:37 -0800 (PST)
From: Michael Stoler <michael.stoler@vastdata.com>
To: jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	Michael Stoler <michael.stoler@vastdata.com>
Subject: [PATCH] nfs: avoid triggering out-of-order write handling in nfs_setattr()
Date: Sun, 22 Feb 2026 15:40:19 +0200
Message-ID: <20260222134019.21516-1-michael.stoler@vastdata.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[vastdata.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[vastdata.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[vastdata.com:+];
	TAGGED_FROM(0.00)[bounces-19087-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.stoler@vastdata.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 172D916F3F9
X-Rspamd-Action: no action

    I’m seeing a performance issue with an NFS driver based on Linux 6.6. When
untar extracts an archive, it sets file attributes and timestamps after each
file is created. As a result, the inodes of these files are marked as OOO
(out-of-order write), which causes valid page cache to be dropped on subsequent
opens.
    This false OOO tagging occurs during the nfs_setattr() inode method. The
reason is that inode attributes are updated twice: first in the protocol version
specific method nfs*_proc_setattr(), and then again in nfs_setattr() itself via
nfs_refresh_inode(), even though the inode state has already been updated by
nfs_update_inode() in protocol-version-specific method. As a result,
nfs_refresh_inode() falsely detects the second attempt to apply the same file
attributes as an out-of-order operation and marks the inode with an OOO range.
    The proposed patch resolves this issue by eliminating the second inode
attribute update in nfs_refresh_inode() when the inode has already been updated.

Signed-off-by: Michael Stoler <michael.stoler@vastdata.com>
---
 fs/nfs/inode.c         | 10 ++++++----
 fs/nfs/nfs3proc.c      |  2 +-
 fs/nfs/nfs4proc.c      |  2 +-
 fs/nfs/proc.c          |  2 +-
 include/linux/nfs_fs.h |  2 +-
 5 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 0d7facfdafb9..13ac5dffd3e6 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -657,8 +657,6 @@ nfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	}
 
 	error = NFS_PROTO(inode)->setattr(dentry, fattr, attr);
-	if (error == 0)
-		error = nfs_refresh_inode(inode, fattr);
 	nfs_free_fattr(fattr);
 out:
 	trace_nfs_setattr_exit(inode, error);
@@ -709,9 +707,11 @@ static int nfs_vmtruncate(struct inode * inode, loff_t offset)
  * Note: we do this in the *proc.c in order to ensure that
  *       it works for things like exclusive creates too.
  */
-void nfs_setattr_update_inode(struct inode *inode, struct iattr *attr,
+int nfs_setattr_update_inode(struct inode *inode, struct iattr *attr,
 		struct nfs_fattr *fattr)
 {
+	int ret = 0;
+
 	/* Barrier: bump the attribute generation count. */
 	nfs_fattr_set_barrier(fattr);
 
@@ -780,8 +780,10 @@ void nfs_setattr_update_inode(struct inode *inode, struct iattr *attr,
 					| NFS_INO_INVALID_CTIME);
 	}
 	if (fattr->valid)
-		nfs_update_inode(inode, fattr);
+		ret = nfs_update_inode(inode, fattr);
 	spin_unlock(&inode->i_lock);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(nfs_setattr_update_inode);
 
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 715753f41fb0..dc9f33735cf2 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -144,7 +144,7 @@ nfs3_proc_setattr(struct dentry *dentry, struct nfs_fattr *fattr,
 	nfs_fattr_init(fattr);
 	status = rpc_call_sync(NFS_CLIENT(inode), &msg, 0);
 	if (status == 0) {
-		nfs_setattr_update_inode(inode, sattr, fattr);
+		status = nfs_setattr_update_inode(inode, sattr, fattr);
 		if (NFS_I(inode)->cache_validity & NFS_INO_INVALID_ACL)
 			nfs_zap_acl_cache(inode);
 	}
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index fe6986939bc9..a41c5b046205 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4436,7 +4436,7 @@ nfs4_proc_setattr(struct dentry *dentry, struct nfs_fattr *fattr,
 
 	status = nfs4_do_setattr(inode, cred, fattr, sattr, ctx, NULL);
 	if (status == 0) {
-		nfs_setattr_update_inode(inode, sattr, fattr);
+		status = nfs_setattr_update_inode(inode, sattr, fattr);
 		nfs_setsecurity(inode, fattr);
 	}
 	return status;
diff --git a/fs/nfs/proc.c b/fs/nfs/proc.c
index e3570c656b0f..edf3edf6720a 100644
--- a/fs/nfs/proc.c
+++ b/fs/nfs/proc.c
@@ -147,7 +147,7 @@ nfs_proc_setattr(struct dentry *dentry, struct nfs_fattr *fattr,
 	nfs_fattr_init(fattr);
 	status = rpc_call_sync(NFS_CLIENT(inode), &msg, 0);
 	if (status == 0)
-		nfs_setattr_update_inode(inode, sattr, fattr);
+		status = nfs_setattr_update_inode(inode, sattr, fattr);
 	dprintk("NFS reply setattr: %d\n", status);
 	return status;
 }
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 832b7e354b4e..a1bcec8d0992 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -434,7 +434,7 @@ extern bool nfs_mapping_need_revalidate_inode(struct inode *inode);
 extern int nfs_revalidate_mapping(struct inode *inode, struct address_space *mapping);
 extern int nfs_revalidate_mapping_rcu(struct inode *inode);
 extern int nfs_setattr(struct mnt_idmap *, struct dentry *, struct iattr *);
-extern void nfs_setattr_update_inode(struct inode *inode, struct iattr *attr, struct nfs_fattr *);
+extern int nfs_setattr_update_inode(struct inode *inode, struct iattr *attr, struct nfs_fattr *);
 extern void nfs_setsecurity(struct inode *inode, struct nfs_fattr *fattr);
 extern struct nfs_open_context *get_nfs_open_context(struct nfs_open_context *ctx);
 extern void put_nfs_open_context(struct nfs_open_context *ctx);
-- 
2.53.0


