Return-Path: <linux-nfs+bounces-3797-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5E2907FF6
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 01:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 021191C21683
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 23:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CAF14B95B;
	Thu, 13 Jun 2024 23:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwPAzlx9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D4C139D04;
	Thu, 13 Jun 2024 23:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718322986; cv=none; b=DzKeibNutbuc2o8PQCuniVBNrInxL639dTtFGhtYPVrgUMNcmWMlEowgBreQU0w9y1XUTqzTBqxB8ga7SQU/5RZsMRruruL6bjdBRWHSkdq8qBYylMhORTvdqZ4PCjqO1K+iu34z+oH5sfoY236GRIuovltkALR4Uhsp8w5FO5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718322986; c=relaxed/simple;
	bh=wQDFflUnmobvjhJcXXTOXEm6xj6JxzdgpjMPzhngbpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SyQztAEze3amahDSpdpO974wGwp0mubnPCHQb7xrsMlC2Bsnp7P5eYSw9abIXlmC69EzlAmpMHpOEhdQLyrDLvAaIzhltRELfsus0MzOEwAM8wpeOu7flU2si6jErNitFwftbQ0S76sRWhJ8T2LTAI0yCenbv55jeqy7npiq5K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwPAzlx9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FDFC4AF1C;
	Thu, 13 Jun 2024 23:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718322985;
	bh=wQDFflUnmobvjhJcXXTOXEm6xj6JxzdgpjMPzhngbpQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XwPAzlx9WTPjngjTcEgyxNeaI/IFID8fkdNiyTjLQfyQ5bGvMPJ/RC2R0FIEGVqob
	 MwE9pXb/vaipH3c7T6ECtM7fn7Lpi6qyILAwNq2bIvlydhi+SUyWZSEnspiNbIbkRZ
	 /00Xc4WYFPwNpgs5tqeVuvMXt2I3nv0UHIzAy479cEjUV0zJLpQllLIQ8Jbr+bZ7nG
	 QA+k1qMoHVLMFSe4CFA6yeku0dkPbG7Tm6cClfTPcfj0ZDJnV5V7I/VbLF9ZaCHx50
	 zlc156wBM+oX3wO3LH0BGj/JqX/zgSxbSJW5qyPcY3bV83nAA84C4o/H+NyXaFB52h
	 u24vE3OGn8qbg==
Date: Thu, 13 Jun 2024 16:56:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, Olga
 Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 5/5] nfsd: new netlink ops to get/set server
 pool_mode
Message-ID: <20240613165623.2a5150e8@kernel.org>
In-Reply-To: <20240613-nfsd-next-v3-5-3b51c3c2fc59@kernel.org>
References: <20240613-nfsd-next-v3-0-3b51c3c2fc59@kernel.org>
	<20240613-nfsd-next-v3-5-3b51c3c2fc59@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 14:34:34 -0400 Jeff Layton wrote:
> +	err = nla_put_string(skb, NFSD_A_POOL_MODE_MODE, buf) ||
> +	      nla_put_u32(skb, NFSD_A_POOL_MODE_NPOOLS, nfsd_nrpools(net));

bitwise or?

Other option would be to move sunrpc_get_pool_mode() before allocation
that way all error codes past allocations are EMSGSIZE and life is
simpler.

