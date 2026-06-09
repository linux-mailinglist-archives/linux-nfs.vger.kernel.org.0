Return-Path: <linux-nfs+bounces-22419-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QlzUKilVKGpSCQMAu9opvQ
	(envelope-from <linux-nfs+bounces-22419-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 20:02:17 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E4E663260
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 20:02:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LU05ovkq;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22419-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22419-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A113830A5AF8
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jun 2026 17:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8324EA370;
	Tue,  9 Jun 2026 17:48:11 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D004EA367;
	Tue,  9 Jun 2026 17:48:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781027291; cv=none; b=QK4d7tIpkNVPOUMXTuErJYlYzuhEmW5jiNxqidTV7RxXsvyZEBnXH4m5eSgENmVGxnxBG+pel4pT7U9uvqMkFDoqE5uoxCooKdHV0zULOmxRqk27XsePAMcczRSYUYiG1zzMbsRFPUh591ACyHYRpa6giraDasxwyhbwIrAxRH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781027291; c=relaxed/simple;
	bh=hRhpof256WQKvwovAWbRm1MWiOD2BnEzRGWngsNI+JE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tWbPAwBgqqQart2xwm8NpClj1H3ZqCGnYTBvwezb1+L1YiawmUYputpdvpIdX4wpQ6d5pXye2a53CT1k6kKdtbfwyyRkXdg97UtJwgPP8HrYhVDc5IH27LJgamui33tWB5PPe+hRY7dR2zG2AH8eJgo2VXKWcooZ22+jGx8S4Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LU05ovkq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA491F00899;
	Tue,  9 Jun 2026 17:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781027289;
	bh=/VBdGVg26zQKWyJI8yfnf2xCXui05mQvSa45bIwcNzA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=LU05ovkqpLA14pLPGSbnqIs+99r1EAo9hBgQSVYKf9woMNEhi40X6JpAAQz72Ri4u
	 1fFHrY/eefesyFsMbg8qyijalR4u2lWoYYPvEJSzTFj1s/dafREKvVb8j+uaMgkhKr
	 hoSWMj4nB4L6CFn2F9HCB2ZOoxW5mXxHyDCO+dE1HekXaioxtSggK2QxvVQas3HZcs
	 v+psq5ESY/HrhivwY3A6F71f2sd7eySWRmsP9wFKEUsV+TZXjuKnucNBTHYE8vAEju
	 UEazM6eaMJVITuNFSApHXhQlli80dKGdioK2Sqcmg0iw6xrpplscK3Ar3RfRerGAsD
	 kxMAxWy3WFT3g==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 09 Jun 2026 13:47:33 -0400
Subject: [PATCH 12/19] nfsd: add fh_want_write() for early-verified SETATTR
 in nfsd_proc_setattr()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-nfsd-testing-v1-12-e83acead2ae8@kernel.org>
References: <20260609-nfsd-testing-v1-0-e83acead2ae8@kernel.org>
In-Reply-To: <20260609-nfsd-testing-v1-0-e83acead2ae8@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Benjamin Coddington <bcodding@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Muchun Song <muchun.song@linux.dev>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1192; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=hRhpof256WQKvwovAWbRm1MWiOD2BnEzRGWngsNI+JE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKFG80QOEnXx9LKgofwY2TbK8Wb3WnhA80ooMD
 3EOsw/lCByJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaihRvAAKCRAADmhBGVaC
 FewtEACmtY4axz/R+MEukW5LnRHHP3k0WsosoFh660ezMVBLqkr4UjS9g5IBH7Ly3k1j+e4dZA3
 TLrjZyMq5us4H+KCtNYSMlvnELGUejh7ECKKZ3NBAiWSYJ6xne4YfydiqtYzpbndltQe3krBh97
 oQjrQBUkOZ1tPo2UBbvRx8TVMi9EGUSzGzlpe8xV59ebYEELhTwwNQhAs2O1XVg2T41ffpXd82z
 Q6j/pZZj15NRHVMuhOessQXybwwXwt3owejv7FLXLTKw3i9AMuEQSgP+dKfmYvMctocizsmRmKW
 ov662ejP1FwEQ+6mQkUoFlS0Cs+BwRby/w3/8F2icXQTcqUgjdB7KLMPhNTJuB5H7Tvsm65bnRt
 y2uxu6Wa8iiFeiLMshOF3IL6NJ8ZawXBfpHipDT3h3me2K70bA2GYo7+jn0UhqN2/sh8z8Mmk+x
 smsdoGHUJ5p+DfM6m3wpfFrk6AVp8DZ3TZz5Uljy3cP/r4KHvQ6qRgLbXMLFk9HPV+TxDiXKUbt
 kbf+589FBx0xurchEaCaDoeMoY+via6jadlZxWLrwdAo3tfO1zgBVky9YkNlM2XaM+M/cx/IRR0
 Y0VQEnfM86XR4Vw5p5TVFnimfQYwrOk+VKEsQz8xjl4zQho4NlotNcC7/eHqmNuQ1chrWJWOEdO
 hOe3vOW+bY85iGA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:brauner@kernel.org,m:bcodding@redhat.com,m:donald.hunter@gmail.com,m:lorenzo@kernel.org,m:qi.zheng@linux.dev,m:akpm@linux-foundation.org,m:muchun.song@linux.dev,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:jlayton@kernel.org,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_TO(0.00)[kernel.org,oracle.com,brown.name,redhat.com,talpey.com,davemloft.net,google.com,gmail.com,linux.dev,linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22419-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 05E4E663260

The BOTH_TIME_SET branch calls fh_verify() early so setattr_prepare()
can inspect the dentry. This causes nfsd_setattr() to skip
fh_want_write(), so notify_change() runs without a mount write
reference.

Add the missing fh_want_write() call after the early fh_verify().

Fixes: cc265089ce1b ("nfsd: Disable NFSv2 timestamp workaround for NFSv3+")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfsproc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 8873033d1e82..a73d5c259cd9 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -82,6 +82,7 @@ nfsd_proc_setattr(struct svc_rqst *rqstp)
 		.na_iattr	= iap,
 	};
 	struct svc_fh *fhp;
+	int hosterr;
 
 	dprintk("nfsd: SETATTR  %s, valid=%x, size=%ld\n",
 		SVCFH_fmt(&argp->fh),
@@ -117,6 +118,12 @@ nfsd_proc_setattr(struct svc_rqst *rqstp)
 		if (resp->status != nfs_ok)
 			goto out;
 
+		hosterr = fh_want_write(fhp);
+		if (hosterr) {
+			resp->status = nfserrno(hosterr);
+			goto out;
+		}
+
 		if (delta < 0)
 			delta = -delta;
 		if (delta < MAX_TOUCH_TIME_ERROR &&

-- 
2.54.0


