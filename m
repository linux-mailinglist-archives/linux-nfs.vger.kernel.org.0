Return-Path: <linux-nfs+bounces-4891-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAD6930D22
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 06:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BB1428135A
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 04:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6351F27457;
	Mon, 15 Jul 2024 04:13:15 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E399223B1;
	Mon, 15 Jul 2024 04:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721016795; cv=none; b=W2R+msvDP6pLl5u0FLsvw+BjtdsjH8A90IxW9UR/B10WEKuvCe9DUVrTKjfaHk3uHQnHX6BsIBEDKjhZz3/dQiKe+WEviUfpYmWxT1IXEdX2tlA98A7RuJ+yNCoFgj8nKvA+w+v5D7bfuI+VFqHcIZqwxsenqowsRL8gJxvBca8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721016795; c=relaxed/simple;
	bh=dp8Y7w3ruSO1K7DfVW1bMqrFQmoYXRT6yPxWd2A0KMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKtWab6n5VZzRwJpm+4KVgP+Dx7fSSDDZB2c3lkoMw08BTs8IEW7VD7lll/bBI2QcczwFNNcxK84PfEc4UF0rDwop4LGMu8LAGxNk7yuCIUIaMK9ZgnRsiuHClx7sBcAd/rfJ11gEZAY3K+jGKUIFlIu0iTeZJuz2FMyf9QmnYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 80A2468B05; Mon, 15 Jul 2024 06:13:06 +0200 (CEST)
Date: Mon, 15 Jul 2024 06:13:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Anna Schumaker <Anna.Schumaker@Netapp.com>,
	Trond Myklebust <trondmy@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Kairui Song <kasong@tencent.com>,
	NFS Mailing List <linux-nfs@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the nfs-anna tree with the
 mm-stable tree
Message-ID: <20240715041306.GA2229@lst.de>
References: <20240715105836.6d6e6e50@canb.auug.org.au> <20240715114759.16a86e78@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715114759.16a86e78@canb.auug.org.au>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks Stephen,

the fix looks good.

Anna, given that the commit is near the head of your branch I can
resend (or you can just fix up directy) to use folio_pos instead of
folio_file_pos to avoid the harder to fix part of the conflict.


