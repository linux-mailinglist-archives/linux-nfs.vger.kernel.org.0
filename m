Return-Path: <linux-nfs+bounces-13475-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB935B1DB0F
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Aug 2025 17:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6AC458533E
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Aug 2025 15:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48977263F52;
	Thu,  7 Aug 2025 15:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zk/5klhc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D70263C8F
	for <linux-nfs@vger.kernel.org>; Thu,  7 Aug 2025 15:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754581999; cv=none; b=I/i2DXN2bahxuzMN+jD/YOtCT24u9F3ezIU2hPabKHX8BAiR2FsJf7t+Lm+7UEMPHLTZJD1X+q+lUTaJkSR7DTKpPuGLLuxgrA0MIosILhpPd11prkeK0eCUpVY6aifu2brEd1oBOfvZfJVUHxedxJdfXIOHeDPcDSUbaINyu54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754581999; c=relaxed/simple;
	bh=y81mD010BpqOXmDhfKNCKQf4T7k7HGxEEvQfiEU1kbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOq++tWUNPnRagbaGWCpmeANgp4vqKm00iR0gNP+fNkDmOmmIv/sCma5lzL0BR2eqfiyznZ/ow+HnTDDdP7hQ+ILlBCWSk2EwGHVJ4lXf35OyX2gWM6hoQJn+VWLGxh6HYvAClXj7059htpG41bgVyqdteJNmvp5Ww3oPLfQXkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zk/5klhc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0A3C4CEEB;
	Thu,  7 Aug 2025 15:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754581999;
	bh=y81mD010BpqOXmDhfKNCKQf4T7k7HGxEEvQfiEU1kbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zk/5klhcpL4iSCDkzl97tel7IbTMXwS0azvytxK5zl2YcWbJElTXnAI/HJn6DHBgn
	 /PPKnFw8Jdw2yzZNIj+I1SbkPzQHiZGypT2D7NKcrwO6qywGzgHS1HMan6u1R1jH4H
	 PEZU/a9MNW8NtlD8jdLiinV+a3ntwcDYXg6fnyPTplq/fNTetsgmZhZYLTQWPX8+yd
	 9u7OkYv0TKm5PmacNa4TLzmprc/TpvFVABOYg+Hnkow7tMwX7Pjs6YUPXuvWqFbLIm
	 MqRm0ZR5ZDElDhCUfTngcVBMG3SZoXiz8iUM/pbmEF4dkQvxVaoONw+4dKpfEMbuYh
	 qXM3HGT/sW9Wg==
Date: Thu, 7 Aug 2025 11:53:17 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: sparse warnings with nfsd-testing [was: Re: [PATCH v4 1/4] NFSD:
 avoid using iov_iter_is_aligned() in nfsd_iter_read()]
Message-ID: <aJTL7WtMWXtuIsrM@kernel.org>
References: <20250805184428.5848-1-snitzer@kernel.org>
 <20250805184428.5848-2-snitzer@kernel.org>
 <d3249463-411d-4e0d-aa20-6489cd52c787@oracle.com>
 <aJN7dr37mo1LXkQx@kernel.org>
 <aJTLL6z0OVZ1k_XC@kernel.org>
 <92a4ae05-1437-43f0-8300-f286ac7452b3@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92a4ae05-1437-43f0-8300-f286ac7452b3@oracle.com>

On Thu, Aug 07, 2025 at 11:51:49AM -0400, Chuck Lever wrote:
> On 8/7/25 11:50 AM, Mike Snitzer wrote:
> > On Wed, Aug 06, 2025 at 11:57:42AM -0400, Mike Snitzer wrote:
> >> On Wed, Aug 06, 2025 at 09:18:51AM -0400, Chuck Lever wrote:
> >>  
> >>> Before reposting, please do run checkpatch.pl on the series.
> >>
> >> Will do, will also ensure bisect safe and that sparse is happy.
> > 
> > FYI, I'm preparing my next patchset and sparse is happy with it, but I
> > wanted to share these warnings seen with nfsd-testing through commit
> > ae83299cc048e ("NFSD: Fix last write offset handling in
> > layoutcommit"):
> > 
> > fs/nfsd/nfs4state.c: note: in included file (through include/linux/wait.h, include/linux/wait_bit.h, include/linux/fs.h):
> > ./include/linux/list.h:229:25: warning: context imbalance in 'put_clnt_odstate' - unexpected unlock
> > fs/nfsd/nfs4state.c:1188:9: warning: context imbalance in 'nfs4_put_stid' - unexpected unlock
> > 
> > I haven't looked at them closer. Could be you're well aware of them?
> 
> These warnings have been there forever. I'm told they are the result of
> bugs in sparse.

OK, good to know, thanks!

