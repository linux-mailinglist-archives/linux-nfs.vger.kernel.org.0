Return-Path: <linux-nfs+bounces-10991-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D81DAA79345
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Apr 2025 18:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9642189800F
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Apr 2025 16:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B93A1C5F13;
	Wed,  2 Apr 2025 16:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Skb1UAaB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DA01BD9F0;
	Wed,  2 Apr 2025 16:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743611382; cv=none; b=G7C0oYV8hEHdkEEeyDde/rexuLLeOJdxoVDI8Wng+VsuckKKIkcd+tZwRFo2UXfqJi9uXDEnrSFCDdVXCFzxu6UokanBhUChSTtBET/NcFstNP3ZYyxQmf9m/wWHp6VVg0ScAhYGx9b7ZvG4/sjB+voH7V1dK5qLrjibIz9CAUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743611382; c=relaxed/simple;
	bh=a1Jqz4AdejyyOw0dqXIvbzsiymf/h4r5uJuyzeJ9uLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/e3+iqTyG0cEbpsf8xtR0yKSqH9rgkeyR0SkLFOS6Uhk3lutWJrPwykzM9lecRvZbgdWvou8aVlhPpsPx/AcEjj5xLEjH1M+kYLQRBNEqiluG+saeEAfkWiHWuli4yyIGa3dIaCr/AcWXJjoDumDy2vdVQQGh42UkeiZ07cnXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Skb1UAaB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5F3C4CEDD;
	Wed,  2 Apr 2025 16:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743611381;
	bh=a1Jqz4AdejyyOw0dqXIvbzsiymf/h4r5uJuyzeJ9uLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Skb1UAaBKKtPjavlMGJbwVmwCc1rQiu68uPSjn9lCdQBO6is8EnPjDiIUlGZDycY9
	 JM8oWG8yoYMtKIi86J3vCO5S61t/futny1iePQ9Nqbrug+NGks6b1tr9eIl4sLNFHW
	 MSafq3gVSFRulAVRtV3fjQTzTnOMi/y8uAvoQtUDJRVEHJ/2Oa5BohZe8RoMrommaH
	 2XTkXhjxJeT6qld4/0WPWeYPeef0q7HxO/kqHlIqU6ndw46E3Vm248mwsYnSgb+nfQ
	 ccqOz0qT9/Y9cbRWArUxH7gG+wfwN96R7YKQpM0MaQbyH7h4saMRZHpROXD6tts417
	 1IYLMdIw/79bg==
Date: Wed, 2 Apr 2025 09:29:40 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfs: add missing selections of CONFIG_CRC32
Message-ID: <20250402162940.GB1235@sol.localdomain>
References: <20250401220221.22040-1-ebiggers@kernel.org>
 <35874d6a-d5bc-4f5f-a62c-c03a6e877588@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35874d6a-d5bc-4f5f-a62c-c03a6e877588@oracle.com>

On Wed, Apr 02, 2025 at 09:51:05AM -0400, Chuck Lever wrote:
> On 4/1/25 6:02 PM, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > nfs.ko, nfsd.ko, and lockd.ko all use crc32_le(), which is available
> > only when CONFIG_CRC32 is enabled.  But the only NFS kconfig option that
> > selected CONFIG_CRC32 was CONFIG_NFS_DEBUG, which is client-specific and
> > did not actually guard the use of crc32_le() even on the client.
> > 
> > The code worked around this bug by only actually calling crc32_le() when
> > CONFIG_CRC32 is built-in, instead hard-coding '0' in other cases.  This
> > avoided randconfig build errors, and in real kernels the fallback code
> > was unlikely to be reached since CONFIG_CRC32 is 'default y'.  But, this
> > really needs to just be done properly, especially now that I'm planning
> > to update CONFIG_CRC32 to not be 'default y'.
> 
> It's interesting that no-one has noticed this before. dprintk is not the
> only consumer of the FH hash function: NFS/NFSD trace points also use
> it.
> 
> Eric, assuming you would like to carry this patch forward instead of us
> taking it through one of the NFS client or server trees:
> 
> Acked-by: Chuck Lever <chuck.lever@oracle.com>
> 
> for the hunks related to nfsd and lockd.

Please go ahead and take it through one of the NFS trees.  Thanks!

- Eric

