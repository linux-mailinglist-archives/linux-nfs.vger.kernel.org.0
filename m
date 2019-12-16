Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0E5B12194B
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Dec 2019 19:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbfLPSsR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Dec 2019 13:48:17 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45219 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfLPRyZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Dec 2019 12:54:25 -0500
Received: by mail-wr1-f67.google.com with SMTP id j42so4210753wrj.12;
        Mon, 16 Dec 2019 09:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=/ADs60hbOFeV91Nal7IRwSibD1PvyjxPHFpLiwg56pU=;
        b=alIV0owQs+4Tj0VrignHQenjkrJKJPddVpY38ar5e0/9GAS/qdZp6IvmaUQifxORdi
         vpeh8DL4t32X85EhODF52sW1LIOeD8Ta6eGaZT8XpAILRK/kiKN+m5zag1FI97NCYtw9
         J9c0B++M2fsp2z27my6fre4P9s7PAH6Af+JzD6+6mU5UAVDeuvr5VbdS6JkI5oiO9yjc
         mXbpuQZDsY8EKFXUtHtJU/jbi3yoc6GLejAUNlPVmlQCq5l246PQg6KjH4143AmyZ1+d
         KmveWgkLxo0l0AdNlv/U4Fu4Y7AH8GE1kA8Plk4sLr+ejkdSODixOPOZk75OSvvubQTJ
         BgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=/ADs60hbOFeV91Nal7IRwSibD1PvyjxPHFpLiwg56pU=;
        b=LAccXNwtaUJK4TZfY7TsYSdeavEzrWn9PP63NKKpb+bC8arDjhcyi3lwwEoKbSi52p
         gwEp1R1fYPdr5UjGKCr05E1onLFrdMFiyUqPcpgnR2pBUw2PQ1bz0aPu1w4bPs8JZ+CW
         ukZgiScIAs5abuRKuDl+iMXemB5GiiAwCWkcwJLIy5xW6uU8pqvD8TJMx8qCCAKTpSqd
         i0qP71yokq5ti5gBgA3H6KsvCRyjvdDUdaIaRvvSIJBi1pJXElcqJbaEq1vYCLuKXgIJ
         frKQb4L75xsg6PcE+pck3dQ8DQk8JsmezZ0jiwN5vaHSPT/YbO+dW77dMPWsBvWy1J5+
         2uZg==
X-Gm-Message-State: APjAAAVwk43g/HO3SQxdACmTWL0mj8MnbHsajHXjMETUcdM7Z+57H7Oo
        UyWv6DUI3qgje1E98Sn9ibE=
X-Google-Smtp-Source: APXvYqzLvZWcCouTgjODTUh4a7Ne/akkw8fCqL5aQfJbgy+SUlUUEvXNo8P6tp8tTVtgRDgaZ54HHA==
X-Received: by 2002:adf:f88c:: with SMTP id u12mr33319322wrp.323.1576518863678;
        Mon, 16 Dec 2019 09:54:23 -0800 (PST)
Received: from WINDOWSSS5SP16 (cpc96954-walt26-2-0-cust383.13-2.cable.virginm.net. [82.31.89.128])
        by smtp.gmail.com with ESMTPSA id a16sm22341245wrt.37.2019.12.16.09.54.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 09:54:23 -0800 (PST)
From:   "Robert Milkowski" <rmilkowski@gmail.com>
To:     <linux-nfs@vger.kernel.org>
Cc:     "'Trond Myklebust'" <trond.myklebust@hammerspace.com>,
        "'Anna Schumaker'" <anna.schumaker@netapp.com>,
        <linux-kernel@vger.kernel.org>, <linux-nfs@vger.kernel.org>
Subject: [PATCH] NFSv4: open() should try lease recovery on NFS4ERR_EXPIRED
Date:   Mon, 16 Dec 2019 17:54:22 -0000
Message-ID: <05c201d5b439$d99083c0$8cb18b40$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdW0MuhLiOKK2wGRQLycz+SVs0XJrQ==
Content-Language: en-gb
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Robert Milkowski <rmilkowski@gmail.com>

Currently, if an nfs server returns NFS4ERR_EXPIRED to open,
we return EIO to applications without even trying to recover.

Signed-off-by: Robert Milkowski <rmilkowski@gmail.com>
---
 fs/nfs/nfs4proc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index aad65dd..04e6a13 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -481,6 +481,10 @@ static int nfs4_do_handle_exception(struct nfs_server
*server,
 						stateid);
 				goto wait_on_recovery;
 			}
+			if (state == NULL) {
+				nfs4_schedule_lease_recovery(clp);
+				goto wait_on_recovery;
+			}
 			/* Fall through */
 		case -NFS4ERR_OPENMODE:
 			if (inode) {
-- 
1.8.3.1


