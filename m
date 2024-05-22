Return-Path: <linux-nfs+bounces-3329-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E2A8CBC44
	for <lists+linux-nfs@lfdr.de>; Wed, 22 May 2024 09:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B65B21C2135B
	for <lists+linux-nfs@lfdr.de>; Wed, 22 May 2024 07:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACC5770E6;
	Wed, 22 May 2024 07:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SglWi2qJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D554B58AD0;
	Wed, 22 May 2024 07:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716363950; cv=none; b=Kxr3HT/yBsI3Z9hzpsA732ccJlRWGBvBTp7yDBtPM17xrOmszgFfelxRs5OcXW4icqAIaUX3m3paEyoJ0jVGrcDA295cJe7rY207CohB0hTawBCatr4/PJN44tvHXHpS1YcIs+Hnr2a4e66m2LYPLIPC/Y5ZwDZCQvfHNQk6Y7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716363950; c=relaxed/simple;
	bh=Iqr3TUTNHyaZn9ybfzHOiVCGCqojYHa2thw0eGxhUn8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZSIm3lfvmGFcNKkkS8nFoYjHbr2e+CpP2YukxQd/TYEHCwZbY47i70GlZj7QaI7vjMhnT8RZI3bsAuz5oURHt60DPD2wLrpgzxtQC1+332hAUBWEyVtlweJSs2Q5NSgeYlbJUcjWWn1KVClxtXFhCmcuD0OmvX+Q8vcNvA5VkJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SglWi2qJ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4202dd90dcfso4861475e9.0;
        Wed, 22 May 2024 00:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716363947; x=1716968747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JSjY0LzqeczP0/PtbwWHsWsWQHqbRXxXXTo7cQU5k6s=;
        b=SglWi2qJfZ/YEb8qbJtR5yGfL2kaCe82EY9AVgLbswEmf6u0+7LVvDKB/bIoqpy4lG
         pfSdVqWqwgtU7QxFfm9RhHl4Vb1iIVZcDi4MGzkmYAulcG2w9XBuh+tQ+mirUGKwM3jQ
         oZeuK3b2GbnEko33ahr+GH8G+dhQkLQsik3zDUr8FeHPOtlsc1pLkT6FN8uXHhWo99cy
         H8oEqWvN5nAeLtEeo0dtNdXJ6jtFFtG+Tp64hS7xxs23v7lkWJoBeRj7sS7TV9MeQt9F
         1wUBeRgHHLrBj+K5MxBdrZTBJn5jqm0BSzVHIS72XrkXsGNEybFxVXn44sElvpngxx2k
         /JmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716363947; x=1716968747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JSjY0LzqeczP0/PtbwWHsWsWQHqbRXxXXTo7cQU5k6s=;
        b=CjD7kZOp8D6ddN+k+AHOYARTbbByNCGjLl45ZJWnCeZfL0n9nBd7d/n51sTspsjXzk
         6ata7ZZsDMRGXBwUCmW1xtJPw/eZdTaOnQtBF70bHrOAZYEOGHCssQ8bF5P+WUxb1W8n
         Whc74CQOJQpGagZwRcG/4wqJaUrMOgl3SwGMBAejeb0Fqt18XiIjoCAV1XT/ezYVyxwa
         F3nqsM0Qv+3e6KMpMW2AK75Hkw7Z63gkk1fEiIuYWUDHBXuHGMmYke4noNz5JXTd/Dz9
         dn7YVUdQI4sGfAWIgpX77XT80wnbFV6N0IQvMQeKlHlLQKjE8CGDYPuYGwgq3QejVex4
         fzDw==
X-Forwarded-Encrypted: i=1; AJvYcCXWer1JnuFAz29p+Jl29pax0xlpl7f5qlXX3he/S1SRKp4N7uIpBK4T0xfbHSVAbW+WSLbTiSWH7fm4+Hyc0hjok8vWDZOpiENo2w7tlUCCHyfkMDyUdqaYOztO21r3UNXtvmvfhKv3
X-Gm-Message-State: AOJu0YwuYXQEW9nPRtVu0joPbdGgHUxoYyQKXgbB0+dXM+lKQEZcsbtG
	8DnA934hCd2pMoWwZDKmopRkzD7NpiYX3IWFjZZ6HujCBZafKAsm
X-Google-Smtp-Source: AGHT+IExMHTEZt/9I4TO9K/fLc86GF/7l8joCmnEFxBxj6OicukLK+/E733KQodYvXcSDOvAMH5aMA==
X-Received: by 2002:a05:600c:3645:b0:420:1375:95ae with SMTP id 5b1f17b1804b1-420fd3261abmr8686055e9.24.1716363947019;
        Wed, 22 May 2024 00:45:47 -0700 (PDT)
Received: from localhost.localdomain ([195.16.41.104])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41ff7a840d2sm451036835e9.39.2024.05.22.00.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 00:45:46 -0700 (PDT)
From: Dmitry Mastykin <mastichi@gmail.com>
To: trond.myklebust@hammerspace.com,
	anna@kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Dmitry Mastykin <mastichi@gmail.com>
Subject: [PATCH] NFSv4: Fix memory leak in nfs4_set_security_label
Date: Wed, 22 May 2024 10:45:24 +0300
Message-Id: <20240522074524.23046-1-mastichi@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We leak nfs_fattr and nfs4_label every time we set a security xattr.

Signed-off-by: Dmitry Mastykin <mastichi@gmail.com>
---
 fs/nfs/nfs4proc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index ea390db94b62..d400093a2fff 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6268,6 +6268,7 @@ nfs4_set_security_label(struct inode *inode, const void *buf, size_t buflen)
 	if (status == 0)
 		nfs_setsecurity(inode, fattr);
 
+	nfs_free_fattr(fattr);
 	return status;
 }
 #endif	/* CONFIG_NFS_V4_SECURITY_LABEL */
-- 
2.30.2


