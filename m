Return-Path: <linux-nfs+bounces-13835-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F38D3B2FDC3
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 17:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFCDA7AE2FE
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 15:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54687267729;
	Thu, 21 Aug 2025 15:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLMXtmef"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B6826AAAA
	for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 15:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755788835; cv=none; b=mQOgoxf/7s82arZ+Nlk151Rt9KrkofMl0FnDiIQ+5aWV8xW3/6gDGZJqBlr4A8VJJTE9XUUd5bAns4gEyBC9sIKp/tz2KFCdS61cVE0Qtsa7PEIQvjPX3Q5KwjJ7VTHoWUU67wIShWcz4+aUOBTkrNoGchpoGEz0DLCuT9UdI6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755788835; c=relaxed/simple;
	bh=FRBjoyxCpYnFlZdCyIoIsS6vT7qK8CUpP4sqtjMXtAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FyF/sasZYeqrcgvzukZnvIxcf/Dt9juXH3t2b0kDzs8ffwGQrWfqxPI6Gr5q5dcTw3BpeTWYaLHnLfvFIqUsrBSpZdXpv+yI2KBKsajkdgd7pLA+/yv7rFt8lfZHKMaET/qyaOnbglAgSa5GsOUksnuiTTmmMRMi1QRkJ8FqToo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLMXtmef; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C17CC4CEF4;
	Thu, 21 Aug 2025 15:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755788834;
	bh=FRBjoyxCpYnFlZdCyIoIsS6vT7qK8CUpP4sqtjMXtAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mLMXtmef9gZvdDeWa8sDjCbVPZXVvph11JcVtuTk0H72Wj5eUOqYTJj2juSuHjr+H
	 9Og4O8hb9PjfHCDzaRf00xNg6iN1YdQQgVKTjttHz3rXVELztKSO8JEuYP5V8SAN0M
	 AXnaJkyPLHMFP3Mcq/A34pEXTm8c8ebllJWlzd8QkZ1v7x+lnsGkxN+Ci4r5Ey5O41
	 dSvq1DNsfyt2WpFM8sCIFxi9U0QuOGxi8++DnFeFIec6yfUxjbcW9S74CUoSnRbu9H
	 HwdbPmPeWKQVfJ1cQDM8Fvmbm1gHsSXsLuAl7mtT0bGtp+ZgGY9RvypFpmYxGFvJ7A
	 4qiaFAKI22NFw==
From: Chuck Lever <cel@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: discard nfserr_dropit
Date: Thu, 21 Aug 2025 11:07:11 -0400
Message-ID: <175578881101.8566.16071574463260041610.b4-ty@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <175573864133.2234665.4220094746965657176@noble.neil.brown.name>
References: <175573864133.2234665.4220094746965657176@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Thu, 21 Aug 2025 11:10:41 +1000, NeilBrown wrote:
> nfserr_dropit hasn't been used for over a decade, since rq_dropme and
> the RQ_DROPME were introduced.
> 
> Time to get rid of it completely.
> 
> 

Applied to nfsd-testing, thanks!

[1/1] nfsd: discard nfserr_dropit
      commit: cefea648ea22cecc5311f10a322fb6e19c8bb257

--
Chuck Lever


