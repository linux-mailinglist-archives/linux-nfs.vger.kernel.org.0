Return-Path: <linux-nfs+bounces-2443-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A05EC886A7B
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Mar 2024 11:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34B131F23D8F
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Mar 2024 10:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A896335B5;
	Fri, 22 Mar 2024 10:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="rxIRZCP9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0010A20B27
	for <linux-nfs@vger.kernel.org>; Fri, 22 Mar 2024 10:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711103800; cv=none; b=Ig0VN3rT//rlRePHCbj65uAsYiC8/iVE8RX5EFS5QnTyYzE+kwJZ/GxEI2ojihmwIewSqgYuLIHOTNuPi4yMyye+zOdKOyBP5svqWgFdWT7sITFJIwl1QbepXTKkvrcnefwnj/yKI/aNZkFkZeiuSpbncRyApDB3CsIlJk+dt6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711103800; c=relaxed/simple;
	bh=H/2jvz3tr3kv/UISS3Rir6reSq2vhNGrC594o3o9w2s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jP3IobyahmCHMkq804YNAl4G1R1wAItmCQMAgcg14z3G3gDfLR+8g39CJUqKT6U3yTvhfAFjkFkVSU34GoUNjT4oPzKdd+ADc4Rx9zgNU0G0q+xEWvAxnVUgfOcirwfbFsOUXVNSAkO6Z1W55xSKjLusbZg4pjPzIteaTq2pt/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=rxIRZCP9; arc=none smtp.client-ip=139.138.36.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1711103797; x=1742639797;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=H/2jvz3tr3kv/UISS3Rir6reSq2vhNGrC594o3o9w2s=;
  b=rxIRZCP9b0hr97eDtaMyjH9AA+Qwhyn/4LUyTNSNLriED3Dt89HNjjjL
   D6DeJ5zOMxNdXsc28mdboLso6hTM9xay/ug+INeXl1yPVK2To012WamDS
   7PNjlX3IZS+i8WInw/8KX3PSR/zVZg/GWtICT2H0SrDcetYsZlKlLHDdw
   sghHaxRdSgEqwojlgHC2B1dTXU3toMMs4eOK/gWDTtxIMJtf04bZEt9KJ
   CMaxtfcwvFTxMahxUk+eGmaoB93kk0YQj8XziSz1doAGaxzZK9FbPitGR
   hEBky7sUCIL0+EiftVpaFHAaryCCz6jnryiuJkeP4ymoJUtDSeaYloa3k
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="141487997"
X-IronPort-AV: E=Sophos;i="6.07,145,1708354800"; 
   d="scan'208";a="141487997"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 19:36:28 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 14FD3EB469
	for <linux-nfs@vger.kernel.org>; Fri, 22 Mar 2024 19:36:26 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 4605ECDA72
	for <linux-nfs@vger.kernel.org>; Fri, 22 Mar 2024 19:36:25 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id B07AF228831
	for <linux-nfs@vger.kernel.org>; Fri, 22 Mar 2024 19:36:24 +0900 (JST)
Received: from G08FNSTD200033.g08.fujitsu.local (unknown [10.167.225.189])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 2C6BF1A006B;
	Fri, 22 Mar 2024 18:36:24 +0800 (CST)
From: Chen Hanxiao <chenhx.fnst@fujitsu.com>
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH] mount: reject "namlen=" option for a NFSv4 mount
Date: Fri, 22 Mar 2024 18:36:18 +0800
Message-Id: <20240322103618.1270-1-chenhx.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.1.windows.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28266.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28266.006
X-TMASE-Result: 10--2.044700-10.000000
X-TMASE-MatchedRID: m5YRaeAMZa5OBjuTIREKLfCCu8kVj0TRrzD8YrC59vxXGTbsQqHbkr8F
	Hrw7frluf146W0iUu2vcy8zPIAV4G8witucT3dE7XYWcmn4D4qsL//VMxXlyExwSIQKeKdA3o8W
	MkQWv6iV3LAytsQR4e1cppCzPq+1UxlblqLlYqXJM4QHSCYeOXpj4c856vzcE7Kr1dy/tKglo1u
	e5wEYpm/waiH8R8cAA3uGaND9++Qir6p4V70zuH3F/cojPjwNM8YChsASDjqwRZbRsQk5MBUB1Q
	Pq9bxnWZkAxAwjIrrMHz/H0kiLyEqGAtHMDjkk9
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

namlen is not a valid option for NFSv4.
Currently, we could pass a namlen=xxx in a NFSv4 mount,
the mount command succeed and namlen is ignored silently

# mount -o vers=4,namlen=100 192.168.122.19:/nfsroot /mnt/ -vvv
mount.nfs: timeout set for Fri Mar 22 14:22:18 2024
mount.nfs: trying text-based options 'namlen=100,vers=4.2,
	   addr=192.168.122.19,clientaddr=192.168.122.15'

This patch reject "namlen=" option in a NFSv4 mount.

Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
---
 utils/mount/stropts.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/utils/mount/stropts.c b/utils/mount/stropts.c
index dbdd11e7..028ff6a6 100644
--- a/utils/mount/stropts.c
+++ b/utils/mount/stropts.c
@@ -780,6 +780,15 @@ static int nfs_do_mount_v4(struct nfsmount_info *mi,
 		goto out_fail;
 	}
 
+	if (po_contains(options, "namlen")) {
+		if (verbose) {
+			printf(_("%s: Unsupported nfs4 mount option(s) passed '%s'\n"),
+				progname, *mi->extra_opts);
+		}
+		errno = EINVAL;
+		goto out_fail;
+	}
+
 	if (mi->version.v_mode != V_SPECIFIC) {
 		char *fmt;
 		switch (mi->version.minor) {
-- 
2.39.1


