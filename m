Return-Path: <linux-nfs+bounces-3852-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF49390964B
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Jun 2024 08:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E71161C21325
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Jun 2024 06:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB0016426;
	Sat, 15 Jun 2024 06:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Iy2taN7Y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D071640B
	for <linux-nfs@vger.kernel.org>; Sat, 15 Jun 2024 06:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718432829; cv=none; b=d9ctFdHtiArhbGYJgPsIUlbe+BYqnqa83Oybjz4CxuCpMdBLigwb10D/cr1d87l8bBYK0XmYCXkJsG3lE049TSB2/uz/Vz+GzkmO3G0y1ota6AMCYm/4hWdU2EZCG83ynaDTAbicnKAUyHNCtV6fwexd6AswJGhgASwjNHgg9VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718432829; c=relaxed/simple;
	bh=sbnChAcZvhv+D2pfpg52EfCA1loZId4S5ut4pfE7OO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7tg1rlOF2MtU2xd/LvWY4N1NlCjy0i3yo8+GlJxtX8Col9k8ok1xtTWEan4YJQc+q0cqYwv4Zse693nEI5/C81mKfWD1ZG+3m17XIj0ZTNjpZ3TrHs7TmKBdBwMHYW5O1Xk6Kh9aJxBOaUtcGt5CGzb3ZuI/lj8GX5tkPA/6eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Iy2taN7Y; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3/odegyH1+5kNTCmy075Qadt+XffdXfCQND4KxemL+o=; b=Iy2taN7YbrQ3KD0EUoYULnsQ96
	Wvn6GuJ3QCliJt+Qnv2T6KapHGKB7F/r5oYIPul0plqMXofYDBSUHS0Yps2I3W7825Bn+IE5MtSvp
	2GVGdjYkwPdiVz5FXSjgLidfaKgKxDIp2AV+pPInOWeoQ5uOti0+7bfyPyu6TFsTMpqAQ++6f9eVO
	K20uVIsiR9UGabgV9oKRZbShKPW3QW5CBDRauIHGp1eZvOkxkoLdtrOuvXyVq7WzqnFnS36xkyjE5
	R6f9SofWAd6+o9mOFey6k3fzXMzHVny0/JrHFlbeO7KRvToegNVx99XOPBUM+6eptHH636Zeiqa76
	7+J4NX+A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIMsV-00000004ne5-0ww6;
	Sat, 15 Jun 2024 06:27:07 +0000
Date: Fri, 14 Jun 2024 23:27:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: trondmy@gmail.com, linux-nfs@vger.kernel.org, chuck.lever@oracle.com
Subject: Re: [PATCH 00/19] OPEN optimisations and Attribute delegations
Message-ID: <Zm00O4JN7rY2BiiI@infradead.org>
References: <20240613041136.506908-1-trond.myklebust@hammerspace.com>
 <b9f5ae349c6ff90b90aff43b86bc3de8b8a9f863.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9f5ae349c6ff90b90aff43b86bc3de8b8a9f863.camel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jun 14, 2024 at 08:34:32AM -0400, Jeff Layton wrote:
> This all looks pretty reasonable except for the last two patches.
> Probably, they should be squashed together since there is no caller of
> ->return_delegation until the last one. There is also nothing
> describing the changes there, and I think it could use some explanation
> (though I think I get what you're doing).
> 
> Finally, I suppose we need to look at implementing support delstid in
> knfsd as well. I'll open a new feature request for that the linux-nfs
> project on github.

I don't think there ever was a formal rule, but having a feature like
this that affects all of the core nfs code without beeing able to test
it against knfsd seems a bit dangerous indeed.


