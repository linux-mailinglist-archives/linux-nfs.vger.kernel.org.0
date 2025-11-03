Return-Path: <linux-nfs+bounces-15892-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA23C2B7F7
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 12:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B55984F2760
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 11:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0F12EC09A;
	Mon,  3 Nov 2025 11:42:11 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972F62FF662
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 11:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762170131; cv=none; b=NMkY0QhB+hfVl/jOOog/oWaf1pQ8/7NIRVAfF+BiYUMbpqdVmo4vztwzgg2Z/l/vzrn7f93+u7fPDfnzKmN9YwWDqdwKY50KJ6jD+x9nTMy1up0AsY8VlZTPS4KAMEo0HOgs9JUHPuTqjfj/u64VxBRryQV+1Oaui76tQWudfA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762170131; c=relaxed/simple;
	bh=H8Ej8U6HQcoKfOSfGmE1/2+8UwiLKN2oQkv9EUbvto0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgnbeguaCPsDtRH9qIIo8pYVPj2qYN1/K9dLWIXdCV+Ntx1sWmpE3ySNPzeuHL9lIOF2OpqIPnTEZcCCD4XnABFD4eD072WVUjHg6HlUoxt8QsMMJ90FOZfBBDk47q6B4KVf58otLj7zDQ/0+PDM8Qe94NfMEZDbvf9fv7OXlHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5D684227AAA; Mon,  3 Nov 2025 12:42:05 +0100 (CET)
Date: Mon, 3 Nov 2025 12:42:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
	okorniev@redhat.com, tom@talpey.com, hch@lst.de,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/3] NFSD: Fix problem with nfsd4_scsi_fence_client
 using the wrong reservation type
Message-ID: <20251103114205.GB14852@lst.de>
References: <20251101185220.663905-1-dai.ngo@oracle.com> <20251101185220.663905-2-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251101185220.663905-2-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Nov 01, 2025 at 11:51:33AM -0700, Dai Ngo wrote:
> -			nfsd4_scsi_pr_key(clp), 0, true);
> +			nfsd4_scsi_pr_key(clp), PR_EXCLUSIVE_ACCESS_REG_ONLY, true);

Please avoid the overly long line.  Otherwise this looks good to me.


