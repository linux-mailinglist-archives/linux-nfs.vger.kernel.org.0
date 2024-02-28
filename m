Return-Path: <linux-nfs+bounces-2107-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E71386ABEC
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Feb 2024 11:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0E661C24411
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Feb 2024 10:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781E437171;
	Wed, 28 Feb 2024 10:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="WFs4QqHL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463CC3715E
	for <linux-nfs@vger.kernel.org>; Wed, 28 Feb 2024 10:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709115083; cv=none; b=OJgYTj6Usd4OgDH77aJFt1WiOQOscXGN1O+Pz8plX1e0fdnvJo8Zy0xjAlbJ7ZI+2eXPLs4p9CBXYC9Zfye2g+EoowaLYBt+p9yi4WqyVfixMuX+XzcNkgplpZZuSBXqiFmzC/GdyPWeFJPYtNgUxWSHw4uD0aviozADA91Lj7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709115083; c=relaxed/simple;
	bh=mVKgmCUHe0c0160A4ShHbZlLQFhwEJi0mA8mdQxXDRM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dgEjj7s+O/JRVNQkxQFYFJJsMeSqSPsbs5zqrqBp37jUFcDufcdjgsDdiFmsOdMBS0tFDSJNJpQk8qVgrIm0T90CCf7mW3SIHd7U9tqhiuZ6f4yamhXHkPonBIBKll3R+qMAMWR4x14D3Mguc+u+lrxOxfp81TNTJ8kb949Af54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=WFs4QqHL; arc=none smtp.client-ip=207.54.90.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1709115081; x=1740651081;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mVKgmCUHe0c0160A4ShHbZlLQFhwEJi0mA8mdQxXDRM=;
  b=WFs4QqHL8eL38OZ3FPdGnX+n03JLohQuizzdZ8bnEPfOFFptENS4//pD
   zo7mw+HjCAATTK+u8LKe2Zh1FZiqBqmxt5qcLeHWHBH/Bedyh/ZFeHriD
   zzExdrGTvQcza2iqckN20xPQlA5ImcubeTTG0FtMWKONGfMmadkyiA1np
   PlnfhdIPWOLbXZivQVuKPw8gQ3fZnRqufC6wOgCgruQkyYajGpXcdes19
   e/7QZevP/U5VoAYT/8lVxXIqpTIN0EpwzTOKu2GE3RTrUVct9S+lgvZJl
   cmmB2acRvQuu+Fetpd7H/Xa/Jb28W36dBHrp7Jva3KBd6CVS61N8uXTEx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="130059992"
X-IronPort-AV: E=Sophos;i="6.06,190,1705330800"; 
   d="scan'208";a="130059992"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 19:10:10 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 89D9CD4807
	for <linux-nfs@vger.kernel.org>; Wed, 28 Feb 2024 19:10:07 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id B91C9D41C8
	for <linux-nfs@vger.kernel.org>; Wed, 28 Feb 2024 19:10:06 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 4BF5F2008FF86
	for <linux-nfs@vger.kernel.org>; Wed, 28 Feb 2024 19:10:06 +0900 (JST)
Received: from G08FNSTD200033.g08.fujitsu.local (unknown [10.167.225.189])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id B57ED1A006A;
	Wed, 28 Feb 2024 18:10:05 +0800 (CST)
From: Chen Hanxiao <chenhx.fnst@fujitsu.com>
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] exports(5): update version information of "refer=" option
Date: Wed, 28 Feb 2024 18:09:57 +0800
Message-Id: <20240228100957.659-1-chenhx.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.1.windows.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28218.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28218.006
X-TMASE-Result: 10--4.693000-10.000000
X-TMASE-MatchedRID: /2NGPvLZz+NHRwCgLVR8bTllFsU0CXSPrthpnZXZolCAI7Mvq/sL5yvG
	qScnsLroIvrftAIhWmLy9zcRSkKatcc6R/b4owP8WTWEh5N2a9GRiObUuJBGYT19y/o3/Xfgo8W
	MkQWv6iUoTQl7wNH8Pg1fA1QHegDv3QfwsVk0UbvqwGfCk7KUsy28tscA3ij+oTSMBvnf8wDf1s
	uzMdCGLYDLKb3crQxym9CiiGhD3DWYwLHMn0XdcBN0rqZByWUp+6jQAmIMdcBg8P2QJ9Oa1iHJp
	2UYVccqxOB8J0pRLhyJxKSZiwBX6QtRTXOqKmFVftwZ3X11IV0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

"refer=" is a NFSv4-specific option (as per RFC 7530 section 8.4.3).
Other client version will ignore this option.

Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
---
 utils/exportfs/exports.man | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
index 58537a22..c14769e5 100644
--- a/utils/exportfs/exports.man
+++ b/utils/exportfs/exports.man
@@ -445,6 +445,9 @@ the given list an alternative location for the filesystem.
 filesystem is not required; so, for example,
 .IR "mount --bind" " /path /path"
 is sufficient.)
+
+This option affects only NFSv4 clients. Other clients will ignore
+all "refer=" parts.
 .TP
 .IR replicas= path@host[+host][:path@host[+host]]
 If the client asks for alternative locations for the export point, it
-- 
2.43.0


