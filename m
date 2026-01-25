Return-Path: <linux-nfs+bounces-18444-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLr6K34LdmkNLAEAu9opvQ
	(envelope-from <linux-nfs+bounces-18444-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Jan 2026 13:24:30 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8E080847
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Jan 2026 13:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1891930053A7
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Jan 2026 12:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C4431A57C;
	Sun, 25 Jan 2026 12:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvdHByHR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4BE191F91;
	Sun, 25 Jan 2026 12:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769343865; cv=none; b=OY7el01dT3Psac8Nw8zyOnfdCo/0GmeWoyi4ublwQv3J0dEIywEfr0G0R4OzKeb5s+zpwsjjXipfMnNRDzEhLf2NaoXefsk49g0OQqswRbB2ej8YsHTrOfW506xbm1q9r5iMUeVg1Q5w4U/uvJ4tzAiiB7CcKrh5NU1wpMQ1bPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769343865; c=relaxed/simple;
	bh=w1HVPyRUR5weJ6460gobTVT6mMvjOJvs9NQCdhVhScU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=k6/Y+b2cy9HyLLKrNXO4ZpbjiND8YRebPH9NmBNmCImpiq7IPzSjbj+VCu2/I1c2eFubxsCprE/BYMWZSDVBYVUBGq89N5oKx+D07wAGpR5EE726ZHDaTuSceVM57Sb4CLm54fzyU9OKZJReZn9AFHxL7vrXdVw5dpO7ru+iTf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvdHByHR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9646DC19425;
	Sun, 25 Jan 2026 12:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769343865;
	bh=w1HVPyRUR5weJ6460gobTVT6mMvjOJvs9NQCdhVhScU=;
	h=From:Subject:Date:To:Cc:From;
	b=bvdHByHRADgf6exXh67SNOreHrf8pXPI+pcXov4pS8Id82LE+SaRAWwlFMExXlUU2
	 bsJbTf+O7cgteBfA/xwWFHlWl2xrF+9l7uiN6lPo6yrBwEdvIdJMntwvOxWMVW9DHC
	 I0KcA4SObbL5drLeavHqF1zXy1rwx0dh+QYObZv7wMuJj6HF/D0SqdQnckikS3/kUT
	 UFbpl7zZlXrfGs3/jbaCN5joaH7Wa9WS+dGkF8g4iumkjPPPEG4UtHRJYdm11O5Vz1
	 Oo+McOZ9NaHUK2j5KUMkFBLK8WExOQvEJO+nRSFdbWmO8duowtcmoa9DYIznVzttWB
	 Y609Ljxz/z3KA==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 0/2] nfsd: move delegated timestamps to being runtime
 disabled instead of compile time
Date: Sun, 25 Jan 2026 07:24:12 -0500
Message-Id: <20260125-delegts-v2-0-cd004157fb46@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XMywrDIBCF4VcJs65llGovq75HycKYiZEGLWOQl
 uC712bb5X84fBtk4kAZbt0GTCXkkGILdejAzTZ6EmFsDQqVQamUGGkhv2YhNaJB687uaqG9X0x
 TeO/So289h7wm/uxwkb/13yhSoDjhNAzyglobd38SR1qOiT30tdYvakFAQJ8AAAA=
X-Change-ID: 20260122-delegts-150060ac7c9a
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=958; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=w1HVPyRUR5weJ6460gobTVT6mMvjOJvs9NQCdhVhScU=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpdgtzhwtBEW85Vid5HJfQlR+5FPv9x1ZkFxhP+
 gY8gI10GEeJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaXYLcwAKCRAADmhBGVaC
 FXRHD/4/r5lhdesKGf9nSSFr9jbYmAwWI4Ufh02M61AQG1117AxBTSt6mD3uE+Ee09q44/0gOQe
 sfTAHw/WLKw2rvq+hNNBStXJafBolDQMGXpvU3Ns3x+a8E42G/OcFP7zeBDKCvZQTZj9YbqkNKk
 l4el0LuJemg0mJoxH3d2TMS5GM8w+BrNtMHRwqDbR4IWHA2WkyHwbYjuWV0AlSNMVoytqLjfibN
 QVP/0kcyV3kNRULcWnmRqS3OrfZml4Jne//KVki+pgqV3LHW3b5u6m0Qs4t264yTR/6k1i6H49h
 CYTAT6zjkGfTnFqdT+emGQfUY9IeFoje3jydYo9VpNgJkOfUlBHquDIDP73u7FfBXth17avB+OW
 7W3Gtt24ZK5BlTm7d2LgmK2rVJ4C4+EysNPseeB7FV9v5pP7pLdZWPgawfIlpcg7OsWXZNW1/Y5
 y3jEIi3TMKVbkizahuJAgwM+yvQCM3LdpEbCEvfXqR2W4NNZO68hCc7u1lFCFj1r/+HVD3IOFcz
 HgxJPn9G66z5ZfAPp46lNLz8+C7AU6xAK9VQKhu3WtRIacvmQZEFwf/zZfRXqusPiIKhrnikQYn
 cIGHticoa/+DH9S7pmNsuRuEYMO5BC6Kda2tAQZE8p/RCHCwHeXblkVUesXuMprzekpnk8kh3Du
 I6jvgoHgVdD/nCw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-18444-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2A8E080847
X-Rspamd-Action: no action

Small update: The kernel test robot reported that this didn't build when
CONFIG_NFSD_V4 was disabled. The fix is to compile out the new debugfs
file when that's the case. Resending both patches, but the second patch
is identical.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- Don't create debugfs file when CONFIG_NFSD_V4 is disabled
- Link to v1: https://lore.kernel.org/r/20260122-delegts-v1-0-40fbb180556c@kernel.org

---
Jeff Layton (2):
      nfsd: add a runtime switch for disabling delegated timestamps
      nfsd: remove NFSD_V4_DELEG_TIMESTAMPS Kconfig option

 fs/nfsd/Kconfig     | 10 ----------
 fs/nfsd/debugfs.c   |  4 ++++
 fs/nfsd/nfs4state.c | 11 ++++-------
 fs/nfsd/nfsd.h      |  1 +
 4 files changed, 9 insertions(+), 17 deletions(-)
---
base-commit: 2a1dde6dd823e94e0768e929566dd65cd74ca793
change-id: 20260122-delegts-150060ac7c9a

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


