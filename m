Return-Path: <linux-nfs+bounces-13069-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FD3B05403
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 10:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C9261C211FF
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 08:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010D118CC13;
	Tue, 15 Jul 2025 08:03:36 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D4725D540
	for <linux-nfs@vger.kernel.org>; Tue, 15 Jul 2025 08:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752566615; cv=none; b=acWio8uyO10yUGFaAvdVfBW76R85SB3SyTyrceH2urwhDkGN6xsm5rDl4WPZ1XzGMn1mPs3IZLwjWPT9RJzGdyxTign3H5DpFAeUWJsGJ7XIVn2TN12jCzGgsWfesgztHojlSHEG2D3NEp5G4RtMUBn03A1iG8pcFzPR8VIDbc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752566615; c=relaxed/simple;
	bh=df6f2jAMh1inSiBwiRf6wnEpEbtYQy1rvrm0V4INrS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DmLFF/uoJJaskTTfrgjCp6MZ+ZOVAlRhCBmQgc13cDBIKKTuoPGcGZsyLjRQBKGNaNjWBkmEcoITvyK3Kk5faGcebjBkgA7IaTqqJbP6UqbCCzzaRyKeCxJSgW3bwBbll/qP6zUQ3qQFOVp2J+6bJdVmC2UkHJUq/1LV/uDfrLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4EDBB68AA6; Tue, 15 Jul 2025 10:03:30 +0200 (CEST)
Date: Tue, 15 Jul 2025 10:03:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/4] NFS: move the delegation_watermark module parameter
Message-ID: <20250715080329.GA20590@lst.de>
References: <20250714111651.1565055-1-hch@lst.de> <20250714111651.1565055-3-hch@lst.de> <7af8b8239a10a0141be841cb00b8992834a55b43.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7af8b8239a10a0141be841cb00b8992834a55b43.camel@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 14, 2025 at 09:06:42AM -0400, Jeff Layton wrote:
> > -
> > -module_param_named(delegation_watermark, nfs_delegation_watermark, uint, 0644);
> 
> Sure, but I'd just squash this into patch #3:

Why?  It's completely unrelated to the changes there.


