Return-Path: <linux-nfs+bounces-20223-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIDNFAhluGmadQEAu9opvQ
	(envelope-from <linux-nfs+bounces-20223-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 21:16:08 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAEA2A01B7
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 21:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 647E9303FA9E
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 20:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C37E22D792;
	Mon, 16 Mar 2026 20:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ze7pd+9g"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59829139D;
	Mon, 16 Mar 2026 20:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773692165; cv=none; b=q6z+A6fAycDVU+OKlR3mAmmvO8Wt+85n1oUVOBDXtq4bHgiq+14tGbepNwz22vZ7uZv0OSJfs7i/DJVNanXYemb+Io9AED5bdREGsrtVHS/OmGMQAf5UDzJFxpCuYOT0a7ZDv4UAuUw6lClV0BT/BtHA+WifhKsC/SzJ5udYK+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773692165; c=relaxed/simple;
	bh=CA3ykj6lgS2xDiPt5TRwIOuEe6+OlWiBhdnNpwqm/HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kED3r9DpjSSmrUlnLsI81190GWPIkzmg3YfjkDmob8ZeFVmTd0DxZWupTkzh5UQ03lB8ALFKS8OVEnb8B5dt7riFHQXNzzgte4vMKZG3hP5/p/RP+lCNN8HjNtKrh0NXBA1HLRM2R8OrVnpMc/BDAQm8IpiY76c4Gqa6rCVWHYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ze7pd+9g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0A6C19421;
	Mon, 16 Mar 2026 20:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773692165;
	bh=CA3ykj6lgS2xDiPt5TRwIOuEe6+OlWiBhdnNpwqm/HM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ze7pd+9gbynypOfeZSutB42h7Mvb4o6sE8bi9sQzFMrZVW3eLE5L2jUsRdEuVGTUm
	 LcKfOyoV1Cz/pqpPCSkkr2o8rn9pECvGn/CZZQUhyUh9DUWqIY/9AQ0Uzite4waBsa
	 3sLFV09up9J0sqlU56092isKPQCZSH1ZNyvNEuGl1Y08wX0RkbnOgKiAWYxoja4jL6
	 IwTrs7mCU78S4sH7YIyMroSuFNMhvt60AUzXsKC4VbnP0V4YiGHRGOivlt8qx8Gr2T
	 ANSC9hyDuCODWgE7wU+qD31vj5BRR5r0VPzi6riKpoefr+31nKUWim2EOrZH71JG48
	 HxR8EuKBRNnpg==
Date: Mon, 16 Mar 2026 22:15:58 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v3 0/4] RDMA/rw: Fix MR pool exhaustion in bvec RDMA READ
 path
Message-ID: <20260316201558.GM61385@unreal>
References: <20260313194201.5818-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313194201.5818-1-cel@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20223-lists,linux-nfs=lfdr.de];
	FREEMAIL_CC(0.00)[lst.de,ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: AAAEA2A01B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 03:41:57PM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> This series now carries two MR exhaustion fixes and a proposal for
> using contiguous pages for RDMA Read sink buffers in svcrdma.
> 
> Fixes for the MR exhaustion issues should go into 7.0-rc and stable,
> and the contiguous page patches can wait for the next merge window.
> 
> Base commit: v7.0-rc3
> ---
> Changes since v2:
> - Fix similar exhaustion issue for SGL
> - Add patch that introduces svc_rqst_page_release
> 
> Changes since v1:
> - Clarify code comments
> - Allocate contiguous pages for RDMA Read sink buffers
> 
> Chuck Lever (4):
>   RDMA/rw: Fall back to direct SGE on MR pool exhaustion
>   RDMA/rw: Fix MR pool exhaustion in bvec RDMA READ path

I applied these two to wip/leon-for-rc.

Thanks

>   SUNRPC: Add svc_rqst_page_release() helper
>   svcrdma: Use contiguous pages for RDMA Read sink buffers
> 
>  drivers/infiniband/core/rw.c      |  43 ++++--
>  include/linux/sunrpc/svc.h        |  15 ++
>  net/sunrpc/svc.c                  |   7 +-
>  net/sunrpc/svcsock.c              |   2 +-
>  net/sunrpc/xprtrdma/svc_rdma_rw.c | 220 ++++++++++++++++++++++++++++++
>  5 files changed, 268 insertions(+), 19 deletions(-)
> 
> -- 
> 2.53.0
> 

