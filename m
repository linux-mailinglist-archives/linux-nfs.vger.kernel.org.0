Return-Path: <linux-nfs+bounces-13910-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB35B384DD
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Aug 2025 16:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 946DD6826B0
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Aug 2025 14:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DDD3570D4;
	Wed, 27 Aug 2025 14:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3P21mG2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C4D2EBB96;
	Wed, 27 Aug 2025 14:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756304644; cv=none; b=lReze1sduOrz5TD1DrUvV4yBB8iTkk9Q02qyH/GzP3hUbPn6kjCqrL7f6/aZAyOGcNPK72s58jEYK35+8yJvR93fpfSQ+AoNIQDeZB2owQhmwdf30WD9oVVZyN26Wot42vsIS5l+TtVzNQKYbqj5boZCu5T1LHr5hUVeMLwm4jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756304644; c=relaxed/simple;
	bh=F0CpgK+cDS4e0Mz55tpKBNTpyOF9OG2tCtZUaL08FMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=db2j118C0duBJwCjIIo5bZsopL6JfDYW7FbMEKyov34q8MvfwgViIAE3+kg3XGt6u5HV37CyPFOAUWY73iIuwIVY2GSabCJUf4PL3PM8m5p7rz8KhIUyvGVdt48QYaDVjLpGESwIxCOs5WVz7dIo0/2QHe2LgusBGIqeskZezAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3P21mG2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966B7C4CEEB;
	Wed, 27 Aug 2025 14:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756304643;
	bh=F0CpgK+cDS4e0Mz55tpKBNTpyOF9OG2tCtZUaL08FMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J3P21mG2Xxm2z79J8NkEgt/zFZlV5WT5iRNw7TliAqunzkjG9BL+ilg806Zu2RUqo
	 Cx/JHOqHtsh9DNqkmMTWo/Cf3iqzwYcuhdpbi39LKkVNUY6hQkPry8hJZZWbhDQyGL
	 MsHapuPLf8PcjnM/PuwfpBRQoTsu9dVGDUl6MjE2LgVxEUmYPLGirVR0nnXp8mo9QX
	 8NSEBHrdivINB4b1t7QGoSoUXiDTCgbcJ4jPI7F7jrs+P+uBooMvkQCdovM6e3IsZn
	 nbQ3S7utwCRZGhJL1vHUKIbEC7KR+vOI8m/tXjsVVLy0m1nz7sDN73sjdtaA7H1ElA
	 nP2iyp3UMt22w==
Date: Wed, 27 Aug 2025 15:23:58 +0100
From: Simon Horman <horms@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 1/2] sunrpc: remove dfprintk_cont() and
 dfprintk_rcu_cont()
Message-ID: <20250827142358.GE5652@horms.kernel.org>
References: <20250822-nfs-testing-v2-0-5f6034b16e46@kernel.org>
 <20250822-nfs-testing-v2-1-5f6034b16e46@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822-nfs-testing-v2-1-5f6034b16e46@kernel.org>

On Fri, Aug 22, 2025 at 09:19:22AM -0400, Jeff Layton wrote:
> KERN_CONT hails from a simpler time, when SMP wasn't the norm. These
> days, it doesn't quite work right since another printk() can always race
> in between the first one and the one being "continued".
> 
> Nothing calls dprintk_rcu_cont(), so just remove it. The only caller of
> dprintk_cont() is in nfs_commit_release_pages(). Just use a normal
> dprintk() there instead, since this is not SMP-safe anyway.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


