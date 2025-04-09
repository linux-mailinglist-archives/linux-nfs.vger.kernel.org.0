Return-Path: <linux-nfs+bounces-11050-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8077EA827F9
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 16:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 410C14E37A8
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 14:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08DD262811;
	Wed,  9 Apr 2025 14:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="picSNNT9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DEE25D908;
	Wed,  9 Apr 2025 14:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209181; cv=none; b=FM32nJ0sqq4ALWLmagKeSUkCi6hkORotAmuBZqwp26hJYEmR6qGRVK26xETNTvmJbsLNzXnNeRtXuONqJ1a7OEMhw88+Sw3f9LO4EF4AQb+4qBjTzKau0MT18VFA/Is4E+lAbnFNbPgRm5f9gRPu3y+0valb3znJH+GkYRr+0sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209181; c=relaxed/simple;
	bh=cX6gFBabJR2vRXRIMDyuOchKc8UluFvVmb7Kf9ib1eM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qKuU5LYAkmjc3CFFVIbfMYINLg6n3qV0YAf5uUtuF8Ok2D+m7zkYButzgiRylBU7y41kP2sxklKEBsUiu7uIzlnFmsHlhB0IwBBav9YlrtSH7eMpAjms6b/UROziQM4XCDTeuWHsmNhzxfNGzyfF4jlKYfTo/IPmh+9XKzkODUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=picSNNT9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2556FC4CEE2;
	Wed,  9 Apr 2025 14:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744209181;
	bh=cX6gFBabJR2vRXRIMDyuOchKc8UluFvVmb7Kf9ib1eM=;
	h=From:Subject:Date:To:Cc:From;
	b=picSNNT9cU0BCRu3ihC/hXQcQvQtikpynjepuXmNwNj2IoVLXZ81M9ZDx+HzoXEZJ
	 HFX9Kan9SeUv2aYqIrXtgpHcUtYdh2lW2z7eHaVqA0QD1JaJaeh9ixxUPIXkIWi6pw
	 fWIw7dhgG2flpLMnMjYUvxu4YW4JiSBsP5TfaYI9fIUySIwdQFG4boW4sf3zhLdfZO
	 8f39QDI/iplthS1G/JXjQlO0eikvrNL2vOB54glf1xXJKiGLg3u6wePXhLIFd4dRK+
	 aS+o5jn5WKHwdwZVyvtCDErPMgBApN/f9F62BZtqxO0BPTTKXMaPPkgkF3vBjBGWx6
	 sOJJwp0sv4liw==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 00/12] nfsd: observability improvements
Date: Wed, 09 Apr 2025 10:32:22 -0400
Message-Id: <20250409-nfsd-tracepoints-v2-0-cf4e084fdd9c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPeE9mcC/2WNQQqDMBBFryKzbkoSjdSueo/iIiYTHVoSmYi0i
 HdvKnTV5Xvw398gIxNmuFYbMK6UKcUC+lSBm2wcUZAvDFpqI2tZixiyFwtbh3OiuGThLtp63yl
 jbAtlNjMGeh3Je194orwkfh8Pq/raX6z9j61KSNE00gyhUUNnwu2BHPF5TjxCv+/7B0t0iSOxA
 AAA
X-Change-ID: 20250303-nfsd-tracepoints-c82add9155a6
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: Sargun Dillon <sargun@sargun.me>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2264; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=cX6gFBabJR2vRXRIMDyuOchKc8UluFvVmb7Kf9ib1eM=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn9oUTUe8+LBHHcGK7i0XPA0xoDP8zOPicn879n
 1VmJGODuGyJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ/aFEwAKCRAADmhBGVaC
 Fch7D/9kiflWjltcwg7isG7lUtbHJcqQ57oQMKvUMgCxN9fZ5UPIItFRJHVIpd0AwMvY1avLyXE
 46gFknIeQG2HPf+QwLDXsN8Bves6mgQbwVt9XBcS0HBJOiOeT5cxZCZfylWiwN0jL93O7kItPAA
 MJwa2tHhrziO9YL7Mtlhj/Yf0A1YGd9tyAa3GEiU8LukUjF5re7gwyDwNMOvVVFbxTiRCngLpAt
 JXV3xxt8jFHU7cVXBObMsPh8w/izIhLTwW/4VSSy5bZsBRxpCsbUcTDVj0SU7C0CuY2CLbMaGe9
 mcAdAyF2l1aKH5EcC2Pe3fNDx5wb9r/D1VryAavFNbtEyIKdOEksQomQQJtrvuy+wJxDXPz5yUX
 yqz0TITZKlenOdmRTCNGbe1/jaNyik/buUI6W1qflK0X4M++htHVKxmy191c5gfZA+wbSGJPRtX
 0fN/Jr1xCmlbsJKeljMFhytj5ioTa/TBNL3oMxpSqWVbNZfUO1V93n55BymeYbG2iAycdGIxtbf
 u8WoVWLf2X38dA0i4e2QEG7sqrOm6FAd9cZGcznmJsfD/iUtWaP/c/vH7tCi4hJL0iNkRnPrNcF
 uL4Lj+dVR+OO3fsnSdiTR8vDHaOf9lZIQ3vPNRVVHRb/HTad+IBO2CUGUNPw5AJ7gwUSaJPQxMw
 Ln+KF8Q2n8GXwAg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

While troubleshooting a performance problem internally, it became
evident that we needed tracepoints in nfsd_commit. The first patch adds
that. While discussing that, Sargun pointed out some tracepoints he
added using kprobes. Those are converted to static tracepoints here, and
the legacy dprintk's removed.

Lastly, I've updated the svc_xprt_dequeue tracepoint to show how long
the xprt sat on the queue before being serviced.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- Break tracepoints out into multiple patches
- Flesh out the tracepoints in these locations to display the same info
  as legacy dprintks.
- have all the tracepoints SVC_XPRT_ENDPOINT_* info
- update svc_xprt_dequeue tracepoint to show how long xprt was on queue
- Link to v1: https://lore.kernel.org/r/20250306-nfsd-tracepoints-v1-0-4405bf41b95f@kernel.org

---
Jeff Layton (12):
      nfsd: add commit start/done tracepoints around nfsd_commit()
      sunrpc: add info about xprt queue times to svc_xprt_dequeue tracepoint
      sunrpc: move the SVC_RQST_EVENT_*() macros to common header
      nfsd: add a tracepoint for nfsd_setattr
      nfsd: add a tracepoint to nfsd_lookup_dentry
      nfsd: add tracepoints around nfsd_create events
      nfsd: add tracepoints for symlink events
      nfsd: add tracepoints for hardlink events
      nfsd: add tracepoints for unlink events
      nfsd: add tracepoints to rename events
      nfsd: add tracepoints for readdir events
      nfsd: add tracepoint for getattr events

 fs/nfsd/nfs3proc.c              |  67 +++------
 fs/nfsd/nfs4proc.c              |  45 ++++++
 fs/nfsd/nfsproc.c               |  39 ++----
 fs/nfsd/trace.h                 | 298 ++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/vfs.c                   |  10 +-
 include/linux/sunrpc/svc_xprt.h |   1 +
 include/trace/events/sunrpc.h   |  36 +----
 include/trace/misc/fs.h         |  21 +++
 include/trace/misc/sunrpc.h     |  23 ++++
 net/sunrpc/svc_xprt.c           |   1 +
 10 files changed, 433 insertions(+), 108 deletions(-)
---
base-commit: 71238ba71a67aab408cfe14b6a5ae3c9b83082f9
change-id: 20250303-nfsd-tracepoints-c82add9155a6

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


