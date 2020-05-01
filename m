Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B691C1BEF
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2020 19:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbgEARhx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 May 2020 13:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729572AbgEARhx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 May 2020 13:37:53 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560F3C061A0C
        for <linux-nfs@vger.kernel.org>; Fri,  1 May 2020 10:37:53 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id v38so5073621qvf.6
        for <linux-nfs@vger.kernel.org>; Fri, 01 May 2020 10:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=w1iUtLJSPCUIGZsawUGcopkfcHeFfCERO+QIffqI47g=;
        b=fYt52uLyomqz+WPeRaXI4ohWZCIi8gJGMS1Y8hqoN6w7P//IozfepiEIR8qRjJj6Kp
         vbGwRYSwjE06Gv5KrGj+tXSUzYO9Ia6UFurPczScwPtBa5H6usz5vTxSWU2S4tjvh2Xx
         YRB8KuMM0LNCqSOnbWNRBbiUUjUqOwjTfDY+dTXmzJs3ILR5f9B22QU/vpRVr3JzLOAJ
         VxK9VqRLoiri8n0D4bzxoTIyH0YI7d09motOoBMyarLH2QHjM3gx9aH0CPGHMWN+VOzf
         apBdzrNQQpyR+XAlrrDDU9ZTpFoWg0dcZL/r6OWl+g+1QVttTdPNM6mVqkeYf5hCcThd
         0pVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=w1iUtLJSPCUIGZsawUGcopkfcHeFfCERO+QIffqI47g=;
        b=CCEjzOupLDqN1RavtyULzNR0gmVQX7+4U+RnzMt6WpGZBB+8+SIYb03m6QPZUCA1zW
         VDNmr21w5FF8RbjeXNgJayzWFb8fZhf0rgXl18gIXtuSIMWB7MgPDSxK5po8Epar3ywh
         fdJodgddUIwPiJj6KBCl7d3nKKKXhGij6TCALQRUvEo5AQ7wuziA79uc5v9orLjtTEgY
         2CF0MAUSsing8ejWs2JBVWd87/5P7h9on99PE++bRdK9GJ/NWoxcclYl3ojQJMHMTkqB
         Al2aVIcHIJpLFPtFVBH2N95vvFZOyhsxtbOXf54TsJeKOTdQtYNy2ieRZbX5lqIoWYwu
         TpDQ==
X-Gm-Message-State: AGi0PuajWBSVeKQH1nxXW+/Vkgn8642hDidNGoH7PefjmSbzgUDxHbeb
        Uu/NL1jElX3c0fDzph2oPIUb8/QZ
X-Google-Smtp-Source: APiQypJQVEsLYrKuothng1OwUJDerQwmghMkKP8XAH7qcAA7XdJKEqJyIO/TFrCWipCTeNOg700bmA==
X-Received: by 2002:a05:6214:bc6:: with SMTP id ff6mr5161473qvb.43.1588354672451;
        Fri, 01 May 2020 10:37:52 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id h13sm3129376qti.32.2020.05.01.10.37.51
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 10:37:51 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 041HboJL026728
        for <linux-nfs@vger.kernel.org>; Fri, 1 May 2020 17:37:50 GMT
Subject: [PATCH v1 1/8] SUNRPC: Remove "#include <trace/events/skb.h>"
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 01 May 2020 13:37:50 -0400
Message-ID: <20200501173750.3868.17508.stgit@klimt.1015granger.net>
In-Reply-To: <20200501173526.3868.96971.stgit@klimt.1015granger.net>
References: <20200501173526.3868.96971.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-20-geafe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: Commit 850cbaddb52d ("udp: use it's own memory accounting
schema") removed the last skb trace event from svcsock.c, so it is
no longer necessary to include trace/events/skb.h.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svcsock.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index cf4bd198c19d..1c4d0aacc531 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -45,7 +45,6 @@
 #include <net/tcp_states.h>
 #include <linux/uaccess.h>
 #include <asm/ioctls.h>
-#include <trace/events/skb.h>
 
 #include <linux/sunrpc/types.h>
 #include <linux/sunrpc/clnt.h>

