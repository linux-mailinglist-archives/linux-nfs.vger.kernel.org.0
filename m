Return-Path: <linux-nfs+bounces-16128-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AC8C3B222
	for <lists+linux-nfs@lfdr.de>; Thu, 06 Nov 2025 14:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC10C1A416D9
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Nov 2025 13:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158942DAFA7;
	Thu,  6 Nov 2025 13:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k4Dyarnb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588A01DF27D
	for <linux-nfs@vger.kernel.org>; Thu,  6 Nov 2025 13:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762434432; cv=none; b=NUw5doyMMFcsrlmnCWV7TPtPlBF7DriVv/As9jrHZbUpYRlHVhOskUI4yGtuRw4QYc8HtfaCqlkZ95hi14oI/fUw7csNt5wl05u2WFTMv859f27UQWEiNx4hpaBHJhJqtuGdMT8LbArxyt7I9kZ6VygDVpYHdBV2nTrw8Pyeqjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762434432; c=relaxed/simple;
	bh=sp9XBv5d1XhyEhaZPpU089GvG4XRLX0i/V5KXV7KuEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/xe2ne7pBaq1+H0L+CZTrKi4btSr3FKF6K1vCQguGnEbTwkKKkDpQwx1udgC/xvA7BB+6ZkwX51cb987grpRvDQYury03dZDSlzjwcEjiNAmasFq4hhzZPfiKz/9GHiU5hdzl0LxWcbHNw90HZUkVw0+9iYnbObPp+WizCOvTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=k4Dyarnb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sp9XBv5d1XhyEhaZPpU089GvG4XRLX0i/V5KXV7KuEQ=; b=k4DyarnbxCP6RPv6mkvEuaAABJ
	K42AfFilMzKkK9wdA3fcVjrpVZ6QFG58kwmN23iKrVg20ORg+Hg1UHpqfkP0n8U3txJT+KRlQ8e/9
	cqsL0uUv+nknki5scp04xqOUKXhzltKMJnpPdN5qEKGb/kGPxkJ3fsy4FV7iNLDTil/53RhlICOPY
	ZrRHyv4ngZn8iuzmza0yPQyt38xvektOnhvf5kT+Fyy3iD7UEDps1riHud9HLFO9BQFNyIv72rq99
	DSB3PLYehwg0I5U8GguwxgPIevzTM/uTwI2uZytwxe+UVgVb9zLJ9MobQGidHFtppGBYdJS4UA+HT
	O8bH1JkA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGzhj-0000000FXFm-2E8Q;
	Thu, 06 Nov 2025 13:07:07 +0000
Date: Thu, 6 Nov 2025 05:07:07 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v10 3/5] NFSD: Enable return of an updated stable_how to
 NFS clients
Message-ID: <aQyde06-9qKs6o9O@infradead.org>
References: <20251105192806.77093-1-cel@kernel.org>
 <20251105192806.77093-4-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105192806.77093-4-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

I don't think we need this any more with the current version, or am I
missing something?


