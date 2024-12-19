Return-Path: <linux-nfs+bounces-8671-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B2B9F83D5
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Dec 2024 20:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBBD61884AF0
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Dec 2024 19:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C150919E826;
	Thu, 19 Dec 2024 19:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8LWo69z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5564E194C96
	for <linux-nfs@vger.kernel.org>; Thu, 19 Dec 2024 19:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734635539; cv=none; b=YRL+tXRh1qrB7GcRRaueYItZA/J4EOaNA7rsKw8DXweH8vFuKuXUeSgmycIZE54DrIMjmeFhK0hlmEk6dSPNz2XKmF4bqLyR4FGq6f65R4SXk9wemBRemXBZyZ4Y8uvT0NzeJLsKiQQIyhDFyNwV5OUj3INVDDFVMeBnOYwvXy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734635539; c=relaxed/simple;
	bh=yNV3GR+GWpsJAm/cnQlZo4JMyDkznhXPKlJcti0ZM2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eb0QnqHnBbgOsSNVZuilmxAP341rVGS4IApJ/f/RnElIfQGUZbAbwU6ZdlEmtSyUyUWUEYIR2GGArZFhKRt/19ht95OAX8oFR0OxvMTzLJ8p9QAf8mOi4rnvwr08a7Gmi5OJDKfYMAyFu7SLukJovkB2cE/Si3sdW92SZS19HFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8LWo69z; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-728e729562fso1106653b3a.0
        for <linux-nfs@vger.kernel.org>; Thu, 19 Dec 2024 11:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734635537; x=1735240337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lZV1bbUyOjVIFcrPuk5hLAqIogSx0yetOtgC9jDqaZ4=;
        b=c8LWo69zUzOaYQBVZ0FpuH8CxigKfBAFI6I+kPS5SwIKiivT2Ame0RCw2x380XPE1z
         KaQgKN9vsL70iMpfWLmVk4OFWWNQ7n75tNUgNJOZleamxa6RvivNWPyZmhIknSPCpaJ1
         bLGiZFjEBr6k4Wzs/VB+vrHa/DlpTatpsYPv8rcYllIQBHxqnZ4CPCZgA9K5giEl2h81
         MoswapTfAk/Sw9Rp77dWpxFaH+9y2ihLBCxCp5Vnzt0w6mp0lee/DBU79QnwgMxvoLFK
         1lxT7uF7VoTwiPgcHPO0MDfkFfIBtHbSelrpIgtuSuxPrZyzzIBIXz2gYWY7KAbo0fO7
         uR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734635537; x=1735240337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lZV1bbUyOjVIFcrPuk5hLAqIogSx0yetOtgC9jDqaZ4=;
        b=nm1UHmNkRsrrjlo7j6Bk/MZaEVsB3PqkihbyxzmnqskNZyH8TgAsLphQupol2ro+SP
         NfUJvsTOmM+5baoJNOzMHcw2A2KppKzfk35CVH/U5A5eBrOCvqAAoPwAmIgU6kJM0o8C
         dXuD5nujViWd2upowfyn7kd2Evg31en3wI0HjuQiJqf0sM/0HGVExyT6ihspzM1ATgxo
         ELjGV5cJ9vjzF28r79woaliRwdMVdeVOjG9gGcfR+Q5vEvwB/J1k+/le2sCEYA0vwQw3
         opTdZ4HTdu+rtA7NgZJCXLHwch48zP5qIpxiiFJfURyqxd1ZgataHHXyUnVrWu8x7qyS
         MCog==
X-Gm-Message-State: AOJu0Yxa+BLIBE9TzKKZ77/b2aijiLRSyc6pRkngG7NmwscLQBAS90+z
	guzcrXTNOQiefqyV/K/wWkd89NDsVpJ/a8olOxjUXxKja6pJWuEBu1Mvm3b+
X-Gm-Gg: ASbGncv4NCnGGWvPO17HRl4qV+f8aNa14fPdKwH+jSRpuxqW9/RGncGaq4caW/lM2Fa
	bRMP64EMm6gxEMazehMoPoTg4FOq6V4t+DWf1Tbawk2kh2KB0MyjQpMTljrVApw3COKYP8T/259
	4ScO4xVf7nk0ZVkwCPIEKMyulg4c8wECfC+aQc1bsl/DTr+UDSU2+m1MGbOfdxOaEelSLUSEECL
	XBmu2rTrNnAcHNUTdMeXlLvBG5VvPRNLRWlkkU1cQC4fRCWYGl4cPXaj8E=
X-Google-Smtp-Source: AGHT+IHBSsmFJ7EdDRd/NenyngT7rT+KwXsIzE0ZjQPjYJyg7YvEwKKMnJUveGyUsMbeIiIl51wOLw==
X-Received: by 2002:a05:6a21:33a4:b0:1e4:80a9:b8fa with SMTP id adf61e73a8af0-1e5e0461547mr406188637.13.1734635537267;
        Thu, 19 Dec 2024 11:12:17 -0800 (PST)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:8201:fd20::5df3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad6cc885sm1682370b3a.0.2024.12.19.11.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 11:12:16 -0800 (PST)
From: Khem Raj <raj.khem@gmail.com>
To: linux-nfs@vger.kernel.org
Cc: Khem Raj <raj.khem@gmail.com>,
	Benjamin Coddington <bcodding@redhat.com>,
	Steve Dickson <steved@redhat.com>
Subject: [PATCH v2] Fix typecast warning with clang
Date: Thu, 19 Dec 2024 11:12:12 -0800
Message-ID: <20241219191212.530007-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes
file.c:200:8: error: assigning to 'char *' from 'const char *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]

Signed-off-by: Khem Raj <raj.khem@gmail.com>
Cc: Benjamin Coddington <bcodding@redhat.com>
Cc: Steve Dickson <steved@redhat.com>
---
v2: Make base as const char pointer insread of trying type punning

 support/nsm/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/support/nsm/file.c b/support/nsm/file.c
index de122b0f..68f99bf0 100644
--- a/support/nsm/file.c
+++ b/support/nsm/file.c
@@ -184,7 +184,8 @@ static char *
 nsm_make_temp_pathname(const char *pathname)
 {
 	size_t size;
-	char *path, *base;
+	char *path;
+	const char *base;
 	int len;
 
 	size = strlen(pathname) + sizeof(".new") + 1;

