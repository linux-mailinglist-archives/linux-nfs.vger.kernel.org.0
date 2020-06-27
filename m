Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B76120C314
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jun 2020 18:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgF0QfC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 27 Jun 2020 12:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgF0QfB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 27 Jun 2020 12:35:01 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4BFC061794;
        Sat, 27 Jun 2020 09:35:01 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id u12so9814543qth.12;
        Sat, 27 Jun 2020 09:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=k9qWgWEKEOvNo1NfXaaylUDklpJhDGDU+W1e9h/Lvgs=;
        b=H9W9lfPFTzpn5cqPbM2Z0RM0VOWdXARPAc8BZnxVqI/eEpVCpxgzxMSCPDGqDeCyaD
         GBcRICDC226dtxJhKdU2jXJ4+5JHZPACZcRD2PByOg5TksznGBfiquP/J5exeKRfIxJ2
         Mrr5UU8NeLXSI08hHMys8hrEyY4veiMgUXcOumAq53aHDyzLt0r/13HJjNHX/WDkDKhD
         6RNAvw/o57HCVfl3dqE8LKFuGfTOW/6mEDeLnXWGnznCaWNSAtGMAo3xsGyl51y1Rb/D
         VDhfDYS0z44eZPw4JfDjkwZuVZAbaqd0ro4OMVVFd4oqVxgvIcJnE8HN+oaR8i+JvwNS
         RM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=k9qWgWEKEOvNo1NfXaaylUDklpJhDGDU+W1e9h/Lvgs=;
        b=jkmcWk7IyD3QjFNomBfZVplFVm67Jjv5rNCl2FT0JLouzYT2bvahAi5Ay98OXVqBkb
         BUSdfI2REs1W9u7lkHl2y7flCjaU7nNzoSqUso6b43s51RcMC+QxnnKwenBbs0BBkgGw
         D/Kh232UqY3okSra2KQS3tte0nN+TFsSHCtGZld+p3o+fspkhipj9byrXCKucEyvOBoe
         hFQV0/oT6GJQofQNnZfoWo5kAXbXhGI1UK3MhIpRwSRIR/HWxetomewEuFW9DB9gncKt
         pB1VN2vHKytjZzpGxSMQZpaKaU9MeH+UGQxrh1m8zYojF6XaTvNQUBFe1EHEghuLFxMM
         1L1A==
X-Gm-Message-State: AOAM530NxwwpLtU+rHxnSr09PDZJAMJbkeXRsHWoI+aXF/hMe3Qr4j0a
        ia2GFYqEpxR/1IA8p4j2NFKIE6EZ
X-Google-Smtp-Source: ABdhPJwFJdbfH7xocLqbTuBLdC8UqibfV/qwQ8KLTyIU0ORN1v0FtjAmNrlkcVLcTyWyQSduYGbP0Q==
X-Received: by 2002:ac8:31a6:: with SMTP id h35mr8309362qte.323.1593275701053;
        Sat, 27 Jun 2020 09:35:01 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id p80sm10937859qke.19.2020.06.27.09.35.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Jun 2020 09:35:00 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 05RGYwqE003755;
        Sat, 27 Jun 2020 16:34:59 GMT
Subject: [PATCH v1 0/4] Fix more issues in new connect logic
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     dan@kernelim.com
Date:   Sat, 27 Jun 2020 12:34:58 -0400
Message-ID: <20200627162911.22826.34426.stgit@manet.1015granger.net>
User-Agent: StGit/0.22-38-gfb18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This series addresses several more flaws in the recent overhaul of
the client's RPC/RDMA connect logic. More testing is called for,
but these are ready for review. They apply on the fixes that were
pulled into Linus' tree yesterday.

See also the "cel-testing" topic branch in my kernel repo:

  git://git.linux-nfs.org/projects/cel/cel-2.6.git

---

Chuck Lever (4):
      xprtrdma: Fix double-free in rpcrdma_ep_create()
      xprtrdma: Fix recursion into rpcrdma_xprt_disconnect()
      xprtrdma: Fix return code from rpcrdma_xprt_connect()
      xprtrdma: Fix handling of connect errors


 net/sunrpc/xprtrdma/transport.c |  5 +++++
 net/sunrpc/xprtrdma/verbs.c     | 28 ++++++++++++++--------------
 2 files changed, 19 insertions(+), 14 deletions(-)

--
Chuck Lever
