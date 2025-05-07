Return-Path: <linux-nfs+bounces-11543-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EE2AAD47E
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 06:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C509A4A2C2E
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 04:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681AB1C84BF;
	Wed,  7 May 2025 04:36:04 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7606E12CD88
	for <linux-nfs@vger.kernel.org>; Wed,  7 May 2025 04:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746592564; cv=none; b=uUXBv59CpvyJSgqCO7yZGLp08eP0rHDMiIr+0b0nbyJzKA7oA4iuAwlekC5K+eB3HLqZQifHXOeCuMlP8EZwULLETVZXolHbP3MXZfCebFFjC0Nn/SPS3h7QYDKdx6bI5P1lkaEaT0JSetWyk5/w7w22azK+Q9SUTa/s76rDmQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746592564; c=relaxed/simple;
	bh=mACsTjzTRYhGwNOd2hlsG67ffBhtE2c/19XsFMcyjA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KI8eF8Zq9ST4fRy/mHfUMHFJbgj9bEeCOZ8DyKtz85wcUJZUsv1HytMYfzp4A56wQm88JsRwRW8GmlcHmBvcg0KZgfTdvlTX68eMtifH/AdSenyKpWcJbXMjZHrbqkoKGlMum0OPcQKk0BXZtqSyIC1SuPthCqG39T9nrTD2kWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id ABA3268B05; Wed,  7 May 2025 06:35:56 +0200 (CEST)
Date: Wed, 7 May 2025 06:35:56 +0200
From: "hch@lst.de" <hch@lst.de>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "hch@lst.de" <hch@lst.de>, "anna@kernel.org" <anna@kernel.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 3/5] nfs: move the call to nfs_pageio_cond_complete in
 nfs_do_writepage
Message-ID: <20250507043556.GA28402@lst.de>
References: <20250506140815.3761765-1-hch@lst.de> <20250506140815.3761765-4-hch@lst.de> <dcff42774c13403029e187a78196504acebbe142.camel@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dcff42774c13403029e187a78196504acebbe142.camel@hammerspace.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, May 06, 2025 at 03:46:13PM +0000, Trond Myklebust wrote:
> Maybe collapse this patch and 1/5? 🙂

Oops, I didn't realize it was me who messed up the function call
placement.  Yes, this should be fixed at the source.

