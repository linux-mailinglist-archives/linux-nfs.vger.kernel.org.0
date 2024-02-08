Return-Path: <linux-nfs+bounces-1856-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6202F84DB02
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Feb 2024 09:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94E331C2140B
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Feb 2024 08:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA5C69E11;
	Thu,  8 Feb 2024 08:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="PyuayM+S"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C242269E00
	for <linux-nfs@vger.kernel.org>; Thu,  8 Feb 2024 08:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707379684; cv=none; b=drH2HKxEYRPaU1SN1jcbIWnqM4gDMIKo4ceumZVYwhQ2KpYjOkg6Pm/YSw4PyTDCiVYCzhU/dIdYRcooy9X2pk3p7w1pDuu31faQSvCkO0M6Td61Vspmm81AN9wbA3Fj44u3XGFEGNiS1QlMcrz4gFla89S23yn4KDFV1vS8svw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707379684; c=relaxed/simple;
	bh=/frmN4xSAtoDDq5whXSXb+13huxkdAcEp/JVT4vh1xU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S7vqrYZIBEqJnOx+vU5NJGCnWmiVmY2B/mxcz9MzTLIyKz3L0yj1Rmr+Sdj0g/auhEzHbOcQwzaKE55oZdk2r8Ph1bqh+Ow/u9AAzQ0ncf0tJ9/TALx/MBprpCc8IwzI8mfu3xmBTYEAVc+eLhHA0w5CRqHujR7oNW51VtO2RFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=PyuayM+S; arc=none smtp.client-ip=139.138.36.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1707379681; x=1738915681;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/frmN4xSAtoDDq5whXSXb+13huxkdAcEp/JVT4vh1xU=;
  b=PyuayM+Syb/BLcqWH3ISzuFIz90yx+4OYsyyk6V8O16ruruLRBkICLYx
   4Awr5CfBFqnANWLQNqmQt+0ginGfltwmScuD7YdyaGBx3MbGNxYgg2G8Q
   rCYTlIJKVSxgB3GnDt/VzVl+sdvNlHEWP2a4tMLmuI7lVbf6LJ6Jwka0t
   PL0p79k3SuFPLc0o/B/ARcEfDNm2y7BIy1BVQ4r5uDJLOkQNCrdaMDWgq
   Niy0uz5sO45SL4uQkvh7/qCXq1WKnyGgJdNr250Ei0yASpbHVIKe2gd+u
   ZpfRmFi1Wmg43Q1vYDpWyzl9cc1oK9yTvTbDJx+lzhpskwbHHbMSXXaPY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="137247375"
X-IronPort-AV: E=Sophos;i="6.05,253,1701097200"; 
   d="scan'208";a="137247375"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 17:06:48 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 8A54CCA0A9
	for <linux-nfs@vger.kernel.org>; Thu,  8 Feb 2024 17:06:46 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id B2B1A1C504A
	for <linux-nfs@vger.kernel.org>; Thu,  8 Feb 2024 17:06:45 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 09C0A200989CA
	for <linux-nfs@vger.kernel.org>; Thu,  8 Feb 2024 17:06:45 +0900 (JST)
Received: from G08FNSTD200033.g08.fujitsu.local (unknown [10.167.225.189])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 2FDC81A006B;
	Thu,  8 Feb 2024 16:06:44 +0800 (CST)
From: Chen Hanxiao <chenhx.fnst@fujitsu.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: clean up comments over nfs4_client definition
Date: Thu,  8 Feb 2024 16:06:26 +0800
Message-Id: <20240208080627.1014-1-chenhx.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.1.windows.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28178.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28178.003
X-TMASE-Result: 10--2.271500-10.000000
X-TMASE-MatchedRID: PrWv+NeUIb4P4o3VqtN0lsYv//yaWh0DMVx/3ZYby7/AuQ0xDMaXkH4q
	tYI9sRE/L2EYbInFI5uzqC3huvC/UfNyBdcHnpoYlTsGW3DmpUvYUDvAr2Y/13y/Hx1AgJrrpIy
	5bqa+5U7i8zVgXoAltuJ5hXsnxp7jC24oEZ6SpSmcfuxsiY4QFEdZOLImRiBiZ+s/gjLehTQiuW
	9/4ZHihg3lz1Mh/KEmB3qI/idIOUi7AO6qVyRrVJ+jS8uzkp8SM3oysPucAGD5/2VwMgPB8JsNE
	GpLafrrLM/nEDLP056e+TDiyH/49wxfkLAfkNNSaAZk0sEcY14=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

nfsd fault injection has been deprecated since
commit 9d60d93198c6 ("Deprecate nfsd fault injection")
and removed by
commit e56dc9e2949e ("nfsd: remove fault injection code")

So remove the outdated parts about fault injection.

Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
---
 fs/nfsd/state.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 41bdc913fa71..2231d9da9bfe 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -317,8 +317,8 @@ enum {
  * 0. If they are not renewed within a lease period, they become eligible for
  * destruction by the laundromat.
  *
- * These objects can also be destroyed prematurely by the fault injection code,
- * or if the client sends certain forms of SETCLIENTID or EXCHANGE_ID updates.
+ * These objects can also be destroyed prematurely if the client sends certain
+ * forms of SETCLIENTID or EXCHANGE_ID updates.
  * Care is taken *not* to do this however when the objects have an elevated
  * refcount.
  *
@@ -326,7 +326,7 @@ enum {
  *
  * o Each nfs4_clients is also hashed by name (the opaque quantity initially
  *   sent by the client to identify itself).
- * 	  
+ *
  * o cl_perclient list is used to ensure no dangling stateowner references
  *   when we expire the nfs4_client
  */
-- 
2.43.0


