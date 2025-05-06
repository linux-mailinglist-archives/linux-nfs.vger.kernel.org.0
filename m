Return-Path: <linux-nfs+bounces-11518-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 429F0AAC7EE
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 16:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE0707B0382
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 14:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D9426C3AC;
	Tue,  6 May 2025 14:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fzGuM/qY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37581E3DF4;
	Tue,  6 May 2025 14:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746541658; cv=none; b=E9bvQqJmlps6xa6KyPM7vmWANynpN4LYKzspkfYHAlTONh8vAQsKdPPLfBV3IzgrZWGEGrhconKK4YtV+YsrzcSUY0mX5x3wQe65Uk+W8gJ1333FlIKY7F8M4oADQkUwPbRXwEsYF768riZ9UKwvrGgAnpVkIxxxCkWnZkH2TK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746541658; c=relaxed/simple;
	bh=7WVMOxLoLBvlJDf78nGJVGiQ95toUVmA9f6j93iDoZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=inss49Ix9K+2wIul9J6RUDKnpufe1rp8MA9/oph1zSTzqFA3Yg7DWbvXMNA/WXn+QDKfi+AVBHWbsxmPHbsOM7blM0fKkQvYcEj1I2wpKUhWhi9mDXEVbrOcPL+eHnZ9z2BWKvmjialzOMOl8/M5jBANWDRGg+V+m9t0hCJNACE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fzGuM/qY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IHZn7Z4ecIgUYMvftdIgf5bc8WU89/3P1Mm0q/KINBE=; b=fzGuM/qY95nT6lxGDhcZEvvA0/
	yYkNtPSX2adAv30DD2/IkdhtPMmxUJKWd7PPnM59g/wQrDUERppd74w5Ny6sLMJDNd+EiQfuohYQO
	3SCAAAzHu72+LtaVkvsAksMEZnffuu6S94Vc/0DZhJlaD9+nRPMXgtJ4IyPElKeDWj10HrdUJ5ULY
	NiDqeZv+3hocagj40SDjrPycA1DFYxcGYi2ni6sdc0hYce4sN7jHuE1KmQxj4PHL/R/yhrLfkrCiZ
	sJ7vgxPO0DyUgJqOTHcvtB4lKNZJQzaWMwWhAzenIPL9F5Ede8yEqm+hHCOaH/NGiMhKYUCK5df/a
	fHe1Bemg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCJGi-0000000CJyN-11jJ;
	Tue, 06 May 2025 14:27:36 +0000
Date: Tue, 6 May 2025 07:27:36 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	linux-nvme@lists.infradead.org
Subject: Re: kernel TLS configuration, was: Re: [ANNOUNCE] ktls-utils 1.0.0
Message-ID: <aBocWAKRbttPeStt@infradead.org>
References: <oracle/ktls-utils/push/refs/tags/ktls-utils-1.0.0/000000-c787cd@github.com>
 <32e4bd99-a85f-4f53-94bd-b8c3ecf2c66f@oracle.com>
 <aBoCELZ_x-C4talt@infradead.org>
 <63b16277-d651-4f37-9e32-965dc6d1e7b0@oracle.com>
 <aBoYDS84d8N5STLq@infradead.org>
 <fb8862b6-97aa-43d0-882f-f0ab9f873e16@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb8862b6-97aa-43d0-882f-f0ab9f873e16@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, May 06, 2025 at 10:17:48AM -0400, Chuck Lever wrote:
> On 5/6/25 10:09 AM, Christoph Hellwig wrote:
> > On Tue, May 06, 2025 at 09:42:29AM -0400, Chuck Lever wrote:
> >> are very welcome. (But you do have to sign the Oracle Contributor's
> >> Agreement, unfortunately, to get the patches into ktls-utils).
> > 
> > I guess we should just for it, which would also take care of the
> > musl support?
> 
> My employer might not take kindly to that.
> 
> The "MUSL issue" isn't due to the OCA, directly. The developer got
> agreement from his employer (WD) to sign, he just hasn't gotten around
> to it.

the point is that any kind of CLA is completely unacceptable for
something needed in the core Linux stack.

Someone at your employer might have smoked some really bad stuff if
they thought it as a good idea and I don't think anyone gives a rats
ass if they take it kindly or not.


