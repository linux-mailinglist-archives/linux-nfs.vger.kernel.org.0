Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C86EAC41B9
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Oct 2019 22:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfJAUWJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Oct 2019 16:22:09 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36575 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfJAUWJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Oct 2019 16:22:09 -0400
Received: by mail-io1-f68.google.com with SMTP id b136so51429249iof.3
        for <linux-nfs@vger.kernel.org>; Tue, 01 Oct 2019 13:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F8L90vKwRkdlDt7xNjsJpOWp+5BT+qzsHeD4ywVlciU=;
        b=mT/+L6jZ52hWB1cyM1wprED5qgDhaPRNaC1qkSYkHJsRuo4MnJGOZ6wUF4T0FanPGn
         KBha60VTXQd8SQKpODozmV0/kN1Hzf15c7Bs5FJmm+KvlejW3q11z4kkaHxkaHqUpp9k
         i3JJv/ANzfkzx4usrWUdcO/25EawZttzyGWgK45/MZsRDhOoVPyUviCcOlH+EpSmsV1r
         TbGWyuQsDUo8hG+W9r1rvkvKP+ys6+qO1X/gTiy9hhMSZ8+L9n8uxm41p49CoeWbhd+d
         OAiQFGDkdLmamZOIZh0W5BdkNeDELcd7dL8VF8zNZB0OXHnd5bXT9jpsCNZB8xPVrJHI
         B+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F8L90vKwRkdlDt7xNjsJpOWp+5BT+qzsHeD4ywVlciU=;
        b=IQclavGWf0eQmwRYMgdrEI2mYYkBnU0g9fJIHJgB6nOYVzzUfkE8da6xgkbqs9610N
         VbYN1Nu+oJD3u3GXn2alXRBJGuP/imeaYie7tMTCD6xdpnEGNzDYe3zHZZ2Z9GrJwlJT
         JhfQSgCKliOeQc9GXGdH/iXK1/OrTTQp6nBa1LhbmAmbCuZeTxuhZ7YlFuCaBtNAyoRj
         kRniIcM++DZSEu+0xUl45sH61u8ZEh98G3Ec+0kN4amp3O3gnQ22Zs34K8eSmJIiUi3I
         UsaBcz/yH7XZuG+5bsxZHeRgW/wu3ftrUbuXVHAI5sVo8RNYK7263DQz80WWsKtG0vrZ
         /j5Q==
X-Gm-Message-State: APjAAAWpa6WeNZCVcz8senu9FMFFbkFpv73rFU/CltDs6z91Ur+9i0KG
        sEvjQ55tFrt7GXZcibIMog==
X-Google-Smtp-Source: APXvYqwimqp7FcxD1uEwjhxDR9lMjNc+1bPdyGX766o2dE1wrtOrrLNzebnDxQM1mxePoqvQKrnK7w==
X-Received: by 2002:a92:3851:: with SMTP id f78mr27071521ila.179.1569961328462;
        Tue, 01 Oct 2019 13:22:08 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id c65sm8038648ilg.26.2019.10.01.13.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 13:22:07 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Su Yanjun <suyj.fnst@cn.fujitsu.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/2] Fix O_DIRECT error handling
Date:   Tue,  1 Oct 2019 16:19:58 -0400
Message-Id: <20191001202000.13248-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

These patches fix issues with how O_DIRECT handles read and write
errors, and also how it handles eof.

v2:
- Change to handle all short reads and writes in the same manner.

Note that we can still end up breaking generic/465 by using the
nconnect=<n> (where n > 1) mount option. The reason is that the
test assumes the writes land in increasing order on the server,
despite having being launched in parallel.

Trond Myklebust (2):
  NFS: Fix O_DIRECT accounting of number of bytes read/written
  NFS: Remove redundant mirror tracking in O_DIRECT

 fs/nfs/direct.c | 111 ++++++++++++++++++------------------------------
 1 file changed, 41 insertions(+), 70 deletions(-)

-- 
2.21.0

