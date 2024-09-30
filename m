Return-Path: <linux-nfs+bounces-6724-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372C098AA42
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 18:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692661C20C4C
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 16:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EE21946AA;
	Mon, 30 Sep 2024 16:46:53 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DEC195805
	for <linux-nfs@vger.kernel.org>; Mon, 30 Sep 2024 16:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727714813; cv=none; b=mhcmHr6BRAVBYGOHjKh1YsJ7eAlDDHsK1swfWuygm/rT4jCrmXHvSnHoV9+vkgbVhC+GXUA/KX6u6y3D2eMwoVzf3Ku2VTw7I4GqetJBRP13HfR9n4QTAgOpNQY2qTfzRGWL8fy391z/fgZsZdyM+XU0FvJxJyS771/IQefxQ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727714813; c=relaxed/simple;
	bh=dO9gozPdQl2OhaD5p9iHUgs5avHYX0qx6mcdaqSzgvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Csc0O3KJuiixusBMk57xTbGem8UZMll6VMaGqATiGNxne6HXwJhM/FqwPdNYOjFEe9ukCiqFTx3AkWHAllFELOZI1Dgk5EcplEInueLcRMmovqCSasLs1oJeRExQ4HgXesrw8OVtCQOAzNRMDQ/h+K1JXbjaJy8aKJ3PNArqlEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6cb399056b4so34454836d6.0
        for <linux-nfs@vger.kernel.org>; Mon, 30 Sep 2024 09:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727714809; x=1728319609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yYd3ZPfO1PQXNlVSLH8W9udmGwHGxWcACHmAcODqJLM=;
        b=rAh+0xyqjyEciHSHa2Siy6XhFvWXwBAH+Zv0KWEdgiCXNtTtz7tKP5p/Lrlr6n1POQ
         8pT88WoNF7vru9yTkpBev5HGFWbGspYFS0/RuX63hnIjI7UqwzFWXQDspgYoPtMI9zEP
         rteAFBrqdXqh9fxmOjjmI3kZpe1jEh6/iT6M1LHVrB0aHWGRTAYjRqo+00B5abH6qB0g
         OrtLhJKI73PWwPDk4qR4uDoo73iscwG1ZZuZpJaArCkimAOKXIdrhuRLT6ggyMdutkZ0
         uFfBY0qmCFKlXXHSh8pFYb8fLm+bwIqyt99zAqE+00jUj2PfYL5z4ydteyjjMQ8+yf5G
         tajQ==
X-Gm-Message-State: AOJu0Yy+ZfBPeKTDn1zEGIV5gL+t8RhJzXChB62avqJr7VNdmfOhGJBX
	eIZRRYn6ldPEtBX5nWzo3+F9ene+CGibaAF3iXfbXwVBG2mz/qSKkWAPEVOzFRgeWhaYDt2qlZ+
	4hr2wOXK6R50ZlLhBP+TqRkQJPILGW45J/VMcZ2cMMrTrGfnSAmvYyrarE2NEjKGDY9FfhK2QZU
	HDygaf7s/toaxu99mD+zX4SJC/HOBikYUW4K+AH48=
X-Google-Smtp-Source: AGHT+IFj47mqr6DVEXs2TLgsan/Hd2OR1wD4l7fdxY8pYFTxR/4V3ypHwlLSpM8KeDZxVvTb40AhLw==
X-Received: by 2002:a05:6214:5902:b0:6cb:4625:983 with SMTP id 6a1803df08f44-6cb462513a5mr197908666d6.7.1727714808710;
        Mon, 30 Sep 2024 09:46:48 -0700 (PDT)
Received: from localhost (pool-68-160-145-92.bstnma.fios.verizon.net. [68.160.145.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b68e7fesm41324516d6.132.2024.09.30.09.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 09:46:46 -0700 (PDT)
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	Matthew Wilcox <willy@infradead.org>
Subject: [6.12-rc2 PATCH 2/5] nfs/localio: remove redundant suid/sgid handling
Date: Mon, 30 Sep 2024 12:46:34 -0400
Message-ID: <20240930164637.8300-3-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240930164637.8300-1-snitzer@kernel.org>
References: <20240930164637.8300-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mike Snitzer <snitzer@hammerspace.com>

nfs_writeback_done() will take care of suid/sgid corner case.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/localio.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index d124c265b8fd..88b6658b93fc 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -521,12 +521,7 @@ nfs_local_write_done(struct nfs_local_kiocb *iocb, long status)
 	}
 	if (status < 0)
 		nfs_reset_boot_verifier(inode);
-	else if (nfs_should_remove_suid(inode)) {
-		/* Deal with the suid/sgid bit corner case */
-		spin_lock(&inode->i_lock);
-		nfs_set_cache_invalid(inode, NFS_INO_INVALID_MODE);
-		spin_unlock(&inode->i_lock);
-	}
+
 	nfs_local_pgio_done(hdr, status);
 }
 
-- 
2.44.0


