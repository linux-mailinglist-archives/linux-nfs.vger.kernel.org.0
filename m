Return-Path: <linux-nfs+bounces-11776-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC3DAB9F63
	for <lists+linux-nfs@lfdr.de>; Fri, 16 May 2025 17:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FD5E1BC48A0
	for <lists+linux-nfs@lfdr.de>; Fri, 16 May 2025 15:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052C11DDC0F;
	Fri, 16 May 2025 15:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhghM0d2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D429B1AD3E5
	for <linux-nfs@vger.kernel.org>; Fri, 16 May 2025 15:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747407612; cv=none; b=GaSUmt5NwjpGEV8GlgPdaJZoo5A0CBo6cqYMrtlX9ifx/2IPkg+jeEFno0rUJUPO3A5Q1G8Sb05Z6F3Abq0hca/pyPf6CwHZl2WPSLY+jJrVSu6kX1U8DM6nR8sF3PC0Qr8rvl5Z7gqmvTm7ATeGYhdn72shXo5OPebVWVwqQ4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747407612; c=relaxed/simple;
	bh=N4QeW+OGcP5Z68H5B+mrWW3JaPNPXGgpgFLuaqqMbgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OjTfeTHZqQ2UcGWKPSI8hLwZSgSXgjIfrw1hzUSIWlb0J0567lKNdtSTNFQIrlyDq5IgM3hKrzm8mz+KZEleEqi9HUSJsxHWL1YIrsCE3FcQO+VEb5eDvU5LacpjN0deQ8y9Oz8zcYeVgKqzzLcE4dA8KXgWi0ySnpkB6wEAd+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhghM0d2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA830C4CEED;
	Fri, 16 May 2025 15:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747407612;
	bh=N4QeW+OGcP5Z68H5B+mrWW3JaPNPXGgpgFLuaqqMbgY=;
	h=From:To:Cc:Subject:Date:From;
	b=RhghM0d2stmrKZvFLa9bC/frt94e8hG+mhpZtrEGnRQONqXlUvGv3gulupA0yn8ev
	 SyW6pnO0ee6m59p58as6HXJmFsStS8jmqub2z8gWJpK1ajG/Y/vwv1fuX0PsZpvstE
	 fpOsG16SUyi5Gf6KcyVzjtSeU87AgNwd71DwLx12bjceEV9Y1liq0meJ78dTnxKHM0
	 85mO04Jg/YCOwrRnjMwgSpwghTYHAvw1eyfUZlbfBkEgAuBQAa2te54oHgwLYgYCrT
	 48rIM25cJqFZ9Kqxj4QCdEOEmFMUH2sr+bq/lyO+dD4TStkP3jLsURZWgI/Njds86a
	 /RugvNjYEr4pw==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH] NFS: Fixes for nfs4_proc_mkdir() error handling
Date: Fri, 16 May 2025 11:00:10 -0400
Message-ID: <20250516150010.61641-1-anna@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

The PTR_ERR_OR_ZERO() macro uses IS_ERR(), which checks if an error
value is a valid Linux error code. It does not take into account NFS
error codes, which are well out of the range of MAX_ERRNO. So if
_nfs4_proc_mkdir() returns -NFS4ERR_DELAY (which xfstests generic/477 was
able to consistently hit while running against a Hammerspace server),
PTR_ERR_OR_ZERO() will happily say "no, that's not an error", so we
propagate it up to the VFS who then tries to dput() it.

Naturally, the kernel doesn't like this:

[  247.669307] BUG: unable to handle page fault for address: ffffffffffffd968
[  247.690824] RIP: 0010:lockref_put_return+0x67/0x130
[  247.719037] Call Trace:
[  247.719446]  <TASK>
[  247.719806]  ? __pfx_lockref_put_return+0x10/0x10
[  247.720538]  ? _raw_spin_unlock+0x15/0x30
[  247.721173]  ? dput+0x179/0x490
[  247.721682]  ? vfs_mkdir+0x475/0x780
[  247.722259]  dput+0x30/0x490
[  247.722730]  do_mkdirat+0x158/0x310
[  247.723292]  ? __pfx_do_mkdirat+0x10/0x10
[  247.723928]  __x64_sys_mkdir+0xd3/0x160
[  247.724531]  do_syscall_64+0x4b/0x120
[  247.725131]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  247.725914] RIP: 0033:0x7fe0e22f3ddb

While I was in the area, I noticed that we're discarding any errors left
unhandled by nfs4_handle_exception(). This patch fixes both of these
issues.

Fixes: 8376583b84a1 ("nfs: change mkdir inode_operation to return alternate dentry if needed.")
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 fs/nfs/nfs4proc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index c7e068b563ff..306dade146e6 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5274,13 +5274,17 @@ static struct dentry *nfs4_proc_mkdir(struct inode *dir, struct dentry *dentry,
 		sattr->ia_mode &= ~current_umask();
 	do {
 		alias = _nfs4_proc_mkdir(dir, dentry, sattr, label);
-		err = PTR_ERR_OR_ZERO(alias);
+		err = PTR_ERR(alias);
+		if (err > 0)
+			err = 0;
 		trace_nfs4_mkdir(dir, &dentry->d_name, err);
 		err = nfs4_handle_exception(NFS_SERVER(dir), err,
 				&exception);
 	} while (exception.retry);
 	nfs4_label_release_security(label);
 
+	if (err != 0)
+		return ERR_PTR(err);
 	return alias;
 }
 
-- 
2.49.0


