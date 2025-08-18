Return-Path: <linux-nfs+bounces-13755-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 440D1B2B3EE
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Aug 2025 00:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D709B1B22CC2
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 22:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C93D1E5205;
	Mon, 18 Aug 2025 22:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ATAC1AK5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924831E25F2
	for <linux-nfs@vger.kernel.org>; Mon, 18 Aug 2025 22:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755554904; cv=none; b=ZTSQ7EpljE/PIbMIuFFIR+B50Hphv1qniHrs2xCBKBcEQbzJTzAByQ6AVz+mtmqAGFwq7v6CxIOHkF8B/PfdIwqkziJ3eaqVfWhxZfC5Elp91h4+ztpfsJu155IwknHUMoSe7GRz4UQwNr5xoByNqDDSKRgvDeZred7dfLiX0Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755554904; c=relaxed/simple;
	bh=C6pIljQUVbXribM74eO/Yi4zDmJMVwzxtOTyMoH2G6c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eDlyynIkn9zvnU0hRIPljEg/5ThWOKBmT3qhgls/y6kkYwnr9zBp/oLtNSYLDROwwvYWAb+QEK5yIlMxtsN6ufAY+sLh5GPhqWAa3YaRSF2dEtvPKFc5uM0l4XK4NwG7s5WFqz8h57lFblCs9+xPN7a15W6nbtpgkiEOaxzqsx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ATAC1AK5; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6197efa570eso5217246a12.1
        for <linux-nfs@vger.kernel.org>; Mon, 18 Aug 2025 15:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1755554901; x=1756159701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+rHpWL/Piu+edXatPGs9bVuXgKSl2HpG+xEZdZh0g8=;
        b=ATAC1AK5yGbdkUHX5mg3o3ZiZnEkOcVqsdeE6Cbt7xcVL18FIhywYHCP5noSLZ4TeB
         T9P8MPpraV74leyGe6juZeJTMVMufoYNLjh3y8RtinlEaKUhxuSOrUFtTSSZ6pGn8fpp
         zkiIRfVqmbcXaMAxS1+gyDXmwpNv+GK2gpQvBzQQ8dvpZjFZ6uMDVmlvYInQj8pjCQN8
         tQgl0eO6a5JmvxPl+ENNJeerxi5XifNzNYT6M5vq0E8TPXZezwQnNfCnQCZJ23TJ8vfG
         9HIwz72az6mymkzZTvB+L9+RaQq2ganXMgzRGLRXW07HMD0/p47TmxpUY2byiPrv1vw9
         4zDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755554901; x=1756159701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+rHpWL/Piu+edXatPGs9bVuXgKSl2HpG+xEZdZh0g8=;
        b=MCCoh0MweQgSLH58UzQfXHkf55WnB8scnAw8MFmf17cOYqA1CqwgYh3jGv5rFOcxPv
         RCekNPAhcYOnDjz1CdiVVq0YiKEpsdGKhN030lX2T+4rwcVmqVKN6kOWBegp3mySUHL5
         gG8uyijVrg/FsIllprZiuVc7J/ge3s4PMZjS4mwQDdZdjXwxTO/5Ki2zBmZkMGSkYmOE
         2hGBX9v/K4YENvsbqHkmYHGCcTyHDYg5L08/jTle1FynAkWpvcrN49WOeYZMwm1J6qrA
         KN8HDSmUkk6uQXYExs/sff00OPrZVUyVAeXCwn0aEBbiFlH/mJ+T6vNAKrUzEtrC8nK7
         yQRg==
X-Forwarded-Encrypted: i=1; AJvYcCXc1VNRobk8qAQ216tTyoWaMbZ5Xb2wg01vH3cGjYC9DeBcfUDPwVYZnUptAwd7bp9YhfA2OzX9qds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7S3nv549zfMRyOc6awO2MciJIpIjFGXgwi8YUkXJGDtLj7DNM
	la/BkzEwZdNyh9kKed1mIS2hQiP/Yiollmc4EObNGGZj98iasvksanGwQ9JZLcmhFqU=
X-Gm-Gg: ASbGncuOeooA7nqyCRveGQD5Cb3i5R8OGGVWkJej9LOkIT19tCYXMX7PKORtFhg0oua
	dcQCWmqp853zI6qpe7vJFTeLBsKNsJ2DE8SXZ+96MKsVYc/SD7Oog1mdw2bXxlup1bg7lTiJtfn
	oZHsKFSce+r0Z+/v6Sn8nSHTvl4GWOhHV0AivsE2HAn7++mZ2T/ZiFr/owVtjcX+pXYFV7/5F5Y
	FW+Yp6JgF+i5KfIj7PERyzcFLcWP/FbUT0xsZLqiGS6R3dCFJWWAJJj4bW4lBlQJMcGcdHWHk7g
	wWEvKH2xkPakDhwYyJNqIjgi5D2eSPcVHZ8mFjEpsLeXnTRVjNkTkpgFpGwTiNSO4a05EVYQelX
	mUgeXappSi8FqOuGVg0cNQ4Y=
X-Google-Smtp-Source: AGHT+IEEyoa7WDLe//9ppCfw2MgNt9HtHHZR+Y+BvMNLEZJQ8Kasqjb0CX/+4HEU0S5TQ2rfPJ+4yw==
X-Received: by 2002:a17:907:da7:b0:afa:1bf0:97fa with SMTP id a640c23a62f3a-afddccdcaedmr31772966b.25.1755554900809;
        Mon, 18 Aug 2025 15:08:20 -0700 (PDT)
Received: from localhost ([208.88.158.128])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-afcdce72ce4sm874054266b.32.2025.08.18.15.08.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 15:08:20 -0700 (PDT)
From: Jonathan Curley <jcurley@purestorage.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jonathan Curley <jcurley@purestorage.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 2/9] NFSv4/flexfiles: Use ds_commit_idx when marking a write commit
Date: Mon, 18 Aug 2025 22:07:43 +0000
Message-Id: <20250818220750.47085-3-jcurley@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250818220750.47085-1-jcurley@purestorage.com>
References: <20250818220750.47085-1-jcurley@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct this path to use ds_commit_idx. Another noop preparation
change. In current code commit_idx == mirror_idx but when striping is
enabled that will not be true.

Signed-off-by: Jonathan Curley <jcurley@purestorage.com>
---
 fs/nfs/write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 374fc6b34c79..422bb817cc85 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -977,7 +977,7 @@ static void nfs_write_completion(struct nfs_pgio_header *hdr)
 			req->wb_nio = 0;
 			memcpy(&req->wb_verf, &hdr->verf.verifier, sizeof(req->wb_verf));
 			nfs_mark_request_commit(req, hdr->lseg, &cinfo,
-				hdr->pgio_mirror_idx);
+				hdr->ds_commit_idx);
 			goto next;
 		}
 remove_req:
-- 
2.34.1


