Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9DA57FFEB
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Jul 2022 15:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbiGYNcz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Jul 2022 09:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235049AbiGYNcq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Jul 2022 09:32:46 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11567DF7E
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 06:32:42 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id a7so3733688vkl.0
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 06:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p/Ff1Wz8vtr24ZP3FEb7/lynhGvGiAjb8N0JIVBZTnk=;
        b=FVT0kI1gKKCN/nEDvuRsa5Zcw3EY3C+QoaUL1T34hEnTkPdcuFUkkigWIoDhhRYzHQ
         e1Qz/lRRzxQf+3T2wgFDyLWK7rzurXdJzex6QDTTD9r6S0FMqZ7mND+7QhXGz3/JnpwP
         1HcCW7W58KARDwYM1Wt1Ri5/PHg8hYZ5B8vk6bATCiMUokr4EjTEa3i/FTwROHAwbNJe
         HSlbnzs8VCCrns22OjGxPO19IoYLzWw0rfyK07X+Dcw52ysVWPjFyFk2TmpcpkZViXfA
         sGuLz30VH588MqK5S4ZNGM7Nh/y5Pf3umsTnPKWEwUPBJwGRMe3EvXTHVgHmAvbky2gl
         pBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p/Ff1Wz8vtr24ZP3FEb7/lynhGvGiAjb8N0JIVBZTnk=;
        b=McTSbSj6X4cpk58GC+OkaNVSgdqNG8EdHwtFHCaX5lT+PIgCYTeiQpY6j2ay0HSET/
         erN+Vf+pU9+Bv4inczRTWUu1Z9sGcV/jyD1geRySnJsWj6BxKrh4HWYjDlfDzz/LUyyd
         1SKFzuuuhPglRh7vi49NDT+8u1pr8YmWEjVqaXCMP8k4NZTd36mJ5qz41K9D0VIoULV7
         Q4dro5ogW8+QfueDhtOMeEWzSvYGU6kIyA715qUQR9PH0visjsFwn38+G3lDxtJYIdcJ
         TE2y66J4ITTnKCOQGPNjBFZfnutk8CtnW6ciulB9WTzbv8ONgFWQjIfNpwv/dAKn+xwx
         kQuQ==
X-Gm-Message-State: AJIora/goPp2nquIbwwa/PVDyH5QGK7bAX/8eNvym1JIz0KLUmZgHYn0
        5KqjQZzKm18fZmkVXCMIPkVe6lYS0i0=
X-Google-Smtp-Source: AGRyM1s0pxZNREyEaaYRaVCHaiVMDbus0EopmzZftuW19cMw2GJ8BK8Xdi69ZDwi4LlV7/u9akdj5Q==
X-Received: by 2002:a1f:9f92:0:b0:376:3525:998 with SMTP id i140-20020a1f9f92000000b0037635250998mr2458971vke.41.1658755962513;
        Mon, 25 Jul 2022 06:32:42 -0700 (PDT)
Received: from localhost.localdomain (071-047-011-047.res.spectrum.com. [71.47.11.47])
        by smtp.gmail.com with ESMTPSA id a6-20020ab06306000000b00383aeb53100sm2128826uap.16.2022.07.25.06.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 06:32:42 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 07/11] NFSv4.1 remove xprt from xprt_switch if session trunking test fails
Date:   Mon, 25 Jul 2022 09:32:27 -0400
Message-Id: <20220725133231.4279-8-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220725133231.4279-1-olga.kornievskaia@gmail.com>
References: <20220725133231.4279-1-olga.kornievskaia@gmail.com>
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

If we are doing a session trunking test and it fails for the transport,
then remove this transport from the xprt_switch group.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4proc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 3f4e84e9646e..4850e29904e6 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -8922,6 +8922,9 @@ void nfs4_test_session_trunk(struct rpc_clnt *clnt, struct rpc_xprt *xprt,
 
 	if (status == 0)
 		rpc_clnt_xprt_switch_add_xprt(clnt, xprt);
+	else if (rpc_clnt_xprt_switch_has_addr(clnt,
+				(struct sockaddr *)&xprt->addr))
+		rpc_clnt_xprt_switch_remove_xprt(clnt, xprt);
 
 	rpc_put_task(task);
 }
-- 
2.27.0

