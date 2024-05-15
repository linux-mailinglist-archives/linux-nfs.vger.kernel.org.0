Return-Path: <linux-nfs+bounces-3258-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F26BE8C6399
	for <lists+linux-nfs@lfdr.de>; Wed, 15 May 2024 11:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A98071F234E9
	for <lists+linux-nfs@lfdr.de>; Wed, 15 May 2024 09:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C4557CB6;
	Wed, 15 May 2024 09:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="k2nh75pv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B6356458;
	Wed, 15 May 2024 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715764999; cv=none; b=ODrcIWx5Pi8tgvkZ+ToqIB9us6npw8K1DAP/Jaqhlv21pu+w72So3rUrJT4WpPPwX0hwbTts89CWgfwAVpy800kTCCfC5cfbIMzu6YESH4deqTSz3qtRx4ugUc04O4MCTiX0gEwnfb/GPNzozcvteE81eltsqH8MZ10rvAvMmGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715764999; c=relaxed/simple;
	bh=fr8U6ULYhGSysmuHI/1XB4gPqr15FfbX85nqDdMXJGw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d1gudf0w13jqoOygTuOH9Dn5BbFhrmDWajaiZvgl8Qk0I2wUeNl2Lo9QH3bkTRnEI2YyK9fR53qmzp6j+zjpRzOt9lJTp5IoiglEtNbrM2UUVAdpKfmUmPCwxVSYWLxXPzyiLqvjHFyrNgYHCG2KOuEL3EUuguQYZqgHdUaeF/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=k2nh75pv; arc=none smtp.client-ip=68.232.139.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1715764997; x=1747300997;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fr8U6ULYhGSysmuHI/1XB4gPqr15FfbX85nqDdMXJGw=;
  b=k2nh75pvUMGgompw6XMwAhEIP6Thj3ousjkF/zUMUB8KEA6q39JygKon
   1LTesV7jxXlKhTnVvPnnZ1TKLp2nvYmhr/66Mtyv382qYPQmPzLDGprNk
   ygXAczngy1IWK+N6ks7lC6/NFS0Vd496Edpb6O3UUAPHPUftHPA7EiHK8
   te+QtJ6p43IloWpiCtGU6bEjBDgxA/hZEljrz1J3RLcIQYf+RF94+b7Ae
   EDK0hGqTWnlQ9ZYOKEezTIKv7jPfrEaQdA+HtnVcEJKWMHUCfPuFWBi9C
   5bxnQqCLg9NdzifU8zsSpWn7Tv+l3TPC8sa6/M2fzw+iM78VEifAVzchO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="160387670"
X-IronPort-AV: E=Sophos;i="6.08,161,1712588400"; 
   d="scan'208";a="160387670"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 18:22:05 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 65544CD6DC;
	Wed, 15 May 2024 18:22:02 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 98A5214513;
	Wed, 15 May 2024 18:22:01 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 1E65D6CB17;
	Wed, 15 May 2024 18:22:01 +0900 (JST)
Received: from G08FNSTD200033.g08.fujitsu.local (unknown [10.167.225.189])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id B6DDB1A0002;
	Wed, 15 May 2024 17:22:00 +0800 (CST)
From: Chen Hanxiao <chenhx.fnst@fujitsu.com>
To: fstests@vger.kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH fstests] generic/742: don't run it on NFS
Date: Wed, 15 May 2024 17:21:33 +0800
Message-Id: <20240515092133.1219-1-chenhx.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.1.windows.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28388.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28388.005
X-TMASE-Result: 10--1.234100-10.000000
X-TMASE-MatchedRID: NOa955NDYOSHYSb76u64fzyjd/AizytBAZn/4A9db2TAuQ0xDMaXkH4q
	tYI9sRE/o5C9bTTxaUZ7/ppjELPtsh8TzIzimOwPXDuuY6zZZfPZs3HUcS/scCq2rl3dzGQ1Wz5
	CTyymPMtESG2fOHz5j3cDyrsaI1ixf/ubDltRgQnlKpdyVHXzBWMiBwoaOnTWo5ygWaR3cL93TG
	UN75h+2TniS3uCSqAT7jOrYwIKPdAVxRB/din+uJ07T8ZSLiAVvR84/OmB1wQp4n8eQBnwiw==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

This test requires FIEMAP support.

Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
---
 tests/generic/742 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/742 b/tests/generic/742
index 43ebdbc6..aad57f2d 100755
--- a/tests/generic/742
+++ b/tests/generic/742
@@ -30,6 +30,7 @@ _require_test
 _require_test_program "fiemap-fault"
 _require_test_program "punch-alternating"
 _require_xfs_io_command "fpunch"
+_require_xfs_io_command "fiemap"
 
 dst=$TEST_DIR/$seq/fiemap-fault
 
-- 
2.43.0


