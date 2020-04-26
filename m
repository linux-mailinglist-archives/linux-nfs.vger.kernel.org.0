Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0BA1B912D
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Apr 2020 17:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgDZP3x (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 26 Apr 2020 11:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgDZP3x (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 26 Apr 2020 11:29:53 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA70C061A0F
        for <linux-nfs@vger.kernel.org>; Sun, 26 Apr 2020 08:29:53 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id o135so3080146qke.6
        for <linux-nfs@vger.kernel.org>; Sun, 26 Apr 2020 08:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Sm9AMurxgZGRtcbD/4OMN+PDtVPTsNCZnUc7i4eDI10=;
        b=rI5XSa9DHZ+CfKG+dQ16eeSk/CuL4qtSLRBBVwXvK8/FvCEmk0gNwjNGjnt+KA1bNt
         SikU9GwopG86zWdaj6jEcpr28+6bQcEtxaZ7RZ88qVCHZSn2ChzfI6YvoiJrU8KvHrLc
         vrJ7Y4IryYWDkerWq8UWWbmJfS+WjWYzMDId7urq4Z3j/43VNmn4NsF9Chidx9wHCVKM
         n/DKRwE4oBFKFz1kdEdYMhA2CqzIJf0+47vIlpxB0PzWcyJ9y5ipxZ0uKN6h/d9mJhbi
         1ALOfUZDhHVkiHhosnUcTf8UoMoU75rPSuUAP58wCXwRGuaQrT5lLPQclrBGKHjVmWE6
         NWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Sm9AMurxgZGRtcbD/4OMN+PDtVPTsNCZnUc7i4eDI10=;
        b=b3rNG+EGC7SIDGD9JoNuA53ScMP/QTvHCP1qDcvIZe216qlWLjA9p4I1gueIBbdbIa
         IVsKCVMOFKmFDJQgGP8VeUQMQ89ehzmHwlrESdidxHwrQa9J9gebm4rtQ/mAv1atuhWF
         xRZ7+Ap3lnD5F8IcKijaoWuRAJwfvEYMn2kPBzFJExxtxa8LOVlTpZNzcRlEzq6XhCDA
         4MTr/RBwEkw1CV3xT2t3m080vR43qirV2WL+AwGRfIpFEVOCXX9V11M3IHIMYfsBikkw
         bJsDkb3dtkPZ02pZ9LU+BGBy6pd4w90Rc5QHgZnoBnvdHv97lUIGOQ2m9Ga9W6NKpbbX
         7g8Q==
X-Gm-Message-State: AGi0Pua8wDTte1MW5nwflrfOICVGrDHuff0Y6JoJZkZwSe8PUsNmzEAx
        nvPfkAzFf/+feZ6BoQ9D90EVase3
X-Google-Smtp-Source: APiQypL5LC1/0r/8hCUw8WUPPNRvl71w+oOGOa6D4X9z19KjwVrSn4+fPdKfqn/YYE4BuM8YClnkUg==
X-Received: by 2002:a37:7143:: with SMTP id m64mr18710438qkc.215.1587914992098;
        Sun, 26 Apr 2020 08:29:52 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id c69sm7503660qkg.104.2020.04.26.08.29.50
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 26 Apr 2020 08:29:51 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4.1 fix rpc_call_done assignment for BIND_CONN_TO_SESSION
Date:   Sun, 26 Apr 2020 11:30:00 -0400
Message-Id: <20200426153000.31931-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Fixes: 02a95dee8 ("NFS add callback_ops to nfs4_proc_bind_conn_to_session_callback")
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 7e7c24e..c3c6bc6 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7909,7 +7909,7 @@ static int nfs4_check_cl_exchange_flags(u32 flags)
 }
 
 static const struct rpc_call_ops nfs4_bind_one_conn_to_session_ops = {
-	.rpc_call_done =  &nfs4_bind_one_conn_to_session_done,
+	.rpc_call_done =  nfs4_bind_one_conn_to_session_done,
 };
 
 /*
-- 
1.8.3.1

