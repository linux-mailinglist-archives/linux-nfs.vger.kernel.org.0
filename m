Return-Path: <linux-nfs+bounces-12575-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A52AE06D0
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Jun 2025 15:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 786337A1524
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Jun 2025 13:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E50124293C;
	Thu, 19 Jun 2025 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUEj4mNG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691BD188CB1;
	Thu, 19 Jun 2025 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750339101; cv=none; b=kUjmeMgqQcFHPIH9VTokV/l8fBYy1SMSWjECPHuFbIIsWYobV+coX+uL0n18L6b0apYBu7vcL2oWgaVWsA8EoN3Kv1z2UKB2iib1ra0EF8jSJ2yJ4XkfCR+fkUqW6aJDJE3+MzEJck/siqbnakbOxsTk3WgRdxieikAkj9svflk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750339101; c=relaxed/simple;
	bh=4dfwl6njUlqczLbqzvkUfC3MkKzL/GcP/GJ8WCrZNlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hmO2yiReVF9KkRhna0oHJxosgGHqnqpUIg5Tm/JZcgp39Gu+20osbbpWfquEK6GO8/IfaJ2cbsHDXZbefqk6Dlcu9MsEFpzEbSbgWhzk2VSGoC6J7oPVwfXw2JaS/60Omn65OoyIJMNuBIdfFSRHq6QKvwdGJ1yxZqTPs6A21L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUEj4mNG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A4B5C4CEEA;
	Thu, 19 Jun 2025 13:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750339100;
	bh=4dfwl6njUlqczLbqzvkUfC3MkKzL/GcP/GJ8WCrZNlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oUEj4mNG8T8YwEU487HkN8q6zdQfCJIRrgr2fAEdLew8PhL/wm80PN6ryTnbeb62e
	 Lkq+mAE5ZtRo5CgmlT8IVwjk72q/dyQnDOH1OELClpw2cy8UPxmL8eyu1peHnoqu6y
	 tmYTsjEK9OZNBCm1G87Dvf/+EwUduxAwfM0HPzj8e6QeYsQYXJpMocCfbgHz+wJvWi
	 +pxgDWmOWYyMHAcvpSsy3ahYwmjtclO/ifpCSFuPVunPvLbXoLCSr/hXSijgHTU5Kw
	 CKEnKxxH5FHscXZLXK6nU9qirMhnDvbzjLroHwmp8v5kMXnGdPpY12XCcZjixP/hRH
	 nxdTs+LTXiIlQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
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
	tianshuo han <hantianshuo233@gmail.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	security@kernel.org,
	yuxuanzhe@outlook.com,
	Jiri Slaby <jirislaby@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] sunrpc: handle SVC_GARBAGE during svc auth processing as auth error
Date: Thu, 19 Jun 2025 09:18:15 -0400
Message-ID: <175033900601.115666.13177707398024542481.b4-ty@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619-rpc-6-16-v1-1-9fd5e01637d3@kernel.org>
References: <20250619-rpc-6-16-v1-1-9fd5e01637d3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Thu, 19 Jun 2025 06:01:55 -0400, Jeff Layton wrote:
> tianshuo han reported a remotely-triggerable crash if the client sends a
> kernel RPC server a specially crafted packet. If decoding the RPC reply
> fails in such a way that SVC_GARBAGE is returned without setting the
> rq_accept_statp pointer, then that pointer can be dereferenced and a
> value stored there.
> 
> If it's the first time the thread has processed an RPC, then that
> pointer will be set to NULL and the kernel will crash. In other cases,
> it could create a memory scribble.
> 
> [...]

Yesterday's version passed overnight CI testing.

Applied to nfsd-fixes, thanks!

[1/1] sunrpc: handle SVC_GARBAGE during svc auth processing as auth error
      commit: 92c2969bcd57272698d5aae037f55481dcb11f2d

--
Chuck Lever


