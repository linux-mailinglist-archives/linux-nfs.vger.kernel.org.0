Return-Path: <linux-nfs+bounces-11955-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC2CAC70BF
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 20:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DC0D3AF2A0
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 18:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9379B28E57F;
	Wed, 28 May 2025 18:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXcBIlIV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638F428E573;
	Wed, 28 May 2025 18:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748455921; cv=none; b=uzOJMIi28Tcxh42uMx7f+QaCreZwlpg8SpBhmTdrjtDKVYe6Wqx+uhaC21ROoNYusAEobYsS7DQtD1Ng+L1sMZYfFPePtnzm9vPb3/wN8EF2Q2dxAf4H4fcmBxVal3LMs3obHMgurz89U2QWdnNSckHfHAO3uiBjt01YSZve84g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748455921; c=relaxed/simple;
	bh=hxcBVVt/dT1aFY9T1MdNfnDvaZdZ7UKvOnkx2IJSPOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FfhiTiOUpKLELc62sF3++/n6JNPg+F/FJ+Hsb1ehqIXn/ERnQIIO7NTaOgrpgZ4gFIZ91ZTmWOfzylAZi6aOhtbLBWm8qcB5jakl5QySbztfFkuroghIQOkogm+7CxvPoyFQnD9yF3fkpVKFH3KG/O5gukljnmAuUkeJmeAmYUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXcBIlIV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CBBFC4CEE3;
	Wed, 28 May 2025 18:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748455920;
	bh=hxcBVVt/dT1aFY9T1MdNfnDvaZdZ7UKvOnkx2IJSPOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NXcBIlIVynu5FMeJskRun3YbPT+MHYULMWaV0dfeh+ZnjVg3/BNj2FCXzE0ExnMGo
	 Wnc+HS0ahq7E4WYejyv5Dn/KCZ6pNy1jnixQC/ZTNkWOZbSMh9XV1e+O729KnxgToc
	 1UWxDPOlJfXDJnCnQtheM7nhg2S2R22JkIjVHWFbng3ZSejgTb6ypl82FTen3wDz/c
	 FjyZYiyr4Bg6PTGlWlxWqbAa5eeLz7D2a9xaPswVPX7J885XROg8jpS9LjC9u3Ju2Z
	 F9cud6uESqcFVJFbnmcEUgPNMSV/mg4TR9ZX6VG1+F23MCzHIpbMMojhsKKTOFQqXe
	 qPqL1zQzdB8qw==
From: cel@kernel.org
To: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Mike Snitzer <snitzer@kernel.org>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 0/2] nfsd: use threads array as-is in netlink thread set interface
Date: Wed, 28 May 2025 14:11:53 -0400
Message-ID: <174845587080.200069.9203268802136145057.b4-ty@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527-rpc-numa-v1-0-fa1d98e9a900@kernel.org>
References: <20250527-rpc-numa-v1-0-fa1d98e9a900@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Tue, 27 May 2025 20:12:46 -0400, Jeff Layton wrote:
> The first patch is probably appropriate for stable. It should fix
> problems when someone sets the pool_mode to pernode, without userland
> sending down a fully-populated thread array.
> 
> The second patch just adds a couple of new tracepoints that I ended up
> using to track this down.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/2] nfsd: use threads array as-is in netlink interface
      commit: b2a9a114a3c7f5abfa2875b70ce9b73525a74291
[2/2] sunrpc: new tracepoints around svc thread wakeups
      commit: 65b8babe551bddf00aac69bc905f88a4e0371766

--
Chuck Lever


