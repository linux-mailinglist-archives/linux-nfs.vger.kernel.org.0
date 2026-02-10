Return-Path: <linux-nfs+bounces-18834-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKdCKdJai2ljUAAAu9opvQ
	(envelope-from <linux-nfs+bounces-18834-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 17:20:34 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D10611D0DD
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 17:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3BC23021EBF
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 16:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FD33876D7;
	Tue, 10 Feb 2026 16:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJ6fXyTQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747042E7BCC
	for <linux-nfs@vger.kernel.org>; Tue, 10 Feb 2026 16:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770740429; cv=none; b=f7tZSg3ZCcOKAYs7CNQhQvtNnh3TL8YVtdqjH9AUaCIL7d8YvMq5YW/lWgObq7s/PZR3+BbDeZW+7c3mrakXk/ksxjysUXp1DkT+1YZMP28Srt7yd6ULVPGDmMElGuDgRUePV6x0+WC/O0hxHx3KYUlJTmyRze+zAC0p6EhSmvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770740429; c=relaxed/simple;
	bh=KTTZfisyPNfmI5zjY3QWGOMwdJXkux57lRtI27Ph060=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=flJGzIB9yiNrDWcKtqYLHRBFvIDHbIAgKtuZJxh4BBtLvS0BZQ+56CHfLCffOvKF2VvAvDRHpF9HYA6Aer0ieIpRpkJezZgGDQAzB3Yndksxf8UzIPaUkGtWBwjwpHKiH8l+ZvMb9C7JuCqelxUjpNX+XfEL7kp3aqCuVTuYkKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJ6fXyTQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73CB9C19424;
	Tue, 10 Feb 2026 16:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770740429;
	bh=KTTZfisyPNfmI5zjY3QWGOMwdJXkux57lRtI27Ph060=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kJ6fXyTQ1iFVQkMWCp3maAFycLnoe34Rr5I9RmDqHMqOrWjQw4JFujN25F1AO52vp
	 jKCEYkneCFFd9Diy4pZGKLZSplok21WkHYuoG/Bp9fRoev88KQGMmIOyLuI8eqVq4N
	 y5xSB5Ib5jr1Fg+dspgCyCRFRomn/M+ZNpF94IPJbXxuy7faNkC7smFgJdM+mbHPnw
	 Zqsu0RS1TcgsczXqKvjYF0Jno3f8Bav5ffCXUaUdrhN/4PgbGD4TO8Co0GrtJGnNAZ
	 OvQQ1xO04q/mtyCymCxFrpNf4nrT00gyT4QmKBEpAf37Q3IOWloOtCcAMVjzZmFHIH
	 HpQK3Sy1EUnJg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 1/8] sunrpc: Add XPT flags missing from SVC_XPRT_FLAG_LIST
Date: Tue, 10 Feb 2026 11:20:18 -0500
Message-ID: <20260210162025.2356389-2-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260210162025.2356389-1-cel@kernel.org>
References: <20260210162025.2356389-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	TAGGED_FROM(0.00)[bounces-18834-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0D10611D0DD
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Commit eccbbc7c00a5 ("nfsd: don't use sv_nrthreads in connection
limiting calculations.") and commit 898374fdd7f0 ("nfsd: unregister
with rpcbind when deleting a transport") added new XPT flags but
neglected to update the show_svc_xprt_flags() macro.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 750ecce56930..076182ae19ec 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1933,7 +1933,9 @@ TRACE_EVENT(svc_stats_latency,
 	svc_xprt_flag(CONG_CTRL)					\
 	svc_xprt_flag(HANDSHAKE)					\
 	svc_xprt_flag(TLS_SESSION)					\
-	svc_xprt_flag_end(PEER_AUTH)
+	svc_xprt_flag(PEER_AUTH)					\
+	svc_xprt_flag(XPT_PEER_VALID)					\
+	svc_xprt_flag_end(XPT_RPCB_UNREG)
 
 #undef svc_xprt_flag
 #undef svc_xprt_flag_end
-- 
2.52.0


