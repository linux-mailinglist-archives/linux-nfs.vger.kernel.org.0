Return-Path: <linux-nfs+bounces-12745-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6C5AE7966
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Jun 2025 10:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F36E1624AF
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Jun 2025 08:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BA31E5B95;
	Wed, 25 Jun 2025 08:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="fD4D+tQx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E2C1C4A2D
	for <linux-nfs@vger.kernel.org>; Wed, 25 Jun 2025 08:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750838666; cv=none; b=riR+bwktWZPJ/vQxAcLZKkKRIC3Ip+TiVwqAunZiMeX/JPuDlI0nN1YCPN1tuT0N6p4tYMjvQgf+KGMwn4T0fK1JwcobvneliER7ig1G9bj3Tfsx76C8se6X5MIXVIjT2cSkszwwEk2QbpdqBsQHVZC2QNO+oWtLgHbOAW1koaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750838666; c=relaxed/simple;
	bh=4RSlHf4vIOeNIBG5XB/aatEJBjRq8ejExCt0m/fcogk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AoZl7h/mN/NMwhl9AHn3eeR6z9yn6yD9d1bkOMC1AhVSB/3sbK0O5MPQkQTO9wKKJyLYS3WSzxmY4xbWYu3ZWhVQyMXLu4wJEcprQmZYSA+xaVkfLChOdm7GGlq391bDCTiXzf+F7Hb/4tM1SNnozHJShoZqIJSV/H24lzF5MIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=fD4D+tQx; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1750838664; x=1782374664;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4RSlHf4vIOeNIBG5XB/aatEJBjRq8ejExCt0m/fcogk=;
  b=fD4D+tQxFgRWV3EG+l00tXuHOoYVXPGBLa5Si6+EM9I3hmnX0aJvpi4b
   rK83uyu/2qLPkJleJW+KpbFdpHnKsXLx6tgVoubYxRns4AopFxfsHiL5q
   rxWF3QXGYSQ+g34uQ5++Yy93exZIqk9FfUKj3E/c0XZURe+KVaQBl6O1G
   mapo7hSVNDCftvdmjphjv4EzeiJFEMRv8lXmz7W25ynHz/2NC/aTbdQdg
   FFCBenc+LnoKGy4akO+9KDNZzllTKeo48pZGapd9JiPQ1YDvE3ClCqsZU
   VCtFuIPY/6ExT+7Eqy0AIY1tXOtIrePfoQzRxWuSfU2+sYQn1dkWEK3Ek
   g==;
X-CSE-ConnectionGUID: NSfC5dpmR+aoO0Q0zC9WZQ==
X-CSE-MsgGUID: 2G0DbSlDSM6PmlGh3JpBUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="182833329"
X-IronPort-AV: E=Sophos;i="6.16,264,1744038000"; 
   d="scan'208";a="182833329"
Received: from unknown (HELO az2uksmgr3.o.css.fujitsu.com) ([52.151.125.19])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 17:03:14 +0900
Received: from az2uksmgm2.o.css.fujitsu.com (unknown [10.151.22.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgr3.o.css.fujitsu.com (Postfix) with ESMTPS id 68DE81002BA4
	for <linux-nfs@vger.kernel.org>; Wed, 25 Jun 2025 08:03:14 +0000 (UTC)
Received: from yto-m2.gw.nic.fujitsu.com (yto-m2.gw.nic.fujitsu.com [10.128.47.163])
	by az2uksmgm2.o.css.fujitsu.com (Postfix) with ESMTP id C49D318001FF
	for <linux-nfs@vger.kernel.org>; Wed, 25 Jun 2025 08:03:13 +0000 (UTC)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 3E6FBD35E4
	for <linux-nfs@vger.kernel.org>; Wed, 25 Jun 2025 17:03:12 +0900 (JST)
Received: from G08XZGSD200059.g08.fujitsu.local (unknown [10.167.135.156])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 9AB3C1A0074;
	Wed, 25 Jun 2025 16:03:11 +0800 (CST)
From: Chen Hanxiao <chenhx.fnst@fujitsu.com>
To: calum.mackay@oracle.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] pynfs: Fix RuntimeError by increasing default ca_maxrequests from 8 to 16
Date: Wed, 25 Jun 2025 16:00:59 +0800
Message-ID: <20250625080208.1424-1-chenhx.fnst@fujitsu.com>
X-Mailer: git-send-email 2.49.0.windows.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Increased the default value of ca_maxrequests from 8 to 16 to address a
RuntimeError encountered in DELEG8.

This change resolves the issue where
DELEG8 st_delegation.testDelegRevocation
fails with a RuntimeError: "Out of slots".

Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
---
 nfs4.1/nfs4client.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nfs4.1/nfs4client.py b/nfs4.1/nfs4client.py
index f4fabcc..fa31b34 100644
--- a/nfs4.1/nfs4client.py
+++ b/nfs4.1/nfs4client.py
@@ -390,7 +390,7 @@ class ClientRecord(object):
                        fore_attrs=None, back_attrs=None, sec=None,
                        prog=None,
                        max_retries=1, delay_time=1):
-        chan_attrs = channel_attrs4(0,8192,8192,8192,128,8,[])
+        chan_attrs = channel_attrs4(0,8192,8192,8192,128,16,[])
         if fore_attrs is None:
             fore_attrs = chan_attrs
         if back_attrs is None:
-- 
2.39.1


