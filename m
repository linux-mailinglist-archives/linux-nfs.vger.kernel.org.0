Return-Path: <linux-nfs+bounces-11167-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 231F8A9382F
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Apr 2025 16:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C8984664C1
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Apr 2025 14:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4857E2940F;
	Fri, 18 Apr 2025 14:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQ8yd3Bz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B20127470;
	Fri, 18 Apr 2025 14:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744984819; cv=none; b=RjzELhYkQ1XEUQafhb/gRpNAtsUVqfyFZTngaSh0ZMJPXeeADeqwJBh9vi0ynpMPa/ZxcoLISUWGfCyqOgb0gbvQbO2vTF6OCXSDMcdP9PFdG3bOHEfxKQlPwKEGVJLMWbb51R3KGlHxGU2n9TuKbPROjh0UwBkAYT1NN+BQ0VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744984819; c=relaxed/simple;
	bh=mU6IHI3+QHPzVGRjkpFASNAQK92ao1ary1xz2qj3Q7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H4LD8Dhh5TnBqXulkkN+gGujgTMgkah2xvLaDpyn4xzlUgi9v/LphPQtac9eKeVBR5zRYb0m6bNH+ReMq5urpWVxotg0QJ3N6voPcul4jsLu3DUXuVO/rsxl2VNY459oUrlPXveHaPuGsIPOxcmu8VYOyXgT/ZCD9AsBixBVN88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQ8yd3Bz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077F8C4CEE2;
	Fri, 18 Apr 2025 14:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744984818;
	bh=mU6IHI3+QHPzVGRjkpFASNAQK92ao1ary1xz2qj3Q7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gQ8yd3BzbaXZ+6b52VgwwK3xmWiAZ0bdj/TRPjg15bZal4YhlOPgF/01U1OzZFtmR
	 9/Bxp8Bgx38kySYa4y8mkGXKiYFOTByBgT8AS2jVZvBuoUYC4OC86yYIR8T4Rw/FT6
	 FlcLF4ol2yBuFl5eqIN1WOJDUB6uqCBLpn732HiRbk95U360M2lVDC7MRi99GR4ExJ
	 VMhS/IyXQoWMTU0HVhW3SGDTqDnv4ESVpxhQIR+8Tm6GJ19oeWMJsMorVxCF4n2uP+
	 urSRL3Tts/4MlRtDIbkIZbms1A8NsZXqdKR6IA9crjXJvM0e7mMTqkGsqXMBRFBLz2
	 dkq7KxLMxTkrQ==
From: cel@kernel.org
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: Re: [PATCH] sunrpc: allow SOMAXCONN backlogged TCP connections
Date: Fri, 18 Apr 2025 10:00:13 -0400
Message-ID: <174498478558.3618.5006356093533762788.b4-ty@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417-svc-somaxconn-v1-1-ff5955cc9f45@kernel.org>
References: <20250417-svc-somaxconn-v1-1-ff5955cc9f45@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Thu, 17 Apr 2025 14:54:36 -0400, Jeff Layton wrote:
> The connection backlog passed to listen() denotes the number of
> connections that are fully established, but that have not yet been
> accept()ed. If the amount goes above that level, new connection requests
> will be dropped on the floor until the value goes down. If all the knfsd
> threads are bogged down in (e.g.) disk I/O, new connection attempts can
> stall because of this.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] sunrpc: allow SOMAXCONN backlogged TCP connections
      commit: 1fe4a78475a5203a9ee1d9ede1bc2043cb505382

--
Chuck Lever


