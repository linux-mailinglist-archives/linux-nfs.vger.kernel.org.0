Return-Path: <linux-nfs+bounces-17746-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE38D122E4
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jan 2026 12:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BC8D6302427B
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jan 2026 11:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5839431D38F;
	Mon, 12 Jan 2026 11:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="woMncY0+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3543928F948;
	Mon, 12 Jan 2026 11:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768216126; cv=none; b=ez1Fi448HV4m87N+ajOj0aXS5juusyB7dY9agHi5x/KCvkvvCQjULRwU69WN2KP9CD7IuSLsLBkLRlyszEdBNxLLNB67I7+Zf3oPQwtLVxK/ro47Lkds1BmjpJ+aEB1LMHYhvVqE33vP/mf5v76aLZDwjI7dUT5WxwalVfqBoEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768216126; c=relaxed/simple;
	bh=ezyFA+DELTx6yBVExaP0BltWre5xkgvONKti9hcWwBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKPtaw4oQLEcmZkeBGULtZksqLAd60EHS/T4XAWyrUy8oFcXnmzB1AfphrX6WFCLGJjHDyjcInTev9UHOLOjXvSsLxIeHpK1kXzdCATqvzU4wZjK0/q0E9N3GIpKsPvcoUxbBZXEDNl4tWdsM6+DQi6GawnGlduyBuhC6ooK+i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=woMncY0+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9092BC16AAE;
	Mon, 12 Jan 2026 11:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768216125;
	bh=ezyFA+DELTx6yBVExaP0BltWre5xkgvONKti9hcWwBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=woMncY0+NDEwaqCjKsEe+u45dFCR1AJRgSOJ49ezvyHOebTQacvqkgdJloh2X5nKa
	 1owUoedbaMlLy8ls059MLe7gxJab7xRwaeoOtfgSIpWwtrHX22I7G6i/qPbXcm6s/L
	 p8CT/5sKn/7ENJSmXz20OKJlGTpZSWWGZZtV2Pc4=
Date: Mon, 12 Jan 2026 12:08:43 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chuck Lever <cel@kernel.org>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH 6.6.y v3 0/4] NFSD: NFSv4 file creation neglects setting
 ACL
Message-ID: <2026011235-coma-sullen-3b13@gregkh>
References: <2025122941-civic-revered-b250@gregkh>
 <20260109143946.4173043-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109143946.4173043-1-cel@kernel.org>

On Fri, Jan 09, 2026 at 09:39:42AM -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> I received an automated report that patch "NFSD: NFSv4 file creation
> neglects setting ACL" failed to apply to the 6.6-stable tree. This
> series is my attempt to address that failure.
> 
> - First, applied several pre-requisite patches
> - LLM agent review for possible regressions reported no issues
> - CI testing reported no regressions
> 
> Changes since v2:
> - Add a Signed-off-by to 1/4
> - Address a build warning introduced in 1/4
> - Fix the In-Reply-To header
> 
> Changes since v1:
> - Replace 1/4 with the upstreamed version of that commit

Nice, this worked, thanks!

greg k-h

