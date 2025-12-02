Return-Path: <linux-nfs+bounces-16842-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2F5C9AFF7
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Dec 2025 10:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 815AD3441D7
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Dec 2025 09:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7C42848B2;
	Tue,  2 Dec 2025 09:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzaGZ+5B"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9785B31A55E
	for <linux-nfs@vger.kernel.org>; Tue,  2 Dec 2025 09:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764669153; cv=none; b=VmaOVJdXobcKIR5V1NZQAfamgxWzcad+o7OtzbqZV0n2iWlIX1FAMz8sQgT0MaiGCsr0rxQ4SbP/csr4ZLEIdgo1rZl5SnGK9bye7Uue20fAzBmxTc2B3mXzEfadwnyeH/V1UI4MhS0LuD/rtL4iLjIsgPT1mkAlELHWEXqSTsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764669153; c=relaxed/simple;
	bh=A2mUuXYeXgH3GWgj/1Uvi0IkvWKTlPl3+NWkZcL1hdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UdhAgmfFbuSfRhIbQBv76Z0zCvFBxiQScyJUVfEEFfeXptnZlQQexl7u2TEVnNwuLDrppnCaZXAgzWJiqiQ7Q8e/UvmQu+pd/m9Ey1Oqcw5PDuV9peTHfRuYVjgqTBEyYBl7L6vJizxImCXpxeCKVyq58ZX76/3DdfK32bs3YJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzaGZ+5B; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b98983bae8eso4161955a12.0
        for <linux-nfs@vger.kernel.org>; Tue, 02 Dec 2025 01:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764669151; x=1765273951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+6Q/13dXqqU2hdMSbPVRMXa6L7LavqU9DAw5tswhZM=;
        b=mzaGZ+5B3ktREpH/BxlYH4UVp0gqR6Sd28HPen0E5pXTnZ49CM1uQOrm4jc3XFqEBs
         pCs5+amAKjOi8Xbl0i51Ex7YlRZcVvJZSa6Pluik59LNDfcU0vKO/zRmtigpZW4bXlfV
         N1dAI5ywT1fB4p61Qm39bjZQHfijFc/YZYM0b4P2sxIIMser52edwnODoxr0lfuLcPPy
         qQbujrGumoeo32lMxvp8E4R9wIr0B0ViRbLy3Bev8sZ/h52M6QgC86wz2nkZJpYtPNY+
         koNKFofPAyW7YeiWOClGwl797q9SvW1JkObwlqFq0JWA6faOE1UZ1wH30Y37LRWzRygP
         /RQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764669151; x=1765273951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X+6Q/13dXqqU2hdMSbPVRMXa6L7LavqU9DAw5tswhZM=;
        b=Zy0ATNSRq3mvvyl8l3oNmM9YljmVuBiQ0IVcXtRf7FO9tLvBfaqn6YwWiw5wuXGFrm
         SMdK/KT/qyvHMvJXzBC2k/qCbkPA3JTt0Khkm3yYTk7MAnaciTCYQw2FbtoewxMCb/D8
         Ckxe72t/TsSabHuJn7BlDI3Qv/yARtdY78wkgxeY8pbHPTGDJUoyJeNX5XKr54Wi8qCc
         6286+2JbmLECHP7lzEabblX6f5wnjnjcwTM2j3wxtE6v25snci9Rq0CcJVM3CKJkqYor
         +QwqFJmtPJQXkaho7XGPyy7BgkJghkW4dzrFJS/GVl5gXOKL0Ox218N1j2ytpg7kGDkO
         Kp3w==
X-Gm-Message-State: AOJu0YxTne7ohnK9hDr+foPUFHERF4gfHyuxu0iZfO1zl1KfX1013/nh
	95tet9LZ2z7tfSCtEr4TpS5bw1+TQOJBl2aylxa+STOMoaRS0k/Y/HsL
X-Gm-Gg: ASbGncuGQd1Ttn2NUNXfx8lKbI8lEgwsiD9FTbaV5zfME7xzNc0u9O1NL00b/dBkzaq
	VThHB21ziICzh54NTiJ9cYycpF9Ly+j3m9NP4MP4KtvHZtWy5i3zIKqiEG/ufVKsDXTvDN/+FzQ
	MqBmWaxlVTqutHAyEhfuEuugy7MgHAAJWT1xshFGNFoxqgdoF37PshZnR1Kcx6lvwliqNeAAm6X
	Rmm5x76EsvdVYfTO8iEpPtmMMOXFdsRUhiUSAvckzCrlDS0ZaPoHjfJ59aM+XPxtu40j47sFg7G
	YufefjOKTB8z/kjvfU9zNRymlq4PtUh/9N6SNh4opRB2dUmoN8mxxQHIpUQgxH6rGPf1k2gmZTF
	ucpDCZYPAeT8GaFYOAMzk8gXR/vmJ8gYj7G1Dy4+uLJNn9VUSL4/Z3UCUnpcfxKDBA/mwBSZQbg
	3/seRA43TusUzJqDgmTS5LsaK7pG3t09rCqGQ=
X-Google-Smtp-Source: AGHT+IFA62oLYKnlDqtoBnPUAYcC3aQLjfERYxHt0mlC+Wj3TDUDWpCBfU4LNshvI4iel+R8CqbMaA==
X-Received: by 2002:a05:7300:8a1d:b0:2a4:3592:cf5e with SMTP id 5a478bee46e88-2a9415824d7mr14493264eec.2.1764669150541;
        Tue, 02 Dec 2025 01:52:30 -0800 (PST)
Received: from localhost.localdomain ([192.146.154.240])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5fcasm83532079c88.2.2025.12.02.01.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 01:52:30 -0800 (PST)
From: Gaurav Gangalwar <gaurav.gangalwar@gmail.com>
To: trondmy@kernel.org,
	anna@kernel.org,
	tom@talpey.com,
	chuck.lever@oracle.com
Cc: linux-nfs@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Gaurav Gangalwar <gaurav.gangalwar@gmail.com>
Subject: [PATCH v2] NFS: inherit parent transport protocol for referral mounts
Date: Tue,  2 Dec 2025 04:52:12 -0500
Message-ID: <20251202095212.69329-1-gaurav.gangalwar@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <CAJiE4OkW6XT71xvv49VN5STPx7dQ6GxV+-Rz1=55JhoFPyM7PQ@mail.gmail.com>
References: <CAJiE4OkW6XT71xvv49VN5STPx7dQ6GxV+-Rz1=55JhoFPyM7PQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When following NFS referrals, the client always attempts RDMA first
(if compiled in), even when the parent mount uses TCP. This causes
unnecessary timeouts when the referral server doesn't support RDMA.

Modify nfs4_create_referral_server() to check the parent client's
transport protocol. Only attempt RDMA if the parent is using RDMA,
otherwise use the parent's protocol (TCP/TCP-TLS) directly.

This eliminates connection delays for TCP-based referrals in
environments where RDMA is compiled in but not deployed.

Signed-off-by: Gaurav Gangalwar <gaurav.gangalwar@gmail.com>

---
Changes since v1:
- Removed module parameter.
---
 fs/nfs/nfs4client.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 3a4baed993c9..39a0424523e5 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -1258,12 +1258,19 @@ struct nfs_server *nfs4_create_referral_server(struct fs_context *fc)
 	nfs_server_copy_userdata(server, parent_server);
 
 	/* Get a client representation */
+	/*
+	 * Only try RDMA if the parent client is using RDMA. This avoids
+	 * connection delays when parent uses TCP and referral server doesn't
+	 * support RDMA.
+	 */
 #if IS_ENABLED(CONFIG_SUNRPC_XPRT_RDMA)
-	rpc_set_port(&ctx->nfs_server.address, NFS_RDMA_PORT);
-	cl_init.proto = XPRT_TRANSPORT_RDMA;
-	error = nfs4_set_client(server, &cl_init);
-	if (!error)
-		goto init_server;
+	if (parent_client->cl_proto == XPRT_TRANSPORT_RDMA) {
+		rpc_set_port(&ctx->nfs_server.address, NFS_RDMA_PORT);
+		cl_init.proto = XPRT_TRANSPORT_RDMA;
+		error = nfs4_set_client(server, &cl_init);
+		if (!error)
+			goto init_server;
+	}
 #endif	/* IS_ENABLED(CONFIG_SUNRPC_XPRT_RDMA) */
 
 	cl_init.proto = XPRT_TRANSPORT_TCP;
-- 
2.43.7


