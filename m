Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A58B15B3BD
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2020 23:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbgBLWcP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Feb 2020 17:32:15 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:46105 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbgBLWcO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Feb 2020 17:32:14 -0500
Received: by mail-yb1-f193.google.com with SMTP id p129so1937166ybc.13
        for <linux-nfs@vger.kernel.org>; Wed, 12 Feb 2020 14:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LOJU83Pp3nAOHH0VfWoPfEIJ/pyNqj1eT0PlvmayaMM=;
        b=J7iiLrBslO6tYTl1uRa4kb05Zh2iR3A3Iwg65NEh2E+V4noyHokLaZE5b6ZJ9aN8nH
         qYuk2jhWb6BNITl+3CLnXfS0tlZeDGAW4qguZHW7uH4UAyhksU5dta7dW4QEWGvqTSXI
         yBJ+Vx+J9wQbJv2b+wDE3RpuExT6/n+5rSI2O8Oo98Lkk7/42MxkQgS3KEJQKSMUSYV7
         qMg5k9DbcvcOhXFCXPyKvfQOqo9HMx9TjZPWbM5UNDmYX6I6bjtatlLXJZdPbuOmmLvJ
         5QpXJM2SA/Jhi/cz9su04dNYFuCo4KLYfKubVBap9v/vP9JQdRLWT1STa5y6Ry7y7TeS
         h7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LOJU83Pp3nAOHH0VfWoPfEIJ/pyNqj1eT0PlvmayaMM=;
        b=WS/m8Rrr5E6R66HbF+yEhCv6X/+UfNpSWqkzS71YoWKyiUuW/AZu9Iqi8NcS1JPnVL
         cZsHAZ7KoH0ApQNX97PGFS22dCJpDOW9CaUF+hft7YIPjpJfN9XHzc0Jjm/wVFKdIoTE
         BeWBJm6V+WmyFcSGskxg9wbs+foMoqQXTEtTARlQO99EnNRnCkyMddwPW2PL0h7jEkF4
         yjcudJBy7MXyU2ui12G5hP3w52nGx/UbwVIzVwO0FWPrF+TiHB7vTj6UTI9TT6B1n47K
         ksJuYfTKatk5eDn92rZfHJNSvrW3FDTfld6d+dDxginm9rm/OfcVi5AQNJqu1vhYGEyf
         wwdA==
X-Gm-Message-State: APjAAAVTQ21/XcEO8GXi1ixVM6q6reCtXJ+k0h1Nl3KmJ72JMK7rJBkW
        UyFPTYtBC4Usaj0wzLnr6jU=
X-Google-Smtp-Source: APXvYqwkVH1lPXx8Uu0SflC6c4xUHRxH1ep2l6RCG3wnRYYY7+wdb9zFlKD36SKoIi3ri6peXmJbCw==
X-Received: by 2002:a25:28f:: with SMTP id 137mr12693722ybc.31.1581546733402;
        Wed, 12 Feb 2020 14:32:13 -0800 (PST)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id l189sm209487ywe.7.2020.02.12.14.32.11
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 12 Feb 2020 14:32:12 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4.1 make cachethis=no for writes
Date:   Wed, 12 Feb 2020 17:32:12 -0500
Message-Id: <20200212223212.14638-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Turning caching off for writes on the server should improve performance.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 7f5802b..22dca49 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5336,7 +5336,7 @@ static void nfs4_proc_write_setup(struct nfs_pgio_header *hdr,
 	hdr->timestamp   = jiffies;
 
 	msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_WRITE];
-	nfs4_init_sequence(&hdr->args.seq_args, &hdr->res.seq_res, 1, 0);
+	nfs4_init_sequence(&hdr->args.seq_args, &hdr->res.seq_res, 0, 0);
 	nfs4_state_protect_write(server->nfs_client, clnt, msg, hdr);
 }
 
-- 
1.8.3.1

