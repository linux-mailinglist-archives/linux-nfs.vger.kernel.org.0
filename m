Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09780734894
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Jun 2023 23:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjFRVca (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 18 Jun 2023 17:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFRVca (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 18 Jun 2023 17:32:30 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB11E1
        for <linux-nfs@vger.kernel.org>; Sun, 18 Jun 2023 14:32:28 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-7747cc8bea0so21091639f.1
        for <linux-nfs@vger.kernel.org>; Sun, 18 Jun 2023 14:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687123948; x=1689715948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FI/kTCZxQ/CJBf5UAJbTWZ0HmRL6NTAZUlbdLIJ+LJI=;
        b=T5URD4KPf8TGJHKnUGV59bMdBSBmVNDdaDyFy39wxzDaRTembEB9W+9iju3pqHIFuD
         Fv1iWFzZQf8bHLSRWsZ2ihF+wFPoeAHrDZRLk4uPZ9hGXOjrkmiTcXzM6P1uQbqmlP7f
         97vZwA6tlidX6KT3HnivfNSCvQj/ht/eNLMAQcRLUYKGII27M56Nr0VP+DNyRNMvlvY8
         J6v9NXnNBflx6K1ccyA/9CZUmPLDyQ3BVfByRYQupGJsT1GiU/P76XSIFglXEvNQM2vg
         9KfwfmZFfN03yRgqCDqQPOsX+VsBiQQQ5YlAct03Q+R2cdjbA9pVdHdb4XQPtjmDLymk
         gkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687123948; x=1689715948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FI/kTCZxQ/CJBf5UAJbTWZ0HmRL6NTAZUlbdLIJ+LJI=;
        b=Q5K3pdR8l2rI75jkCLwrGFIBtoWNo5A26sa0ZY6zaQehpMNnRzUfFEgwgE43Soj5Jo
         HaR88zp2LUlxZztNS+BxtbFhBVgFU8hn13Wsqsh6fAMRl88xu9da5du86wz7LhFIFNwu
         BWgxBNISmelQPXgLVc3F2imobWKay9Y0mj8lh8F3DYZa+TiGSo6b2TCHLqkF3PeNuLzA
         nvyDKdg92iyxw13fZ82gc4n15+tR0/cgxUcDdTjI+R16tA5nNSxdF7IhtrsS6qk4FY6V
         gyTp3uewT88vG8JGRkQbnIYrKTnu6f7NtAVLxz3qDP/vyc+PAxZPfmBOTyAJLqlH1PLD
         HgzA==
X-Gm-Message-State: AC+VfDzyDim/Ys7PCeF7CROFo3J7/SxGh6OIgbt/ESVnr8SOoKSmzbtL
        GbnUcjZmC1lFNLPYwQ1LMhM=
X-Google-Smtp-Source: ACHHUZ5QTEJJ3WKV0pmIaip+xUiJ/eq8xQAnFr4zJsXy7X7gMJ6uHG5p5yf35SzgIXRo4HuARRfbpw==
X-Received: by 2002:a05:6e02:13f1:b0:33b:583d:1273 with SMTP id w17-20020a056e0213f100b0033b583d1273mr5974939ilj.1.1687123947875;
        Sun, 18 Jun 2023 14:32:27 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:c030:1659:acdb:11bd])
        by smtp.gmail.com with ESMTPSA id f27-20020a02cadb000000b00416789bfd70sm7745057jap.1.2023.06.18.14.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 14:32:27 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4.1: freeze the session table upon receiving NFS4ERR_BADSESSION
Date:   Sun, 18 Jun 2023 17:32:25 -0400
Message-Id: <20230618213225.75518-1-olga.kornievskaia@gmail.com>
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

When the client received NFS4ERR_BADSESSION, it schedules recovery
and start the state manager thread which in turn freezes the
session table and does not allow for any new requests to use the
no-longer valid session. However, it is possible that before
the state manager thread runs, a new operation would use the
released slot that received BADSESSION and was therefore not
updated its sequence number. Such re-use of the slot can lead
the application errors.

Fixes: 5c441544f045 ("NFSv4.x: Handle bad/dead sessions correctly in nfs41_sequence_process()")
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4proc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index d3665390c4cb..9faba2dac11d 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -921,6 +921,7 @@ static int nfs41_sequence_process(struct rpc_task *task,
 out_noaction:
 	return ret;
 session_recover:
+	set_bit(NFS4_SLOT_TBL_DRAINING, &session->fc_slot_table.slot_tbl_state);
 	nfs4_schedule_session_recovery(session, status);
 	dprintk("%s ERROR: %d Reset session\n", __func__, status);
 	nfs41_sequence_free_slot(res);
-- 
2.39.1

