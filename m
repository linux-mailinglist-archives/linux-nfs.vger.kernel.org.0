Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706D96A022D
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Feb 2023 05:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbjBWE5L (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Feb 2023 23:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbjBWE5K (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Feb 2023 23:57:10 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC8237711
        for <linux-nfs@vger.kernel.org>; Wed, 22 Feb 2023 20:57:07 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id m14-20020a7bce0e000000b003e00c739ce4so7022091wmc.5
        for <linux-nfs@vger.kernel.org>; Wed, 22 Feb 2023 20:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NAMvmRrE4C6YuhvJLmHdc9GulbTUFayQp7fFkOD4XcQ=;
        b=RgUOo0kv3y8h/ILBD4bsQjrLwVRzZV+uBQeTCHDG6mWSOd9LALwMuCUPblSj6iDVOR
         K7d/lXIlEINsF92MWE8KBcLk6DbiaLQKNSR1Eh9DgyVl+yoVeoP87m5RMjNrQ4NpDLFr
         1dILpBGmafmVJzAZo7Iq435zpcO5V9dAYOYJMPQl303RRTjJKejlKzO4r+yL9UOANSxL
         ag6ygQplQyMm46aREGwsXAX4kqeWOyWBDzImyZ93JrHu570McH/ABZ/rNnZLld5VLN0A
         L8YH09jDqi7D19UGhLYF3rXfm0/+fiyE1pbMv2WL0IWwCAtk99OSUTH+4h5gn1yJM3nt
         tECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NAMvmRrE4C6YuhvJLmHdc9GulbTUFayQp7fFkOD4XcQ=;
        b=rKvRIXtyrWYdOw6Yvw3ZJ8BggUIZBR4UHgRZexoluREd61bmtOfjsm+d12q8ZioRt8
         3gbF9aBhb6R+TrE5SMSaoeqsUG+jpsC9UMh+2QI+UY+F75ys4A/vQjb60vFDs+y2L5iM
         9xYUvGP2t+m+QO1clw7qYni6LgZAuNBPRs4I/IL09Zt3PMxFBqqc+/VyDy5Wuav8+GZF
         Kp1goCgV6IcE1mI8X0Y9YFU/6xg5lxOee+I0G6u90Mj7pgf5k9B6XzJIxAk1BANgTukt
         3nZhhbpxxaJFOFHvlCgnqQ5e0qYWJRd1QEiDPhw2qBEo7Kd2n9N3ogzSR5Ugx8X9DA0N
         RLsg==
X-Gm-Message-State: AO0yUKXdEPhV5knlddH+pvnbvtqiN+Fb5HwzbC/OFqPg20gZL0CCdYD7
        G4LFdCg5pfoOiJTfPxy3xXI=
X-Google-Smtp-Source: AK7set+IbRLo3SB7PB/8ZwO01Cb9C/aTi3KJmBatqhkaK5AjQP7Gf2xs0aT2LuCZp5lQsBf/SOip7A==
X-Received: by 2002:a05:600c:3b20:b0:3df:db20:b0ae with SMTP id m32-20020a05600c3b2000b003dfdb20b0aemr9000910wms.17.1677128226333;
        Wed, 22 Feb 2023 20:57:06 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id hn29-20020a05600ca39d00b003db03725e86sm9984113wmb.8.2023.02.22.20.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 20:57:05 -0800 (PST)
Date:   Wed, 22 Feb 2023 17:02:18 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     trond.myklebust@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Subject: [bug report] NFS: Convert buffered writes to use folios
Message-ID: <Y/YgahwOk4DL217a@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello Trond Myklebust,

This is a semi-automatic email about new static checker warnings.

The patch 0c493b5cf16e: "NFS: Convert buffered writes to use folios" 
from Jan 19, 2023, leads to the following Smatch complaint:

    fs/nfs/write.c:793 nfs_inode_remove_request()
    warn: variable dereferenced before check 'folio' (see line 790)

fs/nfs/write.c
   789			struct folio *folio = nfs_page_to_folio(req->wb_head);
   790			struct address_space *mapping = folio_file_mapping(folio);
                                                                           ^^^^^
Patch adds dereference

   791	
   792			spin_lock(&mapping->private_lock);
   793			if (likely(folio && !folio_test_swapcache(folio))) {
                                   ^^^^^
Patch adds a check (too late).

   794				folio->private = NULL;
   795				folio_clear_private(folio);

regards,
dan carpenter
