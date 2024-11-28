Return-Path: <linux-nfs+bounces-8247-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69529DB7C7
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Nov 2024 13:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96F12284713
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Nov 2024 12:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7369198E63;
	Thu, 28 Nov 2024 12:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="PHxvYRMA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76593195385
	for <linux-nfs@vger.kernel.org>; Thu, 28 Nov 2024 12:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732797431; cv=none; b=pacBawD8nl6wIjKSjSSEr1YbSORswceozhLT8gZxMeopeMqs8wqtpzS73nc0Ky6jUPrgrzijhk/szGl+QM8Z8nyPE4hxwj9HOtCSTV1BiIl+18AI+h2i8U5uQcujTMBDSDioIh66Uq5yE5L5WSnMjaGFAGuMw9F7ZC+cCYre2qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732797431; c=relaxed/simple;
	bh=bzLM5g36lmVNE7OsBk+spl9G4pC4UcWFAep9k5jREcw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sd2044Jbp1a/73G3QBVM+dHG3tFJkIpvRlfg21dSfHilIenow4XSOCcMlC+SBcqLYpo+f++InVw+Ih9bJeifXjQ18a87PwkLvPpJ3R9tlrvtxOcO8p3rDmu2nMFmdrbh3nlLwHvzX4o32vlEpa6s31q1HKABX4VhGUhUphAnK9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=PHxvYRMA; arc=none smtp.client-ip=68.232.139.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1732797429; x=1764333429;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bzLM5g36lmVNE7OsBk+spl9G4pC4UcWFAep9k5jREcw=;
  b=PHxvYRMA2+yfo/Ho7XCWqeBcZoF2bzsGbs5bVUWYUpMQtGFcfvKnNADb
   ZUwT5uA8UtVtGloJBsuYIYdOuRv+Ti7amzgNYWnZfvCRJPABpPEtuHJ+O
   pOM1bsfcUJMYW4Eyy/7Sd0wMvfx9aCa6kjKhf+8MAJ0/e/mAOlvXoWV8v
   pWMcxgImnJMH38f1xEfdwc1n1+30nfeCbpb5bJBImr+U4DhfIQlZJHPlj
   SNq4kF5uz5ukO/idCpaxZjpqGRu86HvNVm0A/H/sGMcrAcUHezCbdPFD6
   WpHvIrr7LN/04XRPi7EU3o12S1NJK7bzAqsI4++UUQ9foey7AR8qqCYGq
   Q==;
X-CSE-ConnectionGUID: r1p/RxgIRUeL/VAgoHyPrQ==
X-CSE-MsgGUID: tnzKot9yS+SjSs9QJSINMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="182182390"
X-IronPort-AV: E=Sophos;i="6.12,192,1728918000"; 
   d="scan'208";a="182182390"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 21:37:01 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 318A62341F
	for <linux-nfs@vger.kernel.org>; Thu, 28 Nov 2024 21:36:59 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id B5B2ACFAB2
	for <linux-nfs@vger.kernel.org>; Thu, 28 Nov 2024 21:36:58 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 306E1401AE
	for <linux-nfs@vger.kernel.org>; Thu, 28 Nov 2024 21:36:58 +0900 (JST)
Received: from G08FNSTD200033.g08.fujitsu.local (unknown [10.167.135.89])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 918731A000B;
	Thu, 28 Nov 2024 20:36:57 +0800 (CST)
From: Chen Hanxiao <chenhx.fnst@fujitsu.com>
To: calum.mackay@oracle.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] pynfs: rpc.py: use OSError.errno to fix a not subscriptable exception
Date: Thu, 28 Nov 2024 20:36:01 +0800
Message-ID: <20241128123642.1636-1-chenhx.fnst@fujitsu.com>
X-Mailer: git-send-email 2.45.2.windows.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28824.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28824.006
X-TMASE-Result: 10-0.778500-10.000000
X-TMASE-MatchedRID: AuCKiGuH5B4AL6VbmDy897U+IyHhkXf1CZa9cSpBObnAuQ0xDMaXkH4q
	tYI9sRE/L2EYbInFI5tLC42PB7KOrR2+l290c2mongIgpj8eDcBpkajQR5gb3lQwtQm7iV5jKra
	uXd3MZDWvVLf7RaMfzGMdkwwWc/YUk1EYevdlvuiALYfQRrxSDM0jXPdSjj0wrryMmPAGKhUSQ0
	tvc767qUa12UmwjLHflJGkDJWbztoYigD+WO05IRXFEH92Kf64nTtPxlIuIBW9Hzj86YHXBCnif
	x5AGfCL
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

In python3, socket.error is a deprecated alias of OSError
https://docs.python.org/3/library/socket.html#socket.error

Also, use socket.error[0] will raise:
TypeError: 'OSError' object is not subscriptable

Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
---
 nfs4.0/lib/rpc/rpc.py | 4 ++--
 rpc/rpc.py            | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/nfs4.0/lib/rpc/rpc.py b/nfs4.0/lib/rpc/rpc.py
index 24a7fc7..243ef9e 100644
--- a/nfs4.0/lib/rpc/rpc.py
+++ b/nfs4.0/lib/rpc/rpc.py
@@ -226,8 +226,8 @@ class RPCClient(object):
             try:
                 sock.bind(('', port))
                 return
-            except socket.error as why:
-                if why[0] == errno.EADDRINUSE:
+            except OSError as why:
+                if why.errno == errno.EADDRINUSE:
                     port += 1
                 else:
                     print("Could not use low port")
diff --git a/rpc/rpc.py b/rpc/rpc.py
index 1fe285a..124e97a 100644
--- a/rpc/rpc.py
+++ b/rpc/rpc.py
@@ -845,8 +845,8 @@ class ConnectionHandler(object):
             try:
                 s.bind(('', using))
                 return
-            except socket.error as why:
-                if why[0] == errno.EADDRINUSE:
+            except OSError as why:
+                if why.errno == errno.EADDRINUSE:
                     using += 1
                     if port < 1024 <= using:
                         # If we ask for a secure port, make sure we don't
-- 
2.43.5


