Return-Path: <linux-nfs+bounces-5396-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2BA952AF4
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Aug 2024 10:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 333BB2822DA
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Aug 2024 08:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B528518C907;
	Thu, 15 Aug 2024 08:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rwEvnGnB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E65C224EF;
	Thu, 15 Aug 2024 08:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723710317; cv=none; b=jIc+ZR/SBVdXxqzUAwXNFo6nI3qWAw2bDWoDwVJz8JB0Gxp9KMf73ro4tI2KU0Vwt0ZSHcYn7mJtfgI9l6Y+hSL24dX4gbVU4EMpdvcSVPg0wJMxdiTkHEK5l6WIEQUGNIFz2/8/r31AXvczjOsnNaviGzaI74y6xd1Z0IcnJ+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723710317; c=relaxed/simple;
	bh=AW8hxqKUUuH4zwGWoGsp1jC6Bx3GIdqEcDEjnSysGTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtyKgBIONupMl1uA6a2IY/bKHY51IDQDWr1mH5T+iILbUt3VC1YBMHOnMpg4sK30Ghwt0apEFWswb7luiJv0NUXEtEzNL8+ugGryJW132O9qDK8JcOlnMA+xLwPDzQQ6Js6BXtVLl7nP3tvEYCVW+t/uVWQJPazjBi2tmwLAo+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rwEvnGnB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF486C32786;
	Thu, 15 Aug 2024 08:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723710317;
	bh=AW8hxqKUUuH4zwGWoGsp1jC6Bx3GIdqEcDEjnSysGTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rwEvnGnBepcg914pTUr2UUD9leQ27aviQQEEz/Z2+wklnH2UR9OfQP7v7DPyLpakG
	 q0nets/oV6xCd8G2hT67FqTtGVXNjvD3zCFSlLsn+DJHUf0MfKgZgdwSdQIs6TWjJ5
	 oE39tM8VUL6Qc9RvIr4S8e2rl/4rnuq5dUewsPlw=
Date: Thu, 15 Aug 2024 10:25:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: cel@kernel.org
Cc: stable@vger.kernel.org, linux-nfs@vger.kernel.org, pvorel@suse.cz,
	sherry.yang@oracle.com, calum.mackay@oracle.com, kernel-team@fb.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH 6.6.y 00/12] Backport "make svc_stat per-net instead of
 global"
Message-ID: <2024081506-grandson-hatless-a094@gregkh>
References: <20240812223604.32592-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812223604.32592-1-cel@kernel.org>

On Mon, Aug 12, 2024 at 06:35:52PM -0400, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Following up on:
> 
> https://lore.kernel.org/linux-nfs/d4b235df-4ee5-4824-9d48-e3b3c1f1f4d1@oracle.com/
> 
> Here is a backport series targeting origin/linux-6.6.y that closes
> the information leak described in the above thread. It passes basic
> NFSD regression testing.
> 
> Review comments welcome.   

All now queued up, thanks.

greg k-h

