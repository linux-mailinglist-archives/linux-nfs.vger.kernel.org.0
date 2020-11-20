Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A78D2BB724
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731118AbgKTUes (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731034AbgKTUer (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:34:47 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2A7C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:34:47 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id g19so5330111qvy.2
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ns4r4yy8hXlJcaQU15al8G28x4aiuNo5XhIglFPo0t8=;
        b=Lqatmphda7p9ciP+D38O2HkFEEbpbvbbTWvFvkxchtfT4nkcnXT65JWobxMeJFTU/s
         k9Hic0I7cJwgOtdx5ciaEV4NiIzAovmBUnPkgnGmpAdJGIXqxsJ0A7P5NKjcXa7LFVUa
         C2Pw/W1nf+HwIXvzmBQRMlkd1TfpO7Ivm9GAyztL897PqaVWZqUHzJHpun+Y6TzB/hsd
         YeTrSeLYUJ+kelQY8nlPl9NOWUvVaPhNqE5WrbFI7xhZrwR9elVFsch4jlfGdAPFvdm4
         y5kZZrYz5ksnO02oSjyTKO3qsL5ccBdxoKR4JCwTFxM6NVx6vs5pg/jSa48TUXUs3APR
         Xeyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=ns4r4yy8hXlJcaQU15al8G28x4aiuNo5XhIglFPo0t8=;
        b=HHyrgZktDN6jpu1JYjDH/bWf3hxGJEY0IwYbgSXCvdSeszLbbfqxhSsgV7djoSIWl9
         ebpJbNTWzffAYKoUwS52b5isXW9hCE5qoINACLZZLk29HiLy5XC+mhbB/n2Q6TJdLGiG
         AwjHqZmLbCHB/O48hJJPkbDgdDdX1/S2IGs3pnoDtoxdAn28J5IcmnsWJ4APig4EeoPg
         6i4TTmkwOXHSyzT4X33r/F/fg1875MEsB3qvfJM2C8IcOevPQFCu0ohHCDZoS5/D3AE1
         Q9BTAresq/PLFfvACDGJTj+epwBLfHNx/Ye0nJzoCceC8ZN95OynCXbEus3NGwyW1+83
         uL7w==
X-Gm-Message-State: AOAM530kYEtjFTaBSodRyeSYp1rZr86JKBUflIuI9LxRgcTFmvvktv1o
        qhu/bOUX0kTF4x/uGYYh9gMwKECjlME=
X-Google-Smtp-Source: ABdhPJxM8ywVa4v87uLcWDxIwzoIgnSicPhEi6lDiwNRH760K+xgjXqAy14zcc8+93Mj7DpEeQEzCA==
X-Received: by 2002:a0c:f651:: with SMTP id s17mr18484352qvm.32.1605904486410;
        Fri, 20 Nov 2020 12:34:46 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id l46sm2926591qta.44.2020.11.20.12.34.45
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:34:45 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKYiLJ029235
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:34:44 GMT
Subject: [PATCH v2 011/118] NFSD: Replace READ* macros that decode the fattr4
 size attribute
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:34:44 -0500
Message-ID: <160590448442.1340.1862136126790405957.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index a076bb42e98a..9f121698aa92 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -271,8 +271,11 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 	starting_pos = xdr_stream_pos(argp->xdr);
 
 	if (bmval[0] & FATTR4_WORD0_SIZE) {
-		READ_BUF(8);
-		p = xdr_decode_hyper(p, &iattr->ia_size);
+		u64 size;
+
+		if (xdr_stream_decode_u64(argp->xdr, &size) < 0)
+			return nfserr_bad_xdr;
+		iattr->ia_size = size;
 		iattr->ia_valid |= ATTR_SIZE;
 	}
 	if (bmval[0] & FATTR4_WORD0_ACL) {


