Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E220918B9
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Aug 2019 20:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfHRSVT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 18 Aug 2019 14:21:19 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43547 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfHRSVT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 18 Aug 2019 14:21:19 -0400
Received: by mail-io1-f66.google.com with SMTP id 18so16106847ioe.10
        for <linux-nfs@vger.kernel.org>; Sun, 18 Aug 2019 11:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0lUkdpLwnsPV2033Gelot7S3NczTnw9f1lWg30kTGWo=;
        b=jcYnl7mJW+EHxP07sQUMPeJmeZPcW4I2sySmBkAE4kfgj/VYkrT8bAmlzdJtn5gImW
         1K8IHQObOgc21B4hT/n3YOJAbVFx76A++6rWWVBAHtY3EbHgUFjSRDWFZDHBh//Lm9vQ
         TC6kkNajjAgEKEMXKRS1pbt1wTK0gz7wj5gho844SPfTG0CFRfraHpLTBh6NfBbBDPBb
         skSNV2K3av3vuiSKoybsYUlHvXR07i73tISXLNk+thtCDve66hdhsQhGlOj2aAxdQTCN
         F5fhGGHeDqdOROqfRgWzelgA6zOhRKg67ATyWepDbcHdPVMAIYpqbmzap6s9mYJFln8W
         Dtsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0lUkdpLwnsPV2033Gelot7S3NczTnw9f1lWg30kTGWo=;
        b=FEvk5Y5gOix9L0E+6aS5Qf6D2o9lTQWLTiY91QviTShnrEX5ChCxZ7WTcUsmQkLe4v
         d1rGzIygWTTfLH4kggytZ5Ic4c1u3AoAp3nw4kkYclgImiHQq5vXZQ7JDv4spFhrXH2N
         1y7dw+GyJ031D+AUn4VLjv8f0wF4a8WqaMeTBJnSrKKJajGepTTxzEaXZBUYvif57OLp
         nT0Gg4SFdbmgZzQ7gztIzmk9TvkeLS6ZQ6qhJdkkAw8fuS0MBK51ns/kg8U0MjXgZdAp
         hRTqpWWy+qOfYAHnavp9sPpEOFmqAsq3sA01aIbzIdSLFvf1ufyeEY/H5WYRy+Aln5UF
         it7w==
X-Gm-Message-State: APjAAAWE7d8yBOpuhW4d5s8gK9NABiFUOyKOK5IWD8+24IHbfwyfuPlu
        N+88zcap7BjYVdnsZOr+vw==
X-Google-Smtp-Source: APXvYqx2u5YgQxFMWokaawvsGxB5tTRGL1iGrlNC1XStMyro/a0Zc6uP9yuNFRoS1yjJpNMaDvVlrg==
X-Received: by 2002:a05:6602:2289:: with SMTP id d9mr22070752iod.47.1566152478062;
        Sun, 18 Aug 2019 11:21:18 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id n22sm10317844iob.37.2019.08.18.11.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 11:21:17 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 04/16] vfs: Export flush_delayed_fput for use by knfsd.
Date:   Sun, 18 Aug 2019 14:18:47 -0400
Message-Id: <20190818181859.8458-5-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190818181859.8458-4-trond.myklebust@hammerspace.com>
References: <20190818181859.8458-1-trond.myklebust@hammerspace.com>
 <20190818181859.8458-2-trond.myklebust@hammerspace.com>
 <20190818181859.8458-3-trond.myklebust@hammerspace.com>
 <20190818181859.8458-4-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@primarydata.com>

Allow knfsd to flush the delayed fput list so that it can ensure the
cached struct file is closed before it is unlinked.

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/file_table.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/file_table.c b/fs/file_table.c
index b07b53f24ff5..30d55c9a1744 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -327,6 +327,7 @@ void flush_delayed_fput(void)
 {
 	delayed_fput(NULL);
 }
+EXPORT_SYMBOL_GPL(flush_delayed_fput);
 
 static DECLARE_DELAYED_WORK(delayed_fput_work, delayed_fput);
 
-- 
2.21.0

