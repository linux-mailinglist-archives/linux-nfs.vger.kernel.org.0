Return-Path: <linux-nfs+bounces-11853-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EABBFABFDF3
	for <lists+linux-nfs@lfdr.de>; Wed, 21 May 2025 22:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44B073BFB22
	for <lists+linux-nfs@lfdr.de>; Wed, 21 May 2025 20:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178D729C355;
	Wed, 21 May 2025 20:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPjVxjUV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2D829B23A;
	Wed, 21 May 2025 20:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747859658; cv=none; b=O73JVd4NI5Z3/qY438G2Bn5VkE4ztkBZ08/DeWeQgfH+SFeG986qR6ft2825Ojkh6orOpxYUaQOqgA0RUkDEyAx5Bj9bSEKU1rQuwzK1Sf/xWLtucU5OhtTvQ6WMOOQuToohRUbBFRuR28wAJmem+bOAfGz6Y9MlmkOG/kujTD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747859658; c=relaxed/simple;
	bh=sCP4ForbnTSGdk09W7n4ANFcE6o8g5/4PYaLiu3wfws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vDyXFzXvl0uJTaeqMTHAvaA5y9WiH9ZCAd79/f3DjMG8pP87yOcJUZSq5eYUuD5ai/KZfH3Df/DsAnczmm9kKYMp07M/g6eaK4Un7dxUplHn68R5uiPPJ/vkXUpRUQPeyC7VEtQHIPYKlVH4E9UfBbN3Tgc6KvG3Hwf3wQWaGBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPjVxjUV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE51C4CEE4;
	Wed, 21 May 2025 20:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747859657;
	bh=sCP4ForbnTSGdk09W7n4ANFcE6o8g5/4PYaLiu3wfws=;
	h=From:To:Cc:Subject:Date:From;
	b=oPjVxjUVd7wZCKuB0rGnD4kkiazLWvimgQJ3FTelnUO+wvzWeEZFBvsLkp8ik4R2E
	 cEp3EGBnRDhA155RzWz3XECCE9Pc0pII3sunbGv16AiHtTRA5Lv/gB882TrF6VJmh4
	 TPqV+sEjnw6Wzz1oSVPQpPeO5Qa1vvTh7LvfJGEvuELZ+efYmBH7tBjQKokq2WylFa
	 XBNjgRYA9ovhd3H1q9/Pbq3cyzlkWHt5wuSG7WN6nFZYEXl3yfMgdomt0A4NXlWx7U
	 IY9J8r7fkEdk1odkoS0K4L3H8chixa2yqRXv70fuw/iT1O56KJKnYQT/D03hggOrOz
	 JJK1wqxAuv16g==
From: cel@kernel.org
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: Mike Snitzer <snitzer@kernel.org>,
	Thomas Haynes <loghyr@hammerspace.com>,
	<linux-nfs@vger.kernel.org>,
	<netdev@vger.kernel.org>,
	<kernel-tls-handshake@lists.linux.dev>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 0/2] Avoid hang when mounting xprtsec=[m]tls
Date: Wed, 21 May 2025 16:34:12 -0400
Message-ID: <20250521203414.889931-1-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

An NFS mount request can sometimes hang when TLS is requested.
This series attempts to address that.

I've checked on a couple of things since v1.

 - Why doesn't the Linux kernel SunRPC client already poll just
   after connecting? Typically the SunRPC client does not expect
   an RPC Reply (ie, any ingress traffic) until it has sent an RPC
   Call first. RPC-with-TLS has changed that scenario a bit.

 - Is this an issue for other in-kernel TLS consumers? It is. But
   the only other in-kernel TLS consumer at the moment is NVMe over
   TCP, and it already polls after a successful connection, for
   other reasons.

Changes since v1:
- Include Mike's R-b and T-b tags in 1/2
- Clean up dead code noticed while testing

Chuck Lever (2):
  SUNRPC: Prevent hang on NFS mount with xprtsec=[m]tls
  SUNRPC: Remove dead code from xs_tcp_tls_setup_socket()

 net/sunrpc/xprtsock.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

-- 
2.49.0


