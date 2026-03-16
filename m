Return-Path: <linux-nfs+bounces-20200-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iH9SGQwhuGmdZQEAu9opvQ
	(envelope-from <linux-nfs+bounces-20200-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:26:04 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E2029C46F
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 085E6302F41A
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 15:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6574D3A1A3D;
	Mon, 16 Mar 2026 15:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXekFBNV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D503A0E93
	for <linux-nfs@vger.kernel.org>; Mon, 16 Mar 2026 15:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674214; cv=none; b=etbZUMK4U7md5ja5BaAAqLpA4bKzZPdeleQdlT8eIcoFQ7xD53ArMDhWmDP8wKDS9Yb7nVXWYlqP2ITTikmS94IdlPzE2yA3Ybt6xDokzi1tLot+xZ37vyb3/yYP++wAdESJ316yon/5+Lk2WeGIyeA1Vdzm04v97DJCNjc0rHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674214; c=relaxed/simple;
	bh=5A+kLhVNZ2qlVMYbUkQXjIkvKmsxaHN+v/r0IB9+PGs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gX+3rHPDLiIFj1ed5Cmfmh97MgAm4dmFeld+vgDxczWsf8szPO5dCeU5VziUPSRuDCAlBnsPtHUZko0hxQ7jLzZe55+u5glLhfqx+rGolrnPblx3kPhNt5zC2X9sQxck9ZJrb3ovFCTao9EocOARddTGmLaIC30AABa5sQghoYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXekFBNV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49FC4C2BC9E;
	Mon, 16 Mar 2026 15:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773674214;
	bh=5A+kLhVNZ2qlVMYbUkQXjIkvKmsxaHN+v/r0IB9+PGs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cXekFBNVYBgt47dSgcaoLQLfLPUv/hLMrHGmgMGtAvHBP5zFoIICSDdDdkqZQjzFB
	 /q6tIiPCY8MaFqfJEd4rnqZcUGZILDtUmxf3s7+rCSWhEHuuwtehbvnYog5z+nKtqG
	 +7YDWBTdelGwc/FGoeFEOfX1tfxzY6fFL9VAXLKOYRdhZnV6461Dr8nw4KeWZlj2o1
	 Y6uGF9px03wTWjTd7L/OxLVB0w3P8eOByROhA88XoLHHp9YmovPVYkAb29PWbaCYHM
	 usTrE8u5++K5U6w6xorhmgAghoIGfoHRwBbEHON5COrNpuQwKeWa/YAhIzbumskXTh
	 ksBMxAW9QCMfA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 16 Mar 2026 11:16:39 -0400
Subject: [PATCH nfs-utils 01/17] nfsdctl: move *_netlink.h to
 support/include/
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-exportd-netlink-v1-1-9a408a0b389d@kernel.org>
References: <20260316-exportd-netlink-v1-0-9a408a0b389d@kernel.org>
In-Reply-To: <20260316-exportd-netlink-v1-0-9a408a0b389d@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1586; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=5A+kLhVNZ2qlVMYbUkQXjIkvKmsxaHN+v/r0IB9+PGs=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpuB7fLeCI55UecJAJybU4xEqmYYNvhkD761ay+
 sVT/OBs8ACJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCabge3wAKCRAADmhBGVaC
 FTjsEADMK8YVVNFhptLa979K7a6RO8RgNWQbR9LIGc0PTqjrcroYlRGpeMKwnQt8wkSostBh2wF
 uIGh/X5dXCll4sGiEZFpFQRm/yqrww0Sca0kkvDOE57ou1rbvnigUXi2qpmrCcr/yhpR9DX43tI
 rCHsH62w4FwTuPtA2uN87VCWMK0rjCJoPpxBr+uqWaa+jyweVQlvH3/s3oTsmz4WVe30CbNzxoe
 TZj+yQA7vpItPN/w2XQ3Ld6TokJSf2vBF7bD6zOxBqwnIo8THljjmYnB0zaMp9RN2gB+GIPke7N
 jLfisiIM+O5swWfzIOGExuwHD5UPrhBLecXMcnNBGgZ1mfqN7s9+SowmQvex/qh/jGT6xTtRmXL
 /5L+y2ULDixQISLb57blIgq4rUJzZy/cLU2gNrM2+rrp/9TC2tlhKb97rs0D7AWaP51WVX0m/5Z
 gjG5ZV8c2HxkodHgQOpPCAWSoIU24B9LiJByaV7jQRxFNwvLy9l0KIWrFI6KYVLzhw3RyeH9UeY
 GEU+RSilD+KqhEeyieD+2rztsrVAJhBG4InDuqft9in0kzsgZpWfSzE1rUeuC3msFJsHzBNPCmE
 FcZgnVPSUEYVfgR7ycmy994YG20qKgSUrJplKmgiKH3x2m/aOp2a5j28KEu0dd7YOkmou9JKxyk
 x6AcQGgKuJ906kw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20200-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,makefile.in:url]
X-Rspamd-Queue-Id: D5E2029C46F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move lockd_netlink.h and nfsd_netlink.h from utils/nfsdctl/ to
support/include/ so they are available to other components.

The support/include/ directory is already in the default include path
(via AC_CONFIG_HEADERS), so no source-level #include changes are
needed.
---
 support/include/Makefile.am                        | 6 ++++--
 {utils/nfsdctl => support/include}/lockd_netlink.h | 0
 {utils/nfsdctl => support/include}/nfsd_netlink.h  | 0
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/support/include/Makefile.am b/support/include/Makefile.am
index 631a84f808ae9f2a13d9539c70c09670c5ef0ff2..2b45e56b044c35c0e7a11aec5f583d600fcae6a0 100644
--- a/support/include/Makefile.am
+++ b/support/include/Makefile.am
@@ -4,13 +4,16 @@ SUBDIRS = nfs rpcsvc sys
 
 noinst_HEADERS = \
 	cld.h \
+	conffile.h \
 	exportfs.h \
 	ha-callout.h \
 	junction.h \
+	lockd_netlink.h \
 	misc.h \
 	nfs_mntent.h \
 	nfs_paths.h \
 	nfs_ucred.h \
+	nfsd_netlink.h \
 	nfsd_path.h \
 	nfslib.h \
 	nfsrpc.h \
@@ -26,7 +29,6 @@ noinst_HEADERS = \
 	xlog.h \
 	xmalloc.h \
 	xcommon.h \
-	xstat.h \
-	conffile.h
+	xstat.h
 
 MAINTAINERCLEANFILES = Makefile.in
diff --git a/utils/nfsdctl/lockd_netlink.h b/support/include/lockd_netlink.h
similarity index 100%
rename from utils/nfsdctl/lockd_netlink.h
rename to support/include/lockd_netlink.h
diff --git a/utils/nfsdctl/nfsd_netlink.h b/support/include/nfsd_netlink.h
similarity index 100%
rename from utils/nfsdctl/nfsd_netlink.h
rename to support/include/nfsd_netlink.h

-- 
2.53.0


