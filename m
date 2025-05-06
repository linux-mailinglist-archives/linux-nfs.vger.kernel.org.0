Return-Path: <linux-nfs+bounces-11510-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF26DAAC782
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 16:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 330A046549C
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 14:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760CF28137A;
	Tue,  6 May 2025 14:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C/CcBjaA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5DC8F7D;
	Tue,  6 May 2025 14:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746540559; cv=none; b=bqJGCImYLlbQA3Zzi59GYqVeI6e6zIHRYe+fx7p+5arGs3etHD78Q5NVnWvYj+QmeIq9O+8+fEwuLVAHQk3MKf+rDsPAG7Is98EuvD/0qEMnPHVINS0rx/O41ferrRkzVgnaCxJ3wW5pYVsqzSNsnjKd1w4sscsibpKHMGi0tMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746540559; c=relaxed/simple;
	bh=7j4RlZ7YeNUapKgf+Chlob+RLOvYJtidQUMzo9Wj5is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQJqi9NqfzxG/1akoaw7CZIevxadQjc5Ef9sU8v0FNBUAJ5yEsUlqBNvrBftLaZI9HSpjyZG+/G8wrYSr0KloWRVHX1EcblVm7CTQqwxcNUKROuQ8ccBNZXMx50O1+u07TVjLVCuPBXMsouWFB1MNNF8faNOk9d5UvUsPzgzvZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=C/CcBjaA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7j4RlZ7YeNUapKgf+Chlob+RLOvYJtidQUMzo9Wj5is=; b=C/CcBjaAf0bch6vbg+ZZ+2cZ/u
	aKc6e2qGd1Su1n0g2F5Ysmufp57rVyt33CjA4ieGF1FTAQa5XJ4m+naXLBTn7FppNNKCdy66Fn5uQ
	EQraYNn3zLVmPn6Dd9N8SfeEuOeeJveR/vrXSucdnpQCxxOET2pCQup9zyobMHPO8t7hd6HL3LFPe
	FCfc4zKfWZAf4gSrdiq1mNAJlQHWls9MaRLil/ji8P5uEvYvjYR9XE/7ED3SU8d9C4eDLacUXJCCv
	L9Nd3wiB9G+txeB14JqTNCeCJ5JiWxjlI7ddwRZeOq2PV/SJxYCJPSXVQQNu28QZ/gUHjBGzBvIin
	k02TB4eg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCIyz-0000000CGDK-31z7;
	Tue, 06 May 2025 14:09:17 +0000
Date: Tue, 6 May 2025 07:09:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	linux-nvme@lists.infradead.org
Subject: Re: kernel TLS configuration, was: Re: [ANNOUNCE] ktls-utils 1.0.0
Message-ID: <aBoYDS84d8N5STLq@infradead.org>
References: <oracle/ktls-utils/push/refs/tags/ktls-utils-1.0.0/000000-c787cd@github.com>
 <32e4bd99-a85f-4f53-94bd-b8c3ecf2c66f@oracle.com>
 <aBoCELZ_x-C4talt@infradead.org>
 <63b16277-d651-4f37-9e32-965dc6d1e7b0@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63b16277-d651-4f37-9e32-965dc6d1e7b0@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, May 06, 2025 at 09:42:29AM -0400, Chuck Lever wrote:
> are very welcome. (But you do have to sign the Oracle Contributor's
> Agreement, unfortunately, to get the patches into ktls-utils).

I guess we should just for it, which would also take care of the
musl support?


