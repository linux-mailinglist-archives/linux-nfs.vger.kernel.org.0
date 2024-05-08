Return-Path: <linux-nfs+bounces-3206-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F423D8C00CD
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2024 17:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84562281839
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2024 15:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACC6126F0A;
	Wed,  8 May 2024 15:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K9rZ1qBM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468B21A2C05;
	Wed,  8 May 2024 15:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715181609; cv=none; b=dCDHNGyqmQzs1/57LlzHA0GK2DYKqEUtzGN34XL+2ClmAY8ps+pbZcAVQGfPat/FCwYel77n6D5oOCBKi67a7uWHkXmOuhAkcdnN87RPPAOfeddIo37zu+PcXHCJB7fcxfCcx1a2AweMuva1Z0Hrhym0nn7E0c5ifFLeoSu30mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715181609; c=relaxed/simple;
	bh=F7/xJtqZj5pHb27cUKilA7HO8qx0Hd9ce0l1SBmQKRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eea/wLZT+y6SwkKKkjvchh+krAF++aIBxjD2Z4VTqh6wI6i29sFm0Kz6r0K+lKGWzsG/9BduHthG7Kduw9m5FTms81TmsTpfwzM9vND1JkcxSxYVEwGnZ82BlwhVY2Dc4Ge/VcW7w8yp6txvjHkJ4kYgOeYRiMMQPqiySFeEE9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K9rZ1qBM; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715181607; x=1746717607;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=F7/xJtqZj5pHb27cUKilA7HO8qx0Hd9ce0l1SBmQKRI=;
  b=K9rZ1qBMIbDSnoZfkx/JsFnmqxaXIQm5gH3TdQhaqhNWm494Co+KPEZr
   wSnaDFaamtbmY9oBJZya6fK00RgROspDBpIgCW2ehSaTJD0gLLhYDc1Fu
   FoiLL2XapInY8Ggz82ZiaA5IV2IrL7w0Q5hDJ9ec11YA7mpK4HU0I3azZ
   W4jWjAzbCBVezVBcR+XMmuebg06MJAAFZgZSnGuTJhFwz8gMKse1PVii/
   Www/m5/OAMqA+mJd+vMfetlkVzJ2S/8+an0tdpkDqv+JZqjrOK2sSgF08
   xTBFrnfDHcNxdAWco17KBYFt2RA7a47AJseeNzmANa5X/wigcaJil1I49
   w==;
X-CSE-ConnectionGUID: Tv+QKSp1Tt6i0T1NcAvU6w==
X-CSE-MsgGUID: 7u3Vk7otSP6kQgbYqg5nEg==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="11428977"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="11428977"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 08:19:59 -0700
X-CSE-ConnectionGUID: hVZnJc5nTd+QSa92kM2png==
X-CSE-MsgGUID: 8GM+nOUMSu6VdSY8WhUTvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28850980"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 08 May 2024 08:19:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 7C6DD109; Wed, 08 May 2024 18:19:52 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH v1 1/1] lockd: Use *-y instead of *-objs in Makefile
Date: Wed,  8 May 2024 18:19:38 +0300
Message-ID: <20240508151951.1445074-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

*-objs suffix is reserved rather for (user-space) host programs while
usually *-y suffix is used for kernel drivers (although *-objs works
for that purpose for now).

Let's correct the old usages of *-objs in Makefiles.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Note, the original approach is weirdest from the existing.
Only a few drivers use this (-objs-y) one most likely by mistake.

 fs/lockd/Makefile | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/lockd/Makefile b/fs/lockd/Makefile
index ac9f9d84510e..fe3e23dd29c3 100644
--- a/fs/lockd/Makefile
+++ b/fs/lockd/Makefile
@@ -7,8 +7,7 @@ ccflags-y += -I$(src)			# needed for trace events
 
 obj-$(CONFIG_LOCKD) += lockd.o
 
-lockd-objs-y += clntlock.o clntproc.o clntxdr.o host.o svc.o svclock.o \
-	        svcshare.o svcproc.o svcsubs.o mon.o trace.o xdr.o
-lockd-objs-$(CONFIG_LOCKD_V4) += clnt4xdr.o xdr4.o svc4proc.o
-lockd-objs-$(CONFIG_PROC_FS) += procfs.o
-lockd-objs		      := $(lockd-objs-y)
+lockd-y := clntlock.o clntproc.o clntxdr.o host.o svc.o svclock.o \
+	   svcshare.o svcproc.o svcsubs.o mon.o trace.o xdr.o
+lockd-$(CONFIG_LOCKD_V4) += clnt4xdr.o xdr4.o svc4proc.o
+lockd-$(CONFIG_PROC_FS) += procfs.o
-- 
2.43.0.rc1.1336.g36b5255a03ac


