Return-Path: <linux-nfs+bounces-20516-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJZnNBF9ymlo9QUAu9opvQ
	(envelope-from <linux-nfs+bounces-20516-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 15:39:29 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C2235C212
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 15:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA3E93013DE6
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 13:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C75F3D5239;
	Mon, 30 Mar 2026 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRQSllAC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153AD3D5221
	for <linux-nfs@vger.kernel.org>; Mon, 30 Mar 2026 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774877924; cv=none; b=ZI6EXeqLHIoMxnCyQGaqRAf6f5oO6KyJklbFoDH7dTUq5EUSMN1S9pAg42/AqGIrW6gxn7bSl5MC8Egoduz7rA19l6kgs+pVfMTmuWbEUSDg4XHex19YltshkKwueSQya5hKFb+k+fGlVrOHCzNCpng8o7PYSDlnVr4+2Iz7hys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774877924; c=relaxed/simple;
	bh=5A+kLhVNZ2qlVMYbUkQXjIkvKmsxaHN+v/r0IB9+PGs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X4giV5hyAUV93UWFLWyTAn4kOnvwVIRgzu2dJ6kPQPeEHIkJfs6WSJPtbWhNycVwZoRlLCC4xyO7MZtCj2kTCkM6oFXeRl3WKt1fHUAIEZMvPA54NIk8q2cdrd0jf3ydoSUdj//AM8CIraPdn3dQ6RGnW4RNdk94C7qIBZkGdLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRQSllAC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0926BC2BCB1;
	Mon, 30 Mar 2026 13:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774877923;
	bh=5A+kLhVNZ2qlVMYbUkQXjIkvKmsxaHN+v/r0IB9+PGs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MRQSllACu6le4FaarwVAdx5LMScRtChkmHBklVK/ox7/dy5cOmD/ZVlvTjD4X6Qla
	 7rINXE8ECEuHODv/6l/m6yBR/sWwbhXMQRiIl/HH8+Ab62rDGCjBuORJbVCTo0lkOn
	 f7+lEr/zc4zjdjjspv3A2EpqbUcY21vZQ29clmjvF1CDG4Mi24iUpocNpD45y5tAlo
	 Ip8BKgI9gGO5myOx26cWUYunjAYE1dMzTTp6uXqKR/qaha2C6ssHpvOOzU3UZaBpoE
	 jfDXmUz+QD3NVL44+AIicmZrqCNZl8u5LtBPZqwI16RE4a9nLvm8ijmCfh54+zCr3n
	 /tl7JE9tp3OXw==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 30 Mar 2026 09:38:21 -0400
Subject: [PATCH nfs-utils v2 01/16] nfsdctl: move *_netlink.h to
 support/include/
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-exportd-netlink-v2-1-cc9bd5db2408@kernel.org>
References: <20260330-exportd-netlink-v2-0-cc9bd5db2408@kernel.org>
In-Reply-To: <20260330-exportd-netlink-v2-0-cc9bd5db2408@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1586; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=5A+kLhVNZ2qlVMYbUkQXjIkvKmsxaHN+v/r0IB9+PGs=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpynzd2AMXI/c5el6ati30UuOlaLB8gt9EZt7J1
 LvQzV1cx/CJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCacp83QAKCRAADmhBGVaC
 FfE6D/4ulQRzghvoN5HDp9g2wMCl62c3IFVyQhQs/wALejm9TpfecXHBsdsev5DT6gWBn/tSq7i
 B8Kuzb58oNlHydiq3/dqVvZqkkdxl6gtJ8scPPg3WjSj8V8km7RG5ZgHjAr2LpQHGBoF1zHkDCU
 qFtp6oNy7MX2pPKvAkwoK/eyq//pjadr/8iFfQGQ59ac2gbUNRMWDXq5d55v3t//PvaqffMiO9r
 mcEyZLSN2wm9NTQQW4NmEpdc09OyKQ0kPTiRtPTAwCN+5Vcl8OSbLyNJDBX7bACi8mpGUVGasZK
 r7YYDBSQSNWF+1D3pELHWgUNeEKNkkrZWHwuaVPeXsFUXFFSPSQxKN+zBJTkYsCljkNa9O6bdB4
 vd6V5Fy8SqtuuFme8cUE4UN8rHKLIF4Mc+ni1+S5ORZACfv/GmgcMwg0aoGb2xbj5Ysbik2BBHn
 0OfjwNUYG5vMo7MTmaZKVyk37xET9/5+nY+uPYq18qYJXjYqXI3j7h4jLN5lebyzwmSkjoBkauo
 9uqOYnzJKZMI1q5wpC7aN2QbJtlTzZdXZ3rZY/Kyo+FkzcCxF106b1Ib31XC1pKjkENXj3m4+3M
 BGHfylSMt0abBopK7DMZIjpKhl/DplC7fNU9iyU6BMDWxyisDrKj+WWawLovW2XCJWbUI27vEGM
 ns6vK9KXBrxul1g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20516-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 89C2235C212
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


