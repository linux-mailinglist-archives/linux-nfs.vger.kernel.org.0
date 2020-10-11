Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE77028A9A3
	for <lists+linux-nfs@lfdr.de>; Sun, 11 Oct 2020 21:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgJKT3B (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 11 Oct 2020 15:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgJKT3B (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 11 Oct 2020 15:29:01 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6DCC0613CE
        for <linux-nfs@vger.kernel.org>; Sun, 11 Oct 2020 12:29:00 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q5so15319338wmq.0
        for <linux-nfs@vger.kernel.org>; Sun, 11 Oct 2020 12:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=mvbCxLSyqg74xTUGGfIStKKPXnplqL4PTKI5IyyVc5A=;
        b=BfGyC73nD0H5abCAvwk6Z6ISSLg1yaU1rZFpVz8z6v9HlKgunW2ZUDNg4VQvtFQGpg
         crsGVb1svJ02mHtp4ZnNiZSOy/WrljiwTVgZ9K9AIzHYwQ2SU6PmPOSQfoDYjRVr17mh
         lGRY5Ra1VacNmAr115z77eNKOTbaMRs9xQ/qwsS+l9t9UFc1Uf4PDCna7iJ0FYcnqOzW
         fvKmSfExAmUf/me5TJ4YQLnuDKx4ooekYZu/u6Wux/ghgb4SVy8aUqFJCKheoU5JBH9N
         /iX1ZQWmHsePT6CbKnHiMXR4I18ohLzSwYwvkSlh1GMuYAh4R/LEJRWX1D2e1VP23JKk
         0dlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=mvbCxLSyqg74xTUGGfIStKKPXnplqL4PTKI5IyyVc5A=;
        b=kFcqux5R0nsIaewAzLlj7j6wnpQaCjlH5gycuYTKvd9Sr34zrO3An2WK4rqc2X63jk
         cgQCinH2VBixQfy8kXsbyQ02yPeXIHO8JpDo8wWtQidu01fb6g0dRgwikdaw1f779IKp
         1fi8GgJ0mSsibaesMduCKh/oCdU7+0+dY8t6njLlISCcl+pnVSQW5EawNmc0rwZBJSXB
         albUQ9kB4yU1f3rkS+Sdyj2SyKhj/jmspOdvZR3ZEZn5rro89PWaO2awmvmaCnnU5PVp
         hMYQeSA8VmtRPwnPP4eToP5oJWeGMfIzz2eGpX0IB/QlcABXnkO5cUgcjfpfEdvLQEkc
         PeGg==
X-Gm-Message-State: AOAM533SRzxbHZjBMwG9TH/1H2JE4LjiEde89v3/acon06z0ljV/eGBl
        7WK590eTIzjuMyz5WE0MT/MyWbMAq/ve8g==
X-Google-Smtp-Source: ABdhPJzg9E3D+c+z5tjWAlWwEk0GerEa2pOrx4UQhz+np4Rd8QsOLZYR7v66oO3f9QPFULzeHJrboA==
X-Received: by 2002:a1c:3285:: with SMTP id y127mr8092115wmy.183.1602444539116;
        Sun, 11 Oct 2020 12:28:59 -0700 (PDT)
Received: from [192.168.50.190] ([194.158.213.176])
        by smtp.gmail.com with ESMTPSA id q10sm22012961wrp.83.2020.10.11.12.28.57
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Oct 2020 12:28:58 -0700 (PDT)
From:   Artur Molchanov <arturmolchanov@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: [PATCH] net/sunrpc: Fix return value for sysctl sunrpc.transports
Message-Id: <635CFB46-6C1B-4C7A-9BD6-7B26E6AD022F@gmail.com>
Date:   Sun, 11 Oct 2020 22:28:57 +0300
To:     linux-nfs@vger.kernel.org
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Fix returning value for sysctl sunrpc.transports.

Without this fix sysctl returns random garbage for this sysctl key.

Signed-off-by: Artur Molchanov <arturmolchanov@gmail.com>
Cc: stable@vger.kernel.org
---
 net/sunrpc/sysctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/sysctl.c b/net/sunrpc/sysctl.c
index 999eee1ed61c..1edcecef23dc 100644
--- a/net/sunrpc/sysctl.c
+++ b/net/sunrpc/sysctl.c
@@ -70,7 +70,8 @@ static int proc_do_xprt(struct ctl_table *table, int write,
 		return 0;
 	}
 	len = svc_print_xprts(tmpbuf, sizeof(tmpbuf));
-	return memory_read_from_buffer(buffer, *lenp, ppos, tmpbuf, len);
+	*lenp = memory_read_from_buffer(buffer, *lenp, ppos, tmpbuf, len);
+	return 0;
 }
 
 static int
-- 
2.20.1


