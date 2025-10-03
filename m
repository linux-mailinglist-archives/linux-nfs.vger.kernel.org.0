Return-Path: <linux-nfs+bounces-14939-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2CFBB601F
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Oct 2025 08:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1025D1AE00D1
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Oct 2025 06:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD621EA7C6;
	Fri,  3 Oct 2025 06:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e9lbevXT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160B421B9F5;
	Fri,  3 Oct 2025 06:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759474604; cv=none; b=dOEkzqPPHaQo2eWPy0ZwrhvP0j+fL7B00ZWRp9dvvZRgQURqBfkPND2UMQrpO1Ex0uP9Y3NiRlHbejkV5w7dK4DCeUneq3vWqqwWu0OudAKfBvOkjoQnb3dxNJdxFboIZ/VbUUV0w98MXGS/iE+q+4uWiQ1LngPzcRDCpQ58cAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759474604; c=relaxed/simple;
	bh=q2LISh2xwHrpTqKPnBZ5h9bjeJw15giYlmiFTzzqshA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEIoKaqltbxW6Gr71MBwlSXVSsp/gqbcH2PFNHz9B9WFplzrK+hhNt8vr1MAd+PVwo38tyHOyzV4XcfAjjdAauVd5TEAG6mgXcBQYcruUj14i4HzTfDRvq1Ur3xUPa7pKtWquAb3KH15pb6OoqupQQ3JiNPGuDnY4h8FO4V5N74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=e9lbevXT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=q2LISh2xwHrpTqKPnBZ5h9bjeJw15giYlmiFTzzqshA=; b=e9lbevXTQg0XYJ2cLnss8GvloZ
	yNdrBLhAn2kH9s/PAk5xOXfbJA8qAnS170mk+cuJ73qv6OmnN15iG2DV0KF07AtWpKXUKdQcgohRH
	ePmCnz/aajSkJzmI85GPcfZSIJErp5kE/pmeYRGMMzL6skBJkNUxFx2z9toYF/cMLEbPSRMkFaptN
	BaLlhf3reYreyrQ8TrkVcibM5W3xC1V4/wupZaaGLjhpcv7kotR9i4jU0BF/eJ5bGcCQ6uckfLL0F
	+RmVkKxuMFKjJg3rEQ8+oPp5UNo25JpBgAQojIl0PfJEeboLVQ54g8yM1aVbEwAaRhjgkUYHCZ084
	jWjgkbHw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4ZiZ-0000000BlPb-02i9;
	Fri, 03 Oct 2025 06:56:39 +0000
Date: Thu, 2 Oct 2025 23:56:38 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sergey Bashirov <sergeybashirov@gmail.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@infradead.org>, Dai Ngo <Dai.Ngo@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] NFSD/blocklayout: Extract extent mapping from
 proc_layoutget
Message-ID: <aN9zpt75V3F1HjM1@infradead.org>
References: <20251002203121.182395-1-sergeybashirov@gmail.com>
 <20251002203121.182395-3-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002203121.182395-3-sergeybashirov@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Oct 02, 2025 at 11:31:12PM +0300, Sergey Bashirov wrote:
> No changes in functionality. Split the proc_layoutget function to
> create a helper function that maps single extent to the requested
> range. This helper function is then used to implement support for
> multiple extents per LAYOUTGET.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


