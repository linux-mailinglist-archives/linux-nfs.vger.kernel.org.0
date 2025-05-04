Return-Path: <linux-nfs+bounces-11434-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 403C7AA867B
	for <lists+linux-nfs@lfdr.de>; Sun,  4 May 2025 14:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8011C7A195F
	for <lists+linux-nfs@lfdr.de>; Sun,  4 May 2025 12:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677EF61FF2;
	Sun,  4 May 2025 12:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AUHRVFZb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE618C0B
	for <linux-nfs@vger.kernel.org>; Sun,  4 May 2025 12:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746363435; cv=none; b=g7+YNcSFtRWzwuCJqv8RSjUTLZlGDAjrPEj70j9pRIg4EWNM8iqm/BjGLG28XxDk3kiMuuJ4MSyH+BDM+lpMekE1vnu2OJUB7K923j3AzIPiXNymk78qG3udgLBX9hq2ixUfgsc3hNKO5/RoWNt4cggi/XGr51t41KXgAm4jSNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746363435; c=relaxed/simple;
	bh=HwLrxVdMWFx9KgOvlmeWWeOal1tqn04f+FPBRd/LhD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NpkruicIAuJNio9Z93b4ygdLyb3+tzpknxX1y5L4n0LDXI8AtwiRxPCzWI1WsawXMTBPTlPe22fhrgO3wqKB5H+VM8eLaA/G3owPViRtlyNAb+C3m0Qxj2+1vFazt3Tj4DXqQiBbfDszx5NUAkLBSgP5arcCWfXWFuahkYXo+2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AUHRVFZb; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22c33677183so41216595ad.2
        for <linux-nfs@vger.kernel.org>; Sun, 04 May 2025 05:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1746363432; x=1746968232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIPOcwwZq+UnFgbLAD4qmHv3wOCyN2fkCvHP4gis5Gc=;
        b=AUHRVFZbBY2G9Cj6ZwwQ2TyydjnfZH5stMgHO3XVPcX/MGsUsLmFTN6/qI3F6x74Xj
         RzwgzOsXbP7P17xebe4yxp1LUpg8RwOT+Y97BogP+/+++MS1+5R33Q0pxyAOojCnX34P
         pGo9xC/bwjdpUyqoMapUAIog5ifqQFWSbJwnACLUy3t/r7iaCZkO3YBk4eFDvjK4Q01k
         sl6r62HoTpmWa7wssZXxATilQ9yh/nhwk/n08LuSbdjj375tzMHgIPw6vPn70UCOLIwb
         lNdz0L4RxJOz830vZuQE6lBHtdSQv8K2jWv92vhlTZJIYVvC35fjQOOOWSBVpIjEGbXh
         HkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746363432; x=1746968232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CIPOcwwZq+UnFgbLAD4qmHv3wOCyN2fkCvHP4gis5Gc=;
        b=nwxPvXhhXmg+5FIKhEZVz5t9zx5XDX3/5MpAUjIXG3f73shP0R/OxJ/DUJunQkbXJA
         ofhevVQuoSGbL7OT+sm+PHRv3NykD+6ypPs8SJNRgP/XDpBQ5qBzvYWsnacZlNZbrrtB
         nW+c9ZmBfre+94Igf0ZFLTKlqpPxOfKmFuwqE289QzEco8kbXtC6BDzYgv1MtcyI7ynk
         gZX1B8EuSyyiZjMJkt+dBuw1Vz9/jZgZPbOXo0QfwlU1enCSKo0tTXcvXSILkSDuHLP8
         vgbLw7rt9jOOlWaOufpQVXw1bIJ2o8/UlcQfeaZpq7veLyf2LWA3olTzOjcVHpfGhh/w
         XIVg==
X-Gm-Message-State: AOJu0YwZcrQsi3faghUGRt8XfeafyK0Jd8zmTY4mgd8hb+SOJAmjEYYD
	wqHx8jiDWsrKwCe9EOTKsM8Mr3DPqwrpkpGFXi2F+Ux7f9/3sMTAVDKSmxQFC98=
X-Gm-Gg: ASbGnctTPsLH3vyVxcQrSoxX3tT1682EsyPNNrOYVnpBqbTCmcb4j2PIYPdTnshA7VT
	MMav/4uWwj/Uj6DAoXU5BlJ7pkJE7bmvujoAYE6VBmJGuPcgcyq3CHv3SmtTpXnDXFLL3pic8JM
	MVxw8yi4BdfRGmv6MwmdLQj0bvUjsqZgVJ86idjYIGrnWMxWqfPumvZ+JMK0viKgW9N+d6Xu8XU
	SvFlrh6VaOwaEIuaT6GSpCk0wKe9948gCxoe0I6zIq8HOJ8BGNg7zVakE+MwnyyppTsovY/ig9w
	/eq0P6HvgArhs2S9BayQ4yOA1CHDKHPy67yso55+hZd42UopPc49faNZGisFJ78NYBP4expG6RY
	=
X-Google-Smtp-Source: AGHT+IGaVqP0R3nKv2yipnY2p/1fzcYpY/pBgfIddvdWaoB1hK3jHM4zvoVv+f71mVv+7LBao1upBQ==
X-Received: by 2002:a17:903:19eb:b0:224:1eab:97b2 with SMTP id d9443c01a7336-22e1ec3e7c7mr59732215ad.53.1746363432534;
        Sun, 04 May 2025 05:57:12 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1522fa58sm37257605ad.242.2025.05.04.05.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 May 2025 05:57:11 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org,
	Han Young <hanyang.tony@bytedance.com>
Subject: [PATCH v2] NFSv4: Always set NLINK even if the server doesn't support it
Date: Sun,  4 May 2025 20:57:04 +0800
Message-ID: <20250504125704.76237-1-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250502151544.76653-1-hanyang.tony@bytedance.com>
References: <20250502151544.76653-1-hanyang.tony@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fattr4_numlinks is a recommended attribute, so the client should emulate
it even if the server doesn't support it. In decode_attr_nlink function
in nfs4xdr.c, nlink is initialized to 1. However, this default value
isn't set to the inode due to the check in nfs_fhget.

So if the server doesn't support numlinks, inode's nlink will be zero,
the mount will fail with error "Stale file handle". Set the nlink to 1
if the server doesn't support it.

Signed-off-by: Han Young <hanyang.tony@bytedance.com>
---
 fs/nfs/inode.c | 2 ++
 1 file changed, 2 insertions(+)

Changes since v1:
set the nlink to 1 in the else, instead of relying on fattr->nlink,
which is uninitialized.

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 119e447758b9..4695292378bb 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -557,6 +557,8 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 			set_nlink(inode, fattr->nlink);
 		else if (fattr_supported & NFS_ATTR_FATTR_NLINK)
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_NLINK);
+		else
+			set_nlink(inode, 1);
 		if (fattr->valid & NFS_ATTR_FATTR_OWNER)
 			inode->i_uid = fattr->uid;
 		else if (fattr_supported & NFS_ATTR_FATTR_OWNER)
-- 
2.48.1


