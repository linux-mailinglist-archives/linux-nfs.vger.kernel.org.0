Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED5726CE8E
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Sep 2020 00:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgIPWSV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Sep 2020 18:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgIPWR5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Sep 2020 18:17:57 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C53C061A2D
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 14:42:48 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id a8so298437ilk.1
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 14:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=bz731S6wZQA+1qpFznGE8eQlmK/fBClUt6HbiD7bfaQ=;
        b=MSu4GEWAvVsiY0wxg9FIYGP/KaWb43SMshTTHFSakZENiuyB6gWKuFi1twj3Th/cSp
         t6kJikL1Cu3ehZtcIxYwDbMb1iwMqRhgJcBdCNDV1nnFrz4+Lat53mq6sYxNQ9ErVEPG
         8VJA/cZAqRDJJxMZfKXU3RKN+IWawB6tTblJ9SJpFWCaqu3O9fVVx6ptlsNzJTcNqi5l
         JO8m4+9pf61km/BziP8+DfmZFLnRxzpCQpzEJFTAlrG36mPLPAFa7c3gTWfo+7mYMgOE
         VtEeuzxahoKi6OQl+W1TJG7qSRGmMNQVFabzGVw9CBKWwMNJ6v9xrbgCiEzF6GY/4gJn
         26bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=bz731S6wZQA+1qpFznGE8eQlmK/fBClUt6HbiD7bfaQ=;
        b=WwGMZ1m4O9roGfd07GXAB+qIBW0P2BsSJa8onGZ3nAP0dMayEJtXiFjamqXNGMBT/9
         pPbN+8MEif4fJR5wgsRTKR1WCAJTPbTN+W+hBde3c/O1JFJt3pSyQHUo2RD77Dxdal5F
         FsogzsATv2SaieR4JjOeg7n2nvyx5kpMtpxJX96WCptni1JuRzb0IbE6iTaWIscO01mZ
         OSLERi0kTQnY2Gtw3i5tX0ejxT6UVdcICSj/Deuc8kb0wbl9OF+j9ATs95kyo3/spL9p
         cwIwfJSSoOu038b0wYm06pbfKVTT7UTNGTFRu5fDSvBopDjyW9Kp72dnRhVuQiCOECK1
         CrhQ==
X-Gm-Message-State: AOAM5300WB+HorhF0SW8bVobprjKda0VziExA5Ct+peX4WTwpvYxtmlg
        w+FKnScJFsW6u8N5gO6WR/s=
X-Google-Smtp-Source: ABdhPJx7biM1+qbPHXeAL5HqSUKghKqFTun1p1ci9kTqYkbhmzp8EIkREKZ2Om3umQzwOGBmtKuXJg==
X-Received: by 2002:a92:c7a2:: with SMTP id f2mr3558811ilk.171.1600292566182;
        Wed, 16 Sep 2020 14:42:46 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id s23sm9776897iol.23.2020.09.16.14.42.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 14:42:45 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08GLgiYl022996;
        Wed, 16 Sep 2020 21:42:44 GMT
Subject: [PATCH RFC 06/21] NFSD: Constify @fh argument of knfsd_fh_hash()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 16 Sep 2020 17:42:44 -0400
Message-ID: <160029256470.29208.12060672647527057465.stgit@klimt.1015granger.net>
In-Reply-To: <160029169954.29208.8757662600714736320.stgit@klimt.1015granger.net>
References: <160029169954.29208.8757662600714736320.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Refactor: Enable knfsd_fh_hash() to be invoked in functions where
the FH is const.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsfh.h |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 56cfbc361561..1a2e28369d04 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -219,15 +219,12 @@ static inline bool fh_fsid_match(struct knfsd_fh *fh1, struct knfsd_fh *fh2)
  * returns a crc32 hash for the filehandle that is compatible with
  * the one displayed by "wireshark".
  */
-
-static inline u32
-knfsd_fh_hash(struct knfsd_fh *fh)
+static inline u32 knfsd_fh_hash(const struct knfsd_fh *fh)
 {
 	return ~crc32_le(0xFFFFFFFF, (unsigned char *)&fh->fh_base, fh->fh_size);
 }
 #else
-static inline u32
-knfsd_fh_hash(struct knfsd_fh *fh)
+static inline u32 knfsd_fh_hash(const struct knfsd_fh *fh)
 {
 	return 0;
 }


