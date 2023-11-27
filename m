Return-Path: <linux-nfs+bounces-99-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4837FA697
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Nov 2023 17:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08290B20FC9
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Nov 2023 16:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6660136AEA;
	Mon, 27 Nov 2023 16:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vr5LAACF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BF299
	for <linux-nfs@vger.kernel.org>; Mon, 27 Nov 2023 08:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=odZBi6HJI9sAn4TqziYwGVe+XbcV0XW8DzDO2hWV0FE=; b=Vr5LAACFHDTsPuZv8tQUti0Xx3
	wJlowCJh8UM5Fl7PlL98jH5ROGC78OexRZLfB+0LTMLAQzI5LWXs63PB23R0WrItCI6RYHNCCu7Yi
	zzuEBRjBKgJCprRqxXN9qaaoK6dPlWEqdDAr1PRsfmu2bYHuQ/rdggBN5GzNbPpgx46OV3HjAUP0K
	shxLa/XJr9ycZplhCEKc0AbHHFlEZOzYZryxnP7UCuiaV+6u4hhK65er55Dyck7sctx8L0ikAYPw4
	8Xvd8yyc6NE/bVdmdFzoAbJR0vRk14UfytKBlDG+5UhxCLETlwxNxFeMdNFfGs8kLxfHfFP9GJgMN
	170TazRg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r7ebH-0031R2-1a;
	Mon, 27 Nov 2023 16:36:47 +0000
Date: Mon, 27 Nov 2023 08:36:47 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Tao Lyu <tao.lyu@epfl.ch>
Cc: Trond Myklebust <trondmy@hammerspace.com>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Question about O_APPEND | O_DIRECT
Message-ID: <ZWTFn0/FtJ5WuQGc@infradead.org>
References: <c609e5f9df75438dbfe3810859935d58@epfl.ch>
 <2d948b43fa625952e50589e4bedf9551df7ee112.camel@hammerspace.com>
 <7d2d17e4d3904d29b75fadcfd916b2a3@epfl.ch>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d2d17e4d3904d29b75fadcfd916b2a3@epfl.ch>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Nov 27, 2023 at 03:28:16PM +0000, Tao Lyu wrote:
> 
> O_APPEND | O_DIRECT can be used to bypass the client cache for multiple threads writing data without caring of the orders (e.g., logs).
> 
> Yes, to support O_APPEND | O_DIRECT, NFS must first support APPEND.
> But the key point is that looks like NFS has supported O_APPEND already.
> I can successfully open a file with "O_RDWR|O_APPEND".
> 
> My confusion is why NFS supports O_RDWR and O_APPEND individually but does not support this combination.

Well, it does support O_RDWR|O_APPEND, just not with O_DIRECT?

Btw, I think an APPEND operation in NFS would be a very good idea, and
I'd love to work with interested parties in the IETF on it.  Not that
we (Damien to be specific) plan to add support to Linux to also report
the actual offset an O_APPEND write wrote to through io_uring as we
have varios use cases for out of place write data stores for that.
It would be great to also support that programming model over NFS.


