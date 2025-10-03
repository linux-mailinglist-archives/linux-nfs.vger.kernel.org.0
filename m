Return-Path: <linux-nfs+bounces-14944-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6C4BB6247
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Oct 2025 09:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BE1A3A9952
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Oct 2025 07:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63E02135B9;
	Fri,  3 Oct 2025 07:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YO9KLp0Y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EE8224AF7
	for <linux-nfs@vger.kernel.org>; Fri,  3 Oct 2025 07:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759475388; cv=none; b=hMZk2pG1++DYJxi6snuK8rU3wKEET/NSi27Xd7CnNujmA3/ILD1ScbeCPB4iHN0M9Y2UAPNZ12vsU3F4yXLTQe4WcfnHkmEnREA67aq30TNqnnYmYjTw3WdN6ruDyOkSG9K9DmuXXKZC9fS6dhrI218hAxs6SHp9j9KlQFIIGrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759475388; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWguxYCAeP3GImLg5P9T00mYr1Z/NS3eM4U8BxFbq/vgn2nFBsg8Jxk8fMTUzs4NFrILwM/1QA3VQ4/mcvoCGWw8X8N5KhyWOSKG5k9u5tnZpfayUM3JWx7VKjJtcw3Jj8KkY82WqcMCIcsyeAff6fiEtD3FtC2oE3A0vUea4oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YO9KLp0Y; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=YO9KLp0YX8kAX7WwS8KtMGvh4k
	v3KjCSMTpbT9mTtIVvf2JPXnVRSjw5Z2CVDsloGvTaUMBdHMXPrac4IeLeU/DYKi9gAbsqDkFT+xO
	ZFidCHVMYNpqvz9aIX5equrPqfNaMeoFgPjzxwE9eiLywttAInzAp7Y/nuTPfDKjqGAB+L5FSGcyP
	H2jSd05bx5JlZJW1jXO6nTs+Z52+MqdWBKadTVgt1dZDR3SJy0acUJD8Cbx2gbG+x/TADddWfaEDI
	f8sWoioNW0yEQeeyFEzajQ5fscV+MdHd3Iazb3ifJLkoRP43NWJ86AcTw1diR60lDQkt+jtFPSmnE
	K8x55gIA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4ZvG-0000000BnJS-0Ejs;
	Fri, 03 Oct 2025 07:09:46 +0000
Date: Fri, 3 Oct 2025 00:09:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH v5 2/6] NFSD: pass nfsd_file to nfsd_iter_read()
Message-ID: <aN92undUAEBAFrV7@infradead.org>
References: <20250929155646.4818-1-cel@kernel.org>
 <20250929155646.4818-3-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929155646.4818-3-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


