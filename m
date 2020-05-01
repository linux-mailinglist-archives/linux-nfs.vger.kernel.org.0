Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08CBC1C1C20
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2020 19:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbgEARmz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 May 2020 13:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729447AbgEARmz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 May 2020 13:42:55 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439B8C061A0C
        for <linux-nfs@vger.kernel.org>; Fri,  1 May 2020 10:42:55 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id n14so1883229qke.8
        for <linux-nfs@vger.kernel.org>; Fri, 01 May 2020 10:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=idTOD0cj5JMetvSoe/nhe1jG+WvTsZ8mj0WjWB7C3CQ=;
        b=Jz+R3O734fTl/dwSFmjRfGG6nwk6T8aPOYrpPBLWHM6wTL3u+xwdj63qHw/x3ji1BN
         QLS5FkGVnLN9Lv+rlaqaUHWg4tRNR/cawRrCqEas/dyMwss22KDI3PqZuLRQucmm+tXl
         rZW/xlc4CeBwPnofOybS9wb62nwp1I+ujX1uPALlsaISnLqFZz/dfpDiXG6YL9t2pAPR
         B8WdlW3QWT8GVjE1iL2AjA9nW25znBYfGbIF/PrWZhH80JX/TLpd6DmSMJCwonY3WuIG
         fqdyS4tfwN3hoi5p9B8FQ2N2n/hu37vuzXHTIixv/1JgWBZwr+HXFerX++iJmDQ1p2PI
         yvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=idTOD0cj5JMetvSoe/nhe1jG+WvTsZ8mj0WjWB7C3CQ=;
        b=aJ3pm7NHRMpL/IK8gDAAv5YdIGRLeDISID8YjbJkfJ30Vm7Snx3r5yhKk9HTkYlLLu
         +lylcrVXJppmD7acUtlZedDIK5fFEgL0sElOIFyTbhkihU01AQkeOc459ynLfRMPEHri
         AtZxkU025OQziCrvLry7j9IK5UPWB8SCwOpw60njRoAE75XoP5hIL32c7ms6dumz1Nu+
         J5oX7zNK9Ct0idOUKxTppSJ4cZazZqwadFrhozfifKj2qnrOi8x+cfZ5zc0++LC5T317
         8RKtp6iF8jpk+mVqQeZqkPROyaHsJobse6RNJkfomqy7h1CgU/yrWFrU17yYvfR5jpd4
         YcMw==
X-Gm-Message-State: AGi0PuZ9qk3WnKaKX+LHb+bxvQA+Afh4ZFsDBMa9s043KTrB9mq0m1nc
        dVDPXTuCs/2MgRea01sXGlwrcWHw
X-Google-Smtp-Source: APiQypIzz/F0yvFropg53PCwHJuEZ0cMjz/2KKlhwqJpd91DCCBYQP22sAGskK9rJBW8FxP7Q1rovA==
X-Received: by 2002:a05:620a:2114:: with SMTP id l20mr4562630qkl.220.1588354974287;
        Fri, 01 May 2020 10:42:54 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id a17sm3229390qka.37.2020.05.01.10.42.53
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 10:42:53 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 041HgqdB026787
        for <linux-nfs@vger.kernel.org>; Fri, 1 May 2020 17:42:52 GMT
Subject: [PATCH 0/2] Fix some NFSD-related compiler warnings
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 01 May 2020 13:42:52 -0400
Message-ID: <20200501174124.3941.36405.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-20-geafe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi-

(cc: linux-nfs only)

These are simple, obvious corrections that do not change code
behavior, and the last patches I have ready for now.

---

Chuck Lever (2):
      NFSD: Squash annoying compiler warning
      NFSD: Fix improperly-formatted Doxygen comments


 fs/nfsd/nfs4proc.c |  7 +++----
 fs/nfsd/nfsctl.c   | 26 +++++++++++++-------------
 2 files changed, 16 insertions(+), 17 deletions(-)

--
Chuck Lever
