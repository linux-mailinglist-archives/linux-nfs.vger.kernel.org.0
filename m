Return-Path: <linux-nfs+bounces-19078-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIEHIQb8mWnvXgMAu9opvQ
	(envelope-from <linux-nfs+bounces-19078-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Feb 2026 19:40:06 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2EF16D8D7
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Feb 2026 19:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5A03300650B
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Feb 2026 18:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF772D3225;
	Sat, 21 Feb 2026 18:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tv/VySmk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFDB7263B
	for <linux-nfs@vger.kernel.org>; Sat, 21 Feb 2026 18:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771699202; cv=none; b=WXWH6xBiGtY7BPo3k7Ns7GnR6yenwy+BndNV6fuTdfSZaL+qCYRFgQO2AyQ8vRukWTT9bCfWPQ92msaBwnY1LbhyglJRRPMAw0ApZW4i6esntnh6i1VwhTCZV8LjVwS7Ajqm8mtucNt8KVpjh7MR1lUsjJooMOUf0NkXiQe5ZWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771699202; c=relaxed/simple;
	bh=UDss4PqNurn+HyznqmX79jBZWJb8O8k6bnq9AIzdG2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SfZ2kvPCB35luQ10RR4woS+v3qns7anvmvglUKIi61yv7/Q2i97tEgVBn9h1JYBlNiALNvkWcTcfJAWktxsaN/njV7d0gaTkzCrFBGr37ZGmsWc6f5/kMOBxZwwzrQlYfzqwwbRLn6+qzm+oeUOMSytkU4q66wwbVnYjLwycl9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tv/VySmk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1900C4CEF7;
	Sat, 21 Feb 2026 18:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771699202;
	bh=UDss4PqNurn+HyznqmX79jBZWJb8O8k6bnq9AIzdG2g=;
	h=From:To:Cc:Subject:Date:From;
	b=tv/VySmkOQcLcbGcoiLnbGPPU2O1ewc6YZCapFZbwfPN/0F9VLvgXfA4jWtnPt8Qm
	 K1Nbb7ufUo2ZRKOs26N7u3hu9UhyPYRvjMZqDR5cjxgVkZA92L3mmN2I99IhrfsUnl
	 zE1LIThxJl4e0QPyfvyeyYH+IXNeNOKf06zDCBnlRZQCcaxPiq+NFlArepr1DvdOeC
	 OOmVOg8fuLuIAsB2Koy7eIm+nonNap+257uH05m3nzoJxNsikfbOhsbSmF9B2A0Fq3
	 3/dfIMo7ij3h3+6uh7qHYHfAWyn6Dj4WP5I2faMZMd0GgNh4sokxiUFr0OPBbzigrx
	 JRiD689EstHGQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] sunrpc: Add XPT flags missing from SVC_XPRT_FLAG_LIST
Date: Sat, 21 Feb 2026 13:39:59 -0500
Message-ID: <20260221183959.7672-1-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19078-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: DE2EF16D8D7
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
index 750ecce56930..ff855197880d 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1933,7 +1933,9 @@ TRACE_EVENT(svc_stats_latency,
 	svc_xprt_flag(CONG_CTRL)					\
 	svc_xprt_flag(HANDSHAKE)					\
 	svc_xprt_flag(TLS_SESSION)					\
-	svc_xprt_flag_end(PEER_AUTH)
+	svc_xprt_flag(PEER_AUTH)					\
+	svc_xprt_flag(PEER_VALID)					\
+	svc_xprt_flag_end(RPCB_UNREG)
 
 #undef svc_xprt_flag
 #undef svc_xprt_flag_end
-- 
2.53.0


