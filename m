Return-Path: <linux-nfs+bounces-11117-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B1EA86112
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Apr 2025 16:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 907C64C55EF
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Apr 2025 14:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F661F7575;
	Fri, 11 Apr 2025 14:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bpoq+oUz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F031607B4;
	Fri, 11 Apr 2025 14:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744383200; cv=none; b=jdvL0ovH3zPpc6ky7gZQMJQShktE4mTYC7Fs4OvbENMB/ERzfN82e8YvwordPwR3RC/gpwyAwBpziQK2wFZUA0Hl9vpql/yr5SmC/s8KT9BqTs2+25HshV+PITOeMzAufsJFPepMCGp7BzKaIok51MLsoKUdsuFIFm7AF2NWC7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744383200; c=relaxed/simple;
	bh=9vUOR9Y4OjDDb9ss3wEoenqKWPL/Oge7/h/YmGefah4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UI7j5MfnyskJ1uPfEQyLAw82zwae72koEthjXzrDjjrjk0yuFl022K+nvU/66aT2YbHnJ/NYQM8XX6jk4Z39nL5J6qnfty0kMeUdUCBCORGNSmidakiJDsf7d0wXrhv22Woy2FeD1wD5isF3/+D1PHRd3t76OCbX4qL346vPuII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bpoq+oUz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 273F5C4CEE7;
	Fri, 11 Apr 2025 14:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744383200;
	bh=9vUOR9Y4OjDDb9ss3wEoenqKWPL/Oge7/h/YmGefah4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bpoq+oUzt8CMvVvrAAQBpUrH2Aplp+l0sdszcroEIHW9/ZWZTpu58xcg0Q5zGKVQ3
	 SllaE3QH3LFu2xwaZpMDZ7iYq8lBdMfUJuikYloPSJisJj+P1hzQtwicALajLYJueP
	 tYNOttBP7zwp/QvoHsL2pzN2Lj4LDxLXfLIY4MGxp8VElRi9KFmJfJ/mJTfRcfk049
	 zPCyNJeiSlrr7FiOYzXYCO3JgyK7JGjY2KU9Z1fejYqt67n9Uxb+fWgaXck4kL1Xpe
	 qCvBaZdrxThymOjQBhn/VYVIQXlGhS6uiDcnABrUdlNAyqKVJvCD4o13jLxGZcZbgl
	 NPVz16arQxIkg==
From: cel@kernel.org
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sunrpc: add info about xprt queue times to svc_xprt_dequeue tracepoint
Date: Fri, 11 Apr 2025 10:53:15 -0400
Message-ID: <174438318485.31035.4351288521914711713.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250411-sunrpc-tracepoints-v1-1-ed2eb14ce6ee@kernel.org>
References: <20250411-sunrpc-tracepoints-v1-1-ed2eb14ce6ee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Fri, 11 Apr 2025 10:22:14 -0400, Jeff Layton wrote:
> I've been looking at a problem where we see increased RPC timeouts in
> clients when the nfs_layout_flexfiles dataserver_timeo value is tuned
> very low (6s). This is necessary to ensure quick failover to a different
> mirror if a server goes down, but it causes a lot more major RPC timeouts.
> 
> Ultimately, the problem is server-side however. It's sometimes doesn't
> respond to connection attempts. My theory is that the interrupt handler
> runs when a connection comes in, the xprt ends up being enqueued, but it
> takes a significant amount of time for the nfsd thread to pick it up.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] sunrpc: add info about xprt queue times to svc_xprt_dequeue tracepoint
      commit: b7a6405d13bb2b5cbf89decb111f84408d121dc9

--
Chuck Lever


