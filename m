Return-Path: <linux-nfs+bounces-17228-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A20D5CCF8B6
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Dec 2025 12:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD9293015104
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Dec 2025 11:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF223093D2;
	Fri, 19 Dec 2025 11:14:17 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3A33093CD
	for <linux-nfs@vger.kernel.org>; Fri, 19 Dec 2025 11:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766142857; cv=none; b=KDDj5BtRcQy0pl3EZKkcP6FEg9aX2qsyerpAVbpLuNFPtgLi7LG2lfA1E+Yz2bGwCUcdj64KMZYZe6RGrKtIRrg4hD+VFP6/+eABEArJ8LY9ouDQ8fqkCS2tQZlQp0dopjQB9iDwZIVqROtU7MikDp3C2HG5dPrm/AwP1+XKXgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766142857; c=relaxed/simple;
	bh=BlFoU4D0L0Q1LoVsV42ISZPZzSe3WCoGNAIZgT7899U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T95No6elVSCMSaLF1qvEpX9Txly+lWUPTLIDUZIMF8yEwrh2kDMZuZv6jBgWf/rW+w2TMrkI5JxjXHPVnFb/k/IKJY79LDrKxnhT1NkFSQLoxJ68CPYvBwUA30TMzfE4x5I0zrISUKfZlRPy3s+PTupCHwi38EOmHKfJoKPywDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AA6416732A; Fri, 19 Dec 2025 12:14:11 +0100 (CET)
Date: Fri, 19 Dec 2025 12:14:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 23/24] NFS: return delegations from the end of a LRU
 when over the watermark
Message-ID: <20251219111411.GA11715@lst.de>
References: <20251218055633.1532159-1-hch@lst.de> <20251218055633.1532159-24-hch@lst.de> <13891f50-73a1-40ee-aaa2-373dba3886e6@oracle.com> <20251219052124.GA29411@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219052124.GA29411@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

This was caused by a delegation already on the LRU not getting moved
to the return list.  The patch below fixes it and passes the xfstests
quick group with 4.0.  I'll fold it in after a little more testing.

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 776020bdf8f3..6497fdbd9516 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -93,11 +93,9 @@ static void nfs_mark_return_delegation(struct nfs_server *server,
 				       struct nfs_delegation *delegation)
 {
 	spin_lock(&server->delegations_lock);
-	if (list_empty(&delegation->entry)) {
-		list_add_tail(&delegation->entry,
-				&server->delegations_return);
+	if (list_empty(&delegation->entry))
 		refcount_inc(&delegation->refcount);
-	}
+	list_move_tail(&delegation->entry, &server->delegations_return);
 	spin_unlock(&server->delegations_lock);
 
 	set_bit(NFS4CLNT_DELEGRETURN, &server->nfs_client->cl_state);

