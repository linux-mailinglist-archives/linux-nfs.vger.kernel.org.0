Return-Path: <linux-nfs+bounces-2487-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7561C88D6C6
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Mar 2024 07:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E61191F2B4B7
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Mar 2024 06:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BE628DDA;
	Wed, 27 Mar 2024 06:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="m/gcop4l"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4782561B
	for <linux-nfs@vger.kernel.org>; Wed, 27 Mar 2024 06:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711521689; cv=none; b=U7nDMs5GBroyCePz7h2H2cZKaLeTPSl3z/Eyz00blAcZNv6DLqG+WjG+33qu3kwnNqjqJzloQCbAOWUsIpKCd19svBokzDWvXGWKhQDZb2wnnATG4prcsFyE3hV13Od3JZx1I7M8z+Io4rzx5Vg8VHErryF9L6mz76+oQ0bNRIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711521689; c=relaxed/simple;
	bh=cBux7bxdajbfdzhFz592bQuBPZZgLkIJL7M/T3qyT0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nzcI+MIsPsL8SlZHiBy/tCZUd2HJSTw5wwZ9CgXhpya5q7ljAR/cnUCLuaAzCX7MYruh3vSqsu1BLCrrRHkXpiMmt8Wr+I+A2eSqIk2pSP9pBXX83k/b7mp+/zQG7el3cqadmiq745YY/yszvm3/S7pikp9DdFi5XKfpRvVX1X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=m/gcop4l; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1711521686; x=1743057686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cBux7bxdajbfdzhFz592bQuBPZZgLkIJL7M/T3qyT0A=;
  b=m/gcop4lrn20ouCErHd1I9Ji5ED8/U/4Ou2y9ZapnMaT1WdQz/OlXXx/
   puYCQBIMNUbTvYpNENevqs1V7cS9wSBZFVZ7brDgZnbH26Ph+TeTxshpQ
   OwspBr1cx9su4n/rTtT7Ng85lXgcjoYfNVv0NIIBzyN9sAlzfUR6PJM0m
   RkVGBXE2EoO6nNLBTSCLMPkxUgGANUL9SZM0Eocos1WTyNAkPMCBY5EIg
   /+5ya3jz0augOHNTI410y0Q92RWTn8ngUpnH3p8BVIW6tJ6VvzCbtt8ho
   VUHqhPUcjHd1//VjfimmYBG6GxStPrQVUzovqgJPfloJj8dK4+DkoqNF4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="132803733"
X-IronPort-AV: E=Sophos;i="6.07,158,1708354800"; 
   d="scan'208";a="132803733"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 15:40:13 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 95A21E48E1
	for <linux-nfs@vger.kernel.org>; Wed, 27 Mar 2024 15:40:11 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id BFEB12DB37
	for <linux-nfs@vger.kernel.org>; Wed, 27 Mar 2024 15:40:10 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 4A74DE4A88
	for <linux-nfs@vger.kernel.org>; Wed, 27 Mar 2024 15:40:10 +0900 (JST)
Received: from G08FNSTD200033.g08.fujitsu.local (unknown [10.167.225.189])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 58D6A1A006C;
	Wed, 27 Mar 2024 14:40:09 +0800 (CST)
From: Chen Hanxiao <chenhx.fnst@fujitsu.com>
To: jlayton@kernel.org
Cc: Dai.Ngo@oracle.com,
	chenhx.fnst@fujitsu.com,
	chuck.lever@oracle.com,
	kolga@netapp.com,
	linux-nfs@vger.kernel.org,
	neilb@suse.de,
	tom@talpey.com
Subject: Re: [PATCH] NFSD: nfsctl: remove read permission of filehandle
Date: Wed, 27 Mar 2024 14:40:00 +0800
Message-Id: <20240327064000.1363-1-chenhx.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.1.windows.1
In-Reply-To: <21f3580de20445ddd9bdae6eecc316a58b6df97d.camel@kernel.org>
References: <21f3580de20445ddd9bdae6eecc316a58b6df97d.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28276.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28276.005
X-TMASE-Result: 10--1.819800-10.000000
X-TMASE-MatchedRID: O/y65JfDwwsMek0ClnpVpzo39wOA02LhTSz0JdEAJbQB+kZ9/05jkNno
	quRwHY3BvhZZvlPO4OHmn3xyPJAJoh2P280ZiGmR30kDaWZBE1QpA2ExuipmWoAjsy+r+wvn2l+
	1zUPkXziriIB6EaKLoFKawtqL+6JPEd0YyW6tLbkOeRRGICV9PSxhn4W9FFDdmyiLZetSf8mfop
	0ytGwvXiq2rl3dzGQ1mP4Tqw15lP52vn3uDY45MpiaIytrIwRdsP60wDdbSpr5MKH6MenjdKlz4
	fzn9YAx7DUZC9pCrwlTrOufrGdrNN8Drzx0R/VeCJtgfYTSQmoVxRB/din+uJ07T8ZSLiAVvR84
	/OmB1wQp4n8eQBnwiw==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Hi, Jeff

I wrote a POC patch, use name_to_handle_at to get nfs root filehandle
instead of /proc/fs/nfsd/filehandle.

I did some simple tests and it works.

Pls check the POC patch below:
---
 support/export/cache.c | 95 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 93 insertions(+), 2 deletions(-)

diff --git a/support/export/cache.c b/support/export/cache.c
index 6c0a44a3..adecac2e 100644
--- a/support/export/cache.c
+++ b/support/export/cache.c
@@ -43,6 +43,25 @@
 #include "blkid/blkid.h"
 #endif
 
+#define NFS4_FHSIZE           128
+
+struct knfsd_fh {
+	unsigned int	fh_size;	/*
+					 * Points to the current size while
+					 * building a new file handle.
+					 */
+	union {
+		char			fh_raw[NFS4_FHSIZE];
+		struct {
+			uint8_t		fh_version;	/* == 1 */
+			uint8_t		fh_auth_type;	/* deprecated */
+			uint8_t		fh_fsid_type;
+			uint8_t		fh_fileid_type;
+			uint32_t	fh_fsid[]; /* flexible-array member */
+		};
+	};
+};
+
 enum nfsd_fsid {
 	FSID_DEV = 0,
 	FSID_NUM,
@@ -1827,8 +1846,8 @@ int cache_export(nfs_export *exp, char *path)
  *   read filehandle <&0
  * } <> /proc/fs/nfsd/filehandle
  */
-struct nfs_fh_len *
-cache_get_filehandle(nfs_export *exp, int len, char *p)
+static struct nfs_fh_len *
+cache_get_filehandle_by_proc(nfs_export *exp, int len, char *p)
 {
 	static struct nfs_fh_len fh;
 	char buf[RPC_CHAN_BUF_SIZE], *bp;
@@ -1862,6 +1881,78 @@ cache_get_filehandle(nfs_export *exp, int len, char *p)
 	return &fh;
 }
 
+static struct nfs_fh_len *
+cache_get_filehandle_by_name(nfs_export *exp, char *name)
+{
+	static struct nfs_fh_len fh;
+	struct {
+		struct file_handle fh;
+		unsigned char handle[128];
+	} file_fh;
+	char buf[RPC_CHAN_BUF_SIZE] = {0};
+	char *mesg = buf;
+	int len, mnt_id;
+	unsigned int e_fsid;
+	struct knfsd_fh kfh;
+	char u[16];
+
+	memset(fh.fh_handle, 0, sizeof(fh.fh_handle));
+	
+	file_fh.fh.handle_bytes = 128;
+	if (name_to_handle_at(AT_FDCWD, name, &file_fh.fh, &mnt_id, 0) < 0)
+		return NULL;
+
+	memset(fh.fh_handle, 0, sizeof(fh.fh_handle));
+	memset(&kfh, 0, sizeof(struct knfsd_fh));
+	kfh.fh_version = 1;
+	kfh.fh_auth_type = 0;
+	e_fsid = exp->m_export.e_fsid;
+
+	if (e_fsid > 0) {
+		len = 12;
+		fh.fh_size = 8;
+		kfh.fh_size = 12;
+		kfh.fh_fsid_type = 1;
+		kfh.fh_fsid[0] = e_fsid;
+	} else {
+		len = file_fh.fh.handle_bytes + 8;
+		fh.fh_size = file_fh.fh.handle_bytes;
+		kfh.fh_size = file_fh.fh.handle_bytes + sizeof(kfh.fh_size);
+		kfh.fh_fsid_type = FSID_UUID16_INUM;
+		if (file_fh.fh.handle_bytes <= 12) {
+			kfh.fh_fsid[0] = *(uint32_t *)file_fh.fh.f_handle;
+			kfh.fh_fsid[1] = 0;
+		} else {
+			kfh.fh_fsid[0] = *(uint32_t *)file_fh.fh.f_handle;
+			kfh.fh_fsid[1] = *((uint32_t *)file_fh.fh.f_handle + 1);
+		}
+	}
+	kfh.fh_fileid_type = 0; // FILEID_ROOT
+
+	qword_addhex(&mesg, &len, kfh.fh_raw, kfh.fh_size);
+	mesg = buf;
+	len = qword_get(&mesg, (char *)fh.fh_handle, NFS3_FHSIZE);
+	if (e_fsid == 0) {
+		len = 16;
+		uuid_by_path(name, 0, 16, u);
+		memcpy((char *)fh.fh_handle+12, u, 16);
+		fh.fh_size += 16;
+	}
+	
+	return &fh;
+}
+
+struct nfs_fh_len *
+cache_get_filehandle(nfs_export *exp, int len, char *p)
+{
+	struct nfs_fh_len *fh;
+	fh = cache_get_filehandle_by_name(exp, p);
+	if (!fh)
+		fh = cache_get_filehandle_by_proc(exp, len, p);
+
+	return fh;
+}
+
 /* Wait for all worker child processes to exit and reap them */
 void
 cache_wait_for_workers(char *prog)
-- 
2.39.1


