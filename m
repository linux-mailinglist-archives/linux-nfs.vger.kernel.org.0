Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4622D341E
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Dec 2020 21:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbgLHUaJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Dec 2020 15:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbgLHUaI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Dec 2020 15:30:08 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C42C0613D6
        for <linux-nfs@vger.kernel.org>; Tue,  8 Dec 2020 12:29:28 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id s6so1145006qvn.6
        for <linux-nfs@vger.kernel.org>; Tue, 08 Dec 2020 12:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QadeMDB4dD0Jr9KGE9XjLUzhELzlem1e4EEpTMv9PU0=;
        b=E9HvWo55YQmLSLfoUgfVG8RxHV4R4Tnm7yyyKJBflAufaDfBehV5Ae6JlGvrBZeROF
         hm9UobbbbymVm0Upz/J3TvsmsSKjgtkL4RdhnKIJOJHtz+Z0sgql09cPPVHZypJkT7GY
         Gx6XpvpCiaiP7HcnCvOmOZkHJ9/Xhi0YhbEoen9yMQFPwnJGzPBGyIHrVnKJjUixSw9d
         o0PK16VA3cMUvS1yxVCXTvyO8lkgUc2CxpymOsxW4wpxzZxER1tcKoVtkwqx5UGGQIUG
         dyTcc4EaSRFltcDaRbU/tT5iVmoqnL0ck2K7qfRFxx1CgvYIB/WpwhDl06BQaF+32EGR
         8C+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=QadeMDB4dD0Jr9KGE9XjLUzhELzlem1e4EEpTMv9PU0=;
        b=JefwOvvEiFNeG0e1CK/BZ8NgwxcuxpLx82DFPQ3/uZNiaXVrs7MG90caPdQAtWzwVo
         L7b3FtV3LH8VIwcMTal6jL4PAUBaIcACXkdPzYHW62Rr3d4ZPGKHZAx530BTr2d3SkpF
         MS4ptxOGzcXAF4ufylS10l3gqkdvw/V8ixRLngLSO9GBPjm1fXwyRrbh1iZT2gAk9f/0
         RLv18N2obIRiZzcUa+eXgiipNdi1kQgffJE7K2vHBkxbOG9jyAE0ATkEMf/DR24b0DSR
         agm14sNowXCuqOQZ0jT9yGN5VRGhGCZlJvhd74elGdy1fmUlCecncrcw2Y6XPkwYXYdY
         HYjw==
X-Gm-Message-State: AOAM532bmdJ42CQ74sZCQywvYI+D+mN5pg3JtzBqPy/XtBls8MWPvkiT
        W7MxVVcOfQkMANwALWCM4KyJhncQ3ok=
X-Google-Smtp-Source: ABdhPJwWttURZxUcotbmComhB49mduLHM/AZasOnXi73Vp9Gu14PnMDHoE7Y45uLzJyOfL8dMp3TZg==
X-Received: by 2002:a0c:8e47:: with SMTP id w7mr29327827qvb.55.1607459367698;
        Tue, 08 Dec 2020 12:29:27 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id q20sm5057278qkj.49.2020.12.08.12.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 12:29:26 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 1/2] SUNRPC: Keep buf->len in sync with xdr->nwords when expanding holes
Date:   Tue,  8 Dec 2020 15:29:24 -0500
Message-Id: <20201208202925.597663-2-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208202925.597663-1-Anna.Schumaker@Netapp.com>
References: <20201208202925.597663-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Otherwise we could end up placing data a few bytes off from where we
actually want to put it.

Fixes: 84ce182ab85b "SUNRPC: Add the ability to expand holes in data pages"
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 net/sunrpc/xdr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 71e03b930b70..5b848fe65c81 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1314,6 +1314,7 @@ uint64_t xdr_expand_hole(struct xdr_stream *xdr, uint64_t offset, uint64_t lengt
 		unsigned int res = _shift_data_right_tail(buf, from + bytes - shift, shift);
 		truncated = shift - res;
 		xdr->nwords -= XDR_QUADLEN(truncated);
+		buf->len -= 4 * XDR_QUADLEN(truncated);
 		bytes -= shift;
 	}
 
@@ -1325,7 +1326,7 @@ uint64_t xdr_expand_hole(struct xdr_stream *xdr, uint64_t offset, uint64_t lengt
 					bytes);
 	_zero_pages(buf->pages, buf->page_base + offset, length);
 
-	buf->len += length - (from - offset) - truncated;
+	buf->len += length - (from - offset);
 	xdr_set_page(xdr, offset + length, PAGE_SIZE);
 	return length;
 }
-- 
2.29.2

