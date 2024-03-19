Return-Path: <linux-nfs+bounces-2390-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D312B87FC17
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Mar 2024 11:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 092801C221C1
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Mar 2024 10:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1374F8A9;
	Tue, 19 Mar 2024 10:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="DGsl8cXN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307D67E117
	for <linux-nfs@vger.kernel.org>; Tue, 19 Mar 2024 10:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710845249; cv=none; b=kwa4Tw71tpvA2Pz6mz+PjmLvLZHRu8Pec5CRW5mKbzUms8UNQ22gIsLDA0AaLBXUnsiE6XvnPEcafDu0I1KRNRFmo3T4l9v3IsMC4xsLgzG/Sbfa+XvMGQWTVu7zXsBXk0QFTu3t/5K7GdlVYjrHLkVz2UzSHUm0tJobuKTFtVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710845249; c=relaxed/simple;
	bh=tv+5iS5o1E4X/pAcwfGRsa114PMmYvnoDlgEfp8rc6o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O0GL0oyDf1Z48kuuw6BUQP0DRY3OVNC8P8AOaKY04WwmVktAl6ev+74il51Bdd2gvsMJRoFbV7/WM714DhJBm9yzvOdHi5exlr9t1MQw+Qt+s96QY0ay3kDnI2lB4G9GQ392zaf+O5Y+U3ciiZihp/wRS7C+BQeT7grHfBgoNgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=DGsl8cXN; arc=none smtp.client-ip=139.138.36.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710845246; x=1742381246;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tv+5iS5o1E4X/pAcwfGRsa114PMmYvnoDlgEfp8rc6o=;
  b=DGsl8cXNe/aS86R/ITca0pkR0sgWl8FRupGDf7s5iVxFMGfrTtn/IQos
   pX9W/iPprF014bbNATRhTr0Mjh2KHVLkgFzMseverFeHa/He8O0jj48vY
   0zOUANAbLDYpwF/aURXALoTDz64sp3RGhNzC2nYOolIDjYXSHixpTc8dy
   bqHOZy9gDcgm9a0F19OPwB6bld7vozRjK+AEo8nHTpjqOtM5bTA7NkcOS
   lXQzg9jQe5zOQsQRxvFMKeLWYB022g4cq+QOSop3kSfKqC7fT3iX4Sebg
   u/Pm7HIWCejK+SZRlFQqmScUNjUfPaqLRUb0TKOlKIhA3t1zd9bRJgByV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="141182862"
X-IronPort-AV: E=Sophos;i="6.07,136,1708354800"; 
   d="scan'208";a="141182862"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 19:47:22 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id D15AB2A0DFB
	for <linux-nfs@vger.kernel.org>; Tue, 19 Mar 2024 19:47:20 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 20C8243356
	for <linux-nfs@vger.kernel.org>; Tue, 19 Mar 2024 19:47:20 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 911801E9545
	for <linux-nfs@vger.kernel.org>; Tue, 19 Mar 2024 19:47:19 +0900 (JST)
Received: from G08FNSTD200033.g08.fujitsu.local (unknown [10.167.225.189])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 947561A006B;
	Tue, 19 Mar 2024 18:47:18 +0800 (CST)
From: Chen Hanxiao <chenhx.fnst@fujitsu.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] NFSD: nfsctl: remove read permission of filehandle
Date: Tue, 19 Mar 2024 18:47:14 +0800
Message-Id: <20240319104714.1178-1-chenhx.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.1.windows.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28260.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28260.006
X-TMASE-Result: 10-2.027500-10.000000
X-TMASE-MatchedRID: 5yxGn8a1hxTeG4FwcWqAS/CW/PNRRp/ZwTlc9CcHMZerwqxtE531VIpb
	wG9fIuITWX4eTcjDZsSAMuqetGVetv1UB9A6pTKC3QfwsVk0UbvqwGfCk7KUs6UVRhtewaml6Kg
	0kEJCYy3sz4qfqyD5/VqYk7hGXRpHzLtWAFrSwO+ju3WFvImDq4k76Veo582oFkb/OLLJ3Urzvd
	Nv9olS+iHJp2UYVccqxOB8J0pRLhyJxKSZiwBX6QtRTXOqKmFVftwZ3X11IV0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

As write_filehandle can't accept zero-bytes writting, 
remove read permission of /proc/fs/nfsd/filehandle

Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
---
 fs/nfsd/nfsctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index ecd18bffeebc..da1387f1e30a 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1346,7 +1346,7 @@ static int nfsd_fill_super(struct super_block *sb, struct fs_context *fc)
 					&transaction_ops, S_IWUSR|S_IRUSR},
 		[NFSD_FO_UnlockFS] = {"unlock_filesystem",
 					&transaction_ops, S_IWUSR|S_IRUSR},
-		[NFSD_Fh] = {"filehandle", &transaction_ops, S_IWUSR|S_IRUSR},
+		[NFSD_Fh] = {"filehandle", &transaction_ops, S_IWUSR},
 		[NFSD_Threads] = {"threads", &transaction_ops, S_IWUSR|S_IRUSR},
 		[NFSD_Pool_Threads] = {"pool_threads", &transaction_ops, S_IWUSR|S_IRUSR},
 		[NFSD_Pool_Stats] = {"pool_stats", &pool_stats_operations, S_IRUGO},
-- 
2.39.1


