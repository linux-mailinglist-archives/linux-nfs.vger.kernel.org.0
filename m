Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41DC02CDF9E
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Dec 2020 21:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgLCUT2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Dec 2020 15:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbgLCUT1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Dec 2020 15:19:27 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3BBC061A54
        for <linux-nfs@vger.kernel.org>; Thu,  3 Dec 2020 12:18:47 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id i199so3404328qke.5
        for <linux-nfs@vger.kernel.org>; Thu, 03 Dec 2020 12:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T1cjsePf2wHK5cj8ShKsUDNynGhFjKDY0ROw5ITEQmA=;
        b=oYJbu4CgJ6ipd3YL7eXCNZDu4KsiXVOd1sQOIOoZiE4LY9Ic/bRAIEGfhPUvnJYar4
         Ut6SZbXH1cT1oOz3srvf5A+kUkKi45OfbT2fYQbLfNCPaxzKSayDEsUuGPVNH/F8e0WF
         yx0siKkcIofYX6G3CkDWhAzkqhBjZuxuh5/XgqyAS/WyvD7AswbVLvj+v2qcorAbH2Mk
         daQRbjKNo3VjDgFZFMwSeKJew2KV7uhZ4vJt+g0x0KNYrCMNhCHYpuTf0xBqQ8I8fEf/
         YUvZD3FIUbDjAFb6phQ+eAN4yoWNaIRuZJcnm5A7wNneNrHlSNWTojY8NTecMEl78Dwh
         cC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=T1cjsePf2wHK5cj8ShKsUDNynGhFjKDY0ROw5ITEQmA=;
        b=TbuiXzMJrcRWcZcUFMf5MbJSZXw649IPPTEKElu+fNc+o84w2jG0DH/qYC49gTZ1Xy
         Z0FgftanL2i2WrCwsPk5V2zcV7IpGVFRUnrPH6KqzBdUSBI8P87CEesK2zKOYz/s686+
         R8ubl3DNlAT2BtJi2K5+7T47w/giGAiG999NUUAbBl/vl5ZzDRIJQLIzYSyufLZpH/QG
         4b1Qmw3Q6Vq03C1QAupjII+0rlkrp7/wfhBr02jyGjV13cC7vzxxIJ4A5igXjtCHN8LU
         onS01z+r30mM4x6HHvdyYZJGx+DIPdV3wXxgSBw40C4mITrSpXYK1iDcc5Tyx2t0fbzU
         xNCA==
X-Gm-Message-State: AOAM5322MPS1lC2KTtj4AIob9RttDeuL27VSY04KSrUt2am7AhJ7srFg
        u9bunThaxyAldP+ETpZwf99NPZW/qyA=
X-Google-Smtp-Source: ABdhPJw+oY4qU2W72rTaS286od2Nc15yX1SJ3f+GpLtebM4JSScLE9uzll+eAR/327pLvBbXyzGULw==
X-Received: by 2002:a37:a484:: with SMTP id n126mr4693353qke.277.1607026726395;
        Thu, 03 Dec 2020 12:18:46 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id q20sm2194530qtn.80.2020.12.03.12.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 12:18:45 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 3/3] SUNRPC: Keep buf->len in sync with xdr->nwords when expanding holes
Date:   Thu,  3 Dec 2020 15:18:41 -0500
Message-Id: <20201203201841.103294-4-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201203201841.103294-1-Anna.Schumaker@Netapp.com>
References: <20201203201841.103294-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Otherwise we could end up placing data a few bytes off from where we
actually want to put it.

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

