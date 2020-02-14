Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7971D15F880
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2020 22:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388880AbgBNVMc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Feb 2020 16:12:32 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46083 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388611AbgBNVMc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Feb 2020 16:12:32 -0500
Received: by mail-yb1-f194.google.com with SMTP id n131so2083929ybg.13
        for <linux-nfs@vger.kernel.org>; Fri, 14 Feb 2020 13:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JdeyJJxBiPoYKIpc2OOvNsxuYuaYaRTbJwkLpmvnKo4=;
        b=uwUHJd9wgzovLpHjJ6XTFsTAxtlXOYvNXsXLSCmnBpBECJnjNFWLL66Mzfgy8T1YQx
         StUjEa3KgJS5sCS36dH3PhznVOCTzL5RM6llOnXa8RPe60bdO7whvF6vtR9FhQr3UB84
         iUdaW4XmQGRxgtnGEk1YAeIX9FPOfh2hFTW+GQUlOqgivsqX4Uiovp1shTlh9TJoEXFP
         XUjXaKNU5De11gR6HEQozy6T7uo5gDafrmTUKLTMae3aTWhssqjYeueGt63Wt2vCcaZa
         y0rDaNChSjxjHp/80onab2Amjt5c0/FNRr+Wr1jSp9e2TgP4MpV7ztLGDad9+fyzq3Im
         EmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=JdeyJJxBiPoYKIpc2OOvNsxuYuaYaRTbJwkLpmvnKo4=;
        b=svbsQQ1r828DFZPj1x6e2nclHNyOkbP8UeoucdHk/hR+OVZ4Vr2XxD+GNS4jyFIhVg
         Pb0YszpjFMzKFY2CIKhZjHmvP6pxxkvCc/sY6PGaAwaFr3d+PZCsnGMpgxbpHZaExDgv
         o2DIuVSYpGS63j/iSqpXvp/heYragdglZpgtVhRkwVWO2qxtvuLatK6lnLKJaiCvpK2Z
         //j4veT+vxfa3qR8+0G664sqyxJaogH6g14Ce2GvLs7QzHuldHpGYYUfsTjYnfqz6oXS
         JreoFjWP8o6LsN8++sqJmfSLIfmXSTcMianT/hQdt80/DrNTVcXbsjeqAY+R1oWTmt9W
         Nm6w==
X-Gm-Message-State: APjAAAVbEZI3BKp+czgLWqoDoQxPAnunQVtMxaev0oG+QsnAuqxZd4ex
        FCrQUtq/xN01jXbSnHcnNwE=
X-Google-Smtp-Source: APXvYqwvrwsG0xZK+V3hqpPtGpegJyFYfvJlwpMo7MBpX99kvTlNPckONoSFomNNTtaqs2RobbGUYw==
X-Received: by 2002:a25:854f:: with SMTP id f15mr4452892ybn.463.1581714749971;
        Fri, 14 Feb 2020 13:12:29 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id z2sm2840636ywb.13.2020.02.14.13.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 13:12:29 -0800 (PST)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 1/6] SUNRPC: Split out a function for setting current page
Date:   Fri, 14 Feb 2020 16:12:22 -0500
Message-Id: <20200214211227.407836-2-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200214211227.407836-1-Anna.Schumaker@Netapp.com>
References: <20200214211227.407836-1-Anna.Schumaker@Netapp.com>
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
2.25.0

