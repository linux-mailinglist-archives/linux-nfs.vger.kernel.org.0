Return-Path: <linux-nfs+bounces-14953-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 612C2BB6661
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Oct 2025 11:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0203A344D2D
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Oct 2025 09:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84B32DEA6B;
	Fri,  3 Oct 2025 09:51:19 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D536125E824;
	Fri,  3 Oct 2025 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759485079; cv=none; b=msrjsDXbmag13Qk3wCletymRWP0Mn66r+ysLPDQ05jNSV82527M7JfcUW7yYdXceaUjvSygwDokHLq80ucoZzy6dBDI1ulBTnejM8oOh6ARwCH1/56POjvEz7QUyIKnavc8yH35oPfJ7K7V7+VjK8h04ct+iiveXNR+guYy635A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759485079; c=relaxed/simple;
	bh=917LLIJAnoM6rzDtwvOKgObE0IYuweiOP89/WHFyWAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIPUhq1UOwHdavGx/CV4ggOLbbf9eOXU98s0Cot/8wPqsYC1i6LQx7SVyAfVT4r4HSfllYLP0Z6C41xZ7n1PVmjHsxd/xJh+2fvH/0c6viYAiocUYAIPXnNKM1nAq5FaWXOn/Q0XhuUplORLDjeuzCkthg5T/DPqih87EPklFiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A042E227AAC; Fri,  3 Oct 2025 11:51:11 +0200 (CEST)
Date: Fri, 3 Oct 2025 11:51:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: alistair23@gmail.com
Cc: chuck.lever@oracle.com, hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
	kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, hare@suse.de,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v3 4/8] nvmet: Expose nvmet_stop_keep_alive_timer
 publically
Message-ID: <20251003095111.GA15497@lst.de>
References: <20251003043140.1341958-1-alistair.francis@wdc.com> <20251003043140.1341958-5-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003043140.1341958-5-alistair.francis@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Oct 03, 2025 at 02:31:35PM +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Please explain why making it available is a good idea.  Because it
feels a bit sketchy as-is.


