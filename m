Return-Path: <linux-nfs+bounces-10504-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2FAA54AE1
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Mar 2025 13:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 548D916D89C
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Mar 2025 12:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DAD20B7F0;
	Thu,  6 Mar 2025 12:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUdeU5A5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B2B20B1F3;
	Thu,  6 Mar 2025 12:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741264711; cv=none; b=Ky/vakEgLASGGDVDypAx5W3ozVJRDLUt3GW/VHplZv/6Mzajt5iq6BQwzujdojNQocHpNhWq8MB//ZI8a0axfD0531WODavjHejbVF2PXYwGTGYS73UKzAJHcnIKV5uEtt+vzS+2ElaPyY6Bmf67ipAQW1w1eVG1nMKnsWzklzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741264711; c=relaxed/simple;
	bh=VB81pVidViM68Ro2j4IG6kZ5N4FBbkZoUJAi27RI5Ew=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=d/PdTzD/vE2OwBk8ko9Ij6crK73NzeGfBP4TGGiaTDGwLy6X4yxzQCZ8JOx2wS5+h/lUITHXIVqQHBRmAp+Hxo+fG3bmXOfdy3qXPenn7JXSYfLGRsl2lAlIlPuH51lMQeYao5N5sfsro5XsW/p0DAzgvTGQRN2ksWfL/wAUNhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUdeU5A5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DECCEC4CEE0;
	Thu,  6 Mar 2025 12:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741264711;
	bh=VB81pVidViM68Ro2j4IG6kZ5N4FBbkZoUJAi27RI5Ew=;
	h=From:Subject:Date:To:Cc:From;
	b=qUdeU5A5hKrJAjDzroaVNybJRfpSkgs9Di2o9qdt2FTFVftGnXiCW6ddPs4PJ1duJ
	 2B1g7CK7+o9J8NuxVsTtOs1d9yLZ+mpprNwcdR6dHLVS3SHjzT1gNTeuHTRjs9PSYm
	 bWrA7NmVc9b42UC+W7N0yb+IuM6xY5G9IzKc3xAouGX+K2/hVAy3CpZxmp9zBUg6Zg
	 wH7tFriLPcdnRMDCkJVER407keSYDCDL6liI4m80lgo2HypjiNQeYaQHmU+qNdDUcq
	 32kCoETnul1netH7ix363U1pcO/vYtYLY1o7/CAu62EFGL0vAfDQKExmMsL7t+bOhd
	 T1y+HPRYNABUg==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/4] nfsd: observability improvements
Date: Thu, 06 Mar 2025 07:38:12 -0500
Message-Id: <20250306-nfsd-tracepoints-v1-0-4405bf41b95f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADSXyWcC/x3MQQqAIBBA0avErBPUMKqrRAvRsWaj4kgE0t2Tl
 m/xfwPGQsiwDQ0K3sSUYocaB3CXjScK8t2gpTZykpOIgb2oxTrMiWJl4RZtvV+VMXaGnuWCgZ5
 /uR/v+wGK4Xk3YgAAAA==
X-Change-ID: 20250303-nfsd-tracepoints-c82add9155a6
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Sargun Dillon <sargun@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1448; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=VB81pVidViM68Ro2j4IG6kZ5N4FBbkZoUJAi27RI5Ew=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnyZc+CcnVyd0tRtcIR+Xc2I/xp5G1Nof4NIAGn
 Yybm2RcbsqJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ8mXPgAKCRAADmhBGVaC
 FRvBD/9HPUpR8PqpT58yIHakSh7KWcZzGqpPvbbFoV+Tsu9Ltn31Odf2a1C0yf8Q3uB6ji3AAYO
 L7z0f84v2Nzfx7ccy5IRFf8vKbpAvtPyNo6iEncbrMBDAnVo3TJzVU2ONiEMpJ9thuR2UMEPHEV
 LJVxQ9K3GtLiNdvdvQN3oinp+mEKH+H+iNzzCSO0hVQhc+h9IROGLJLl1hM32MSCpE1kkVbcI+1
 FzC2rucq03hkXxs7YQHjwtcPlKdEEiCTAYo+cKBhAKu6GRmLv0Imk87a+tGw6qevp+9fUvhvqPw
 ERUnqMsBUW//MiFEhGkBipUKqTu7R2XVQlEAD6LfMjFBVhSdoBcIUztnzcc1XuoLo3v7XZ8+2BV
 zbnevoT9IpK15I+6REQSBm7sPUnZhXyoRdQQMpfFkmc8QHmMYFi3TM/HdjWpWU2iVke+l9IU/Mu
 9ufmXcMBvIP1SHCVDGoslC1ych0r/7S13vOACQZMtk3gYqp62n7bcDySsqZDdgsTV1FgEhT01FY
 6/3PsqsWrD/AUnxtjTVu5dMzfwj74PFuKFYToBvWaRWnPSUy7jOHmlu09J275FYhvgXk9PmOMxL
 oSN+aTb0Ib7+tDFxB14bXhKiL0MpDo6susIM/m6H0tBDo0O4PIVuemAEtiZQArDoJmtJNz79gzT
 TeWf+a/KCQDlrew==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

While troubleshooting a performance problem internally, it became
evident that we needed tracepoints in nfsd_commit. The first patch adds
that. While discussing that, Sargun pointed out some tracepoints he
added using kprobes. Those are converted to static tracepoints here.

Lastly, this adds a new counter to the pool_stats for counting the number
of times that the kernel tried to wake a svc thread, but there were none
available. I think this may be useful info for determining whether we're
bumping up against the size of the thread pool.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (4):
      nfsd: add commit start/done tracepoints around nfsd_commit()
      nfsd: add a tracepoint for nfsd_setattr
      nfsd: add some stub tracepoints around key vfs functions
      sunrpc: keep a count of when there are no threads available

 fs/nfsd/nfs3proc.c         |  3 ++
 fs/nfsd/nfs4proc.c         |  2 +
 fs/nfsd/nfsproc.c          |  2 +
 fs/nfsd/trace.h            | 91 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/vfs.c              | 31 ++++++++++++++++
 include/linux/sunrpc/svc.h |  1 +
 net/sunrpc/svc.c           |  4 +-
 net/sunrpc/svc_xprt.c      |  7 ++--
 8 files changed, 137 insertions(+), 4 deletions(-)
---
base-commit: 7dc86d35a5f8a7ac24b53792c704b101e5041842
change-id: 20250303-nfsd-tracepoints-c82add9155a6

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


