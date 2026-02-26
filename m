Return-Path: <linux-nfs+bounces-19285-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PA7LUJhoGk0jAQAu9opvQ
	(envelope-from <linux-nfs+bounces-19285-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Feb 2026 16:05:38 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A27A1A836A
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Feb 2026 16:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D38CF3068F7C
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Feb 2026 14:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272E22F260E;
	Thu, 26 Feb 2026 14:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/q51uc0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F082DB79D
	for <linux-nfs@vger.kernel.org>; Thu, 26 Feb 2026 14:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772117268; cv=none; b=q3m3gOZ4cabqkRt5H/eduuutFgEMXSKoemTzXcxqg5vl2pmohakh9aDMv3GRSfoTNUzaHSOtL9dNkp6rjhzSAeEqYm2qK0Ct5UBDZdmvcUiSbXuL9OluJ4a8/lGsApYhYP1xM0+kyepOLLLJqhxGNJR1Pu1joCdnYRLrWqGuhDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772117268; c=relaxed/simple;
	bh=xjZtIDkc6vngwg5sZ1d+vGi/1JkZeCIiuPRiVWmS9Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GFiPds+KY/orlX7ooQMeUeAzAKXR3VSvSrOx9EEh9HzTR+afq+mdET+23DDbvEzPcOUoo07B9cai3705LdFpCpD20QAPfFbaalJNKewpDl/ycANi1urPjUgy+GNnTfXmfbCvsiLpO6x4FHLqA8ydtV1p8O9T4zWhq3S40TukOn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/q51uc0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09511C19423;
	Thu, 26 Feb 2026 14:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772117267;
	bh=xjZtIDkc6vngwg5sZ1d+vGi/1JkZeCIiuPRiVWmS9Y0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e/q51uc0xQ/Ty+N6Eh33mBvxhtPFm889p4jlhoU0MBVzbO3q1mLCPA9rBadyLpCCc
	 YbxDhA0Y9lB3YHTgG6w0G4WTx8aqF+DlJGV3Jm4GFLJzhdUEXx29HrFhhiuzDO3ouD
	 U+mUVOFNzz6bIuBNOdUViWF/SHEqVZ8HijL1dbdZz7X0rZwATaAWSAPYALE083pQYJ
	 6V7enaSQD9n7teWcwRw9df9zu+GCFv/h6AcUl143N1wJSuPbdp5u/MAoeBrEyDnyDF
	 eT2CCueaCuc2WLK0Zmj+CAcIbDA48p0IC7UpoW9gHAs867q4fIOYk/B2RN5axV5U5Y
	 nfiflylPOIQow==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 6/6] SUNRPC: Optimize rq_respages allocation in svc_alloc_arg
Date: Thu, 26 Feb 2026 09:47:39 -0500
Message-ID: <20260226144739.193129-7-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260226144739.193129-1-cel@kernel.org>
References: <20260226144739.193129-1-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19285-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RSPAMD_EMAILBL_FAIL(0.00)[chuck.lever.oracle.com:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A27A1A836A
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

svc_alloc_arg() invokes alloc_pages_bulk() with the full rq_maxpages
count (~259 for 1MB messages) for the rq_respages array, causing a
full-array scan despite most slots holding valid pages.

svc_rqst_release_pages() NULLs only the range

  [rq_respages, rq_next_page)

after each RPC, so only that range contains NULL entries. Limit the
rq_respages fill in svc_alloc_arg() to that range instead of
scanning the full array.

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
index b5a842dd97a4..7315c529f88a 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -152,6 +152,10 @@ extern u32 svc_max_payload(const struct svc_rqst *rqstp);
  * still in transport use, and set rq_pages_nfree to the count.
  * svc_alloc_arg() refills only that many rq_pages entries.
  *
+ * For rq_respages, svc_rqst_release_pages() NULLs entries in
+ * [rq_respages, rq_next_page) after each RPC. svc_alloc_arg()
+ * refills only that range.
+ *
  * xdr_buf holds responses; the structure fits NFS read responses
  * (header, data pages, optional tail) and enables sharing of
  * client-side routines.
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 6e57e35fa6d6..5e0b5ec2fd52 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -656,6 +656,7 @@ svc_init_buffer(struct svc_rqst *rqstp, const struct svc_serv *serv, int node)
 	}
 
 	rqstp->rq_pages_nfree = rqstp->rq_maxpages;
+	rqstp->rq_next_page = rqstp->rq_respages + rqstp->rq_maxpages;
 	return true;
 }
 
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 795b5729525f..b16e710926c1 100644
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


