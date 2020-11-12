Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6742B0800
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Nov 2020 16:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbgKLPBE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Nov 2020 10:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbgKLPBD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Nov 2020 10:01:03 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34C9C0613D1
        for <linux-nfs@vger.kernel.org>; Thu, 12 Nov 2020 07:01:03 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id i12so4148868qtj.0
        for <linux-nfs@vger.kernel.org>; Thu, 12 Nov 2020 07:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=n/xC1jq6uqJ9mWF3zLJagXpp/H6o4d8vxPz82Pni4IU=;
        b=XAru2HOffhhJ/SkY7TDHb/mOIWcvzKdZYRdr29N0/Iq35jkOy8QazgUhkE2Z6lWGLW
         FSi5sa3msxS3ga9UdSW6ycMBby6ebFrlTBehXqgK9pf4TnL7842X3cFhiJGdj8BNFN5F
         YVDThbPjFP1yrbl6Rta7+PUoRTa71LNCswMOWJOhmRD4HDirrXqgetj5kii1jg1Kq4+n
         YXFMpW80Nc5qy7OE798p4HVgsRKvZvoS1yYQFCavW4TIdjF8buE4qpDSL0bMTOjRBbuD
         pLK27nBerx09Znpi7RGXOI9QGp1f5UgFuyAju2Rk/uGOug2IQ7DqQNXVLLbCfNkNLJiB
         lThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=n/xC1jq6uqJ9mWF3zLJagXpp/H6o4d8vxPz82Pni4IU=;
        b=XeCDDYwN7vB0pt/dVbeUa0K7Ms9ynHZe3gnE416Si++eLpBfNGJwTmELMIG/nBM7Qj
         lvdmD+IXROeGe1GMphJaBv/dEdiyEiJcHN8uoPxq8wqcb7zKFv//KDCs5pbaEnNC6tyS
         PjM4zycpkShdaKOF/ySTNQV3zhmum3FiujtwJeuuxSW1yLN5t7F2+W4KD+/FTflrauO9
         n2YEUFmZqn6Vr9Rz4OlchTI9+EX+NyIh7QVRxd1uMB9inn5y0xlDJzJ88+EdjWogynZ2
         Qtp9hlrRfAQaGZvbhiez23T+Tjn6TskKECrPml0fkaplgiWeQt8zlM+l4e0ohUbEBgqG
         BltQ==
X-Gm-Message-State: AOAM531WdUDKVlOqywgd6LVIoTi1MokK4vUJxfd2FybhqnVtKiWJVn4n
        w1BwmScAG2CaXceMxcKMbClSDk2gY9U=
X-Google-Smtp-Source: ABdhPJyK6uLdR1+P3WGjayFvz8wWYuW5n3KYhuiowj4a8qNUOnZzrZUQ6KcDinC7y6NUBeeyvx03Rg==
X-Received: by 2002:aed:2c45:: with SMTP id f63mr29583033qtd.301.1605193257870;
        Thu, 12 Nov 2020 07:00:57 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id o1sm4809993qkm.102.2020.11.12.07.00.56
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2020 07:00:57 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ACF0t27029780
        for <linux-nfs@vger.kernel.org>; Thu, 12 Nov 2020 15:00:56 GMT
Subject: [PATCH v1 0/4] NFSD tracepoint clean-ups for v5.11
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Thu, 12 Nov 2020 10:00:55 -0500
Message-ID: <160519319763.1658.12613346131541001302.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi-

I'm planning to merge these minor clean-ups with v5.11. Thanks in
advance for any review comments!

---

Chuck Lever (4):
      SUNRPC: Move the svc_xdr_recvfrom() tracepoint
      NFSD: Clean up the show_nf_may macro
      NFSD: Remove extra "0x" in tracepoint format specifier
      NFSD: Add SPDX header for fs/nfsd/trace.c


 fs/nfsd/trace.c |  1 +
 fs/nfsd/trace.h | 48 ++++++++++++++++++++++++++++++------------------
 2 files changed, 31 insertions(+), 18 deletions(-)

--
Chuck Lever

