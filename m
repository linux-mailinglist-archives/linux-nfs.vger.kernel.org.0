Return-Path: <linux-nfs+bounces-4529-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D809924237
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 17:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E020EB290B4
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 15:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941DA1BBBC3;
	Tue,  2 Jul 2024 15:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbwrpHKL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB911BB6A9
	for <linux-nfs@vger.kernel.org>; Tue,  2 Jul 2024 15:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719933618; cv=none; b=q913xRpfxeB4LfHN9SluCh9z1bofuLhMcYN/nQ40uBDp/F6Qu/culIljySQAPd3REkJiythkmj8IJDhSwYgXbc+VKhvu9z3tegNl5tyD9BGF65uU2+/bZh3fFPJ9qtB/+AM50Xvr4jPDXpF0569vvPsoEbd+EiPXVuhhEgACpvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719933618; c=relaxed/simple;
	bh=zVSe19MLa1slkzxgl7ntV/Oi30w0dqs2gNOynpYLGnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RfhE9CyAS6DkJcsEkH0y/LJcIHKi6/bd/u/DzlZHRqh/+QHsoIBRKX84MkWLWuVQby2v5xoq41jL4Ogbu8CNZT3+kfcUbeoXX6PRCn5mYwRfwbHZz32/v6zeEAH77rFmmSNrju5wIY3oq6rAn4mGbuS4smQbdgVfEnkCwtbzSuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbwrpHKL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B48EC116B1;
	Tue,  2 Jul 2024 15:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719933618;
	bh=zVSe19MLa1slkzxgl7ntV/Oi30w0dqs2gNOynpYLGnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZbwrpHKLKfGRaigXQxURHa/Ivacdnu2xuU/ix7KW5O7CE4PgHMPFN1AGna79jbWVU
	 xLlDTNSMeovVhRW3tLrwdrtvWliRMPS94USIXF3t9QVDDhMnQf781i4OdJvJ5k2p5c
	 d9N0glFv/6+ZnelC2pINHLCW5pLHdcoo+QZluzCcxTN5PueTRDddWvOEGIVK4+Yk2e
	 88iaiyWIx/gsGTFuYqeLVAMTp1wtBlUDkjwuoQvWhzqG4Dwum1MI5hRlHf1HN9GWXP
	 y/UIYgSGTwyL5aTGIhBdEDec/vA9Hdi2mtlJkTXr669KCdqQYqKbA3SOmx5JVXD4tn
	 Hrj0wjTXRd4Nw==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 1/6] NFS: Fix typo in OFFLOAD_CANCEL comment
Date: Tue,  2 Jul 2024 11:19:49 -0400
Message-ID: <20240702151947.549814-9-cel@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702151947.549814-8-cel@kernel.org>
References: <20240702151947.549814-8-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=546; i=chuck.lever@oracle.com; h=from:subject; bh=FouNxurNnc7KaV/m3hYXhCzOdaMvMV0gIbtNAiH2Mpg=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmhBqZr+dDyB/Pw/NdXpxgPhGvDjUZ3WU8CksI2 Vx/DVdRfKqJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZoQamQAKCRAzarMzb2Z/ lx14D/0Yj8VlofOZmxh/FnomCnfHZvosNarfUn5K6riPiPvAY+Kb4um594Chv65G0LmNYxh0POJ v+uvG7veoR5UCaMoenmS+dbM+SQsOrxTMpmo4Qge8Ze3DrUo9HETGzPPBPNpFOIy2wqzGlhzFqj OBue9zTARnwcAf7NyoJZQcDMziUV9uRCYg0l34JilQg13m3DPWkzf70/V3cbi+iGmWTtEppCSjD UI3kU76Ravnoannw7sXAFo0vE//siHKqoc90Xra1qulBapsEeTtaNh4Q9oOOkO2MS+TAJxXim/k oaiHDuZgUw56yJdR/Ydgz5Kz2bDQ/jX9Jnmtd2+y3mmj1vxiS9wgmUjHIVVmo4II8yl9GEl/rYQ zRPXIWSAhQLL2pE9W7udvJ8l7L5yasxK65MBZumF30z56fU1y+8FSMooecqKCxBnwXo3JlQPwrR AxUEcuQINR8AFoaTi4xJyDM+Zv4AUBMS6wf1EM6J6f9AoHKU53ReWXbcsgMifpCF5MZBKwbWV5h 6sbJrRIu6or+LQtmZs9NYpK7qUiJ5eYXYAegp8sYvpsufYNZ7N/VCgSDtZrmHs11/WFYKNGUlXL Tb3RbFzl9xlXlQabeAKGqHQFlp9pM2vZOYPUEofu/yvERAFSC/WJ7+eN35naS0TSBv0x/Kdlyr7 IEt7QT/BIIuU6ag==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs42xdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index 9e3ae53e2205..ef5730c5e704 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -549,7 +549,7 @@ static void nfs4_xdr_enc_copy(struct rpc_rqst *req,
 }
 
 /*
- * Encode OFFLOAD_CANEL request
+ * Encode OFFLOAD_CANCEL request
  */
 static void nfs4_xdr_enc_offload_cancel(struct rpc_rqst *req,
 					struct xdr_stream *xdr,
-- 
2.45.2


