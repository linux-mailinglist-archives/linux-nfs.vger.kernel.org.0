Return-Path: <linux-nfs+bounces-11274-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13123A9B895
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Apr 2025 21:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 299A37B5350
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Apr 2025 19:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DEA2949ED;
	Thu, 24 Apr 2025 19:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khyNzJHq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75686293478;
	Thu, 24 Apr 2025 19:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745524652; cv=none; b=r8RVQmHEhES2s9C3L2p+acnfQEPcJcSRH3r74C5uaohNTowQuxZSglhzHVka9hvPyotMqB02aWbd56eXwOtYXAauup0UFNFVh2yfK7lhndC4mDP7jBs2lLISF8CbjPVmXW38QRbv9mpqpPHC9SIfjqSkOtz9yCBHK9IBTvxH274=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745524652; c=relaxed/simple;
	bh=kPfOqjz6jAr4e+5EEf2F4sYeM4jiHQmWUXimGsxSVbs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FOXY6X0F49ma0JHfU1UZJME6ax9Bit22V7Cdr8xH6cbc+l6uiUs6MDyqWL58pHBMA6Bq7WKlJuT+pNkgkkar7l96swdut/VN/nh/3kqEyVz1W+Iu0+j35MuvP3WtTvDcd1yk43lZkoBbW/odNg8/B3izOTyepXP2hNimHD0pvYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khyNzJHq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA7EC4CEE3;
	Thu, 24 Apr 2025 19:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745524652;
	bh=kPfOqjz6jAr4e+5EEf2F4sYeM4jiHQmWUXimGsxSVbs=;
	h=From:To:Cc:Subject:Date:From;
	b=khyNzJHqadT7OtcM5DulMbBY1nSGvrcuGhogghQwF3cWK/EFWq40lpdri2SIg3Ami
	 qeXC0uFFQcWP2ru8TAkU0FIU/K3m1kOMSFxr2YHuot9oftyHlj7Zo48wqhuNWKosGu
	 SfXkjZrXeJSqlXDtf/eLAqHGW4wp79meA2hlWKuQ+NKb05i9bknfX46V6uIS4qVz6O
	 7PtcBC7itY3Mc9Tkt26AOZf863pOKqTlqFn0P7vz204btSKM26tke9j5jDi9MgG209
	 MxvASjT4Z/y1JNUY96vOQeuduTS17SCuhy1JoiBChO8WRBANlSACTeB3BRDooKfOiX
	 82nbOD6dxRFRg==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	fstests@vger.kernel.org
Cc: anna@kernel.org
Subject: [PATCH] generic/033: Check that the 'fzero' operations supports KEEP_SIZE
Date: Thu, 24 Apr 2025 15:57:30 -0400
Message-ID: <20250424195730.342846-1-anna@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

Otherwise this test will fail on filesystems that implement
FALLOC_FL_ZERO_RANGE but not the optional FALLOC_FL_KEEP_SIZE flag.

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 tests/generic/033 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/033 b/tests/generic/033
index a9a9ff5a3431..a33f6add67bf 100755
--- a/tests/generic/033
+++ b/tests/generic/033
@@ -20,7 +20,7 @@ _begin_fstest auto quick rw zero
 
 # Modify as appropriate.
 _require_scratch
-_require_xfs_io_command "fzero"
+_require_xfs_io_command "fzero" "-k"
 
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
-- 
2.49.0


