Return-Path: <linux-nfs+bounces-12823-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C3AAEE6D7
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Jun 2025 20:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6674D17FF0E
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Jun 2025 18:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD1FEADC;
	Mon, 30 Jun 2025 18:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFwm5yod"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986022E54D2;
	Mon, 30 Jun 2025 18:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751308566; cv=none; b=fI7SIjdP3KNbvttcKWy60CBH7WkA67+B+CnUbFLIeVQpWRGSvEEQp6+ayNi2jua9rmsWaGa73B5ZrRyoVKrBfIB8XRZX+MiV2bs7iDraVegwHhkRvgVEfhzNnEA37MSwQejVtU1l15zg9EFPWi/uv6GfXKIGkoEw1vcVMfkq+do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751308566; c=relaxed/simple;
	bh=CJDIdZiGcnrzwH4FjTCpmNqcK+ouJMAgoNX3eCN5Yg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vBIDJDvjODhaseQcsz9Y99tWWRiF+EkziCUt/K4JB+iW9lrjKx0TNp2Yq7kbSlVmn2ReuHSEmbw/eVM0+GGIFrD9QewTywY+0R0Dmrb8zEVHRrsjabGUqzKOucVWNYNBcAJH8BMLuJaOSzsfFLqhB0jQaX5c3/r+x7LJgmUDchg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFwm5yod; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-553c31542b1so2844420e87.2;
        Mon, 30 Jun 2025 11:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751308563; x=1751913363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vloA9hnEfaZRfFrBFN7HQOldZIvROZ2AysUaNQzK8FE=;
        b=eFwm5yodsiUN0lFiqJxuL7x4axmCWgk4+VxmxDSSihT4aLh9wPDZAVd38Z5UxRhIey
         rYfkF3D3Zt+A+q00xlP0qJO48i94sFf5Ex528PExdomSNk7DQie/T5Dhm8E1+7mBlC9B
         N8XmAVNh4MCyhNZKgnmnxDmKOYtbBKgcITDqjLCYegTnQCjFY03G3kHUmT1GNuYSZygh
         huVSxxFn56tJo1KeWJ3pgCS8NBCuiw7nAlNJoQAC012UPHnhzMcPbZpLtETF4fhlWYPG
         0TIf0nk9OeVDHL8RuxxP5Pn9OK/wcFEDLToOVouirreoXHQJ6LV+FOO/8d3KmFvNvE3u
         NWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751308563; x=1751913363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vloA9hnEfaZRfFrBFN7HQOldZIvROZ2AysUaNQzK8FE=;
        b=afSuhIr7lWdtRwmPB1Z9Sbq8DdHUPMcnPSYfaW4g3sqSRnyCgD2B6/lNNYC4OBwZCN
         mJmo3eY7b8NZbsMChweAoef7R89tyLpF2OEY7qwiFIwe8fSIZSYhk1sQ3mCEmQYChqQM
         8fLlziCZ0N6CPmodnSXq8FqNh+yHmSyeHrvjoPlo8Uf6/Budrmmg57wLdCtoun72L7Ms
         k9DmpjUtR0NzWZgB4/6fzetULDIJRWalSpCU8YXj7McANZp6ZiR70Sd6z+lRhPkTpRqH
         WNdlpdK3/0Gv+6U8rXZ5wm8IpQEe2jqd504JPVjAVOFtJLaA6iCem9M2vr/6JHS0MWZ5
         Qf5w==
X-Forwarded-Encrypted: i=1; AJvYcCWsT2A5IpjEsSX/XIAaCunip4UGEPQ999OVN77/GKg1/P0uSyPtceuZeJaM7xPM1U24sspi7N1WtsSC0t4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhWsRRoZpqeytVlexHpGlxqMiTI5QaYwUUGUiAc39LHthEBP51
	di//F+XIrRq4+cij4Cq7OA88c1eDEhXHCtSNDN9zm6Mqme7PqsKSyxHHTHaos/03
X-Gm-Gg: ASbGnctWmeOBy+U5mpHyidHy3x1o/crbu+7UUKYbuarRLDdUOS+sqslimtfZlzONbIP
	WT/URtE2hqKfWhQ1uJ6jh2nZiz7A5N77wFhuM50QiyF3ewZjsHAmZn+wNo1/CgZneaPqk/yQTYb
	Yz0QZKFJkLYjn9joZOwluXPiiThkx8aeQ/V+KZr3KXqQob18uQCud2rrbaMLy+XjcnaHTnF3Pf0
	aXW0NvvOoOWdzy3l8bvbaiijT6OfhpEsWZRi21EXszHAfTp1ur0qH3P1qdh0SxL/qWSrLelDH7q
	SNhfNxo6MYtvuBOa7HjI8ODNl8eUkSVaOWHlsA7VdXl12JLtO3HWY6cqdmY2+dkNalYdLqgMQGO
	MojwO2/rY6IiYLw==
X-Google-Smtp-Source: AGHT+IEtt/pIK1WIPwVGQ9SXq1VbD9Q8gG6yoTAhFI10CqjXq6u18HuGGeUSFm269n/4g6ehQz9EQQ==
X-Received: by 2002:a05:6512:3c87:b0:553:2927:985f with SMTP id 2adb3069b0e04-5550b860bafmr4259106e87.5.1751308562315;
        Mon, 30 Jun 2025 11:36:02 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([37.78.230.218])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b255a51sm1530793e87.88.2025.06.30.11.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 11:36:02 -0700 (PDT)
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Christoph Hellwig <hch@infradead.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konstantin Evtushenko <koevtushenko@yandex.com>,
	Sergey Bashirov <sergeybashirov@gmail.com>
Subject: [PATCH 1/4] pNFS: Fix uninited ptr deref in block/scsi layout
Date: Mon, 30 Jun 2025 21:35:26 +0300
Message-ID: <20250630183537.196479-2-sergeybashirov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630183537.196479-1-sergeybashirov@gmail.com>
References: <20250630183537.196479-1-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The error occurs on the third attempt to encode extents. When function
ext_tree_prepare_commit() reallocates a larger buffer to retry encoding
extents, the "layoutupdate_pages" page array is initialized only after the
retry loop. But ext_tree_free_commitdata() is called on every iteration
and tries to put pages in the array, thus dereferencing uninitialized
pointers.

An additional problem is that there is no limit on the maximum possible
buffer_size. When there are too many extents, the client may create a
layoutcommit that is larger than the maximum possible RPC size accepted
by the server.

During testing, we observed two typical scenarios. First, one memory page
for extents is enough when we work with small files, append data to the
end of the file, or preallocate extents before writing. But when we fill
a new large file without preallocating, the number of extents can be huge,
and counting the number of written extents in ext_tree_encode_commit()
does not help much. Since this number increases even more between
unlocking and locking of ext_tree, the reallocated buffer may not be
large enough again and again.

Co-developed-by: Konstantin Evtushenko <koevtushenko@yandex.com>
Signed-off-by: Konstantin Evtushenko <koevtushenko@yandex.com>
Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
---
 fs/nfs/blocklayout/extent_tree.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/blocklayout/extent_tree.c b/fs/nfs/blocklayout/extent_tree.c
index 8f7cff7a4293..0add0f329816 100644
--- a/fs/nfs/blocklayout/extent_tree.c
+++ b/fs/nfs/blocklayout/extent_tree.c
@@ -552,6 +552,15 @@ static int ext_tree_encode_commit(struct pnfs_block_layout *bl, __be32 *p,
 	return ret;
 }
 
+/**
+ * ext_tree_prepare_commit - encode extents that need to be committed
+ * @arg: layout commit data
+ *
+ * Return values:
+ *   %0: Success, all required extents are encoded
+ *   %-ENOSPC: Some extents are encoded, but not all, due to RPC size limit
+ *   %-ENOMEM: Out of memory, extents not encoded
+ */
 int
 ext_tree_prepare_commit(struct nfs4_layoutcommit_args *arg)
 {
@@ -568,12 +577,12 @@ ext_tree_prepare_commit(struct nfs4_layoutcommit_args *arg)
 	start_p = page_address(arg->layoutupdate_page);
 	arg->layoutupdate_pages = &arg->layoutupdate_page;
 
-retry:
-	ret = ext_tree_encode_commit(bl, start_p + 1, buffer_size, &count, &arg->lastbytewritten);
+	ret = ext_tree_encode_commit(bl, start_p + 1, buffer_size,
+			&count, &arg->lastbytewritten);
 	if (unlikely(ret)) {
 		ext_tree_free_commitdata(arg, buffer_size);
 
-		buffer_size = ext_tree_layoutupdate_size(bl, count);
+		buffer_size = NFS_SERVER(arg->inode)->wsize;
 		count = 0;
 
 		arg->layoutupdate_pages =
@@ -588,7 +597,8 @@ ext_tree_prepare_commit(struct nfs4_layoutcommit_args *arg)
 			return -ENOMEM;
 		}
 
-		goto retry;
+		ret = ext_tree_encode_commit(bl, start_p + 1, buffer_size,
+				&count, &arg->lastbytewritten);
 	}
 
 	*start_p = cpu_to_be32(count);
@@ -608,7 +618,7 @@ ext_tree_prepare_commit(struct nfs4_layoutcommit_args *arg)
 	}
 
 	dprintk("%s found %zu ranges\n", __func__, count);
-	return 0;
+	return ret;
 }
 
 void
-- 
2.43.0


