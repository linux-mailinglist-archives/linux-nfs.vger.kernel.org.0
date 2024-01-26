Return-Path: <linux-nfs+bounces-1501-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1C583E0D5
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 18:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D0A21C21A5E
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 17:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67F720332;
	Fri, 26 Jan 2024 17:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fmp/DpPr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F532032C
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 17:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706291187; cv=none; b=Fi8QlP/dwu9oXMssWZIzlA8R49BoHJIAMPCNaCYc46HQZSrCqyq73nGI00TykYZy3DlyYy9JtEOFfdKpPZiY86guVj1q7f0tSeFM6Mis413i5Lrl58OQzQ9NQYpJTkgEIVG//ZlgnD1CyuSLoc5Klw0F7ISxZ+N2EY5viO6GHhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706291187; c=relaxed/simple;
	bh=Fu3L82waShOOX7KYol1b4ynHXnaie9En//gVGDy+Hcs=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lwtUu9rcLXCRKKthdx7tXOaByd8McpnnUvpsAWYaXSlVeOnZYV1paFZr9tACLuZQXqdIJuTnoJBuFpycZ+pwoM40tjVNdumuO13Qa4cpXC8msvqF1CbEUYZQUb+nHxcdaaJP0fLNe0HAfjfMLOO6Czk2aGmptKS4NDMNgoJb2kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fmp/DpPr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4244EC433F1
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 17:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706291187;
	bh=Fu3L82waShOOX7KYol1b4ynHXnaie9En//gVGDy+Hcs=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=Fmp/DpPruUpdUUP6sqYUMDQHYisNVaXgukAln3+vSL41eMN/webwP6s2HDlVt9dBd
	 LuY6AmkFv8mqOEl5SF7vGcWKOwA4T+jaoL+nh2ln4GNE5sZmAiqqgT0F6ds9+Vhlqq
	 iigGSmfNirGldA8zaC8zCzuihH0XurArHMvNxkZ9zum/CdOCYkPoPvCesuL2zOcH/S
	 pVvRZ9ZWaSpfBxeuQbcq8dKBQzU7+oANWi6xako6o14v2Hce6xBHyalnqDdZlu6ydk
	 RjfZjVbBAcXh9pUgpLdroEJ9C0rHVh31ZyuWyE15RNmC4Eywq7lYrjApBQNaD8JdRj
	 Fp48Hub1wQHdw==
Subject: [PATCH 2 12/14] NFSD: Remove BUG_ON in nfsd4_process_cb_update()
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Date: Fri, 26 Jan 2024 12:46:26 -0500
Message-ID: 
 <170629118633.20612.16185729156649168754.stgit@manet.1015granger.net>
In-Reply-To: 
 <170629091560.20612.563908774748586696.stgit@manet.1015granger.net>
References: 
 <170629091560.20612.563908774748586696.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

Don't kill the kworker thread, and don't panic while cl_lock is
held. There's no need for scorching the earth here.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4callback.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index d73c66fa131d..fd6a27e20f65 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1370,8 +1370,9 @@ static void nfsd4_process_cb_update(struct nfsd4_callback *cb)
 	 * Only serialized callback code is allowed to clear these
 	 * flags; main nfsd code can only set them:
 	 */
-	BUG_ON(!(clp->cl_flags & NFSD4_CLIENT_CB_FLAG_MASK));
+	WARN_ON(!(clp->cl_flags & NFSD4_CLIENT_CB_FLAG_MASK));
 	clear_bit(NFSD4_CLIENT_CB_UPDATE, &clp->cl_flags);
+
 	memcpy(&conn, &cb->cb_clp->cl_cb_conn, sizeof(struct nfs4_cb_conn));
 	c = __nfsd4_find_backchannel(clp);
 	if (c) {



