Return-Path: <linux-nfs+bounces-13869-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB11B3195F
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Aug 2025 15:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA652A2455E
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Aug 2025 13:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B7F2FF14E;
	Fri, 22 Aug 2025 13:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dzav66wS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48E22FE592;
	Fri, 22 Aug 2025 13:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755868786; cv=none; b=GHD+maRqsA+Qpq7sw0EQf6tjy+hJW5paXDeG/WsSZY5YXTDKiMBEymDUe0OQgYXwz1x8rcgivPSnPRIe07KzyRiY7JtNxO76f0HxeS7ujGBJD06EFCJlz3ycnzALl2DcNPhDqCFtcOXPphb+joG47f0bz/Uou3O1EoLf4z1X8gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755868786; c=relaxed/simple;
	bh=MyNgdMxnyEB/P7oXWoztxQMr+47U1RLFpT8c8a5OKoc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SSombk1bNWZ2DDrRJG9HIbDjXXzO7U3lwCrx2GNWDPLA6R0ERezATFY5n7aj224rOLO9MN0TFiRuas88Zh0MEXwehxgdoX+ZmKMp5goojNYJJeWdGISt01thA/Xq9i2mX8E9piC24jXRfG8qNZZR0ahbTNW1he9DduvQ+j2EHsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dzav66wS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B787C4CEED;
	Fri, 22 Aug 2025 13:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755868786;
	bh=MyNgdMxnyEB/P7oXWoztxQMr+47U1RLFpT8c8a5OKoc=;
	h=From:Subject:Date:To:Cc:From;
	b=Dzav66wSYqOQh8PgImtIxM6Cwlr5krkZrJf+Uu5VPHyuhSq5Mw+zkORV28y1TFVnZ
	 m+aPS5PjU1NFfMmbJDXcrIDDnu2cGNRbwfQubvtO81xavtkDRYx4NZrUVxBCx/NnfN
	 ncZiOYpie5SitqOF6Eh/RvYnXXJIl/SHRaYvLld7FaYlm+uXgh1i1+4qtkIhSHweyW
	 0YxTHB9TgUvzR6/Nubmqbzv/p/V7Ov7BY3yGpHJu1r2huyyjDxejrd49WLaZ901BkS
	 5+vQNHMUcfmaD8nzHCkcNcwNzsc6FQQdKXSxk2Xnl9qXeu3kGv13mZXa2W4mR0mqAB
	 8TvIttVQXfprg==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 0/2] sunrpc: allow dprintk() to go to the trace buffer
 instead of console
Date: Fri, 22 Aug 2025 09:19:21 -0400
Message-Id: <20250822-nfs-testing-v2-0-5f6034b16e46@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFluqGgC/23MQQ6CMBCF4auQWVszHQWtK+9hWKAdYKIppNM0G
 sLdraxd/i953wLKUVjhUi0QOYvKFErQroLH2IWBjfjSQEg1nsma0KtJrEnCYOhOFk/oavJHKI8
 5ci/vTbu1pUfRNMXPhmf7W/872Ro0PTbonGsO7Lvrk2Pg136KA7Trun4BfKlknKcAAAA=
X-Change-ID: 20250821-nfs-testing-2b21070952d4
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1243; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=MyNgdMxnyEB/P7oXWoztxQMr+47U1RLFpT8c8a5OKoc=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoqG5nlo54B+e38yagzXYM8iUYdmSkDPT+QaAEj
 K8b3fpOdQuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaKhuZwAKCRAADmhBGVaC
 FfWLEACyR9DwlivE1t0R3+hiKGnmcX8Dj+dyFumcDeLRq0r6F/qFqNOPJl1U+cxvCXdt91r2tO/
 kI6bHTnCJwFdzwhj4oySHNoYqmeDFC4ZyxrO+pKreWR2Uw9BdudISWMywMcNntIQLko48dyelUR
 CWni6JnHsVgqEnfkhfvAdmZ2Kv2pXeKuBsI0n7YhOHVs4emAlBRieNql30ELQpzQZZFr/Gg952d
 wonnYN8rNJuyp/0FYM3brch0ucTao9P4jHTbjvJAyMhO2uDkQUnimH8JE/DxyeRkVePy3u6NiWL
 sjTM1gnfbfBit5XiIOyiayUqMJGbgNkR39o7bk8q4NO74cd1dU4GEInMk6F4+0H/ZGBzsHD6xQa
 MCPjjPq3cImkmL2WDtpvveSQ22ywLA5ZUpZ0KAYcIkrLMepXjU3EhkPq7CbfyHi+ZPn7qHyqPqt
 /s4jB/qBcDpRXqUmSGmK0vCa9YhAukKM0iWZ9SFkCC42r14upoDLAKSuy7XPgqAti/6UJ7kDHqc
 T8suQQgq3//JmGPxXxTDmi8BmNa1bdFmXBIXRUDCNTDMzPz8IA0zwcqyPLloXBcgmi9CjzSvGiF
 CpMD4CtMfl91IhtTQtPzoScJQUY1NUZ+K9GJb9mGeBwR3U/VweSGw7zmTSPPjVCjE6EWSjiGvd0
 wwCaQwo2/3whrbg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

While we have added a lot of static tracepoints in the last few years,
we still have a load of dprintks in place at all levels of the
NFS/NLM/RPC stack. At the same time, they're pretty useless under any
significant load due to the console overhead.

This adds a new Kconfig switch to allow those to go to the trace buffer
instead. In addition to being more efficient, that allows us to enable
static tracepoints alongside dprintk() and get a unified log.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- pr_default() doesn't exist. Use printk(KERN_DEFAULT ...) instead.
- Link to v1: https://lore.kernel.org/r/20250821-nfs-testing-v1-0-f06099963eda@kernel.org

---
Jeff Layton (2):
      sunrpc: remove dfprintk_cont() and dfprintk_rcu_cont()
      sunrpc: add a Kconfig option to redirect dfprintk() output to trace buffer

 fs/nfs/write.c               |  6 +++---
 include/linux/sunrpc/debug.h | 30 ++++++++----------------------
 net/sunrpc/Kconfig           | 14 ++++++++++++++
 3 files changed, 25 insertions(+), 25 deletions(-)
---
base-commit: 80a1bea0cd81de70c56b37a8292c23d57419776f
change-id: 20250821-nfs-testing-2b21070952d4

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


