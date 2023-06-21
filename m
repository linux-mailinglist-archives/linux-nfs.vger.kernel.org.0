Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE06739180
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jun 2023 23:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjFUV2t (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 21 Jun 2023 17:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjFUV2s (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 21 Jun 2023 17:28:48 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF991BE4;
        Wed, 21 Jun 2023 14:28:41 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-34207e81c98so30991325ab.2;
        Wed, 21 Jun 2023 14:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687382921; x=1689974921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KDVeKgt20anLjpmZL3lLbfkT9Je6VtDNWrGWDpMPcz4=;
        b=RvbWobbubv0WAnB5MOzIkt7ykTs7F8l/9ejrg40RaTJHbrFOtrQSoADnE7lnud5Iuk
         nYiXpQXNkb67FFaaNt3hgXnj38zPMCUj+JYo/JvOoMraNl5Z/mZcyFm6JTqw9ca+Tc5T
         JYJVraxgeDFzY/4YqtRyW/+Fv0akQQBJxXoc8izGzN90PjzovTBRgR+hWJ6KQPSXraVl
         jTgQHfu2I3BAUHjH6uJGQ0SBb8s2R/yi0D8AsdW+gx6usnqEXwspfOgrivolDw2ni7lp
         YT8lqGLD8sUbcRp3NfgyoGJw3/INtgWg25KYYTKtgDfQo/TC69L1NHjm1wxE3dqxvAOn
         9+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687382921; x=1689974921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDVeKgt20anLjpmZL3lLbfkT9Je6VtDNWrGWDpMPcz4=;
        b=AI9g4y/3Vt4m70AZOHp2e0++3VsN2TUebiBxOaoRjuFkiMnwwOTbMUfdJ/VrQVTLO4
         hpbwwDBK++DJPYTt98F2NQn9pVcG40EX3kvPMStmUiFB4iiqks9rPI1xd3SeR3WPlCUL
         3cXlFlkaCaBb7GCHzVYUrk94RlDlOdeMvvnayJ4cF0VrngC+G8byVR10tCPcSsFtbgfR
         3VAEdvzoYS8iiOzxCtUU960Vq6INq6gOAkghg4pTPISd4qBRUzDFcDS0CfreIk750Xhg
         ASfpquJFldaN1fLk5UUMtNL6dd0+jT0zRGDIIsc1PXnFNTFpvTbX8fO754CEiZxJL1oX
         YUSQ==
X-Gm-Message-State: AC+VfDx9Qv2QlXNBm7ru1idUu1p2J145LHluUioDH4SYlnjf11GW/b/T
        /BR3lrLMmKTA1FLPZaKxBCg=
X-Google-Smtp-Source: ACHHUZ6BZzIC7TcPquzSAHqFVAEaYT0OhXJraqh0DPT8+mgXUfM+BWMcj4cpWUTp9wHKFIHXT7Tnrg==
X-Received: by 2002:a92:c10e:0:b0:335:7be2:26ca with SMTP id p14-20020a92c10e000000b003357be226camr16876500ile.19.1687382920609;
        Wed, 21 Jun 2023 14:28:40 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id v2-20020a92c6c2000000b0033bc3a3ea39sm1524188ilm.70.2023.06.21.14.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 14:28:40 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 21 Jun 2023 11:28:38 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: contention on pwq->pool->lock under heavy NFS workload
Message-ID: <ZJNrht3NlLyPn2A0@slm.duckdns.org>
References: <38FA0353-5303-4A3D-86A5-EF1E989CD497@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38FA0353-5303-4A3D-86A5-EF1E989CD497@oracle.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

On Wed, Jun 21, 2023 at 03:26:22PM +0000, Chuck Lever III wrote:
> lock_stat reports that the pool->lock kernel/workqueue.c:1483 is the highest
> contended lock on my test NFS client. The issue appears to be that the three
> NFS-related workqueues, rpciod_workqueue, xprtiod_workqueue, and nfsiod all
> get placed in the same worker_pool, so they have to fight over one pool lock.
> 
> I notice that ib_comp_wq is allocated with the same flags, but I don't see
> significant contention there, and a trace_printk in __queue_work shows that
> work items queued on that WQ seem to alternate between at least two different
> worker_pools.
> 
> Is there a preferred way to ensure the NFS WQs get spread a little more fairly
> amongst the worker_pools?

Can you share the output of lstopo on the test machine?

The following branch has pending workqueue changes which makes unbound
workqueues finer grained by default and a lot more flexible in how they're
segmented.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git affinity-scopes-v2

Can you please test with the brnach? If the default doesn't improve the
situation, you can set WQ_SYSFS on the affected workqueues and change their
scoping by writing to /sys/devices/virtual/WQ_NAME/affinity_scope. Please
take a look at

 https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/tree/Documentation/core-api/workqueue.rst?h=affinity-scopes-v2#n350

for more details.

Thanks.

-- 
tejun
