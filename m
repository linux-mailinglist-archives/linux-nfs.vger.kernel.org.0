Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A408B3B4F5E
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Jun 2021 18:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhFZQHx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 26 Jun 2021 12:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhFZQHx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 26 Jun 2021 12:07:53 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA4CC061574
        for <linux-nfs@vger.kernel.org>; Sat, 26 Jun 2021 09:05:29 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id y29so20962488qky.12
        for <linux-nfs@vger.kernel.org>; Sat, 26 Jun 2021 09:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4oX8GPuob12g3IjDgWW4IA+HLL6gV1gMHyu1HgIJxK0=;
        b=LlK5oPG8B/1J/ylnBNOLx8EZWYakVR7mAhvfPe31rrpIwbs0tnfnyViaWkcrlP7Rue
         TjlGfwO1zBukVlYhNqf0cFoBhjyT0zVZ7dWHtfg2u+vi9nCFIeAIbpDN7uXpY5KZms7J
         xadTLgchCBoZ/yXtXW9g8IH/XRW+etiFAwIErYb3yg3R9YiDb1/Xr78bhqVCVcz0r+YB
         f0Hoj7V0h1ZxDMo52PxyhfG6y1H7Ih3wLYv/Yv0Rn/Pj3YfD5AlYpXXoENxD7chvnElw
         q33Q+q6ebsA1vgS+Qn0Uxs+ih4xw04mB1lwIzLoUMgsIg6RwENx8EqrW+H4j8V1IOLUo
         wXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4oX8GPuob12g3IjDgWW4IA+HLL6gV1gMHyu1HgIJxK0=;
        b=CQ2nSARANokrPBFFApZbD8XUELeCvo7CeoJhqP6fA1i/pSK/0iWgRRHcsZQIyltshR
         D5BWdbsGMSUHVk6WU7V6F6Sgbq0jxNKx66muGvd1TeTX0Ic99uEsdn7A2wgeH86qMeIn
         u6hZd4z3HPeECvFnIIWd3VpbM1RbqEKe8NvNXVfh5wQ//+2zWCet9gECcY4NnVIlVM2Z
         Cnw+zO09e5KvnfPtCPzTgpUMj0pOXGR6D0l7OT1I0hZJFC639IW1Wgi+0urLZZYnniR+
         BQLNzs39prZNvbzxB3sk3nJt030ojYHBjMmAkwqLK2YKnSsPHR3+Bn4gMQO2EtaBXJGT
         QuMw==
X-Gm-Message-State: AOAM5323yZs+wYQEYBXKjea1EHNq7XES+1XetTA5L1714cQUPfHkrfWB
        j/0jt/eEeDnJz5BgnYyaWK1a09oRpFpD
X-Google-Smtp-Source: ABdhPJz4bJ5Xz/Lxv2Rh3crjDUePpLWIjoog+uoFERH67A1doat/RruKecqKtIX3fbkzGx/+28M7QA==
X-Received: by 2002:ae9:f510:: with SMTP id o16mr16822763qkg.211.1624723527754;
        Sat, 26 Jun 2021 09:05:27 -0700 (PDT)
Received: from leira.hammer.space (c-68-36-133-222.hsd1.mi.comcast.net. [68.36.133.222])
        by smtp.gmail.com with ESMTPSA id 202sm5797624qki.83.2021.06.26.09.05.27
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jun 2021 09:05:27 -0700 (PDT)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/3] Fix up inode attribute revalidation timeouts
Date:   Sat, 26 Jun 2021 12:05:23 -0400
Message-Id: <20210626160526.323332-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The changes to allow more fine grained revalidation of the inode
attribute cache has had a detrimental effect on the polling timeouts.
The current code assumes that if we've not revalidated all the
attributes in the cache, then we can't advance the polling window.
That's obviously incorrect. What we really want is to ensure that if
we've revalidated the cache by checking the value of the change
attribute against the server value, then we can update the polling
window timer.

Trond Myklebust (3):
  NFS: Fix up inode attribute revalidation timeouts
  NFSv4: Fix handling of non-atomic change attrbute updates
  NFS: Avoid duplicate resets of attribute cache timeouts

 fs/nfs/inode.c    | 57 ++++++++++++++---------------------------------
 fs/nfs/nfs4proc.c | 33 +++++++++++++--------------
 2 files changed, 32 insertions(+), 58 deletions(-)

-- 
2.31.1

