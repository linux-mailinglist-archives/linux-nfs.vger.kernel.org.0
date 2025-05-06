Return-Path: <linux-nfs+bounces-11521-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A170AAC803
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 16:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D9B416D603
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 14:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5370F18D656;
	Tue,  6 May 2025 14:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IYSXw6Ye"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B92D1DDA2D;
	Tue,  6 May 2025 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746541944; cv=none; b=Ecb5+B9R+wP3aI8Djj5oj12BeOXFowuMTjh5CLkdLPRQnZ6FBz3r/sctGNytzvZctBwx5tsx9v8P2NUgqq8vVhHWqPnxj1AfCW4k/IjuQ6BIInLFeVYcAxCwa8AKP2NI96KY5Wtm0pq/sRyjWruIObuuSubb0R/SDZzVxfBwKms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746541944; c=relaxed/simple;
	bh=ukc4sFfxNHo7R9qy0JGn+fCRenZkmrAwfGY0qtjDbZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hS2lYtIiMRUyDkO3z4tMLkC1RAM0QhFNOztd0OGmQFqHRfMrEYS+6f6aZSMHfHEpya0WHGiWFA6tKs6FLtR3e3IdOsGjRzj370loAWPsbUQ8xs21DvyCCVGIZBc0UZ8SoSbZ5dzpkkkLVXYBX7KXVwS4ASgi1O3ddm1MM9PXVkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IYSXw6Ye; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fkF0hyTz1yc21HZCRU7Z+Pv1Q1jymcLy2txqYWDyMvs=; b=IYSXw6YeUh+HoAgqvVzfy+H6yV
	3GulqSz/4Qsnxc+FQCaL+SiLKlnkSLx3SZIsr1gYavjhffU8+xzBKA7F21TP1Bv+cz7obB+YwzdlC
	ViyS6o3BI3Mz18kFbxRfy3nDGIm7LW9bgtsuW6pE+rc9oHwKrBovC4JR/1pNkIDft8u4IyXjPMUZA
	c2vFj5OfYST+ueJ2G056RUO8YXNWrBHQbS7msJNEd1Wi7V7WtHoGMxDiDA+hx4EznCYGR0fRjJuVV
	hkfEjFH3Sr9pthm9AGl7tOOBQN/e9ha7F3jKkqhkR15bnksounrcaxHqoz9hGF1h3PQxkCnDGs2qy
	tU50xeZA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCJLK-0000000CKmB-1lnV;
	Tue, 06 May 2025 14:32:22 +0000
Date: Tue, 6 May 2025 07:32:22 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	linux-nvme@lists.infradead.org
Subject: Re: kernel TLS configuration, was: Re: [ANNOUNCE] ktls-utils 1.0.0
Message-ID: <aBoddkwEbyqGllOh@infradead.org>
References: <oracle/ktls-utils/push/refs/tags/ktls-utils-1.0.0/000000-c787cd@github.com>
 <32e4bd99-a85f-4f53-94bd-b8c3ecf2c66f@oracle.com>
 <aBoCELZ_x-C4talt@infradead.org>
 <63b16277-d651-4f37-9e32-965dc6d1e7b0@oracle.com>
 <aBoYDS84d8N5STLq@infradead.org>
 <fb8862b6-97aa-43d0-882f-f0ab9f873e16@oracle.com>
 <aBocWAKRbttPeStt@infradead.org>
 <8094c0f2-3f83-45c0-9b1f-0cee682997d4@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8094c0f2-3f83-45c0-9b1f-0cee682997d4@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, May 06, 2025 at 10:31:04AM -0400, Chuck Lever wrote:
> I do. I can't burn that bridge and stay employed. So calm yourself,
> sir. Let me ask around.

No one expects you to support this.  But you should also not expect
much support for a project with a silly CLA.


