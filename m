Return-Path: <linux-nfs+bounces-2183-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F5E870E1C
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 22:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35D0528961E
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 21:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515E17992D;
	Mon,  4 Mar 2024 21:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E6PD4oAy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E951F92C;
	Mon,  4 Mar 2024 21:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588456; cv=none; b=Yzsc4kl+cBSYykabb8FpUy1VX9eOuVmgqbWHOz7LeatD2ngkwayFVyff66vAHAIdT9lA9ux8NbAmKNWXwhn9F43uDUbcWrfUAzKX1Hdlo4gqYd8iJyg73dWNjrnrK8n3f/+qE/VlHLwqhzZyKyv8pWXa11GSurcDTH8pHG/yts4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588456; c=relaxed/simple;
	bh=I0gefTOGqK87RJsPA/7fWF38MbflvvGzmBmFBxPq7bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kLHP+vYICr7UuvNsSI8ow62+OGw5sUekLlogndPplvUMMkHqBUjdXYlRUqVYrSD+Xe/R/jj/eYMyQopkQcipLa9h0XpmKVQfToQkxZ6N3ZGMFUT6xpJmFvRYyxDEmdfwBFrC+AnKbX6tE8XKuSzDcdtnMhbczW90GaMM60uBvUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E6PD4oAy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E053C433F1;
	Mon,  4 Mar 2024 21:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709588455;
	bh=I0gefTOGqK87RJsPA/7fWF38MbflvvGzmBmFBxPq7bs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E6PD4oAyXyARYS0whvIBbiUT06sCvZwcw3fTUYQmK+w470Lxcsk9bps66KxP3Do5p
	 vcVSqCZi5sWi1jOQPSa9r3oQA9Y7hyNkKQ0fD+6KMt9R/XFsomc1YI2lasBAhgSCms
	 bx1jNxC2D6Erb3v0o/iUPEWWpzrBR/6K1a5Re3ds=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	NeilBrown <neilb@suse.de>,
	Jacek Tomaka <Jacek.Tomaka@poczta.fm>
Subject: [PATCH 6.6 114/143] NFS: Fix data corruption caused by congestion.
Date: Mon,  4 Mar 2024 21:23:54 +0000
Message-ID: <20240304211553.557826912@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211549.876981797@linuxfoundation.org>
References: <20240304211549.876981797@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

when AOP_WRITEPAGE_ACTIVATE is returned (as NFS does when it detects
congestion) it is important that the folio is redirtied.
nfs_writepage_locked() doesn't do this, so files can become corrupted as
writes can be lost.

Note that this is not needed in v6.8 as AOP_WRITEPAGE_ACTIVATE cannot be
returned.  It is needed for kernels v5.18..v6.7.  Prior to 6.3 the patch
is different as it needs to mention "page", not "folio".

Reported-and-tested-by: Jacek Tomaka <Jacek.Tomaka@poczta.fm>
Fixes: 6df25e58532b ("nfs: remove reliance on bdi congestion")
Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs/write.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -668,8 +668,10 @@ static int nfs_writepage_locked(struct f
 	int err;
 
 	if (wbc->sync_mode == WB_SYNC_NONE &&
-	    NFS_SERVER(inode)->write_congested)
+	    NFS_SERVER(inode)->write_congested) {
+		folio_redirty_for_writepage(wbc, folio);
 		return AOP_WRITEPAGE_ACTIVATE;
+	}
 
 	nfs_inc_stats(inode, NFSIOS_VFSWRITEPAGE);
 	nfs_pageio_init_write(&pgio, inode, 0, false,



