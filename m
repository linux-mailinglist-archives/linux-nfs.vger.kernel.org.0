Return-Path: <linux-nfs+bounces-20835-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oO+GG8hM3mkzqAkAu9opvQ
	(envelope-from <linux-nfs+bounces-20835-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Apr 2026 16:18:48 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD653FB064
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Apr 2026 16:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E58DE300FA17
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Apr 2026 14:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C5C34CFDD;
	Tue, 14 Apr 2026 14:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSYfqU4r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF7131159C;
	Tue, 14 Apr 2026 14:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176299; cv=none; b=HWoASmHN+C3duPw4qDDujjLIui/fa7Qcy05/ybfSTjh56Wntkn0PvbBtWEXXQGYyYvcuh1G6piaIBedrh0dtegkgj46lc1PrPxqR+j/5P7C+277HhtbrIeJU69cRZYlw+8YUBTk7lS1pb+X9BH0h/su16brPvf4KD9EfvEiy6Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176299; c=relaxed/simple;
	bh=vOwxvdA4nemq29N+//GmKlaiHnJRXNUgTq4p8lYOwQ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RRkmGBSWLK3FShFgmrfBo6AdtY9qA/rOfROGGWLpo4VjDDUK7PnuwF8ZGYqrdB0YBLZGQ/7E1nSTZNiiR526wfUPAKlv+YcnpkcWtdOgOql6rFJJtLMb9z1NoNyO7ls6QMJNGJvYnKXXEi7H11K52Uoe4htXcr6Pj42yawMzNKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSYfqU4r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 062C9C2BCB0;
	Tue, 14 Apr 2026 14:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776176299;
	bh=vOwxvdA4nemq29N+//GmKlaiHnJRXNUgTq4p8lYOwQ0=;
	h=From:Date:Subject:To:Cc:From;
	b=uSYfqU4rQzI/F2fibQn+C7Vmm8CrGKXpdlWAB4r3k6lxYn3iOXRv4seI+QEvDBGW9
	 3qK02omb/O4DWfS5JPj30H+0wDvFcqPO1LeNbr2BcSxXz7AmtuNXFJIGf+u/Aq1jGn
	 oVnXuOAH6GcNAz9FcwoAgOEtHV/3tfl23Kd7yRfkJ43vIZnIFfxSiqF3NxmiHV+lb3
	 JkVt7zWojFYeoLD8+UikpWVobLiG8EEL+z+Qbt8qXCpNKWcITpyc1I/Yaj6EdHpOPS
	 tSq1jc17xwyiTwHyrqk8ES7ANLFl/oZBbiULA9LWaUez6cBEL0DBerQISQJ+WNLydW
	 X7v6jINYO3h5g==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 14 Apr 2026 07:18:05 -0700
Subject: [PATCH] nfsd: fix handling of NFSEXP_PNFS in the netlink codepath
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-pnfs-exp-fix-v1-1-9face14c16c2@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvxJ7bkHNhPpKdMhcay8mCiGIf086z
 sBMhUyJKcM6VEj0cuYndJDjAOd9hIuQXWdQQhmhpcYYfEYqET0XtJLsYpyYzaShJzFR1/9u21v
 7AH+F4j1eAAAA
X-Change-ID: 20260414-pnfs-exp-fix-b1eb96d05634
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Christoph Hellwig <hch@lst.de>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1293; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=vOwxvdA4nemq29N+//GmKlaiHnJRXNUgTq4p8lYOwQ0=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp3kymH+/xqWv53Je3/M8b2UMyduEcFxyyOhZAt
 +jev3eEcvmJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCad5MpgAKCRAADmhBGVaC
 FVcyEACbJqL7+xcKQ5mI/c7czYjxMJXgLOfs3iyr65wr6m0PDp+E8yABlzqRZesdIoPxML5nDW9
 v2kXs2tIBvbwhTGP4uAyHbH2EprgDzm6lEAudyC2Rntbisezz2fkrOPPq0G7PnMlXgJyOXYcoKp
 fDB9qLACwyN5uCkxYNPmjOYPKwVZGpOFDnsC01DwYqbPTIX5mbGKf78TaUx9Tg8d2zzJzOKRBOB
 9C/Zxu5wheuZUTDNv8qb44zBUYoQE9+8iyt+2KixlEZ22OA9LFDGq/EGSiKtM5UlRoxvN+aliJH
 icBWr+iZZHwy+2lkIIK2n2oCe65Qp4BVmD+oPxmK9kNipnpqykIOzIgInNyOTho0ohKjcrpjgCi
 eNTR3X3mbcYU8YLpU+q2BmDZBpO1vPRFzPtvatyfPA0RzVYdQYpOl0aNsbbM3mS5oCUxTnf8Xz3
 43U6jlQlxwlE8PrTx3snHxU/aK7WTJnaty664IqUMwev8Cr+ibsqEUS7qP5Zo0jPaAOvGsnk9IH
 r9R4rUFT/2P5Y6S2Rg/A9fpleEPSxuaTY8yfVF0N4enWDHCaah6k+YiER5IwesS6S+ainYj1VVk
 7imB3OcPxpjVXxn9nKc5Z2ntiHQ+tUA7J0aOamW/tsuvX5LAxlVCXg67FmRZXPm4bCjU5zl0ZhL
 syA1yrldvR/09fg==
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
	TAGGED_FROM(0.00)[bounces-20835-lists,linux-nfs=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Queue-Id: 0FD653FB064
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The rework of how block layouts were checked moved the check for
NFSEXP_PNFS out of nfsd4_setup_layout_type() and into the callers. That
patch didn't account for the new call in nfsd4_setup_layout_type().

Cc: Christoph Hellwig <hch@lst.de>
Fixes: f85460b2aa22 ("exportfs,nfsd: rework checking for layout-based block device access support")
Reported-by: Olga Kornievskaia <okorniev@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
This patch needs to go into Chuck's nfsd-testing branch, ideally folded
into the patch in the Fixes: line. Otherwise, pnfs is enabled on every
xfs export discovered via netlink.
---
 fs/nfsd/export.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index e6a250576048..f562d383439b 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1017,7 +1017,8 @@ static int nfsd_nl_parse_one_export(struct cache_detail *cd,
 			goto out_uuid;
 		err = 0;
 
-		nfsd4_setup_layout_type(&exp);
+		if (exp.ex_flags & NFSEXP_PNFS)
+			nfsd4_setup_layout_type(&exp);
 	}
 
 	expp = svc_export_lookup(&exp);

---
base-commit: b858b275543b35cb0fc2bf863da017de92ef192b
change-id: 20260414-pnfs-exp-fix-b1eb96d05634

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


