Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9121379BE
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2020 23:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgAJWfA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Jan 2020 17:35:00 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46522 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbgAJWfA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Jan 2020 17:35:00 -0500
Received: by mail-yb1-f194.google.com with SMTP id k128so1356728ybc.13
        for <linux-nfs@vger.kernel.org>; Fri, 10 Jan 2020 14:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=exiG3GqNe0eX6JhDS66gE2pn/HyCAzCxwXkZUXHpG1M=;
        b=nSe4JgsuxjJ3p9Ki7VFOMLhC5pOqRFAX6LkG1a1ZIeYbfOKuLdNmuxj0fjlQ2nBCO/
         PoFZ04+9kTloPV/QaKX1Qgb2bI4PiMX/WiMTZg4niXAsm2/iT+SveCE23GpV/HQbfHY3
         ODQ9aLFaRw+Yp/o8AVkg9FB685+AKg32slV0tyjHR9KZQepXqPIE4ayZ341Wn2xzkcdn
         FH+inWEFMOQ7hqNOlyMH/AWAIpD4qXCpTwKrPE3ggY6ZTCUmRJFFHZ01pwUGzGFgDTjF
         igee0bKO69Lsd9h1iTskW6vsPV+LKzrms9/sd4fNiTaCIEhpG0N7cBBbjInrTG/lYiVZ
         Cv6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=exiG3GqNe0eX6JhDS66gE2pn/HyCAzCxwXkZUXHpG1M=;
        b=o0Nu7B54abCMeEdscVa2UHv5MD0NYil/7tQULQAFk38DOBbOf+B5Pnbs7v0w3OabQm
         XCe2rl73m+KEQmZes5V/icGIUVD867jwniwaq4udOtlRILuZArMCdg1XwUCEyK9VqgFX
         Pdx6O+G3d6Gp31YIvNzghLoCWX/qJ9t85XcZmftl1kczl8M+U3xEyIZ51JU9+6q28uGL
         JF7LrjOAMsUyq3VXCAui1WqRv5sNQQNybq6I29hHVtAcMk/u0DgMxzRVaw/HB/4RZUiS
         KGvp9QG2ekIFYyzb2YqQsAGSkoYcQ25UVahID/ep+8RBVIHKBAwLMYYU+d6oayJwdzaQ
         Goyg==
X-Gm-Message-State: APjAAAVgkamZvon0rUW5oV5W7hUamCof2ozZirQAATFmGu+A3Qc7r0nZ
        QByURT1nTur5cKGM5+rKb0W59rSL7VQ=
X-Google-Smtp-Source: APXvYqz99d8nToN/6SWau6T1gIZcN9suDKZ/f40dWdhsd49p7fsbE93G6x0LhCgNQPL+VOkqoFhfEg==
X-Received: by 2002:a25:b9d2:: with SMTP id y18mr4542500ybj.202.1578695699244;
        Fri, 10 Jan 2020 14:34:59 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id e186sm1554060ywb.73.2020.01.10.14.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 14:34:58 -0800 (PST)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 1/7] SUNRPC: Split out a function for setting current page
Date:   Fri, 10 Jan 2020 17:34:49 -0500
Message-Id: <20200110223455.528471-2-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110223455.528471-1-Anna.Schumaker@Netapp.com>
References: <20200110223455.528471-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

I'm going to need this bit of code in a few places for READ_PLUS
decoding, so let's make it a helper function.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 net/sunrpc/xdr.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index e5497dc2475b..8bed0ec21563 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -825,6 +825,12 @@ static int xdr_set_page_base(struct xdr_stream *xdr,
 	return 0;
 }
 
+static void xdr_set_page(struct xdr_stream *xdr, unsigned int base)
+{
+	if (xdr_set_page_base(xdr, base, PAGE_SIZE) < 0)
+		xdr_set_iov(xdr, xdr->buf->tail, xdr->nwords << 2);
+}
+
 static void xdr_set_next_page(struct xdr_stream *xdr)
 {
 	unsigned int newbase;
@@ -832,8 +838,7 @@ static void xdr_set_next_page(struct xdr_stream *xdr)
 	newbase = (1 + xdr->page_ptr - xdr->buf->pages) << PAGE_SHIFT;
 	newbase -= xdr->buf->page_base;
 
-	if (xdr_set_page_base(xdr, newbase, PAGE_SIZE) < 0)
-		xdr_set_iov(xdr, xdr->buf->tail, xdr->nwords << 2);
+	xdr_set_page(xdr, newbase);
 }
 
 static bool xdr_set_next_buffer(struct xdr_stream *xdr)
-- 
2.24.1

