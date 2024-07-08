Return-Path: <linux-nfs+bounces-4734-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC34492A86D
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 19:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59275B209D4
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 17:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D6D148317;
	Mon,  8 Jul 2024 17:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TghK0vy8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B28146A85
	for <linux-nfs@vger.kernel.org>; Mon,  8 Jul 2024 17:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720461020; cv=none; b=OkXDV3oZtJpx5RLC/JIn80Xw70soA9a/2bximz4KjdompmRe+++JI4KbGYTcf5LT9izhwmQCnOUuse39fo7zheuNiOCNzNj9VVSaQldFSVtm+b5ETKL/DqgMzxj9LvqLvUzjWKxAyHODqX4BOFbWFSjiVMCnjMoxYEEgkfxILQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720461020; c=relaxed/simple;
	bh=NR9bvrDePTycQHC2juAdcymV6q+4d/hvumQ76U/UVtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFD3DFP1hpIrXDBelNkIGFen3DSnBT+bgNJZ/rQTOEkCzizEsf3e8uMR5V3rTfIInC1U0UwpZkP8CfGBvVlfLEzDS9eQ5Yczw4pErSZZXvlESZJoVEC+KueJBpjerTrX7U+aJdMIkeKeKHLJl2yDlzqXnvNxJvmcMlikQXkZ6is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TghK0vy8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0CDBC4AF0B;
	Mon,  8 Jul 2024 17:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720461020;
	bh=NR9bvrDePTycQHC2juAdcymV6q+4d/hvumQ76U/UVtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TghK0vy8VYmt5IWaouphK5MEpRZFbJZavnudO9ZABqQx9und7bFsKFKt3anIxg4L2
	 W65Z1KgNZppdSznJPQp9pBvXimc/Zy1xqByEYxHNSnB75iWvvkrBp44uboyOQhb0/H
	 rnLQ97x0tAO/M0hslLEXhruCPUp+hOZ3nUGUfIp52dmIp03iYqCDc/NhlW5XV5dt2n
	 J+64n+TqDuYLs9T47rUmSOR1Zo77dA4LJKP4EBGydfGIvC/jJota+v6iVd5rj+DrG+
	 bIoqHE6C1MTcq2ZvmQkvXWw+jfisXvAI9pzTiz8qvzzUMRCIKIrpkxsBUAw/E2MGfT
	 K46q0Zn6VTs1g==
Date: Mon, 8 Jul 2024 11:50:18 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nvme: implement ->get_unique_id
Message-ID: <Zowm2hDp_B81P2qQ@kbusch-mbp>
References: <20240705164640.2247869-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705164640.2247869-1-hch@lst.de>

On Fri, Jul 05, 2024 at 06:46:26PM +0200, Christoph Hellwig wrote:
> Implement the get_unique_id method to allow pNFS SCSI layout access to
> NVMe namespaces.
> 
> This is the server side implementation of RFC 9561 "Using the Parallel
> NFS (pNFS) SCSI Layout to Access Non-Volatile Memory Express (NVMe)
> Storage Devices".

Thanks, applied to nvme-6.11.

