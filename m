Return-Path: <linux-nfs+bounces-18326-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AAkEJJzcmlpkwAAu9opvQ
	(envelope-from <linux-nfs+bounces-18326-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 19:59:30 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1906CD17
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 19:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9A143007674
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 18:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A88138A734;
	Thu, 22 Jan 2026 18:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BisUomAz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CEA357713;
	Thu, 22 Jan 2026 18:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769108365; cv=none; b=QPa3dQfD2uaGKEId3Urjf0EpX9R0H+govm1LMVC6OKJFcwT1W7rDCOOCUaBQH3M57NXuXDk5SmP7gKjuZgshjVN1kNPAgmNJQPcqwncCmaizSKc2uVBmq+nkZsXbVFhNgjx7KFmsQIGYIe3bHKV89zlN5hnG7vsFR7AJYI5UgNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769108365; c=relaxed/simple;
	bh=/tek0OLjqC1l+O5Xw/JrC06UDsQIel58UyGJqqU/ELg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=faw6SYHp9JKoy4Wk7oLlJNj3iVvaoYnYEq9w8Ku+kwRMrdj5tJ7UPKJw7ki2TXvjBaumC+Guay/hBUGZuHqIXkLTYuC8X+6E5HIJOjcyY8ytFyA/zHE/9Xy8dANJgSZkg8pM5JSy81yDb34dlmYSfGnQGGtpTD9bx+Q8tTYuiqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BisUomAz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D7E5C19424;
	Thu, 22 Jan 2026 18:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769108364;
	bh=/tek0OLjqC1l+O5Xw/JrC06UDsQIel58UyGJqqU/ELg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BisUomAzdgZQKz47kedt4erqhYdRAlxqFps4RnebMuDNHf7HinErISOudmsz/6IDD
	 MyReZ/Ws7ALzsArPKK2Y8rf8jxgESH94WYVoEEfsTwEpRsBe3s8eSitep6TlQUKc2g
	 JRvXFZKRXqvflC2ZITdrNUKKsYNZVAEjdRRIjpTG+Y/Lr7DDyORhfNwdl5uEXV2O+9
	 kjzkrb3uMBbtLfDVEujzTqoTDF7/fUM08SI6Ksnd6FWMARclemd/wsowbbaedtglmJ
	 cLAqTRviHcQC1gUxKNBA+UW1Q47tAF+pTtqJlCPlz6EN5tAvt+ReibsyYFGs9k6S4A
	 wEZ8KJuqEKX2g==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 22 Jan 2026 13:59:15 -0500
Subject: [PATCH 1/2] nfsd: add a runtime switch for disabling delegated
 timestamps
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-delegts-v1-1-40fbb180556c@kernel.org>
References: <20260122-delegts-v1-0-40fbb180556c@kernel.org>
In-Reply-To: <20260122-delegts-v1-0-40fbb180556c@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2390; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=/tek0OLjqC1l+O5Xw/JrC06UDsQIel58UyGJqqU/ELg=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpcnOJ3toduxQIVewFces5HAaCyt3Jsi7XNkGgl
 a4wRsgdm06JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaXJziQAKCRAADmhBGVaC
 FaRNEADAkaFU+I10xqcAtBEedVOAWDvSU9IMKFwkGcCZSsWKmftEk95Wk+F7KFQ+Q2CguVlN5od
 jWqLGRXrl3yREPJKjwp6jj9ISl7211EhVF9Bjp63Az/Q5MwvXgeRi628Q2L60IQNr3ttaU63dzB
 kpx21LggYn2asDxaKJDX+IX1lhet+OxkdGk13VvoYfCVGEp+a5zN9YFyY47mumhHKWYo1T4B81e
 Lab/JafpPZ0c/UQW5MLBPZuj3HBv4U0hQ3RE2HH51AupWVG+s08y79llakgqApdGRb4o9MP21v2
 T4Svo8e7mvrKS5y3ua/k6iNHzeZ6qA3TRCyzjUQmC9rwmVv3qv+LMg40IEXPbo/jv4q6855lyUk
 OD1AviAVD/b4NO35pS5WBmAWF1Gmxh4Fax1hCtkrxL2cXloJk5Mfpp3C1fB+a9HB+ugxH6osXSH
 80unfzgT5HoL64ByhTZGCp/90XEz4eU/CdRxlQtHGjumGi4np2CM//1kpzTR1dpVrhrResQxLxl
 RVQjVs5K4Ep6qJq74khAyk/CtSg///uAvm6iPHGFQS/GWv9I7RPb2hJcyITIJAMYgVJnBetZncu
 lWucMOS4EXClmKFqmJDD2NsiSYlw9qak2geGHEFF9jNR6aZV93uy6IkJTrdassIhj6lp79J/+Qj
 sG0XGChHr8uAGhA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18326-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EA1906CD17
X-Rspamd-Action: no action

The delegated timestamp code seems to be working well enough now that we
want to make it always be built in. In the event that there are problems
though, we still want to be able to disable them for debugging purposes.
Add a switch to debugfs to enable them at runtime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/debugfs.c   | 3 +++
 fs/nfsd/nfs4state.c | 4 ++++
 fs/nfsd/nfsd.h      | 1 +
 3 files changed, 8 insertions(+)

diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
index 7f44689e0a53edbfd6ade9dda6af4052976a65d3..d113e0e19c8d73fc9e023fd30ed3bc909dc5ddbd 100644
--- a/fs/nfsd/debugfs.c
+++ b/fs/nfsd/debugfs.c
@@ -140,4 +140,7 @@ void nfsd_debugfs_init(void)
 
 	debugfs_create_file("io_cache_write", 0644, nfsd_top_dir, NULL,
 			    &nfsd_io_cache_write_fops);
+
+	debugfs_create_bool("delegated_timestamps", 0644, nfsd_top_dir,
+			    &nfsd_delegts_enabled);
 }
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 583c13b5aaf3cd12a87c7aae62fe6a8223368f55..95f2e87141a7ab5dd3da6741859bdcae28a8c6c0 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -76,6 +76,8 @@ static const stateid_t close_stateid = {
 
 static u64 current_sessionid = 1;
 
+bool nfsd_delegts_enabled __read_mostly = true;
+
 #define ZERO_STATEID(stateid) (!memcmp((stateid), &zero_stateid, sizeof(stateid_t)))
 #define ONE_STATEID(stateid)  (!memcmp((stateid), &one_stateid, sizeof(stateid_t)))
 #define CURRENT_STATEID(stateid) (!memcmp((stateid), &currentstateid, sizeof(stateid_t)))
@@ -6048,6 +6050,8 @@ nfsd4_verify_setuid_write(struct nfsd4_open *open, struct nfsd_file *nf)
 #ifdef CONFIG_NFSD_V4_DELEG_TIMESTAMPS
 static bool nfsd4_want_deleg_timestamps(const struct nfsd4_open *open)
 {
+	if (!nfsd_delegts_enabled)
+		return false;
 	return open->op_deleg_want & OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS;
 }
 #else /* CONFIG_NFSD_V4_DELEG_TIMESTAMPS */
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index a2e35a4fa105380c2d99cb0865003e0f7f4a8e8d..7c009f07c90b50d7074695d4665a2eca85140eda 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -160,6 +160,7 @@ static inline void nfsd_debugfs_exit(void) {}
 #endif
 
 extern bool nfsd_disable_splice_read __read_mostly;
+extern bool nfsd_delegts_enabled __read_mostly;
 
 enum {
 	/* Any new NFSD_IO enum value must be added at the end */

-- 
2.52.0


