Return-Path: <linux-nfs+bounces-21631-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHNyEOMTB2rgrQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21631-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2026 14:38:59 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4950454FB7F
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2026 14:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CCB1E31DF5FB
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2026 11:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC3347ECFB;
	Fri, 15 May 2026 11:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jW1n4YB3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50E647DD4D;
	Fri, 15 May 2026 11:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778845782; cv=none; b=s7DAwDIPfKgNIOom82iocS61xWjoKxej8bHai6+i7Oy+IkfNXJDg+M16eIWjbb/Who7P8l3BtKcILb7uJQv1rVYinJOp9w/Pjdx6VIe7lNDSCQiHBm0cETd2n7A6yyZ7rSbgPwD8VeLRT5qzIREewNINKYIfzOuWpgcNO9EMKbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778845782; c=relaxed/simple;
	bh=JXtl3x4uSjO+8rIvjA59e987Tpou7VazUYB55Bk3XDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EY3RSHvKm/EmRT3zi+KK6z433pk6Te7R8n6vK/V2PUC/glzVHIDtmfOZt8KCPdhy3H4u9euW//0vZL1qz09QdQecDYeEMKj/paKgAi0MNaG1kcC/v07ZklVVsqmNSZ/3LhlNx/3rmXvAkAQ4HGPO1BX/Hz+prCpvMidNsIKX9wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jW1n4YB3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ma1/ZCSU5iZaiP3/IcuyU1VwGv+xai93AI5xuPNY6qc=; b=jW1n4YB3lrv/hfOEVrEudMm4yQ
	G4ETvsH3BDrsG5ZrS8eb1K9pDMBQcVm1bCQzUKdPb7JH0xtk84QpM5/Js07X1o6kX4uXBc3lGGp5J
	k05VGIrGjSf7y2EVnbHDG9mWDFMwbKQ2iSdKZ6ZM62bfZ81spt4rfZ1xQJLotPJFAvNwX6V4y/DZR
	o6F2+GXMndwGC9ywO0DHS1GYs+cbUfqUEWy7owZE0a3UgUMQEV7nHlvqIJqJ7tWQtQE9PGkqChBFP
	AsgocC4sV0f0SeurBy4udlHKPfMTq1Jc+b/VEq/wKTUvDvKIh/eq5pVen/m30D00BEt2aHAiJdQMs
	t/KislZA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNr2v-00000008FB0-2CUO;
	Fri, 15 May 2026 11:49:37 +0000
Date: Fri, 15 May 2026 04:49:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, cem@kernel.org,
	linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] xfs: fix overlapping extents returned for pNFS
 LAYOUTGET
Message-ID: <agcIUYJE6a93seLc@infradead.org>
References: <20260512172238.2495085-1-dai.ngo@oracle.com>
 <agQhzg-0aeISwOGW@infradead.org>
 <961eb355-2f52-47a0-9399-e050a4e535a2@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <961eb355-2f52-47a0-9399-e050a4e535a2@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Queue-Id: 4950454FB7F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21631-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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

On Wed, May 13, 2026 at 08:50:29AM -0700, Dai Ngo wrote:
> 
> On 5/13/26 12:01 AM, Christoph Hellwig wrote:
> > On Tue, May 12, 2026 at 10:21:53AM -0700, Dai Ngo wrote:
> > > A single LAYOUTGET request from the client can cause the server to
> > > issue multiple calls to xfs_fs_map_blocks() for different offsets
> > > within the same extent. Because the use of XFS_BMAPI_ENTIRE flag,
> > > these calls can produce overlapping mappings.
> > > 
> > > As a result, the LAYOUTGET reply sent to the NFS client may contain
> > > overlapping extents. This creates ambiguity in extent selection for a
> > > given file range, which can lead to incorrect device selection,
> > > inconsistent handling of datastate, and ultimately data corruption or
> > > protocol violations on the client side.
> > Please also add a check to the client that catches this and doesn't
> > use the layout that has extents outside the requested range.  And maybe
> > warn about it as well.
> 
> The returned extents cover exactly the range requested in the LAYOUTGET
> op. However these extents are overlapping. For example, here is the
> on-the-wire capture of the LAYOUTGET operation and reply showing the
> overlapping extents:

Now that is really weird.  How do we end up not using the remainder
of the previous extent from a previous nfsd4_block_map_extent call
in nfsd4_block_proc_layoutget?  Looks like there is another bug hiding
in the nfsd code somewhere.

And the client should probably also validate that extents of the same
kind do not overlap (read vs write extents are allowed to overlap).


