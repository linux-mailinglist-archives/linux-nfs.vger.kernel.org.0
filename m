Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEE457D687
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jul 2022 00:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbiGUWHd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jul 2022 18:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbiGUWHa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jul 2022 18:07:30 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEACB93C2B
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 15:07:29 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id u20so2429630iob.8
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 15:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mcqOOLA/HQO8uLApukS1MK6XhSilmUS6rT32N7eaYwk=;
        b=em8U93eOtslfCHwL4uxUDCysT0SteoyYDges/EbYygTipY0mvXFgIghZjjuP7et+5/
         O6XP0kKkcTc6tyOOrFoo3JAuPnfoRozrnQQiZ6KADvmQWdEh3daEHU26OgXXUKSJmX9S
         JHAwMFq+6G+9e+EAXReDu32oYATlkPFZjx6XFkt7xbAAy1WFsMPfLXSgGHWCK2jyziCg
         jhj9qgKSj749JeO3RB1eOMCnsuVG/Lrww+6zrjYv7NLlWn5IobvbX/EgpV4UJ15iNI7+
         KVrHRoOwogcIznaNG0QutY0u6EJW+U18mfGrnpauzWnQNTnbmlOPZkv/Niy67bFODzca
         mWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mcqOOLA/HQO8uLApukS1MK6XhSilmUS6rT32N7eaYwk=;
        b=UwKNUKlL4w46o2dBZrzMQL57tMwB3nQijXMq+mvm+lwy0r7SBncdMgJnF4VlW0fGq5
         2dBjADCb6jKX/SjRZZBuOy+rWdRGbkaXQUyz1Al7qCLXzSVnirBzA1Cum/x3f+ykm4nA
         8++aKQGFo9OLS1yuRVHOcrQX9PYj705kYnFtdzImJ0ZLCAUIAiprS5hn1jBiSvzdvXxI
         fvB2pw98gehwpZzmCG4JXJL+Yv61CL3P1OS/neBCaoDFKdvP56sIWLr55jauTCDrmDh/
         wsc6wlQnx4GCZcTren/6ZztO4laW2LZbpeznYzXMWu+BXd3ozAPRd9k6soI3mhhwEF5x
         BAlw==
X-Gm-Message-State: AJIora+qY+nlaC4vwY+qJ+yuYD2htoHXFgshinH5l5zbrzNx4JJS0GS6
        hSNTRCzY0VFd1IAaHWba8h0NNPam88c=
X-Google-Smtp-Source: AGRyM1tvFcV+K/UIMAOejDV1dmtrebzyZNzEUsvl2MzZtsafi9VNszGd0LAeiAP33fgm3PnH7g4USQ==
X-Received: by 2002:a05:6638:304a:b0:335:ba01:8be9 with SMTP id u10-20020a056638304a00b00335ba018be9mr282005jak.273.1658441249074;
        Thu, 21 Jul 2022 15:07:29 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id g11-20020a05663811cb00b00341668383cfsm1281105jas.33.2022.07.21.15.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 15:07:28 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 11/11] NFSv4.1 probe offline transports for trunking on session creation
Date:   Thu, 21 Jul 2022 18:07:14 -0400
Message-Id: <20220721220714.22620-12-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220721220714.22620-1-olga.kornievskaia@gmail.com>
References: <20220721220714.22620-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Once the session is established call into the SUNRPC layer to check
if any offlined trunking connections should be re-enabled.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4proc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index b805541f4501..c5f17af9370f 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -9251,6 +9251,13 @@ int nfs4_proc_create_session(struct nfs_client *clp, const struct cred *cred)
 	int status;
 	unsigned *ptr;
 	struct nfs4_session *session = clp->cl_session;
+	struct nfs4_add_xprt_data xprtdata = {
+		.clp = clp,
+	};
+	struct rpc_add_xprt_test rpcdata = {
+		.add_xprt_test = clp->cl_mvops->session_trunk,
+		.data = &xprtdata,
+	};
 
 	dprintk("--> %s clp=%p session=%p\n", __func__, clp, session);
 
@@ -9267,6 +9274,7 @@ int nfs4_proc_create_session(struct nfs_client *clp, const struct cred *cred)
 	ptr = (unsigned *)&session->sess_id.data[0];
 	dprintk("%s client>seqid %d sessionid %u:%u:%u:%u\n", __func__,
 		clp->cl_seqid, ptr[0], ptr[1], ptr[2], ptr[3]);
+	rpc_clnt_probe_trunked_xprts(clp->cl_rpcclient, &rpcdata);
 out:
 	return status;
 }
-- 
2.27.0

