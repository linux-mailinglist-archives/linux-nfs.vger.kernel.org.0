Return-Path: <linux-nfs+bounces-14026-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B8FB42FC0
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 04:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EC01567555
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 02:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5695E17BA6;
	Thu,  4 Sep 2025 02:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVofCQRc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F0EC8CE
	for <linux-nfs@vger.kernel.org>; Thu,  4 Sep 2025 02:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756953026; cv=none; b=QpdeFTVB0tMag/tfEaSAipRoCTmGeSzyY1YaIkRlyALG6wI1tUvLxbtOtSx/9vtCCLDuwgEjflxl2ZYPhSGXi0NheZBTpfeZvQOdrBNgo8e8sxlkkSo47LnnOhVEVKd95OIaRnxc0PGVqsT0FXk5Q0XGTJBJL9g+VhY4rY9iuV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756953026; c=relaxed/simple;
	bh=oVvEs4mlUTCknqtYXhDh4qYezSWA3Bs9LfGh2+7x95Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjJGXNbUwjhNXTOk7BcBBmvdO7BA9aJ1PVXWkkNzn20ZA66R2bUyZzBTxIDv8IFfb7aipNZSSnXN1lMAZ+bTbGNJ85tNkCpkZVRjIeekDG2a+d1nO3ygklI4BuFkbqa7GlzF7sB/1AXVIP+7uZiNMNkMqjGVfZfeZBhT6K1zEoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVofCQRc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E8AC4CEE7;
	Thu,  4 Sep 2025 02:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756953025;
	bh=oVvEs4mlUTCknqtYXhDh4qYezSWA3Bs9LfGh2+7x95Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NVofCQRcKIW659nsx3Sn1XnrATqJ76pZ/2dlgv3DHZnJ4/PUPMfAP4eSxleOH7oCc
	 20zrN4bWqMMeuESakTq24vXxcEXdRwT4jxVMY0wsuQr4QMUi1NCoMEzKNsVzzlPAd6
	 KDarevF85FVRC2Dn2tfqBTmk4TIPVedNBNLq6e/a9AGjUP6yf9vq8wnKGfOvArxLHK
	 a0XcBRTkW3DQX9R5sJeVcg99kdpod5RewOiONAS73zDMvPthD64JyV3rAdxse9anqc
	 KXAUAOvn+csyvwPkBAMxHr6Ij/vMSL/f6lIHb7gLJOeQM+PFxkgmL7iyX1DmD1pWpH
	 1DU/jY5gSZPIg==
Date: Wed, 3 Sep 2025 19:29:15 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH] nfsd: Don't force CRYPTO_LIB_SHA256 to be built-in
Message-ID: <20250904022915.GA1345@sol>
References: <20250803212130.105700-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250803212130.105700-1-ebiggers@kernel.org>

On Sun, Aug 03, 2025 at 02:21:30PM -0700, Eric Biggers wrote:
> Now that nfsd is accessing SHA-256 via the library API instead of via
> crypto_shash, there is a direct symbol dependency on the SHA-256 code
> and there is no benefit to be gained from forcing it to be built-in.
> Therefore, select CRYPTO_LIB_SHA256 from NFSD (conditional on NFSD_V4)
> instead of from NFSD_V4, so that it can be 'm' if NFSD is 'm'.
> 
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  fs/nfsd/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks like this patch hasn't been applied yet.  Could it be taken
through the nfs tree?  Thanks,

- Eric

