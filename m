Return-Path: <linux-nfs+bounces-5397-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F29952AF1
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Aug 2024 10:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3C911C20CBF
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Aug 2024 08:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583BE17A932;
	Thu, 15 Aug 2024 08:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x0v9ZRzj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299A8224EF;
	Thu, 15 Aug 2024 08:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723710443; cv=none; b=L6LykNoEcSFoZjlKaitxivXhtfIreqFkMicAkHXOcIpuzpkpHIeliUMsgmc67LKzCLsEaKNoga1GbLFBerlfm/Q7bryFX52ijAtNf34GaLphN5a33vKoqM4C/sh+DFe9qQz+op3TYJv4vh23qcJJH/9/LR3d3oZeN5tnysyt9BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723710443; c=relaxed/simple;
	bh=v8P56oHNTYvbAAxCX1bbMP4akoI/55elIExQZz8jGoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUutaGuHr6Kv3Uz8oVTwiVpujy5Q8ILl+sIWk6mrwsCVAZCg9QHfsch+4ctQyUZse5R2+HjnOZ2ZyiQfwcaNCOHff1vryvj2n95nk/tunSj9haTOp+YFsIfONuy5uXw34aADmabCgPHxBWGfMPfXL66F00pOSyKqy1GAIiixq4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x0v9ZRzj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC684C4AF0E;
	Thu, 15 Aug 2024 08:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723710442;
	bh=v8P56oHNTYvbAAxCX1bbMP4akoI/55elIExQZz8jGoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=x0v9ZRzjzZ5mhfptkgtbMNTmD6JdDVWHeRNGmGANLYsAz7YzjXNX+VtFx06hz9t0K
	 eS621uasixkYSjt/489e+4GYPLPeBwwAKIVoT/mmVADiSIzIY5lzVhEXcaSAD1KwQW
	 mhHYMpPMaBuyuuR5m5sawgMbLpX2KxIiwWakBHE0=
Date: Thu, 15 Aug 2024 10:27:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: cel@kernel.org
Cc: stable@vger.kernel.org, linux-nfs@vger.kernel.org, pvorel@suse.cz,
	sherry.yang@oracle.com, calum.mackay@oracle.com, kernel-team@fb.com,
	ltp@lists.linux.it, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH 6.1.y 00/18] Backport "make svc_stat per-net instead of
 global"
Message-ID: <2024081509-surgical-surgical-fb94@gregkh>
References: <20240810200009.9882-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240810200009.9882-1-cel@kernel.org>

On Sat, Aug 10, 2024 at 03:59:51PM -0400, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Following up on
> 
> https://lore.kernel.org/linux-nfs/d4b235df-4ee5-4824-9d48-e3b3c1f1f4d1@oracle.com/
> 
> Here is a backport series targeting origin/linux-6.1.y that closes
> the information leak described in the above thread.
> 
> I started with v6.1.y because that is the most recent LTS kernel
> and thus the closest to upstream. I plan to look at 5.15 and 5.10
> LTS too if this series is applied to v6.1.y.
> 
> Review comments welcome.

Now queued up, thanks.

greg k-h

