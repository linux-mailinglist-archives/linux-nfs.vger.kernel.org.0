Return-Path: <linux-nfs+bounces-123-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A965A7FBADF
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Nov 2023 14:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6320628250A
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Nov 2023 13:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1354F88D;
	Tue, 28 Nov 2023 13:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gmYBIYBN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1D1D6D
	for <linux-nfs@vger.kernel.org>; Tue, 28 Nov 2023 05:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cr39bMb58vJt4rWebaEN0xNgrMpZlAXuU3PDJK++r/U=; b=gmYBIYBNRFvWSmeRdmZd1erwaQ
	YO1Dh2A+/bJc4sdrfUimfBLXSQ1s5c0vv5sUchbgMfipR4aVQPcFKsPFhVoiou71Ti+xt0QwxA+tW
	grZ4hZvp3sjWjoeJpZFybps9iLD90OAS+nh57sFl2tMJ9A94tezB9l1NJY2yuq3a/maHqJzMOnGdC
	ODxUJE/qAbvW3fWeFo76ZpaLy4s7ln26/VCvHznLYwTqazx27nI8WmlbeYEbImV1F6IOPgN+IBq5U
	x9ikNXD7S4YuNxS8/u+Fo9lBFGjI7Gr4gSfsh/a6dPLkYGMD2RpXwckMDK4PADAwJYdMEGbIGjWEP
	zw5XtYQQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r7xnF-005M5V-2T;
	Tue, 28 Nov 2023 13:06:25 +0000
Date: Tue, 28 Nov 2023 05:06:25 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Tao Lyu <tao.lyu@epfl.ch>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Question about O_APPEND | O_DIRECT
Message-ID: <ZWXl0ZppQkpafXVr@infradead.org>
References: <c609e5f9df75438dbfe3810859935d58@epfl.ch>
 <2d948b43fa625952e50589e4bedf9551df7ee112.camel@hammerspace.com>
 <7d2d17e4d3904d29b75fadcfd916b2a3@epfl.ch>
 <ZWTFn0/FtJ5WuQGc@infradead.org>
 <7E2914D2-B9AB-4280-9A44-875DA8B58328@oracle.com>
 <ZWTKBzx2Wkw6Mbxd@infradead.org>
 <52559C84-A251-4CAD-8BDF-B1B2EA4DA390@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52559C84-A251-4CAD-8BDF-B1B2EA4DA390@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> I said "proof of concept" -- obviously you don't want this kind of
> racy arrangement as a long-term solution, you just want something
> that works with current server implementations for experimentation.
> 
> And, if the above WRITE succeeds, the client would know exactly
> where the server placed the payload in the file.

But I'm not sure how this proof of concept helps me to prove anything
except that this method sucks :)


