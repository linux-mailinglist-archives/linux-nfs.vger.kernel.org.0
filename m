Return-Path: <linux-nfs+bounces-11159-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F170A91F4D
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Apr 2025 16:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1C3B5A77CE
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Apr 2025 14:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A834424EABC;
	Thu, 17 Apr 2025 14:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r5+C38KO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7906924EA8F;
	Thu, 17 Apr 2025 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744899439; cv=none; b=BwdPRCMux5zKvUfo1ZDAdJ7P586vW8xUtxLM9APbJgaNR3k2H7RVBzPP7WM/aXHQPgPHl4w5fyjSTW+wNfFcRPoZw6iXDDQUs4fnvRGeXWzRZi9KPQ2elOA6JibVjPinHOP1MajDx1ibPSml1ITjFAb48t9mFKAu3zUYNj4fIug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744899439; c=relaxed/simple;
	bh=JYulr/kvFyVv/HNI0Ldhqw7RQajqDCiHTFNt7NYBRKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/AousNKJ0gkrsropfYPa1bFLALct3Vs2OwqZ+l6fanX6arkXgdNKF1graCBlIuUNnTItKYCkCdZnWnm5aFWHQ2Wlk6jaEULCkdXpWCGkupnAIQjz3jCuJY8bkNmUg+nvSMcpLAy4gUZ6pRpdZcTpcGn5i7707Zm0t9HGqXoUHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r5+C38KO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66FDBC4CEE4;
	Thu, 17 Apr 2025 14:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744899437;
	bh=JYulr/kvFyVv/HNI0Ldhqw7RQajqDCiHTFNt7NYBRKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r5+C38KOhrHV8eqdvuN861a46rx1OTrqHw80zf7PoLLo11i28oCftdEHYfyUm9jlc
	 caB84yDoj8W3gKH8Fs4jdJ/++b6u+kgRlKng09yXU5lD+Th2BTXpTW7aUZ5Bikxqiv
	 dvDypOHasWIapiisDyTesJay7E4CtbD3GnzFUBVs=
Date: Thu, 17 Apr 2025 16:17:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Rik Theys <rik.theys@gmail.com>
Subject: Re: Two NFSD commits for recent LTS kernels
Message-ID: <2025041759-shack-parasail-e9d5@gregkh>
References: <5ea93daf-5419-4396-96fe-91249ece26b6@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ea93daf-5419-4396-96fe-91249ece26b6@oracle.com>

On Tue, Apr 08, 2025 at 09:35:15AM -0400, Chuck Lever wrote:
> Hi-
> 
> These two upstream commits have Fixes: tags, but should have also been
> marked "Cc: stable" :
> 
>   1b3e26a5ccbf ("NFSD: fix decoding in nfs4_xdr_dec_cb_getattr")
>   4990d098433d ("NFSD: Fix CB_GETATTR status fix")
> 
> As far as I can tell, they can be applied to both origin/linux-6.12.y
> and origin/linux-6.13.y.
> 

Both queued up, thanks.

greg k-h

