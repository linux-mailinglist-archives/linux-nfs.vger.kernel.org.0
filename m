Return-Path: <linux-nfs+bounces-18037-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45572D38427
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 19:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5784E3002D0A
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 18:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E8C396B66;
	Fri, 16 Jan 2026 18:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTMQkRg0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D72730214B;
	Fri, 16 Jan 2026 18:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768587744; cv=none; b=b4V9v9AWAEAGYZVqvY5M0XjnSOfX0dtbM/+HRIVJEk1OSsQSRKARX0RZQ3IWKeZiFm8ORj4Kwbklsa0fRCzHddWIk8cbXs/PVoE0sZlwaTaEZjRZ6bShqbLZBTu/x+rSUuORTiP4zJAuvbYcRkGF+sMx4UnjBm0Q+WU8IlM5w54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768587744; c=relaxed/simple;
	bh=KvUKfB1aWv3UdHZuQP8kc/9oZVUdkmq0P9u8HDm10TE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mfJRW7PyfaehKYKtAtxvVz8nIfX1+dD9nI+FTpwzwROp8MuSERfBr1hGvGrXwxomF+GrnqOTm4NrqN0c43Sx/AMRa7msBS9xR6w8VgfwU21w1hplhapkToBCTUJtfIT62/00GaGcGj0TRyrmwaStAhTtX0sPH/FNnKGdrKMrWPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTMQkRg0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC01C116C6;
	Fri, 16 Jan 2026 18:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768587743;
	bh=KvUKfB1aWv3UdHZuQP8kc/9oZVUdkmq0P9u8HDm10TE=;
	h=From:Date:Subject:To:Cc:From;
	b=QTMQkRg0HVevhY/kvE2N9ptRqvoH1lkcR50pU23BdLB6XaNS/3d/fEFspvY2r085J
	 HNw5/dLRFb1Q9VXiPEX0DLafKtg2dutAyyKgoAR7GIUyBf1y4Gn+Ujip4iy7VzdF8v
	 zkJln/Ab7eScj/KK6bVKge71DKmKxJQSUr/WFzt6nf+TeA1NcTZU0Ny2dCjD5yvvHc
	 2bTftzCnDpGfkMOlPHd2i9wp3+jaNSnp572HP0CQ9NxQFWxo/KBeEt3Ka+3Qf3pT3K
	 JESOI7E1v01qj50OVmk8PanfPTEf58hsHYf2zyVuHnxgk0u513bQX+7oLTMTXlyZ5y
	 UorZTg64d+GsA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 16 Jan 2026 13:22:19 -0500
Subject: [PATCH] nfsd: fix NULL pointer dereference in check_export()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-nfsd-fixes-v1-1-019689b72747@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2LQQqAIBAAvyJ7TtA9aPWV6BC61l4sXIhA+ntLx
 2FmOgg1JoHZdGh0s/BZFfxgIB1b3clyVgZ0GJz3wdYi2RZ+SOyYHE4YMXoKoMPV6BfaL+v7fgx
 8spJcAAAA
X-Change-ID: 20260116-nfsd-fixes-8c02927271e6
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3100; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=KvUKfB1aWv3UdHZuQP8kc/9oZVUdkmq0P9u8HDm10TE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpaoHe+J+xOrx7LDOqPPzl2MzyxqNWYKyRS/LYJ
 EzoQNyPIHqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWqB3gAKCRAADmhBGVaC
 FaU3D/9CEyRCaGWuAmWSugqdVu6irDjqgX1zC4B/aFpEWN2d/7+gk9n+p4FGsgUkwnUIRQmv1DX
 /ZHlqxtDs+IugxNcXuN1BmTqkTb1QrDLjthsznuiD3y+w3oKQb+snQ4elwW6qPXLi8QLiQpjkKH
 x54W/vPPBjVTJO9odOCCnL6iq6H51SBuo2FQOK6RKaU1JIkqnjYh7vvj175r89RfW83GpaNkRjH
 51N7+KB9mpVob+DP1ICERcz2S6ftG3I3EsTcq29hzkq+hsNYfkIqU8qOJlVpDRQMBjINsLXrw5l
 yaA93rJkYlCmIcvuQE6CfX7+en4Oq/rTibn3rDJFYjGNIS2mEd+zAP9G6+eoZI+F2BXIHCttfW8
 hYZQnS/S949Gqsx+rKeFePLYjzMHB1SAGUF2tnrhPCeJfPV6KAYKYxCd+DVf3JGTLglwWaRtf3f
 eo/tdkRlQqUDB1PmchMnnmyR6vWazZE0LNg5sl804ST0pqVy47L3nA69FkKcDgYBWgFOkaaGHTa
 sASeWufvA6UZUDLAkzM9bk4LKOMev2q+Vvp6FNhrIkaFw32d9vOS2ZJy4fcora0iVr11m1FYPmy
 E1349Br1N+qpwFvt4nos8EplKcRS2DH/f1lzWxao4Q5Lk+lX6AuOzePycyp0Y/QpYJB0R6ESvtU
 MFZUEw9VR3wO5+g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Given the right export table, it's possible to trigger a NULL pointer
dereference when mountd sends a path that has no export operations.
Check that the export_ops are set and just return -EINVAL if not.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Triggering this required a rather pathological export table (I just
exported "/"). Given that, I'm on the fence as to whether we want to
send this to stable.
---
 fs/nfsd/export.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 2a1499f2ad196a6033787260881e451146283bdc..4187c109d84985d33a69e19291edbf2b27b257d8 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -405,6 +405,7 @@ static struct svc_export *svc_export_lookup(struct svc_export *);
 static int check_export(const struct path *path, int *flags, unsigned char *uuid)
 {
 	struct inode *inode = d_inode(path->dentry);
+	struct export_operations *export_op = inode->i_sb->s_export_op;
 
 	/*
 	 * We currently export only dirs, regular files, and (for v4
@@ -422,14 +423,20 @@ static int check_export(const struct path *path, int *flags, unsigned char *uuid
 	if (*flags & NFSEXP_V4ROOT)
 		*flags |= NFSEXP_READONLY;
 
-	/* There are two requirements on a filesystem to be exportable.
-	 * 1:  We must be able to identify the filesystem from a number.
+	/* There are four requirements on a filesystem to be exportable:
+	 * 1: It must define sb->s_export_op
+	 * 2: We must be able to identify the filesystem from a number.
 	 *       either a device number (so FS_REQUIRES_DEV needed)
 	 *       or an FSID number (so NFSEXP_FSID or ->uuid is needed).
-	 * 2:  We must be able to find an inode from a filehandle.
+	 * 3: We must be able to find an inode from a filehandle.
 	 *       This means that s_export_op must be set.
-	 * 3: We must not currently be on an idmapped mount.
+	 * 4: We must not currently be on an idmapped mount.
 	 */
+	if (!export_op) {
+		dprintk("%s: fs doesn't define export_operations!\n", __func__);
+		return -EINVAL;
+	}
+
 	if (!(inode->i_sb->s_type->fs_flags & FS_REQUIRES_DEV) &&
 	    !(*flags & NFSEXP_FSID) &&
 	    uuid == NULL) {
@@ -437,7 +444,7 @@ static int check_export(const struct path *path, int *flags, unsigned char *uuid
 		return -EINVAL;
 	}
 
-	if (!exportfs_can_decode_fh(inode->i_sb->s_export_op)) {
+	if (!exportfs_can_decode_fh(export_op)) {
 		dprintk("exp_export: export of invalid fs type.\n");
 		return -EINVAL;
 	}
@@ -447,7 +454,7 @@ static int check_export(const struct path *path, int *flags, unsigned char *uuid
 		return -EINVAL;
 	}
 
-	if (inode->i_sb->s_export_op->flags & EXPORT_OP_NOSUBTREECHK &&
+	if (export_op->flags & EXPORT_OP_NOSUBTREECHK &&
 	    !(*flags & NFSEXP_NOSUBTREECHECK)) {
 		dprintk("%s: %s does not support subtree checking!\n",
 			__func__, inode->i_sb->s_type->name);

---
base-commit: 983d014aafb14ee5e4915465bf8948e8f3a723b5
change-id: 20260116-nfsd-fixes-8c02927271e6

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


