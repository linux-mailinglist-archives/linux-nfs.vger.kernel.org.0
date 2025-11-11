Return-Path: <linux-nfs+bounces-16272-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2184AC4EB21
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Nov 2025 16:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C855234BAD7
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Nov 2025 15:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FEA35BDC9;
	Tue, 11 Nov 2025 15:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zwmr0sQL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9365A35BDCF
	for <linux-nfs@vger.kernel.org>; Tue, 11 Nov 2025 15:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762873855; cv=none; b=e3JfX43ZNWb6vvoCGM9grCqlyxdrgGUzZGY1DcxPz/bcmch1l0x8OxADBfME/KcoRnJGNZQ6I3ESO7zbl9z5hKZKVzZOAGdOZiLBXJLLlFVavIqNXNtpBrvT3vVxqhMc/b1dWs3d0FU9WOG1j/cix+8DTCfHhKUGbMLbFwD3aCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762873855; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhx76fIZMQw7JTcRiI79G8l0HCNCb92Ick9LrXc2w6q4P4UMqA7/D1wsf/7pMNDhrNMl7j9Drk6J95qPNOnIBeOLMwU2AllAnPcX8yPo4gy4jcVRGqTbE7EvfgQzeBLmVLcu5Mbv56LhX2DiMHRWVsD+pXaEBcG4Jy293deIQnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zwmr0sQL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=zwmr0sQLMMVZ4un8qS1P95meMD
	yqo4fJpRU64izj3LHSjUUdjphiMYO2miPnYMr+Vk9DWcAB9UMGIwm5NrwDw9DZLooGoO/nsBov97v
	DsFLsNqonfNRI61S+imj5Kle57fG+76Ptb3bEklBC2Xu0T7+KH2i7ppCA20Aa4kgobJkj3TXERv00
	ZNX7t1sxNa6plsMjjUr7fMzZUzLIukJZ8wtnUBYIrFUm+4dFHlqP4UqgFe1TyxdsGpxKfOm97jgm8
	xFdagxgBqxvU0vswLlVMMFjExd62Q1ngF2A6O3HYD0QoNAxoOFBogpCHq0RcDD3WEupZe7fwb8UQg
	k00Ly7AQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIq1B-00000007MZe-1dBX;
	Tue, 11 Nov 2025 15:10:49 +0000
Date: Tue, 11 Nov 2025 07:10:49 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v12 2/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Message-ID: <aRNR-U1Bds-ULdKq@infradead.org>
References: <20251111145932.23784-1-cel@kernel.org>
 <20251111145932.23784-3-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111145932.23784-3-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


