Return-Path: <linux-nfs+bounces-17262-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 292C8CD7626
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Dec 2025 23:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6FEDB3014DE2
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Dec 2025 22:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BF43587D4;
	Mon, 22 Dec 2025 22:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T5UuKufk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87BB3587CA
	for <linux-nfs@vger.kernel.org>; Mon, 22 Dec 2025 22:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766442914; cv=none; b=QscCdXVDFTauITpb/xpm6kIQ24e9kaMMYiSm+NBAKK25/FePNgv1IqAqiti1jR/LwZfn0wW353WUFGBAkd617sT5eM2nATwKTbvUtpqvoN8SQSeg37obYvDz4+IsetrRINKbaWqPovmhkUGMAUY/yNB5PJVoLEMbtBeDh5+T8/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766442914; c=relaxed/simple;
	bh=E3Vr2+Zgze96dVifQsc2fJgv3ODt24/Mo/PpbehLnhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOWcbfdKlc6AYrN9dLVHic7u9pEAkPAhwiD0qp+czae1+bCjc05rjETy/8VnSNckiuywnElKDKT04o9NmuNymW9K1cVJqe710I9qVV5SoJBjF5NwIG6wf6uYqzgUMMuhBYcX2kFN+Urug27ImxZq4bEE/q4ieMKXAmxZ/D7nN3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T5UuKufk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XCupXeMpfsW3ocP0dcMZe871ZtNsLRnhJGR8PQaw+GI=; b=T5UuKufkOIZ/ZzHvNlxRDLlPhM
	Lhwvif4YUhsF85e3pyRgNETwgsJkkeAQngH+BqwKW6fzwYA0Jc4Vc3zcsKc7ILvpU9qv22KjqSx6i
	n6gSaF0sFOKeyZLexvemRhF+jEP0gDrlOP1WmpKbuGEcJOnoVaaYnxhBe31L6/oF+7nzErJAtOaWI
	uFDyNcgMtw8hBqHL2hpmd62ifLuwqViuzwPRfYj+DOUsKcqNYM8EyHpw8/jfjAhDZOaYeaIrwRQbV
	zv4fAO0hmcdA2FjM+Dwvz+v+HaQw3khP3V0vCmlQ5p03GUI7TzSx95YikZyXUxzFnwMWq+T7m/W59
	tM0CZvqw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXoUg-0000000EESS-3xzm;
	Mon, 22 Dec 2025 22:35:10 +0000
Date: Mon, 22 Dec 2025 14:35:10 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Subject: Re: [PATCH] NFS: Fix directory delegation verifier checks
Message-ID: <aUnHnlnDtwMJGP3u@infradead.org>
References: <20251219201344.380279-1-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219201344.380279-1-anna@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Dec 19, 2025 at 03:13:44PM -0500, Anna Schumaker wrote:
> From: Anna Schumaker <anna.schumaker@oracle.com>
> 
> Doing this check in nfs_check_verifier() resulted in many, many more
> lookups on the wire when running Christoph's delegation benchmarking
> script. After some experimentation, I found that we can treat directory
> delegations exactly the same as having a delegated verifier when we
> reach nfs4_lookup_revalidate() for the best performance.
> 
> Reported-by: Christoph Hellwig <hch@lst.de>
> Fixes: 156b09482933 ("NFS: Request a directory delegation on ACCESS, CREATE, and UNLINK")
> Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>

I wish I could actually review this, but I don't actually understand
the lookup revalidation logic enough for that.  But it does fix the
problem I saw, so at least:

Tested-by: Christoph Hellwig <hch@lst.de>


