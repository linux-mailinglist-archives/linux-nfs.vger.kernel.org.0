Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2A9514FFE0
	for <lists+linux-nfs@lfdr.de>; Sun,  2 Feb 2020 23:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgBBW4M (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 2 Feb 2020 17:56:12 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:39193 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgBBW4M (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 2 Feb 2020 17:56:12 -0500
Received: by mail-yw1-f67.google.com with SMTP id h126so11955263ywc.6
        for <linux-nfs@vger.kernel.org>; Sun, 02 Feb 2020 14:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sbpll5m/D2jqhS1yNNOSxZ189BRV9Du6vR6MiDbVdEg=;
        b=qri7e740zzgZdFTplW+u/98OCbz+VhxrxPJEAloQXSOjPSurjFgo9A6/TL5i266n1J
         zKhAUsBxlbCqTNtvCCT0nfk6CX9/d7p89ImE//+q6Nf7ht+Y3vJgzSagh5SOwVBiz/ws
         QKLV9ktFf1mH4Z81cPnsGta2t7eAqivLWuT9pyxmDDzoZivR+Y2goZ4U4pasT0W1spzU
         hkFr7nOlUxS/qErcWgJQputOvZcnqcA+YCd6T5yYsdpn9pd4qS/QrWT6hnLGFRP3h5iJ
         UOdZallwz9mzcxpTxL6zljvHwV19YJeNipY/Z2j13hAKASiJMg2dZNnLtJYu4+aWf4Nc
         pmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sbpll5m/D2jqhS1yNNOSxZ189BRV9Du6vR6MiDbVdEg=;
        b=CnuQ1ML9VCTpQIv7D5poEfBBpYIoDJhRqqNxG4GuNqOnV6XX2UFE7ZVY6+dYBhLKnp
         PZE3vECTPTVcuJv6YSRDqzjrv6Bf5yIJfvM/62+zdikMAt2oXhaZ/aPlCHd9TcDWXRk+
         nYXImjPFM4ImuCiWNS9z2dq9ltfA2KTT+PLjC4wAWWPitOfQdoNdNNWKxXFDKLcGfa+f
         FWRB14w2+6jn5nNEpH6rEdzV+SzoXHQ/LPMRaoxHCji93+Szk3Wx88RQPNbT6sWSycku
         6LJYBTdL8WWGJD8AgD47cSV0B7h+n8Ot9Qw5uAs1cRCQjF211mvPBkoHI0lpKnG066ub
         K9Bg==
X-Gm-Message-State: APjAAAVbREu7x19A8mNa8A6+wCanNxttxJKGVUxnaYjlm1MrjruUJTe8
        jPOUJxhQtByIJfRU83bhWw==
X-Google-Smtp-Source: APXvYqx784TAzbPMYolCx+Uaikhj4pzD/QrIyB7z80ES0utc6PL2m7u8USl8q9jY9++jOZXUmC3DbQ==
X-Received: by 2002:a25:664e:: with SMTP id z14mr16706236ybm.75.1580684171200;
        Sun, 02 Feb 2020 14:56:11 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id u136sm7185529ywf.101.2020.02.02.14.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 14:56:10 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     Benjamin Coddington <bcodding@redhat.com>,
        Dai Ngo <dai.ngo@oracle.com>, linux-nfs@vger.kernel.org
Subject: [PATCH 4/4] NFS: Switch readdir to using iterate_shared()
Date:   Sun,  2 Feb 2020 17:53:56 -0500
Message-Id: <20200202225356.995080-5-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200202225356.995080-4-trond.myklebust@hammerspace.com>
References: <20200202225356.995080-1-trond.myklebust@hammerspace.com>
 <20200202225356.995080-2-trond.myklebust@hammerspace.com>
 <20200202225356.995080-3-trond.myklebust@hammerspace.com>
 <20200202225356.995080-4-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Now that the page cache locking is repaired, we should be able to
switch to using iterate_shared() for improved concurrency when
doing readdir().

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 60387dec9032..803e6fec0266 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -58,7 +58,7 @@ static void nfs_readdir_clear_array(struct page*);
 const struct file_operations nfs_dir_operations = {
 	.llseek		= nfs_llseek_dir,
 	.read		= generic_read_dir,
-	.iterate	= nfs_readdir,
+	.iterate_shared	= nfs_readdir,
 	.open		= nfs_opendir,
 	.release	= nfs_closedir,
 	.fsync		= nfs_fsync_dir,
-- 
2.24.1

