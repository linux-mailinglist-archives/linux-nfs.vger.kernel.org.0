Return-Path: <linux-nfs+bounces-3981-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7037590D013
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 15:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6E56282BCB
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 13:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A2614F130;
	Tue, 18 Jun 2024 12:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="txxFZT8T"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8C113B5B8;
	Tue, 18 Jun 2024 12:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715260; cv=none; b=lLJWBCvePBTswkPj2f2g3Du6ymOsFcnvfQA1ET6m2Xh13hE2bAUsNzTqqfCOT7sfWkFrhOODoYBYVkIpH50IrHWUM11mmz9nNE8upNwDpRbXn1s0AYL1T9W9xEAb44QiwYaN1TDiY4ph4VKWtXH2DuQxAVRWSY5Bkn6x7DsAMvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715260; c=relaxed/simple;
	bh=3vmTpf1Vgonbyqj5owY8QYs+Anbz4lDgew7eTmPLeug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G+PlSoMK3SgoF7VN8ShAbprleQxdb6lyEzeeFJZnE8Prdg27zJxFGelBUDR8ik5FErlkxzVVzhsLa7Tw/LbU7CRw9YjO/XOcGk43bOifUDq/UWK6lTQ+EHGMGsQzhTNuaEdgpoycNRCmJ0AeWvkdlJEGKJcT/RtsTMdf9Qvt8L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=txxFZT8T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C7AC3277B;
	Tue, 18 Jun 2024 12:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718715259;
	bh=3vmTpf1Vgonbyqj5owY8QYs+Anbz4lDgew7eTmPLeug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=txxFZT8TUHjJhXFTP0USWnSbHR/2gZjv4siG+Rh8aJc63kprTeCQ6WhGGD469PgHC
	 osizjE7cqxP3NmSUk421/XPAZ0n8jnHViJgMy5Lxe+d7WOgroxqg3DXA/Ik98QeR+m
	 lImKlxfU+PXqzn9TdSq9peGZigGUNOPffsC9idE4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 241/770] nfsd: Log client tracking type log message as info instead of warning
Date: Tue, 18 Jun 2024 14:31:34 +0200
Message-ID: <20240618123416.581108372@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618123407.280171066@linuxfoundation.org>
References: <20240618123407.280171066@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Menzel <pmenzel@molgen.mpg.de>

[ Upstream commit f988a7b71d1e66e63f79cd59c763875347943a7a ]

`printk()`, by default, uses the log level warning, which leaves the
user reading

    NFSD: Using UMH upcall client tracking operations.

wondering what to do about it (`dmesg --level=warn`).

Several client tracking methods are tried, and expected to fail. That’s
why a message is printed only on success. It might be interesting for
users to know the chosen method, so use info-level instead of
debug-level.

Cc: linux-nfs@vger.kernel.org
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4recover.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 83c4e68839537..d08c1a8c9254b 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -626,7 +626,7 @@ nfsd4_legacy_tracking_init(struct net *net)
 	status = nfsd4_load_reboot_recovery_data(net);
 	if (status)
 		goto err;
-	printk("NFSD: Using legacy client tracking operations.\n");
+	pr_info("NFSD: Using legacy client tracking operations.\n");
 	return 0;
 
 err:
@@ -1030,7 +1030,7 @@ nfsd4_init_cld_pipe(struct net *net)
 
 	status = __nfsd4_init_cld_pipe(net);
 	if (!status)
-		printk("NFSD: Using old nfsdcld client tracking operations.\n");
+		pr_info("NFSD: Using old nfsdcld client tracking operations.\n");
 	return status;
 }
 
@@ -1607,7 +1607,7 @@ nfsd4_cld_tracking_init(struct net *net)
 		nfs4_release_reclaim(nn);
 		goto err_remove;
 	} else
-		printk("NFSD: Using nfsdcld client tracking operations.\n");
+		pr_info("NFSD: Using nfsdcld client tracking operations.\n");
 	return 0;
 
 err_remove:
@@ -1866,7 +1866,7 @@ nfsd4_umh_cltrack_init(struct net *net)
 	ret = nfsd4_umh_cltrack_upcall("init", NULL, grace_start, NULL);
 	kfree(grace_start);
 	if (!ret)
-		printk("NFSD: Using UMH upcall client tracking operations.\n");
+		pr_info("NFSD: Using UMH upcall client tracking operations.\n");
 	return ret;
 }
 
-- 
2.43.0




