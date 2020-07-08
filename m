Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75AD6219130
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2020 22:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgGHUJp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Jul 2020 16:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgGHUJo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Jul 2020 16:09:44 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C364C061A0B
        for <linux-nfs@vger.kernel.org>; Wed,  8 Jul 2020 13:09:44 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id u8so21086620qvj.12
        for <linux-nfs@vger.kernel.org>; Wed, 08 Jul 2020 13:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=1213wZxKhmsyMRm+QVeXOJ+O7UgsaXihqjng0r/K2tA=;
        b=ZYrHgnDbSK4qRPdyuPBV9pVlK5EYWeFYOmUGTaVi1ZPobrmnkCoWRSIoUUeLPQee2g
         ge4F2fP36p1zioFW3OdsFMRH+ts2j5vnuXGAfaMkrzy6MfLieioj8MlPqUE4+JA8hDzT
         lT8r5B6GCXy/eqBSzki3mZhHy3ILS+zFXEdTgDgsig1RXc6Vh5WJYCOxLVUEVAZJFLoA
         GAQkWmRa9RIJwz6kangsbVqD0I01XxfgvWHLO25yXuZ05ZFWkAhCfwf50IUzyivYZWcY
         gXv7GSIpP82nFGxZaotQ2gdOEJ7SCbJ7WAHjyDIpgeMK/HVRskLr0wh7tlFl1ARhenSd
         UWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=1213wZxKhmsyMRm+QVeXOJ+O7UgsaXihqjng0r/K2tA=;
        b=esXIzPv+KKtYPmM1aZi8upblMX3aaFe7azAG+1QY9cTcFxH94l1ulAl/NFagdhs55z
         ZMYJF6uAVAM5/X2/naTc7QaizW3+H8itYDJbokrm1ZIrh25YztRhj5+gMe7OGj9bHhwf
         6WqKp3lx8CA8sQV74A/aUcmDUtoOLGCnZAyLT8nS9yZzSUBU/IUEg5JKqbL7xkr3AxNi
         r2D/WYFol/qE/9q/zGXDZ3c7XfPwcbh0pIrDk7oqKzAE6MRjFjZgmJEhkFtsJjW9+sNe
         vBfT5egQ/Rk/nQbG5Bodq/Ll91g10mnAuG5r1/xcOuDc/v1r2aUJVejrFhKUQUj/JqNc
         lHDQ==
X-Gm-Message-State: AOAM533M60UjDyoNr7DUSfSoBRA4k2u1UWwcXrZrk2rMqIpAiOt/WBq/
        5KiobW8ldOoYLX+zWUvlp2ZWYkCD
X-Google-Smtp-Source: ABdhPJyC9i2iBT/GMT2LUN7ruZysf6NeDNy15cUXnydlh/DSMn9mznQrwxma0DgQdZ0iA/Lc41nyrg==
X-Received: by 2002:ad4:4112:: with SMTP id i18mr57530860qvp.109.1594238983615;
        Wed, 08 Jul 2020 13:09:43 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id o15sm977310qko.67.2020.07.08.13.09.43
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 13:09:43 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 068K9gnO006087
        for <linux-nfs@vger.kernel.org>; Wed, 8 Jul 2020 20:09:42 GMT
Subject: [PATCH v1 08/22] SUNRPC: Remove dprintk call site in call_start()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 08 Jul 2020 16:09:42 -0400
Message-ID: <20200708200942.22129.88285.stgit@manet.1015granger.net>
In-Reply-To: <20200708200121.22129.92375.stgit@manet.1015granger.net>
References: <20200708200121.22129.92375.stgit@manet.1015granger.net>
User-Agent: StGit/0.22-38-gfb18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: The rpc_rpc_request tracepoint serves the same purpose.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/clnt.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index d8bc47a4a848..533de318fab9 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1635,10 +1635,6 @@ call_start(struct rpc_task *task)
 	int idx = task->tk_msg.rpc_proc->p_statidx;
 
 	trace_rpc_request(task);
-	dprintk("RPC: %5u call_start %s%d proc %s (%s)\n", task->tk_pid,
-			clnt->cl_program->name, clnt->cl_vers,
-			rpc_proc_name(task),
-			(RPC_IS_ASYNC(task) ? "async" : "sync"));
 
 	/* Increment call count (version might not be valid for ping) */
 	if (clnt->cl_program->version[clnt->cl_vers])

