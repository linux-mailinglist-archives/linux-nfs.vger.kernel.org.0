Return-Path: <linux-nfs+bounces-1489-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0ABB83E0C9
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 18:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D291F1C211BE
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 17:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3137D20322;
	Fri, 26 Jan 2024 17:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCPgz9uM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD502030F
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 17:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706291112; cv=none; b=XM4VGyL1BL7ODVFQ7pzi6S5JmAqZ98EFyCl2Ift8/j3MGfZvsM2ZXSjTfFMJy/MPmNCtH/wAnRDUUHNa2xq+K/LFFfXKFDVKh6EK8QL33Hid4j/6PEwfMyU4s9AodSV/7BLQyWpfntYy0omKsKmq2BjmwAo5nN4jVYQONf74Ias=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706291112; c=relaxed/simple;
	bh=+Bh70vWUystYTKsL6DLveDtVPBhsqY81v4hw9nvNaG4=;
	h=Subject:From:To:Date:Message-ID:MIME-Version:Content-Type; b=YInjE/EU+62sVG9mzBtSGGts7u5mDWnWNCih6bqvfOD4dE9YJKIBPshuKvA5bh6kNanSPvEX5BT5bsYX4mH722VlrU6ci4xEVMu2RC9yg8ybTzbNZpkmwev1e3JMWvCi9zhQIGqCzLfU/rbrb68B4bSNghjp7VWoVHGRGAdkGfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCPgz9uM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E1FC43394
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 17:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706291111;
	bh=+Bh70vWUystYTKsL6DLveDtVPBhsqY81v4hw9nvNaG4=;
	h=Subject:From:To:Date:From;
	b=uCPgz9uMeDQOdekTcaSzkZ7RDsKEZUHBI3kgKz/dDerwbJRc+W4hhCQ4A433GCYOI
	 VYMBDNOyTXBqe66VM2imtv7701CwnPSdb2ILp+E/oPlNsga+yK/iC/k2697nxTjCC9
	 JINCmw28oOikIGWlMe0zXLUtvLiQZaBhWLUw1DuqVt9dY6JfCe3OibIhJvuYGAba+4
	 0CtaAB6T+YDSYU21nnywLUYVm/bRGx5hDwbDYfw0w+FT9hbZgA8b8eYB9lIk2OpG1V
	 NleBN6DIPOXj9n+JaDlCnh4WAqZ6KAhKMeCv2WiO9malxh5QRHahg+0lYilCQCwa4d
	 PeJarfhCsOHtQ==
Subject: [PATCH 2 00/14] NFSD backchannel fixes
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Date: Fri, 26 Jan 2024 12:45:10 -0500
Message-ID: 
 <170629091560.20612.563908774748586696.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The first four patches fix bugs that prevent NFSD's backchannel
from reliably retransmitting after a client reconnects.

Following that are some new trace points that might be helpful for
field troubleshooting.

Then there are some minor clean-ups.

Changes since RFC:
- Replace the msleep with queue_delayed_work
- Refinements to patch descriptions

---

Chuck Lever (14):
      NFSD: Reset cb_seq_status after NFS4ERR_DELAY
      NFSD: Convert the callback workqueue to use delayed_work
      NFSD: Reschedule CB operations when backchannel rpc_clnt is shut down
      NFSD: Retransmit callbacks after client reconnects
      NFSD: Add nfsd_seq4_status trace event
      NFSD: Replace dprintks in nfsd4_cb_sequence_done()
      NFSD: Rename nfsd_cb_state trace point
      NFSD: Add callback operation lifetime trace points
      SUNRPC: Remove EXPORT_SYMBOL_GPL for svc_process_bc()
      NFSD: Remove unused @reason argument
      NFSD: Replace comment with lockdep assertion
      NFSD: Remove BUG_ON in nfsd4_process_cb_update()
      SUNRPC: Remove stale comments
      NFSD: Remove redundant cb_seq_status initialization


 fs/nfsd/nfs4callback.c   |  94 +++++++++++++++--------
 fs/nfsd/nfs4state.c      |   1 +
 fs/nfsd/state.h          |   2 +-
 fs/nfsd/trace.h          | 162 ++++++++++++++++++++++++++++++++++++++-
 include/trace/misc/nfs.h |  34 ++++++++
 net/sunrpc/svc.c         |   1 -
 net/sunrpc/xprtsock.c    |   9 ---
 7 files changed, 261 insertions(+), 42 deletions(-)

--
Chuck Lever


