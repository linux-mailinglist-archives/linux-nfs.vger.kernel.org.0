Return-Path: <linux-nfs+bounces-2182-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C97A0870D31
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 22:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7204B1F216E9
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 21:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658C57C6DB;
	Mon,  4 Mar 2024 21:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dVN1GsP6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2E07A736;
	Mon,  4 Mar 2024 21:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587894; cv=none; b=h4GylcEYEkaYaV7O4rcYMPHyW8f9vFaeUVBi1VuAPQZfAyaGO7HVlLiPgNg5bbzD8lOzIPa2WJu7mZzla7pRkqYJgzG8cS01Nz3etPNUYF77wKmfTSbzxRarnyvusSVXxhRBwbzt+1KZNWN0iEWCgxM5FPWXmZpUZ8POpCUO6LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587894; c=relaxed/simple;
	bh=ED0KoT86vYYoJuGhhY4f3J1XxbumSTV1vvVwuHtqSfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dqEbPPLo+ZnY+TzZUUgRnPgtLlVrKpzIVmjN1mJ6TZWD9WyjUDoNhCPTZCJti86eud9xo/ga03/4QAUONr+ky6TNxH4Enbcr8l8NdTv0zfapgbpT/TTW6jEL9Yz0bjkQTtzRQz1ZpDjP1D7tuNaaGy9hTSr+1cT5WgPFaTk0dLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dVN1GsP6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24C5C433C7;
	Mon,  4 Mar 2024 21:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709587894;
	bh=ED0KoT86vYYoJuGhhY4f3J1XxbumSTV1vvVwuHtqSfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dVN1GsP6+h6spU9CDWLFcYCFQ5MT/MfEJ2w7+AK5skug62mSQgLxLZOJN+n0m0cmn
	 uf+6pU57S97RfiqW+NQa6dI+oTYJd+I7YmJ+rVF2qAVFT7ylWAdfDBrV519IW8Iv6Y
	 h6XDXwfY+lIPocdvzNj0WcKNPrguCzOk2Xk3Vio4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	NeilBrown <neilb@suse.de>,
	Jacek Tomaka <Jacek.Tomaka@poczta.fm>
Subject: [PATCH 6.7 131/162] NFS: Fix data corruption caused by congestion.
Date: Mon,  4 Mar 2024 21:23:16 +0000
Message-ID: <20240304211555.926791835@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211551.833500257@linuxfoundation.org>
References: <20240304211551.833500257@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

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



