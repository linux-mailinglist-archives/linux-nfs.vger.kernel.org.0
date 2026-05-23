Return-Path: <linux-nfs+bounces-21867-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGAzFynTEWrvqwYAu9opvQ
	(envelope-from <linux-nfs+bounces-21867-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 18:17:45 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB3B5BFC2F
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 18:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CCB33014654
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 16:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5362C235E;
	Sat, 23 May 2026 16:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfWQM52A"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D34221FB6;
	Sat, 23 May 2026 16:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779553062; cv=none; b=JOlneQYt1ziiKgqSc2GZWFDhmkc+4/x7wpFoCaPq8CJg+EoL05QcxtXDKy9NKF4jaoNqQmcgYOWnkAYl5qWWpt2/+dQScRvGfMpY8po3M7a99NbHkx8DBz27Y+1M28cLrIynAiBZRoIzXwi9U2x7Lu1sAPHCudKd9toGoOJXf5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779553062; c=relaxed/simple;
	bh=NWZu26HG+LtrMwiaLZ+diFv1o6LuzDt1ia43NoHxK/w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FXWS+EwESOnMgxHIfBT/eoUZPzYuUBodyIFa3wu/efUOysg68SWUg/0bRD+s6al9Wuo/JY6e7gt6F7adHIBfPNiuFeHKY/KaD0pcFHWK7CS3NWpi8Z6q2b9KD3N21I30AnfdSeDJaCjUI4Z/0ipVj/Iu33ECxhK408ggEQDwZDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfWQM52A; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1029A1F000E9;
	Sat, 23 May 2026 16:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779553060;
	bh=mC2QtNjKdyEsGVmvf3eGva20w5Iy4Zdph0R4VALrXdI=;
	h=From:Subject:Date:To:Cc;
	b=DfWQM52AwCItEDBhWH7x7ab8vwwmySrXXqodpyxoiN8//LQk/x8Wo/MCfmqWAcHU+
	 a/MpCw85XPPl9MaCRmNPAFlsYxhnQAy/vTtaI0wPTVxvyGePnhSBsyHlwOX6Dzs5Y4
	 93lJCLyrd3jnlkFm6wFCJcpagEA8u1onrzoNA14iRzycMb9OtTr0FRcM6rEEHix57I
	 aSq59cfsUzpaEdqNSRc6bEz381+x3sqyFG8nsxkckN9+HoQ3m9qNHLKe6r2p3PP4q6
	 lAbDXP+8l7K3agruG7EEepXCNsjfKDX9Z46FKXuy/mvtI0kbSWO1BUdu/R2qfDUDGh
	 37v5GMYMuO1nA==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/4] nfsd: follow-on fixes for directory delegations
Date: Sat, 23 May 2026 12:17:33 -0400
Message-Id: <20260523-dir-deleg-fixes-v1-0-142c884f85ce@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3L0QpAQBBG4VfRXJtaw27yKnKB/TEltFtS2ne3u
 fw6nZcigiJSV7wUcGvU88ioyoLmbTxWsPpsEiPOWKnZa2CPHSsv+iByI8b6dhE7wVG+roA/5Kk
 fUvoAJrW0oWEAAAA=
X-Change-ID: 20260523-dir-deleg-fixes-4205d8f25be6
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=835; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=NWZu26HG+LtrMwiaLZ+diFv1o6LuzDt1ia43NoHxK/w=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqEdMiDdM5aCNBxB4FbJhGMqf6MfRahhWY351KH
 OX0nUbGYNWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahHTIgAKCRAADmhBGVaC
 FVZaEAC/Pv89+ACMkyDTekhvdGSXIT3DbSRokc9STdeOl5j24S7F83IYZGEBD1Tw/qqWVRkC55s
 oVxkrowfuUWR1Xy4UHz1YIgaZ3BokWaFsTBjK7GILIVA6PsWvUFzEjTNlnLeUPvoKMq2QXC/X5M
 ilgF+jRLTZh1lOXgi8G42AtKJkoUOfWze7XdvFO41ZJM0XvEJmvwkTGRgxk+9/bwZcRuItUZgTz
 yL++t6101P6wsn4H/cMKWdyC4oDsuMqRN7t+c8H0MYurQ80b5B2mUGolNygpfDT1k4jOM9Mdqlk
 vuf1oumDnRYM076/JgfzaC5jzkMwl8hQbfa8dhu7Q9+PaOX7Wi23ZFBXFNS/k5d2HBJN0YUozOL
 9wk/ZySPv8VUYp4/BGHzGtIkkBbOqmi8UskV3x/dksaEUVjx/M19EuAL8ixfVtZDxaprD+XPxFu
 ecRSzyCYEhQtvrECuXG+0Gqa9ceve85t9JoZX/eYQ7qMOcN/vHsQHFzb8My8KSXi4MH6BII1Z4u
 iDFjajaFoxZBPvSPVKVYnQ85OsKaWIKnpB/jN57lT7zxnw0wLuEvxcfvamSSNGXhzvb2hAqhLJS
 bMtuBRvChMXiJ5TrkpGAXBVR4hi/pd8Y2xgSjeuwkm/jIvM5WlnELaWquQQJYJA03nldhgeqTCH
 K4Qr0FW+bWGgOtA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21867-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: ACB3B5BFC2F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Just a few small fixes for problems that Sashiko noticed flagged during
review. None are super-critical but it'd be good to have them fixed
before the feature ships.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (4):
      nfsd: check for FILEID_INVALID in setup_notify_fhandle
      nfsd: use empty string for directory name in NOTIFY4_CHANGE_DIR_ATTRS
      nfsd: check delegation status in nfsd4_cb_notify_done
      nfsd: fix ino_t format specifier in nfsd_handle_dir_event tracepoint

 fs/nfsd/nfs4state.c | 3 +++
 fs/nfsd/nfs4xdr.c   | 9 +++------
 fs/nfsd/trace.h     | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)
---
base-commit: 479723a81683c7a5bdaff48ec6968fad3ac1ae24
change-id: 20260523-dir-deleg-fixes-4205d8f25be6

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


