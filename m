Return-Path: <linux-nfs+bounces-4595-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB47D9264A5
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 17:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68A5BB217D5
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 15:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C49176AB9;
	Wed,  3 Jul 2024 15:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="unnkKDZg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B6B1DFD1
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jul 2024 15:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019767; cv=none; b=ALrnRGWoF30hB+Y2XYWi6HGiwYaGdAQJUj6KWSmCpp6wXJf537eozcMQqgC+4LU7/O5n441Lv+JBxGKZ4W5ylvDTUMfwERPo5lzEC3+hjkAqsBilV6uS9YA8fCjlNx4XdsG8RNtK61+6MFQJIY8JGWVSLjJ2yNU7NSQeDxY9FGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019767; c=relaxed/simple;
	bh=NUPKBwXcw5ZAjsmeVICYWeLAWvPT2hoAZ3/n39kNtts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ufrylb3UTXORLHxJGB4+DgBtn+q1LhAnFOn2KBCOrSPTtJoLvz+oXz3R/mej/a3zVI7bBdexFZpFiXBjXJytIVxhBo84chdKhZ/A/TGjiNfe4t51J9Jwkud8n+9nV/HPZ4StoTSx59+aUr5j8A+FLLv1XWR/86N4lGqDIBV6rhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=unnkKDZg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UI4wBnyTVQ10cgqYjHBsDXQRiUYIPPVRpdpHLNUgG+8=; b=unnkKDZgeDvsrm9TUQl92NKdbc
	9+HD9+TpLteXpF8rFdffsrOTtWlQczoxlpZz3/ijmNXTsz67hKLQVwUkr3SygVk7BKhCDSgDE8lXf
	pa9xMS5bgjQC9F64gAVm24MGGVcGG+G4Ds7rsKsWxtNsa4xi90/LEnG8UaZblL1doMbMakh/pFahv
	cm+luJrqVAlzxqFwuswg/dyOPOET7nmp7+jQhZUMIk8hg+cPw2F0LKtk3atsSRgAchfUgoIAyDIjz
	DTgstYhJ7WerQz3j1yoEeUNskYDRbBNItcF3W2XMa1UXIOfpcD5BJa1JbJmL/xxzPCu3OO6FtYOiU
	S+XYZxUA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP1iC-0000000AeFk-2WCA;
	Wed, 03 Jul 2024 15:16:00 +0000
Date: Wed, 3 Jul 2024 08:16:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>, snitzer@hammerspace.com
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
Message-ID: <ZoVrMBmOS9BalBXO@infradead.org>
References: <20240702162831.91604-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702162831.91604-1-snitzer@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

I've stated looking a bit at the code, and the architectural model
confuses me more than a bit.

A first thing that would be very helpful is an actual problem statement.
The only mention of a concrete use case is about containers, implying
that this about a client in one container/namespace with the server
or the servers in another containers/namespace.  Is that the main use
case, are there others?

I kinda deduct from that that the client and server probably do not
have the same view and access permissions to the underlying file
systems?  As this would defeat the use of NFS I suspect that is the
case, but it should probably be stated clearly somewhere.

Going from there I don't understand why we need multiple layers of
server bypass.  The normal way to do this in NFSv4 is to use pNFS
layout.

I.e. you add a pnfs localio layout that just does local reads
and writes for the I/O path.  We'd still need a way to find a good
in-kernel way to get the file structure, but compared to the two
separate layers of bypasses in the current code it should be
significantly simpler.

