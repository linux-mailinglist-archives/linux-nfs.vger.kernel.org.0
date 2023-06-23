Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B8073C211
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jun 2023 23:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbjFWVJn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Jun 2023 17:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbjFWVJm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 23 Jun 2023 17:09:42 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926E483;
        Fri, 23 Jun 2023 14:09:40 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-40082859ef7so10591971cf.2;
        Fri, 23 Jun 2023 14:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687554579; x=1690146579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=0IRfzdsPREExmTFRCdstQ25nFnB2H002ePSFXfYff2I=;
        b=W43a0E6kfDK1mqgqp7b9fvpxG8De5ehOat9sWfgRLFyoZfj/LCb+GYYfoDfs0nipky
         rACeeU+YWgzND33s9WpepQzJpiL8a0d9SILFT384eXA4iqN4aGFeir5dhc0JWKF7s5H7
         CxK1ks1aq7Mrzy81wPDX89rczK8IQKpIAgkslfEHADrU4td/Oui3HMu8CJzMV0kcQsOf
         S9BhKqTJPuVhrCtSyG8Pq+dbjDD4LGef3wseoG1vRv0nNdmunelzmco4VlHO1rE31Zo+
         m4SN6BCozypW/XDRZQphvapVmesKmd85ZZO/tEowFDxmALnj+qGgEYQuLW69tKCj99Ri
         PMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687554579; x=1690146579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0IRfzdsPREExmTFRCdstQ25nFnB2H002ePSFXfYff2I=;
        b=QQdWlbnbcHgNdFIvIOmvsdEf55BNqyEMJLUVHz2M7bTWaUhzrc1RbCrfTknAfUiI1W
         4j8r3BWfGiOyUnon/EOIyRCJqogfhKzX356HxU3itkI3UrnZEU1NSPy5WATfGKDXsgyq
         WGyYB813/pYJM4+Y6mgIQIntx1FUcAUWFoeVrVTb7TaKWVvAdXxk9LiIMloMyha+VA8H
         IXb00d6KY0lesfAa/iEV4SPBIEVpPD3xggo6jL6c9TpoEyYcuKQekF2swcI1gwvzDbWr
         3VOGFqfEGIrc702sgdnZz29oJeahVvN3voWOmVmIjSlkQqDKXjOrZF2KCRhrLvtrB210
         3sfA==
X-Gm-Message-State: AC+VfDw3C29CMJjU0wzznz9vhiorM6losF1y1G1gjH+6wnVf8lns09q+
        4v5MrvynJb0mJ0R87E1DiAQTHUJHM0ZhZQ==
X-Google-Smtp-Source: ACHHUZ5X+OYGUe1o3a+gwaYBoQylve9a03x/VB9MreD23PK1dfkfJcMiR4yd72tlJCEGngrhEN8aPQ==
X-Received: by 2002:ac8:5756:0:b0:3f6:c392:93ee with SMTP id 22-20020ac85756000000b003f6c39293eemr30127529qtx.42.1687554579482;
        Fri, 23 Jun 2023 14:09:39 -0700 (PDT)
Received: from tachyon.tail92c87.ts.net ([192.159.180.233])
        by smtp.gmail.com with ESMTPSA id bp20-20020a05622a1b9400b003ff251b17c8sm5256522qtb.10.2023.06.23.14.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 14:09:39 -0700 (PDT)
Sender: Tavian Barnes <tavianator@gmail.com>
From:   tavianator@tavianator.com
To:     linux-nfs@vger.kernel.org
Cc:     Tavian Barnes <tavianator@tavianator.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ondrej Valousek <ondrej.valousek.xm@renesas.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs/nfsd: Fix creation time serialization order
Date:   Fri, 23 Jun 2023 17:09:06 -0400
Message-ID: <4154eb6503988c2096f5d30af26d06863fb5d973.1687554467.git.tavianator@tavianator.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Tavian Barnes <tavianator@tavianator.com>

In nfsd4_encode_fattr(), TIME_CREATE was being written out after all
other times.  However, they should be written out in an order that
matches the bit flags in bmval1, which in this case are

    #define FATTR4_WORD1_TIME_ACCESS        (1UL << 15)
    #define FATTR4_WORD1_TIME_CREATE        (1UL << 18)
    #define FATTR4_WORD1_TIME_DELTA         (1UL << 19)
    #define FATTR4_WORD1_TIME_METADATA      (1UL << 20)
    #define FATTR4_WORD1_TIME_MODIFY        (1UL << 21)

so TIME_CREATE should come second.

I noticed this on a FreeBSD NFSv4.2 client, which supports creation
times.  On this client, file times were weirdly permuted.  With this
patch applied on the server, times looked normal on the client.

Fixes: e377a3e698fb ("nfsd: Add support for the birth time attribute")
Link: https://unix.stackexchange.com/q/749605/56202
Signed-off-by: Tavian Barnes <tavianator@tavianator.com>
---
 fs/nfsd/nfs4xdr.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 76db2fe29624..3037c5b0623e 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3354,6 +3354,13 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		p = xdr_encode_hyper(p, (s64)stat.atime.tv_sec);
 		*p++ = cpu_to_be32(stat.atime.tv_nsec);
 	}
+	if (bmval1 & FATTR4_WORD1_TIME_CREATE) {
+		p = xdr_reserve_space(xdr, 12);
+		if (!p)
+			goto out_resource;
+		p = xdr_encode_hyper(p, (s64)stat.btime.tv_sec);
+		*p++ = cpu_to_be32(stat.btime.tv_nsec);
+	}
 	if (bmval1 & FATTR4_WORD1_TIME_DELTA) {
 		p = xdr_reserve_space(xdr, 12);
 		if (!p)
@@ -3374,13 +3381,6 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		p = xdr_encode_hyper(p, (s64)stat.mtime.tv_sec);
 		*p++ = cpu_to_be32(stat.mtime.tv_nsec);
 	}
-	if (bmval1 & FATTR4_WORD1_TIME_CREATE) {
-		p = xdr_reserve_space(xdr, 12);
-		if (!p)
-			goto out_resource;
-		p = xdr_encode_hyper(p, (s64)stat.btime.tv_sec);
-		*p++ = cpu_to_be32(stat.btime.tv_nsec);
-	}
 	if (bmval1 & FATTR4_WORD1_MOUNTED_ON_FILEID) {
 		u64 ino = stat.ino;
 
-- 
2.41.0

