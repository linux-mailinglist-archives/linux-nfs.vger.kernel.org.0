Return-Path: <linux-nfs+bounces-1749-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC47848CB4
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Feb 2024 11:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22EC41F222EE
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Feb 2024 10:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8841B5B1;
	Sun,  4 Feb 2024 10:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Hdmx1DT8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34061B59E
	for <linux-nfs@vger.kernel.org>; Sun,  4 Feb 2024 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707041936; cv=none; b=GlperLWU/DVIFButis6Q9SGqvy12DK+QFBg0iFi2SKm1deDRhrS8ISVTnlVUQ0dVYvsPw375JQSRxQsBGGRe33vTBNum70dcppirnhTYamz1In3MEVZ/LS2cq/Nbpa5Pfq5S11/ieS5dYm2XTflcDyMLBhJJACXPlvmXlCzuosI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707041936; c=relaxed/simple;
	bh=M7dVKWP99ML9aDIZGZM11bwkNwEk3zUQqJrCAiW48FM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=NkDT3VZsECzDwWOf8DN3tM0/DWaRt7Uwf9IwsFUqqf4RefcGiV4qcI65znk0pHiBblt0nM3FhgnkaT7A0HzkfX/sYql36JwWTilB8lwsnRQH7KZw5scPMXAka1yoOTln/h/5rYfvVp3CnYsP9L0MuDcF9lBFoUOsadONLC7RtNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Hdmx1DT8; arc=none smtp.client-ip=207.54.90.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1707041934; x=1738577934;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M7dVKWP99ML9aDIZGZM11bwkNwEk3zUQqJrCAiW48FM=;
  b=Hdmx1DT8kTsw3jG+lscINADP4OfbneCZ5lq5sOQdb9DzzN3x09AGJLEo
   qzIjZD3wtM3mrE6DylRQZY+0hgbM1IbiGNzwh6C1oDV1QpjOGHypLFTy+
   InqzH3tBUFJwo31K6pueUobWcKoFBJa11j+FLm6hFmEWx7fgT0H8rnJkw
   dLQWtVVAMX3QKKFIKHjzY51EZblZ3U0GgzBXdSaRslOB8az6tqThcRASY
   5VwwJJaMr1+qlpDmc7/sZehNKawQosvTnr9mUDQ5kPu1fe2U4HmoMDebR
   ANGziLfmxTO72D2JVoWMouJy1YNUyht+Wft30Qed13z+rAK9c/rtxUpnf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="127712782"
X-IronPort-AV: E=Sophos;i="6.05,242,1701097200"; 
   d="scan'208";a="127712782"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 19:18:46 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 39FA3DCD4B
	for <linux-nfs@vger.kernel.org>; Sun,  4 Feb 2024 19:18:43 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 770E71A88A
	for <linux-nfs@vger.kernel.org>; Sun,  4 Feb 2024 19:18:42 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id ED68E20095248
	for <linux-nfs@vger.kernel.org>; Sun,  4 Feb 2024 19:18:41 +0900 (JST)
Received: from G08FNSTD200033.g08.fujitsu.local (unknown [10.167.225.189])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 6D4531A006A
	for <linux-nfs@vger.kernel.org>; Sun,  4 Feb 2024 18:18:41 +0800 (CST)
From: Chen Hanxiao <chenhx.fnst@fujitsu.com>
To: linux-nfs@vger.kernel.org
Subject: [PATCH]  nfs(5): Document the max value "timeo=" mount option
Date: Sun,  4 Feb 2024 18:18:21 +0800
Message-Id: <20240204101821.958-1-chenhx.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.1.windows.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28166.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28166.003
X-TMASE-Result: 10--2.131800-10.000000
X-TMASE-MatchedRID: 9IrrHbNZyfrR6RKL7TRTbhF4zyLyne+ATJDl9FKHbrlnyL8x0tKlOz7h
	mFGKpcOtBdv5H2ulen22Rnvq1hC7tzf6ZkIPCe1yngIgpj8eDcBpkajQR5gb3savT21DsLD/UEh
	Wy9W70AEnRE+fI6etkg6/Ta4+dUqRBvoK/s9Eau8yWOvO/P0s4bgyz0QbCaR8f0NUgPV8mQAvp/
	xKj6NWillxHuVVuIXW+s9EMao2KS/YQGi8nLnGEZNXzfSpGjR+khLM4dgqCq4lnZEk2zZ/XGKsY
	c7AKUEYGQnVWQzQGmI=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
---
 utils/mount/nfs.man | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
index 7103d28e..233a7177 100644
--- a/utils/mount/nfs.man
+++ b/utils/mount/nfs.man
@@ -186,6 +186,10 @@ infrequently used request types are retried after 1.1 seconds.
 After each retransmission, the NFS client doubles the timeout for
 that request,
 up to a maximum timeout length of 60 seconds.
+.IP
+Any timeo value greater than default value will be set to the default value.
+For TCP and RDMA, default value is 600 (60 seconds).
+For UDP, default value is 60 (6 seconds).
 .TP 1.5i
 .BI retrans= n
 The number of times the NFS client retries a request before
-- 
2.31.1


