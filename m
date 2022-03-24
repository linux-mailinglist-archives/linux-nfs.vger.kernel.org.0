Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144224E656D
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Mar 2022 15:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351088AbiCXOkT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Mar 2022 10:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239059AbiCXOkT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Mar 2022 10:40:19 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613BB3123E
        for <linux-nfs@vger.kernel.org>; Thu, 24 Mar 2022 07:38:46 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id t7so3963545qta.10
        for <linux-nfs@vger.kernel.org>; Thu, 24 Mar 2022 07:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sk3QurrMsz70+It6YO/70JAbSzrk6zaMxnnkXSCRE8A=;
        b=EH6ZCVzSA7UgX3z5mm12rfUJzFRZggo8JWMSEnY5fayt95Zn0hHdF535v1uTe33lOP
         47TJVszYVVTKdpTpChzpjIK42ExSBGME5dHALxkt2CTOMyTB7dts2UnsXREk7WaaMyOl
         zKqwnmkXcvW+QeitMToc8LPo57xa0+nBE0U4CsKYkbkc73VRrR0qeAW91n9NgpN9VUG/
         UGa5Wnr95okOnZasM6YWfh645FPoOeYz/Ij+Q1SG9HlfcZjagiJc2dG/p8z/35uS/0zq
         MAmcJ/c93PJHq8GASbbBJjOWrI9rjZV8dt22ukjlKmcrtCRjPM6Al9W74ik5lI01fZTA
         icsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sk3QurrMsz70+It6YO/70JAbSzrk6zaMxnnkXSCRE8A=;
        b=lOFX+H1Y0L68vICLUTU7OqyNt0aZG25e06kSOrYBeXYMGvtZZhrq+QbqSe2+WTlLwE
         j7Me9psaZRCmmgp3iz6Wt0KFBIcZ7vl+Db5wqseEeOUrQV9ORxsB2E6ZdBRhnyDEud8n
         8mNgeq1QFTJRKvV0lxaRmQ2cd0jb/Ssak0WZ7+oHt83AByGZfj5iCqdpvCCaobOtmr6h
         e0kHauxFlTzjJdZggXuJu0OIiEVByWNVU85oZjZRTJTpneQtapFEPMOT8XUESJ2wFuWW
         mAe5Wg7IZu6z4fgGnBnrhrWDECEf2eSI0EKkOauvvrftDVXLCTnTtc1V5oPqXODGrFsh
         m38w==
X-Gm-Message-State: AOAM5335FEZqw7mnDZEwR6TlomLXjToWi5oew8mRcEjjQf5PzYTr9bnr
        PrjKAtOyF1QTMIF4nLpwy8NCka4zf9M=
X-Google-Smtp-Source: ABdhPJyR1YacSzW1xelZEwBTFgJC2IYHNWybiZDOELDrtJiPeITJ/4nsfuBZ1eTyJXnsL3K53zsnpg==
X-Received: by 2002:a05:622a:1b86:b0:2e2:1e80:ed52 with SMTP id bp6-20020a05622a1b8600b002e21e80ed52mr4778728qtb.95.1648132725437;
        Thu, 24 Mar 2022 07:38:45 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-25.netapp.com. [216.240.30.25])
        by smtp.gmail.com with ESMTPSA id az9-20020a05620a170900b00680aeaac936sm69338qkb.136.2022.03.24.07.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 07:38:44 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4.1: don't retry BIND_CONN_TO_SESSION on session error
Date:   Thu, 24 Mar 2022 10:38:42 -0400
Message-Id: <20220324143842.63955-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
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

From: Olga Kornievskaia <kolga@netapp.com>

There is no reason to retry the operation if a session error had
occurred in such case result structure isn't filled out.

Fixes: dff58530c4ca ("NFSv4.1: fix handling of backchannel binding in BIND_CONN_TO_SESSION")
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4proc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index dd7a4c2a3f05..e3f5b380cefe 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -8340,6 +8340,7 @@ nfs4_bind_one_conn_to_session_done(struct rpc_task *task, void *calldata)
 	case -NFS4ERR_DEADSESSION:
 		nfs4_schedule_session_recovery(clp->cl_session,
 				task->tk_status);
+		return;
 	}
 	if (args->dir == NFS4_CDFC4_FORE_OR_BOTH &&
 			res->dir != NFS4_CDFS4_BOTH) {
-- 
2.27.0

