Return-Path: <linux-nfs+bounces-4579-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9917E92520C
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 06:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB5D91C232A2
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 04:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F0D45024;
	Wed,  3 Jul 2024 04:19:27 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6609EBA2D
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jul 2024 04:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719980367; cv=none; b=ZEBsffSDziCv5TBCrg4js0ozNrENbZck17m4qiUig1bX1dxoubW3mLcKLlvvK3mkHA97WK/L7ghAqPheuqHCxTcOB+hydQMh5YfMFnUvADasdwdC1k7z14PiFh3A24awInUcJZWBG2EW32zrDVyEMeJUrINf5rhnsuD2FnC01PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719980367; c=relaxed/simple;
	bh=ll3E2B2ONjDOqykqJARIf0GEvwSIWImaqS75E/xCqzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6xuHp9VaGJ22COTxCUxzsTEGiteSAGptNFdCXy4iCSP2fWrOioroFIkCJRkMcR5GoxXadPag0xzQpVGPKAJTS1B+bQdoswhsmEFysFqRUPvS3IPQhJnAUP8t2EtxWmvDo95J4oOSda7g2f+4ySVZGheYIeER1DFQTXoN4KQwRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7EF9B227A87; Wed,  3 Jul 2024 06:19:21 +0200 (CEST)
Date: Wed, 3 Jul 2024 06:19:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 3/7] nfs: simplify nfs_folio_find_and_lock_request
Message-ID: <20240703041921.GA24050@lst.de>
References: <20240701052707.1246254-1-hch@lst.de> <20240701052707.1246254-4-hch@lst.de> <e00e5ffc-8724-4dcb-868e-2a9d23531648@grimberg.me>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e00e5ffc-8724-4dcb-868e-2a9d23531648@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jul 02, 2024 at 10:54:17AM +0300, Sagi Grimberg wrote:
> Is nfs_folio_find_head_reques() an appropriate name here? it doesn't search 
> and find afaict (aside from internally the pnfs commits search). Anyways, 

I could use a rename.  If everyone agrees I can do that incrementally.


