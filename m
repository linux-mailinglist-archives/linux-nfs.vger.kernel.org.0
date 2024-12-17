Return-Path: <linux-nfs+bounces-8627-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F2C9F4FA9
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Dec 2024 16:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04C287A05DE
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Dec 2024 15:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AB01F4E4A;
	Tue, 17 Dec 2024 15:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+AO/L4z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A811F4705
	for <linux-nfs@vger.kernel.org>; Tue, 17 Dec 2024 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734450037; cv=none; b=bPfKOKfuI7xhok0+5qYdFU7bvS/K8rvCBOdnHS77l0z5CqXcbIiMWJyTBHeZNDxr0WOtyt8p8WOYIW09zrZ+e5EX1LfW5Pf/cdSP2MI4L/vFPUBSh7WGXqJNa8jYeaf7O+y67WoPTmgNSTEtgojdzcfh2RZvfEOFf6K0k0BCvjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734450037; c=relaxed/simple;
	bh=fULVYAHdRm7ygFtSMjsoaisV+RroR0R0F/bor7V4wi4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kKokxcamMkOlkwubwzJWng2/YxkT3hoPkVZBUuOF6JItp6qU/rXkH4MbEDP6rDZD2hESTMDwcRWJwRVVplk6yFhv4jem+Dp+XyAbP/FZU3DXOjEa3gC6Sq+CoHEBW5oT0fTpxkhV77v/J9WRzb9fTdVw8bdlsOCJyUSCStOBd5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+AO/L4z; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7273967f2f0so5864787b3a.1
        for <linux-nfs@vger.kernel.org>; Tue, 17 Dec 2024 07:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734450035; x=1735054835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=u2ny11zzNQZXRQARDhl//+4XGgz5eIyl7gckhaJNIp0=;
        b=i+AO/L4zBfrPHqVYfWRRbeuWNlLgZ+QAZ5GQxAcLPgVM6He/3AtIdXJ9Levp3s8sqC
         seXqJTTsej3YUaGfs+lVZwqkGZ1abFrXvTeIWMZAlfB+rxnl+FiDQifzyiz5RQr9f/LW
         Ct58UvFmNvleMQMg6v71GGDJlfwUjcEn8pX1rplfvj59iQy6XqVM6MEyb81RJoHX9sR6
         1u+eJvgWOiykSTIdO6K2n/0FtpsN6NkT+3Nz6i+CGnbzgT4pr92o7xrpI75KF98Gi+/z
         PjRukKX5un/TTi5M32i1RdnATQlBf05XWFgmkHMUSfbPdG65xMoh58pEp4NXdjYhg8ko
         2ZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734450035; x=1735054835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u2ny11zzNQZXRQARDhl//+4XGgz5eIyl7gckhaJNIp0=;
        b=XTzbfGDx9djW5h1nmp97DPy4U1i03YrRNEu36XQ8eQ4fNn6NFmA5gtURa15YiL3Gaa
         AjYXkKH5YtucJAJlHUYchMBsq2rPB2y3qOVZZRsmyoMXCDC2xwZIR9AD5OIyM0kyDrL3
         8i6zoJ95wWzE5p1FhByuQP2U9JknghGVAONf/hfjyzUFQVJJbY/xTeSkN6ohnepK8uZb
         2aOaT3k9//QWOf/PWLjJjTEccmjSVVMevigxuMHyNruqsOl0yczsSWI2tp+7F5MKnqBu
         v8mwlzL4MqCmacvncOsJcysmhuReVc3QLUc+VQxXoLQXE5kvvh4qzbcAUrK/8Y1AGeba
         dGfA==
X-Gm-Message-State: AOJu0Yyv/1SljRmmEsmFJmmkEoH6dNJxslKgHb8HPyG+BLFNpuBAiS0c
	4EYtlVQuKh+/phX+eUHV+OXws1H1jp02pLA9lx0OAUUppRQ57/VayKsK
X-Gm-Gg: ASbGnctbO+B9EkbwVioacd55m/7EsAnqYvLsEGa1mlmTLWn3dSwXGxLWJUWtMQHHVbX
	fQSEQTXy/wqUXtSUL9wygEsJIvGUyZh6ln8AMQDerW1bHgNhttFv1IyzqL2u+/9vhFi1dfH+laG
	QV+KHUEvsXfwLD3KF8/FwxtXFMLrWiprlHtFIewxOBP4J85ucsqjL9//DHWDfdXugonAABulOLI
	xZJ1wieOtjKSfSVroN+IHMxGcR0Y1ieaSQ86Z1qs8pDbG5EjV5eG2cWHzToSdBQxCzvM6TAt2nS
	noFrh2La5YoAxRCnfYUt/VUJ9ZvG0QC9tIW35YV82N8jjbkJvEhjwZ/TJ4Q5u9wW9qoT2eW4UOQ
	WqQZLbRQ=
X-Google-Smtp-Source: AGHT+IHbabR5BOAyf31jICdVKAesKcXXKiICnvptTng2qVBu7CcDXzbxZ6j4JQeB1RHDdQ+9hj5EDw==
X-Received: by 2002:a05:6a00:8015:b0:725:e015:908d with SMTP id d2e1a72fcca58-7290c0ee458mr21755073b3a.1.1734450034942;
        Tue, 17 Dec 2024 07:40:34 -0800 (PST)
Received: from leira.trondhjem.org.localdomain (104-63-89-173.lightspeed.livnmi.sbcglobal.net. [104.63.89.173])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ac5280sm6789036b3a.35.2024.12.17.07.40.34
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 07:40:34 -0800 (PST)
From: trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To: linux-nfs@vger.kernel.org
Subject: [PATCH] NFS/pnfs: Fix a live lock between recalled layouts and layoutget
Date: Tue, 17 Dec 2024 10:40:32 -0500
Message-ID: <0688a7b30bfe847ccab1feca8dde7617036e7ca8.1734439172.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When the server is recalling a layout, we should ignore the count of
outstanding layoutget calls, since the server is expected to return
either NFS4ERR_RECALLCONFLICT or NFS4ERR_RETURNCONFLICT for as long as
the recall is outstanding.
Currently, we may end up livelocking, causing the layout to eventually
be forcibly revoked.

Fixes: bf0291dd2267 ("pNFS: Ensure LAYOUTGET and LAYOUTRETURN are properly serialised")
Cc: stable@vger.kernel.org
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 0d16b383a452..5f582713bf05 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1308,7 +1308,7 @@ pnfs_prepare_layoutreturn(struct pnfs_layout_hdr *lo,
 		enum pnfs_iomode *iomode)
 {
 	/* Serialise LAYOUTGET/LAYOUTRETURN */
-	if (atomic_read(&lo->plh_outstanding) != 0)
+	if (atomic_read(&lo->plh_outstanding) != 0 && lo->plh_return_seq == 0)
 		return false;
 	if (test_and_set_bit(NFS_LAYOUT_RETURN_LOCK, &lo->plh_flags))
 		return false;
-- 
2.47.1


