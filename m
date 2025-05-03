Return-Path: <linux-nfs+bounces-11390-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5949AA8134
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 17:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C3613B3941
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 15:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E904239085;
	Sat,  3 May 2025 15:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaPRTaM0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3420B83CC7;
	Sat,  3 May 2025 15:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746285105; cv=none; b=lQFI0yMucD8jF2rg5ozDHZ0v/4hCpzYcbBnadyIooUIXyWMiE7swCFqP0Mf25JuiOeZ3LmHGhcgGu1MYyWyQ+hd8Pm1oMmibkcSm7u2tIpl28ZJ91yCbsc7CwkG3HRLXf5rUgR2pHejgHUVSvDyDUoQ/1nZu+2exczQYnb8vS2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746285105; c=relaxed/simple;
	bh=kLFBK8wr8H3twAoSRnXL/MOt+qP6UP8OCXIjceKl9So=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Q4qjNo2lvcPc3VBZpC3F1ugipf2HxOvY2s3KfCX3SwR04h28xg9jwKkuKaze2udivKtIEWm+q+MwGObzMYhagqI5IfrqPjD1dv94TXLG2r+bqhn3iSKM/RPlRBPAQEJW9NM7zXltQoxjdInuGHMweUsNJRBoxAjHjMI6rkKJ8QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WaPRTaM0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEABAC4CEE3;
	Sat,  3 May 2025 15:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746285104;
	bh=kLFBK8wr8H3twAoSRnXL/MOt+qP6UP8OCXIjceKl9So=;
	h=From:Subject:Date:To:Cc:From;
	b=WaPRTaM01QuJVsfk8boQO0WyMQ+7LkY3VId2NS16kpMZ2b9uu0PxP6zxuDww4vytT
	 FYSmjUFPijKalbRxwVmebOXt46WbczwUriPs7MDwEK898Dq78k3nDGTuAeBVJjtW1A
	 9SMY+2U7oVjhw8caX2Eo51xX5J1p49OUuXIZP+9Klza4gCmMzrSGe3K+Cw16aq3ccr
	 ZmmJnb/pETgMhMZge+8HAVZnJQe1Y8wwe+3Wvpf1S3qH1+mjHFICjXWjlEJe7RZ320
	 PcaHkfNQI4e4Jaw94OXG9AWsm+ZU9T1Gf2bVN7sW3QuPqLgNvrLWisdreS5VvdbPie
	 0PibrV/09hcgg==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v3 00/17] nfsd: observability improvements
Date: Sat, 03 May 2025 11:11:16 -0400
Message-Id: <20250503-nfsd-tracepoints-v3-0-d89f445969af@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABUyFmgC/23OUQvCIBDA8a8yfM44nY6tp75H9OD03KTQoUOKs
 e+eG0REPf4P7ne3kITRYSKnaiERs0su+BL1oSJ6VH5A6kxpwoFLqKGm3iZD56g0TsH5OVHdcmV
 Mx6RUDSlrU0TrHjt5uZYeXZpDfO4XMtumb6z5xTKjQIUA2VvB+k7a8w2jx/sxxIFsWuYfQUD3R
 +BF0FYgtMKWv/SXsK7rC82OkanzAAAA
X-Change-ID: 20250303-nfsd-tracepoints-c82add9155a6
To: Chuck Lever <chuck.lever@oracle.com>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, NeilBrown <neil@brown.name>
Cc: Sargun Dillon <sargun@sargun.me>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2529; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=kLFBK8wr8H3twAoSRnXL/MOt+qP6UP8OCXIjceKl9So=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoFjIl1nh6CnsIrD9e6kC4G5W6jU3eGgnGEEdra
 Fb6Be1vFiCJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaBYyJQAKCRAADmhBGVaC
 FWIuD/9MJSL55UJ0H8QIQLuaZlVe5o2Hnv4dpW1DCipQxiVvyHCZz8fUWi9Bk1SxCySkFbbXWZS
 BILrm8EJurjgvA+TZ9wHIZp1Wk7SS3CbiRZPXTR9I86iAhfagDD9FYIlKQlcvLDE5OLE4RGXrVS
 ZyZLuXDZpZ/2kW+JE76L7C+a0CPdJ6yxDUC7Idx4QxHRBbudHKYhsGIu742ku5Gd6tKMEVTv5Yr
 jzkMxgwzIk/hYuwdAv08cgoVutLiuVnF3bkCGm5OhzDb2aSB5Zg9uB2X97gT5aQow0P7mPtJ3Y3
 aExXebDuMzuX+0WEOOOLMqtlygNV1h6ekK5Q59bB2cpYH2h2c2HUppNcqps9YWEV/5GGPfO3e8Y
 P/7Mg6FeyUs7tsjxN4j9tDYDAObH8luw2a125qL8qIBBLXFbq439TXHLjN8XPYRuCMWMP1Vs1hb
 5134irGdhAIOM6faFniC+cbvFxqY73jK0Mp1WqF892DXXSmeRGR6WqszeIOPY8fN+GLpw6e1sM0
 p6YyoALJ1deI3uq6JuzCkIhOlEQtgDAhdIrc46Yzke45+StaRghDSPnlfK+5nYZnLmf41NdEMo3
 DeZiPT1V9jH9PYjWIrwkYP6LJ6oAm5UfnvuYMm0sj4/GCx2jeZmY71Zn1nzKO/qYu4LXGmBt916
 MyTvoZx3BpZ9TyQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Sorry these took a while! This version moves the new tracepoints closer
to the vfs layer, into the non-version specific common vfs helpers.

I've also made separate patches that remove the dprintks. Since the new
tracepoints aren't in the same places as the old dprintk's, there could
be an argument for keeping them. I'm fine with either.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v3:
- move most of the tracepoints into non-version specific nfsd/vfs.c calls
- rename them with a nfsd_vfs_* prefix
- remove the dprintks in separate patches
- Link to v2: https://lore.kernel.org/r/20250409-nfsd-tracepoints-v2-0-cf4e084fdd9c@kernel.org

Changes in v2:
- Break tracepoints out into multiple patches
- Flesh out the tracepoints in these locations to display the same info
  as legacy dprintks.
- have all the tracepoints SVC_XPRT_ENDPOINT_* info
- update svc_xprt_dequeue tracepoint to show how long xprt was on queue
- Link to v1: https://lore.kernel.org/r/20250306-nfsd-tracepoints-v1-0-4405bf41b95f@kernel.org

---
Jeff Layton (17):
      sunrpc: move the SVC_RQST_EVENT_*() macros to common header
      nfsd: add a tracepoint for nfsd_setattr
      nfsd: add a tracepoint to nfsd_lookup_dentry
      nfsd: add nfsd_vfs_create tracepoints
      nfsd: add tracepoint to nfsd_symlink
      nfsd: add tracepoint to nfsd_link()
      nfsd: add tracepoints for unlink events
      nfsd: add tracepoint to nfsd_rename
      nfsd: add tracepoint to nfsd_readdir
      nfsd: add tracepoint for getattr and statfs events
      nfsd: remove old v2/3 create path dprintks
      nfsd: remove old v2/3 SYMLINK dprintks
      nfsd: remove old LINK dprintks
      nfsd: remove REMOVE/RMDIR dprintks
      nfsd: remove dprintks for v2/3 RENAME events
      nfsd: remove legacy READDIR dprintks
      nfsd: remove legacy dprintks from GETATTR and STATFS codepaths

 fs/nfsd/nfs3proc.c            |  63 +-----------
 fs/nfsd/nfs4proc.c            |   2 +
 fs/nfsd/nfsproc.c             |  35 +------
 fs/nfsd/trace.h               | 218 ++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/vfs.c                 |  18 +++-
 include/trace/events/sunrpc.h |  23 -----
 include/trace/misc/fs.h       |  21 ++++
 include/trace/misc/sunrpc.h   |  23 +++++
 8 files changed, 287 insertions(+), 116 deletions(-)
---
base-commit: d417fc0a03710ea5ed4c50d8eff3cf29cd86c87f
change-id: 20250303-nfsd-tracepoints-c82add9155a6

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


