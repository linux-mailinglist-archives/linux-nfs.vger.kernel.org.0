Return-Path: <linux-nfs+bounces-3604-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF03900692
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 16:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADACBB286B7
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 14:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589691667DE;
	Fri,  7 Jun 2024 14:27:19 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C60C194C8B
	for <linux-nfs@vger.kernel.org>; Fri,  7 Jun 2024 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770439; cv=none; b=CVPJNf9Q5qwOWTGBa6SxpGsb4STsDAIb1ItFBQh0T9OIMpQMlmGm28jUFnWZ9Md2phnGIy/2/w0EzSmf/UF3Zxe+E+fOjBlYPwuBP/8yHmE+UAR1Q79D+4kv1bRn+BrOWcJb1PvUVQVdHxXGlqopnfvXYMeGiAq5ybOGHwixLQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770439; c=relaxed/simple;
	bh=ii+5ry2KMBfdheobxP5xhqF0+2hL1tmuG/yExU1eLAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWUwrMqUG/+WRvAyx0VqWE1haJpFnh3rWT3NU0GaZYxxemKGDobSkqW785xtbWtxV6HIXs0nFpwILmBmke16qvRRBrWfvgzB2fMD0cmDfGuhNkVx6Flsh1PJD1rKIPyWkNFKFb4eK1tazRoy6zM8H8MqelmwRZhIvlGrgvnPBoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6f96445cfaeso133559a34.2
        for <linux-nfs@vger.kernel.org>; Fri, 07 Jun 2024 07:27:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717770437; x=1718375237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sb4QyxgGf3qFoLoTCWz/lmuqZ+CKWHrUcZJHvENFZhI=;
        b=NRhkw1t/LUei1JjKNuesZx/Fgu73nElb7u7SEHflWEEf0ENmgjwQoCidx9uDCZ0dbd
         EHYppSEXpSTP7Ce9Maq/6NrRZWAmM1Li7H2Bn61s2Vi7bLO9SRR1b4qOET4e2j1auvkZ
         p27ootFmZ4PwovsO02ZevHQ3IGJjbV3Ved5C5NUghcdUXz3Niy/vTSeVcMoK78CFHvg2
         b/RZQVc91k554O/Jje0Ald6QIW8pCbKr/em//6eCtkIECysDyQw8Ji8uIK9SsCQcx3kg
         aL0s/u0NQTdc7M3e1Xp9gYl/dTIMCjyJpZccIZFv8+Mg63+jy1akD9Q2gjGgKNIw5cnU
         uaFQ==
X-Gm-Message-State: AOJu0YxZP7Gx8ISJEr1ZLr4DwYHMTS+Um5PPMb8exAufEl6xGgJ5OTGy
	PKwmFekrxn3FiUV5YPtRmgfZvaE9tdcW0C1sc2+NmeSkmDk6WXFSYfyYbdU7e8tSQ0DFBMCHl85
	SyN0=
X-Google-Smtp-Source: AGHT+IGLRs/I/NjfAyfp43kWgy8mun8erZLVtlncJTW0VWCOn7wV+iqRcukTE9KpIPXsIWr6NjGYMA==
X-Received: by 2002:a05:6830:1055:b0:6f8:e05e:a50b with SMTP id 46e09a7af769-6f9571ea66amr2789927a34.1.1717770436898;
        Fri, 07 Jun 2024 07:27:16 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7953284ceccsm171235385a.29.2024.06.07.07.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:27:16 -0700 (PDT)
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	snitzer@hammerspace.com
Subject: [for-6.11 PATCH 19/29] nfs/write: fix nfs_initiate_commit to return error from nfs_local_commit
Date: Fri,  7 Jun 2024 10:26:36 -0400
Message-ID: <20240607142646.20924-20-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240607142646.20924-1-snitzer@kernel.org>
References: <20240607142646.20924-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

status was established in nfs_initiate_commit when nfs_local_commit
was introduced, but it was never actually used to return any error
from nfs_local_commit.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 79375af3f2a6..7deda7e90d22 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1704,7 +1704,7 @@ int nfs_initiate_commit(struct nfs_client *clp,
 	dprintk("NFS: initiated commit call\n");
 
 	if (localio) {
-		nfs_local_commit(clp, localio, data, call_ops, how);
+		status = nfs_local_commit(clp, localio, data, call_ops, how);
 		goto out;
 	}
 
-- 
2.44.0


