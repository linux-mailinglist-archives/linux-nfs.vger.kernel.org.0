Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD9B2D3421
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Dec 2020 21:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbgLHUaQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Dec 2020 15:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbgLHUaP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Dec 2020 15:30:15 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0E8C061793
        for <linux-nfs@vger.kernel.org>; Tue,  8 Dec 2020 12:29:29 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id p12so8850382qvj.13
        for <linux-nfs@vger.kernel.org>; Tue, 08 Dec 2020 12:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ta0oJLpJ85BMcjzd4A8eoeI6BZCDRtN4qtDaP420o2o=;
        b=uGoXH08+Tlrb42quO0VKWOVA5dwX0YDaTUbqQnegeHV/rWCBPtnubrpZqtZAiUATBH
         w/u+8ES6Kk6j/32MtKr8XPX5SYS01P2heKH2yFmPLFRSAB9cLMpEv7LjFzgnrUtYXtyB
         1jPMdW+pbZ9uoc/Vtt+rKa9oiV/gqohSkq9rYbD12YX1bdhiOvTh3TU+2gAnX9056Blb
         ORY9v8E4yQ0TUQifoVvOp8TxtcstXx69s8GZ9rLh3JZAk6H+iu1ThXlMc6YpEthzdreg
         ZLkQ3J9wsEvldUVZYIe5LcAr6vCeeVB90HMYBXeLkuNCzRL8N/zLw+PyyZJI5Hh/Ma9W
         yEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ta0oJLpJ85BMcjzd4A8eoeI6BZCDRtN4qtDaP420o2o=;
        b=bsFYcNU+x4THovKLHMoMzJsxdFcHAzGxMLVxfOjGufBREvtyE0ra87YPuUhNtixq73
         BJ+QzS1n2mO0+NOLVlTCT1/ysojuW20zrGHO1LGFdNGUPEOSoZqTAc7sOCjc8nCkkwYx
         Rf3108yIGGeBNSOgLb0DQD6Ex62YSKJhlbBcvAowpiNF6tlBxghs78hDx0cIJG37Osrt
         C1EUQBggIVounvZWdnJ8HBQJ8H3QLdkO2bnopghzFWOepFUbq558ockE5fGYVJYqVCjZ
         AIBeKmKy05atSqoaSLsu7IyNkNw/+sB6mGM8P8uiT6BNbWT9gqYOJbEG7fswqMoleUep
         eOOQ==
X-Gm-Message-State: AOAM531laFAAFtVnJEJ551Nz4Gl2hEh2bn+XAZd3z5KBUfWrAaPSR6PZ
        6rHUptfm+29+QGjYks4C6GQx2vwG3/w=
X-Google-Smtp-Source: ABdhPJyDDqWqIzgO/aCR9GmEIE0hhiWmx+E5nA/eZ9b3jFsDP2HkO+fg6NHxdC0vwGror0Fj9efhCA==
X-Received: by 2002:a05:6214:144b:: with SMTP id b11mr10430230qvy.5.1607459368698;
        Tue, 08 Dec 2020 12:29:28 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id q20sm5057278qkj.49.2020.12.08.12.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 12:29:28 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 2/2] SUNRPC: Check if the buffer has fewer bytes than requested
Date:   Tue,  8 Dec 2020 15:29:25 -0500
Message-Id: <20201208202925.597663-3-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208202925.597663-1-Anna.Schumaker@Netapp.com>
References: <20201208202925.597663-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

xdr_expand_hole() might truncate data off the end of the buffer. If that
happens, we need to return a short read to the NFS code to indicate that
some data has been lost.

Fixes: e6ac0accb27c "SUNRPC: Add an xdr_align_data() function"
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 net/sunrpc/xdr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 5b848fe65c81..68f470e33427 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1273,6 +1273,8 @@ uint64_t xdr_align_data(struct xdr_stream *xdr, uint64_t offset, uint32_t length
 	bytes = xdr->nwords << 2;
 	if (length < bytes)
 		bytes = length;
+	if (bytes < length)
+		length = bytes;
 
 	/* Move page data to the left */
 	if (from > offset) {
-- 
2.29.2

