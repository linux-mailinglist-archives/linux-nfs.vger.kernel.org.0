Return-Path: <linux-nfs+bounces-11491-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A68AAC683
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 15:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70CE07BE89C
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 13:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B876280CE7;
	Tue,  6 May 2025 13:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o2fGnjJ5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EB7239E83;
	Tue,  6 May 2025 13:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746538401; cv=none; b=ga2Av1yt31JUct9aBg/+PkaW59w/wQHfZqywy6cVC29jfAa+U3xSnC+MkURn/M5r5KCa/nMT2WQy8saGjdKi5OIzSxbjV+BOnkouqvjaImEKna4tjR69yIp1FkoXfYZ+UTctIsKjyVB3KCxmv8tGEJN0W6A1OPsMN4/h11jT3JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746538401; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogYOnfbH0LESikhKGwbgCpnYVZhveCTEYcPzDhb4pi2MT3KqSxRG/j2VaIrLJY8L/8PYTBCImT5oXMwLaR3DqjYsRZbs++931xc42ZVofBXxVkBulFdSQctXbUbW8455buGblRlHiajfjkFU+VWDb+JiXabKg9AfWnTe8teWyPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=o2fGnjJ5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=o2fGnjJ53S33BFzjIxyvZLn6Fb
	N2LfDduxWQWk9nq4lcyxJ37CnRbau8VoJQN2Ucvb2l4XmcyQYC3HdFmWJA2SMEdvzf02Fu406sJab
	zVMwl+29U0gLOsO6u6oRfpDQdfP6CY76rYcrjtCC+DxcR1Z9zpZFH/X4sdbWU+bde3tZu2x+4HXy/
	7f4m7XQH7pdEuZ0bT0lr/rnkAsg1aYO9lH9aysLb0zHnhuDoE3Za7x3R5wRmAvQ2l23HdoIk8z/0t
	UMY6OWtcLfDDJdlDQ9dmqffUKZMOAYKK2LGDVy2KhftTqMIRhwjAs2nW9d11H+/qD2uHK9d5YPwb3
	0R+d01XA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCIQA-0000000C8Ze-2e3d;
	Tue, 06 May 2025 13:33:18 +0000
Date: Tue, 6 May 2025 06:33:18 -0700
From: Christoph Hellwig <hch@infradead.org>
To: cel@kernel.org
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-rdma@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v4 12/14] NFSD: Remove NFSSVC_MAXBLKSIZE_V2 macro
Message-ID: <aBoPnr9-MN33n4dy@infradead.org>
References: <20250428193702.5186-1-cel@kernel.org>
 <20250428193702.5186-13-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428193702.5186-13-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


