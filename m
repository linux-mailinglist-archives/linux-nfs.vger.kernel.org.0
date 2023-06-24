Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA87E73C3EE
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Jun 2023 00:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjFWWTZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Jun 2023 18:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbjFWWTX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 23 Jun 2023 18:19:23 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944ED2729
        for <linux-nfs@vger.kernel.org>; Fri, 23 Jun 2023 15:19:20 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-668723729c5so780043b3a.3
        for <linux-nfs@vger.kernel.org>; Fri, 23 Jun 2023 15:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1687558760; x=1690150760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mD+HWl2aEG73j6Ak2J3eZjmDfUV1ZAzR4FiFGaQDP6g=;
        b=lhK6GKfDyI3S2QEkidlKI9Ek7fIdf8s37/5sqH0oYikZjcY7jput4UDyCpFr2NTdT8
         zVyRwANCpkSqZtLXi737KASfNRL8jzfb+T40RkB84q+J2KMVe792KQuGyG75zUe1uU9/
         y8KvlnU3EwX/2kXOOlbwtshnDERQlNsq270xMVedNytpu7Z+d6cUbBidgJ6X6DjHIzPN
         7j8fd31lnOvF/aMkMY7bUu4o0IY8LUCtjYfDI1XbfU7cyMWriXOuApAvFBa9TAUUYDHZ
         fQEMipnVJ6GJpcYxmPtjY5bvv9Ob+7MwsmiucWVnjVO5xA+M617znVGuQZS0X5eWOQ0u
         zyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687558760; x=1690150760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mD+HWl2aEG73j6Ak2J3eZjmDfUV1ZAzR4FiFGaQDP6g=;
        b=kQOyJPQPx8BHYq6Eb8r6fQ2JbobOO3JlEhPxk6FhTul+9PM3cu/ueTxMXaLEeAof9O
         XNeCn7V+ngN4WL7OLhbnnwrEy4OuafOfzt/xs0q9/VkZpceLBFL8AHd3iTxQ7y/Yew39
         3XGu/3/rq8k/u4sV5n3TKJiyxjWAfuYJDyrcCkhfjyATI3FtC7PXv0YBKi/FDun/R9V0
         Y7P/7aKAC8w/4ua4V+Qg3pi6Dx2Lcrj6OB/G2V/k5Cs66Zm+ydA40xXtHBowskPz+YTf
         5nyTVFUlV7UcXHDsFUTeWcdHgYTtPasRRP/qYW0tUf4KG1m2GIMGnofzfFoqQUvoDCSE
         E5+Q==
X-Gm-Message-State: AC+VfDwoYHRfXhTS4c2zGrQ7k1kRClsSoR/sIPAfXhLSi2cjGDgap6JH
        n4+Eb3EP44zI2p0I5RlJZt4NEg==
X-Google-Smtp-Source: ACHHUZ6Wu9ky21UYgtgHUmTHayjznwHVfcTzLH8QgkKVoWewOSRi12/4tLQSsphqEkidSt1h32qo3g==
X-Received: by 2002:a05:6a20:4410:b0:121:7454:be2a with SMTP id ce16-20020a056a20441000b001217454be2amr17133223pzb.45.1687558759759;
        Fri, 23 Jun 2023 15:19:19 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-94-37.pa.vic.optusnet.com.au. [49.186.94.37])
        by smtp.gmail.com with ESMTPSA id b17-20020a170902b61100b001ab0672fc1fsm58552pls.105.2023.06.23.15.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 15:19:19 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qCp7a-00FP7U-2k;
        Sat, 24 Jun 2023 08:19:14 +1000
Date:   Sat, 24 Jun 2023 08:19:14 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, paulmck@kernel.org,
        akpm@linux-foundation.org, tkhai@ya.ru, roman.gushchin@linux.dev,
        djwong@kernel.org, brauner@kernel.org, tytso@mit.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, dm-devel@redhat.com,
        linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 24/29] mm: vmscan: make global slab shrink lockless
Message-ID: <ZJYaYv4pACmCaBoT@dread.disaster.area>
References: <20230622085335.77010-1-zhengqi.arch@bytedance.com>
 <20230622085335.77010-25-zhengqi.arch@bytedance.com>
 <cf0d9b12-6491-bf23-b464-9d01e5781203@suse.cz>
 <ZJU708VIyJ/3StAX@dread.disaster.area>
 <a21047bb-3b87-a50a-94a7-f3fa4847bc08@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a21047bb-3b87-a50a-94a7-f3fa4847bc08@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jun 23, 2023 at 09:10:57PM +0800, Qi Zheng wrote:
> On 2023/6/23 14:29, Dave Chinner wrote:
> > On Thu, Jun 22, 2023 at 05:12:02PM +0200, Vlastimil Babka wrote:
> > > On 6/22/23 10:53, Qi Zheng wrote:
> > Yes, I suggested the IDR route because radix tree lookups under RCU
> > with reference counted objects are a known safe pattern that we can
> > easily confirm is correct or not.  Hence I suggested the unification
> > + IDR route because it makes the life of reviewers so, so much
> > easier...
> 
> In fact, I originally planned to try the unification + IDR method you
> suggested at the beginning. But in the case of CONFIG_MEMCG disabled,
> the struct mem_cgroup is not even defined, and root_mem_cgroup and
> shrinker_info will not be allocated.  This required more code changes, so
> I ended up keeping the shrinker_list and implementing the above pattern.

Yes. Go back and read what I originally said needed to be done
first. In the case of CONFIG_MEMCG=n, a dummy root memcg still needs
to exist that holds all of the global shrinkers. Then shrink_slab()
is only ever passed a memcg that should be iterated.

Yes, it needs changes external to the shrinker code itself to be
made to work. And even if memcg's are not enabled, we can still use
the memcg structures to ensure a common abstraction is used for the
shrinker tracking infrastructure....

> If the above pattern is not safe, I will go back to the unification +
> IDR method.

And that is exactly how we got into this mess in the first place....

-Dave
-- 
Dave Chinner
david@fromorbit.com
