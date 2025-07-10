Return-Path: <linux-nfs+bounces-12964-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B0CAFFAC8
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jul 2025 09:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89CCA641CB8
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jul 2025 07:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEC428751F;
	Thu, 10 Jul 2025 07:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VsqxxVIV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD862701C0
	for <linux-nfs@vger.kernel.org>; Thu, 10 Jul 2025 07:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752132285; cv=none; b=C2ZfPViIiskKwlhNJ0z+G4fNWqL5q8ne+XLn6WQU8YnLg82yy8fddq1pvKQldU7EiCyEJXTdYlCVes2R9mIWKV3Bn8daHGphgzPhdGU2eNfg/AcXt9CJ/eWsxtLwCu+58NF3aRj8cyoy/gEd/v2U0Y9h7TI01TZB4ee1Z8f5MDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752132285; c=relaxed/simple;
	bh=taD5zqBSakTEx1MYqA6Q75+gPbApqnPghp8kzdoJSmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWStWT/XywuZXTJ6QH3OxCUVppmgdW+6kcJ44qFA9LwseSPJAmQvoDQOGmWI/8DLXOaHOwZBkBXrgGHbfuLvIQf5aKY1CHwopl/At8tDk9VcSi8cRNJ81Ez5I1HayIDweftr9FNrlUgPUJGTAkxihfLIxzdO4DuP1ZKLu/g804M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VsqxxVIV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LWD3lUIEPwwiBdZYU9ybqOvvjGKQcAuB55Cr4pGQxQM=; b=VsqxxVIVB+wXxNhAbvaSXNLOuz
	Fh2GUExplsqx7D0G0cqu6HS4ZWbCrgwePMlkgus5Vehaz3HbDrwlPMFVkw4SWASurAVI8yiKk4OIt
	Z4suAWu56sQeMDGCiwmsHmNK5zSRsL4DW6KZnwmS9FfL2VN22F4qB95NUSp4/0cNaQ8AEubdID/F9
	BsVynJLJy1Dza9T7hy/dt/xM+UlBLFFEVbZSOWErAA1vQsCOeQl2/Ov1Oy5iYBCc0C1E8PojLVIiI
	E4K4B/q66etv55UG5ZqO29r9ExTTBvGx2BY4DLdkMwNksaGzr2JbONCIFnYbUM7qc1dZdzyt0o93n
	baljco6Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZle2-0000000AzvI-2gA8;
	Thu, 10 Jul 2025 07:24:38 +0000
Date: Thu, 10 Jul 2025 00:24:38 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linus-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 4/8] lib/iov_iter: remove piecewise bvec length
 checking in iov_iter_aligned_bvec
Message-ID: <aG9qtlHCmSztOsFo@infradead.org>
References: <20250708160619.64800-1-snitzer@kernel.org>
 <20250708160619.64800-5-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708160619.64800-5-snitzer@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

You'll really need to send this to the VFS mainers and especially
Al.  Also the best way to make things stand out is to either send
them separastely or the beginning of the series.


