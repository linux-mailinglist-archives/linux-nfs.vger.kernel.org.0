Return-Path: <linux-nfs+bounces-3462-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FB38D2D2D
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2024 08:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B9D0B28EA9
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2024 06:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E977315B99C;
	Wed, 29 May 2024 06:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QtSENrOu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CF82F56
	for <linux-nfs@vger.kernel.org>; Wed, 29 May 2024 06:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716963930; cv=none; b=pedPIAF3quL55+V3hf8EEFf1YXij3SMiwmeylAjPu/08IB5jbM4dKX9EZ4b0uL+yGzJT9y//X6oWA4Ghnh7gjUklPJJ5ilHWQQW/hj3ZomY7yq3P+qp1NgtxVJhrs92bzXm4bPZyQCvTdVcAhaJC6IKn4b2faxXbQWw1ECO85Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716963930; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJYcNjRyx4/oOLxPqq0PqKh/4bWRZYvTnkYgohnRuzUnNye6XQOdv7gHTm4wqHUgsPEU/tTd3wmyeh4RhvnBjKO9mypkv9corsTpnl/aKCu0YCBHxvz/PiOd9dWfjzlEAvme2K//fTNzKKduz5krVgqQ75/q+LUd4MmlGTIxzqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QtSENrOu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=QtSENrOuMtS0Fcc9xBXd1F7dj1
	2F0NEAXp3g+3BGTbnTYgJQYdts/ZS5hdBK7kqf5BLZYS0Khut0Y4bCpguUfSZE/GFNB8dPvl9dfdG
	S0IJ/+nwwV6va3QJlxXJSB8eM9lBW9up1GR85i0VEXtH+ZQyax5zgbvukD0nOdsr6bZhGbEWiJPYH
	kBFASZDLuI4GGfa61368eD4upFhtJk80VsRJQCWO8+IA6xuGD7PWLUCL6971Y5i8v1iiMMLyOoFE+
	El4OJX3wJanKu/sIZbClgLLXz53JbqZ2gJO0m0zNw0nbfwPJbSdmx7/diK7E4HtsRVsNg0PYNKzD6
	I0m/LMbw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCCkZ-000000030DP-11xY;
	Wed, 29 May 2024 06:25:27 +0000
Date: Tue, 28 May 2024 23:25:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neilb@suse.de>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>, james.clark@arm.com,
	ltp@lists.linux.it, broonie@kernel.org, Aishwarya.TCV@arm.com,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFS: abort nfs_atomic_open_v23 if name is too long.
Message-ID: <ZlbKVyVIJjh-_pUD@infradead.org>
References: <171693789645.27191.13475059024941012614@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171693789645.27191.13475059024941012614@noble.neil.brown.name>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

