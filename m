Return-Path: <linux-nfs+bounces-4056-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC3A90E479
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 09:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E05D3286A34
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 07:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0547605E;
	Wed, 19 Jun 2024 07:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rUP8G96M"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8013F7581D
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 07:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718781906; cv=none; b=UHn/HfJ+5UfOBW+XVIbGZtivr1i9LBs7I+k3eZ3gxNE6AbQDY7XhZEYfJQHsdGuSY1aBdcBzFsfJPR1xldZVRrzTw9CfX2CJ2ZIL/RIPQQksT1JjQujlmbPFNR9+uwjrX7jySqvBF0dUU7U0IzNwTlK1RVKYHCujkZN9YlS1HAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718781906; c=relaxed/simple;
	bh=ljVK4Rit+lAc4lSc6+4w7+8HhTXh/7gCWv/BHLyWiBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YqbVK4Fta4JR+M8WICfZgFSsusE16Mqy/eQL2Iz/DwGl534L2rNltw9DPKhhfm3zECFSqS0ItwEukKAvYifoKylyeGxW0nXZAybTdHT8oOntZuyuuOT3pcJjTffhzU4BqwXWKCNJeSvoYN7CkfAtX4W/f+dB10j9PLlzWmqRuEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rUP8G96M; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=m+KAzyx0gGOCh3rlKcrCSZKA6yPL3BVCF1fzhElooU8=; b=rUP8G96M618eaL3DDHfshxCUW+
	WOkFShLhG0mvboNRujnkgbkWN+xWhP1U6zsH5HCH+2FDuDqb3kfHvR/5vnAu8mnd2TKLzwQN25EQZ
	pYUr/cFKhTWbFA2nBxLiMKWoqnddgrx5sWN/xg+YUdpN2/ifC8Sc0oZKJIaHqGasIoVL73sZrYgwh
	Z7onow/oTIdUCSN9FBgkjErXQTU4Sx7BeDRlth6bgMMKpUeO2SRVULD42vv8RKw/ZQollgoDKHOzm
	3G+p1S502NDE9006lG1T4On9ZwIsIG32UqVlLH4Sj/6upsLtWaDahdeCSi/E0FhK0R5gjFg6v5NdA
	f9xOD7xw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJpgm-00000000Bi9-3Upy;
	Wed, 19 Jun 2024 07:25:04 +0000
Date: Wed, 19 Jun 2024 00:25:04 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Martin Wege <martin.l.wege@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Rick Macklem <rick.macklem@gmail.com>
Subject: Re: Mailing list for FreeBSD NFSv4.1/2nfsd?
Message-ID: <ZnKH0IpRP3Ajioq2@infradead.org>
References: <CANH4o6PRoq26hkB=EJ=bX1r15TjkHSMcxzgrP8oGw+Yy7D4P3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANH4o6PRoq26hkB=EJ=bX1r15TjkHSMcxzgrP8oGw+Yy7D4P3Q@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 19, 2024 at 08:58:07AM +0200, Martin Wege wrote:
> Hello,
> 
> Is there a list for FreeBSD NFSv4.1/v4.2 nfsd?

Asking the FreeBSD NFS maintainer might yield better results than asking
the linux-nfs list.


