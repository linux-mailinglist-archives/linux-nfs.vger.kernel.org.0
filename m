Return-Path: <linux-nfs+bounces-11490-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB723AAC67C
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 15:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CCD616F9D2
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 13:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D10D281529;
	Tue,  6 May 2025 13:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tIG7tEcS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0107D281538;
	Tue,  6 May 2025 13:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746538382; cv=none; b=RxUoDQpBbhxznA3iwjmjuuD0EDNnSZ7NBWv6whuVo1euAzA1+yNSvz51iYEGHe+HtcHVA2nEN3fDy5C1xzBSrCC6rAxON62ngh0Po+MAhcySoBzQCQoMQ7NowE2Soto1si2AbiWcwYCfE+8yPSWdrP0f5+klo7YbnBPm7ySVeco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746538382; c=relaxed/simple;
	bh=wNfTg0KqoYW+u6TWi7l6Z454Wnzkgtkd/HHwIPQz4Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rq8AcFJXJRp4NcMWyS1KrSG8v65NGD/sOxd+Av+t4J+yV97Z7iynMxnB0BSFYMjtzUbix/Xy+wdKkLThuLV1nAxl07qT6oZzBa0pQkACvvmTdcoZtbPvx44y/HBkLXCO05pZhuFznU3EoFu86wsLuiCAgKmyq7CNAv72Iim+KH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tIG7tEcS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wNfTg0KqoYW+u6TWi7l6Z454Wnzkgtkd/HHwIPQz4Qs=; b=tIG7tEcS429VJ/en8lJrnUUoev
	RRMAXrcx7RL2uW7N0gnV2VHWEQu+snEwoQ1qyO1LnTgJlTuGo+fnQTHbN1uFT7+7yUQmlUZbMKl2d
	liqip8Lwt/VuZVfOM0kBwKycxnEO0m9y9yxdkwM8l3tkKC1porTBioRfw0lDyfTY1J3B/RND+WLII
	zzIEaMbaQypbRrtKsxZgkOs8z2bILGAahTFVS1Lgl9XmQZg1CTVqZ8l1WjjfIdQmfKLjP/OtAl4sT
	AARFNkYg3OJ9z07WWk9gGpb42YyMYQG3+Z7gsBY699DT3IzrX2wmfoGUunBZTz1vbJLY5GLm2+ZBA
	36neHcnQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCIPr-0000000C8Y1-1HgB;
	Tue, 06 May 2025 13:32:59 +0000
Date: Tue, 6 May 2025 06:32:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: cel@kernel.org
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-rdma@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v4 11/14] NFSD: Remove NFSD_BUFSIZE
Message-ID: <aBoPixW2J4vibtRd@infradead.org>
References: <20250428193702.5186-1-cel@kernel.org>
 <20250428193702.5186-12-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428193702.5186-12-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Any reason the subject prefix switches from lower to upper case at this
point?


