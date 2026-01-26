Return-Path: <linux-nfs+bounces-18466-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EClRKthZd2maeQEAu9opvQ
	(envelope-from <linux-nfs+bounces-18466-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 13:11:04 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8A2880BC
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 13:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCFAB30495D8
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 12:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43546335542;
	Mon, 26 Jan 2026 12:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdTP9Q/g"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF4F334C39;
	Mon, 26 Jan 2026 12:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769429425; cv=none; b=HvDM79p9kuVnlG1ojTwxgejDFEouesMz6LEyvwlKCg/RgR2z/Kgpxrp77Sebzyxpgy1vke2gBzwwN/5CuDOeIrp0cF1NApwlFXleRf88k9yQgYwA7r9TE/OVvaeBzSoSCbjzkP4Adue+0nmKnaKxzku3/AFjOcIZiRrBefxN3Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769429425; c=relaxed/simple;
	bh=KfrEtZUoZ6DircrBOcjTPRR6eG2xyXf3beE9oVkhNIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ajgi/dEzjK+Ccr81dICN1j/6ceXsnJKMdqMvkN+5k07cOxAVim8vxkPokFXfcgWu54Dkznf+dyqDrfru9P6yb/i4E6EtYEeZCoiOkC7ykjwGFCZj20OtlBWfhzFn3YtaKKGjkua6xZfCzCYA67kKxWl2cyj7nf+4QGPqgM15IC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdTP9Q/g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3944DC2BC9E;
	Mon, 26 Jan 2026 12:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769429425;
	bh=KfrEtZUoZ6DircrBOcjTPRR6eG2xyXf3beE9oVkhNIE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AdTP9Q/gyu/uQqaOY3ScijbWsgrLlooN2pOwQeD6Efb2mKUNrMr4oMWiJq993lSN9
	 erxd+UQg1eaAXY2vewjxMSgsEFEIBWFPLigpxKD5Dk5OKpeaerUWocZxnsimOCPbwN
	 wth1f9LQ0IZR5ReEU1ocAgbK2NhAD+IOuXJMh19VmSMbwD0Nypi4iLvwb/ypsL+gBi
	 lKFac8FrIwN2TXdVVl35i6pGiNTL4ikTsGdrhe/rgVQe4EQP07GdvKrMMroOusjf1O
	 x/kvwl/OdVAImQH6VzKgeysRyT09mIP2RN9/touSIBMbKlLHyXcmdmrOP7IZvpoMWn
	 dz/8IzNiPp/XA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 26 Jan 2026 07:10:14 -0500
Subject: [PATCH v3 2/2] nfsd: remove NFSD_V4_DELEG_TIMESTAMPS Kconfig
 option
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-delegts-v3-2-079f29927b83@kernel.org>
References: <20260126-delegts-v3-0-079f29927b83@kernel.org>
In-Reply-To: <20260126-delegts-v3-0-079f29927b83@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2269; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=KfrEtZUoZ6DircrBOcjTPRR6eG2xyXf3beE9oVkhNIE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpd1mtSMJE5UPnf9Uvba/jF8fPowD2UlX6iriR4
 hP3mslD5WmJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaXdZrQAKCRAADmhBGVaC
 FWUMEACqbxa6m+QkuVCCCMhrMGOF/ZBWEaXlhFhmXX3lLBiGrbS3iNnm9ZGke/O3Idn/H3VysUm
 Z3Aan3E0FRAaxmSUHtv+CwuRN//94mGX+dkYMUusoFbALX2+YBtYnMafqlIx6ojncpAowkcBqTl
 ADC1eO6/nD2KJncFunkZFyfxBjh6GVvpk0u+YMLt8jQsxwLosOx90XElWtpV1o4XDy6Yvlk0JBD
 LctF+Tc4Ubq7OhC5frp2Af2jw9EMu05caC08oRr7I7l7+cBdVUBPGhljxEqoNBWhiudyDx4MSh0
 GwxIum9rJMhuUokTMDJxnM7//PscwHmUMk5Afbod1EsO3LwDtxG5DJKnEhKDl26YtOX2erHCw9s
 u6ugryOXCv5uzv937dwCtdtt2xnzADeLvdisXk8WYxH0r9G/l1XhMNJhjQv2v/ozDF1cN6IQ0eZ
 xCEXouE/UqdpXoCXXs36EvSTvTsMiCSJ2Vhy3QXKP5Y0yhotr2IstLRoJ4acy+CfxpTX0Z7hXWV
 VN+cTJZcaD28SOXVVAyOkfWMyZhLnv+y/AmeboUG+u/aPYp6tuw0xE+ChKf5UPbiDtcArS410FX
 oeLynFns85LmZWpZNT9310QZekqQ08phJcFZ4MDpso9SzifWEzXjrTssT+Hk7LICpAcU8vGYq3c
 Not9NSyW+3T59Vg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18466-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E8A2880BC
X-Rspamd-Action: no action

Now that there is a runtime debugfs switch, eliminate the compile-time
switch and always build in support for delegated timestamps.

Administrators who previously disabled this feature at compile time can
disable it at runtime via:

    echo 0 > /sys/kernel/debug/nfsd/delegated_timestamps

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/Kconfig     | 10 ----------
 fs/nfsd/nfs4state.c |  7 -------
 2 files changed, 17 deletions(-)

diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index 4fd6e818565ea24e4e16844a3f82e808dbc558f8..fc0e87eaa25714d621aa893c99dabe4ce34228df 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -177,16 +177,6 @@ config NFSD_LEGACY_CLIENT_TRACKING
 	  and will be removed in the future. Say Y here if you need support
 	  for them in the interim.
 
-config NFSD_V4_DELEG_TIMESTAMPS
-	bool "Support delegated timestamps"
-	depends on NFSD_V4
-	default n
-	help
-	  NFSD implements delegated timestamps according to
-	  draft-ietf-nfsv4-delstid-08 "Extending the Opening of Files". This
-	  is currently an experimental feature and is therefore left disabled
-	  by default.
-
 config NFSD_V4_POSIX_ACLS
 	bool "Support NFSv4 POSIX draft ACLs"
 	depends on NFSD_V4
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 2251ff43aac8ef8a3d01d7094d40f9b2604763d6..f105ca19815f97c1dd042bbf9a543c1cc3551282 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6047,7 +6047,6 @@ nfsd4_verify_setuid_write(struct nfsd4_open *open, struct nfsd_file *nf)
 	return 0;
 }
 
-#ifdef CONFIG_NFSD_V4_DELEG_TIMESTAMPS
 /*
  * Timestamp delegation was introduced in RFC7862. Runtime switch for disabling
  * this feature is /sys/kernel/debug/nfsd/delegated_timestamps.
@@ -6058,12 +6057,6 @@ static bool nfsd4_want_deleg_timestamps(const struct nfsd4_open *open)
 		return false;
 	return open->op_deleg_want & OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS;
 }
-#else /* CONFIG_NFSD_V4_DELEG_TIMESTAMPS */
-static bool nfsd4_want_deleg_timestamps(const struct nfsd4_open *open)
-{
-	return false;
-}
-#endif /* CONFIG NFSD_V4_DELEG_TIMESTAMPS */
 
 static struct nfs4_delegation *
 nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,

-- 
2.52.0


