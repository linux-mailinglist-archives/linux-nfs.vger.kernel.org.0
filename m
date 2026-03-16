Return-Path: <linux-nfs+bounces-20184-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UD+FLCwfuGlYZAEAu9opvQ
	(envelope-from <linux-nfs+bounces-20184-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:18:04 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7181329C236
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E16EA302961E
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 15:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCB3283CB5;
	Mon, 16 Mar 2026 15:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntzHJWRa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDC21E531;
	Mon, 16 Mar 2026 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674111; cv=none; b=notFjKFC1ZzYbSpsX+luMvOyRKWmhBRBPlSLctY+TokTEBtGgzbc784Cbob1TFtO8d3bP+KdSVCPcz8VEJqgNkMjko/1t3/WDsUYiY+WuopWcKLvmouAxFEqIGSAW/wzwrbcLHcaJjGXeB7YlioG5iNIaM3yh6/0GcMDGHaVxN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674111; c=relaxed/simple;
	bh=6LagLiqTb82yUEM0HqWHQF04wLlhTNLq28iIDEjaKjo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lrgTutgw8U5qyiTtXaMk1k87SBilt9LfqPXzj7mbCg+MuzjW9NlyZCjhEEKXZDREkdIJOSw05DDuMGJBACb1Ry29BmUwDyTTHdQSgrHbzlqeiUNma9A7afvEHK3qQ+E8csrGk6v9NcA4wBhM9TrscjbasOCgii+Z6UF7+tlMHjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntzHJWRa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823D6C19421;
	Mon, 16 Mar 2026 15:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773674111;
	bh=6LagLiqTb82yUEM0HqWHQF04wLlhTNLq28iIDEjaKjo=;
	h=From:Subject:Date:To:Cc:From;
	b=ntzHJWRaa2sT/4fDVrzn25c5qXOUJ0s0PWqTQ79WFG66c1GIkXKvVbpTzGJnnvsOS
	 ZMnxesR778uX3Q1U2vk+CmOV1gZrjCqpYqJKNCzxfvDYU0myOgQhKt3aBJvtBXNAvg
	 UE+K0/+MS5+dlXVAkQtqU1Fd5kdGkOT1GW1Gq/NTpiy239fLdcTzsnKLy/78FgTiqO
	 M99cPxt2wwDPfK7B6sgJNTol9WgFimy4AapN9I9T8AccyRML3+sb8LF5NPjsNrzHxY
	 j9thDl5MsIsqEFj9qJdwB9CxbpJAOY3FCCC0aTf+mn1DjUC2RvGZ1u4+vfsRb5uAv9
	 nnxLlFlXesEGg==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 00/14] nfsd/sunrpc: add support for netlink upcalls for
 mountd/exportd
Date: Mon, 16 Mar 2026 11:14:34 -0400
Message-Id: <20260316-exportd-netlink-v1-0-6125dc62b955@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQqAIBBA4avErBP8QaGuEi0qxxoKFY0IxLsnL
 b/FewUyJsIMY1cg4UOZgm8QfQfbsfgdGdlmkFwaroRh+MaQbss83hf5k4ltcKuWWhlU0KqY0NH
 7H6e51g+ZsXWbYQAAAA==
X-Change-ID: 20260316-exportd-netlink-1c9fb52536e3
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3200; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=6LagLiqTb82yUEM0HqWHQF04wLlhTNLq28iIDEjaKjo=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpuB50dlpuz8LsW06IyyrkRsPtqTH4DwpWCCPIs
 Bv7e4ghknKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCabgedAAKCRAADmhBGVaC
 FY+3D/0eJa3+GQfYWeKOGsS2QIwEJr5kvk27H9NIMhW+qvdCjK/cuxsqysMsdbmvHEtRSOp6BT0
 jeK95+ZcHPz4uifiB2XhhAzeQ46i1sLJu9h/b7r+dPSNs0QAhJTmdNfgzCZVg/AIvdHFyjqGNlW
 fWOt5tse3UC3bJVjzGbB/xYMYa9YqWscGE5uHoqAUMXhEZzE5rNhXGVfNLL1IR7IsCz10O7uhN6
 pbpyxin5siRT2SgRg1I5820kF8jOWB1H+ZinPDnXMROk4qVPTgJF5yQSetp4nzcSfoLd/8GRjZS
 KYNRhpYGYTLqfRCLJ+AT0FDYTWVWWD1PAWfyP7XN4TPZLFSteQZ8kXlUruKz72jxT0wnRxWdZ3E
 WgPLWab9OHWzXjTQCwgJXgmwEcFEhly57q3h93FJ+e/6TOu24OXQFjD9bZx/mnCP2C+XfIwJjBL
 UIqzGucH+jiPIIjuIWUB1m9xM5DiKUWS9PCGgwD5HiiX289qrduyWDgc1q3UpcQEFlH0iCgankx
 A3YuJApbnxOovdN4zbxWHC2rbvq/0Q1mE/rcftNBKf5LwXeprfdEMvb3jouW+v/gY9fUczKrWKf
 L60OLQcz8Um8ZpUOB/+iGbtw0OguOuyB4o2vjuGWZmqj1NGy2h0fmt2op2YqBAVGjP6i12Ad8o+
 W6OYWnmkAl4yfig==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20184-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7181329C236
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mountd/exportd use the sunrpc cache mechanism for some of its internal
caches that are populated by userland. These currently use some very
antiquated interfaces in /proc to handle upcalls and downcalls. While it
has worked well for decades and is relatively stable, it has some
problems:

Most notably, it's very difficult to extend to add support for new
export options. There is also the matter of requiring /proc which is not
always desirable in a container.

This patchset adds new netlink-based interfaces for handling the sunrpc
cache upcalls. The basic idea is to add a new "cache_notify" operation
to struct cache_detail. That causes the kernel to send a notification to
userland which then fetches any outstanding cache_requests and then
responds to them via netlink.

There is also a companion patchset for nfs-utils that adds the necessary
support for these interfaces to mountd/exportd and exportfs.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (14):
      nfsd: move struct nfsd_genl_rqstp to nfsctl.c
      sunrpc: rename sunrpc_cache_pipe_upcall() to sunrpc_cache_upcall()
      sunrpc: rename sunrpc_cache_pipe_upcall_timeout()
      sunrpc: rename cache_pipe_upcall() to cache_do_upcall()
      sunrpc: add a cache_notify callback
      sunrpc: add helpers to count and snapshot pending cache requests
      sunrpc: add a generic netlink family for cache upcalls
      sunrpc: add netlink upcall for the auth.unix.ip cache
      sunrpc: add netlink upcall for the auth.unix.gid cache
      nfsd: add new netlink spec for svc_export upcall
      nfsd: add netlink upcall for the svc_export cache
      nfsd: add netlink upcall for the nfsd.fh cache
      sunrpc: add SUNRPC_CMD_CACHE_FLUSH netlink command
      nfsd: add NFSD_CMD_CACHE_FLUSH netlink command

 Documentation/netlink/specs/nfsd.yaml         | 239 +++++++++
 Documentation/netlink/specs/sunrpc_cache.yaml | 149 ++++++
 fs/nfs/dns_resolve.c                          |   2 +-
 fs/nfsd/export.c                              | 707 +++++++++++++++++++++++++-
 fs/nfsd/netlink.c                             | 109 +++-
 fs/nfsd/netlink.h                             |  18 +
 fs/nfsd/nfs4idmap.c                           |   4 +-
 fs/nfsd/nfsctl.c                              |  75 +++
 fs/nfsd/nfsd.h                                |  17 +-
 include/linux/sunrpc/cache.h                  |  12 +-
 include/uapi/linux/nfsd_netlink.h             | 133 +++++
 include/uapi/linux/sunrpc_netlink.h           |  84 +++
 net/sunrpc/Makefile                           |   2 +-
 net/sunrpc/auth_gss/svcauth_gss.c             |   2 +-
 net/sunrpc/cache.c                            |  76 ++-
 net/sunrpc/netlink.c                          | 144 ++++++
 net/sunrpc/netlink.h                          |  38 ++
 net/sunrpc/sunrpc_syms.c                      |  10 +
 net/sunrpc/svcauth_unix.c                     | 506 +++++++++++++++++-
 19 files changed, 2287 insertions(+), 40 deletions(-)
---
base-commit: e344b49528c8ef457ee714bb65e2da4c121132c2
change-id: 20260316-exportd-netlink-1c9fb52536e3

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


