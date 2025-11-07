Return-Path: <linux-nfs+bounces-16185-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D82ABC40999
	for <lists+linux-nfs@lfdr.de>; Fri, 07 Nov 2025 16:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 859291A44159
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Nov 2025 15:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22FB2F0C45;
	Fri,  7 Nov 2025 15:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="syXZWE7f"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6083239E7F
	for <linux-nfs@vger.kernel.org>; Fri,  7 Nov 2025 15:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762529663; cv=none; b=NS5UYmeWWb9/UAL9WzngCpUp66/CI1cOYZ7T4oIcJ/A1UOds12rZaOrvG5H6+AtnVW8c79CNx513zOvLQbt9GvudVYNSTKd2L37+RDWHMlTAYiFfKs2fVe6Rvvir8eYzkmGggEKBhpmPjijVuF9O6SwXbbrTeA+K8MwtCosbnBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762529663; c=relaxed/simple;
	bh=ZRAN9WR3nmo7Yux21d6jdeXWTmDTo4DSRVgbFAWCK5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLOV0lhmx/733yaCZxokU2eGljIaOXB2l4PxJ2e64TCDwWzk9PDbgoCtBPwCFSGjDR8zzOptESC7S4MejLijGnuz1Mv0UnWbESzY3qL5/ym9LfYljJF4F70QrvD8a0rpheQ2qE04vl6rLR6EIcpHlMXsGxsfWKyWrp9HqZThVLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=syXZWE7f; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=C6nxKiJN5pT7zjAnlNh5+VFog+ut8PTN99yD9f6CCck=; b=syXZWE7fxNEP4W4scGj2PcjyuR
	2hvUDovIz5AbNvxmFfE9HnhzQnEshUnSWWOtvAwUeVEFDOshKlnMqj5E8n/3nfz5GHSMUsMr3Gz2s
	BvQB+UwmK8rLY147cvE+C+ZZvVSK0dYjazt8YbG4gemgpBVH0D/ze5q+3eJRDDBRSWGALBDToN+QD
	FqvgONXTd0E3juzhMRhH2Vj2EK0InG07GdcNYyHqQUnpKSCJUCRht2kFentHO4GS+GWYRWF0phsPr
	1hAkaZ+h9+vR+1LQyrq7bGJBU6q5dNLtka26NcoRNSN83JAP0xUsSADNTgF1fUPuZ9aAOaiROK04g
	h0vCVmrw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHOTm-0000000Habn-0bSw;
	Fri, 07 Nov 2025 15:34:22 +0000
Date: Fri, 7 Nov 2025 07:34:22 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 2/3] NFSD: add new NFSD_IO_DIRECT variants that may
 override stable_how
Message-ID: <aQ4RftwuYIxwvLgb@infradead.org>
References: <20251105174210.54023-1-snitzer@kernel.org>
 <20251105174210.54023-3-snitzer@kernel.org>
 <c1f4d144-826e-4c27-821c-47652a7b67d2@oracle.com>
 <aQ0CUPcYYg6-5IJ1@kernel.org>
 <7d9bcc0c-d997-4fb9-aa0c-831b8f08a9b0@oracle.com>
 <aQ0noN473a-QFqpz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQ0noN473a-QFqpz@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Nov 06, 2025 at 05:56:32PM -0500, Mike Snitzer wrote:
> OK, I'll take a closer look at NFS client controls for stable_how,
> because NFSD clearly handles NFS_DATA_SYNC and NFS_FILE_SYNC so I just
> assumed its because the client does actually send them.

Asking for NFS_DATA_SYNC / NFS_FILE_SYNC for O_ЅYNC/O_SYNC writes or
even fdatasync/fsync calls that translate to a single on the write write
request would be a valuable client additoon that should speed things up
with most if not all servers.

> > And as I said above, "no plan to merge it for now," meaning it's still
> > on the table for sometime down the road. I have some other ideas I'm
> > cooking up, such as using BDI congestion to control NFS WRITE
> > throttling.
> 
> Hmm, I thought the BDI congestion infra got killed (by Jan Kara and
> others).. which made me sad because when it was first introduced it
> was amazing at solving some complex deadlocks (but we're talking 20
> years ago now).  So I haven't kept my finger on the pulse of what is
> still available to us relative to BDI congestion.

Yes, BDI congestion is gone, mostly because it didn't really work.
I'm also not sure how it could have solved deadlocks.

I feel a little out of the loops, though - what are the NFS-level
write throttling needs to start with?


