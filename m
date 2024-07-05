Return-Path: <linux-nfs+bounces-4659-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B89C0928D0E
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jul 2024 19:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CF22B21734
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jul 2024 17:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0D561FC5;
	Fri,  5 Jul 2024 17:32:23 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F5AA955
	for <linux-nfs@vger.kernel.org>; Fri,  5 Jul 2024 17:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720200743; cv=none; b=KXP5wMOM7shrs1LCIBDn4vpgCDo+RarV29dcxovCIbkM2zRsLH7hRBVJuvtSyDGgoDIuab0MZBcNBxAHaRiE34ADMA0Hh20LtGkxp/Qfglc8zsqTe9N2OJ2iPff0yIc4u6WFyadvplLM3fEDXbY62i0Y6XHBCWsWQ+3ApfO+A+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720200743; c=relaxed/simple;
	bh=y3jSV0nlVnP1LMDZ98aP7Rbc6MPbXkAAbHTdN6xDUFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IM6/Pb881US/iDwVOlBiLp1zNhu/hbBTuGMlMsxP+yYxib7lzaL+KuAMHHJV7KtYQAqPzlCBjzhoERWSGsHVkl7L9r9PdI9hZoSaH8mIa4KQZdR3d/Om7xRRomMCvcEzj1Bvq62dVT7Tcgo/lSkMF/UQgFsDkqPgdSPJeK3dk9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 83F4268BFE; Fri,  5 Jul 2024 19:32:16 +0200 (CEST)
Date: Fri, 5 Jul 2024 19:32:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nvme: implement ->get_unique_id
Message-ID: <20240705173216.GA2279@lst.de>
References: <20240705164640.2247869-1-hch@lst.de> <ZogqNFka2384O0pT@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZogqNFka2384O0pT@tissot.1015granger.net>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jul 05, 2024 at 01:15:32PM -0400, Chuck Lever wrote:
> I will connect with you offline to advise me on setting up a test
> harness similar to what I have with iSCSI.

Unfortunately there is nothing that works out of the box right now.

What I've done is that I've taken this patch:

https://lore.kernel.org/linux-nvme/20240229031241.8692-1-kanie@linux.alibaba.com/

which still needs to address a few issues before we can merge it,
and then hacke the nvmet code to not autogenerate a UUID.

I'm looking into a patch to disable uuid autogeneration, and hopefully
we can upstream the persistent reservation support for 6.12.  After
that it should be very similar to the iSCSI test setup.


