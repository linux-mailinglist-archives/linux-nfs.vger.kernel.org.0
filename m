Return-Path: <linux-nfs+bounces-14122-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7997B48240
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Sep 2025 03:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEC5E189AFEA
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Sep 2025 01:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651D42AE99;
	Mon,  8 Sep 2025 01:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="J383927S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h6lbBB31"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921AD185E4A
	for <linux-nfs@vger.kernel.org>; Mon,  8 Sep 2025 01:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757295863; cv=none; b=MJBwUPZkrdbzUmU+fSnx8/pqSMN/jTbS1JOSLAcB8y+ZPnsR89D6xXNMr3WNuGv8qskEivU85XYWjCiJArhv4T2Loo1UMWsr8BcPys2WFdXsfAKCHPKpgPPcWDNgYcj9PVLkfa1wLTSKnIyoq7T1cBi1rXt+Jmyka0EZ0uEpWNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757295863; c=relaxed/simple;
	bh=xjWHnbcXE72J9xDMletCGdIEqM/aZDNByAIps5V8yoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NwXqEiB+EjHeHfnkphodTUyKT7iiJOCTLbR3O2EllveKjwIbZDkA/8eL4kCajTB/2iWSJ0yrKQvqYTmBck3FUDkgFxFpc1GgwibNRzRHbTq7G1y0NBwvi7aterztOHdZNB2vnfpacNEbPFSAqx4vlB+LXKybN8TlLc4slPGMnvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=J383927S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h6lbBB31; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4DC27140003D;
	Sun,  7 Sep 2025 21:44:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 07 Sep 2025 21:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1757295859; x=
	1757382259; bh=Xq45D/HlQx2Gdd/vMnX7fXMCFIi+lFDyjc8Z8/jec0A=; b=J
	383927SBQl3FZRYqcrWRJCmYLSVaNDkvXOhcVs+IEPioodFe5QOOM3d7KN/fidk0
	KX7DWs1DclriZtcPT2B9y8qW6eG48H9l6QOLdAvOiIT//KJ0xDD0Bd0yJSs88yfN
	J2i+bMtrtpvwuVhlnVKb+FhFnvI++SJNHkAo7+ZCQNxtwaOnex07h21l5/YVvaoq
	WD8kOVPCofK4TNVXfssTvKOltfqfR2ryVzKHjl8oQMsVl6e+GvdZSY17ejffwmVn
	gd4v4l86T+mJhE0Q5iDwxBfj2EcPUHGNHb/WWyAgLSdrIGWoGGmEwP3kfz4VNjrs
	9OTPpyDpeLX8pMykeKXTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757295859; x=1757382259; bh=X
	q45D/HlQx2Gdd/vMnX7fXMCFIi+lFDyjc8Z8/jec0A=; b=h6lbBB31ZRwB8rcqM
	CWWGh/csioPIDTbcC/BXZvzcWZVXinxsNaxiBUTZ1/1QFYtwuqDkvEE5xUOeDs1o
	9TO+z63rdeXZbVRnXd2axPOakU1nlXRJAp9+6XwzlFjVq/darpL8K3czAz6VxswK
	DmOuOKgfQq3EOEzBh/d7RkruxeeJQL2rjp+FSGr1qfx27GYWel4jkG8UlPOPCUfC
	AJVwDCqBHCHHmKWFBCKTht0ENZkW9kEvNECZxazXYIku+M5A46w1SxPPxvtE8wfn
	g6Mfwekcjy+/+e9am77yHdKDeEQ6gcG3SyRHYeYA7JTAzVHEfrcxsVR1/2Osbyr+
	qxWyA==
X-ME-Sender: <xms:8zS-aP8kb9N5Rc_QX2MAeP0CtjzHPYPg1PF1bid51icXLbc3fvScRw>
    <xme:8zS-aEI1Z2cPl1ivtVxpzFParDdxBn6Mi-4-1oQcxHhqIIGmfuXWPVSPXgcJbjhQZ
    TkbAY70FydWsg>
X-ME-Received: <xmr:8zS-aNdokPlLa4hI0agbUWPbiRRKhCBdKpxE3EF6l4tAaG27aep_ADrKcMoYTMugZ56457x5ZIfnE3Y-DBR7Z3KFqp7CU_vyHa3J0C7TmQy7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedvhecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:8zS-aL-cV39cD3-LqpQwuRPpuCJ4TRPmjonppqYJ3k_AmJ-ze-jGyw>
    <xmx:8zS-aCp2ZaC-LwRjT1vwU6KisFPTfTPZzRu9QvcpTEEk-zwskPjmhQ>
    <xmx:8zS-aICCHdz8w63pJDe6fLLDZrNZEdxcpmk6Ty_NGpMdGxz3dBdcFg>
    <xmx:8zS-aMyUnYj_V20iMJPLknltqZr-__3g4nW0bTd4V5sKAf-yAqAkSA>
    <xmx:8zS-aBEcim8GRaQhsFgTQho6B58WzLI8zDPxw6JXpTvaN9YrIjW5KmBW>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Sep 2025 21:44:17 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] nfsd: change nfs4_client_to_reclaim() to allocate data
Date: Mon,  8 Sep 2025 11:38:33 +1000
Message-ID: <20250908014348.329348-3-neilb@ownmail.net>
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

The calling convention for nfs4_client_to_reclaim() is clumsy in that
the caller need to free memory if the function fails.  It is much
cleaner if the function frees its own memory.

This patch changes nfs4_client_to_reclaim() to re-allocate the .data
fields to be stored in the newly allocated struct nfs4_client_reclaim,
and to free everything on failure.

__cld_pipe_inprogress_downcall() needs to allocate the data anyway to
copy it from user-space, so now that data is allocated twice.  I think
that is a small price to pay for a cleaner interface.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4recover.c | 67 +++++++++++++++----------------------------
 fs/nfsd/nfs4state.c   | 22 ++++++++++++--
 2 files changed, 42 insertions(+), 47 deletions(-)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 990fe3d958ed..1605538ecb80 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -147,24 +147,13 @@ legacy_recdir_name_error(struct nfs4_client *clp, int error)
 
 static void
 __nfsd4_create_reclaim_record_grace(struct nfs4_client *clp,
-		const char *dname, int len, struct nfsd_net *nn)
+				    char *dname, struct nfsd_net *nn)
 {
-	struct xdr_netobj name;
+	struct xdr_netobj name = { .len = strlen(dname), .data = dname };
 	struct xdr_netobj princhash = { .len = 0, .data = NULL };
 	struct nfs4_client_reclaim *crp;
 
-	name.data = kmemdup(dname, len, GFP_KERNEL);
-	if (!name.data) {
-		dprintk("%s: failed to allocate memory for name.data!\n",
-			__func__);
-		return;
-	}
-	name.len = len;
 	crp = nfs4_client_to_reclaim(name, princhash, nn);
-	if (!crp) {
-		kfree(name.data);
-		return;
-	}
 	crp->cr_clp = clp;
 }
 
@@ -223,8 +212,7 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
 	inode_unlock(d_inode(dir));
 	if (status == 0) {
 		if (nn->in_grace)
-			__nfsd4_create_reclaim_record_grace(clp, dname,
-					HEXDIR_LEN, nn);
+			__nfsd4_create_reclaim_record_grace(clp, dname, nn);
 		vfs_fsync(nn->rec_file, 0);
 	} else {
 		printk(KERN_ERR "NFSD: failed to write recovery record"
@@ -461,7 +449,7 @@ nfsd4_recdir_purge_old(struct nfsd_net *nn)
 static int
 load_recdir(struct dentry *parent, char *cname, struct nfsd_net *nn)
 {
-	struct xdr_netobj name;
+	struct xdr_netobj name = { .len = HEXDIR_LEN, .data = cname };
 	struct xdr_netobj princhash = { .len = 0, .data = NULL };
 
 	if (strlen(cname) != HEXDIR_LEN - 1) {
@@ -470,16 +458,7 @@ load_recdir(struct dentry *parent, char *cname, struct nfsd_net *nn)
 		/* Keep trying; maybe the others are OK: */
 		return 0;
 	}
-	name.data = kstrdup(cname, GFP_KERNEL);
-	if (!name.data) {
-		dprintk("%s: failed to allocate memory for name.data!\n",
-			__func__);
-		goto out;
-	}
-	name.len = HEXDIR_LEN;
-	if (!nfs4_client_to_reclaim(name, princhash, nn))
-		kfree(name.data);
-out:
+	nfs4_client_to_reclaim(name, princhash, nn);
 	return 0;
 }
 
@@ -777,6 +756,8 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v2 __user *cmsg,
 {
 	uint8_t cmd, princhashlen;
 	struct xdr_netobj name, princhash = { .len = 0, .data = NULL };
+	char *namecopy __free(kfree) = NULL;
+	char *princhashcopy __free(kfree) = NULL;
 	uint16_t namelen;
 
 	if (get_user(cmd, &cmsg->cm_cmd)) {
@@ -794,19 +775,19 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v2 __user *cmsg,
 				dprintk("%s: invalid namelen (%u)", __func__, namelen);
 				return -EINVAL;
 			}
-			name.data = memdup_user(&ci->cc_name.cn_id, namelen);
-			if (IS_ERR(name.data))
-				return PTR_ERR(name.data);
+			namecopy = memdup_user(&ci->cc_name.cn_id, namelen);
+			if (IS_ERR(namecopy))
+				return PTR_ERR(namecopy);
+			name.data = namecopy;
 			name.len = namelen;
 			get_user(princhashlen, &ci->cc_princhash.cp_len);
 			if (princhashlen > 0) {
-				princhash.data = memdup_user(
-						&ci->cc_princhash.cp_data,
-						princhashlen);
-				if (IS_ERR(princhash.data)) {
-					kfree(name.data);
-					return PTR_ERR(princhash.data);
-				}
+				princhashcopy = memdup_user(
+					&ci->cc_princhash.cp_data,
+					princhashlen);
+				if (IS_ERR(princhashcopy))
+					return PTR_ERR(princhashcopy);
+				princhash.data = princhashcopy;
 				princhash.len = princhashlen;
 			} else
 				princhash.len = 0;
@@ -820,9 +801,10 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v2 __user *cmsg,
 				dprintk("%s: invalid namelen (%u)", __func__, namelen);
 				return -EINVAL;
 			}
-			name.data = memdup_user(&cnm->cn_id, namelen);
-			if (IS_ERR(name.data))
-				return PTR_ERR(name.data);
+			namecopy = memdup_user(&cnm->cn_id, namelen);
+			if (IS_ERR(namecopy))
+				return PTR_ERR(namecopy);
+			name.data = namecopy;
 			name.len = namelen;
 		}
 #ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
@@ -830,15 +812,12 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v2 __user *cmsg,
 			struct cld_net *cn = nn->cld_net;
 
 			name.len = name.len - 5;
-			memmove(name.data, name.data + 5, name.len);
+			name.data = name.data + 5;
 			cn->cn_has_legacy = true;
 		}
 #endif
-		if (!nfs4_client_to_reclaim(name, princhash, nn)) {
-			kfree(name.data);
-			kfree(princhash.data);
+		if (!nfs4_client_to_reclaim(name, princhash, nn))
 			return -EFAULT;
-		}
 		return nn->client_tracking_ops->msglen;
 	}
 	return -EFAULT;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index e45f67924bd0..fa073353f30b 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -8801,9 +8801,6 @@ nfs4_has_reclaimed_state(struct xdr_netobj name, struct nfsd_net *nn)
 
 /*
  * failure => all reset bets are off, nfserr_no_grace...
- *
- * The caller is responsible for freeing name.data if NULL is returned (it
- * will be freed in nfs4_remove_reclaim_record in the normal case).
  */
 struct nfs4_client_reclaim *
 nfs4_client_to_reclaim(struct xdr_netobj name, struct xdr_netobj princhash,
@@ -8812,6 +8809,22 @@ nfs4_client_to_reclaim(struct xdr_netobj name, struct xdr_netobj princhash,
 	unsigned int strhashval;
 	struct nfs4_client_reclaim *crp;
 
+	name.data = kmemdup(name.data, name.len, GFP_KERNEL);
+	if (!name.data) {
+		dprintk("%s: failed to allocate memory for name.data!\n",
+			__func__);
+		return NULL;
+	}
+	if (princhash.len) {
+		princhash.data = kmemdup(princhash.data, princhash.len, GFP_KERNEL);
+		if (!princhash.data) {
+			dprintk("%s: failed to allocate memory for princhash.data!\n",
+				__func__);
+			kfree(name.data);
+			return NULL;
+		}
+	} else
+		princhash.data = NULL;
 	crp = alloc_reclaim();
 	if (crp) {
 		strhashval = clientstr_hashval(name);
@@ -8823,6 +8836,9 @@ nfs4_client_to_reclaim(struct xdr_netobj name, struct xdr_netobj princhash,
 		crp->cr_princhash.len = princhash.len;
 		crp->cr_clp = NULL;
 		nn->reclaim_str_hashtbl_size++;
+	} else {
+		kfree(name.data);
+		kfree(princhash.data);
 	}
 	return crp;
 }
-- 
2.50.0.107.gf914562f5916.dirty


