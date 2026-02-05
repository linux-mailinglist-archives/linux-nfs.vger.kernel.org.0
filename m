Return-Path: <linux-nfs+bounces-18752-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGyqNF6VhGmL3gMAu9opvQ
	(envelope-from <linux-nfs+bounces-18752-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Feb 2026 14:04:30 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 386DEF2F18
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Feb 2026 14:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4765D300D337
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Feb 2026 12:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6753D413F;
	Thu,  5 Feb 2026 12:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBAlvcmr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0E93B95F9;
	Thu,  5 Feb 2026 12:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770296372; cv=none; b=DZZ9YCzfFR1AEaPhUeuR8tc9yc68l4xe88TTJZvW3WxRWT0XXlKolsNvIW9IcWxf8XiUEjfJMotXB9iJYy2cCms1RYFwrW2fKNriMqN+qglq96q0sE/VnGduv9K3zA3kKaKUsy/jNwz8iLYm2sZudp3ocM3Okv3MtlIdeTZUe+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770296372; c=relaxed/simple;
	bh=PNI/WZg/764MowsmND6tWd4dy2UmcghSEcyWL53l5Ms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PjNaotYUl7perJAPyeWT/wmrRYbtmMGQlhJUmfZQ7EUlBWuiB6m/VtGzitR41yznypJaz4lveysEvCAsbFBAGUZzy7nr0hYozLU7A18DT4PgomihYrZ1yzQVPsKke5cbHnsg9adcerTnEDdLTARgjowUDijTQ2Z0yvltD90nXeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBAlvcmr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C821DC16AAE;
	Thu,  5 Feb 2026 12:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770296372;
	bh=PNI/WZg/764MowsmND6tWd4dy2UmcghSEcyWL53l5Ms=;
	h=From:Date:Subject:To:Cc:From;
	b=MBAlvcmrLytSStloqUT8WaBZ8P5POomsFQzVr8InudD9iNKFKx2slQD4Wv+Ecvo19
	 WsK1tmdPYiq2ec52mefRcx6cLj6xGmK9bWCPrmvIEIo93uOhLhMYqkvETOFl24AGzz
	 zSHggajTrzZET/oj34LmBANgvNnyM/R7CD7pzFJ9FlG+wM9s4FAXXJowxywFWKjl2N
	 LizyuemPcdJzqYbz9EVk30wyJdPxjuVUDf10zx3efOzxUziqyEUG1xW5YUIBAflggY
	 kepeNSMP3v4EiOUvpFxAU+FouMZIxPoerKWqxrqU5iTm+xZGqE4tgw0V1XGHSbahcz
	 W6cy0x1nExlqQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 05 Feb 2026 07:59:20 -0500
Subject: [PATCH v2] nfsd: report the requested maximum number of threads
 instead of number running
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-minthreads-v2-1-b49c7be04e67@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23MQQ7CIBCF4as0sxYDWEFdeQ/TBS3TMlGpGRqia
 bi72LXL/yXvWyEhEya4NCswZko0xxp618AQXJxQkK8NWmojtWzFk+ISGJ1PwvYatTybwVsL9fB
 iHOm9YbeudqC0zPzZ7Kx+618mK6GEbU9SWdO78XC83pEjPvYzT9CVUr4hBquopQAAAA==
X-Change-ID: 20260204-minthreads-7b2e2096cd77
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4443; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=PNI/WZg/764MowsmND6tWd4dy2UmcghSEcyWL53l5Ms=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBphJQtsUnb5WWMOMEkZ7Y3iyvD4ZihZHg/G7BDd
 +lxNRffrieJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaYSULQAKCRAADmhBGVaC
 FZECD/9i15ZTDy1HRQxJvA0uYZ/cidet7PA/SF8RosFoNHRLk6gX3gPQ8JqJ0SXnvBZzhDhfqsz
 kc9LippZ6jsnJ4EzbgG3T2UfaJ2mYKrp+tMYETcjprwG+gIbsSopQo4P0It9X/bagWlKtaGReRw
 4FHYGGYsjjoqUfXXSVW5I413izPwhEcz0wuW+YgZQS5YpGq0hfRhRQTihoDak5l76DXgPMuAHve
 GVLmDT/hLC5ovpPtowFe7Bt6vorF8cbKzXqDI8vb0sqk13bIDS40ZgySTC8O3OuRv1AAfGBB2+m
 SRYL7oeWwyqChqG5rTQQanUfdM4enVA/2DAR1Ulozsr3zK5w4DChAXh4KAPu6N5pMO4UKRaPJ95
 HCRNDCSStYaBSE6pOK+0rHhHc3gkREJsM4uGQ9BYko/575Ujgwu/2bPaFoqHu54FZnTL/hVK7Jq
 5tpuBVrni36aJ1m/EC7dW+Euann15OA4/EvA1Y3rloyX5htKxVI3mzv9SHFMJyWsfz3OHXw62q2
 oz0xqn8pP8Zr0isja77Njyb0p7YasEGQ4sPZ7/glz5e62ZSXJpL1DmwZak2582B8DB55mkeYEw5
 DyuNFHJoxOkgqLru0+0MU3Emv3EbJ6exuz1UVIAnstDq0IAjzhAAwlf/7VBIlG1a35/l7YuSNQw
 PQ1k5oeK/gsJzbQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18752-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 386DEF2F18
X-Rspamd-Action: no action

The current netlink and /proc interfaces deviate from their traditional
values when dynamic threading is enabled, and there is currently no way
to know what the current setting is. This patch brings the reporting
back in line with traditional behavior.

Make these interfaces report the requested maximum number of threads
instead of the number currently running. Also, update documentation and
comments to reflect that this value represents a maximum and not the
number currently running.

Fixes: d8316b837c2c ("nfsd: add controls to set the minimum number of threads per pool")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
I think this is less surprising than the current behavior of what's in
Chuck's tree. We could also consider adding netlink attributes to report
the number of running threads, but you can get that info from ps too.
---
Changes in v2:
- Update docs and comments that this is a max and not the current value
- Link to v1: https://lore.kernel.org/r/20260204-minthreads-v1-1-7480176baf35@kernel.org
---
 Documentation/netlink/specs/nfsd.yaml | 4 ++--
 fs/nfsd/nfsctl.c                      | 8 ++++----
 fs/nfsd/nfssvc.c                      | 7 ++++---
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index badb2fe57c9859c6932c621a589da694782b0272..f87b5a05e5e987a2dfc474468ddadb5e1f935328 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -152,7 +152,7 @@ operations:
             - compound-ops
     -
       name: threads-set
-      doc: set the number of running threads
+      doc: set the maximum number of running threads
       attribute-set: server
       flags: [admin-perm]
       do:
@@ -165,7 +165,7 @@ operations:
             - min-threads
     -
       name: threads-get
-      doc: get the number of running threads
+      doc: get the maximum number of running threads
       attribute-set: server
       do:
         reply:
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 4d8e3c1a7be3b3a4e4f5248b27b60d6b3ae88d51..592d47de8c0dcf56c3e9611af634703c212a7aaf 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -384,8 +384,8 @@ static ssize_t write_filehandle(struct file *file, char *buf, size_t size)
  *			size:		zero
  * Output:
  *	On success:	passed-in buffer filled with '\n'-terminated C
- *			string numeric value representing the number of
- *			running NFSD threads;
+ *			string numeric value representing the requested
+ *			maximum number of running NFSD threads;
  *			return code is the size in bytes of the string
  *	On error:	return code is zero
  *
@@ -1657,7 +1657,7 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 }
 
 /**
- * nfsd_nl_threads_get_doit - get the number of running threads
+ * nfsd_nl_threads_get_doit - get the maximum number of running threads
  * @skb: reply buffer
  * @info: netlink metadata and command arguments
  *
@@ -1700,7 +1700,7 @@ int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *info)
 			struct svc_pool *sp = &nn->nfsd_serv->sv_pools[i];
 
 			err = nla_put_u32(skb, NFSD_A_SERVER_THREADS,
-					  sp->sp_nrthreads);
+					  sp->sp_nrthrmax);
 			if (err)
 				goto err_unlock;
 		}
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 8184514c58de8e396795cd4714a04d66d9637f17..be0add971c2d994948c3e8fca19bcf6f3c75dfaf 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -239,12 +239,13 @@ static void nfsd_net_free(struct percpu_ref *ref)
 
 int nfsd_nrthreads(struct net *net)
 {
-	int rv = 0;
+	int i, rv = 0;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
 	mutex_lock(&nfsd_mutex);
 	if (nn->nfsd_serv)
-		rv = nn->nfsd_serv->sv_nrthreads;
+		for (i = 0; i < nn->nfsd_serv->sv_nrpools; ++i)
+			rv += nn->nfsd_serv->sv_pools[i].sp_nrthrmax;
 	mutex_unlock(&nfsd_mutex);
 	return rv;
 }
@@ -673,7 +674,7 @@ int nfsd_get_nrthreads(int n, int *nthreads, struct net *net)
 
 	if (serv)
 		for (i = 0; i < serv->sv_nrpools && i < n; i++)
-			nthreads[i] = serv->sv_pools[i].sp_nrthreads;
+			nthreads[i] = serv->sv_pools[i].sp_nrthrmax;
 	return 0;
 }
 

---
base-commit: dabff11003f9aaf293bd8f907a62f3366bd5e65f
change-id: 20260204-minthreads-7b2e2096cd77

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


