Return-Path: <linux-nfs+bounces-13082-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2CCB06311
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 17:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C032D17417B
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 15:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2FD1F473C;
	Tue, 15 Jul 2025 15:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYaoPrbn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBFB19ADA2;
	Tue, 15 Jul 2025 15:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752593682; cv=none; b=pn7gRf/xZazDmZAIoHxFnSU4KMKJpaMVc3lPzHn043fwr/Nge9UcbBAle7Bf84eZ7W34dBs6kWBalECbHBtkInUh3ijktRMHJ2+4rqbTsZ9Y0x1Ct9YSafGn14D0aWxJ/+Rea+fhLsyZuc9t0wVfbMM3H2JwOfRpHADhhSYDC3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752593682; c=relaxed/simple;
	bh=UVgH8+FY1fNm43nKiNjStjzvtgIm99z/OEEPH0sYtY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4OTDKpzzXctr7oGdMkUIIfEBr0+4+K1O3GAooSMXjz4Jkt/+UqH5m+/6+IC783OQp58biEg8ef6KuKbzSXWZLNYVh8rxyPFVK8tLrz3Fi2OXhPh5jBIeklCdc43VuhINW2ymf7V9CIWVbcNDRXOj7RAyP132r/F8qpZbzPFdp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYaoPrbn; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55a10c74f31so2670975e87.1;
        Tue, 15 Jul 2025 08:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752593678; x=1753198478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kbuk2FF+f2H6MyL+EZHtdbe6/1pYCjhs1W+HV7OFIDQ=;
        b=mYaoPrbnFqLzkZ50brk+OgF1Bf5wizwDCO7ef9K2C1ow4CsCFN71j0jFWPlMrgGgxY
         pW/hie55Sa/BD6a/lBq5zzWwsa8Y5URLH48X71OWV94JoXexxrXlcMo67OLetN1UVYWc
         U3pKCzZ5IF+nw6KdbCXggNVIMp69/6m2gtvEsLGSCw92wfHGtfYZoXeRtcBvf54o8Wkc
         BS8nCNZePRrr4egYe+2ysdavclMpTbFwcd2I98aqLb5sA6J62TvNQmMRUP8o9QutHJxq
         MxS9nYs08iHro21iucePiymTJmGnwdj9d6NS9qaDvZdDu4aBLZWYh99DAW4LMSM+A2xv
         yxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752593678; x=1753198478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kbuk2FF+f2H6MyL+EZHtdbe6/1pYCjhs1W+HV7OFIDQ=;
        b=mv41PJrVw7ZoEy0qQOjwpoklXa4yfP8UvAvT56ntTtdHOWQb+04tnBUbmFf6y3Q26h
         MAOVAZQUtygXbQjWbweJB7JknauT/kD4ynxpQu+3R2D/ukN9KcXlxCBpmBzLeXZbbYBb
         GiydCVcYoMuck5e+wTC4zEc9f5KZ3F5gvAlom8F1N71iWfptfPCLH7qL6FwDiiYwZ8w8
         U30oH/HktLOFjRHgnYmgKBr1EzPaOAhY1XRNP1JFQbWGODiP9/+Sz57sgz0V1KmZTT5Y
         K5uk6ckksgp76dJiQTAx0o4MVjqGJbBjnKaPX6DovoEO/db0uZYrsYxyWXtwv1VSUuOr
         I1SA==
X-Forwarded-Encrypted: i=1; AJvYcCXIXWYDfArxuvea4rjtjpgwgO/6aIu/8n3wPSXuZtbJnsqaG8CGsVfaSFjfJSU61JrvYEqJ61hFKSJLQEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLt1INZ5HLnlBSYf6G+poAc/Ph7MyjycpwMehY7oa1iscM2MJk
	/AWY78ohvdnLCggVVJJdOMHZja65wrI/L8l56r9avP7KGLm4jJ/6qCg1
X-Gm-Gg: ASbGncuMLluOtwbpicWin7X1OO9qpymGpQhco9pxYDA/bRleqLgKMZaqKizwmPbAsPa
	eNYolO4RQJnpyybj1SuFzCmO8emXicP538bzd84GxsqHITt7/XYpwX1bgXtwi4OjE1U1p/WI2yE
	BBo6QpsbypMtMDlM+NRhZ/K7MGivQpxSxf3lIZ17ZlDOgr0VhgtBCsVQAPwnt1TZztdWrtoxyi3
	NzxqcGxQhe37Dv9xabFhAUpNbpjK/bFSDYkTEBrz3lnL7Buu3g3wPUqdn5hyNrhMBDZHp+nhaO9
	r+4R+OmUgQkqHb+gYlnL+r6KFqpbh2PeTsHxiHeGFyUhyGZYAMlwDPCu8De2bjVp4bSn5twMq/N
	dcjw7cH/ypZrlVxVu8Y2lmuuPNI1yIe1iUeF8C4VJAdXaae+mwME=
X-Google-Smtp-Source: AGHT+IH9E2X8CK8wPeReXuDzGxQLQY5HZm0azJyMFRzh4AR7tjtpXCvSUhDXOwezgJRbdeNG5q3AbQ==
X-Received: by 2002:a05:6512:304e:b0:553:2868:6355 with SMTP id 2adb3069b0e04-55a044e8898mr5248118e87.18.1752593677950;
        Tue, 15 Jul 2025 08:34:37 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([85.174.192.104])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c7e9c7dsm2316482e87.64.2025.07.15.08.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 08:34:37 -0700 (PDT)
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konstantin Evtushenko <koevtushenko@yandex.com>,
	Sergey Bashirov <sergeybashirov@gmail.com>
Subject: [PATCH v2 2/3] NFSD: Fix last write offset handling in layoutcommit
Date: Tue, 15 Jul 2025 18:32:19 +0300
Message-ID: <20250715153319.37428-3-sergeybashirov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715153319.37428-1-sergeybashirov@gmail.com>
References: <20250715153319.37428-1-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The data type of loca_last_write_offset is newoffset4 and is switched
on a boolean value, no_newoffset, that indicates if a previous write
occurred or not. If no_newoffset is FALSE, an offset is not given.
This means that client does not try to update the file size. Thus,
server should not try to calculate new file size and check if it fits
into the segment range. See RFC 8881, section 12.5.4.2.

Sometimes the current incorrect logic may cause clients to hang when
trying to sync an inode. If layoutcommit fails, the client marks the
inode as dirty again.

Fixes: 9cf514ccfacb ("nfsd: implement pNFS operations")

Co-developed-by: Konstantin Evtushenko <koevtushenko@yandex.com>
Signed-off-by: Konstantin Evtushenko <koevtushenko@yandex.com>
Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
---
 fs/nfsd/blocklayout.c |  5 ++---
 fs/nfsd/nfs4proc.c    | 30 +++++++++++++++---------------
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 4c936132eb440..0822d8a119c6f 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -118,7 +118,6 @@ nfsd4_block_commit_blocks(struct inode *inode, struct nfsd4_layoutcommit *lcp,
 		struct iomap *iomaps, int nr_iomaps)
 {
 	struct timespec64 mtime = inode_get_mtime(inode);
-	loff_t new_size = lcp->lc_last_wr + 1;
 	struct iattr iattr = { .ia_valid = 0 };
 	int error;
 
@@ -128,9 +127,9 @@ nfsd4_block_commit_blocks(struct inode *inode, struct nfsd4_layoutcommit *lcp,
 	iattr.ia_valid |= ATTR_ATIME | ATTR_CTIME | ATTR_MTIME;
 	iattr.ia_atime = iattr.ia_ctime = iattr.ia_mtime = lcp->lc_mtime;
 
-	if (new_size > i_size_read(inode)) {
+	if (lcp->lc_size_chg) {
 		iattr.ia_valid |= ATTR_SIZE;
-		iattr.ia_size = new_size;
+		iattr.ia_size = lcp->lc_newsize;
 	}
 
 	error = inode->i_sb->s_export_op->commit_blocks(inode, iomaps,
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 656b2e7d88407..7043fc475458d 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2475,7 +2475,6 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
 	const struct nfsd4_layout_seg *seg = &lcp->lc_seg;
 	struct svc_fh *current_fh = &cstate->current_fh;
 	const struct nfsd4_layout_ops *ops;
-	loff_t new_size = lcp->lc_last_wr + 1;
 	struct inode *inode;
 	struct nfs4_layout_stateid *ls;
 	__be32 nfserr;
@@ -2491,13 +2490,21 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
 		goto out;
 	inode = d_inode(current_fh->fh_dentry);
 
-	nfserr = nfserr_inval;
-	if (new_size <= seg->offset)
-		goto out;
-	if (new_size > seg->offset + seg->length)
-		goto out;
-	if (!lcp->lc_newoffset && new_size > i_size_read(inode))
-		goto out;
+	lcp->lc_size_chg = false;
+	if (lcp->lc_newoffset) {
+		loff_t new_size = lcp->lc_last_wr + 1;
+
+		nfserr = nfserr_inval;
+		if (new_size <= seg->offset)
+			goto out;
+		if (new_size > seg->offset + seg->length)
+			goto out;
+
+		if (new_size > i_size_read(inode)) {
+			lcp->lc_size_chg = true;
+			lcp->lc_newsize = new_size;
+		}
+	}
 
 	nfserr = nfsd4_preprocess_layout_stateid(rqstp, cstate, &lcp->lc_sid,
 						false, lcp->lc_layout_type,
@@ -2513,13 +2520,6 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
 	/* LAYOUTCOMMIT does not require any serialization */
 	mutex_unlock(&ls->ls_mutex);
 
-	if (new_size > i_size_read(inode)) {
-		lcp->lc_size_chg = true;
-		lcp->lc_newsize = new_size;
-	} else {
-		lcp->lc_size_chg = false;
-	}
-
 	nfserr = ops->proc_layoutcommit(inode, rqstp, lcp);
 	nfs4_put_stid(&ls->ls_stid);
 out:
-- 
2.43.0


