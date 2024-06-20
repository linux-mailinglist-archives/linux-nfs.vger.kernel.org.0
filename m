Return-Path: <linux-nfs+bounces-4118-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7038390FC08
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 06:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A0751C22BAB
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 04:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8423F1BC5C;
	Thu, 20 Jun 2024 04:44:53 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75962386
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 04:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718858693; cv=none; b=a0LCUq0IUT9iyKhvnIwe4E86emMloxkMaW0GABX5I56oenPmQxaa10nyfg+YFCUcu8yiTYJA2nT/9pFpioEBBso2QhJ8GYehcKTaQPeQKUB7d2mXLPRgo/uULr6uV5m6SxFcBUXpw0nt2iQT/cG5YmOnT9D7SGn8xXv/ZMYClo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718858693; c=relaxed/simple;
	bh=DBm/33a+8y+if1Z9tMHDMRQDymX2OmMwV3guQ31Aqq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NSGVOj8L9QhhhsVAWWjeOSucTHhGTM1ZL0pScxj0hMsr43qItuHO/4LM9f0af3yexY5U8w4LEEdnm9SZIk+zqCA+Fqs+CEXYVIwoj6/SrDankomLI5yLORK5s+X3OgpAmaAJsglv2cMHmR7gLuIJQ41OAJKKYpLOGYLsfaKbMWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6A96B68BEB; Thu, 20 Jun 2024 06:44:47 +0200 (CEST)
Date: Thu, 20 Jun 2024 06:44:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: cel@kernel.org
Cc: linux-nfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH 4/4] nfs/blocklayout: Use bulk page allocation APIs
Message-ID: <20240620044447.GB19613@lst.de>
References: <20240619173929.177818-6-cel@kernel.org> <20240619173929.177818-10-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619173929.177818-10-cel@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jun 19, 2024 at 01:39:34PM -0400, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> nfs4_get_device_info() frequently requests more than a few pages
> when provisioning a nfs4_deviceid_node object.

Hmm.  Looks like nfs4_get_device_info uses max_resp_sz to size
the buffer.  In theory the max_deviceinfo_size field in
struct pnfs_layoutdriver_type caps it, but that isn't actually set
anywhere at all.

I guess we can't really do anything to size this better, but at least
for blocklayout where we usually get a single device or a handful
of stripes this is quite an overallocation.

And all that is just to pass it to xdr_init_decode_pages, which
is using it basically as a scratchpad.


