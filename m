Return-Path: <linux-nfs+bounces-17400-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC7CCEF784
	for <lists+linux-nfs@lfdr.de>; Sat, 03 Jan 2026 00:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECBC7300EE62
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Jan 2026 23:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9191A08BC;
	Fri,  2 Jan 2026 23:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVUGc16y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F50D279358
	for <linux-nfs@vger.kernel.org>; Fri,  2 Jan 2026 23:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767396631; cv=none; b=TFuwz830c37QK/BpSwScyIhqxcPWNEPOm5c00nGPaE79X4iKn8YG8D2p+X2Blyk/FGdtmoNAjjnfHdgZKveLyu9nFPc70B4u8aqybhelSPBOd2t/5I/Om4RIFJ+qqwKbKEmJMx6a3VJEq8CqNW9t+DOaMk5o8Kz74vF2ouhsn8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767396631; c=relaxed/simple;
	bh=bxaf5RIECU4LIJCbHHsw0q4aPee/VbfY8OSxytUoJCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XVY8Bt+2826PQzOIdKWf7V22JPdxDizNS5BhDCrbGxFaqu2qSU9m0Ve0FtuQTedmeaa8PeDp2rz7M8pVV+PiNkqV/9XTCGmrotom8TqXLflofxK8/9sRFW7yDNJWtLiulOhUSZKcavzOa2rww+ZgFUmnLbU1O0ECZs59nR4FuCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVUGc16y; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a12ebe4b74so222297715ad.0
        for <linux-nfs@vger.kernel.org>; Fri, 02 Jan 2026 15:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767396629; x=1768001429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMg+y1I+VxjhTBpIG8jv49h8G/WLlJofNq+ULEspMvw=;
        b=VVUGc16ymbse187x948X+2dNsL6RjfwJfEyxuvn3KYp7NK9WI6LSxNd03YtNxqi/OM
         cUdnJpu/2TZVec89ZXCjSaWHNVlw0DxKQoAiV8E3Xmcf3nNe+DVI1CcyAC/eLh007Mzl
         LZKNG2hppxs2qACQeYJnQkrkprNQldjWQTkqS0feK5rUxwEPvYn4fAXUe96/Nuvv38zh
         5xlPmvtpOMXHuJ2DFsj1qpzMBnzBLlXDhYxLSWpZe2B+2Un42AKn8UXRMOYEvHChY/4C
         wjI8bkM1F/tWsM+zPnY8J2cWgxB9CVl2C5zRJ7gBs9j4nli6ZXG+o8Pht+0cXpUOWaIt
         2GnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767396629; x=1768001429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hMg+y1I+VxjhTBpIG8jv49h8G/WLlJofNq+ULEspMvw=;
        b=T9htS/dkQgLA2wUx4nuB7rW63OUk44+EvPO86JebgwNOv6crMh38B1RXI3cHQKXszu
         WiNSZ1VWm/Fg7NPOHFU4OhLGW32X6h70aIivgQz/6ZezyOjIR0zrnhxrmVeZ964IqxTU
         xugt1Pjc4omL9zWb/BV5Fer9iMBB55gmxQqUrORzBm4AyjNP1uNrYRJYp02qLRaJ3c6h
         wIuXSd7+NnYt8c8tSqv5ghU+vdRggPHoH+zXJRkAWrwVxOv/l8KZP5CODPkJ76t7X2Bo
         gj6IWujvie+o+s15+L3XoTcphm6EgnfVzHUjSiZA2e+lYm+679J8GlEfFQgWvgeJsDse
         dAvA==
X-Gm-Message-State: AOJu0YxzTchM7AG8yBKBcbGViOHX86TAPTMD7BNdaKcjd79S8D3Eyu8x
	jcGRt8ug0UV3XVSuMs3plAsaDutv61lIJKS5k+WIMQuKM8VwpblUoIVz7TBWywE=
X-Gm-Gg: AY/fxX4KpGatGWuqQpS4Dd0NF3yCI1RjOUK7QVZTS/xslpMHhmzTn0p0kS7xRPSSCnV
	uFbw8Aqk+yPwjqTpy3RcWaTpTvIJGk1qUu/amho93MtB6WZv4VBinzhEMrMNuhRsRN5ynmLsqMm
	6cqSCGhKz+Rn3X260AkEyhB8dTFTgh8CS8MVl5R0uf8HFsvjMtnch6r47q89+/NrLg731XfllXl
	7zSSZ7r8B7dANL1VsWEsI4q+ZDe1nKJ0XJLmdknT17utwied/64tFuHGejXIb7XljJemixk7GUh
	X3B5gDDYHk/nel75LjCRvr9ZSFW/JXYVUYI6Sl1Z+fiyBiteA56cCz78BkHTtztDytF8+n7Lwih
	tbL3C/4f8huruVZx/QqzPCwHo+X1G8LB1P1Xxu+T3Gu/B62A8f0iEVMwaG8LdwIStP28CJ2caEk
	BuAGq+gchXgW4gez+8cH+KDs8gzl1d5PGdOKASy3VcFLL4mTxFG0hS4SGK
X-Google-Smtp-Source: AGHT+IFZMNVva3fyBMGExiUBMAjLVzPYscqGRVKQQXX5cE+k09NG52EctIzPSGchvVbaDZexPO/BGA==
X-Received: by 2002:a17:903:2f87:b0:2a1:14dd:573 with SMTP id d9443c01a7336-2a2f242471dmr444011285ad.23.1767396629554;
        Fri, 02 Jan 2026 15:30:29 -0800 (PST)
Received: from nfsv4-laptop2.cgocable.net (d75-157-27-199.bchsia.telus.net. [75.157.27.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c71853sm391508805ad.19.2026.01.02.15.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 15:30:28 -0800 (PST)
From: rick.macklem@gmail.com
To: linux-nfs@vger.kernel.org
Cc: Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v1 2/7] Add new entries for handling POSIX draft ACLs
Date: Fri,  2 Jan 2026 15:29:29 -0800
Message-ID: <20260102232934.1560-3-rick.macklem@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260102232934.1560-1-rick.macklem@gmail.com>
References: <20260102232934.1560-1-rick.macklem@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rick Macklem <rmacklem@uoguelph.ca>

Add structures and definitions for the handling
of POSIX draft ACLs for the NFS client.

Signed-off-by: Rick Macklem <rmacklem@uoguelph.ca>
---
 include/linux/nfs_xdr.h | 49 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 79fe2dfb470f..5ff8ab3f0f84 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1622,6 +1622,46 @@ struct nfs42_removexattrres {
 	struct nfs4_change_info		cinfo;
 };
 
+struct nfs42_getposixaclargs {
+	struct nfs4_sequence_args 	seq_args;
+	struct nfs_fh *			fh;
+	int				mask;
+	struct page **			pages;
+};
+
+struct nfs42_getposixaclres {
+	struct nfs4_sequence_res	seq_res;
+	const struct nfs_server *	server;
+	int				mask;
+	unsigned int			acl_access_count;
+	unsigned int			acl_default_count;
+	struct posix_acl *		acl_access;
+	struct posix_acl *		acl_default;
+};
+
+struct nfs42_setposixaclargs {
+	struct nfs4_sequence_args 	seq_args;
+	struct nfs_fh *			fh;
+	const struct nfs_server *	server;
+	struct inode *			inode;
+	int				mask;
+	struct posix_acl *		acl_access;
+	struct posix_acl *		acl_default;
+	size_t				len;
+	struct page **			pages;
+};
+
+struct nfs42_setposixaclres {
+	struct nfs4_sequence_res	seq_res;
+	const struct nfs_server *	server;
+};
+
+#define	NFS4_ACL_INLINE_BUFSIZE	((2*(1+3*4+35*(NFS_ACL_MAX_ENTRIES_INLINE-4)))	\
+				 << 2)
+#define NFS4_ACL_MAXPAGES	((2*(4+12*NFS_ACL_MAX_ENTRIES+		\
+				 IDMAP_NAMESZ*(NFS_ACL_MAX_ENTRIES-4))+	\
+				 PAGE_SIZE - 1) >> PAGE_SHIFT)
+
 #endif /* CONFIG_NFS_V4_2 */
 
 struct nfs_page;
@@ -1765,6 +1805,15 @@ struct nfs_renamedata {
 	bool cancelled;
 };
 
+struct nfs_xdr_putpage_desc {
+	struct page	**pages;
+	void		*p;
+	void		*endp;
+	size_t		npages;
+	size_t		page_pos;
+	size_t		max_npages;
+};
+
 struct nfs_access_entry;
 struct nfs_client;
 struct rpc_timeout;
-- 
2.49.0


