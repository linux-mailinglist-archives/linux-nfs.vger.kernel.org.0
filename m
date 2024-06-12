Return-Path: <linux-nfs+bounces-3685-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B33904AA6
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 07:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EC801F2198A
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 05:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724172C1BA;
	Wed, 12 Jun 2024 05:09:06 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE6728DD1
	for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 05:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718168946; cv=none; b=iEpwuiKNuLnvfuoIKXAhV6iH5LJqDghqsKpGXvzg8cAeBEhbaYXxskL7O8chN6DXo8xYCTjB62k1FJWJK6ObKMR8mrUyRQP9fNNQGIvEQGZeF0yR03o2YWGx1hVoSnXpls4Rvb7qZrynHrDn3tWLlXl/5rTJQ8+qnEB5pmOE/Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718168946; c=relaxed/simple;
	bh=7vAdgrn/NamW2RuhsHIwT9Gl3uy2GoPF7IR6O+pZVVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XsmxZG6/v7GM41+9F+nSdMRXOC78gpdtJY5iwh4K2tRJ29GhoDMBzWnRzK0lMWPVY5ug0x+i3CDybnc4Whm3cp3jmG014XGXzkr8lKdmnx0Xq/0LYgZX4Th+GS/B77aDIknbuaFi4BBmi/cUkrM42xmDgSqDpWy16oRfhqnI8ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 448BF68BEB; Wed, 12 Jun 2024 07:09:00 +0200 (CEST)
Date: Wed, 12 Jun 2024 07:08:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: cel@kernel.org
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>, Dai Ngo <dai.ngo@oracle.com>,
	Olga Kornievskaia <kolga@netapp.com>, Tom Talpey <tom@talpey.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] NFSD: Support write delegations in LAYOUTGET
Message-ID: <20240612050859.GA27147@lst.de>
References: <20240611193645.65792-2-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611193645.65792-2-cel@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jun 11, 2024 at 03:36:46PM -0400, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> I noticed LAYOUTGET(LAYOUTIOMODE4_RW) returning NFS4ERR_ACCESS
> unexpectedly. The NFS client had created a file with mode 0444, and
> the server had returned a write delegation on the OPEN(CREATE). The
> client was requesting a RW layout using the write delegation stateid
> so that it could flush file modifications.
> 
> Creating a read-only file does not seem to be problematic for
> NFSv4.1 without pNFS, so I began looking at NFSD's implementation of
> LAYOUTGET.
> 
> The failure was because fh_verify() was doing a permission check as
> part of verifying the FH presented during the LAYOUTGET. It uses the
> loga_iomode value to specify the @accmode argument to fh_verify().
> fh_verify(MAY_WRITE) on a file whose mode is 0444 fails with -EACCES.
> 
> To permit LAYOUT* operations in this case, add OWNER_OVERRIDE when
> checking the access permission of the incoming file handle for
> LAYOUTGET and LAYOUTCOMMIT.

This looks reasonable to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>

