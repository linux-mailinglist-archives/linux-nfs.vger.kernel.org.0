Return-Path: <linux-nfs+bounces-21632-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NpFALAMB2porAIAu9opvQ
	(envelope-from <linux-nfs+bounces-21632-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2026 14:08:16 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6333954F165
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2026 14:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 47DF13154F49
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2026 11:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E6E43E4AE;
	Fri, 15 May 2026 11:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fN5iWf1O"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE47A145B11;
	Fri, 15 May 2026 11:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778845854; cv=none; b=PuQchgFsidEcA2HVAOB1+2kMuDtfRs70m/pCUc6w2SUPdRkZUPhetauR5Ut9A46KPymQphBo2V/qVvh+zWcpafkm9e0MGw26W8GyMpP7CY6NOua1Pjo9KDlSIppVBFI7qxtuxGtuNyE1vkGpfYilePUd8pz4OjT6Vo4L+KB5/Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778845854; c=relaxed/simple;
	bh=kakgVAuYPlpSqQpQSzN4cmRZNLF/hMxdvUlEurtEuLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7RT+JdIsMV+ms7/4V+49hAPjYwaO/Ux7mS+E+yxBNI0LElBlwLO2b0qT777lsxcsfehOPscSlBoGbbIXPTVRajTM3vFQCeOEFNTOtRRrdIQVR37syE5zCq1dt0iyqd36MwdsjsS8O0YrkNJGQRFaM+p30XLYRaxIPJV17+7+h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fN5iWf1O; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DGV3K+cqUR8Ce8SGbBCPSLLbWZgPh4ItqsLdKVh7CS0=; b=fN5iWf1OZCQABYrc1vaYQ4BPNW
	CdGWwroHSHk1rgFT2o0qIenT1mXU8giwLTfRjJpzOIaHLM6y9pgupeVGSfYVan5P4hcxDbeHupSQg
	AB7VqNiKwrZS9mou6UXIkz+zFJ4mM83mOpNkO1UIhj5sBU4T4yShxBPqjGguSrFb9sBKqn6KlQp91
	8XqV0R7YQqNdR0A46zycotqolrnvXV3teB84lMyh7AKIWHZri/vOSNpGJ+YtNAqhe4HMquR5xgzBu
	sce+JTXew+0PNWTTklWVsUhPueAxaZ8xcAoJIpPYckEQQFzpAztb65XRIvLZsLpiHTRnqT/LfT1qE
	e89BNRdg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNr47-00000008FI2-0NXI;
	Fri, 15 May 2026 11:50:51 +0000
Date: Fri, 15 May 2026 04:50:51 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, cem@kernel.org,
	linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] xfs: fix overlapping extents returned for pNFS
 LAYOUTGET
Message-ID: <agcIm53ZQ8-P7dX6@infradead.org>
References: <20260512172238.2495085-1-dai.ngo@oracle.com>
 <agQhzg-0aeISwOGW@infradead.org>
 <961eb355-2f52-47a0-9399-e050a4e535a2@oracle.com>
 <06d9b1ae-e46f-459c-bcb4-1a5ca4ded4b0@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06d9b1ae-e46f-459c-bcb4-1a5ca4ded4b0@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Queue-Id: 6333954F165
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21632-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 10:28:31AM -0700, Dai Ngo wrote:
> After reviewing ext_tree_insert(), with assist from Codex, I think this
> function handles overlapping extents properly. The only issue I see in
> ext_tree_insert() is the accuracy of the return error code, EINVAL instead
> of ENOMEM, when kmemdup() fails.
> 
> Since ext_tree_insert seems to handle overlapping extents fine, do you
> think it's worth it to fix xfs_fs_map_blocks() to avoid returning overlap
> extents?

Oh, we absolutely should not return overlapping extents of the same
class.  So the bug fix itself is good, I was just hoping we could also
improve the sanity checking on the client side.


