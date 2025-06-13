Return-Path: <linux-nfs+bounces-12406-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2395AD828F
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 07:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9645316ACA8
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 05:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F731BEF8C;
	Fri, 13 Jun 2025 05:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j52ogzQO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD712AD0F;
	Fri, 13 Jun 2025 05:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749792765; cv=none; b=W/PsRSeFldceTXcD15uDlm1PDkUTjrwZqOIP5u7Fdrywqxc5ZaeCFTa4ZIOVeRSWPqddZsc6FQleiZ4aKga9cah3/0iBFVZRC4D8kK0Bk7Oox4sCQL8HKrArLtRkAAlVKwDGQx1QyVOJtFOQgBoMQFRq6HMRnBr6piehmPuUDuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749792765; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbLj42fCGAaZDM52u4G5v4XjKkZY19pmZ1KrfRfL09ONPv0RdY8YbXMGRmTjyGskmcYLAX0WOnUMv1qya5YaYNsSiiQ3x2zwWqosFW+mVm3d0ThCwlxt4rkWGxY1aqK9jt+pOvnCw3sm7hom7xOtE74JjIpgP1C/I3Jn0DRaMu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=j52ogzQO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=j52ogzQOkJtRghrt7cNWoYEQ0G
	bOwWHNLX8M8OuQ9AWikhe3rBBPbThL1KO99ujsZ1/+JQeBo5W+U8dm/7qlypE8qzYbvFaU6+w+KhL
	2iePOWx5KznOEtqXkNtYIlisISnlUzZHupa/qdwYNZ/TJDN6UDOBymfCuYC4/8uSl+FcggkCCIf5i
	98Vzcll5gimNdrvgUPZSZJa7LlASSNrYRnvM4rIAe5nCAfw21WK7coJsaMXQHnECztNIEE9C4GyM/
	pUtzz8KCiYEFHoe8YQZJrj0onwfoiSVMaJsMRctS2zltQuTAFfNmrHrIvlMYJ0+of5R5eEoeO1eGd
	PZIbfiYw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPx1q-0000000FO48-0L7n;
	Fri, 13 Jun 2025 05:32:38 +0000
Date: Thu, 12 Jun 2025 22:32:38 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sergey Bashirov <sergeybashirov@gmail.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konstantin Evtushenko <koevtushenko@yandex.com>
Subject: Re: [PATCH v3] nfsd: Use correct error code when decoding extents
Message-ID: <aEu39qgP5lnHwNSb@infradead.org>
References: <20250612214303.35782-1-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612214303.35782-1-sergeybashirov@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


