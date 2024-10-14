Return-Path: <linux-nfs+bounces-7132-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0097A99C43D
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 10:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31D781C22BAE
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 08:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2499156230;
	Mon, 14 Oct 2024 08:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="kEmtk/2z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65CD155725
	for <linux-nfs@vger.kernel.org>; Mon, 14 Oct 2024 08:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896193; cv=none; b=ImiZCtd8wekA4ZAIZvpcr1fMSWbrVP5AY8Gtj+BAl1fwA3QypFLyGrNHT5hM1lA8Rafogguz9AWfF5Ug+K0Kl6PmioEpin9OiewXU9lMkhf34wrPmKYokvK92bFwD9p/ew6kvkzc6Cfu9MZKN8PmEQuMvf8YsEWlZXCUylqzVkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896193; c=relaxed/simple;
	bh=YuJZTB0EXLn3JspAkEM9kx4uPsmFl8B0jccA8r0uV4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AFUIlmvGP8dCFbMCXJf5C3n2Q4irQzn2SXdDvETKludEr1bNfQb8kzD6r9W/Cmdk6C0KP03BR/jr7M+afpX3C/n4RbHvoFp1ZTD5XJd9eSImTEnCdR4KmjqK5i5u2DUsN1pMCtdo+nJ80cEe8IlZbxmsycKurwzXbISs+D15O+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=kEmtk/2z; arc=none smtp.client-ip=139.138.36.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1728896191; x=1760432191;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YuJZTB0EXLn3JspAkEM9kx4uPsmFl8B0jccA8r0uV4g=;
  b=kEmtk/2z3VNMSOb5vT6o3KsJj/HjiD0lwwRl9BJGFKrfB4gO4N29CftL
   mqBfDtOEkbwTRXYBnwj/2Yucv5QybVhPszT9MAMnXiQl6s9zLSiRvsRdJ
   NkQJ/sB+XcL7eFhlMFXaCJpbMFDpiQhFcR9+S2mePiyrcIbvM34+SFD1n
   Q/5ocwBacg/jsH9VPFheRUZfBZwZD5+JK3rkKQlPt0/mS+fNMmrYs0kmI
   SsF1PtswIaWXiQ53DnCc9rKbn9zAir/EnNZ87hwKDHMn+gy1eJGxvlD5k
   4HvGZ6Lx3qwAbtVL4YveKcuUA9zJA+MvBoUOFdyeFUes25CF7ay6h0gQW
   Q==;
X-CSE-ConnectionGUID: esmZKKPJQImAPoZU7VPEBA==
X-CSE-MsgGUID: zVylOsEkQUqwyrCSzrUleQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="165031675"
X-IronPort-AV: E=Sophos;i="6.11,202,1725289200"; 
   d="scan'208";a="165031675"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 17:56:23 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 3921AD800F
	for <linux-nfs@vger.kernel.org>; Mon, 14 Oct 2024 17:56:21 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 74217D4BC7
	for <linux-nfs@vger.kernel.org>; Mon, 14 Oct 2024 17:56:20 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 00B4C200649DB
	for <linux-nfs@vger.kernel.org>; Mon, 14 Oct 2024 17:56:20 +0900 (JST)
Received: from G08FNSTD200033.g08.fujitsu.local (unknown [10.167.135.89])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 8062E1A000A;
	Mon, 14 Oct 2024 16:56:19 +0800 (CST)
From: Chen Hanxiao <chenhx.fnst@fujitsu.com>
To: libtirpc-devel@lists.sourceforge.net
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] svc_fd_create: skip getsockname on a non-network socket
Date: Mon, 14 Oct 2024 16:55:10 +0800
Message-ID: <20241014085525.2067-1-chenhx.fnst@fujitsu.com>
X-Mailer: git-send-email 2.45.2.windows.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28730.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28730.006
X-TMASE-Result: 10--3.286900-10.000000
X-TMASE-MatchedRID: IY5BgHtJl4qx0XeymqIU3TZoNXJMbH+nXHlQSIX8DvVXGTbsQqHbkr8F
	Hrw7frluf146W0iUu2sAhGIvsKa9H+UgeblHhHsangIgpj8eDcBpkajQR5gb3mn0m688Eo38Kra
	uXd3MZDXwMUUgHNDhDdB57qnjB3WlNWpEg21UdYPvVZs4xRA5XO7KuqG3PePVftG7buNeaxekyp
	vUCWGZSvasssxW5L1wxmEbrMXyni2Yr7IjJu8Il94D6E5XhCFxwGC8e6520fKw0PJt06oJaHpaQ
	l5xviY7wxgWdRvK9Un9g+oMf9KM6Q==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

As svcfd_create(3) said, it can:
Create a service on top of any open file descriptor.

But getsockname and getpeername in svc_fd_create assume that
fd should be a connected socket.

This patch will leave xp_raddr and xp_laddr uninitialized
if fd is not a connected socket.

Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
---
 src/svc_vc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/svc_vc.c b/src/svc_vc.c
index 3dc8a75..438cbc5 100644
--- a/src/svc_vc.c
+++ b/src/svc_vc.c
@@ -59,6 +59,7 @@
 #include <rpc/rpc.h>
 
 #include "rpc_com.h"
+#include "debug.h"
 
 #include <getpeereid.h>
 
@@ -232,6 +233,12 @@ svc_fd_create(fd, sendsize, recvsize)
 
 	slen = sizeof (struct sockaddr_storage);
 	if (getsockname(fd, (struct sockaddr *)(void *)&ss, &slen) < 0) {
+		if (errno == ENOTSOCK) {
+			if (libtirpc_debug_level > 3) {
+				LIBTIRPC_DEBUG(4, ("svc_fd_create: ENOTSOCK, return directly"));
+			}
+			return ret;
+		}
 		warnx("svc_fd_create: could not retrieve local addr");
 		goto freedata;
 	}
-- 
2.43.1


