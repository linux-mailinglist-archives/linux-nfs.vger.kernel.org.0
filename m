Return-Path: <linux-nfs+bounces-13520-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D96D3B1EE40
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 20:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D6CE623D18
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 18:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57CA215191;
	Fri,  8 Aug 2025 18:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtfLyPAV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFCA1DA3D
	for <linux-nfs@vger.kernel.org>; Fri,  8 Aug 2025 18:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754676774; cv=none; b=LrvHX1YYSwVsiZ70HNvDr9saN1bEEq/n0ikKaysJ/t4wfd2+3gPm2FXFTnsc2DOSxr2OmW0UPBrZ9j25tDpoU6pyafmsQ/6pdOkdcFgZzhvMgEhpXqg3Vxmku6/2hHyQCbG9k/cHulyOsuFzp4CCIJhoEA7TlvXvF3kEYK5w6tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754676774; c=relaxed/simple;
	bh=KECh9e6m+5yUpXb0BQCVMGMMQ7ODhw/Wh0yWWjqaDVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8Nc7ICGqhQynqJh00PhbRJ/sgxdg76j/WhQNaOq8UiwdnEqDCd2jm7wPYRc9StulPUov4P3GNmqk6+R9+uAxSxCod4IXi6u9Mm467v79tipFGTwzjk5aQHRxqrvpzgFmGZDECRycpbYzZ8imT5r2xus7FgHIBNkvlueXVD2raA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtfLyPAV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD0EC4CEED;
	Fri,  8 Aug 2025 18:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754676774;
	bh=KECh9e6m+5yUpXb0BQCVMGMMQ7ODhw/Wh0yWWjqaDVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VtfLyPAVtY87IXEir79v4cAH035i/GCd0Otyjx68Sxbs9YFpjbn2b6no//7xPAIRI
	 ANEweTero97VtLGUDhjMm15w2dnoHqzpGwihXMx0Q1n/TuiknmZiq3Rc1fywZ+r7mK
	 DXr/KzLIEI4aSGt4TJ+MmTaIHUEATJ8FS7DYBtLcweNayULGXmVzvrrm8tUgewmehr
	 jJU3LtnglW4OgCk9+q35+6MBiRLAGFDvO3tmlf9yHlSCVjvKIDNZvNibEgic9MKhB6
	 XbiPg1ckOwEQGoJ6f8ixd/lJcRWWarLY03MvD5ztCljeLL8Dw7kJFh/tnDRHAsNsCd
	 EpUDc644u1a5Q==
Date: Fri, 8 Aug 2025 14:12:53 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v5 5/7] NFSD: filecache: only get DIO alignment attrs if
 NFSD_IO_DIRECT enabled
Message-ID: <aJY-JW-A8fBg4iPD@kernel.org>
References: <20250807162544.17191-1-snitzer@kernel.org>
 <20250807162544.17191-6-snitzer@kernel.org>
 <a7e02c77-381f-4eb3-9a7d-eaefa38ed7ef@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7e02c77-381f-4eb3-9a7d-eaefa38ed7ef@oracle.com>

On Fri, Aug 08, 2025 at 01:59:07PM -0400, Chuck Lever wrote:
> On 8/7/25 12:25 PM, Mike Snitzer wrote:
> > Suggested-by: Jeff Layton <jlayton@kernel.org>
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > ---
> >  fs/nfsd/filecache.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index 5447dba6c5da0..5601e839a72da 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -1058,8 +1058,12 @@ nfsd_file_getattr(const struct svc_fh *fhp, struct nfsd_file *nf)
> >  	struct kstat stat;
> >  	__be32 status;
> >  
> > -	/* Currently only need to get DIO alignment info for regular files */
> > -	if (!S_ISREG(inode->i_mode))
> > +	/* Currently only need to get DIO alignment info for regular files
> > +	 * IFF NFSD_IO_DIRECT is enabled for nfsd_io_cache_{read,write}.
> 
> What happens if the I/O mode is changed from buffered to direct I/O
> while there are open files? I think you will need to collect the
> alignment parameters on all opens regardless of the I/O mode setting.

Good point... so will just drop this patch, thanks.

