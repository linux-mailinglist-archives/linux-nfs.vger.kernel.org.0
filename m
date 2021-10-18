Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE60432978
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Oct 2021 00:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbhJRWFf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Oct 2021 18:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhJRWFf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Oct 2021 18:05:35 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40786C06161C
        for <linux-nfs@vger.kernel.org>; Mon, 18 Oct 2021 15:03:23 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id g20so4408649qka.1
        for <linux-nfs@vger.kernel.org>; Mon, 18 Oct 2021 15:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2XUstj3vwySnABTL/Qxok9FVYNph3/vv2M2mNk8LhS0=;
        b=Z1+bX92cytW7I1BrGNBG7oRNjgsWiWetWnzx8WE77X0/J2crv2S+NgvFuXg48WYNkw
         F2TPgSJYC3uPhqqmyVKI08b1qmfGSpTxfw4jqTkhFmpY5XCpq38xjR8jlxOJ1/0vGX+l
         EQM9k/V4glv4TBa7lAm4IpsLqlACy2+yj6e4cpzLR9VMMPxDFJAB42auSty+NwycgpMr
         L/BaAx8V8HzVQYzo0+XxEyAyTN5637sQxkI925lp+BubDhzApov7RSURndW448n8fLsT
         fXuzH6aIo3mV5IHEkAYiuc+fok2UFfHjp9lF2LJHK5vtLDaK9G7R5uSARd14pu11UQJn
         OkAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2XUstj3vwySnABTL/Qxok9FVYNph3/vv2M2mNk8LhS0=;
        b=3cYB8MM05VrTqu2P2VVQYIhGJ9EOR5AA/Z0ZEXPy+JkW985ICa0LWPI7RLL7uyVRcZ
         BCbjD03Lj9CBMY41g15CUm9nuCXQ+P4eNtz59CG/qGTmcKaqR4AsiOeJOop9m+jP16QS
         gOvZ5hQkstudSEYxvBsfIGl/H7RsV4FszQcqe0ZkBd7+oYiY9oagOENIQ/MvcrLgWTEI
         vvdaigv+0IAR54Aj2lrye//P5q4MzUqc4/pWV7D7XrRYtglXIFTOJWTUXDqsDPn2Pwvc
         gc9OD7BEPnggDWFWNOhHDgYqG0KlzS6K7/ADmHl/NB7EKVYQtm9PJJlyCPDNSkeMl42+
         M4+g==
X-Gm-Message-State: AOAM533Hjwzxp5bjlPmEXL0w+qeZ/gfC3uK5bkzvs16KPRzW3M0bz4eH
        PDExXWLaGbZqwLKUOl4bwJ4=
X-Google-Smtp-Source: ABdhPJzMkHAvO2QuvckZzUNMjmbxkxLqbtsYecVLMD0yGg2XXokYcv9NYYRXmP1nr/rfbVQ2lXxhkg==
X-Received: by 2002:a05:620a:24ce:: with SMTP id m14mr23651511qkn.212.1634594602426;
        Mon, 18 Oct 2021 15:03:22 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com ([2600:1700:6a10:2e90:e54f:15fc:f79a:2b96])
        by smtp.gmail.com with ESMTPSA id az14sm3352640qkb.125.2021.10.18.15.03.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Oct 2021 15:03:21 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/7] NFSv4.2 add tracepoints to sparse files and copy
Date:   Mon, 18 Oct 2021 18:03:07 -0400
Message-Id: <20211018220314.85115-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Olga Kornievskaia (7):
  NFSv4.2 add tracepoint to SEEK
  NFSv4.2 add tracepoints to FALLOCATE and DEALLOCATE
  NFSv4.2 add tracepoint to COPY
  NFSv4.2 add tracepoint to CLONE
  NFSv4.2 add tracepoint to CB_OFFLOAD
  NFSv4.2 add tracepoint to COPY_NOTIFY
  NFSv4.2 add tracepoint to OFFLOAD_CANCEL

 fs/nfs/callback_proc.c |   3 +
 fs/nfs/nfs42proc.c     |   9 +
 fs/nfs/nfs4trace.h     | 429 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 441 insertions(+)

-- 
2.27.0

