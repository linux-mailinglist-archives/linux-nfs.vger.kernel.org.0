Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606C543E8EA
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Oct 2021 21:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbhJ1TRd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Oct 2021 15:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhJ1TRc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Oct 2021 15:17:32 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8726AC061570
        for <linux-nfs@vger.kernel.org>; Thu, 28 Oct 2021 12:15:05 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id t40so6788978qtc.6
        for <linux-nfs@vger.kernel.org>; Thu, 28 Oct 2021 12:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XsYmSAyM/vFFh0W0vY2hBK179DgvCJ6Zzk7gn2Pu59M=;
        b=g8sjYHoA2QO6Lq7snE2SgxDp5B8oY4AEMkF5PTtVh9ldv6L022rhuywe8VidZOZ12K
         L0Yj7krhsnHiCineSXmY26FkYzXJLFlU7DwMByKexgOQtJy36Ou2S8otzj15pDeCbLBt
         xN4KK6W0JDj14ZwR2XKX0hCfnCm5i9yUaCygsSmGvDs1Hx1YQJzsz6P2IcParnRmacaW
         ZEcu4ddSs5joZgDUkxTlzZfzmAhObSdst44jCXT06SIzoxrB9/9+1naRCkD8dOALqQKY
         yzLw/2RZGoV4rhca6Ij0WQNHFQ3h83Y6iy26+edP53p0rr9GgtEs4xZ7+crUuiMw1bkO
         kkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=XsYmSAyM/vFFh0W0vY2hBK179DgvCJ6Zzk7gn2Pu59M=;
        b=zEPpHlE4HaMtb1OwJp3v55wY5TRsCH2TsRy/T9OD4sy7PuPVPR2AJqp5eUNcAo5h5A
         J+5g5kuYg1yT8jZJoDNqA8Dq3Sp3xXQMz9jmZXqKjy1GKa8KOpoA58WjmjMC6VLG4agj
         Op2R9mO7QnJBIahgoxFjQktiovF8fIuNrMi2wlNVQGhn4/ynXUttwCE7A4MIVbnP+Y5s
         U/qaUg/PsfvI6Sd1WdmWi4H4gfrwc9V1kqBOy8PCdwL5TuFhmN4QdMPkBhx5a+mNzUgl
         JpTRgkOqxkPZrbmudYPL7tF0SyTDlTOK5682PzHpEi7Vk8q25kTYeo5itifuHK8LAKH6
         hJVQ==
X-Gm-Message-State: AOAM532T1WADBvIbiRzoyHFsaUCfhfqv6gc76HeQMZNnoA75bD5nbD+K
        ZyHcVI5oRYLypoVbNjAMyO4=
X-Google-Smtp-Source: ABdhPJy2wz7Q/VirlzSqTCHO+2kSVKzA+Z/upuDqqSen+9axA3PSKIgSoZILR5vtnUCY4ENsnJTSKw==
X-Received: by 2002:ac8:5916:: with SMTP id 22mr6608917qty.247.1635448504608;
        Thu, 28 Oct 2021 12:15:04 -0700 (PDT)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id h13sm2650660qko.27.2021.10.28.12.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 12:15:04 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH] SUNRPC: Check if the xprt is connected before handling sysfs reads
Date:   Thu, 28 Oct 2021 15:15:03 -0400
Message-Id: <20211028191503.161833-1-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

xprts don't immediately reconnect when changing the "dstaddr" property,
instead this gets handled the next time an operation uses the transport.
This could lead to NULL pointer dereferences when trying to read sysfs
files between the disconnect and reconnect operations. Fix this by
returning an error if the xprt is not connected.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 net/sunrpc/sysfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 9a6f17e18f73..8e765a5d3094 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -109,8 +109,8 @@ static ssize_t rpc_sysfs_xprt_srcaddr_show(struct kobject *kobj,
 	struct sock_xprt *sock;
 	ssize_t ret = -1;
 
-	if (!xprt)
-		return 0;
+	if (!xprt || !xprt_connected(xprt))
+		return -ENOTCONN;
 
 	sock = container_of(xprt, struct sock_xprt, xprt);
 	if (kernel_getsockname(sock->sock, (struct sockaddr *)&saddr) < 0)
@@ -129,8 +129,8 @@ static ssize_t rpc_sysfs_xprt_info_show(struct kobject *kobj,
 	struct rpc_xprt *xprt = rpc_sysfs_xprt_kobj_get_xprt(kobj);
 	ssize_t ret;
 
-	if (!xprt)
-		return 0;
+	if (!xprt || !xprt_connected(xprt))
+		return -ENOTCONN;
 
 	ret = sprintf(buf, "last_used=%lu\ncur_cong=%lu\ncong_win=%lu\n"
 		       "max_num_slots=%u\nmin_num_slots=%u\nnum_reqs=%u\n"
-- 
2.33.1

