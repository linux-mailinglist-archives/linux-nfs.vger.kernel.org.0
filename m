Return-Path: <linux-nfs+bounces-1386-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6EE83C7EF
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 17:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F09E31F27A7D
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 16:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC977762A;
	Thu, 25 Jan 2024 16:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0h7ZcX2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D7B73177
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 16:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200121; cv=none; b=N6IaAsl/dxemoUqVDtDDh20hRtQoVXHLF4ebcpdFddGsfdY0a6AAV8wo5a2OnYOHdlcqjOhVK1ZuB9M3caG05ALZwMITmTd1zvj3n/zjiTuKCViJDy1Al9U04wMSdqvjTsyKUPfJYNgme1m/reiyw8JZDVVNlu8yhoVojrmCn+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200121; c=relaxed/simple;
	bh=i2Y6yXDRLAHbGZr1OVFW3UAwZILAyKrA1+Zl4amBkWs=;
	h=Subject:From:To:Date:Message-ID:MIME-Version:Content-Type; b=a7KzLOtgiuFZsaxsCdkWI0SkpaVCOamg4n1Dkrt2wTcyFPKAnUuTFaWQnkpU0Avyb2t7FuYsqip8fIGS4mX+PlH6s5TgIPDTd6HTmTW8OH9nRyMGlM4fz76BHeNqJtlfeUPlx4l5NdmU8fi9xV/+gKXLXWldlHpP+dLccGoJb6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0h7ZcX2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBB8C433C7
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 16:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706200120;
	bh=i2Y6yXDRLAHbGZr1OVFW3UAwZILAyKrA1+Zl4amBkWs=;
	h=Subject:From:To:Date:From;
	b=l0h7ZcX2p1dW34+TCIT5WsyY5kPtUxYGRji36VO8r60NW+jWHVpWxmLq77D4A43N8
	 aTDybLA4pxSoE4UeAOdmcznP17Vl6tATqPVAmd4k1J8Aqsdn8YtQImJzM+fWJ+oipK
	 BnqhXWFpK1NwmTBx4wtqcrl/d4ahLdWpr37GxZ7G6BIdcfbrpGz/0YZO6uQ6tDgk5O
	 a482TnZwkI3uuJEaB7LMrql0PrMdFaAjinPe9+YV2vAPlss6WpJmIVnf5A7N13L+Bm
	 n4wTCTGxU3ovVGYqeDe8uBLhh8MJ7eKEOxHVS1tiqu99tC+DhJYuqSmMHW/d2fhyA8
	 efTxoAiFdhFYA==
Subject: [PATCH RFC 00/13] NFSD backchannel fixes
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Date: Thu, 25 Jan 2024 11:28:39 -0500
Message-ID: 
 <170619984210.2833.7173004255003914651.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The first three patches fix bugs that prevent NFSD's backchannel
from reliably retransmitting after a client reconnects. These fixes
might be appropriate for 6.8-rc.

Following that are some new trace points that might be helpful for
field troubleshooting.

Then there are some minor clean-ups.

I am still testing this series, and there is one msleep() call that
needs some thought. Thoughts, comments, opinions, rotten fruit? You
know the drill.

---

Chuck Lever (13):
      NFSD: Reset cb_seq_status after NFS4ERR_DELAY
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


 fs/nfsd/nfs4callback.c   |  81 +++++++++++++-------
 fs/nfsd/nfs4state.c      |   1 +
 fs/nfsd/trace.h          | 162 ++++++++++++++++++++++++++++++++++++++-
 include/trace/misc/nfs.h |  34 ++++++++
 net/sunrpc/svc.c         |   1 -
 net/sunrpc/xprtsock.c    |   9 ---
 6 files changed, 250 insertions(+), 38 deletions(-)

--
Chuck Lever


