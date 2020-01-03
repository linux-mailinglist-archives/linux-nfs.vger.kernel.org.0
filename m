Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E47612FAD1
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2020 17:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgACQwJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Jan 2020 11:52:09 -0500
Received: from mail-yw1-f49.google.com ([209.85.161.49]:39111 "EHLO
        mail-yw1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbgACQwJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Jan 2020 11:52:09 -0500
Received: by mail-yw1-f49.google.com with SMTP id h126so18750830ywc.6
        for <linux-nfs@vger.kernel.org>; Fri, 03 Jan 2020 08:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=z7GQshRNrKM8Tj1Z4ZLET07CcHkRn/pXX5X5rFYfXJ4=;
        b=e/re/gRcllHG2ZKS19yG/CziwuvgjCMbdmBfnWPoXnavkW8oCa+jab3pTS+IW+8EOv
         J2JOu3Wa9x0cCrfgVGPXA0lG5huuaTVI5BJPmXcVE3aqS49j7Wtv9CP+y99ueF683iDj
         FnewhowZBIJkbn01b1E/vTUc12bkemasb2dBZ7nHnMxtYnigayfh2uthGhjvgm1l0W7y
         kC9zdLy5kMLc5m3uiwVrzavtytnpuZxS9LTiESkcMXkYxtIJL5+8B6aDW5EI2aNlBJLu
         XojqFc40QijTKb8W6ontDGhZhPvbmsIJA55Y8Zh0lksF12dkI4ZRN5PgIgzQdg3v5FqZ
         tBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=z7GQshRNrKM8Tj1Z4ZLET07CcHkRn/pXX5X5rFYfXJ4=;
        b=EeXNp/CgDXeOPFsRwR7LG76nvxIEfyhJXG3hhwqUpyki4iZw9ZCw1Eew34cNhd1cmC
         wIMg1AFSWzW8Bb6N/jLYsk3tGw7t07knOekcult2lJz3M39bEAJQ3AtFLN1/JXMJdPXE
         6Y8tvNXHw37DWmi+6pQ4/vdpmDdACSMPAbpg0UR6uBRLtB6ePhcruTrCG1EaHr0u0fMY
         eluwNlS6A4NKPzVXLVBMZoXCP+gdbe9gw6erGOEPs6KgZH6Kil3dPWfxzfVI6Nw3sDuE
         jjpmD/CaN09q6SqVR7VnN8D6tWqBrotVldS1WYDN/OHjfjqV3CugPB/n64q58r/ndqH5
         gitg==
X-Gm-Message-State: APjAAAVhofYc6/+e07l02kCg/bUGVICiuCOkwrI+P+6E79KbjcguRCGS
        xiNzFRBHlElX5NE2DVVeU710mLuk
X-Google-Smtp-Source: APXvYqybpjPrPSdmhJZyY3wiIX1LUz5Lc97t8bS24Os3Fk/dllzubkw3p9tkkvAijQ7L9sInSQ0Jkw==
X-Received: by 2002:a81:b40a:: with SMTP id h10mr52048922ywi.396.1578070328318;
        Fri, 03 Jan 2020 08:52:08 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id g5sm23621362ywk.46.2020.01.03.08.52.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jan 2020 08:52:07 -0800 (PST)
Received: from morisot.1015granger.net (morisot.1015granger.net [192.168.1.67])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 003Gq6dM016366;
        Fri, 3 Jan 2020 16:52:06 GMT
Subject: [PATCH 0/3] Fixes for v5.4
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 03 Jan 2020 11:52:06 -0500
Message-ID: <157807026361.3637.2531475820164100233.stgit@morisot.1015granger.net>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Anna-

I haven't seen these three go into 5.4 stable yet. Can they be
pushed soon?

---

Chuck Lever (3):
      xprtrdma: Fix create_qp crash on device unload
      xprtrdma: Fix completion wait during device removal
      xprtrdma: Fix oops in Receive handler after device removal


 net/sunrpc/xprtrdma/verbs.c     |   29 ++++++++++++++++++++++-------
 net/sunrpc/xprtrdma/xprt_rdma.h |    2 ++
 2 files changed, 24 insertions(+), 7 deletions(-)

--
Chuck Lever

