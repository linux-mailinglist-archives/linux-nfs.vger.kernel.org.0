Return-Path: <linux-nfs+bounces-15785-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CAFC1E783
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 06:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2331B4E42DA
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 05:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD64F2E54B9;
	Thu, 30 Oct 2025 05:55:17 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A51D246333
	for <linux-nfs@vger.kernel.org>; Thu, 30 Oct 2025 05:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761803717; cv=none; b=BrCCG3PDkE2pnSP7Poo9palgWSBae+fn95zFMTYMyX2tiry2Xn2khujVcbeNJi6+kMFqNwX/KWgmwASlMXbc2my8UuoB/YttWdnGgFGDXT15YGaRg9+p3TVf0P+Zj6xB+/5ifL6CSahgivDS+kdXWMvo8Lxl8qbu0gpqZkTvv5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761803717; c=relaxed/simple;
	bh=Bnz30BDEk5XcV1Rjwxj6Yv16xIxRi/v0J/erSWfqzE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEzKH8xT0VjxehaHKYtRBChZCEXZojk5D8u0f5f7Jp0ds8vvkuNCViaRoCcUQkdQ10duUOO/y/SIk+zrrMq66K4ZQ4XApUNA+PTaJ8JFx7qxGzHkE7k5xKYt7KtRgowz9C5hi05XyY3vqOeSKaQEnIddMwEg0JcjMyCyKoPQXX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4282F227A8E; Thu, 30 Oct 2025 06:55:09 +0100 (CET)
Date: Thu, 30 Oct 2025 06:55:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
	okorniev@redhat.com, tom@talpey.com, hch@lst.de,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] NFSD: Fix problem with nfsd4_scsi_fence_client
 using the wrong reservation type
Message-ID: <20251030055509.GA12657@lst.de>
References: <20251029232917.2212873-1-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029232917.2212873-1-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 29, 2025 at 04:28:26PM -0700, Dai Ngo wrote:
> The reservation type argument for the pr_preempt call should match the
> one used in nfsd4_block_get_device_info_scsi. Additionally, the pr_preempt
> operation only needs to be executed once per SCSI target.

One patch per change, please.

Also please add a Fixes: tag.

> 
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/blocklayout.c | 17 +++++++++++++++--
>  fs/nfsd/state.h       |  1 +
>  2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
> index fde5539cf6a6..4ca6cb420736 100644
> --- a/fs/nfsd/blocklayout.c
> +++ b/fs/nfsd/blocklayout.c
> @@ -340,9 +340,22 @@ nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
>  {
>  	struct nfs4_client *clp = ls->ls_stid.sc_client;
>  	struct block_device *bdev = file->nf_file->f_path.mnt->mnt_sb->s_bdev;
> +	int error;
> +
> +	if (ls->ls_fenced)
> +		return;
> +	ls->ls_fenced = true;

What is used to serialize this?

> +		ls->ls_fenced = false;
> +		rpc_ntop((struct sockaddr *)&clp->cl_addr, addr_str, sizeof(addr_str));

Overly long line.

> +		dprintk("nfsd: failed to fence client %s error %d\n",
> +			addr_str, error);
> +	}

Also the error printing is new without any rationale in the commit
message.


