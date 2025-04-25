Return-Path: <linux-nfs+bounces-11285-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 240F9A9CCD0
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Apr 2025 17:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D35F1697AD
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Apr 2025 15:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7EB285412;
	Fri, 25 Apr 2025 15:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGSglEV8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A264F1E1A2D;
	Fri, 25 Apr 2025 15:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745594694; cv=none; b=Lw+Mgv/qEqbOw83kcV4/qGZxT6Nn1ekaFKL7SD1yJtL7n3pQF6PM2dgRVxkr0qIELW75eKCQCs+m5g/QwgKfEDdR4iIn1q7+xojneaTjn+2D0AboAbrZn8HrpDnLc/g+PCtHkEZVA2KAYTArOFlqx1xgk3Yl0rNa1bexOVEFvQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745594694; c=relaxed/simple;
	bh=kaoMX7lquaRC638i7YucE2U1jeL/DZcLP0xInw1YWqY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aYRLFCccfLvs7y6vFUJQ+InKdwIYuyv6AucS37fhWRZ8Lwi4evEZtulCni97TJ1/tHQvjI2MdzQPhn9PW6mGl33uyxcEsp7pFkLNknbIQO+T8XbGDgOnhboMjIq2FryPw6BHv+/C6jQIwTLFgyuVLjLqmRD6vzfg3zywGFknokk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGSglEV8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4541C4CEE4;
	Fri, 25 Apr 2025 15:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745594694;
	bh=kaoMX7lquaRC638i7YucE2U1jeL/DZcLP0xInw1YWqY=;
	h=From:To:Cc:Subject:Date:From;
	b=eGSglEV8cGgp/fyHOUp2N/VG2hZTE5uB+uZyFspSj4cDKVW5C2IBYpa9/idqZ8GEK
	 IQzeqdnlGJ0qjCMOykCgHKGO8xXa/MbNZErA+bfV3d4A8QBzy5vPSJ6vsvMH5XnRgt
	 DjDic1t3y9oE+ivNgx9750ZZRTGtFy7ozh+Ax+NH8v/1KcZrh2JPSjbfo+Mc8WxaBY
	 e0KRrbVa46ml8n0ffghh/cYCdYbcQV0VDS4Ljog/ogYQsOQt3mTJigNilacYJAB+lo
	 5GWo13tZ1umzLGjDWD/IYmzT82RDxEIBNl63VwpmZQF56w17sqk8d13my6U936Itlc
	 T9Ckl3zwUTwKQ==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	fstests@vger.kernel.org
Cc: anna@kernel.org
Subject: [PATCH v2] generic/033: Don't call 'fzero' with the KEEP_SIZE flag
Date: Fri, 25 Apr 2025 11:24:52 -0400
Message-ID: <20250425152452.105188-1-anna@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

None of the fzero calls in this test end up writing past the end of the
file, so this flag is unnecessary and can cause the test to fail on
filesystems that don't implement FALLOC_FL_KEEP_SIZE.

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 tests/generic/033 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/generic/033 b/tests/generic/033
index a9a9ff5a3431..b7df56b82619 100755
--- a/tests/generic/033
+++ b/tests/generic/033
@@ -37,12 +37,12 @@ $XFS_IO_PROG -f -c "pwrite 0 $bytes" $file >> $seqres.full 2>&1
 # delalloc blocks and convert the ranges to unwritten.
 endoff=$((bytes - 4096))
 for i in $(seq 0 8192 $endoff); do
-	$XFS_IO_PROG -c "fzero -k $i 4k" $file >> $seqres.full 2>&1
+	$XFS_IO_PROG -c "fzero $i 4k" $file >> $seqres.full 2>&1
 done
 
 # now zero the opposite set to remove remaining delalloc extents
 for i in $(seq 4096 8192 $endoff); do
-	$XFS_IO_PROG -c "fzero -k $i 4k" $file >> $seqres.full 2>&1
+	$XFS_IO_PROG -c "fzero $i 4k" $file >> $seqres.full 2>&1
 done
 
 _scratch_cycle_mount
-- 
2.49.0


