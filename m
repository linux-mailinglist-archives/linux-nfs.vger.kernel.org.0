Return-Path: <linux-nfs+bounces-10997-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA4FA79AD9
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Apr 2025 06:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C81297A595A
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Apr 2025 04:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D10D1990AF;
	Thu,  3 Apr 2025 04:36:05 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DA71624DE;
	Thu,  3 Apr 2025 04:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743654965; cv=none; b=uZv/vlKlzW6pAsbpJIRDzK++EsyUAUVgBgvG4Mg0x4QtxLjDSpHo6iL+mEvzIOqVl6m3oF4ez/sTDzX51YNBOgXSMSPIWY0YMBasTgTjghQwuwilaN7U/oSLb5dm7lbgYadR7fed4tsAucJByX82wCWyCkMWwVSRrvU7kN6gPWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743654965; c=relaxed/simple;
	bh=rhssMNKpK1/hocwlukA8zUQ/YhjGvwICNJ/HdhY5UcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptcrYii/GUtFFchkGk1QhnZnhfCAf/EM7PMd5VrZTnMVOAC9YTpugumOZLj0yiQt5eeAIW+gM82RlWZwgDeN276nvyXflHAAWhDZVeaDE7Vk8sU2JfDRL9esZFO9/NE0/G+iyqA5pAdyZVHHspOKvwG+Z2xEzW1akC5vBWW8/sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0CF4168CFE; Thu,  3 Apr 2025 06:36:00 +0200 (CEST)
Date: Thu, 3 Apr 2025 06:35:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] nfs: Add missing release on error in
 nfs_lock_and_join_requests()
Message-ID: <20250403043559.GA22698@lst.de>
References: <3aaaa3d5-1c8a-41e4-98c7-717801ddd171@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3aaaa3d5-1c8a-41e4-98c7-717801ddd171@stanley.mountain>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Apr 02, 2025 at 02:02:40PM +0300, Dan Carpenter wrote:
> Call nfs_release_request() on this error path before returning.
> 
> Fixes: c3f2235782c3 ("nfs: fold nfs_folio_find_and_lock_request into nfs_lock_and_join_requests")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


