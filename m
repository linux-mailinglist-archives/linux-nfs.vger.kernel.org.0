Return-Path: <linux-nfs+bounces-8664-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A73D9F77AB
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Dec 2024 09:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C164168399
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Dec 2024 08:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE4E41C79;
	Thu, 19 Dec 2024 08:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="E+HUYCgO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685F9221447
	for <linux-nfs@vger.kernel.org>; Thu, 19 Dec 2024 08:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734597851; cv=none; b=aXCESn+Jl85ukoU6o3zhjyWuqXCYZfSgQY5Vpl9UXLMdapsA9eEGeKKFF0mccsrYmyfww3TUkjpg+VaJcFM+tZ28hRpd1L1V8wG/OyeoHhxKHAAMbRQTTEjI5mMvI9yOuJTlkVAdigK0FG7HjxMtih3dJOvrWePXRgmpdRdldLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734597851; c=relaxed/simple;
	bh=OQ39jAMujhT/mMyG6yIzpVhgkkFQOxqpHBJCrgtnTLs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=CZjyJezYLRq01xnz8nP2ppfn+SaBp3+slDSLoXmZscUab2BqhVR7oztNCA6Kb1kAk/8qIkeiua9n/OQ7/IekiSneWuAGexufwcag/rJXsiZqdOyvpW8PyCavphr2CxjoiprvO5JGN13zEXheIzwFbNrTCO3w184csdMPxicit2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=E+HUYCgO; arc=none smtp.client-ip=68.232.139.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1734597849; x=1766133849;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OQ39jAMujhT/mMyG6yIzpVhgkkFQOxqpHBJCrgtnTLs=;
  b=E+HUYCgOaceklOEuQTUko5zZqgb5ZLRn7kcwDv+Wuww42ixQpAdYOrpD
   B9InpuFV71gFADKwhE5ObFdwOy+ucbggdz0V3kD1EXWvvam+TzwtSl6mf
   MP2qL0MXBc7X/KUmS8Hb0MnSV6Qn0K1N4+1UCJCr0eEesIXAxmKiBqOns
   dUeCH8iW57Yg4LkGDmY8ONy2PLhb4JalQNESVAVF8aFH9P+FgKEkhGehS
   tw63eL7Gv9aXletrVyjQ5lbNQdwBgu69lUy0WWtwTJgBkqM4U0ZiL76b+
   4H1YU129jdvDse60P+G+Z1dY6h6bRHuw9YcQJP8UtMHE5wgxZ++s6aBss
   w==;
X-CSE-ConnectionGUID: 1CfTZaWvTLSYWl7Qlr/83Q==
X-CSE-MsgGUID: U2nwYraDTMWXZ6TjCZ6jyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="186711432"
X-IronPort-AV: E=Sophos;i="6.12,247,1728918000"; 
   d="scan'208";a="186711432"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 17:42:58 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 7EE07DBB89
	for <linux-nfs@vger.kernel.org>; Thu, 19 Dec 2024 17:42:55 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 4811ABF3C5
	for <linux-nfs@vger.kernel.org>; Thu, 19 Dec 2024 17:42:55 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id D86B56AB43
	for <linux-nfs@vger.kernel.org>; Thu, 19 Dec 2024 17:42:54 +0900 (JST)
Received: from localhost.localdomain.localdomain (unknown [10.193.128.200])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 67D721A006C;
	Thu, 19 Dec 2024 16:42:54 +0800 (CST)
From: wangmy@fujitsu.com
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org,
	Wang Mingyu <wangmy@cn.fujitsu.com>
Subject: [PATCH] Fix const qualifier error
Date: Thu, 19 Dec 2024 16:42:45 +0800
Message-Id: <1734597765-2780-1-git-send-email-wangmy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28868.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28868.006
X-TMASE-Result: 10--2.181800-10.000000
X-TMASE-MatchedRID: nPVbc2e3XqjRhEyb9f1sjmvOwg12ikVSrTq6L3EFhq/8ec8XcBKYHnCi
	b3SWA/DBlsVuD4sM+B7T/db2J5CaXlpgkh9rbl/74v0ZcDzkTyt6i696PjRPiOuLH9BII+4qvwU
	evDt+uW6WEuuopHrw3qwnY0RVRjvrv1l2Uvx6idqu65UDD0aDgsRB0bsfrpPIcSqbxBgG0w5Zr4
	Oy+SFADledxaDyDGeHat1Z9Yce8IZsiEfio6cClD8xAlPoqMstXIl3Mj0Ywdo+rjEXV+6gkLbbi
	+1qz10B2mjIY7htYA1B73EZz7XBCOp1XUG/h2MOieWdV7FfKATLbAp0fm+COw==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

From: Wang Mingyu <wangmy@cn.fujitsu.com>

erroe message:
cc -DHAVE_CONFIG_H -I. -I../../support/include  -I/usr/include/tirpc  -I/usr/include/libxml2  -D_GNU_SOURCE -pipe  -Wall  -Wextra  -Werror=strict-prototypes  -Werror=missing-prototypes  -Werror=missing-declarations  -Werror=format=2  -Werror=undef  -Werror=missing-include-dirs  -Werror=strict-aliasing=2  -Werror=init-self  -Werror=implicit-function-declaration  -Werror=return-type  -Werror=switch  -Werror=overflow  -Werror=parentheses  -Werror=aggregate-return  -Werror=unused-result  -fno-strict-aliasing  -Werror=format-overflow=2 -Werror=int-conversion -Werror=incompatible-pointer-types -Werror=misleading-indentation -Wno-cast-function-type -g -O2 -MT file.o -MD -MP -MF .deps/file.Tpo -c -o file.o file.c
file.c: In function ‘nsm_make_temp_pathname’:
file.c:200:22: warning: assignment discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
  200 |                 base = pathname;
      |                      ^

Signed-off-by: Wang Mingyu <wangmy@cn.fujitsu.com>
---
 support/nsm/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/support/nsm/file.c b/support/nsm/file.c
index de122b0f..27332108 100644
--- a/support/nsm/file.c
+++ b/support/nsm/file.c
@@ -197,7 +197,7 @@ nsm_make_temp_pathname(const char *pathname)
 
 	base = strrchr(pathname, '/');
 	if (base == NULL)
-		base = pathname;
+		base = (char*)(&pathname);
 	else
 		base++;
 
-- 
2.43.0


