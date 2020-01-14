Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27FCA13B030
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jan 2020 18:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgANRCd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Jan 2020 12:02:33 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:41347 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgANRCd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Jan 2020 12:02:33 -0500
Received: by mail-yw1-f66.google.com with SMTP id l22so9611755ywc.8
        for <linux-nfs@vger.kernel.org>; Tue, 14 Jan 2020 09:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WCB73bbYYD5MHty/raK1qkIhT6EzYQtfJOCKDR4gdeI=;
        b=I8KlLuIknShW0lotuZ2NNECiV+tZO1wFaklel6ORyghG5w4FCqWshthmPgu6R667am
         boneH0LpLirguDHqLhsiNz5lQKqzWHuAFVpby6xKL/DwxdkJKvG1a7C5KizJmiWB/ikY
         RdaAkd8DCK+JHdkxseUcLCjVZ4Dj2mn9E69Gk4Y8dvwAynA3zl42+UGEaVjNs/S4iaVM
         bYz6d4NLYKt/yGqXxJTaOUkm3i7AIwc4AmY+x4Jpx8ASHCRih/8z8AptqP0IYOv0BBn5
         3OYt9T4hdqy7nV6f6kys2tnF3QuDX/eaR9Mse/6PH+RFNJreOhsswJ7jtGfzpAWQScH/
         /1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WCB73bbYYD5MHty/raK1qkIhT6EzYQtfJOCKDR4gdeI=;
        b=N3ZqDvgwxC7S9isST5oz2OeNI8Pwhm23ZT6V6sjKAGyb/ae/sBhD/S3SytBLVPVQMD
         LBZCTeh6JNA/3gHaaeF8OGTUvH4Ox11Jrr9bTI6gOFXUpqqbUStmzUYPh8dTyuyIGiu5
         S06f3VFfeEQglyh1MQN9wFFhxhAIb/Euy1P8fu78WPWHnTRgMm0nrdwj4GLuJ92QlGqN
         Mybiq/pD5t1N1OjVb3nZnSCPXPxgPnptenvftlr6YdhnGSHwaYXU6sCJF4AV6hCn+gtk
         hppY4oGHcy5BD7GuYwv1neVqxr9pkGfQNifj4VS7YGIKHu3Wa9hWExlNJtICMIP+jC2i
         HPLw==
X-Gm-Message-State: APjAAAUdOgzOAeWDaR0U1l9RgzZAs51v6SjXEWiIN397MG9WlWN2TPMo
        ifZpFsECWIgbPEr0W+rM9g==
X-Google-Smtp-Source: APXvYqxiuPcJj6aYmirTrfOvGAHJkyz4tJJQQt57N7zggcgsMblsXD3VSBsOjxBXUK4bx/vT+uO1Cw==
X-Received: by 2002:a81:4cd3:: with SMTP id z202mr13455100ywa.477.1579021352649;
        Tue, 14 Jan 2020 09:02:32 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id q185sm6926930ywh.61.2020.01.14.09.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 09:02:32 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] nfsd: Define the file access mode enum for tracing
Date:   Tue, 14 Jan 2020 12:00:22 -0500
Message-Id: <20200114170022.923083-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114170022.923083-1-trond.myklebust@hammerspace.com>
References: <20200114170022.923083-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/trace.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index b073bdc2e6e8..17ecef404e5b 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -166,6 +166,12 @@ DEFINE_STATEID_EVENT(layout_recall_done);
 DEFINE_STATEID_EVENT(layout_recall_fail);
 DEFINE_STATEID_EVENT(layout_recall_release);
 
+TRACE_DEFINE_ENUM(NFSD_FILE_HASHED);
+TRACE_DEFINE_ENUM(NFSD_FILE_PENDING);
+TRACE_DEFINE_ENUM(NFSD_FILE_BREAK_READ);
+TRACE_DEFINE_ENUM(NFSD_FILE_BREAK_WRITE);
+TRACE_DEFINE_ENUM(NFSD_FILE_REFERENCED);
+
 #define show_nf_flags(val)						\
 	__print_flags(val, "|",						\
 		{ 1 << NFSD_FILE_HASHED,	"HASHED" },		\
-- 
2.24.1

