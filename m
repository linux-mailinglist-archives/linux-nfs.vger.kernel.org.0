Return-Path: <linux-nfs+bounces-14449-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96895B58138
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Sep 2025 17:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B245418882D8
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Sep 2025 15:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD5622A808;
	Mon, 15 Sep 2025 15:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuKP2GDe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D712288EE;
	Mon, 15 Sep 2025 15:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757951119; cv=none; b=Qj7ETY21d5f27k8ahD3LFi1S7CwLQUNMnbPvaPqhMYN5xcC7hi9PdKvJhwIRCqNi+ntSbOywbW+/DrjTAtZMwKNhZ1z7QGGBJ2hsIs0X4vzYFoJQp9Aq3yMrEXlHXILtMobZW4XmECD7vFX+6BQv1sD5qz8DV9/EtHDBbO+D188=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757951119; c=relaxed/simple;
	bh=BMMvAIX8lIec0W3uLHniFYKWitkFVyM8NgNBQoOTamI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUVUlHiGDir7XHzo8RrydwH6tzWyn09k1InDFvI2Dxm4aAM81gRAQulh/Kbk7cdu1tJZbv1fB/5EvfUMR23pOARYpNFrJXGrXzkzfP5N9JDwN6ljOIfmyL/SMBmW2ZOmApZeRQukJoeE1cA8yDnU3DtOqSNgJIPZ+HA/9A8Mtn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuKP2GDe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D83C4CEF1;
	Mon, 15 Sep 2025 15:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757951119;
	bh=BMMvAIX8lIec0W3uLHniFYKWitkFVyM8NgNBQoOTamI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RuKP2GDeTAJFF9RHJInYDhTSDClkGNHxoPZHaj9zZVLcJhY8+d/Sv834gCQl4sa4x
	 4LrfugMlueEbgXC570jY+hJLF3obWH5m5hyWrlLPFuqxx520R7hX2N+tA0KlZnYKwR
	 YEJVspy3FJ6879O820NUiJuInNsBu6gk29GeD2ih6KyeJ7Q0Dpaa9ymnpQqf70C+Z1
	 nOtP6AlT795L8ny1ujN0UgvNb+NWyeNGh5AYQ/wMuIzA+YykzOx1AZDpiFTlF8xEkz
	 JhM6ENN4hyuq3fy3myPkaDhMJbRHTTxDMAy2mHHNr4EYJU/wBcXyv6SBcFK5nX1a9b
	 m3HBL+b+E4BLg==
Date: Mon, 15 Sep 2025 09:45:16 -0600
From: Keith Busch <kbusch@kernel.org>
To: Olga Kornievskaia <aglo@umich.edu>
Cc: Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com,
	jlayton@kernel.org, trondmy@hammerspace.com,
	anna.schumaker@oracle.com, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-nfs@vger.kernel.org,
	linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev, neil@brown.name,
	Dai.Ngo@oracle.com, tom@talpey.com, hare@suse.de, horms@kernel.org
Subject: Re: [PATCH v2 3/4] nvmet-tcp: fix handling of tls alerts
Message-ID: <aMg0jDkXOd8E7Ihj@kbusch-mbp>
References: <20250731180058.4669-1-okorniev@redhat.com>
 <20250731180058.4669-4-okorniev@redhat.com>
 <CAN-5tyF=5oQLyy7ikbbhFW10OrUfHh0Sr3D=G1nHN+pEsfiSzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyF=5oQLyy7ikbbhFW10OrUfHh0Sr3D=G1nHN+pEsfiSzw@mail.gmail.com>

On Fri, Sep 05, 2025 at 12:10:21PM -0400, Olga Kornievskaia wrote:
> Dear NvME maintainers,
> 
> Are there objections to this patch? What's the path forward to
> including it in the nvme code.

Sorry for the delay here. This series is mostly outside the nvme driver,
so we need at least need an Ack from the networking folks if we're going
to take this through the nvme tree.

