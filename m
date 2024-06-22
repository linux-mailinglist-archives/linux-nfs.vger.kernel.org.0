Return-Path: <linux-nfs+bounces-4229-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CB491320E
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Jun 2024 07:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F851284543
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Jun 2024 05:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826F41494B8;
	Sat, 22 Jun 2024 05:09:36 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6832F3B
	for <linux-nfs@vger.kernel.org>; Sat, 22 Jun 2024 05:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719032976; cv=none; b=s/aQYpDE2UIEPFq/EFf9iPvT/WXTrhp15eYgyFGBmdV8jb4Tyt33MTEBQkpZDJXUOlobuvpeK0AmQgsv6tpYgfxFLIRFNEYd7ixU5/2/KHCjYTLDMGGCLw57FGQvtloSm5ET/iG3MHV8HVGmm9bw0gocwLIzW70W0YCG4neHaHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719032976; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BweU4PBccwl2EULhKQxMQZp5BzM71pXDc0BtxHagdT87gCl5G4ZR3h2VVrOpNAfV70vyI3uDvrI1iTn0ylktT1cDYbkKOSn/OBaxWkjnpoXWo/GWsirFB7EBY9xXZynnD1wimK5d//1BOEHYyFmfn6LN+VHLsjgoQ8/L2NN9W7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B455A68C7B; Sat, 22 Jun 2024 07:09:31 +0200 (CEST)
Date: Sat, 22 Jun 2024 07:09:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: cel@kernel.org
Cc: linux-nfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 4/4] nfs/blocklayout: SCSI layout trace points for
 reservation key reg/unreg
Message-ID: <20240622050931.GC11110@lst.de>
References: <20240621162227.215412-6-cel@kernel.org> <20240621162227.215412-10-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621162227.215412-10-cel@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


