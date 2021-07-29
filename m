Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFD03DADF7
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jul 2021 22:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbhG2U7y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Jul 2021 16:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbhG2U7y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Jul 2021 16:59:54 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003C9C061765
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jul 2021 13:59:49 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id t68so7357367qkf.8
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jul 2021 13:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aOAej+WSm8VZfSTdnIM6LIx+TmNwAZ/65Z7nK86fg+g=;
        b=C/DOhiSOw7nyyMnoasKLPmsquhZac9lDkbHRWERtvzOwo88mCCpsdSWpKW9BHS73Wn
         jcIU4XARPfuHpVh4NC9svKPQb+nvHUChpN8P+KCCbzHH4k/xEgKjqh9LzEEIwe9tD4bn
         aeWPRV9QxHgdrnOjYVYbdaBMkmdPE5bkclqWq4All6/Cg2y5UpdjuLbclL2ScqWDGos8
         dJqENU9scMu+1o1dqSMZOuz+K6+LZSuXLhPeMVmXFA8+dVLRU9xf3lzlHL5XdJjsf8Lt
         4c1wBCLul6XyBIdHdR/kvnfYbzAMnUL1FfKEHR4h9TIHX1FlutI9DGI5Jm42tvzZFoYF
         jtPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=aOAej+WSm8VZfSTdnIM6LIx+TmNwAZ/65Z7nK86fg+g=;
        b=efN+lK4QGFKqR6cWjWhP5DEn82lBIxY1nmxPJUrsxaqjWxwJEbo6z1+SdsxK+CQWJc
         GWQI84jn96BcVX4nbTe/+KwRvFPrmGtWUtGpnnZM8lUfJK3riAmBvkglqNEhnx31IdRq
         6Xt+OyYMILK0TEHpEqiDPYEVMbpfPRuCsCCn41rOEyH7nIVq+QXfqA9SQD2QXx3nLcL/
         HqDZccLir3MXhGEEgd8X8eAktis+jf1N2ZudXKOkk3AhsDAIKpoUuslRLNeeErGWfP0c
         ySElPSdEjvsUMmc0WR0hardH1RToW8/oWGp3G4B4prETcKDJjgIS7IKRh4HVe5oakP0V
         IFZw==
X-Gm-Message-State: AOAM532glzf76rMYXuuFXvHGMiNrUGL1KQHUZfR5R4yNGw70bN8e9wry
        ii0TPMp7gWHrBdwjdlmk5sa2YKCcaS4=
X-Google-Smtp-Source: ABdhPJy0yuuCD5BOWTw6dMCzY5EPoZYg4EL5VuYSpC63UyGT0tRYXcs7KFa6vf3XR1zsuycA5uV9vA==
X-Received: by 2002:a37:46d1:: with SMTP id t200mr7328216qka.491.1627592388970;
        Thu, 29 Jul 2021 13:59:48 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id j3sm2268529qka.96.2021.07.29.13.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 13:59:48 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 0/2] SUNRPC: Add srcaddr and dst_port to sysfs
Date:   Thu, 29 Jul 2021 16:59:45 -0400
Message-Id: <20210729205947.162599-1-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

At the moment we only show dstaddr and src_port in the sysfs files.
Let's add the other half of the configuration so admins can get a
complete picture of the configuration.

Thanks,
Anna


Anna Schumaker (2):
  SUNRPC: Add srcaddr as a file in sysfs
  SUNRPC: Add dst_port to the sysfs xprt info file

 net/sunrpc/sysfs.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

-- 
2.32.0

