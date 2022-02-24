Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AE24C2911
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Feb 2022 11:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiBXKOF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Feb 2022 05:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiBXKOE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Feb 2022 05:14:04 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596C918A7AA
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 02:13:35 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id d19so2047286ioc.8
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 02:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=9by1bHVMry9H8+pX0TFNr+jD0NaS4nNTdN9Yt2pXO7s=;
        b=T/46hNf2um+Ag/T/VMHZAZE/jPGzjfUgIflizjC24f1K4TY1vNANMiPzYWbezCVqmp
         GAJUmqFe8dDF4xRn3CqspIv8vQ9vReEIuR9prDbuk9O4WBI/zaLl0ZxNMOIu55mEoRKG
         k3t1XSsfAQeh8IGmMo4pN1OMhfZgai2CY7z9aVQlJ+4uUlzkBt+IRxJpMRwy/nFZLCvR
         5fGDcIeM+b/RcKW7u9MbCN2vT/ZWqWdM+Ll+bU/o2TooONjyTI8d9c9FxnXKuMNjz9G9
         9P0uYgmtisFLkz/OZJkZkF081jolPxkY4UxY7tjUwQjdMTmLb/IZG6i72XugfW7HmiX2
         fIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9by1bHVMry9H8+pX0TFNr+jD0NaS4nNTdN9Yt2pXO7s=;
        b=rciW3UrP63yC25UsKuUK4BV2V53fUd+6ENYH16CikARexKVRuYM1FhBDAcxkG8sXz0
         hxoELUBvszkBux9jOsB6d0sqLhkjSPz04jiTh9719tHBVrVLIolcMgFRBBHKuxQKF3ta
         8PMtrp8Qv1ovSxdEn7rGvJus95XIf82Vgno/LLapRMh/RM5Un2gkQwOVNW/nIMMW6dk7
         HINjhmK4+JUFm1+gQy3oxp+bFjEsJoyTrPS5UlcnqwsS6DjrPx0aCs3KhMwR15mj+Mvf
         Q2nJECGT+2+J1AKHtEgq0Ge4c3Q42wzr73Zgn9llyXlwY3QYYbkKNHi9WQpgj82W2Pzg
         H1sA==
X-Gm-Message-State: AOAM531JX594jf6NmN8AY+L23ydEXKPgr+PYc30Tm0fgF3EwxtkUJD7Q
        8PBynToJkUKQ3+NBKDKV18cKHnKqqvz9zjM+dkVm5IRKpj0=
X-Google-Smtp-Source: ABdhPJzOGTsQWoc08P+LL5pyP99LeeX/8qG9lZlnb56grmhB2nI9VRh8rEXbgoRQwfBNy8EnkQn/6mZgQP1jbSZ9qiw=
X-Received: by 2002:a02:a411:0:b0:314:b51c:3b74 with SMTP id
 c17-20020a02a411000000b00314b51c3b74mr1544464jal.69.1645697614747; Thu, 24
 Feb 2022 02:13:34 -0800 (PST)
MIME-Version: 1.0
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 24 Feb 2022 12:13:24 +0200
Message-ID: <CAOQ4uxhYsci9-ADNTH6RZmnzBQoxy0ek4+Hgi9sK8HpF2ftrow@mail.gmail.com>
Subject: nfsd: unable to allocate nfsd_file_hashtbl
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>,
        Chuck Lever <chuck.lever@oracle.com>
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

Hi Jeff,

I got some reports from customers about failure to allocate the
nfsd_file_hashtbl on nfs server restart on a long running system,
probably due to memory fragmentation.

A search in Google for this error message yields several results of
similar reports [1][2].

My question is, does nfsd_file_cache_init() have to be done on server
startup?

Doesn't it make more sense to allocate all the memory pools and
hash table on init_nfsd()?

Thanks,
Amir.

[1] https://unix.stackexchange.com/questions/640534/nfs-cannot-allocate-memory
[2] https://askubuntu.com/questions/1365821/nfs-crashing-on-ubuntu-server-20-04
