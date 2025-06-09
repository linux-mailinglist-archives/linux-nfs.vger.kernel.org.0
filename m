Return-Path: <linux-nfs+bounces-12196-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 018C4AD1795
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Jun 2025 06:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB54E168466
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Jun 2025 04:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974177080D;
	Mon,  9 Jun 2025 04:01:48 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F491172A;
	Mon,  9 Jun 2025 04:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749441708; cv=none; b=nOUa5svqidX74J1iabA5jrxorDWw+1nf3aPnWNReRHgb04nWaHI4Z/zn10v4eD4c4NMZpZIHpWNkmAZ8yrE7y31uhj4kkjAXJALez1pHshBNCe9+rL292dBrIkC4V/zHcrA7h8YyKjO7bBv3O6t6DLGBYTAnp+U8L40OwZn4wjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749441708; c=relaxed/simple;
	bh=2OhUdhxavXov7JgPaOcP4WOTWQfeA4nciTmjPDpke2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fW1i+kiIXcsJhYKebPNAyyQMfF2ytizbQ9EGEXyJ4ZUbkR5ENFW4+2Duic6Ym0HhhkVEPlyP3Sf6VYiT0AjawMfNcXn+09nP/xq3kmRUKyQbT/vzsUdPXYYhKiw/O/4gy/hhRPNtRj37tjGiO69I6nFocdjjDsBlcvI1ueg4jyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B3CF368B05; Mon,  9 Jun 2025 06:01:43 +0200 (CEST)
Date: Mon, 9 Jun 2025 06:01:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
	kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
	keyrings@vger.kernel.org
Subject: Re: [PATCH 2/2] nfs: create a kernel keyring
Message-ID: <20250609040143.GA26162@lst.de>
References: <20250515115107.33052-1-hch@lst.de> <20250515115107.33052-3-hch@lst.de> <c2044daa-c68e-43bf-8c28-6ce5f5a5c129@grimberg.me> <aCdv56ZcYEINRR0N@kernel.org> <692256f1-9179-4c19-ba17-39422c9bad69@grimberg.me> <20250602152525.GA27651@lst.de> <aEB3jDb3EK2CWqNi@kernel.org> <20250605042802.GA834@lst.de> <aEMbvQ7EekwPHQ8c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEMbvQ7EekwPHQ8c@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jun 06, 2025 at 07:47:57PM +0300, Jarkko Sakkinen wrote:
> Ah, ok this cleared it up, thanks! Just learning these subsystem,
> appreciate the patience with this one :-)

I'm also just learning the keyring, so double checking from that
perspective is also always welcome..


