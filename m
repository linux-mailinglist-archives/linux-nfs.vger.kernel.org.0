Return-Path: <linux-nfs+bounces-11336-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 342C7A9FA81
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 22:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B7D0466547
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 20:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1CD1EB1BB;
	Mon, 28 Apr 2025 20:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pV0fPsOY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B250C1E766F;
	Mon, 28 Apr 2025 20:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745871883; cv=none; b=L6A5j2aix4faz+BRQfm3BDUGmZJmXde+GX9cwrZsNdtrsEZCOt4Jin8f34VRE4HT6TokDDwhx4zfD/V2Suyh7TQuJ/rm1t91nvl8mfZQ3qJFOWMkaJ8+Y1hw5UX0ynJ0l8JbSzasVC5SweTEzXeMiqiuurD2H0vAzeeRyI3FhmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745871883; c=relaxed/simple;
	bh=nrYGlGVsPoTdqvS0ZHQ1tsED3Zl2BbfyUm21SX8CPSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m2+PsmPgiiIEoZjYOcrHCb0ktBfJ9HM1NFGYTwiYdX24jvedmDExpaNkaimi1HByteb392yqqLkDGXRDzsRwpZWUS2sMcxkowrJyedsQyuvpcDsdBycHIyuqU1RcN4bL60HOClsIFTNsVJ7m/1MQIDKlZfH5bYEtvcErSePa+uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pV0fPsOY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1467BC4CEF0;
	Mon, 28 Apr 2025 20:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745871882;
	bh=nrYGlGVsPoTdqvS0ZHQ1tsED3Zl2BbfyUm21SX8CPSU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pV0fPsOYXeYqIYNe0I7apUlE95oxFB2UX/OVJLAC0WFY5z9LOV45PJqVJDhDS4jUW
	 j6fIioRsCm5XLinfYpV7rSYiX9Aaw9aVRVmq0+vq8JGU0QEshR/aEPTzS3xBqlmdaU
	 NLkYzjl8w9upgtrrDQJ+q1CYFkZncxxv5ptWrWhCFDUF66hxmAwcBhu2v6+h3NKo3o
	 IjOok4w6kC7N0Sq/PI1DELVm+pboLnl6HTSlKHTfiF36pcsQnxWIdMadI6V3S0CFPU
	 +Qpx9M4svj/vHyB+miPO8Q+flMJR2BIKynOJa857lBGSgs3XueeApHn1XtCC4yiRFh
	 PFveQhqcHDyqQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 28 Apr 2025 13:24:39 -0700
Subject: [PATCH RFC 2/2] nfs: pr_warn if plh_segs or plh_return_segs are
 non-empty when freeing
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-nfs-6-16-v1-2-2d45b80facef@kernel.org>
References: <20250428-nfs-6-16-v1-0-2d45b80facef@kernel.org>
In-Reply-To: <20250428-nfs-6-16-v1-0-2d45b80facef@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: Omar Sandoval <osandov@osandov.com>, Chris Mason <clm@fb.com>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1809; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=nrYGlGVsPoTdqvS0ZHQ1tsED3Zl2BbfyUm21SX8CPSU=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoD+QJCa339MvenqGc/ElCSaEpQPLffxmha44WM
 SLPDByQRj6JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaA/kCQAKCRAADmhBGVaC
 FSsaEACsvcOJbOOhszZeQBXglSszGnbtXpq1r1wsYzyFcYD55hIULaaxQvqjs2IYwMREReSp+YH
 dVxwEgkKc4LY036jvgOuoYny4q97um3aNh10ixrXJI5sN3/1OH4y80Q9wSRxt+m82uNX1QQVvea
 4xo9Lh8Hy0CIMJg+/Mj64zuy4JGnWNR7a24DrVZ3Ln+GDsQkjX4KUP/k1jQzBsHA3jvEtkQs/ls
 e3v3fRXHUM9yvukm3JjWaNvMawnHRgUxxfslTad62ZhSI3tdWEwa4UypVffaaSzaPW6QmTF/9rp
 Iagw4N+pdrOLaF5s7YUR3Yh9frpk+abLM8p6xiZdMXjDzvzbBqFEuyyozQmso0nuX+b3RhzY4bj
 1b+IyCntcAyLEtmZaVeEsPlEiEPYusOWmnpnOhC7QVhiB2tYMNbcCVDEvRIswuEYRXzzRVdK2A1
 eF2DE0jZIcSWpp3RfPmX96rFjHNY4T8V7+/To1+gqU8dteUtAsZbtoaRZkK3e/fdv1/rSYTRnLb
 xm1d9tfQgYB9lyvNlFgs9kLKG2hxAP0S2sKerccmi+A9SscKnrfUqvroLR785B1VlX0hUiQ63Uo
 N8ufH7XdbME65hBvd7nsIyjDSmo5ThvUiwjfAj45/K+LYXebdcnNMDuT0Vmigl1h+JGivkYnOX0
 OWhjRqglHymu9sw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

pnfs_layoutreturn_before_put_layout_hdr() currently throws a WARN if
plh_segs still has entries when the layout_hdr is freed.

Add a new routine that prints info about leftover segments when this
occurs, before dumping the stack. Call that for both plh_segs and
plh_return_segs lists.

Suggested-by: Omar Sandoval <osandov@osandov.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/pnfs.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 0bcb5a4bd420c157069ee63457518b206223b7cb..4387b1f77a3140b88a0644db1a565a4b71ab64bf 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -302,6 +302,22 @@ pnfs_detach_layout_hdr(struct pnfs_layout_hdr *lo)
 	nfsi->read_io = 0;
 }
 
+static void
+pnfs_warn_dangling_lsegs(struct list_head *list, const char *name)
+{
+	struct pnfs_layout_segment *lseg;
+
+	if (list_empty(list))
+		return;
+
+	pr_warn("NFS: BUG unfreed layout segments on %s\n", name);
+	list_for_each_entry(lseg, list, pls_list)
+		pr_warn("%p: refs=%d flags=0x%lx seq=%u\n", lseg,
+			refcount_read(&lseg->pls_refcount), lseg->pls_flags,
+			lseg->pls_seq);
+	dump_stack();
+}
+
 void
 pnfs_put_layout_hdr(struct pnfs_layout_hdr *lo)
 {
@@ -315,8 +331,8 @@ pnfs_put_layout_hdr(struct pnfs_layout_hdr *lo)
 	pnfs_layoutreturn_before_put_layout_hdr(lo);
 
 	if (refcount_dec_and_lock(&lo->plh_refcount, &inode->i_lock)) {
-		if (!list_empty(&lo->plh_segs))
-			WARN_ONCE(1, "NFS: BUG unfreed layout segments.\n");
+		pnfs_warn_dangling_lsegs(&lo->plh_segs, "plh_segs");
+		pnfs_warn_dangling_lsegs(&lo->plh_return_segs, "plh_return_segs");
 		pnfs_mark_layout_stateid_invalid(lo, &tmp_list);
 		pnfs_detach_layout_hdr(lo);
 		i_state = inode->i_state;

-- 
2.49.0


