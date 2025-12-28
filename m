Return-Path: <linux-nfs+bounces-17341-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEE2CE574A
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Dec 2025 21:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E48073008FB7
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Dec 2025 20:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECE8125B2;
	Sun, 28 Dec 2025 20:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kpwv3GIo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FC43FC2;
	Sun, 28 Dec 2025 20:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766954717; cv=none; b=OYuQ79kuFK140GUGGPS6YYpbSUaJuzrxxuCuZVTs5xKVmqJouhFpknXvqcN+72IPzdLF+xebJah3hrhFx9i+mhSa0Tmif4LGkIJkB7WfV8hxYJnNbYErZnNlB9lj/TSdAzcGm2jZNw+qj8GSgPPJ5LhM4c0g+BGk6+UglnDbdso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766954717; c=relaxed/simple;
	bh=iu3tGLV3+4eizoTjWi/r1lxrmVab5NJ8O7FuAdLrCBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVat8not7mFasTBgv3rAqdpw5YZTFsNrC7XgUhbfRv4OCwjqC40uQFn3XeHFpLUE90ArvM0Q66mp8G4Jo/gBSgnKtv8bZrm1R4toCImrO/S/l68eC325diaG1q/NYS9sYa/2arCvzm6cgQsSm3HaTK3bbDpMJ7Q4a0XS8z+/lAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kpwv3GIo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A295C4CEFB;
	Sun, 28 Dec 2025 20:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766954716;
	bh=iu3tGLV3+4eizoTjWi/r1lxrmVab5NJ8O7FuAdLrCBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kpwv3GIoFaAMVm/bRXJtB6l7+fDURG7WELDZLUw3A+GohCfD6KCovQjTjd5NAKHdK
	 Dkl3KXntOlSVntPPBS5kh0k9oALj9cBUSv45yFXLTaSelAvPfkNEGXL3tcUN24CF8n
	 EFzFGtjGSpXeoiGQ59ZKVM3dWUAbKucv+RXNVNYRVDb2V0A6SzheuHWFVX6JoVAYVu
	 cN28exr3iy9M4YSNO+cZCKUhVKumoDfG13zBaLo7Xwoa1t6AQg2/vuEOAKrRj6X2rs
	 8GHT20lkN34+unj24qSg1jMX1hIif8puiKjGCCXrf4irt0o7U9Rx9J7TMnCOYMWYCC
	 WDwRtK1nleQzA==
Date: Sun, 28 Dec 2025 12:45:14 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Benjamin Coddington <bcodding@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH v1 6/7] NFSD: Add filehandle crypto functions and helpers
Message-ID: <20251228204514.GC2431@quark>
References: <cover.1766848778.git.bcodding@hammerspace.com>
 <0688787cf4764d5add06c8ef1fecc9ea549573d7.1766848778.git.bcodding@hammerspace.com>
 <bc74d1a3-d128-486e-939a-f7b3dc560931@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc74d1a3-d128-486e-939a-f7b3dc560931@app.fastmail.com>

On Sat, Dec 27, 2025 at 08:34:18PM -0500, Chuck Lever wrote:
> I'd feel more comfortable if the crypto community had a look
> to ensure that we're utilizing the APIs in the most efficient
> way possible. Adding linux-crypto ...

Many crypto algorithms (especially hash algorithms and MACs) have
library APIs now.  They're much easier to use than the traditional APIs.

But it's too soon to be discussing which API to use.  Looking at the
whole series in lore, there doesn't seem to be any explanation of what
problem this series is trying to solve and how cryptography is being
used to solve that problem.

The choice of AES-CBC encryption is unusual.  It's unlikely to be an
appropriate choice for the problem.

I suspect you're really looking to protect the authenticity of the file
handles, not their confidentiality; i.e., you'd like to prevent clients
from constructing their own file handles.  In that case you'd probably
need a MAC, such as SipHash or HMAC-SHA256.  This would be similar to
the kernel's existing implementations of TCP SYN and SCTP cookies: the
system sends out cookies that encode some information, and it uses a MAC
to verify that any received cookie is a previously sent one.

But that's just what I suspect.  I can't know for sure since this series
doesn't provide any context about what it's trying to achieve.

- Eric

