Return-Path: <linux-nfs+bounces-16199-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F379DC418A2
	for <lists+linux-nfs@lfdr.de>; Fri, 07 Nov 2025 21:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 07DAE4E1EB9
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Nov 2025 20:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FBF302CB2;
	Fri,  7 Nov 2025 20:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqOWV3vk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1A4302CAC
	for <linux-nfs@vger.kernel.org>; Fri,  7 Nov 2025 20:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762546252; cv=none; b=WaF44pHCYKxyvdfeI23Pq/Hw/BwHELjg2JxaEH4Ltvd/M7OPzznu82jq4XrWwVTiRPHjzqdEtbTf14pQpsJKt3TWqylsnPS6aikMmDF/rn6crOr0aBdtXlpAa0pomOSdkyr+GFAWr6Ir8tq7kLlicFrehf9gyMQbTCtoP39hvec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762546252; c=relaxed/simple;
	bh=di3t1GNpcaLR6Ze/qjvhq/ykhD7xJg3601+RpNBlmGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4CO8+Z3mFUW3w96uTeKeyvGX0RRMQprQYRTWFm7t5PfbQaBxecGr3Z8U4dBOC2IN/nwYVlm2yt5Sl65aQRwW0/eWxExMMarbaYLf4r55bSUHyVc7YfssbPjvwdkRKaGqoP3Q9jvQHQZck7Pby4Fxpaoe74b55bAEZwxKX3GC4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqOWV3vk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF016C4CEF5;
	Fri,  7 Nov 2025 20:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762546252;
	bh=di3t1GNpcaLR6Ze/qjvhq/ykhD7xJg3601+RpNBlmGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iqOWV3vkWrYqNJqUTllRUmPRD0jd7nVO9Zv3ZUdeMSFgVsHGu00eYjzxFiO/4bB0b
	 hZ3IU+Y/OCO4HViFQsZ87DBdauJtH9Kdv1Q54sL6umMH1AlwS4h+fw0eL74CNYfUyY
	 yeBjJKHV2bmD7+cPHPo7nPTwdr6BNDp42RlRVClq8In+MX8qc+BxAHXDj327VM06ap
	 4PJglxrwXc6PhjgESU0SE9EwyuNzD8gEPGYh9jtZZicJBDDQuYX9m5NKiJ+S1u70OF
	 F/vpfuIRW6VmFNUzXgpHzMyRoGFCU1Ga7AOj+iVNnc2ebskaSXTI5SJN5OP5qwrBB2
	 rdmUiWFWK1epw==
Date: Fri, 7 Nov 2025 15:10:50 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v11 2/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Message-ID: <aQ5SSnW9xUWj9xBi@kernel.org>
References: <20251107153422.4373-1-cel@kernel.org>
 <20251107153422.4373-3-cel@kernel.org>
 <aQ4Sr5M9dk2jGS0D@infradead.org>
 <82be5f47-77df-423d-a4f3-17f83ddb6636@kernel.org>
 <aQ5Q99Kvw0ZE09Th@kernel.org>
 <fb0d6399-ea74-462a-982a-df232e3f4be9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb0d6399-ea74-462a-982a-df232e3f4be9@kernel.org>

On Fri, Nov 07, 2025 at 03:08:11PM -0500, Chuck Lever wrote:
> On 11/7/25 3:05 PM, Mike Snitzer wrote:
> >> Agreed. The cover letter noted that this is still controversial.
> > Only see this, must be missing what you're referring to:
> > 
> >   Changes since v9:
> >   * Unaligned segments no longer use IOCB_DONTCACHE
> 
> From the v11 cover letter:
> 
> > One controversy remains: Whether to set DONTCACHE for the unaligned
> > segments.

Ha, blind as a bat...

hopefully the rest of my reply helps dispel the controversy

