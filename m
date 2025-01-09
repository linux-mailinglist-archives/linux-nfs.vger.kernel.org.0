Return-Path: <linux-nfs+bounces-9016-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E9BA078AF
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2025 15:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F57A188B3DD
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2025 14:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4721C219A93;
	Thu,  9 Jan 2025 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KF9vu/Tj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD9E21764D;
	Thu,  9 Jan 2025 14:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736431812; cv=none; b=SEUtx0TtsmVk1X8UuCMXQqjtjFiv2+QbD4ymh50NNCMUmiUmvgVE34mna/PS7BNQheDiEDuNgZeRBXkn4yf/u+PFlz72x5P3aB0s0GkFiSowQKf/yrAaOed8VJKdH3SYIInb77pNCMeqeaI4dMN24QNmHg5yVzCVlG2tMidl+/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736431812; c=relaxed/simple;
	bh=wfH6VvZX6J6Cw/yMPl7F1JdtOldjRp6CfpZO5Faq3Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BQd3CimrPciKFdVZbrzDePQQIfSEmldJEQbixYyMT1befSAa3p0hlJUQNSOT1Y83KRG6JweyD7AZtCLGmerNYWQiKWKUGR4V/rRI0SRfTyDsBNeZX9StL7k/zLkkpZ87MyFK4JjXo6yuuULKmVhv6GaMHmWrK/lmIhb/ZUe4cIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KF9vu/Tj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0935DC4CED3;
	Thu,  9 Jan 2025 14:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736431811;
	bh=wfH6VvZX6J6Cw/yMPl7F1JdtOldjRp6CfpZO5Faq3Vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KF9vu/Tj7Zf6BSq2Bka0T/01GmWUsd7XAAsDBvZrsGZZkJLPydFmwo6IsynaGPOGb
	 HHjM1pliUCDxY33SYbuVIti7VZorL3phVyl02cvqtFfi3XUXTcGe3bPopmK2ZWp2MB
	 Sut+/7GW4Qk1aBv1RPDcc8GmtW8s7heR+Hp+1ITnUxTpi4skwBb8apX2aQR0nmNHHI
	 gP/sqdAOnrQ70+m9bcVeIrgD9FEUx+aWzmsm/bYIsmrg/JAK21pbSGmmvvxAgMFp0s
	 HX8MhGTG8noXGxbZwBsIICr+hwrDifzrLF7rsoRO3WMhkCvQUivNCO6vAZdRGwMZgW
	 8PVDl7t5wE2/w==
From: cel@kernel.org
To: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Scott Mayhew <smayhew@redhat.com>,
	Yongcheng Yang <yoyang@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] lockd: add netlink control interface
Date: Thu,  9 Jan 2025 09:10:06 -0500
Message-ID: <173643164044.18486.14928337621532013382.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250108-lockd-nl-v1-1-b39f89ae0f20@kernel.org>
References: <20250108-lockd-nl-v1-1-b39f89ae0f20@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Wed, 08 Jan 2025 16:00:15 -0500, Jeff Layton wrote:
> The legacy rpc.nfsd tool will set the nlm_grace_period if the NFSv4
> grace period is set. nfsdctl is missing this functionality, so add a new
> netlink control interface for lockd that it can use. For now, it only
> allows setting the grace period, and the tcp and udp listener ports.
> 
> lockd currently uses module parameters and sysctls for configuration, so
> all of its settings are global. With this change, lockd now tracks these
> values on a per-net-ns basis. It will only fall back to using the global
> values if any of them are 0.
> 
> [...]

Applied to nfsd-testing, thanks!

This seems utterly reasonable to me. I'm thinking that it's a bit
late for v6.14, so for the moment it is parked in the testing
branch.

[1/1] lockd: add netlink control interface
      commit: c7ec1d59e4adf1660eec9e5ec0ee83f4a32c0a49

--
Chuck Lever


