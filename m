Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13FEB1C1B92
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2020 19:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbgEARWK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 May 2020 13:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729046AbgEARWJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 May 2020 13:22:09 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80257C061A0C
        for <linux-nfs@vger.kernel.org>; Fri,  1 May 2020 10:22:09 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id w29so8462870qtv.3
        for <linux-nfs@vger.kernel.org>; Fri, 01 May 2020 10:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=AQtGKzCzBcvGBUFLvjv8R9YA9GLoumA3ZRJvMwXGlxI=;
        b=Fg0e1cq5srwh/Ok+tqqldTIRp3F3zoHqGgjQhz6YX5B1NDWxeIfxYoTpRcLHLbYDGk
         +gp48BtYmIvq/tq++NvUQ4hTEPdKliLyOc7HJKRWR7VSCOCyruklEYCKvsaufidbRSc/
         Hx3qCEYVFsiDBjwjr5PnSlKZdYAehZ9Of+S8/I8E79eIFMfV4TIh3w6F+L6Kf7kS6iIK
         nBojcG12yR9tdal9x8kvhaw42zuVJeS33S77JGgUuWOvFLeR2gPLI5FVrwnsLyv34vkx
         ypOMbBEkkcZXPKNk3NkIXLfkIAEvqLwqwdU/ss6TjV3OJKtfxlSDEbkXkO2Do78e1MRy
         HaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=AQtGKzCzBcvGBUFLvjv8R9YA9GLoumA3ZRJvMwXGlxI=;
        b=OPjPe3IloHr3UZIS6DH+tGeV0F8TZ8lQdVljw5FVxgoUTgFeD1/91qdyRY8+RBNrV/
         vcPHPNfFWhO2Pvp7yxjAmpE7CewsuOfF65gfPEo4R+H96Tx7l6BH57ANP7xmcli7ZxK3
         CUWlDXS+IL6UKLSM7cUX39lNjJxl/PtXP7YVVesLBBzSJkA6Dfc+a8xpURzbENVXK2td
         5/UzO998NcMRlLZH+rurTcadFPRIYB7MOrUwR3bID4IVu/Cz9yOfNz7cJR0KaZWzmU9y
         eUlNQYpAtdFtMsA4B2lm4VuazCtd4/k/qJLuoEws0kHQ9jGsIo+MQZhpTP2/AFt3TfRC
         IzVw==
X-Gm-Message-State: AGi0PuYOYNYOidQ2L05uIQILpQPfJEQhR638G1vZJwd99bzkXcCh0uy5
        7oDQ9/QHvjkLt+v5vaq5Kkn83N51
X-Google-Smtp-Source: APiQypLmM975yyUL2ZJkFg1/BUrf3QM/r52DMDreob5x7QAJiELoWGkZAnN6RhvFepyUL8DJz1NP7Q==
X-Received: by 2002:ac8:70c8:: with SMTP id g8mr4844062qtp.385.1588353728545;
        Fri, 01 May 2020 10:22:08 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id y18sm3187811qty.41.2020.05.01.10.22.07
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 10:22:07 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 041HM5QS026672
        for <linux-nfs@vger.kernel.org>; Fri, 1 May 2020 17:22:06 GMT
Subject: [PATCH v1 0/4] New NFSD tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 01 May 2020 13:22:05 -0400
Message-ID: <20200501171750.3764.7676.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-20-geafe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

These patches introduce tracepoint infrastructure in several places
in the NFS server in order to help improve operational observability.
They were constructed while chasing down problems I found while
testing v5.7.

---

Chuck Lever (4):
      NFSD: Add tracepoints to NFSD's duplicate reply cache
      NFSD: Add tracepoints to the NFSD state management code
      NFSD: Add tracepoints for monitoring NFSD callbacks
      SUNRPC: Clean up request deferral tracepoints


 fs/nfsd/nfs4callback.c        |  37 +++--
 fs/nfsd/nfs4state.c           |  58 +++----
 fs/nfsd/state.h               |   7 -
 fs/nfsd/trace.h               | 286 ++++++++++++++++++++++++++++++++++
 include/trace/events/sunrpc.h |  11 +-
 net/sunrpc/svc_xprt.c         |  12 +-
 6 files changed, 343 insertions(+), 68 deletions(-)

--
Chuck Lever
