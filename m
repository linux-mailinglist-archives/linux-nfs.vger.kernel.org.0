Return-Path: <linux-nfs+bounces-16294-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E70DC52E3B
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Nov 2025 16:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BAC00504EFE
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Nov 2025 14:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF37333D6D5;
	Wed, 12 Nov 2025 14:38:11 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2764C33CEA2;
	Wed, 12 Nov 2025 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958291; cv=none; b=pd6oJfMiQkqsH+qsruCIOBu8FtSz36jkbuzdNssGrax892VXTgIDRbW45i+LfeOvKp8a2mGiEFPMMbFT6NeNhpGP30gsy54fFtp92BJB8cNwAMREx+ehkMFP7aJuSjbQV7BDfZvLRSQMa8ivPH+9wslOaxar0XilwvMatYwvR3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958291; c=relaxed/simple;
	bh=rMOqIBnKrSZ+2Ceh7Yn6v1Naf0N2rV1tk6qX8O9f5wI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7pg8fj8QG0hMAwUSbhiK1zjJ532xBpXb7Orbfq+1+RTWsYHB7u8G4vZWE5ys4+5FR0yCAWQd2PS7DhmtLucuMjZvwef16uNwoUaWd1DPZI3YvYmvNR2QWaXTjHY3hLgE79UtAcEjmTLkAFt8CwxTCcgVXLJUHr7uGiTvsk99vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7D20D227A88; Wed, 12 Nov 2025 15:38:04 +0100 (CET)
Date: Wed, 12 Nov 2025 15:38:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, alistair23@gmail.com, hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
	kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	kch@nvidia.com, hare@suse.de,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v5 5/6] nvme-tcp: Support KeyUpdate
Message-ID: <20251112143804.GB2831@lst.de>
References: <20251112042720.3695972-1-alistair.francis@wdc.com> <20251112042720.3695972-6-alistair.francis@wdc.com> <20251112065925.GF4873@lst.de> <f7dd4e03-352f-48ba-8a0d-ab9e793ef385@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7dd4e03-352f-48ba-8a0d-ab9e793ef385@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 12, 2025 at 09:31:35AM -0500, Chuck Lever wrote:
> But it is correct style for net/ .

Maybe.  But why would non-net/ code care about their odd preference?

