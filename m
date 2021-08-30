Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70AE73FBA6A
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Aug 2021 18:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237774AbhH3QyB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Aug 2021 12:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237319AbhH3Qx7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Aug 2021 12:53:59 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746F8C061575
        for <linux-nfs@vger.kernel.org>; Mon, 30 Aug 2021 09:53:05 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id i13so16810982ilm.4
        for <linux-nfs@vger.kernel.org>; Mon, 30 Aug 2021 09:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4zHRSRelsuk6nzy8XdO4J0dCV8iUpty/XRmCQFF0mvg=;
        b=LSTXWuhyfc/1P+KsYYRb+Fju6QY5g3ug+i62CsqqGWXYyfZRrdka1oFAMRBakGdOfd
         vgktmOUUPgAzMAN3bYnX027XCRloxFHWDHHw+yHCQ9tTjllK8SmT366H1hltMn9LDylB
         pP+91u/XnaZJQtG1s5ktY50W4VIiSJupz0PtXpchT8SGCEU3CY+xF7ZfIAQmNpIu/1gO
         pH9fKDW+oFgioJvYL6471Yg8qceigg0mPlUSkfgB1RfBBSpnwgJG4R8D1yPwmrl9lpmH
         o9gTQkglynBB/Lm5YhQ1gbs2ulFmiFvHSKtl/CH3DB1cfs21qEv8FLt8t4t0vPTs/FMj
         jrHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4zHRSRelsuk6nzy8XdO4J0dCV8iUpty/XRmCQFF0mvg=;
        b=NEr2JeVXLR2kNblJ4paG9EAkFnPenx6SVG9KaB68tXugvK1TutNPxJQqZ2H97Fl/1e
         EqaOtOHMph81TTl+SUhufxJzXrpI5NUm2/dWSPCzLQRg8ib9aYiTtRGnZ/g7LuVrUBXV
         fxc7z+YSqtyC1vkYNuNEXHehLp6svB4OHltO61ISyg90paOz9Cc46OJFYr8a0BsYveQf
         /edOJgAvqwRMxbvJs+SGfJQi4vjggxj5snG6iMMRSj/kThjEI8Q/6L4nGVzL7K54JVhr
         22aT7SOjB3izbclsG03ObWgizMdYTYLe06pOeRq2JvatwE+Fe82n4YX2Ydt3o0cRsb5U
         6TQw==
X-Gm-Message-State: AOAM531D5txhbIIDu0Ns3sIV7NAljHOwZQ6P62yF6zDWVLqIugZFMpDH
        XH26hX92hAokkgHBAY82GuA=
X-Google-Smtp-Source: ABdhPJysfIreP+rpGbzt1ZKbRX5aXwF8f3HX252L9Nurvk5Df9EX3XKK6XnZSeuDVKaK5HD3lwc1Sg==
X-Received: by 2002:a92:da0c:: with SMTP id z12mr16665775ilm.205.1630342384779;
        Mon, 30 Aug 2021 09:53:04 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:852f:17ae:ef64:bc7])
        by smtp.gmail.com with ESMTPSA id j13sm8579841ile.85.2021.08.30.09.53.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Aug 2021 09:53:04 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        chuck.level@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [RFC 0/2] revisit RMDA XDR padding management
Date:   Mon, 30 Aug 2021 12:53:00 -0400
Message-Id: <20210830165302.60225-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

We have previously revisited how XDR padding management was done
for the RDMA read chunks.

This patch series attempts to do the same for the RDMA read chunks
and altogether remove the options of doing an implicit roundup.

According to the RFC 8166 client "SHOULD NOT" include additional
space for XDR roundup padding. Furthermore, server MUST NOT write
XDR padding into the a write chunk. Given those two statement and
a patch "NFS: Always provide aligned buffers to the RPC read layers",
there is no reason for the client to look at the tail and assume
there is any padding data for which it needs to allocate space for.

The only operation that this patch series effects is an NFS read.
All non-read ops that might use a write chunk are setup to use
reply chunk if reply is larger than inline threshold, not a write
chunk.



*** SUBJECT HERE ***

*** BLURB HERE ***

Olga Kornievskaia (2):
  xprtrdma: xdr pad optimization revisted again
  xprtrdma: remove re_implicit_roundup xprt_rdma_pad_optimize

 net/sunrpc/xprtrdma/rpc_rdma.c  | 15 ---------------
 net/sunrpc/xprtrdma/transport.c |  8 --------
 net/sunrpc/xprtrdma/verbs.c     |  2 --
 net/sunrpc/xprtrdma/xprt_rdma.h |  6 ------
 4 files changed, 31 deletions(-)

-- 
2.27.0

