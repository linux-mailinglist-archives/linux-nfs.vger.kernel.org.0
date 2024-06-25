Return-Path: <linux-nfs+bounces-4303-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87ED191721C
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jun 2024 22:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21DF8B22596
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jun 2024 20:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5652E17D8B6;
	Tue, 25 Jun 2024 20:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzMLJD7u"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3022217D88A
	for <linux-nfs@vger.kernel.org>; Tue, 25 Jun 2024 20:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719345734; cv=none; b=cc3ueP9DnHrQgkMmwy0F1CNkWUPIlg3EuG4IIud8RqIfk6Re3VU1rCLkehj1qugDFFosQddTKygJIFVYqypzhWhrcqeYxIAIC4Xey8hkr4Blh4Z0kLcy/K5ko9loRsTN5GnnHcLM6yXgP72sjoBVt6S65aSzRak5kd4oFvI93V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719345734; c=relaxed/simple;
	bh=+25eUVINz/kzrahc+5v7rOKGU4thb1ghvSXNvs5vpsM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oHYb0NgAnAFWIg8DUK1mQEx3LD3Ey6TYSK/2+l7nGwdbAECZx/baMhvc1wMGopplmQoKu3MQxUsKwvTESm5oWF23DhiCbxQmdrcZAivURsaWNL3UZWixRpFcggeihQwQdv9zN7SDtpUwGB5CyP8GTspq3wcJ3X6k574yfX/7gLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzMLJD7u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC448C32781;
	Tue, 25 Jun 2024 20:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719345734;
	bh=+25eUVINz/kzrahc+5v7rOKGU4thb1ghvSXNvs5vpsM=;
	h=From:To:Cc:Subject:Date:From;
	b=hzMLJD7ux9shOI1L3A0M9zkqSKL0AIvbSJCUcaF7oJSfI2UZiCEoIrLHuivHpLjTl
	 znpud1OhNCS1sE9R96ZlGerl5/vwoASpiogbpWrvVMYw5YEDN9b1jmWXSSdjHaMoOg
	 ZoPSS2dVdP962N7DxI+RChycvHXlYVmC1/lmNk7zNbNFE02CKKEAa39R1+5fyAT091
	 TS0Ar/vq57Y2cLwwXheSZj4XIWu9SkTnnrzNRGIm8pGTElDq1Lb+HXcfYhwwy659ll
	 o3pAz03VKh0gtzlh9gnhiia2LloF3zraP96Bl+Nmtjnf6wUHz+f1AIW0O8PVFCDrES
	 OuxrMkNeVwZJg==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 0/4] Patches for pNFS SCSI layout PR key registration
Date: Tue, 25 Jun 2024 16:02:05 -0400
Message-ID: <20240625200204.276770-5-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1079; i=chuck.lever@oracle.com; h=from:subject; bh=3H8vOAvlzR4srkgcM7s/Qvc9aNZIQCYKBgx2APVPWow=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmeyI8jYBxtv7bkEGOJPukGehBNoIKDG4wMoqvq jsEYpU7rWuJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZnsiPAAKCRAzarMzb2Z/ l7GCD/sHURL24ccNqRtM8mZI5V8rFmatSXMiHpM2CMo3FodJvSXrh5PMGhAPtzYO1Mjgot3CWSD YrCnDWphU1liI9gzhAf7Mz9A9JeoTgbw2ySFBXf8AQXjt5YvPpf+w9TwB4NXFhz7F921QiAgb+/ mugDWWHgE6Pa79X47O9UPHjVl+FnVLsWX5d6dECXn6Jfcx5fMy9oMVH16ThjC4cP2ItmD1uGCXQ PN1BFGrPBODaiTPUWCcBsydWq7PTBhUt1Pz2CgAfgw6zLalGMkn72qvZ1BB90pcxkZIY0GW2LYT +TrGB2rv9uccXDZpASTQLglDekCSPfBrAmoVTIH4YV3oXT3eoC8zpne+lglRkLZEkABJZk4BNXS QBRorwXoSUzY+Zo0h+alZYKExTx4rrUTplGDG5KaMODpDauS1ot1rQrnEVEvdDJsOoHvFfU56bV BonnNTp3H80ued27RWPdAIU0cSwsaogOaQX9yjtteNDJiKxyq5LO1Bfp2UUBoU2cDGjp5G6ddiy CW/ZkPaq1MvybC8FJZ5vcich505GXre6UVAoxOgSRdnZpkOYZpkcu8uwSqsPuh3hfZyD5dcbrya DKi7NoIJplzAGdAfbW6f8cmanl5lBWNPxpP0OVRF4Xzlvzy8oyiRQvlf+qg7noeSqLG34I9ztnh sTB77mQr1vE33zA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

I've dropped the alloc_bulk_pages_array() patch, as it seemed
slightly less reliable than allocating a page at a time on my
small-memory test system.

I do not currently have a set up that can test slice/concat
configurations, but the simple/scsi volume type is stable (except
for generic/450).

---
Changes since v2:
- Support more complex volume types
- Dropped the alloc_bulk_pages_array() patch

Changes since RFC:
- series re-ordered to place fixes first
- address review comments as best I can


Chuck Lever (3):
  nfs/blocklayout: Fix premature PR key unregistration
  nfs/blocklayout: Report only when /no/ device is found
  nfs/blocklayout: SCSI layout trace points for reservation key
    reg/unreg

 fs/nfs/blocklayout/blocklayout.c |  25 ++++---
 fs/nfs/blocklayout/blocklayout.h |   9 ++-
 fs/nfs/blocklayout/dev.c         | 116 +++++++++++++++++++++++--------
 fs/nfs/nfs4trace.c               |   7 ++
 fs/nfs/nfs4trace.h               |  88 +++++++++++++++++++++++
 5 files changed, 205 insertions(+), 40 deletions(-)

-- 
2.45.1


