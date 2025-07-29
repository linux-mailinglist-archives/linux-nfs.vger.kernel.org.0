Return-Path: <linux-nfs+bounces-13297-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD93B1495D
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jul 2025 09:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 818113AA379
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jul 2025 07:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D959626529E;
	Tue, 29 Jul 2025 07:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MHVFnAQS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629AC1FECCD;
	Tue, 29 Jul 2025 07:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753775288; cv=none; b=H4DKui6aLRjZfGHuzy53uUMOeimMP0/+t6xtzZF61ADrmrl6enjqVaBZvOT3EegoRZPXLHR1GE712NJwfiqf2UkU5UWgPUZBZFD1V9I2BaOG3eMhY6ZN9L8EoWLf3fyhbQGXwH3Tj9N2AJP2W2qoDNQ5XD9ON+Ae1adrFHZ3wdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753775288; c=relaxed/simple;
	bh=OEftoGeWv/7Clau6/zwUQDUlYKCGqEVE4h73ol2RA2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gj/bHKYcrnRjFa8BcfbhEKRFF+I/eAL/YwQ4Ei4rqg7GqMmI8DdgzKBLfnLcqEkfpmFDpXrvRmgI5wdRbI69NquEXfqWMb2PeCvznaRPiDNizhLKaJgtsj5a8iNk8twFEgrdSSQETakZcJW0LSk5eaQYTTb2hUUrp2LTyOvDiXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MHVFnAQS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=A6Ej71VhVRiIXOgA/NCbJsh4TP05G5FYsAH+lXr1MnQ=; b=MHVFnAQSNIhahSotUi5/S41dEv
	nLSP53xpt5ahjfvhaOARtXqd4rXKlW6NGIYIJS5O7Wala2K3mDfLyz9Z/cdTsJYaawDPzxSjYdzuE
	FXsFJkPYSEZXY0ZYHFxEyWpLzIYglxUJI+0GBw7tXH1nW44a/J+jRinvw5Os3UhI985x8cxQKSJyH
	tJnj6NRVKsSGVQjHi8xErR+pKfmsgr/8MNi7yvuAws7p5LoLSaU/wNTvGnGpxovW00RapXDzm4vKx
	HErsUAmSj0rkNnPsi72afJJVPfbXMOOqaDVTRoc6VdlNtuCVrgGJF3xtwFINkp2X2DTSplx8Ug+gD
	jTbGEBrA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugf49-0000000GAQi-2n0f;
	Tue, 29 Jul 2025 07:48:05 +0000
Date: Tue, 29 Jul 2025 00:48:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: NeilBrown <neil@brown.name>, Christoph Hellwig <hch@infradead.org>,
	Sergey Bashirov <sergeybashirov@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] NFSD: Rework encoding and decoding of nfsd4_deviceid
Message-ID: <aIh8tQWEO9OQiWZe@infradead.org>
References: <>
 <05e851b2-a569-4311-b95b-e1ac94d4db5c@oracle.com>
 <175323408768.2234665.8262591875626168370@noble.neil.brown.name>
 <81f534a7-8763-492d-bbcc-bc49b22d07e8@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81f534a7-8763-492d-bbcc-bc49b22d07e8@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jul 23, 2025 at 10:35:29AM -0400, Chuck Lever wrote:
> > We could document it in the code with __no_randomize_layout after the
> > structure definition.
> 
> We might also want __attribute__((packed)) or even
> __attribute__((packed, aligned(4))).

Absolute not.  packed causes horrible code generation, and
__attribute__((packed, aligned(4))) will probably break things
that didn't properly pad (although they really should).

> That still leaves undocumented the fact that the fields in the structure
> are treated as both endian types. In most other XDR functions we have
> been careful to write source code that shows where endianness changes
> or, conversely, where endianness is not consequential.

I'm not arguing against doing XDR things in XDR code.  But the rest of
the kernel works very different.


