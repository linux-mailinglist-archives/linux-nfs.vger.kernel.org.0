Return-Path: <linux-nfs+bounces-12586-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC989AE1AC2
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Jun 2025 14:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 554EC166C13
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Jun 2025 12:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EDE220696;
	Fri, 20 Jun 2025 12:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkVs9LV0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DED930E850;
	Fri, 20 Jun 2025 12:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750421784; cv=none; b=lRslE60d1Eq5HhUIud0NrU352AVawWGY1GKpyXBHLMOxGx6nFB4APWNreJ10y9AAacwCjp6Me5AOuLz0zGy7ugt7nmCOdNu/zLi6QWamTmK1Dt3i9yfX9/+lBVBu3mraTNZ+EtRBKDxwfFkZdpk9eTouSf5LCFsRmR8NFOScN/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750421784; c=relaxed/simple;
	bh=rX3bGBndYMRwkB5DKxwVPsot0UQR+utfnqOsyfClt6M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=i1c14Asc/aCXpLferYnvCbvP/sfQ1BM4u+DKdpLF0yKZem+BHoqsx8n2H+tUUIZykTWOjThe0rwa3kEXqJy035jbWX0MUMrRgagRr/Fvf03SvgguyPyyUQXkpr0sF0MC/2S/mEthL7/05s9rRMGiwf593fqDl+E4X92LS97pFvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkVs9LV0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0CBC4CEE3;
	Fri, 20 Jun 2025 12:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750421783;
	bh=rX3bGBndYMRwkB5DKxwVPsot0UQR+utfnqOsyfClt6M=;
	h=From:Subject:Date:To:Cc:From;
	b=gkVs9LV0DZKy+/MZuiIUFBWT8UfP2nTv3KBV6JvlXhy8U5Bf7niQg9BgR0D9VFBNP
	 TtbDMfSz26OS3wOW+79dsujaJK/8whHUz/27Yf3HMF2VF0GLJMwOsrSD3nPX1+kZKs
	 OXiCL6yeq2WUON7K3PMHFPe3dJ82oDN1Ugn59FPI1bPLwpqCoSEHLjY+E260wcbFGd
	 SU66NkjlSPoicsW+98jzhFnjiFItEynYWy0/DCy9H9SItcv5E3uIUoeiIKW8r2FO6X
	 Jpq3FAfO6DKbxJGI1medqZCT0mcQipzBm6qS8OQPFgAqPoMQzr7ohj2v6StdVHkNlx
	 tLrhe1u5351aA==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/6] sunrpc: patches and cleanups for v6.17
Date: Fri, 20 Jun 2025 08:16:00 -0400
Message-Id: <20250620-rpc-6-17-v1-0-a309177d713b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAABRVWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDMyMD3aKCZF0zXUNzXfMk01TL1KS0JIvUVCWg8oKi1LTMCrBR0bG1tQD
 3WIpOWgAAAA==
X-Change-ID: 20250620-rpc-6-17-7b5e9ebfb8ee
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1262; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=rX3bGBndYMRwkB5DKxwVPsot0UQR+utfnqOsyfClt6M=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoVVEOzc+OxtRV1pkMKn4aRbcoFVFdHA1vvHHv7
 TV/lK5bvaCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaFVRDgAKCRAADmhBGVaC
 FYBWD/0c8G810d81IOPb8+3zV7joAdBMB0EqLttQXPmUjA8Ai0AMbdgI2kT7Mc1MKEJoRTQwOhc
 /5ZUtf1Ka5BxNNy3mJ5y0J6rvvr347zbaX9aK1B0V0obnz9SZRhpA8G+YVTH8p/yZj6CcM5CJTZ
 tHodxHOP9ihIFRTkYsLeZis5YBQmewfWSrRfZl+UMUk6AZdQXH72fL0yjyNDN2qFwTZW886o5AA
 TRIH/jwC2q2ChSCY+m/8nZMqFgoFSuc7wlZhFWsghVnYa0xwD3UlHXNv5Y/WpciJsPSxg66Gu+S
 dOLkBfwxgfKSaCAq6O4LFr7felzqRZpiZKBGKpJtxeAONyqrwKItyUWHvLkZPyGBKZ0zUYVthyf
 iLWVR+zbOtrR6LfMxejwvC7mAbk1jMo8gHXtkskNxVOxMmV5rMfxgdzgAfZ1f7HLz9XfBYGDvUN
 onnfPEAyFNuLboyJyGXhg/uSgbdz02ZcUH5BGO8vV+uXbhdTe3M6IxUox+Hx0sculrgcOz686eJ
 ESWW9RnyXIC7oidtFw9IIVa3T0FCK7RF68tXBPHtI8z3WUTe9GzX4gkDlT2cc0D9FK4BeOixi9W
 yj9PPI0thMpkYCJ5dk94EqG9p/6tcWk/slVuPzXL9ANqsfznUnqwgHvBnHBs86hWA1A/T3pERws
 aDjpPEUofWM5lqg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Hi Chuck,

The first 3 are directly related to the svc_process_common() patch I
sent yesterday. They're just further cleanups and fixes to that
codepath. The other two are random sunrpc patches I've been carrying for
a while.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (6):
      sunrpc: fix handling of unknown auth status codes
      sunrpc: remove SVC_SYSERR
      sunrpc: reset rq_accept_statp when starting a new RPC
      sunrpc: return better error in svcauth_gss_accept() on alloc failure
      sunrpc: rearrange struct svc_rqst for fewer cachelines
      sunrpc: make svc_tcp_sendmsg() take a signed sentp pointer

 include/linux/sunrpc/msg_prot.h   | 18 ++++++++++--------
 include/linux/sunrpc/svc.h        |  6 +++---
 include/linux/sunrpc/svcauth.h    |  1 -
 include/linux/sunrpc/xdr.h        |  2 ++
 include/trace/events/sunrpc.h     |  2 --
 net/sunrpc/auth_gss/svcauth_gss.c |  3 ++-
 net/sunrpc/svc.c                  | 14 +++++---------
 net/sunrpc/svcsock.c              |  5 ++---
 8 files changed, 24 insertions(+), 27 deletions(-)
---
base-commit: 78ff1c2c7a4a3a7c6d3c9a7c4142c41081b53a0d
change-id: 20250620-rpc-6-17-7b5e9ebfb8ee

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


