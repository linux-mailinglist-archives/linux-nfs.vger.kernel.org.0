Return-Path: <linux-nfs+bounces-16045-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F433C35B51
	for <lists+linux-nfs@lfdr.de>; Wed, 05 Nov 2025 13:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E21BE4E5AB2
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Nov 2025 12:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A397C3148BE;
	Wed,  5 Nov 2025 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1Pu4Ng2u"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CA32DF3F9
	for <linux-nfs@vger.kernel.org>; Wed,  5 Nov 2025 12:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762347183; cv=none; b=u1wQt3wyBCX+BmYuD4aJHaiMVYIOdvQSlMc2ravE8paGovblQ/jfX6+nG4uXvO530O0fgTR9KJHuKSIeUSSgXnouLG4/kcjMD+QGNnm8FeHR+MrGIP5Lsv1TNCdYHN3esmCbMtOIQSA4LJgPb0JgOd5NN0DCE5rMiZfgf+w62Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762347183; c=relaxed/simple;
	bh=xTHCOI6y4BXjyIcMotWMoIAawzrI8VqDDy1XixSJcZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdPsh3lU0cp1D0TaUi5ddGRVg5yBqdjnhCnYQn9lXpj4HN1H3cjse1lQgqzTPyOuQK6QsQWII93am5cwTDY4CN+/hC6IVU0mMYeT3E02vZt/M8OOqG6ANkA/g03IgCVGOi7lZBd7P/iRUTnSIq9hJmvprKnW0RC8fMfPWLN/nuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1Pu4Ng2u; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=FIhOtRR6DkqB01Ct6+HhkwQFtKC5euDzAfnLw3Rak2A=; b=1Pu4Ng2uWdBtqxS93lvPCOlq9/
	nJhlhbRJ5ZD920I+WxMPu2QZvWHhbGeH4G4Z0UIQZkcUyQzlxvJVJm1ATc/7jfc0tqM46yL0t9TSm
	904rSq3jrMPbVPKkicYPWu1bPiYVW6rCGTI/qynCGn1nZl5l2TWh+WfsKBYOLh+JctsipiFIHJEpd
	OhhoCKLyYgwsgAtK6IR89oxfQ2Zr4yeScoybu1ynqrH69NfCJWlqFXyMeQCHI1qHPH90zIi+GumRB
	lP23f5P/YFwsk1wxWlnhJOXnUh3Rrcy+RhZKtaPvY9IQ2urobvZEJg+WF3AG9gXK3FfSa9iYAyknN
	Sc1UV1Hw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGd0U-0000000Di6W-18Ly;
	Wed, 05 Nov 2025 12:52:58 +0000
Date: Wed, 5 Nov 2025 04:52:58 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v9 05/12] NFSD: Remove alignment size checking
Message-ID: <aQtIqn28Bo2ElPqG@infradead.org>
References: <20251103165351.10261-1-cel@kernel.org>
 <20251103165351.10261-6-cel@kernel.org>
 <176220902556.1793333.10293656800242618512@noble.neil.brown.name>
 <aQnpB4mYMwW9IGM0@infradead.org>
 <35ddc8b0-2727-453e-b970-07b493e21f93@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35ddc8b0-2727-453e-b970-07b493e21f93@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 04, 2025 at 09:14:09AM -0500, Chuck Lever wrote:
> >> It might be good to capture here *why* the check is removed.
> >> Is it because alignments never exceed PAGE_SIZE, or because the code is
> >> quite capable of handling larger alignments
> >> (I haven't been following the conversation closely..)
> > 
> > I'm still trying to understand why it was added in the first place :)
> 
> I'm trying to understand what action you'd like me to take. Should I
> drop this patch?

With "it" I meant the check.  І think Mike explain this was due to a
PAGE_SIZE bound buffer originally, and in that context it makes sense.
Without the explanation I don't understand the rationale for adding the
check in the first place.

> 
> > But I'm also completely lost in the maze of fixup patches.
> Several people have asked me to collapse the fix-ups into a single
> patch. We would lose some history and attributions doing that. Does
> anyone have other thoughts?

The action I'd see is to collapse the series into reviewable chunks.
I.e., fold the addition of the direct I/O writes into a single patch
that has all the policy decisions and documents them, leaving only
clearly separate prep patches separate.

> 

