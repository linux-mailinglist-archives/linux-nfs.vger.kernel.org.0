Return-Path: <linux-nfs+bounces-14455-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78019B586EA
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Sep 2025 23:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7082B7A96EE
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Sep 2025 21:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608A41D618A;
	Mon, 15 Sep 2025 21:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYLHroJg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3136941760;
	Mon, 15 Sep 2025 21:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757972814; cv=none; b=RO9M7ipQq43XNxET3YodtLXPLZ0fPXT4ugH8AaUT96HmFn6SFBpR11qprTVy0x/d1hmnINFQ2kl2msvrBYx+vBK4e/EB9cOTJGCtL+EneKPmoSVBZG7UiZELJJq6i9Jfxcv3AfwqKISzGGN/QdoaBRSb+MrRBgVor8wvlb9WV7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757972814; c=relaxed/simple;
	bh=D9jfoYbyApINAB7D0xsIHvhQDmuv3Id/XROTByhTTos=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M0d3aEQiTsEcGUWMxrX1snVGXbUWxVSzAm+DxiEIw4Qc/eS49OhsC6C229FizuNmxA7u0F4Z05uvvOikWR+fLRF6Hh4c2MewoDa5kdHdZgrHDJLRvYUFqZrE+wi2hLGiomAmG6qLdYn4X8ZiWHWsZGxlihQ48qETA8x6NGHjRdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYLHroJg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD04C4CEF1;
	Mon, 15 Sep 2025 21:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757972813;
	bh=D9jfoYbyApINAB7D0xsIHvhQDmuv3Id/XROTByhTTos=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZYLHroJgZiBKoAKKM2DNo0gpnT7Cb4/o0sE3e/ou2L5J6r+k408b3ij0UlBrGW03H
	 yQhKpBXc7pO8kBJ8HnEv31n0y7FKDWZMkvLi89IZhh1fAq/4LxyAO0sCpskKKvWcsq
	 /UmuxU4VFUliUMrCCfNZ2Op3E9iDknviVZ0kpAoHATaumVU6Ra3BkJG6UvxDlUxBrN
	 Xz2AjaosFPxtm5SLbVn9xStDl81ceXMaQjVZO4Td7uwTwK3mKJmA87r8ciRHQpeEeK
	 paFXxuNg3FTjDpQN48+wIVfPmZLX7kZGc3J58OfszpO8Id7jVz3my8+Dmmgfl2HGT8
	 FBnOMKzKVJGdQ==
Date: Mon, 15 Sep 2025 14:46:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Olga Kornievskaia <aglo@umich.edu>, Olga Kornievskaia
 <okorniev@redhat.com>, chuck.lever@oracle.com, jlayton@kernel.org,
 trondmy@hammerspace.com, anna.schumaker@oracle.com, hch@lst.de,
 sagi@grimberg.me, kch@nvidia.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-nfs@vger.kernel.org,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 kernel-tls-handshake@lists.linux.dev, neil@brown.name, Dai.Ngo@oracle.com,
 tom@talpey.com, hare@suse.de, horms@kernel.org
Subject: Re: [PATCH v2 3/4] nvmet-tcp: fix handling of tls alerts
Message-ID: <20250915144651.7bec7ad4@kernel.org>
In-Reply-To: <aMg0jDkXOd8E7Ihj@kbusch-mbp>
References: <20250731180058.4669-1-okorniev@redhat.com>
	<20250731180058.4669-4-okorniev@redhat.com>
	<CAN-5tyF=5oQLyy7ikbbhFW10OrUfHh0Sr3D=G1nHN+pEsfiSzw@mail.gmail.com>
	<aMg0jDkXOd8E7Ihj@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Sep 2025 09:45:16 -0600 Keith Busch wrote:
> On Fri, Sep 05, 2025 at 12:10:21PM -0400, Olga Kornievskaia wrote:
> > Dear NvME maintainers,
> > 
> > Are there objections to this patch? What's the path forward to
> > including it in the nvme code.  
> 
> Sorry for the delay here. This series is mostly outside the nvme driver,
> so we need at least need an Ack from the networking folks if we're going
> to take this through the nvme tree.

In case you decide to take it, LGTM:

Acked-by: Jakub Kicinski <kuba@kernel.org>

Thanks!

