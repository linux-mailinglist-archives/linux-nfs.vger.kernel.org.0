Return-Path: <linux-nfs+bounces-11710-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EE8AB6233
	for <lists+linux-nfs@lfdr.de>; Wed, 14 May 2025 07:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29C5819E663D
	for <lists+linux-nfs@lfdr.de>; Wed, 14 May 2025 05:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FC91D54EE;
	Wed, 14 May 2025 05:18:15 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B0019E975
	for <linux-nfs@vger.kernel.org>; Wed, 14 May 2025 05:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747199895; cv=none; b=nfF/FVKLUuReG8GPqBfxQumSz9jdD7ysU+9wvLJ9K7LKaELRExO77egWbDxJhd+tzhhWDMxxHVLArR0OLZDXEKCd9SkebPVOsx3WBR46bqm4OrHA0MSXD99Dpr3FMrQkM9U4CsxYEk1T0WLafAnx216fyhTgtE1LAFVObd69Ux0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747199895; c=relaxed/simple;
	bh=4uAZwAsmmvUGE1YOoJsU9oF0IPNSN4J3UugfoUCL660=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7LA4+rhGQbEnqgKNPUR9QWdNwQ2tHnLZIv7vybyzk0LVgjaWyt5M+RktSzvMz1M/P1dcGNfTYDeTefVMyGi29C/efGHHF8VAfIMYYUPrpsAk8XD96Fm6uhe/Br669ZcyE1da4rm7MP+gPs9fJhFouTxIZmnwgYeQA2tYZzmf2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id ECA6068C4E; Wed, 14 May 2025 07:18:09 +0200 (CEST)
Date: Wed, 14 May 2025 07:18:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: Re: writeback cleanups v2
Message-ID: <20250514051809.GB24503@lst.de>
References: <20250507044908.3891983-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507044908.3891983-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, May 07, 2025 at 06:48:50AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series has a bunch of cosmetic cleanups for the NFS folio writeback
> code.

Is this going to get picked up somehere?


