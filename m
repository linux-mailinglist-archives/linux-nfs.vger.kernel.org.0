Return-Path: <linux-nfs+bounces-12558-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E95ADED9F
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jun 2025 15:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5B553AD33A
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jun 2025 13:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18142BD5AF;
	Wed, 18 Jun 2025 13:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGI2Ezai"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9156274FC2;
	Wed, 18 Jun 2025 13:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750252773; cv=none; b=azD8e7yIATg5exetnXYJ1kuPc6jLMwBW6Gc7rTDIegYevB8AqBC/VJfHx8kHQCTwFulDzoGbObI51OrAX2Di7NnlnjQGHeizOLCgGF+JnEnrVXXbxEzNzBMBk8/HLYMRZWjD6nQASRGcQbm+jGjuOit0OS6iODHRYAIrb+C+lEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750252773; c=relaxed/simple;
	bh=DZyzzIc3AGQ3W0P72z/SHMNeWzh8U1DkI0gzYBE68FM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Lm253tOc4Q0Bv4aer0q+eADvdq2OGjDwGRQVP5MiVJco33kqNQMfvKGiiqvVUJu5mZ/QlLQM3wbPK5jEb3FULvbM1ElWxp9fbfke+oy99qBkIEtPmZT/u+5jCjtjyUCR2shNXFDIINjit3c2eccnxd/WIEFra0tBiagkyBf5JnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGI2Ezai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF725C4CEEE;
	Wed, 18 Jun 2025 13:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750252773;
	bh=DZyzzIc3AGQ3W0P72z/SHMNeWzh8U1DkI0gzYBE68FM=;
	h=From:Subject:Date:To:Cc:From;
	b=KGI2EzaiyDhZ6TXOYHLiGTz+HphoILHn5gq3yoJ6CONMf2iISLYN5Qt39Eu8/jlBF
	 pCEel/dGqwy+bSvC2ZwhVb4I5P6FjyColxIziWk3tNFwpNOHRTt8cYC7IMI4M96ygZ
	 eD18E3DksisvGtemRuy1v0aOIzTHHLOtM7kTmls9Avj/bM7Ma5qPO3l3rU/3trEXKG
	 0QlO4fP9Ch9PK/WAE88mWS+ojaOFl/WB0Ej2WOTLstZTAqSLBWo1Rsv6HwPE+QY28Z
	 s9HbTPwAjCAAriM/vb58OpGBp76pInoqLUCwNk245HBq2rUk1RxmjdM3XD+7ko5Gxl
	 nvhNSNQTdRs3Q==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 0/4] nfs: client-side tracepoints for delegations and
 cache coherency
Date: Wed, 18 Jun 2025 09:19:11 -0400
Message-Id: <20250618-nfs-tracepoints-v2-0-540c9fb48da2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM+8UmgC/3WNywqDMBBFf0Vm3ZQ8NEJX/Y/iQuOoQ0sikxBaJ
 P/e1H2X58A994CITBjh1hzAmClS8BX0pQG3jX5FQXNl0FJ30koj/BJF4tHhHsinKKRp267tlVW
 mh7raGRd6n8XHUHmjmAJ/zoOsfvZ/Kyshxayt6hYzTWjd/Yns8XUNvMJQSvkCDKA+mq8AAAA=
X-Change-ID: 20250603-nfs-tracepoints-034454716137
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Benjamin Coddington <bcodding@redhat.com>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1151; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=DZyzzIc3AGQ3W0P72z/SHMNeWzh8U1DkI0gzYBE68FM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoUrzcOSPkc3kqAWGyzOJGbJV/blLFtSVtm0psp
 11Ocz5xsqyJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaFK83AAKCRAADmhBGVaC
 Fe1QEACeNncHAPcf8lDSo+C3WKpBbbGfg3J4saljQjwhijELFzIJnU/8i9zrnqfxKHDcN8lEwtL
 y9yjyiPt9eOvOOILNPRATvHrcsfvaid1k0Dy5WPA7bM6k/iZcBtUTvIIH21KyjBWHFeyC+dEiIT
 c4dL7ae+RFwzMfQxphLVC3ZOrL9vVHiXYZLlbbFGg2rzR4FZhcg8ksCCpWsK05Lj4Jy6aKVuLdU
 vJeqRJIdusTb08+p/ROoV80Uc6HOV1mlMySLL0Mqi3Ie3454O5adcLQtTvjXHpufQ+kAhZOfBew
 uhjLJtCQwSj4q6/hF3WzREfuOD1LRgyZWaCfreZhbH4v05+oBEQWoy5bjRUlCOEzkuxfCJzpb/f
 E7anOm/CcgAlNZXKuKgn18VsUk/61Ff0VNHtQfX+335Kci1DIZwaij9q+rjZz2lciHfWf6Fc2U/
 U3d9MulnF3VdDN7fuQpIaHhGW504Oe4zcCV+GLzG43ACQBuRdS8Mu7VvZOrz53A/p10lSOBgz80
 uanb3kkeozLhMMFm71aypDTNTLyYk4f1YqocOHH1U7Hz1gFsarCdqXzGOlbuwk+v4jvmqyd2WVp
 eLjiol+Z3uSuYNP6gcDhu7O/xllHwO77+yLpc91FwoCQlbM5FLdlIdFpm0TjRHh25VZS2L9IMo5
 ICMD+RmVLY5ikhw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

These patches add some tracepoints that I rolled a while back when
working on the client-side pieces of the directory delegation patchset.
I think that these are useful in their own right, even without dir
delegations.

Please consider these for v6.17.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- add NFS4_FREED_STATEID_TYPE to match_stateid tracepoint
- Link to v1: https://lore.kernel.org/r/20250603-nfs-tracepoints-v1-0-d2615f3bbe6c@kernel.org

---
Jeff Layton (4):
      nfs: add cache_validity to the nfs_inode_event tracepoints
      nfs: add a tracepoint to nfs_inode_detach_delegation_locked
      nfs: new tracepoint in nfs_delegation_need_return
      nfs: new tracepoint in match_stateid operation

 fs/nfs/delegation.c |   4 ++
 fs/nfs/nfs4proc.c   |   4 ++
 fs/nfs/nfs4trace.h  | 105 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfs/nfstrace.h   |   8 +++-
 4 files changed, 119 insertions(+), 2 deletions(-)
---
base-commit: 52da431bf03b5506203bca27fe14a97895c80faf
change-id: 20250603-nfs-tracepoints-034454716137

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


