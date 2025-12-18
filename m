Return-Path: <linux-nfs+bounces-17183-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8551ECCCE23
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 17:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A119630161D2
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 16:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324EE2BD5B4;
	Thu, 18 Dec 2025 16:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1hOgXNO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF29296BC2
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 16:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766076969; cv=none; b=tCRmP/hJ33d0x2LNEQTDeA8yj4uF10+Y4hiqxIFJNh9gmj4SssMjnUbVAOxdEUqWZqvIW8mOLudJdmJ4IRRTnLYD/WR5YF/FgqTllzw4RoQkuiq0F+MLFBalFmvCDlELcmXEGk6nYnBZScX220y1tuPqdeoxQagXL4WExBxHiwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766076969; c=relaxed/simple;
	bh=aVs0mXPkTuJTJAexdLDKytRkPbXOyGWr7xD4XrwH/YY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j16839CbrakMbylRsP7HhjeEU8IiWz7kma5mwfhVAkAhjmnbgi7AN17YG207bPowX71OEjuLFhT9KpEAXEenFrmyNvos/AHF2JOXPp5DMnhSozwcuk8tUJ12wLKoHZTAcz3u0dvBpC/dg+0TzMwPQ006EJPJ0MKbiNNIQpjUcVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1hOgXNO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6CBC4CEFB;
	Thu, 18 Dec 2025 16:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766076968;
	bh=aVs0mXPkTuJTJAexdLDKytRkPbXOyGWr7xD4XrwH/YY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L1hOgXNOJLtdzziT1pgQn/2coLU9y9s8CLkmJox9tEsoZWohKMqNDs7YipAZ9aYXx
	 1Ibz3ivzUElZjgyYA9zCsUBtXJcbkpEMlsGHWkGxrJg1mwPSpEPmqv5faF8hLAR8oJ
	 dFW2OBbDxicFbN8LZGCLxablVFYVglcCi/yihgEuVlwsWPRPXFEJUlhJi4nC6mMocl
	 WPgirtM68keAZk1G48dYY1u6es0Tmou0VKFBPblgJKvmufBDI6TjG2E31eVwnwYlLb
	 TaXs0/dNS47ANvGDVWmn6u+1TEsoQzEVGgaRnp1qs37AzZHQmZAs/JNmFMYGgyomBh
	 /IzR8vBxtDfGA==
Date: Thu, 18 Dec 2025 11:56:07 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: Re: xdr_stream interface oddities with pages vs stream
Message-ID: <aUQyJ4Bn-UvGuwI6@kernel.org>
References: <aUHcjxer3GmVcBwG@kernel.org>
 <cafae1f3-def3-4b64-ae1e-9d4714d91b5c@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cafae1f3-def3-4b64-ae1e-9d4714d91b5c@app.fastmail.com>

On Wed, Dec 17, 2025 at 08:54:36AM -0500, Chuck Lever wrote:
> 
> 
> On Tue, Dec 16, 2025, at 5:26 PM, Mike Snitzer wrote:
> > Hi,
> >
> > I've been working on enhancing the NFS client and server such that
> > nfs4_{set,set}acl utilities to set/get 4.0 ACLs will work when NFSD
> > v4.1 is reexporting NFS v4.2.  Its soul sucking, but that aside...
> >
> > In my journey I'm finding that xdr_stream_decode_u32() followed by
> > xdr_stream_subsegment() doesn't continue from the point where
> > xdr_stream_decode_u32() advanced xdr_stream's ->p
> >
> > xdr_stream_subsegment() doesn't appear in any way interlocked with the
> > pages offset (->p), it starts with xdr_stream_pos() but  ends with
> > advancing ->p.  So xdr_stream_subsegment() does what it should, I'm
> > concerned about interfaces like xdr_stream_decode_u32() not advancing
> > xdr->nwords
> >
> > Shouldn't both the xdr->p and xdr->nwords be interlocked?  SO that
> > xdr_stream_subsegment() continues from the point where
> > xdr_stream_decode_u32() advanced the stream?
> 
> From the wasteland that is my memory... I think only one side
> uses nwords, and I'm betting it's the encode side. These aren't
> exactly symmetrical APIs, and the differences can be subtle.

It was just user error on my part.. (I had expected the acl_pages to
be aligned at the start of the first page in the subsegment I
extracted, but it was offset within that first page).

Move along nothing to see here! ;)

Thannks,
Mike

