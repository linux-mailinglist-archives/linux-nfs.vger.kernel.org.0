Return-Path: <linux-nfs+bounces-12967-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC42EAFFAE5
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jul 2025 09:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 103EE17A9C8
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jul 2025 07:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8A821B195;
	Thu, 10 Jul 2025 07:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kb+YWOGO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393B88F5E;
	Thu, 10 Jul 2025 07:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752132591; cv=none; b=sMePYnMVcJ+34f4KpHJobb82S6/vCYDZEWyHGyNwGDUiScKSr2EmRGQP8LFFqj5sDvtf9dq0TkGkWaZubNaXXXDMd/NAlLqejIYcHz/lm0bKPERDopA+5u/JMzK4AtPSh3LvHcEswakdeQx0jvmnAx2zkTaFg2rqCiTI4OEu+a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752132591; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmC0yubTtDyHQbF7sj/oDmR+sODC0yPN1DaDxqXcv9ss4i2KZYZFf0ab2hdb1eOP0Rg54A6ggo16byC6mmOJC3XIDtzpFfMyn+1a6XuOe15bif+gkj8+aoGTY2Bqf7rWe8nQ2B8CraFHO++4OnC60Ts2WM1Jn+sz9+4LXdqZaTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Kb+YWOGO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Kb+YWOGOmnk5lrwq3+w1zOTzJY
	S3XTu0/BzLwrZXzOJIkoFCJF3SQdjITQxDp4/kgx5enreJPv3K37UfXiAXMoMaJ2Vrn3mKFGYqOnD
	Ztyky8AMdix2FKb9oarg7nudWkr2oJ5AvOdksDhbq+rAde13iXrE8w8lzT7GnCN2fTsZvKMkozO++
	7mH29M0eU4cPwgsVtjxLF1fxjJtvCE2T3lURV/q0tlmrhdbHCtC9t8Q2G8wUFGEIbQbneyk3llSAh
	+EsicaEd/9G8DYme0QKgPgnZc3yLXhIgVQym+hmy1YvJ8cBu6G5UAKzI/un5wFOHmv73/vdvfN7go
	ts5v12xw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZlj1-0000000B0py-130D;
	Thu, 10 Jul 2025 07:29:47 +0000
Date: Thu, 10 Jul 2025 00:29:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sergey Bashirov <sergeybashirov@gmail.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konstantin Evtushenko <koevtushenko@yandex.com>
Subject: Re: [PATCH 1/2] NFSD: Minor cleanup in layoutcommit processing
Message-ID: <aG9r60uzqWcTtJ6S@infradead.org>
References: <20250704114917.18551-1-sergeybashirov@gmail.com>
 <20250704114917.18551-2-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704114917.18551-2-sergeybashirov@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


