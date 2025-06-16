Return-Path: <linux-nfs+bounces-12469-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B7BADA74C
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Jun 2025 07:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDCAD3B0D2B
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Jun 2025 05:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903F611713;
	Mon, 16 Jun 2025 05:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HBmWvl3K"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BB81863E
	for <linux-nfs@vger.kernel.org>; Mon, 16 Jun 2025 05:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750050051; cv=none; b=FLft0k+z4XI1ZiNHLYJ3p3LzYzsnXkdySUGAKX7GFORtXnSAKC1xiez32A5YWSkV+HP5HbO6ac7uyQ/SG5pMZ5OFMmkfP2x8uQDuCgRoZS2AZXMPK+Avg5ve0Wlts4IMaFbqP0jIkmNBoUnmlttJzYIPzIkfh9khSzZyjxZwfh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750050051; c=relaxed/simple;
	bh=A4tDZ7bhGVQznAHZZo0IGuB5C81Pp8JCVrrH0VNpdgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRthvSxB5ZI4vshXXp+ZZz7TTqhh5Wvjyri/G9FR3LWN8/7naIhsZany7q2FYqlrCS5cUZcfMPa667JYjY3u9FYKgIUHOKBRYv2pw8ndpNMAevBqTl1/F45wSMo5NxcgO8EA5l+zL7RUil8xq1oKylfXLDg5kE5W06/jJAnRTt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HBmWvl3K; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=upWDJgsCBMXhc7h1gKx5S6TOwK/N2j0j1sD+X8Fk8NE=; b=HBmWvl3KY3kDMeZzm/m5vyVc+Y
	EF2WMAjTF5AeCONNrD1YdeepnWMk/WS9yFdYUOW8YeR68SmtkQdPjIjGPIVUBLkpO+CI2/mF0d5lL
	/FXqAaEnB2zEeGo4TeWW+/1yFGqEzIxqw20dejr4rhi3z2hlXReweDkL2xIWRmwZztCWe85GhCGZh
	dDWrPLDcRDS6dTG04yl6BWzT7YdSQP+C7ftcMONukUz1bBmaS7Q/I6VreVVrAT2A72/7Gcbuik9Xn
	P4Vu886utKJbbPXIN4Ju5JfscYMgd+8FfJBbppOC2tTOVXD0CTbCAUXlyhVIAHwwcKus36ZRgGjCi
	aAhbXdQw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR1xf-00000003NfT-2jij;
	Mon, 16 Jun 2025 05:00:47 +0000
Date: Sun, 15 Jun 2025 22:00:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH v2 2/2] NFSD: Use vfs_iocb_iter_write()
Message-ID: <aE-k_yGEhBmOUpFP@infradead.org>
References: <20250613200847.7155-1-cel@kernel.org>
 <20250613200847.7155-3-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613200847.7155-3-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jun 13, 2025 at 04:08:47PM -0400, Chuck Lever wrote:
> +	kiocb.ki_flags = 0;

Same thing here.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


