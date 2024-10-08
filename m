Return-Path: <linux-nfs+bounces-6929-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3291995091
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 15:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBB161C2535E
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 13:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD841DF279;
	Tue,  8 Oct 2024 13:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ruDbwBng"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76D213959D
	for <linux-nfs@vger.kernel.org>; Tue,  8 Oct 2024 13:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728395258; cv=none; b=WFoP279BjNjqC0M1vlR/A1bN17lcGWdGdk9WdIXsWzCW0c0KWALkmfFuwheKTfZlfhFgsAR8fLmjzUak8OSTEceX6RBwLvsvmawlUJOuNjB3W5WWsMcrtq6Rhl5+tZtmCiveGeUWXxFkJM78bYMeZTX1qOebd0mwSS46TvXMcbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728395258; c=relaxed/simple;
	bh=PS+siCOz9OVFuPMJFQAG4sD84t/J1JI/yJ7OfIcJIN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UqkQvH5nBu0K/OJ4+bsh0sBFHJqWdl50jTfvmwwDPk8F0grCQpj3IbM+//CUa+VKPDNdVtYBNvOzKV4Gm6U2pk6kCJTHLFk7/zbSagQ30aL1/A5yUOKRermo42AQW3jgEwZNgvrPTz0JAX57viPQnjqu4IcsAMFS8WQoV+oAVUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ruDbwBng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DDDC4CECE;
	Tue,  8 Oct 2024 13:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728395258;
	bh=PS+siCOz9OVFuPMJFQAG4sD84t/J1JI/yJ7OfIcJIN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ruDbwBngukT7wB8omVyUUy0ow/R+Qwoaou74aEr1kjG54m5IKv2nkNCNFsIDEuK7G
	 dPEiCI9Xwfuh05ENNJPXkMR2mv98xSrWVHPQxzVVcZPa0LJ3FtCMGDEAuO4rouXbFz
	 FHVfKCaKKIwxjo++vGOnkLqBSEpQfEUhuSUVp0L22sTWVSnyjcVi32YXyrLTh3MSCf
	 WhmpKWCeBfxoX7qnIAVBbRXL0w4LiqdWBQSuxER8yJAGe/AjwAjD/2kmnHkTg0brbS
	 QI2DrgB/7nOHAqFEtSFatjV74kWSJgCdhR1FquHQH9TcSf5Lx7wthQkSxzR0pJqAu0
	 WIFRuabK1S6fg==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 1/9] NFS: CB_OFFLOAD can return NFS4ERR_DELAY
Date: Tue,  8 Oct 2024 09:47:20 -0400
Message-ID: <20241008134719.116825-12-cel@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008134719.116825-11-cel@kernel.org>
References: <20241008134719.116825-11-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=876; i=chuck.lever@oracle.com; h=from:subject; bh=hx9wCizVSEyAIJq+6ZAKF9s0uu1JfMv95X8lImJ0J3g=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnBTfy+tktoJadsbimKKjyY2exwa8tRPGayhfZ8 d/rXBlI41eJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZwU38gAKCRAzarMzb2Z/ l71gD/0bPaAnIj822ciXe4n84gWVUcdty91w9uUr7OY9QaNaClM4L1v81KtG2nkL8q0MZC9U38T TBUfLs3ow8NeCABTpO1CPuo+2aLSwRDHzYCe/WGgWTfuzYxi9S5WDoH9Uwn+upoW20vNg+1Ze4g /WhvtpvRMDtm0MWOURnbTbkHNsdIDFthqDrYE5TSVmI4l1BGjQv4DPGFhARqXiIeS+rBSqdBz/J ++W7XGzc4pxrl1VSTJBifstJ6kYo3yM5xkQ1ZR3QyEjSZjsZdoKpFPJAjUr4qzvxToHozly13e7 GkQXZwngNn6/KjZCSiPiCDOjoNWrz5bVg77Lqq8eEF4qdvUK4VMVfaaDzds3Tsn0/ZgNoErjB4n o8TGQ0rmyS0yD/lGDC5NnjgEAsb6MvXBJ4Pc4FSfu0CVZN//TJOfjRvfR29ad5XTipHg89dvdXA qXdfW47P9qZmgVI8VxyqRHIX/TK0N8ROZ6ZPbRGDIUWVXUunN0MYTqJPiCGlzTyGtCWz2cvV9bv dRGmMnLO/kE987zIKRk7kN8C1bN4viPH1mpCrmdBrHWxXGPqdyTx815XTpsJBSazOR0OHQ6WmCY DJBuW0HLNups9YFFmfXEJS/PJRKfn6nBIiV4/AzRo0941ummuvJNSUi7TSSTCaxD+fHk+EKIHfQ MXIATvPSaXCI1Uw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

RFC 7862 permits the callback service to respond to a CB_OFFLOAD
operation with NFS4ERR_DELAY. Use that instead of
NFS4ERR_SERVERFAULT for temporary memory allocation failure, as that
is more consistent with how other operations report memory
allocation failure.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/callback_proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index 7832fb0369a1..8397c43358bd 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -718,7 +718,7 @@ __be32 nfs4_callback_offload(void *data, void *dummy,
 
 	copy = kzalloc(sizeof(struct nfs4_copy_state), GFP_KERNEL);
 	if (!copy)
-		return htonl(NFS4ERR_SERVERFAULT);
+		return cpu_to_be32(NFS4ERR_DELAY);
 
 	spin_lock(&cps->clp->cl_lock);
 	rcu_read_lock();
-- 
2.46.2


