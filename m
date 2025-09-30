Return-Path: <linux-nfs+bounces-14801-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B33BEBACB57
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 13:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 593A019270FB
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 11:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D285425E816;
	Tue, 30 Sep 2025 11:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B70nKBU8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC79125D21A
	for <linux-nfs@vger.kernel.org>; Tue, 30 Sep 2025 11:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759232265; cv=none; b=qiFvIqaTU5ww6Qfw8qH6eoeL8cRseNwHItcQtY92+0PO79cuzx1Cmu0c7D89u57ni9l499XvPPUHuTT6BaOcn0F72Nw4Khpdf6CqeRtPIb0/MqwZcfhOgVr3iyWWhMPWaisfKwiYDZrn/NyVp9rIKO6F2VLsEfCSJ5+cdeiGtKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759232265; c=relaxed/simple;
	bh=CQQ/ZFcxYvvYRBHhHvzm4rDhg2jdRm7rxxOWt5iUc4A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F3PKcNUqYO4EsrsnU1auQrUxTZbJzAwC3sYR0KkStIRzKTxsk2y/UI87exVN9DlBUum5SK9NNxCHrTexWwMRjZIg2p4RMEWioehra5yJ1dIQeRTQAZ7Lu9Gj4vU85LA7gkwemOZhYZ7DTSdxP1a8clBzyAzt+tybXH5COYdQv3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B70nKBU8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10445C4CEF0;
	Tue, 30 Sep 2025 11:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759232265;
	bh=CQQ/ZFcxYvvYRBHhHvzm4rDhg2jdRm7rxxOWt5iUc4A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=B70nKBU8wRX/KPIp2PD6t0LfrZCgsTr2cLzib9vp59FmjLlMfM/QzfQbNQPVNjKmw
	 8ZsIa65WloY5OcJGxBWWYQyPe19X3Swdikp4gOrm/uAqIKZS+iuViZhgvLD1XEleEc
	 jh4kBXT/lDAM3SZi5r9T0GnlE6DvIDmh6eXcz5DPmY5jZNO8l68uyW4tGxHRUV+K69
	 UIp9A0/crlAPqMHt8pwReNAKE8clQgPpzVdOJ99pzfhJtf7Xz3JbnFyWlOvCUiNgFl
	 l0S4d07nahPZtEFSgZErprE75V0xR1eVeNjc0mPMdwizOzMoF0YvYvHoX5O6BFpM2T
	 6IqMT8q3mZLaQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 30 Sep 2025 07:37:36 -0400
Subject: [PATCH pynfs 2/7] pynfs: add a getfh() to the end of create_obj()
 compound
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-dir-deleg-v1-2-7057260cd0c6@kernel.org>
References: <20250930-dir-deleg-v1-0-7057260cd0c6@kernel.org>
In-Reply-To: <20250930-dir-deleg-v1-0-7057260cd0c6@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=886; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=CQQ/ZFcxYvvYRBHhHvzm4rDhg2jdRm7rxxOWt5iUc4A=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo28EGZvKAZgB1grkfPoJkrSM41J5Tgv2B1WDac
 0g1HFV1rMCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaNvBBgAKCRAADmhBGVaC
 FeGxD/93K2rpwCXpND3N3I7ayT4ZvziaxxCrAbEs06RuNxXGBt8UX3DsuOeC4SwA+wvTde7IE3G
 zV3YJR9Zmtqgm5h/IgCbazxXFUuonhUAtcLMuIj6nQsGmmL4ac0x1gTQINMgq0vCyikWpKzEaea
 MQRASj54ehBmje/Hz5LBCn9bd9Ov5iVqtrs1cVuwPXPT2+T9oyEE2BCbFIIZ7ULi9hwVSDrYpoi
 rDTS23x3m36P24vLbn35KaAd5y94RHyutdueiY6oZDIddhk+Y08+NTOVPLXNzbe9g7nP+e6olKa
 80sy6f+6wPBSQrWe1Xg0s3efaDh8OqnmBobAG6yCJtp1PcJjlzUGHiKNbakTWbtcarDzXuzqDo5
 gKztSAB5rt/tlt4AC++4IPNto8qVLJOabPBu5pamTdzbI34URsS49hjwvxsxnyTuEFuNmOJ9+Gp
 QJmdlZmp+U0Z8vWLzwC6iVULcG1DxBbujgmNuLkmTfK12R24PcCH1E4fOr6uZkiOmEMAP19mnTb
 zxT1RgjkLgyg1uR58TWrUdeoZcDeqzKYLNrPo4MTTyYd7E197cmosomvMPP+JE+K0gwknFqo5Gw
 CXmpPb5vB4N+0tcILj2f5YC+2lhatIYUKSgG0xISWce+Tt736255TZHHKEouTE0s5QU4y1yUC+B
 NGHaivxkVk44mtg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/environment.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nfs4.1/server41tests/environment.py b/nfs4.1/server41tests/environment.py
index 48284e029634fff60b7690e058cd4131bfea9b08..add13d8565e6529406c3b0db53f4e1396dae846a 100644
--- a/nfs4.1/server41tests/environment.py
+++ b/nfs4.1/server41tests/environment.py
@@ -474,7 +474,7 @@ def create_obj(sess, path, kind=NF4DIR, attrs={FATTR4_MODE:0o755}):
     # Ensure using createtype4
     if not hasattr(kind, "type"):
         kind = createtype4(kind)
-    ops = use_obj(path[:-1]) + [op.create(kind, path[-1], attrs)]
+    ops = use_obj(path[:-1]) + [op.create(kind, path[-1], attrs), op.getfh()]
     return sess.compound(ops)
 
 def open_create_file(sess, owner, path=None, attrs={FATTR4_MODE: 0o644},

-- 
2.51.0


