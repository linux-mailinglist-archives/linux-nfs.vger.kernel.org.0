Return-Path: <linux-nfs+bounces-102-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5CB7FA73A
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Nov 2023 17:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBDD41C20C5A
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Nov 2023 16:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE153EA7E;
	Mon, 27 Nov 2023 16:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uQD2W7lS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A57B269F
	for <linux-nfs@vger.kernel.org>; Mon, 27 Nov 2023 08:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AnrdgModvNhiQ3zIyb1Exs8CkWoTS+MrYD+Gax8jmV4=; b=uQD2W7lSdlCKO4xgqo/pyBgtwX
	CypktXprxjyhURXoF+HdnTHtDZoRnw1x96xTc7oF9o5rW3Lf28bBgYgVZAx7N6GxY/ykU4AfKV5kn
	XT6Yy6GF1G+g1DQql69WB1bI8N/IwVAVh+INVVVhx5WazU+y0Hnel7n5niBPFfJddEY2YKKKtb1Kx
	OjMwb5EdSlyhiz2IAYaOBXyqWx2T2EYqN8lvJxQCiFml2f71MMbTGCy7X7iyWs988Snb57KBh8Qj3
	TObWxWwyGtT6xIKZopWAaYMdRcw3P6lpousdV2YLL6I9PWDFUL3MnUcguB6Nz1CP3Y+UAnJa0kolO
	FboEIavQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r7etT-0033gb-2Q;
	Mon, 27 Nov 2023 16:55:35 +0000
Date: Mon, 27 Nov 2023 08:55:35 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Tao Lyu <tao.lyu@epfl.ch>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Question about O_APPEND | O_DIRECT
Message-ID: <ZWTKBzx2Wkw6Mbxd@infradead.org>
References: <c609e5f9df75438dbfe3810859935d58@epfl.ch>
 <2d948b43fa625952e50589e4bedf9551df7ee112.camel@hammerspace.com>
 <7d2d17e4d3904d29b75fadcfd916b2a3@epfl.ch>
 <ZWTFn0/FtJ5WuQGc@infradead.org>
 <7E2914D2-B9AB-4280-9A44-875DA8B58328@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7E2914D2-B9AB-4280-9A44-875DA8B58328@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Nov 27, 2023 at 04:50:56PM +0000, Chuck Lever III wrote:
> > Btw, I think an APPEND operation in NFS would be a very good idea, and
> > I'd love to work with interested parties in the IETF on it.
> 
> You can write and submit a personal draft that describes it; it
> wouldn't need to be more than a few pages. The hard part of that
> would be accumulating use case descriptions.
> 
> I think you could create a proof of concept by including a VERIFY
> operation in front of the WRITE to ensure the WRITE occurs only
> if the offset argument in the WRITE agrees with the file's size
> on the server. If the VERIFY fails, the client grabs the updated
> file size and tries again.

That seems like exactly the wrong idea around.  The idea behind append
based models for write out of place storage is that you do not care
where it is written - you leave it to the server or storage device to
place it at the current append point.  You just need to know where it
got placed after the fact for some of them (not for simply logs,
though).


