Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663532055B6
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2020 17:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732935AbgFWPWy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Jun 2020 11:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732781AbgFWPWy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Jun 2020 11:22:54 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DC6C061573
        for <linux-nfs@vger.kernel.org>; Tue, 23 Jun 2020 08:22:54 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id m81so24103238ioa.1
        for <linux-nfs@vger.kernel.org>; Tue, 23 Jun 2020 08:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WcFQbP/Z4Pe5B/OwrmJk0jCaVCNncNJLas6kvCANqC8=;
        b=FFuk1JpZ31CKfgp9HDeUByYxPRe/Cp9F7uAKvXnHUaINwjujRcJxXxdGsqOVyRIi6F
         MlqqZnpE6AUi+ykne6z+PO68Cr8m9tCb1muRdKr0GGWri1B3HzJ29h3jeynJxDpaMgjv
         C+JROuaLlif8vhXqgKRJbWaOAx24RvPXgHuQeI0E2sFMvW1Cj4nalW1SAYiesZt3ti2y
         2dmsLLL3TVfjOGOz6uqm8EZAHn+TubipEmQCTwxGtLpozu+ep7rNdZH30l0mNCMYN+Lv
         ANbNFTX/0RjawVUOHINZUEtrkIhJ3y5dIHoRBT6PqQb9eSddF+4Gko6YOUQbLni15++p
         165g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WcFQbP/Z4Pe5B/OwrmJk0jCaVCNncNJLas6kvCANqC8=;
        b=fFpmmCBx05aavT2t3lEzzjAlDYzDuVvGms3KGGzLKw2GMRh6PCiR96XUzCcRR1PUxj
         hjuuFXvsVuYP9EcNHkDYZudh7SLmOBntmt6KnU827Xui061Ol3psRorZCl1yMdNxcij5
         ksNQX8KYzrZ2vEe2kls36Oi4gGTvVb6tsHZW92txd/yW9GhqU/65m9A9ULCVXylZim+c
         wID7JK0rhIciBlg7tBGWahSvjSU8lnrf7WT5g+XatBd2AWlUjqnLyM4GUnpJ3e11gkFI
         QBaeG6Ix3TdGpc1XrTJpTTHXlw96v0iKFZkTB05ElH/B1C/7H269P7yxcFEsZHI7tK9Z
         2/Ng==
X-Gm-Message-State: AOAM5321Xjy/oqrAW3MNgnrKoHo5LGAnbTXAQ+PbyO8Y9ks3JhsImrkF
        eADpbkFNdz869udyiQ/yfeq9LxbF
X-Google-Smtp-Source: ABdhPJz6VQhCrRqUL0S9rN2J5GOc+6wA3DqLRNOqC6xzjsXRhWLwx8axGZm5xuuAYo/tEFXZBOh+vw==
X-Received: by 2002:a05:6638:223:: with SMTP id f3mr16423004jaq.144.1592925773103;
        Tue, 23 Jun 2020 08:22:53 -0700 (PDT)
Received: from Olgas-MBP-286.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id n20sm9832487ila.85.2020.06.23.08.22.52
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 23 Jun 2020 08:22:52 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] SUNRPC dont update timeout value on connection reset
Date:   Tue, 23 Jun 2020 11:24:09 -0400
Message-Id: <20200623152409.70257-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Current behaviour: every time a v3 operation is re-sent to the server
we update (double) the timeout. There is no distinction between whether
or not the previous timer had expired before the re-sent happened.

Here's the scenario:
1. Client sends a v3 operation
2. Server RST-s the connection (prior to the timeout) (eg., connection
is immediately reset)
3. Client re-sends a v3 operation but the timeout is now 120sec.

As a result, an application sees 2mins pause before a retry in case
server again does not reply. Where as if a connection reset didn't
change the timeout value, the client would have re-tried (the 3rd
time) after 60secs.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>

--- I have a question with regards to should we also not update the
number of retries when connection is RST-ed? This would allow the
client to still weather a 6mins (60+120+180) of unresponsive server.
After this patch the client can handle only 3mins (60+120) of
unresponsive server after the initial RST ---
---
 net/sunrpc/clnt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index a91d1cd..65517cf 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2405,7 +2405,8 @@ void rpc_force_rebind(struct rpc_clnt *clnt)
 		goto out_exit;
 	}
 	task->tk_action = call_encode;
-	rpc_check_timeout(task);
+	if (status != -ECONNRESET && status != -ECONNABORTED)
+		rpc_check_timeout(task);
 	return;
 out_exit:
 	rpc_call_rpcerror(task, status);
-- 
1.8.3.1

