Return-Path: <linux-nfs+bounces-17179-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 711FFCCB29F
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 10:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4088F300A6F0
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 09:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5C82F549C;
	Thu, 18 Dec 2025 09:25:38 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA562F361F
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 09:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766049938; cv=none; b=MnFdmjxE11oOsjusAo4ozMAetGTnLPbAXRBLxC8z60NlDiJy52VuL+CNNOWOcUWUBfD2Z25sDgwRGvHh/pdYfWnOf+v/qqKLJw5bNJSTWo/5cGBZEr53Yti7nlIqWa8eKHotdDYx/KVU0ajB0Howey466XA8UnuZ5mLIukvTDHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766049938; c=relaxed/simple;
	bh=ddZIKA0RE9d8reZMkK/q8WscxVSiByxyyOsev80KdZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvYgdNLmZSnw8Kkghv0XHeKjoTjBUm3eA66mW1HUZqS+kW5bLZV/rXIe8wqN1rqevI3uU86GTd6yY516bEWwwW09luRXksQKmil3xGQQBvAEMazNjoTPOvFlqB77SDTs34Zxbmz/lnebSi8FBtoBF/kRgPGO09Dna3PE4mNlp8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EFDD768AFE; Thu, 18 Dec 2025 10:25:30 +0100 (CET)
Date: Thu, 18 Dec 2025 10:25:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <cel@kernel.org>
Cc: Dai Ngo <dai.ngo@oracle.com>, Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, neilb@ownmail.net,
	Olga Kornievskaia <okorniev@redhat.com>,
	Tom Talpey <tom@talpey.com>, Christoph Hellwig <hch@lst.de>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/3] NFSD: Move clientid_hashval and same_clid to
 header files
Message-ID: <20251218092530.GA9235@lst.de>
References: <20251215181418.2201035-1-dai.ngo@oracle.com> <20251215181418.2201035-2-dai.ngo@oracle.com> <f8b4865f-044c-4a5c-b4a6-6e1ea9e756e4@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8b4865f-044c-4a5c-b4a6-6e1ea9e756e4@app.fastmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Dec 15, 2025 at 01:58:49PM -0500, Chuck Lever wrote:
> >  	return bmval_is_subset(bmval, nfsd_suppattrs[minorversion]);
> >  }
> > 
> > +static inline unsigned int clientid_hashval(u32 id)
> > +{
> > +	return id & CLIENT_HASH_MASK;
> > +}
> > +
> 
> I can't comment on the overall purpose of this series yet, but
> there are one or two mechanical issues that I see already.
> 
> Let's not add NFSv4- or pNFS-specific functions to fs/nfsd/nfsd.h.
> Same comment applies to the function declarations this series moves
> in a subsequent patch.
> 
> Why can't clientid_hashval() go into fs/nfsd/state.h instead?

Or why do we need it at all?  It's completly trivial, and there is
no inherent advantage in sharing an arbiteary masking for hasheѕ.

> Also, when a function becomes accessible outside of one source
> file (like a "static inline" function or a callback function),
> it needs to get a kdoc comment that documents its API contract.

And a nfsd_ prefix would also be useful.  All good arguments for
just duplicating this bit.

> > +static inline int same_clid(clientid_t *cl1, clientid_t *cl2)
> > +{
> > +	return (cl1->cl_boot == cl2->cl_boot) && (cl1->cl_id == cl2->cl_id);
> > +}

Now this might have some more reason to be shared as we need two
values to establish the client identify.  Ńo need for the braces
here even wen they are copied from the existing code.

Also I wonder why clientid_t is a typedef instead of a struct?  And
if we want to treat it as opaque, why we're comparing the fields instead
of a memcmp?


