Return-Path: <linux-nfs+bounces-16875-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFE7CA1423
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Dec 2025 20:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13E5D32F5B3E
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Dec 2025 18:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316B3330B30;
	Wed,  3 Dec 2025 15:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTJCyFXH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076AE330B2C;
	Wed,  3 Dec 2025 15:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764777141; cv=none; b=McNWH6HWIvhzPfGtvwxrngId5a2dduZZhL1LkkJHysqWgQChD7ERzbQld9Y4Q7Q6W9cxrnaBIPhNwFlpyF7rVtWPSQLQPhKen1JJftscXbbAtWi+r4vj71gmnBOubzOD2lCHIWn3aUt6jUdjfiDPhiGlB0e9lvZGejg4+QziLuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764777141; c=relaxed/simple;
	bh=7BfHN6AbfV/3XWphq1UqLC6aY8Kt9j+ITDN9fR0IN+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hJZajEZH6gy/ty++YE4FrtLvBCnJ0BsV6c5JJvzkarlPUsFAqaNxgbyk+8EFmIejGCj7wkHqTDO/hY/TUjvCGxeuZ8FFOacZdQQL6VcZtEu6KQwqnB+Ww0kcjbxDghwiVPnueeIAK/beVi3WYm6CiyfQGIOnyK7nB3vBx5QY0l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTJCyFXH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22510C116C6;
	Wed,  3 Dec 2025 15:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764777140;
	bh=7BfHN6AbfV/3XWphq1UqLC6aY8Kt9j+ITDN9fR0IN+A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JTJCyFXHKUHzKoJG3Lb86NmKhXKR/2KFkJQpNCtjBIPofmt/Z3SUCm5IPduKvuA2e
	 neV5ErfWFM4BZbmulwRKhW9zTyNrf8j2cxHfLevugQoEuF63nZ49kNpa6sVEn1REmQ
	 FKhUCfPQ8JGQh3/fV/q9pOPj8+CgMAZNOyKULl9xTrA7YSICOmJc0gkuq5MpuncOcc
	 qtZneoqrtMTO/XXVBEsldMAnYVuzNeY1GaCa1+sCHKL2qDUr0p5BFai8NzfeCWOruM
	 SmdrDaXw+YiLlf+VmuSM7+aySsceWeGTAPJUydQEzKC9mNL1MMNLwA4vtEHadJxlTh
	 KXzbqWdz5lI4g==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 03 Dec 2025 10:52:15 -0500
Subject: [PATCH 1/2] nfsd: use ATTR_DELEG in
 nfsd4_finalize_deleg_timestamps()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-nfsd-7-0-v1-1-653271980d7e@kernel.org>
References: <20251203-nfsd-7-0-v1-0-653271980d7e@kernel.org>
In-Reply-To: <20251203-nfsd-7-0-v1-0-653271980d7e@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1384; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=7BfHN6AbfV/3XWphq1UqLC6aY8Kt9j+ITDN9fR0IN+A=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpMFyyPvQrQuV53L0xsX6mZleciLGEpQB4JBpoW
 naetL4UzAmJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaTBcsgAKCRAADmhBGVaC
 FX3UD/0W+TsQKLGHSSRMNMnVO8evJn34RkIenLVLuW94f2sI1Hbw+iG1VNUW9+yY/UYfHUDY3aR
 r6xXEv9b69RGmXnTcGM4GmGHY3Jb9gCVqp0uaV1YXylGHDNOOvovI8USuOv6m1+yn07WU5qM4ov
 OPmhKGSuaHvyu1EB4XFxuRXCzrAMckAkFJqnpne8NT4/iVR3MxhX88LKJFJFf7sriIgsLUoux0W
 vbbxhb+XOLtSA0Rp7B93LN+y5bCu1xTDDhTNwTjYOtFeiDcCEjuCnFKndiTMY1+RO8YBwLYlcS4
 rO9UfkJgVtbDmbG9TbBQs7ttR67j/r3fiFwhQCLig4sGnTYHbAq7guCE6zgB/q1LtbjC+T5XgAZ
 +qqf2IXbmjAdjM2QHaYOAVKtipE9ejFpSghvcBZ9u8LGOze1tL36wNpErC1drsSoSo6yRjC3IwE
 DiOT4OHSk4/GAj1zaO/8UykIWZVg+cShNm5/4/aawb3xTK7Xw6unrEtEKnEQzIQFj2SPh5ppe7z
 vOb7RXYG6wztmjtIwrbviiLEW2dZbMkltVcWuReyIf720jOWkivpMuyMUYX0lUrGnqvR083UXvP
 Y0Tgbh1m85qMPoYADiukxCRNpp+EB0UjddUdCVw5FypEvcc05UBE8rz13NGWX727nKg+oj6HWql
 mVrGU3t2bvAVDdw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

When finalizing timestamps that have never been updated and preparing to
release the delegation lease, the notify_change() call can trigger a
delegation break, and fail to update the timestamps. When this happens,
there will be messages like this in dmesg:

    [ 2709.375785] Unable to update timestamps on inode 00:39:263: -11

Since this code is going to release the lease just after updating the
timestamps, breaking the delegation is undesirable. Fix this by setting
ATTR_DELEG in ia_valid, in order to avoid the delegation break.

Fixes: e5e9b24ab8fa ("nfsd: freeze c/mtime updates with outstanding WRITE_ATTRS delegation")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 1ef560be2d714c138bc8210d9e7dca50a670a342..b0111104e969057486a4b878fffb84b84ca97b7b 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1226,7 +1226,7 @@ static void put_deleg_file(struct nfs4_file *fp)
 
 static void nfsd4_finalize_deleg_timestamps(struct nfs4_delegation *dp, struct file *f)
 {
-	struct iattr ia = { .ia_valid = ATTR_ATIME | ATTR_CTIME | ATTR_MTIME };
+	struct iattr ia = { .ia_valid = ATTR_ATIME | ATTR_CTIME | ATTR_MTIME | ATTR_DELEG };
 	struct inode *inode = file_inode(f);
 	int ret;
 

-- 
2.52.0


