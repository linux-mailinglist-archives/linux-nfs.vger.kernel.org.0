Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B262AC70E
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Nov 2020 22:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbgKIVUt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Nov 2020 16:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729776AbgKIVUt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Nov 2020 16:20:49 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5541C0613CF
        for <linux-nfs@vger.kernel.org>; Mon,  9 Nov 2020 13:20:47 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id i7so7102241qti.6
        for <linux-nfs@vger.kernel.org>; Mon, 09 Nov 2020 13:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UH44+8kxlFN6tu42KNQaihbAbclJRhUfbzPO2/XsY2k=;
        b=RJKJn/x7xoIyKr1ImFlCwLCQ+z378twK4szYTu5I9Hy0IdPudd2MnyKqMG01d2fz1I
         1hDFEeRU43olppX6AYeTv51wRQg6xpVHtGtJPd8UGDooapXWSfXebm15B3F6FjUoPhNx
         PgG1UAKmnljwgopPAGYej3FA8oytG6Cak9ostL+nIH3H/0mJ563OWwaUVtwLxmHAgofi
         KRTlbhCYlZQ0bWG6b6yVi8qsemk/Dum5VZPYKaJRAekB2k5lmnTG+Ux/Otng0kVnjh31
         hXVYh+GTLP9It8s5H1FXaFMmWwiaDDrF7zIIh+WRbxBdJF95Gptmhy8uyBxxfH9RGO9G
         wPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UH44+8kxlFN6tu42KNQaihbAbclJRhUfbzPO2/XsY2k=;
        b=o031+eKx+bvQN2VERYFKY5g2X2P/Cu/4qioRFxTrLAhWlM2bA9lSROa1JiO5ciAJ8d
         xeu8VVVM3zDOK9bG1kuTBuxPTjYEhA/2klR40Kb9KTBGivUGw4uob97jqcg1hPr4D5QE
         3XONONexGpz3YaW97tssJzssULo/kcENxeGpj410IOMpu5VscKW++t7M4DC5ht2L1JD1
         mRINhqyUaUHEfYED36TJUJYB4Hk19mQ6/5PF1CN+WrDPpm6w0ucqadTYbcCyyxum+Cyn
         aueb2P/MKISAca1BNTRU8gCuzwPAcBh2itoTkms5grEAPsmvPRJ8OXuaC8CbL7ZuZnxq
         osIQ==
X-Gm-Message-State: AOAM530BHbGjiywdfRp4AUAmTzJGlNVN0lpSqokFs2HNsFiYuM2WwDzk
        UdjhdxI36Wx5N3Sa4RztroR5ltQq0JBg
X-Google-Smtp-Source: ABdhPJzzvmOtO66mOpdGOtp3F/MghaojxA73NiMMywiqadj8tWOXBkMLCBa0/JGsLOyTmEJwPqUJfg==
X-Received: by 2002:ac8:6c2a:: with SMTP id k10mr7332000qtu.89.1604956846717;
        Mon, 09 Nov 2020 13:20:46 -0800 (PST)
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net. [68.36.133.222])
        by smtp.gmail.com with ESMTPSA id d188sm7025241qkb.10.2020.11.09.13.20.45
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 13:20:46 -0800 (PST)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 5/5] pNFS: Clean up open coded kmemdup_nul()
Date:   Mon,  9 Nov 2020 16:10:29 -0500
Message-Id: <20201109211029.540993-6-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201109211029.540993-5-trond.myklebust@hammerspace.com>
References: <20201109211029.540993-1-trond.myklebust@hammerspace.com>
 <20201109211029.540993-2-trond.myklebust@hammerspace.com>
 <20201109211029.540993-3-trond.myklebust@hammerspace.com>
 <20201109211029.540993-4-trond.myklebust@hammerspace.com>
 <20201109211029.540993-5-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs_nfs.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index d00750743100..5acddd14ffe8 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -1085,13 +1085,10 @@ nfs4_decode_mp_ds_addr(struct net *net, struct xdr_stream *xdr, gfp_t gfp_flags)
 	if (unlikely(!p))
 		goto out_err;
 
-	netid = kmalloc(nlen+1, gfp_flags);
+	netid = kmemdup_nul(p, nlen, gfp_flags);
 	if (unlikely(!netid))
 		goto out_err;
 
-	netid[nlen] = '\0';
-	memcpy(netid, p, nlen);
-
 	/* r_addr: ip/ip6addr with port in dec octets - see RFC 5665 */
 	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
@@ -1108,13 +1105,11 @@ nfs4_decode_mp_ds_addr(struct net *net, struct xdr_stream *xdr, gfp_t gfp_flags)
 			rlen);
 		goto out_free_netid;
 	}
-	buf = kmalloc(rlen + 1, gfp_flags);
+	buf = kmemdup_nul(p, rlen, gfp_flags);
 	if (!buf) {
 		dprintk("%s: Not enough memory\n", __func__);
 		goto out_free_netid;
 	}
-	buf[rlen] = '\0';
-	memcpy(buf, p, rlen);
 
 	/* replace port '.' with '-' */
 	portstr = strrchr(buf, '.');
-- 
2.28.0

