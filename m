Return-Path: <linux-nfs+bounces-15379-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 62956BEDD3C
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Oct 2025 02:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 818314E0216
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Oct 2025 00:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4173DDC5;
	Sun, 19 Oct 2025 00:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdJgtyCp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB99C2EA
	for <linux-nfs@vger.kernel.org>; Sun, 19 Oct 2025 00:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760832638; cv=none; b=e8HATKlqr/Gv9J+0VNyod2jTFlw/l6XeC77jmk7CiQVtwUCwh+gMSKYP+5jfOr79Awzda6OtFcYRnx7Lwd9K+vqVrjhji+tUWMjqAHyVsD6LYEC4879xDivhJTqwEQvGbKE83UAATkP1UvjJuu2oU0CgD/0qAbQPPk6MqGtABD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760832638; c=relaxed/simple;
	bh=x0jhXpFoBXCxXFLX6oebnTnOXS3vlLABUSLKz+sdF08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aMDzgD/uETrF8Dwv2+ZaKaOrmNZl1PNt4Tc/Fz9zOn6+xNfiaq+DwAPoVsSV57aBCSUX9T/2vQC8SKY/gDxLadP96/hUPLSL+FS5I6yMiY9LB60wkKMYpjzigs2wzwc7//jw3gn9ZUQU015t3+8p+mW36veuKTWX/wTc+vGvcoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdJgtyCp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4AC8C4CEF8;
	Sun, 19 Oct 2025 00:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760832638;
	bh=x0jhXpFoBXCxXFLX6oebnTnOXS3vlLABUSLKz+sdF08=;
	h=From:To:Cc:Subject:Date:From;
	b=RdJgtyCp7XxDewyK7tcoKZ75XkCWo5y4r2S7n/iN06tyROTQ2EiBjS4MP55wazNoL
	 wxNV4yeXMmSviVBvJJW96rsNtkEl/6YzvxSdTpcn0cxGxOp864Xk0Tm2mFIZsiujFh
	 MIJgdeBmHiK5K5gm+UA/almv4ogUpIt4ZmH8bXlVlDpv++DzeAuWPQ0EtT9rHXQ0+i
	 hKqeDZ7diWLIabZZsj6gpYCkdFS71Q78w2Ca/UBzFPAWtnl1IFYVo3BtGaxjF1ECPM
	 fNH5o7U+TaBJAVzHZtzC+bih3mwt2EIPiidbGS6U0OAPjHkAPfDBe2BaKNwA6cjbUI
	 Wk8Iq5mfEN1rA==
From: Trond Myklebust <trondmy@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Mike Snitzer <snitzer@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 0/4] TLS fixes for 6.18
Date: Sat, 18 Oct 2025 20:10:32 -0400
Message-ID: <cover.1760831906.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The following patches fix a couple of logic errors in the pNFS files and
flexfiles drivers' use of TLS. The first two fix logic errors which can
cause TLS-incapable protocols such as RDMA to be added to existing
TLS/TCP NFS clients.
The second patch adds fixes to ensure that the DS client TLS policy
settings match the requested transport type.
Finally, there is a fix to ensure that if the mount syscall parameters
include the "cert_serial" and "privkey_serial" options, then
nfs_match_client() will check those parameters against existing
nfs_client instances.

Trond Myklebust (4):
  pnfs: Fix TLS logic in _nfs4_pnfs_v3_ds_connect()
  pnfs: Fix TLS logic in _nfs4_pnfs_v4_ds_connect()
  pnfs: Set transport security policy to RPC_XPRTSEC_NONE unless using
    TLS
  NFS: Check the TLS certificate fields in nfs_match_client()

 fs/nfs/client.c     |  8 ++++++
 fs/nfs/nfs3client.c | 14 ++++++++--
 fs/nfs/nfs4client.c | 14 ++++++++--
 fs/nfs/pnfs_nfs.c   | 66 ++++++++++++++++++++++++---------------------
 4 files changed, 67 insertions(+), 35 deletions(-)

-- 
2.51.0


