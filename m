Return-Path: <linux-nfs+bounces-7418-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F849AE02E
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2024 11:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18FB81F2246D
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2024 09:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BE8A932;
	Thu, 24 Oct 2024 09:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XycQ29jg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6438F2FC52
	for <linux-nfs@vger.kernel.org>; Thu, 24 Oct 2024 09:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729761060; cv=none; b=R7ce9CyIh0PTMWcpUKZd7HgfdPHXrzmP4Z9DzCxXHMcjIcZagtPrJ71rhP98yKwfO0RJkKf27Ec+IFjadz7sO+OQaxGRn1pdQMvi2UUDFQAjLitu29P1A6Fg7Z/8cddGOhIYKsON6afum7CGIOEh3XwmppKT2S0Xpqt5iuXRZLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729761060; c=relaxed/simple;
	bh=yoISy5pJw4AkUUHEee/hsUSJRdzTnTI5exf/9k+RCIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GOymCPWd0YkRXXtWECZz/hpP2RgLPRGWt+YmS//QfegAHZXyxRq+dyU9y1/wrjWPwmGP7mccLG0SNx03nHVBtWmrvyv6AfVn8B4FH+IKZ1XVC0tSv0qqubar0uN766eOK+rXlMzB2pqnTqEWc3CTKPE76Sia2aqGzlYK3GhSnFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XycQ29jg; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d473c4bb6so570304f8f.3
        for <linux-nfs@vger.kernel.org>; Thu, 24 Oct 2024 02:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729761057; x=1730365857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GQ9UyqcCDmi+CcOQ6MGLv7xss48XavSSseBIklCKGmY=;
        b=XycQ29jgQDHxBHNtUmYuFk9uyinLQRsOx9JzaUeAtbUxi9gthOWI58zRAMIoNAb8Rg
         7Hq/bKjCdSOgD6x1FnXmCLUJGslZ4p573hC+boY8cY3RGZe9z8/IFgFFDh77R7y4DjKR
         SmakaFjjrEqp0FluBpDOtp+9tvGDcornw2TWp4A3Uoz5toipTMDpDH9urhk5QTwvfHly
         qNkCPJSuNbBoB6crWoZzKeT/fnTOIReWFttXvxkNGVrlhxhNmPHnpRWm1BcYKbVz8AHv
         /5d3qG0Ncbzd6JqAx5kNKUxB2jZvWBu8qWeJvwuA2VubQgzeJt1zTiXjDnvDu/m6nrlm
         ue0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729761057; x=1730365857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GQ9UyqcCDmi+CcOQ6MGLv7xss48XavSSseBIklCKGmY=;
        b=mZZsdNwzqJk18+OaV7m8XIiUBLsxP6UvjRIid76ZOJDjeGOVIPOLx6o7hl3+Pr9wOj
         oImy/Gku/zh/3LI/Y9GA4JzkPrINXwTsNqfJd8jFII0JIsQ02BhbZ6uhYJYrCcn3DqD4
         +fYVi4gMq+HT/wrpBrGMhIDyt9yVzK8YtRQdHfRB8RHGopPgY6IpKP20rtc+ksBE5AM1
         EuepFWRM973dJBYLP59o6lvv0wHi8Zcg2ssv5dAEN3t05xItia0YkYrJbtsMgxxV/RF1
         RZqqytuLTnUZuAdAoMvLsWXWVsZhmElFwX1HVJ1Pa2ATqTFF4yN9T5CQUx66QdCl1vKw
         JRWQ==
X-Gm-Message-State: AOJu0Yxfo7E00IsglloWSuMBPY1OESgn2735QGbNn/TaMGUxaWvsESGd
	mAP7TI3ByKSUGROZj3EY9mTgZTVAlLKD0Cpm3cwNXsBAsNwldgPtORQS4pmDq7s=
X-Google-Smtp-Source: AGHT+IGtL6/xLi7IAeVXI1Li+X9EbhdURTBBnYjz57WKUk4um8QKAvH1eWq9Bte/VEsD0ZL4ohU3FQ==
X-Received: by 2002:a5d:680a:0:b0:37d:4f69:c9b with SMTP id ffacd0b85a97d-37efcf33a99mr4219955f8f.35.1729761056554;
        Thu, 24 Oct 2024 02:10:56 -0700 (PDT)
Received: from localhost.asia ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e76df50b0fsm2994821a91.18.2024.10.24.02.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:10:55 -0700 (PDT)
From: Yong Sun <yosun@suse.com>
To: calum.mackay@oracle.com
Cc: linux-nfs@vger.kernel.org,
	Yong Sun <yosun@suse.com>
Subject: [PATCH] Adjust COMP5 for RFC8276 addition of XATTR ops
Date: Thu, 24 Oct 2024 17:10:41 +0800
Message-ID: <20241024091041.30811-1-yosun@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The COMP5 test needs to be updated for RFC-8276.
This RFC added some new legal opcodes for NFSv4.2 - number 72,73,74,75.
So the '72' should be changed to '76'.
---
 nfs4.1/server41tests/st_compound.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nfs4.1/server41tests/st_compound.py b/nfs4.1/server41tests/st_compound.py
index fdf73b6..d6bc486 100644
--- a/nfs4.1/server41tests/st_compound.py
+++ b/nfs4.1/server41tests/st_compound.py
@@ -111,7 +111,7 @@ def testUndefined(t, env):
             except:
                 # If it fails, try to just pack the opcode with void args
                 self.pack_uint32_t(data.argop)
-    for i in [0, 1, 2, 72, OP_ILLEGAL]:
+    for i in [0, 1, 2, OP_REMOVEXATTR+1, OP_ILLEGAL]:
         a = nfs_argop4(argop = i)
         try:
             res = c.compound([a], packer=CustomPacker)
-- 
2.43.0


