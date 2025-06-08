Return-Path: <linux-nfs+bounces-12187-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4975AD1549
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Jun 2025 00:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 418E23AAC5E
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Jun 2025 22:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C771F8744;
	Sun,  8 Jun 2025 22:37:22 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD131F4E4F
	for <linux-nfs@vger.kernel.org>; Sun,  8 Jun 2025 22:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749422242; cv=none; b=UykxNuFBl7zPYrqVSUc6BEDmXEzvEjoiURfbBNtHnOh49Z/9+kkJlM9XlQX13dGAz/tNa0tnK3K93/pLyFsJq90/tiUNVgIAoMgq/rDT3Jh7MdFq8MX7bFTUNqOXLTjsSRSR++eTLYLOEePO9uwmymy/1BmXky3t73PcStNt/24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749422242; c=relaxed/simple;
	bh=tJC/KsjSqGVz1yJBAbbCiFIA4rzB/EiV3EubGasD0bw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=ub2SpyALhjibRxOpA7HJtLcAUJlizwsiQTZ0EUCvTY1796joFXDcbmIH6KRjg0cLj/i8RQS846Dtu/MndwcdO5cVwHP4NFCnGuzSVPOZiXzi0hS/Uh1bvT60NtqtgrhboSNwLjBhorIv02QcQ++olXA/R1yomOZUb0HA6knUgWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uOOIR-005sVR-3A;
	Sun, 08 Jun 2025 22:15:19 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [PATCH] nfs: use lock_two_nondirectories()
Date: Mon, 09 Jun 2025 08:15:17 +1000
Message-id: <174942091741.608730.3327223511347232829@noble.neil.brown.name>


Rather than open-coding this function call it to make intention clear
and to use "correct" nesting levels (parent and child are for
directories).

This is purely cosmetic with no expected change in behaviour.

Signed-off-by: NeilBrown <neil@brown.name>
---

 fs/nfs/nfs4file.c | 25 ++-----------------------
 1 file changed, 2 insertions(+), 23 deletions(-)

diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 5e9d66f3466c..53a958746bb0 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -253,7 +253,6 @@ static loff_t nfs42_remap_file_range(struct file *src_fil=
e, loff_t src_off,
 	struct nfs_server *server =3D NFS_SERVER(dst_inode);
 	struct inode *src_inode =3D file_inode(src_file);
 	unsigned int bs =3D server->clone_blksize;
-	bool same_inode =3D false;
 	int ret;
=20
 	/* NFS does not support deduplication. */
@@ -275,20 +274,8 @@ static loff_t nfs42_remap_file_range(struct file *src_fi=
le, loff_t src_off,
 			goto out;
 	}
=20
-	if (src_inode =3D=3D dst_inode)
-		same_inode =3D true;
-
 	/* XXX: do we lock at all? what if server needs CB_RECALL_LAYOUT? */
-	if (same_inode) {
-		inode_lock(src_inode);
-	} else if (dst_inode < src_inode) {
-		inode_lock_nested(dst_inode, I_MUTEX_PARENT);
-		inode_lock_nested(src_inode, I_MUTEX_CHILD);
-	} else {
-		inode_lock_nested(src_inode, I_MUTEX_PARENT);
-		inode_lock_nested(dst_inode, I_MUTEX_CHILD);
-	}
-
+	lock_two_nondirectories(src_inode, dst_inode);
 	/* flush all pending writes on both src and dst so that server
 	 * has the latest data */
 	ret =3D nfs_sync_inode(src_inode);
@@ -306,15 +293,7 @@ static loff_t nfs42_remap_file_range(struct file *src_fi=
le, loff_t src_off,
 		truncate_inode_pages_range(&dst_inode->i_data, dst_off, dst_off + count - =
1);
=20
 out_unlock:
-	if (same_inode) {
-		inode_unlock(src_inode);
-	} else if (dst_inode < src_inode) {
-		inode_unlock(src_inode);
-		inode_unlock(dst_inode);
-	} else {
-		inode_unlock(dst_inode);
-		inode_unlock(src_inode);
-	}
+	unlock_two_nondirectories(src_inode, dst_inode);
 out:
 	return ret < 0 ? ret : count;
 }
--=20
2.49.0


