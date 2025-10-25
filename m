Return-Path: <linux-nfs+bounces-15628-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA02C0960C
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Oct 2025 18:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9320034671C
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Oct 2025 16:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F243830DD39;
	Sat, 25 Oct 2025 16:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pk9hxmBr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D6930DD36;
	Sat, 25 Oct 2025 16:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409156; cv=none; b=O02X9s1mZzJVCTloUwiklIlyuuQxHUznuhfPEMUQZ8W8Tv0aiaKhAm9bGt/T860tJUPopwi6wME3mgTcFxZJyeKf41H10AgTXsxXDNc5wmQ7oVCfFAzQPFicyHYZW8kOCTO5F9xapOIDIrm1QbcD8M+QjWFHRzivRhC2cRVZv1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409156; c=relaxed/simple;
	bh=VLdLtuyN9J/eVRK6iiEAMD7yIBkR2JsLYXA2NVdJ7t0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VUSRZKejQfy0yPC1ZqVVydkDGJmT9cheoMtaRA0SuXrNqZlzygUUf187kNb/SHt9k9vHt1Nk0whKtI/G/8FZlMb8kyNY0+YX9OBtP59q7QyzQ/pQfSN9PA6lwEmmdspIbquWkXhKlyzxLKPvbF1qh4UHhuVW+5Wc79jiJzI3QZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pk9hxmBr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDAA4C4CEF5;
	Sat, 25 Oct 2025 16:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761409156;
	bh=VLdLtuyN9J/eVRK6iiEAMD7yIBkR2JsLYXA2NVdJ7t0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pk9hxmBrepn/tWhel4qnBLd8/jTxh11/DjaKNVC17oiU52dWb01Aqid068v2ZRoiW
	 yVrhJLjvQfXp1Cnwqoza810SfkFj75yDR/X/A1QamUaJuoR5etkpTCcwXIzZEAhxRD
	 yZzkbn5Yy8Uc4RyoRlCxQuRq4JqQRqekIDwh7Bt9O8rhAo3oCq+LtHfwhraEkHxBE2
	 tvR+CKNT12rbJRbTntfTLTNoQy1KGTf97MBFkwvY6NQ/bNxOtOVRBKJVqSr2WiUyHI
	 rF2OLCfNEzYe9g9Ks8HjO3flbnwQU82kpcwqvGL7LxNAYILAh2q50wIB9jekHpPRze
	 w8TvC65YWYHUA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Anthony Iliopoulos <ailiop@suse.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-5.4] NFSv4.1: fix mount hang after CREATE_SESSION failure
Date: Sat, 25 Oct 2025 11:57:32 -0400
Message-ID: <20251025160905.3857885-221-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Anthony Iliopoulos <ailiop@suse.com>

[ Upstream commit bf75ad096820fee5da40e671ebb32de725a1c417 ]

When client initialization goes through server trunking discovery, it
schedules the state manager and then sleeps waiting for nfs_client
initialization completion.

The state manager can fail during state recovery, and specifically in
lease establishment as nfs41_init_clientid() will bail out in case of
errors returned from nfs4_proc_create_session(), without ever marking
the client ready. The session creation can fail for a variety of reasons
e.g. during backchannel parameter negotiation, with status -EINVAL.

The error status will propagate all the way to the nfs4_state_manager
but the client status will not be marked, and thus the mount process
will remain blocked waiting.

Fix it by adding -EINVAL error handling to nfs4_state_manager().

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES
- Trunking discovery marks the client as `NFS_CS_SESSION_INITING`
  (`fs/nfs/nfs4client.c:391`) and the mount thread waits for
  `nfs_mark_client_ready()` to transition the state
  (`fs/nfs/client.c:376`). When `nfs4_proc_create_session()` aborts with
  `-EINVAL`—for example because the server rejects backchannel
  parameters in `nfs4_verify_back_channel_attrs()`
  (`fs/nfs/nfs4proc.c:9438`)—`nfs41_init_clientid()` returns before the
  ready-state update (`fs/nfs/nfs4state.c:332`), leaving the waiter
  blocked forever.
- The patch adds a dedicated `case -EINVAL` that forwards the failure to
  `nfs_mark_client_ready(clp, status)` (`fs/nfs/nfs4state.c:2747`,
  `fs/nfs/nfs4state.c:2748`), matching the existing handling of fatal
  network errors at `fs/nfs/nfs4state.c:2743`. This immediately wakes
  waiters so the mount fails cleanly instead of hanging.
- The bug is high-impact: affected clients hang indefinitely after
  CREATE_SESSION negotiation failures, preventing mount completion.
  Delivering the real error to user space satisfies the stable tree goal
  of fixing serious user-visible regressions.
- Risk is low: the change is limited to a single switch arm, introduces
  no new code paths on success, and relies on long-standing semantics
  that allow marking the client ready with negative states
  (`fs/nfs/client.c:458`).

- Next step: queue this fix for all supported stable NFSv4.1 branches so
  mounts no longer stall on CREATE_SESSION negotiation failures.

 fs/nfs/nfs4state.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 7612e977e80b5..01179f7de3225 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -2744,6 +2744,9 @@ static void nfs4_state_manager(struct nfs_client *clp)
 	case -ENETUNREACH:
 		nfs_mark_client_ready(clp, -EIO);
 		break;
+	case -EINVAL:
+		nfs_mark_client_ready(clp, status);
+		break;
 	default:
 		ssleep(1);
 		break;
-- 
2.51.0


