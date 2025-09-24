Return-Path: <linux-nfs+bounces-14695-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD9AB9B92B
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 20:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22C9A1B24E21
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 18:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B883168F6;
	Wed, 24 Sep 2025 18:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2IO9494"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20F83074A0
	for <linux-nfs@vger.kernel.org>; Wed, 24 Sep 2025 18:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758740215; cv=none; b=pZ8upU9x4HDLW2VgfzV4TEbHn0QknNli1JS1+cq460mlC3E59IrWWZidvv7d7f50gxgxVQnYQcvI5CPU9A838+8d+SYLMF2tYYWiJSafFKbL9B7917wIvyWP0ZOS3IFcByM2U70cIjrxC9zQiRtc5i/ekVv9qiSmkHSaX+RT+ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758740215; c=relaxed/simple;
	bh=Xb0/rFzs8vmO9SkQKmgJ5OOExX0mejCkEL67z4bBNEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aCdWp7x6ofxrZIWrpX0lbUKGqk0PRrbtRG02UTzTdKf83hzwwMxb0ECVpsLwqRrCkSXjNhvRJi0d6+LNbH42LzftAeSSLi0UAfwWe3/lm0N/EItYVMwsEvUdGvGcdL4rQip61l6VGhE16J4DjbYX++ZMtTeAKYr1Zu+MVZAeI7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2IO9494; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A46C4CEF4;
	Wed, 24 Sep 2025 18:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758740215;
	bh=Xb0/rFzs8vmO9SkQKmgJ5OOExX0mejCkEL67z4bBNEE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k2IO9494J5m1PFN17j+/T9Z/pnMmtH3v9Q3bhKRUIllSTG12uru8LJkKR1XGLeBfK
	 iM7Yv62fGqIqfECzZBC16j9xt1ERWvWJoni9zLjNoh6ejDSoeJDDp6HIYnz+5US3dT
	 EhI3+SoeEjOfr11KJZ1spiuMnWwVp8f6o05yB42GqNzYEVWRXXWp3S9lnRbCvNwV5b
	 HTuBHWTeHHdILs6CEHjpjM8iDZ1khO/dteLXIe/zj+npwZuW2/Kgtv7UPKjLrd1QOn
	 +VscffwSXIKTSaFduarrduEtc0Zw1A3A5WA5yeiCCog0wlAxWgLu3PIs3Y+jw3ZE3x
	 Rw3fJku23kfRg==
Message-ID: <5b82341d-bec2-4c99-826c-0fa8a7b49268@kernel.org>
Date: Wed, 24 Sep 2025 14:56:53 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] NFSD: Implement NFSD_IO_DIRECT for NFS READ
To: NeilBrown <neil@brown.name>
Cc: Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20250922141137.632525-1-cel@kernel.org>
 <20250922141137.632525-4-cel@kernel.org> <aNMei7Ax5CbsR_Qz@kernel.org>
 <19eef754-57d9-4fe4-a6e6-a481dcec470e@kernel.org>
 <175867132212.1696783.15488731457039328170@noble.neil.brown.name>
 <60960803-80b3-4ca1-9fd3-16bc1bd1dbd4@kernel.org>
 <175869903827.1696783.17181184352630252525@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <175869903827.1696783.17181184352630252525@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/24/25 12:30 AM, NeilBrown wrote:
> nfsd4_encode_readv() calls xdr_reserve_space_vec() passing maxcount from
> the READ request.  The maxcount is passed to xdr_reserve_space()
> repeatedly (one page at a time) where it is added to xdr->buf->page_len
> (where xdr is ->rq_res_stream and xdr->buf is rq_res).
> 
> So the result is often that rq_res.page_len will be maxcount.
> 
> Then nfsd4_encode_readv() calls nfsd_iter_read() which, with this patch,
> will test rq_res.page_len, which will always be non-zero.
> So that isn't what we want.
> 
> (after the read, nfsd4_encode_readv() will call xdr_truncate_encode()
>  which will reduce ->page_len based on how much was read).
> 
> Then nfsd4_encode_readv() calls nfsd_iter_read().
> 
> I don't think we can use ->page_len to determine if it is safe to use
> nfsd_direct_read().

Agreed.


> The conditions where nfsd_direct_read() is safe are
> similar to the conditions where nfsd_splice_read() is safe.  Maybe we
> should use similar code.

That seems to be this bit of logic at the tail of
nfsd4_decode_compound() ?

	argp->splice_ok = nfsd_read_splice_ok(argp->rqstp);
	if (readcount > 1 || max_reply > PAGE_SIZE - auth_slack)
		argp->splice_ok = false;

But it is rather specific to NFSv4 COMPOUND processing.

There is this familiar-looking check in nfsd4_encode_splice_read() :

	/*
	 * Splice read doesn't work if encoding has already wandered
	 * into the XDR buf's page array.
	 */
	if (unlikely(xdr->buf->page_len)) {
		WARN_ON_ONCE(1);
		return nfserr_serverfault;
	}

Which probably works fine without the xdr_reserve_space_vec() call,
and might even be unnecessary.

I think nfsd4_encode_readv() needs to perform the check somehow.
The check for NFSv3 is always going to be simpler.


-- 
Chuck Lever

