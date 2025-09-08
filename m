Return-Path: <linux-nfs+bounces-14121-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D19B4823F
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Sep 2025 03:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 203743C147F
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Sep 2025 01:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08B3185E4A;
	Mon,  8 Sep 2025 01:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="i+E+EK3X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i2KQLa7Y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6F22AE99
	for <linux-nfs@vger.kernel.org>; Mon,  8 Sep 2025 01:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757295857; cv=none; b=kv/ImXdBmoFwkqaX0kDsHP46L1OPLPNxO7V1/S3KuPowjNEu3jAt+ry/uyXQ0UqtlrZmGH2KRdH6nQHUSLVUrdbnO79hs/GKTMsBk5Pl2w0ZfiinYcKswPPOmvxeFqmY8Y6vBEL28B4gGlzw8rnXE/ePBQ2QIhwswG60O3rOHG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757295857; c=relaxed/simple;
	bh=6NRnTZXBR3UqKAge/f06oSUPVC6oPlPSCAytxjtdoCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9ss/sUQovkuoHWz7mvqdyXGqn0It2Tg02a6b24KX8I8Ldu5SDnWBLi/WDL0elK1ZOXLm8MwMTRfc5/yjdMQOZaxPLnDhMDFbaDqmZS+WndX2zu+smOQOQHzlwL/nydXD20vfs0hI368jGrPw/yW4EccJOH7h8webBNSwIqJJ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=i+E+EK3X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i2KQLa7Y; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2ECD1140003D;
	Sun,  7 Sep 2025 21:44:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Sun, 07 Sep 2025 21:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1757295855; x=
	1757382255; bh=AQwZOb54L2bcoYw/Dd0Jy0z4lOJ9CNnE+uQF9o5oVkM=; b=i
	+E+EK3XgBz4QMrUv+gBuOfAMs+0sxUW42fZ2DHA7DCVyClA1CckIBfFTWvrpIh3D
	QAeFxgVt4zzgnKR3fNB/Y6lrKjmZiKHIE2oOxm2rpIcbh9fFv6CS+iPA1MzJZJ7R
	aFSX75eKwUCXPD8ASjK9hcF/K1+yV1ghrD4meA74blT490CS500AE+3yCTnamtqN
	n7BL5voSh6x1caGGuc9QxVAuCdfKovgWy6AarSIEytB0H47HCv3A3O+rMOPSMwA3
	Px/boPeYo1x2QwfKg0gko66gjkpyMT3bC7tucTTh5awwinwtqHFESnw9wTwMrU4G
	9FY9ykV1fThxN+lk/11PA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757295855; x=1757382255; bh=A
	QwZOb54L2bcoYw/Dd0Jy0z4lOJ9CNnE+uQF9o5oVkM=; b=i2KQLa7YQPPh65m0t
	FMV/y0+taNkTwo6LdTjcBIf7D09nCrCYZZnQ59YR0TZr2+vrelejKM4UexlKZmIc
	wqO23QCFSkUuX70114bFgLTq7IhTdHs9Wq61s755H6WWKBWCdEP7+4V0edHRHtf6
	jmsqwwe5ihDLhdkUMXlv59StEr9FVW3BNOIAv+FTtCp/Ri5HpNBlL46P30mCkRyb
	GHOsdDxFujLJGeQbCHOD7AcpMu5xw6YDKKSh2ApwzTg8Cig0EMW1njfYktH8dSP5
	P8zSy51i9YxaH1M9SC7Kgeb43+EcxpfrQU5njI8lPmUdtaxWfkwlvTBno1VocmSJ
	kLTEA==
X-ME-Sender: <xms:7jS-aNBt6veJiQSauaXk9X3O755wePQWy_pPlg1njEv9h1ivppNjoA>
    <xme:7jS-aD_8_BHjtZePYwi0_HqUHfI54pyXOIcAZ4fMHXdo3XMBNWypa8X6yYjWKT9kg
    Sb4tNGTgs9oMQ>
X-ME-Received: <xmr:7jS-aJBwWQOJ3Ms1AjY64TkVH8GVroAcUrHeYZSW_qVFI_7ibzxBG1BxIbZctujPFeKvD2Uw7s5apxB7Eu1TqF1wYuSBgUSD6o2jaA6a29pK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheurhho
    fihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepue
    ekvdehhfegtddufffhjeehfeeiueffgeeltdeuhefhtdffteejtdejtedvjeetnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsgesoh
    ifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhnihgv
    vhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrg
    gtlhgvrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhmpdhr
    tghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:7zS-aIQcbNPRU4tgib6DnAoI9fLOLljzA3ZuYtaCSsuUeJ4iwdEF2w>
    <xmx:7zS-aAvbhndAWbYq2nq29S2gpMmjIP6nmQf2qdepXd_92DuamL9GXw>
    <xmx:7zS-aE2cY5Op3qYIbLhvnh3_LNB-vYm-Scz7G6gIcNgGAQJ8RuZIOw>
    <xmx:7zS-aBW_oBvE5bCnA2nql6fPhgrQCoOfbkNWo119uTExn0NTenAuYw>
    <xmx:7zS-aCNFwbH9fJMt1z7wjo85AHMKWOGyU4O-i0XJU5w8CGWKNr_ag7-i>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Sep 2025 21:44:13 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] nfsd: move name lookup out of nfsd4_list_rec_dir()
Date: Mon,  8 Sep 2025 11:38:32 +1000
Message-ID: <20250908014348.329348-2-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250908014348.329348-1-neilb@ownmail.net>
References: <20250908014348.329348-1-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

nfsd4_list_rec_dir() is called with two different callbacks.
One of the callbacks uses vfs_rmdir() to remove the directory.
The other doesn't use the dentry at all, just the name.

As only one callback needs the dentry, this patch moves the lookup into
that callback.  This prepares of changes to how directory operations
are locked.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4recover.c | 50 +++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index e2b9472e5c78..990fe3d958ed 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -237,7 +237,7 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
 	nfs4_reset_creds(original_cred);
 }
 
-typedef int (recdir_func)(struct dentry *, struct dentry *, struct nfsd_net *);
+typedef int (recdir_func)(struct dentry *, char *, struct nfsd_net *);
 
 struct name_list {
 	char name[HEXDIR_LEN];
@@ -291,24 +291,14 @@ nfsd4_list_rec_dir(recdir_func *f, struct nfsd_net *nn)
 	}
 
 	status = iterate_dir(nn->rec_file, &ctx.ctx);
-	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
 
 	list_for_each_entry_safe(entry, tmp, &ctx.names, list) {
-		if (!status) {
-			struct dentry *dentry;
-			dentry = lookup_one(&nop_mnt_idmap,
-					    &QSTR(entry->name), dir);
-			if (IS_ERR(dentry)) {
-				status = PTR_ERR(dentry);
-				break;
-			}
-			status = f(dir, dentry, nn);
-			dput(dentry);
-		}
+		if (!status)
+			status = f(dir, entry->name, nn);
+
 		list_del(&entry->list);
 		kfree(entry);
 	}
-	inode_unlock(d_inode(dir));
 	nfs4_reset_creds(original_cred);
 
 	list_for_each_entry_safe(entry, tmp, &ctx.names, list) {
@@ -406,18 +396,19 @@ nfsd4_remove_clid_dir(struct nfs4_client *clp)
 }
 
 static int
-purge_old(struct dentry *parent, struct dentry *child, struct nfsd_net *nn)
+purge_old(struct dentry *parent, char *cname, struct nfsd_net *nn)
 {
 	int status;
+	struct dentry *child;
 	struct xdr_netobj name;
 
-	if (child->d_name.len != HEXDIR_LEN - 1) {
+	if (strlen(cname) != HEXDIR_LEN - 1) {
 		printk("%s: illegal name %pd in recovery directory\n",
 				__func__, child);
 		/* Keep trying; maybe the others are OK: */
 		return 0;
 	}
-	name.data = kmemdup_nul(child->d_name.name, child->d_name.len, GFP_KERNEL);
+	name.data = kstrdup(cname, GFP_KERNEL);
 	if (!name.data) {
 		dprintk("%s: failed to allocate memory for name.data!\n",
 			__func__);
@@ -427,10 +418,17 @@ purge_old(struct dentry *parent, struct dentry *child, struct nfsd_net *nn)
 	if (nfs4_has_reclaimed_state(name, nn))
 		goto out_free;
 
-	status = vfs_rmdir(&nop_mnt_idmap, d_inode(parent), child);
-	if (status)
-		printk("failed to remove client recovery directory %pd\n",
-				child);
+	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
+	child = lookup_one(&nop_mnt_idmap, &QSTR(cname), parent);
+	if (!IS_ERR(child)) {
+		status = vfs_rmdir(&nop_mnt_idmap, d_inode(parent), child);
+		if (status)
+			printk("failed to remove client recovery directory %pd\n",
+			       child);
+		dput(child);
+	}
+	inode_unlock(d_inode(parent));
+
 out_free:
 	kfree(name.data);
 out:
@@ -461,18 +459,18 @@ nfsd4_recdir_purge_old(struct nfsd_net *nn)
 }
 
 static int
-load_recdir(struct dentry *parent, struct dentry *child, struct nfsd_net *nn)
+load_recdir(struct dentry *parent, char *cname, struct nfsd_net *nn)
 {
 	struct xdr_netobj name;
 	struct xdr_netobj princhash = { .len = 0, .data = NULL };
 
-	if (child->d_name.len != HEXDIR_LEN - 1) {
-		printk("%s: illegal name %pd in recovery directory\n",
-				__func__, child);
+	if (strlen(cname) != HEXDIR_LEN - 1) {
+		printk("%s: illegal name %s in recovery directory\n",
+				__func__, cname);
 		/* Keep trying; maybe the others are OK: */
 		return 0;
 	}
-	name.data = kmemdup_nul(child->d_name.name, child->d_name.len, GFP_KERNEL);
+	name.data = kstrdup(cname, GFP_KERNEL);
 	if (!name.data) {
 		dprintk("%s: failed to allocate memory for name.data!\n",
 			__func__);
-- 
2.50.0.107.gf914562f5916.dirty


