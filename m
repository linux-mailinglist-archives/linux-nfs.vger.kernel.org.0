Return-Path: <linux-nfs+bounces-16838-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C0DC9A2C0
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Dec 2025 07:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E9BDD4E2894
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Dec 2025 06:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF80F2F745D;
	Tue,  2 Dec 2025 06:02:36 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF1B292B2E;
	Tue,  2 Dec 2025 06:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764655356; cv=none; b=RZhnI1Wbq9W2SKOhTrN2kXgjOWCPzqqbwRr/l2uFHUTCpmaKGwMbP3PSlEzDdSNCCGyxExOkKyZW8al1vcqNdje9WVKgeXEkYuLYt5RICg12Cgib+4iq3xp48nY9XvhnFUHN2zObreQgCjzHaekgRCZJvJKc2p4Hisbi73QPngo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764655356; c=relaxed/simple;
	bh=OyysEu/J+ScV3qS2ObWgUgg5U1GtYhIvr8slrV+F/ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VxAmZ9CNZBTZZZw2zi+2F3DxjAmI965bwgQ8fZbg6lmEkgzNHkf22UoGbVAx0K+fGr3t8lnSNqxijs0wxFWlgEfFBcF4JdyihLWUgxXUlrBvcSpv8jgCTnFcb9m/cm1rvHnXH4FDDXRCL6ivPjGNgwj0EmPLPwKLNPTD7vXL19Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2C4A868AA6; Tue,  2 Dec 2025 07:02:27 +0100 (CET)
Date: Tue, 2 Dec 2025 07:02:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: alistair23@gmail.com
Cc: chuck.lever@oracle.com, hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
	kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, hare@suse.de,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v6 4/5] nvme-tcp: Support KeyUpdate
Message-ID: <20251202060226.GA16055@lst.de>
References: <20251202013429.1199659-1-alistair.francis@wdc.com> <20251202013429.1199659-5-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202013429.1199659-5-alistair.francis@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Dec 02, 2025 at 11:34:28AM +1000, alistair23@gmail.com wrote:
> +		if (unlikely(ret < 0)) {
> +			goto msg_control;
>  		}

This should drop the superfluous braces.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

