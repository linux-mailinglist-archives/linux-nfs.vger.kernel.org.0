Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A613738831
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jun 2023 16:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbjFUO6k (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 21 Jun 2023 10:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjFUO6W (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 21 Jun 2023 10:58:22 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE5B10F6;
        Wed, 21 Jun 2023 07:53:12 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-311275efaf8so4527992f8f.3;
        Wed, 21 Jun 2023 07:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687359127; x=1689951127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nj5cySb2awZPbswPCNNrPFPrMSOToZs+lxCLhtLnxqM=;
        b=DMa7o4JaZ3/A/B2OwM3xP/l22yEiaNsiWTcFljxXyczYLHnD7n6oveG919mNB6P5Ic
         J/paTf0iLdK++ldFKS+gJZE4YNXEPZEOIoqe0yjla7DaZyWRxEPPJfDnN1lRkLbQrfak
         uCdxqkcbqLTAsit60EO349s5wO5eHVorsH5DxrpXRaMChXzkibD/hGO3gf7dE2VwwUiG
         VU5L9+OXbjkLeiWzWgdPyYjp1JQay3ZmdKxriGJ9sBcQjusqWR69J1NMV2651ZiAVMys
         k8DVl0fOt7VuodMjyRCYyB6CkBdyY2oY63nAz45rg0hLtSpWe6waOnkijxhuDAYe0n+1
         2Umg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687359127; x=1689951127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nj5cySb2awZPbswPCNNrPFPrMSOToZs+lxCLhtLnxqM=;
        b=JlUye1GzfVsAWiPMXoN75uAhr9E2FaOMZvl5FaolCciv9/i2N8BccNMjmNOwBwtqPv
         GaiFm3hqgp+fUwDFxaMJjsOgAAa+zRuyRbqnG8PayekXypBz4MZhzJki8VLdf1EGyQJM
         IWh6/8yhzD8TOcsJJ5HdSqbUM/ZKT16CjeickRpvxlIuqmbU21/gyUu8+myIKoRPMCm7
         1Jrc+r+UquKXFie2y3J2z4ZY+V+3X9s4xSv23M1DTI3n8emvGD3wEYnU7hr7C0LwbDuC
         LFIBWzMcjH8EfhRuXWI2W9cXKD9HSPM/Zv+XslRMdfZVVJAZr1sC7EgqVBPnyqJMcwgH
         GHFg==
X-Gm-Message-State: AC+VfDxiynVljeCj0SGjc26n0U2a2viX4LQPjmNzm6ttKPgowrVwDVgN
        bNZkGUGB9uaSshZaoFv0dzY=
X-Google-Smtp-Source: ACHHUZ4YmDMSzS0Vs/a7yJ8iIQ19cw27PfgVtfXVBRdE2ItLgg6hz6Upx31NjdP6uDgaLzNxVIr80A==
X-Received: by 2002:adf:e88b:0:b0:30e:3e6f:3682 with SMTP id d11-20020adfe88b000000b0030e3e6f3682mr10488981wrm.5.1687359127129;
        Wed, 21 Jun 2023 07:52:07 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id a7-20020adfed07000000b003112ab916cdsm4668998wro.73.2023.06.21.07.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 07:52:06 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] nfsd: remove redundant assignments to variable len
Date:   Wed, 21 Jun 2023 15:52:05 +0100
Message-Id: <20230621145205.2682584-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

There are a few assignments to variable len where the value is not
being read and so the assignments are redundant and can be removed.
In one case, the variable len can be removed completely. Cleans up
4 clang scan warnings of the form:

fs/nfsd/export.c:100:7: warning: Although the value stored to 'len'
is used in the enclosing expression, the value is never actually
read from 'len' [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/nfsd/export.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index ae85257b4238..11a0eaa2f914 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -97,7 +97,7 @@ static int expkey_parse(struct cache_detail *cd, char *mesg, int mlen)
 		goto out;
 
 	err = -EINVAL;
-	if ((len=qword_get(&mesg, buf, PAGE_SIZE)) <= 0)
+	if (qword_get(&mesg, buf, PAGE_SIZE) <= 0)
 		goto out;
 
 	err = -ENOENT;
@@ -107,7 +107,7 @@ static int expkey_parse(struct cache_detail *cd, char *mesg, int mlen)
 	dprintk("found domain %s\n", buf);
 
 	err = -EINVAL;
-	if ((len=qword_get(&mesg, buf, PAGE_SIZE)) <= 0)
+	if (qword_get(&mesg, buf, PAGE_SIZE) <= 0)
 		goto out;
 	fsidtype = simple_strtoul(buf, &ep, 10);
 	if (*ep)
@@ -593,7 +593,6 @@ static int svc_export_parse(struct cache_detail *cd, char *mesg, int mlen)
 {
 	/* client path expiry [flags anonuid anongid fsid] */
 	char *buf;
-	int len;
 	int err;
 	struct auth_domain *dom = NULL;
 	struct svc_export exp = {}, *expp;
@@ -609,8 +608,7 @@ static int svc_export_parse(struct cache_detail *cd, char *mesg, int mlen)
 
 	/* client */
 	err = -EINVAL;
-	len = qword_get(&mesg, buf, PAGE_SIZE);
-	if (len <= 0)
+	if (qword_get(&mesg, buf, PAGE_SIZE) <= 0)
 		goto out;
 
 	err = -ENOENT;
@@ -620,7 +618,7 @@ static int svc_export_parse(struct cache_detail *cd, char *mesg, int mlen)
 
 	/* path */
 	err = -EINVAL;
-	if ((len = qword_get(&mesg, buf, PAGE_SIZE)) <= 0)
+	if (qword_get(&mesg, buf, PAGE_SIZE) <= 0)
 		goto out1;
 
 	err = kern_path(buf, 0, &exp.ex_path);
@@ -665,7 +663,7 @@ static int svc_export_parse(struct cache_detail *cd, char *mesg, int mlen)
 			goto out3;
 		exp.ex_fsid = an_int;
 
-		while ((len = qword_get(&mesg, buf, PAGE_SIZE)) > 0) {
+		while (qword_get(&mesg, buf, PAGE_SIZE) > 0) {
 			if (strcmp(buf, "fsloc") == 0)
 				err = fsloc_parse(&mesg, buf, &exp.ex_fslocs);
 			else if (strcmp(buf, "uuid") == 0)
-- 
2.39.2

