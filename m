Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5CE42CFAD5
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Dec 2020 10:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgLEJ3s (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 5 Dec 2020 04:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728524AbgLEJ3X (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 5 Dec 2020 04:29:23 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2CAC061A4F
        for <linux-nfs@vger.kernel.org>; Sat,  5 Dec 2020 01:28:42 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id ga15so12264991ejb.4
        for <linux-nfs@vger.kernel.org>; Sat, 05 Dec 2020 01:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bEUZDaoNveIa0V4ixRUsq6lVjVqGVVltPKp+yGY9TZw=;
        b=xSrBABAVYm+bSjCCM+Lm2Aq4EkhbPMk0h8xtysUZKj86XIdSbNr9iVZqG46DLz4Q+A
         I5UAi70TxxXOS+RoBYXJVtzuJND63rptR3Y7uc78npDQ+uk3Bkt5+n0uFN9cnzyaK93E
         +9gag8vhDV5fwS3Sa5zPaD4q5z8e5SAAX4ZpopIKoUbcIfcKlkS0vwLS5Nadk6ZUAN0J
         tEDlWwSHYQ6WEtxHKmKuZEWjo68tHReKz9xt4U3WW9lJKZPsaaH2FaWaEL8IPn1zwcju
         xmZxMjCuN8TkWuT7mMarjVCJL/hs+ojKR9BPMIq0KtFK9oXPCV9P622wH4K0smIBijxv
         Gf4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bEUZDaoNveIa0V4ixRUsq6lVjVqGVVltPKp+yGY9TZw=;
        b=BTs19gw5W8yszO/bhhF9Mc4C7/QsHEqMcWRAqxlcHFRDljmUncuMHZjeS03Jm1/095
         sacezyoVmqMZR9KeK/YoRe8U/EwWgpMZIADY9d//LT7Q+JeM3cntr0jsfEptjOEXFvuX
         WH2ZzWB9Zub/2tsREPb7nNGmFVzrO1HVOrO2XByzvg88Aml0F3apGpV59PgTxvuRTGzj
         swLWWit6luY0b8ulnoWUiA85DGDRtrRUB75hFN5UiPUIfFYzN1ICKRGcIlG3rWGOdXqx
         b78P1O3IdFAOJIRJPU4z9IOFXEktJZCCbeq6Psi2donP5VpBSB5MmVGvQHHjoea9y+qv
         7gcw==
X-Gm-Message-State: AOAM530mK2QoooAdeAdBNga6r9Y0M2AUx7V2oAQAgfERqF4/lOWduW1S
        BTPVuAs+Beiur40oLQHx+vVjgHQZW3sw5txw
X-Google-Smtp-Source: ABdhPJwc279XW4TS0EzgUzSulMF0xNL6sgZ/BUQ1ZRNj+rySli9jGK+CPvtBDRqE3oywUc51GuaDDw==
X-Received: by 2002:a17:906:f0c3:: with SMTP id dk3mr10686982ejb.366.1607160520568;
        Sat, 05 Dec 2020 01:28:40 -0800 (PST)
Received: from jupiter.home.aloni.org ([77.125.107.115])
        by smtp.gmail.com with ESMTPSA id i90sm5251060edd.40.2020.12.05.01.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 01:28:39 -0800 (PST)
From:   Dan Aloni <dan@kernelim.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2] sunrpc: fix xs_read_xdr_buf for partial pages receive
Date:   Sat,  5 Dec 2020 11:28:35 +0200
Message-Id: <20201205092835.2246185-1-dan@kernelim.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <528fd4a869f0757e0a60e9c733d4625067693588.camel@hammerspace.com>
References: <528fd4a869f0757e0a60e9c733d4625067693588.camel@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When receiving pages data, return value 'ret' when positive includes
`buf->page_base`, so we should subtract that before it is used for
changing `offset` and comparing against `want`.

This was discovered on the very rare cases where the server returned a
chunk of bytes that when added to the already received amount of bytes
for the pages happened to match the current `recv.len`, for example
on this case:

     buf->page_base : 258356
     actually received from socket: 1740
     ret : 260096
     want : 260096

In this case neither of the two 'if ... goto out' trigger, and we
continue to tail parsing.

Worth to mention that the ensuing EMSGSIZE from the continued execution of
`xs_read_xdr_buf` may be observed by an application due to 4 superfluous
bytes being added to the pages data.

Fixes: 277e4ab7d53 ("SUNRPC: Simplify TCP receive code by switching to
using iterators")
Signed-off-by: Dan Aloni <dan@kernelim.com>
---
 net/sunrpc/xprtsock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 7090bbee0ec5..9a4300f07e4c 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -433,7 +433,8 @@ xs_read_xdr_buf(struct socket *sock, struct msghdr *msg, int flags,
 		if (ret <= 0)
 			goto sock_err;
 		xs_flush_bvec(buf->bvec, ret, seek + buf->page_base);
-		offset += ret - buf->page_base;
+		ret -= buf->page_base;
+		offset += ret;
 		if (offset == count || msg->msg_flags & (MSG_EOR|MSG_TRUNC))
 			goto out;
 		if (ret != want)
-- 
2.26.2

