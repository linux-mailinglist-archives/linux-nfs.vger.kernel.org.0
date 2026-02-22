Return-Path: <linux-nfs+bounces-19096-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAMCIcAsm2llugMAu9opvQ
	(envelope-from <linux-nfs+bounces-19096-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Feb 2026 17:20:16 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDD616F9C1
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Feb 2026 17:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F369E300CA16
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Feb 2026 16:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92812EC560;
	Sun, 22 Feb 2026 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9HPR9W6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C752025F994
	for <linux-nfs@vger.kernel.org>; Sun, 22 Feb 2026 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771777211; cv=none; b=r5lE16ebtIG1KYV2pXckCiM/rHAJvnOSpMv5IIq85ki2kbIppWDg4nGy7VemCD3vQ8apStwMHSV0d2Oc7NwHWqOW0kvBtyWkqiU7Sk9x47Nzg3ru/Du1GTNPf/YxiIyTaeWoPn6kooHZFQsNMM3Zt98TdVsbMaykj39a55g6xbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771777211; c=relaxed/simple;
	bh=vHB9blp+IHH8GWFcNLiUfN1bKw+tIqOCbQNV2sHZD5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ORV/hHcck8kO2BXyehpJpJP10Up6W8pCTTTMv2V1pbsJx8/KfRPbhFldQ5cf5MDN5429YuBTf4LwGgmolzL5wYcO4Y3+qFNvlqxsoOPBoh/OkCn/gIIYG6Y8FXiv2YJ3xQM9BLphj84ZyVLYgG1/bJAnTcE7Lgj2jwVJd2D5DUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9HPR9W6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9F7C19422;
	Sun, 22 Feb 2026 16:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771777211;
	bh=vHB9blp+IHH8GWFcNLiUfN1bKw+tIqOCbQNV2sHZD5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q9HPR9W6AjZo/EIVL+7UBhiOHyNfhoqeXp6EyQjHVhgYpn58paqHh/3JVGz46nEMP
	 yUgycNDke6r9fskY6ZRtw46aMIj22EpCzylFwOJhnYLum0oNsWmJD28C/Cvw4ZDIFh
	 ZOB8hSVQ5ATMd8x4c5q4VNtVeyl/OuQNn5OMJGFW4OCbImL2ZdKC4ZKkufI9i0ZmBV
	 pLrN1VdUo0sNt/EGp4oi1GhMl9CThUIivOmaIh6a7G2BzpiOuQng+dLAkV25s0xW1O
	 y85hR2iFENKEG0ojGBqr+DVXkT1dxVC4JBrm5B3FKGfOCP2rTQgblfutR7LD9UzmqB
	 zbkAMVyxunZQA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 6/6] sunrpc: Optimize rq_respages allocation in svc_alloc_arg
Date: Sun, 22 Feb 2026 11:20:02 -0500
Message-ID: <20260222162002.10613-7-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260222162002.10613-1-cel@kernel.org>
References: <20260222162002.10613-1-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19096-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email]
X-Rspamd-Queue-Id: 2DDD616F9C1
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

svc_alloc_arg() invokes alloc_pages_bulk() with the full
rq_maxpages count (~259 for 1MB messages) for the rq_respages
array, causing a full-array scan despite most slots holding valid
pages.

svc_rqst_release_pages() NULLs only the range
[rq_respages, rq_next_page) after each RPC, so only that range
contains NULL entries. Limit the rq_respages fill in svc_alloc_arg()
to that range instead of scanning the full array.

svc_init_buffer() initializes rq_next_page to span the entire
rq_respages array, so the first svc_alloc_arg() call fills all
slots.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h | 4 ++++
 net/sunrpc/svc.c           | 1 +
 net/sunrpc/svc_xprt.c      | 8 +++++++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index bb2029e396db..35e9b34e2190 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -150,6 +150,10 @@ extern u32 svc_max_payload(const struct svc_rqst *rqstp);
  * rq_pages[0] and set rq_pages_nfree to the count of entries
  * consumed. svc_alloc_arg() refills only that many entries.
  *
+ * For rq_respages, svc_rqst_release_pages() NULLs entries in
+ * [rq_respages, rq_next_page) after each RPC. svc_alloc_arg()
+ * refills only that range.
+ *
  * xdr_buf holds responses; the structure fits NFS read responses
  * (header, data pages, optional tail) and enables sharing of
  * client-side routines.
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index a8c26634ecf1..ef18365c9d9a 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -655,6 +655,7 @@ svc_init_buffer(struct svc_rqst *rqstp, const struct svc_serv *serv, int node)
 	}
 
 	rqstp->rq_pages_nfree = rqstp->rq_maxpages;
+	rqstp->rq_next_page = rqstp->rq_respages + rqstp->rq_maxpages;
 	return true;
 }
 
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 9d8f6adcfe1f..9b3425f57068 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -686,8 +686,14 @@ static bool svc_alloc_arg(struct svc_rqst *rqstp)
 		rqstp->rq_pages_nfree = 0;
 	}
 
-	if (!svc_fill_pages(rqstp, rqstp->rq_respages, pages))
+	if (WARN_ON_ONCE(rqstp->rq_next_page < rqstp->rq_respages))
 		return false;
+	nfree = rqstp->rq_next_page - rqstp->rq_respages;
+	if (nfree) {
+		if (!svc_fill_pages(rqstp, rqstp->rq_respages, nfree))
+			return false;
+	}
+
 	rqstp->rq_next_page = rqstp->rq_respages;
 	rqstp->rq_page_end = &rqstp->rq_respages[pages];
 	/* svc_rqst_replace_page() dereferences *rq_next_page even
-- 
2.53.0


