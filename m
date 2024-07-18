Return-Path: <linux-nfs+bounces-4978-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CABFF934899
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jul 2024 09:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 082B31C210A5
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jul 2024 07:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E018488;
	Thu, 18 Jul 2024 07:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="nUBPqzPB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FD874058
	for <linux-nfs@vger.kernel.org>; Thu, 18 Jul 2024 07:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721286497; cv=none; b=QWQypqF+o+QhPa9/jjJ8fbO/XMNLKkPmSgqd4dBuQ0HChix41FqeKQ3ETBs1J+K2pvZNBeAOkx+tSKkWUPgrWl/PIdDEECEixgdZhr21QRGClmOo3FVoz5+l2hujFe3qpozFFFBeCYyYcriEBA7ZwCZyWKwkXfdqdjBjxp2Mr4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721286497; c=relaxed/simple;
	bh=21QGp1JygpBJWGNSSzSODvt5boynptO7wTlhJi3SeNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eBpo7z6c0YvBmkR25GJ7Y2E+4ZN1fuXW2VzEVZVdwY+1NRrwoh32gz+cg1OeeO+DQhTjh3xrfKYdG2IvW+PARpUTLLv7Dd3hde+BrfBcjKylyTBx+ymB1p+Fcvi97ccRXVaAyKCcVdWbbBQyxP74D1HVEaJlK7Qq7o57dvb6CTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=nUBPqzPB; arc=none smtp.client-ip=139.138.61.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1721286494; x=1752822494;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=21QGp1JygpBJWGNSSzSODvt5boynptO7wTlhJi3SeNk=;
  b=nUBPqzPBjG+Xgm8mc4YvpJQSUKYv7yVgiNZULBzbBw6IK3phh+Lk3f2U
   BrZXR3eAwgTa6JxGuipFOo+18efZ0oQDtWVJ/WW2gKMJOUlSqxYWBMdxh
   6XbqsapNaGa/i2FS/CX8Qn0R/1rYrRhTf8ze4Rns8Ymhdjbgnx7MQp+Ex
   i8JlnD/8OX6wAm0JyQv6gzD9FJW5Tk+eMN2Nly42v0CBOuLPo0fPDT6lP
   ydQsvy/2zjxmSXLHl96RuNlqBIgdhTWEWZE/USpB0RHsswLQh8tZh193q
   gX+GKRvc8d6wpyoyWPfW63N47P9SSyJUg5JuZj6B7JCZzzhgU7gysc9JL
   w==;
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="155707868"
X-IronPort-AV: E=Sophos;i="6.09,217,1716217200"; 
   d="scan'208";a="155707868"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 16:07:03 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id D978216B902
	for <linux-nfs@vger.kernel.org>; Thu, 18 Jul 2024 16:07:01 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 1EB72D980F
	for <linux-nfs@vger.kernel.org>; Thu, 18 Jul 2024 16:07:01 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 8CF0221FC75
	for <linux-nfs@vger.kernel.org>; Thu, 18 Jul 2024 16:07:00 +0900 (JST)
Received: from G08FNSTD200033.g08.fujitsu.local (unknown [10.167.225.189])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 7837C1A000A;
	Thu, 18 Jul 2024 15:06:59 +0800 (CST)
From: Chen Hanxiao <chenhx.fnst@fujitsu.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: trace: show TIMEDOUT instead of 0x6e
Date: Thu, 18 Jul 2024 15:06:16 +0800
Message-ID: <20240718070640.1913-1-chenhx.fnst@fujitsu.com>
X-Mailer: git-send-email 2.45.2.windows.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28536.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28536.005
X-TMASE-Result: 10-2.847300-10.000000
X-TMASE-MatchedRID: 4XaIt/U/b23gUbgLLPhW5hF4zyLyne+AVBDQSDMig9GbKItl61J/yfJv
	ocwUrWp7FBpuM64i9KELbigRnpKlKSBuGJWwgxArHsoRE2DMTEa7f5j5+igGKhENbtaERwONZBD
	UT5Tw1FcFCtLesIoYW1fw5O0KePyWiRV6pn15Ocx10/YhKcd83tb4TyceeerywiugMFF+dt0hya
	dlGFXHKsTgfCdKUS4cicSkmYsAV+kLUU1zqiphVX7cGd19dSFd
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

__nfs_revalidate_inode may return ETIMEDOUT.

print symbol of ETIMEDOUT in nfs trace:

before:
cat-5191 [005] 119.331127: nfs_revalidate_inode_exit: error=-110 (0x6e)

after:
cat-1738 [004] 44.365509: nfs_revalidate_inode_exit: error=-110 (TIMEDOUT)

Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
---
 include/trace/misc/nfs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/trace/misc/nfs.h b/include/trace/misc/nfs.h
index 7b221d51133a..c82233e950ac 100644
--- a/include/trace/misc/nfs.h
+++ b/include/trace/misc/nfs.h
@@ -51,6 +51,7 @@ TRACE_DEFINE_ENUM(NFSERR_JUKEBOX);
 		{ NFSERR_IO,			"IO" }, \
 		{ NFSERR_NXIO,			"NXIO" }, \
 		{ ECHILD,			"CHILD" }, \
+		{ ETIMEDOUT,			"TIMEDOUT" }, \
 		{ NFSERR_EAGAIN,		"AGAIN" }, \
 		{ NFSERR_ACCES,			"ACCES" }, \
 		{ NFSERR_EXIST,			"EXIST" }, \
-- 
2.39.1


