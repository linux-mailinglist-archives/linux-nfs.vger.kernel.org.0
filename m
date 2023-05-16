Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1296705277
	for <lists+linux-nfs@lfdr.de>; Tue, 16 May 2023 17:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjEPPm5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 May 2023 11:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233985AbjEPPm4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 May 2023 11:42:56 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F606E85
        for <linux-nfs@vger.kernel.org>; Tue, 16 May 2023 08:42:52 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50bcb229adaso26025383a12.2
        for <linux-nfs@vger.kernel.org>; Tue, 16 May 2023 08:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684251771; x=1686843771;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bJdGKICWmGv85K5wtQSHIYe7lme/vN6+44Of5jYTNMU=;
        b=AGkd0Fz5+91D7h7EYcZxGV5kihGAaQdg7yXQKHqrph7R/nJckoEKkJAEWAktWs89Sf
         eViUTbAa8w/hSs+ziaFUSpu+2Y8UjkeZ1xiKP9gOAUJogIIDr73yhB+ux07mVt/dDER7
         sCjVGWjqZfeNDD5mhrYu8wsjMunedzVE48t56BpO9VkjOJYWqY6qRlqdvRqgu2ZJA+wX
         mh9/d+03W42cxvG1/7QmMFoMNp8/96quVvWVWP82JLq+VMcNsIdOu1P7SeFBZ/7h4Dgg
         PdaWGSSZ7nl19l0XzGBtWeXiedcyXtNJVEg1shgtNiAJCl5EYMIAehbAdRzeDMQti2Zs
         g8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684251771; x=1686843771;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bJdGKICWmGv85K5wtQSHIYe7lme/vN6+44Of5jYTNMU=;
        b=IiXP3thu5Dqb8W8fGsktycYCH4B6IV7MWeF5x3PQBSTF++qwos6qYWT+i2eBzGHQpZ
         aCUuW+yIBAvu6kk9xxP8wXDfu9/vJpUdRknOy4yeQDJHY3Ol9+S3x24RjrclHa6KXy8t
         o6QTokn3GAD6p6xPFhNBj5/2ZRWz5D4Rz0fKdIBn8wRknR6SElkuFf8GT9+N3xcvyIWx
         T3pEw0gPPPMn9jrsQ820BVXCcXe37hr5NnMQpyV+3lwM7KdVRMQ/DTtVIHBduZkRHh8b
         fuEh/JuWNqWBn+RzpstpbJ2nwApx3cT4+x8ke0ZqtO78Ff1hYgm+3ncJpaqm+Rx7jk5E
         G+bA==
X-Gm-Message-State: AC+VfDww5HVqf+cLx9MLCkzCr3vWAPo181l/jr0d6xnS1E7i35dBTy6s
        gPbXPKfa1WRMdgZ1kjsfZpY9RKPsdju3vjWgFGbteGceAx0=
X-Google-Smtp-Source: ACHHUZ7VKppiy6hYOyleXTuQ96f7BodeChTwl7i14yAj3Zq/zNyLxt2UpJEJR6P0RDpZEQU662kK+EGa9etmJm/9c0g=
X-Received: by 2002:a17:907:eab:b0:969:813c:9868 with SMTP id
 ho43-20020a1709070eab00b00969813c9868mr28463819ejc.18.1684251770723; Tue, 16
 May 2023 08:42:50 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Chilvers <chilversc@gmail.com>
Date:   Tue, 16 May 2023 16:42:39 +0100
Message-ID: <CAAmbk-f_U8CPcTQM866L572uUHdK4p5iWKnUQs4r8fkW=6RW9g@mail.gmail.com>
Subject: [BUG] fscache writing but not reading
To:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com
Cc:     Benjamin Maynard <benmaynard@google.com>, brennandoyle@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

While testing the fscache performance fixes [1] that were merged into 6.4-rc1
it appears that the caching no longer works. The client will write to the cache
but never reads.

I suspect this is related to known issue #1. However, I tested the client
with rsize less than, equal to, and greater than readahead, and in all cases
I see the issue.

If I apply both the patches [2], [3] from the known issues to 6.4-rc1 then the
cache works as expected. I suspect only patch [2] is required but have not
tested patch [2] without [3].

Testing
=======
For the test I was just using dd to read 300 x 1gb files from an NFS
share to fill the cache, then repeating the read.

In the first test run, /var/cache/fscache steadily filled until reaching
300 GB. The read I/O was less than 1 MB/s, and the write speed was fairly
constant 270 MB/s.

In the second run, /var/cache/fscache remained at 300 GB, so no new data was
being written. However, the read I/O remained at less than 1 MB/s and the write
rate at 270 MB/s.

    /var/cache/fscache
                | 1st run     | 2nd run
    disk usage  | 0 -> 300 GB | 300 GB
    read speed  | < 1 MB/s    | < 1 MB/s
    write speed | 270 MB/s    | 270 MB/s

This seems to imply that the already cached data was being read from the source
server and re-written to the cache.

Known Issues
============
1. Unit test setting rsize < readahead does not properly read from
fscache but re-reads data from the NFS server
* This will be fixed with another dhowells patch [2]:
  "[PATCH v6 2/2] mm, netfs, fscache: Stop read optimisation when
folio removed from pagecache"

2. "Cache volume key already in use" after xfstest runs involving
multiple mounts
* Simple reproducer requires just two mounts as follows:
 mount -overs=4.1,fsc,nosharecache -o
context=system_u:object_r:root_t:s0  nfs-server:/exp1 /mnt1
 mount -overs=4.1,fsc,nosharecache -o
context=system_u:object_r:root_t:s0  nfs-server:/exp2 /mnt2
* This should be fixed with dhowells patch [3]:
  "[PATCH v5] vfs, security: Fix automount superblock LSM init
problem, preventing NFS sb sharing"

References
==========

[1] https://lore.kernel.org/linux-nfs/20230220134308.1193219-1-dwysocha@redhat.com/
[2] https://lore.kernel.org/linux-nfs/20230216150701.3654894-1-dhowells@redhat.com/T/#mf3807fa68fb6d495b87dde0d76b5237833a0cc81
[3] https://lore.kernel.org/linux-kernel/217595.1662033775@warthog.procyon.org.uk/
