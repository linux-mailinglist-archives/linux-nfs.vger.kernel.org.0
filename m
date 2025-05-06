Return-Path: <linux-nfs+bounces-11486-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67275AAC581
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 15:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82F3E1C0611C
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 13:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA0B28000C;
	Tue,  6 May 2025 13:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HtdPP1Dp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2FC16D9C2;
	Tue,  6 May 2025 13:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537076; cv=none; b=rBvMNh5nNL7/ISVJ8nNQ1Z5IpFnR1v4OdYjHmuOvoryafw57QnLdXiHAdqDzGGPA/p/ttf+cRX9vUS3itbkHCIECQJnvDKAw33DHFz34dgVdNmNlrvxwH9lXa/kO5MJ0bTmNNEgz3d0E6LddS+0mF55TKQLcv+n58IXC5y3Bp9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537076; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CjuD4IOfyknFRIS3NUqkvdNvi44kwctmdZ0+8Uyy/E4vQNmnleZAEG4ib9ls5ukC8/1qQ7o7Kb2MAOlWH/5UKOYBF5xWg/lGbRuzno41W9jc5wcBux3JXT04fJxx2kG9BmJmySxIiYqVYi4XimPSLlBZcWZJp2c+oL6Y8AIBrto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HtdPP1Dp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=HtdPP1DpBGWp7Hn/RLWPXbdPtn
	28vTgusCQ/hKMp9RQZnjVs7Ww/qGB2c/MxdHIBh+ZoJYKubLJrds2DWQMKs12d4cdnAar2JwOn0tR
	JRl7Q5RtoWA5B67YcfnQqCu6rhH45529mOuEsOlg6pRuoxVZ/QeHwOdy6kIu1SkyhySwXEvgFh0lp
	D3sxvvcjmbUNLU+sGNSBf6zDaXUIfA3DhwUpMi6yDjNVu3ZxhnFDYTodUzLGnLnjAkgzUUbLSDb+P
	O6CWm0mOySp7kRL1lEV1282688MJ8AqeW6htg9IEOg5XE8llsukz7HyrfbSOCPqHB7BxLRSA/L1PY
	Iq6eHCrA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCI4n-0000000C2mf-0Ul1;
	Tue, 06 May 2025 13:11:13 +0000
Date: Tue, 6 May 2025 06:11:13 -0700
From: Christoph Hellwig <hch@infradead.org>
To: cel@kernel.org
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-rdma@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v4 03/14] sunrpc: Remove backchannel check in
 svc_init_buffer()
Message-ID: <aBoKcXh3Md137Lmg@infradead.org>
References: <20250428193702.5186-1-cel@kernel.org>
 <20250428193702.5186-4-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428193702.5186-4-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


