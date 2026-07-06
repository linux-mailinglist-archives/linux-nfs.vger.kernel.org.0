Return-Path: <linux-nfs+bounces-23063-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0jljLdyyS2rpYgEAu9opvQ
	(envelope-from <linux-nfs+bounces-23063-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 15:51:24 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 54195711821
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 15:51:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lOZKmuAT;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23063-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23063-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED81A311BAC3
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jul 2026 13:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844A841A764;
	Mon,  6 Jul 2026 13:29:33 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B659A41611A;
	Mon,  6 Jul 2026 13:29:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783344572; cv=none; b=OmD3hXlcf7+Nlcmsm+z46/dCJBPdXuqRVZQukmMWXK6hT+f4cgtTyXeYvBgMXUF2aMYB2VY3JtJKgLc3CyZMzA1J3nMyQzZtAR69zGKmxnAHP87iKSSro123BjaVt4WrBqZGAu4ccGAmZj127vSYZp/uMOkrsPK9ARNDiRJ6irA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783344572; c=relaxed/simple;
	bh=ZkSMLJH2/wa+Vs7LKWA7HMCC0yYqyIb6qeWymH9x3xQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LgJn/Ed6e5xFEVgoeY22/hD7ANxFgDdu5EZArX16PANVNFyjdt3y4KAJ/N+ApsYjIVrVVWxZ2H96vG6CZGvLJY1cBGeAJVPLwYVup7dRtUIs2Cp2zNhP7+I9I1vxAgeqHxsvg9WSlR0/8x6OHW2VNwZuK9Ao8K7RulIs0EMKf68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOZKmuAT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0651F000E9;
	Mon,  6 Jul 2026 13:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783344568;
	bh=XX29RWCnVeD/5MBQXkQlbD0pTi4GG99gpog2MJ1vdN0=;
	h=From:Subject:Date:To:Cc;
	b=lOZKmuAT0SYbaPpQV0t2JRk5rntcONdxiZMx7FfLThAdT1jkjf/A91NZO0C4aZ8ZX
	 k8HKnU7Bv/2ItzeamCGO1acJkj+ao+gfMM3UgfzlRX6artJN4Vrv+NpWRfi6EWKdWe
	 MnD+BJ1x8An9tMhGIRLUmOroP+8cj4JxHCsDV+YD/xrPmyYVGu7t9zItGQvPigsPbn
	 7yW4kG3BLf9Ru1rqkvF1Yv4TdlokhKB2eBMafIOf75NDBGdN+mQzkVRtEh/ypJkxmR
	 3soZ1+jP+lumOXchO+ABLuQSJC0905ogNcLmUr+KTHXQ0a5mQJoT56XCVf+Lhvxb44
	 peLLahkd2D3Fw==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v5 0/5] sunrpc: hardcode pool_mode to pernode, remove other
 modes
Date: Mon, 06 Jul 2026 09:29:20 -0400
Message-Id: <20260706-sunrpc-pool-mode-v5-0-6c4ee7cd89aa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NzW7CMAzA8VdBOeMpcb5aTnsPxIE0DkSDpkpGB
 UJ994Veuolqx79l//xkhXKkwnabJ8s0xhJTX0NvN6w7H/sTQfS1GXI0XKGEcuvz0MGQ0gWuyRN
 IMk4bidx3itWzIVOI95ncH2qfY/lO+TF/GMVr+g82ChDgbEBOUlvVus8vyj1dPlI+sZc24iIY1
 CsCVkEFLdAZEkTNmyB/C+2KIIGDb9FYUzd88G+CWgTLxYqgquCkb4wl1TWh/SNM0/QDw3/8LHc
 BAAA=
X-Change-ID: 20260423-sunrpc-pool-mode-3e6b56320dc4
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Chuck Lever <cel@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neilb@ownmail.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2852; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ZkSMLJH2/wa+Vs7LKWA7HMCC0yYqyIb6qeWymH9x3xQ=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqS622JPHW2uepjsa6e1vTmur7ak/hgdJEdJTr8
 31sbhe0vTyJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCakuttgAKCRAADmhBGVaC
 FQmjEAC6cU4lbmsnuoNLo8HYpUY9ozPHAKDI2ZSS2jaE79UBggSzwOQBjkWGEgZWni0cZmIz4us
 N/bJKauD17X0uEONtTyPtHJwZV9pZ9efUP6o71Nctn5aqcht1o0ToGhURuXKAXq/DeZYicTqIDo
 DqqGxYmZsY3GbPCswgrxbd/vRqcRAaNVRX6NhNUPK03MF5MgdTr3XwEErr7gJ48jw0PZs7TJzo8
 DJug4kSfiRH9J6rpfH7A/A74aCaJvkPN/UR1tsglq/GxFADVHOvx8AbWF4wizxC1uHFFLIR9Fr/
 Ao0jK10mEJlFH85fDe1fRLdnzAB9aHpRAKbtr+rHxYD2nuOz8uRAa4v7qjNJfU2ti2PQ6a22SHS
 QuFFjRATGYG1ZggGDd7x/PeI+jxmpKhnobXJ07tO2iNgGiQvt47oz+MFvg9PSnwMfVVDtbg2NTs
 CBK1jtd1LNGMKjdCggXNnHLDpYEgHrmtVb5qTCjn65pMRtZZYCyL7NZ7RfezDgd1EXbgO3Fj46j
 ITYc43dWdpfyzCo+FqrAU2Y3RJOLLPd6o14q/eLzRv48Ut7BKZM9sH7kIFhkFyz33W8lol0DiYq
 F2+WRHnMywnfqdzA7gsbwEvH5QN/LZPZHNCPeFJkFKWYBFFb2llHuJDgSBb76A7x+EGyBv7zIZ8
 HO836RBtN3GDm4w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23063-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:cel@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,m:neilb@ownmail.net,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,ownmail.net];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 54195711821

This has a few small fixes and comment cleanups and also implements
Neil's suggestion to remove serv.sv_nrpools:

Patches #1 and #3 address what is a shortcoming of the existing code --
namely that the server can be configured to schedule RPCs to pools with
no threads in them.

The first patch addresses this problem: if the chosen pool has no
threads, then choose another that does.

The third patch tries to prevent this situation in the
auto-thread-placement case by ensuring that each populated node has at
least one thread.

The last two patches implement Neil's suggestion to eliminate
serv.sv_nrpools. This has the side effect of getting the modulus out of
the svc_pool_for_cpu() hotpath as well.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v5:
- Expand patch to eliminate modulus to also eliminate serv.sv_nrpools field
- Revised comments in svc_pool_for_cpu()
- Link to v4: https://lore.kernel.org/r/20260701-sunrpc-pool-mode-v4-0-b3d867e4c8f9@kernel.org

Changes in v4:
- Drop 5/4 RCU patch
- Only let pooled services consult the map
- Comment and commit log fixes
- Link to v3: https://lore.kernel.org/r/20260629-sunrpc-pool-mode-v3-0-d92676606dfd@kernel.org

Changes in v3:
- Add patch to ensure that we don't route requests to empty pools
- When auto-distributing threads, always create at least one thread per populated pool
- Use sysfs_match_string for the module parameter
- Reword deprecation printk to be more vague about removal
- Explicitly set m_count == 0 in svc_pool_map_get()
- Optimize svc_pool_for_cpu() by eliminating modulus ops
- Link to v2: https://lore.kernel.org/r/20260625-sunrpc-pool-mode-v2-1-4f512b6e1ee8@kernel.org

Changes in v2:
- Accept any previously-accepted setting for pool_mode
- Link to v1: https://lore.kernel.org/r/20260423-sunrpc-pool-mode-v1-1-b7f20e35749b@kernel.org

---
Jeff Layton (5):
      sunrpc: route to a populated pool in svc_pool_for_cpu()
      sunrpc: hardcode pool_mode to pernode, remove other modes
      sunrpc: guarantee a thread per pool when auto-distributing
      sunrpc: tear down pool counters before dropping the pool map reference
      sunrpc: derive the pool count instead of caching it in sv_nrpools

 Documentation/admin-guide/kernel-parameters.txt |  20 +-
 fs/nfsd/nfsctl.c                                |   2 +-
 fs/nfsd/nfssvc.c                                |  10 +-
 include/linux/sunrpc/svc.h                      |   2 +-
 net/sunrpc/svc.c                                | 355 +++++++++---------------
 net/sunrpc/svc_xprt.c                           |   6 +-
 6 files changed, 152 insertions(+), 243 deletions(-)
---
base-commit: ee6ae4a6bf3565b880dfb420017337475dfbc9ea
change-id: 20260423-sunrpc-pool-mode-3e6b56320dc4

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


