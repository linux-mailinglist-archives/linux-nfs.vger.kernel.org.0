Return-Path: <linux-nfs+bounces-12060-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE9FACB89C
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jun 2025 17:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB8C21C27D27
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jun 2025 15:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C47A70825;
	Mon,  2 Jun 2025 15:25:34 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CC71A2547;
	Mon,  2 Jun 2025 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748877933; cv=none; b=mPyj3rsKePsowV55BNjsPeIi3bIb4n4Zejv8d5X5sRCXvuuv//w2RsFWsc8iKL3h08GtHTUcPzLCkkN3y6QRsg39sJNjLFJFwnB/Hu/LxOH7GqsRCfgQ9jDS/uzFBe7gxyHtk6icFyhxl/acV8aWDy2OVTg+wwG62tfUuyd7CjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748877933; c=relaxed/simple;
	bh=sYb1HTwFmid9QR6gcYW6iBAiz6qQUWsRAqJT/xFUer4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbrIYRlhFxHJBQbjvxj7h1iAtZHjZFA9nXigKrrFk08YNVOr4h0fZg7Xe/YGnu3rJGKAh+BJFIoKPj0IoEvmTfNXW+3ZC9PG2KLaJaoicbB2NVdkOW76qQXu6H6gcF4de+w75MhFNPid3h4z8v0ZpnJmMca11Cn0EUO2UyDNiew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AD99468C7B; Mon,  2 Jun 2025 17:25:25 +0200 (CEST)
Date: Mon, 2 Jun 2025 17:25:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
	kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
	keyrings@vger.kernel.org
Subject: Re: [PATCH 2/2] nfs: create a kernel keyring
Message-ID: <20250602152525.GA27651@lst.de>
References: <20250515115107.33052-1-hch@lst.de> <20250515115107.33052-3-hch@lst.de> <c2044daa-c68e-43bf-8c28-6ce5f5a5c129@grimberg.me> <aCdv56ZcYEINRR0N@kernel.org> <692256f1-9179-4c19-ba17-39422c9bad69@grimberg.me>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <692256f1-9179-4c19-ba17-39422c9bad69@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, May 17, 2025 at 12:45:02PM +0300, Sagi Grimberg wrote:
>
>
> On 16/05/2025 20:03, Jarkko Sakkinen wrote:
>> On Fri, May 16, 2025 at 02:47:18PM +0300, Sagi Grimberg wrote:
>>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>> Based on?
>
> Based on the same that nvme is doing. The only reason I see to have it
> is to avoid having the user explicitly set perms on the key for tlshd to be
> able to load it. nvme creates its own keyring that possessors can use, so 
> makes
> sense that nfs has this keyring as well.

Jarkoo, can you please state your objections clearly?  You've only
asked this one liner question in response to Sagi's question but not
even commented the original patch.

