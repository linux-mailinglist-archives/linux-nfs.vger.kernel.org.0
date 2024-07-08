Return-Path: <linux-nfs+bounces-4711-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B39792A351
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 14:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C1B01C20B40
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 12:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A259D7E563;
	Mon,  8 Jul 2024 12:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tr6s7srq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5AA3FB94
	for <linux-nfs@vger.kernel.org>; Mon,  8 Jul 2024 12:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720443315; cv=none; b=gt9D8uawJPnwHlwZCLJjBOtWRyBeBYPGDxJIcW84smltzpJPb5KU8wQcjBr9VD6XRLUYgCJk9SBasX7Q2igddQMv38ZFueluwrgpr4sfbNVDwJKERgavHiRP4r5zOnChW3CoYITrqA+6JLnuJNP+PIIgbQyYV7slhQwXbDRX/8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720443315; c=relaxed/simple;
	bh=ptf7kag2rK5w+4/ma580GqRO8nsjPVPmD0BfvxoXUwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=InfZEU7ELZRQ1jlVB2P00t27P/iEOinbFEO2BMDcRcLzbZyXmy82VC8SZRPHL27ollemrEF9NsIJzEfSqb/otnaZqnMPnnX5dyDUBzUbJ7eXcjss8baWyV+1IqXjqqwDQWWLvzCryfWXXbFmLkxGZTrYdtYYw/YmVR0PRSRjceY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tr6s7srq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFEA8C116B1;
	Mon,  8 Jul 2024 12:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720443315;
	bh=ptf7kag2rK5w+4/ma580GqRO8nsjPVPmD0BfvxoXUwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tr6s7srqPWIA2DmxYktEKx6bWCiKEVW440YZCdB6et+pGSsTYqS9xM5g8BiIFJWS+
	 0EVVcgzBJ6/3/Rnj+HABVvo7wiiYdPiP5xL92abh1VtqS5m49tPUvBKLEduYVJwf0K
	 UD2+DdhwqmSbm4v50dKsH4CIJ6xEP+kccXpzL/Kyxmh0HWidB9nAzizKG3mYpyAQGj
	 wOPbm417js/xxR2fnLMne/QCrjJ7T1+pIhgjmd7ij17PdO2xz4NCCGf85TbedR3Pj/
	 WQPas6HWgK20mFaHjsIoXYYccNs01uxRGZQD8aU7m9oui3z7WPSxvjoPUUynYZu3Aj
	 jzwjOT/jfXXYA==
Date: Mon, 8 Jul 2024 08:55:13 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Chuck Lever III <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Neil Brown <neilb@suse.de>, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
Message-ID: <ZovhsRw_NEqhkfTG@kernel.org>
References: <ZoeCFwzmGiQT4V0a@infradead.org>
 <57C1CB2B-3B46-48F3-A095-417845001C3E@oracle.com>
 <ZogAEqYvJaYLVyKj@kernel.org>
 <ZogAtVfeqXv3jgAv@infradead.org>
 <ZogFBqv0z7Rnh4_p@kernel.org>
 <990C712E-99B0-4227-B67D-0DBAA2B2B72E@oracle.com>
 <ZojBAC3XYIee9wN2@kernel.org>
 <Zojc-v8C2ChEOMjq@infradead.org>
 <ZolCzHWhJN-R4Kvg@kernel.org>
 <Zou1dMVdni9hyPvR@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zou1dMVdni9hyPvR@infradead.org>

On Mon, Jul 08, 2024 at 02:46:28AM -0700, Christoph Hellwig wrote:
> On Sat, Jul 06, 2024 at 09:12:44AM -0400, Mike Snitzer wrote:
> > If you'd like reasonable people to not get upset with you, you might
> > try treating them with respect rather than gaslighting them.
> 
> Let me just repeat the calm down offer.  I'll do my side of it by
> stopping from replying to these threads for this week now, after that
> I'll forget all the accusations you're throwing at me, and we restart
> a purely technical discussion, ok?

OK

