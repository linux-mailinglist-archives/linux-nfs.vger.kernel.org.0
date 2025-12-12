Return-Path: <linux-nfs+bounces-17058-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EA9CB9F73
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Dec 2025 23:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9424305AE4E
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Dec 2025 22:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F183A2C08DF;
	Fri, 12 Dec 2025 22:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUgcTQIN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB8C221F0A;
	Fri, 12 Dec 2025 22:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765579179; cv=none; b=Wx0UnxtZHIEP1Rk02i+1/SL5H/O1+tU7qOuCkRFhaRpA3HbauWLiwZNamhXISMv6eU3q+XyJ1Fa1gNqyFCB+8uvsgftHDtbvZ+VG6y3YPlqRxO5FdpiN0u6M2mBUx0bBZe71Sw0/FFTQK23M0g7GBztxGv6/axG0x2RBDomDuNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765579179; c=relaxed/simple;
	bh=lj1Wlc7uNmoeTI2bfiWvB3O/9hYLAmU6XXKjFxGnLtc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cHTB7ZNmfTstCWCLiYWFnTIv80u/BkakxM6f/8DgQMl8h1oOPs18yXKz03kLk3Nfdh8e65w31z8UdtjMbFj5MHu5v7u96ziuuQFR5NOM6UBXEd900jLsSEOc7ZDbFCmqry0mMOCp2MHzMwv/Hy5hD1s3erE8xbT5myz453UGq9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUgcTQIN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81802C4CEF1;
	Fri, 12 Dec 2025 22:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765579179;
	bh=lj1Wlc7uNmoeTI2bfiWvB3O/9hYLAmU6XXKjFxGnLtc=;
	h=From:Subject:Date:To:Cc:From;
	b=hUgcTQINaHE96mwBEwEpN8aSF3awxXTJYvG4I7BoJzc5OmWSJMX6IOfLYrvj6ZOAK
	 nrlGQLhsv6Tkc6IpNm2hmp1FD6r6umuZKjwa4BRu69s6Uv7Q0hnlnkq8krM9SpqQiN
	 eWMICqXs16dpO3ZlLVaObEarCPXoKiD5FjNc1I4EeDkaQEwFEagP+v9ngh1nDL/Yuh
	 YqQlCx5jdVMaU9cerg6ki0BBJU8wyGC2oUT7ypSODe8cLhm4RRQwTsK5+0Vxxok8W5
	 0hNzVpD28s0zCsv7Lk2Ln31airalQKGxWtmWG3yGzSFNlqIr2hruQh2hVCRTQBaHhe
	 gGk0WjtMlRVdw==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH RFC 0/6] nfsd: allow for a dynamically-sized threadpool
Date: Sat, 13 Dec 2025 07:39:12 +0900
Message-Id: <20251213-nfsd-dynathread-v1-0-de755e59cbc4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDI0Mj3by04hTdlMq8xJKMotTEFF3LNPNEY0NDcyMDA1MloK6CotS0zAq
 widFKQW7OSrG1tQBS3farZgAAAA==
X-Change-ID: 20251212-nfsd-dynathread-9f7a31172005
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2971; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=lj1Wlc7uNmoeTI2bfiWvB3O/9hYLAmU6XXKjFxGnLtc=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpPJmnG9lwPZwxrFL0eA1cW3HkIPqSBzej/FIkE
 NGM3GpWeiGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaTyZpwAKCRAADmhBGVaC
 FX3hEAC2w5/pLJYpxDihSLilXYOzXoG9xz3yQt0XSJ3UcsWbK1gELpCHvyKQ/G1E4EYxabaYUqF
 +y8K8IDRv/G3VCEVcPJ12x6gSAZ/gpMlxQ+NGJcxV4A8OOVzqGao0AbLCxPDF8U+JJ9flLU+kxF
 HkcXQpSdLN54LclT7VPXt/EEmuvYL4FHBGfSy/9mg8J86cDS6JXckFGOExP9rbP8pW1CC/INPMY
 fu4o4/z3w6YRik7IANEtnfhk8lrsrvpWFQFypoilwudEQV7LHiCy9pgjHapvjq4S6XmxbKhTSs5
 Al5NJqXM8n0Nx8OvFyPWtPbWb/qoVqdmbczHepQrqKyG3VE4oO7CCW7HX/zuXsNsuW1PU8p+w5w
 VgG+ZxhoAPFfotPTgem4mKfhSAEGpno0ihcoPmnU3HkLmcgjrbtVqj8QfjxwbDZWOmYoftNI7Hz
 a2llUS0EnCRtB53qewOt4JGAZJk0Ns3CE8YzamD8lZ0xddPpV1ioWwohHXDY9VV7ifRqVhzVTvD
 Xnde4T5CJIpzjlQQ1edmCAyFSsOgGloZKNxFxV0IXDgCZ3fW6AsHJ7A8Yhtkl0xZdGRnT1vFmj4
 KpKdf7IqGQuSO9q1lU8ND4gfRL4I7QvsOcs6t73xQsNwmpVN2D1OU4tIXFxk9Doz1AzmkaT1ql4
 ZyFPcu/OUwfa+fw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This patchset changes nfsd to dynamically size its threadpool as
needed. The main user-visible change is the addition of new controls
that allow the admin to set a minimum number of threads.

When the minimum is set to a non-zero value, the traditional "threads"
setting is interpreted as a maximum number of threads instead of a
static count. The server will start the minimum number of threads, and
then ramp up the thread count as needed. When the server is idle, it
will gradually ramp down the thread count.

This control scheme should allow us to sanely switch between kernels
that do and do not support dynamic threading. In the case where dynamic
threading is not supported, the user will just get the static maximum
number of threads.

The series is based on a set of draft patches by Neil. There are a
number of changes from his work:

1/ his original series was based around a new setting that defined a
maximum number of threads. This one instead adds a control to define a
minimum number of threads.

2/ if the thread's wait doesn't hit the timeout, then svc_recv() will
not return -ETIMEDOUT and the thread will stay running. Timeouts only
happens if a thread is wakes up without finding work to do.

3/ the printks in his original patches have been changed to tracepoints

So far this is only lightly tested, but it seems to work well. I
still need to do some benchmarking to see whether this affects
performance, so I'm posting this as an RFC for now.

Does this approach look sane to everyone?

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (6):
      sunrpc: split svc_set_num_threads() into two functions
      sunrpc: remove special handling of NULL pool from svc_start/stop_kthreads()
      sunrpc: track the max number of requested threads in a pool
      sunrpc: introduce the concept of a minimum number of threads per pool
      nfsd: adjust number of running nfsd threads based on activity
      nfsd: add controls to set the minimum number of threads per pool

 Documentation/netlink/specs/nfsd.yaml |   5 +
 fs/lockd/svc.c                        |   4 +-
 fs/nfs/callback.c                     |   8 +-
 fs/nfsd/netlink.c                     |   5 +-
 fs/nfsd/netns.h                       |   6 ++
 fs/nfsd/nfsctl.c                      |  50 ++++++++++
 fs/nfsd/nfssvc.c                      |  56 ++++++++---
 fs/nfsd/trace.h                       |  54 ++++++++++
 include/linux/sunrpc/svc.h            |  11 +-
 include/linux/sunrpc/svcsock.h        |   2 +-
 include/uapi/linux/nfsd_netlink.h     |   1 +
 net/sunrpc/svc.c                      | 182 +++++++++++++++++++---------------
 net/sunrpc/svc_xprt.c                 |  45 +++++++--
 13 files changed, 315 insertions(+), 114 deletions(-)
---
base-commit: b6cf9ca7e7555f7f079bb062e3cd99a501e0d611
change-id: 20251212-nfsd-dynathread-9f7a31172005

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


