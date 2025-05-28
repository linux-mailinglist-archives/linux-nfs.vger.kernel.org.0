Return-Path: <linux-nfs+bounces-11934-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 391BDAC5E0E
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 02:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B95D49E59E7
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 00:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C14C147;
	Wed, 28 May 2025 00:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFvazXEs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCF41862;
	Wed, 28 May 2025 00:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748391177; cv=none; b=fqXqN2v9t5RWzuI1soEgDfKSX0y0Of6VYHrzW+Stmtw+cS0mH475etU8alyL8aewNzN1oAJaxzVNkf8IMluI3Q6RCaehn4BVd883O8A1RYwYJnHYhrM+sBhfKbzV/9pwOYC1AIjQZf4/aqEPOFUjbPr24fEjzh7xgLmTCOdxIZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748391177; c=relaxed/simple;
	bh=aLnwkTjNl2st21XOB21RJcHshrEuyKkjIXdiF3ekx1c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hTdHSr09eZo5EF3TAtePhYcMAp521/9TUxH5R7YQ5CGdVbGuyn7GFGTY9fp1i6e0nTj3tfiHR0tS+9D1Pdc6vxfvM4QFxnihvkcVm0VkXog0VCcoUBq8UXQj+hBU0DTFQ2NxwTwR1Ayhk/hbsydh+JwtxcxaFpKPfrtgEcls/4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFvazXEs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1FBC4CEE9;
	Wed, 28 May 2025 00:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748391176;
	bh=aLnwkTjNl2st21XOB21RJcHshrEuyKkjIXdiF3ekx1c=;
	h=From:Subject:Date:To:Cc:From;
	b=oFvazXEsXPKxDdk8jYnLwYlku8QDJRWE9jrZ9usnDXC3U1+08LDlABNB2lzqeG8YP
	 pOHv9kHzqOg0v40SbPQPe23duraEzg/+hUa8UONCG8MyWEjH6yN2rE3+qmuTJeV32q
	 yzvctpYtCj5HmjoYIMZ5i+jay/rDk1+d4+p9eq6M1dMBng1kjWk2lZbqutyhkloq1g
	 hgbxS6TKCGdV7CwewDNsgHziroqczflrSHEmdf1SoNm+6i25iWXMNfm5L+/SbKx9ht
	 pDT1BMKndp2Y7MAg8Y1+hZxlqrChGx2TYIh/vJhFUhXDKDDVAePpNjVTiLZx64eg64
	 vmNNpZL2jDR/g==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/2] nfsd: use threads array as-is in netlink thread set
 interface
Date: Tue, 27 May 2025 20:12:46 -0400
Message-Id: <20250527-rpc-numa-v1-0-fa1d98e9a900@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP5UNmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDUyNz3aKCZN280txEXTMDg5TEtDTjNGOzVCWg8oKi1LTMCrBR0bG1tQB
 YqzOrWgAAAA==
X-Change-ID: 20250527-rpc-numa-600daff3f36e
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=834; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=aLnwkTjNl2st21XOB21RJcHshrEuyKkjIXdiF3ekx1c=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoNlUGEPUHxMqZYyOZph1A0j/HCDOZDaUE/yu+4
 887FpKaudCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaDZVBgAKCRAADmhBGVaC
 FdBoD/4qbV+lGvpcYvQeANGzRz3Wjk7FTqOZQ4K77XhypkhdgBotED0UfLZQ/YGduJoZrTzfKAn
 uPZ8ztZhoCaumXOEHzHrmdn8NrQ/+mvajdLAN9ABqUNYMGk+Kw2Qx7ID8BRDSrQIkV+sAJYfgOP
 W6DalpVgjTPvA2r1hF9MS2HsD2DFBEp1rgImjgMpd+iE3JgdtG+Ijb5XqSMlBxOKuqk+baF8O2v
 udUTPl5HE2FR/1Q20GSRsFu3ylaZCO0fvnV6PcLkymbrc8F83yHm93szuT0jlDgDYN3+H0Ru41U
 kMjNEP1FQqHbzeX5qEJVrWBdXsZpoQIrfwo5E1jVo5UUqvmf5MEnsd5UJP07itxXj+ppB9I+HUW
 QEWkp9NFBZB0FssmXccDz5/xJuaVBoPbhXFhliyLlATz8RTiImxqOlWExUvoYvZzJ1mES5MD0cM
 i6mZ1q9kNmLVTh0YnnG7HanQ1Etlft1Le96pHtZDUpOAfrtk70QUj8zeqI/Kz32xjChiT32TG+S
 i23IIWfay6lFMj7eOANXQnvWDhhd7kLm41eWvwWXOmMtBbY2mmBj7EsHRZ4NCyYvYG+lg7K71s5
 cK9eTCGnsXawiOVBT9xUDam8T7+w84l20ff/Cy9LNYIQG9Nh5By5H/246k1d6F/QFfyodKd+Mxd
 jjqN4ARqYWF20sw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The first patch is probably appropriate for stable. It should fix
problems when someone sets the pool_mode to pernode, without userland
sending down a fully-populated thread array.

The second patch just adds a couple of new tracepoints that I ended up
using to track this down.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (2):
      nfsd: use threads array as-is in netlink interface
      sunrpc: new tracepoints around svc thread wakeups

 fs/nfsd/nfsctl.c              |  5 ++---
 include/trace/events/sunrpc.h | 23 ++++++++++++++++++-----
 net/sunrpc/svc.c              |  5 ++++-
 3 files changed, 24 insertions(+), 9 deletions(-)
---
base-commit: 914873bc7df913db988284876c16257e6ab772c6
change-id: 20250527-rpc-numa-600daff3f36e

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


