Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0F6739C4F
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jun 2023 11:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjFVJMH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Jun 2023 05:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjFVJLr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Jun 2023 05:11:47 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BE66582
        for <linux-nfs@vger.kernel.org>; Thu, 22 Jun 2023 02:02:21 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-668842bc50dso867505b3a.1
        for <linux-nfs@vger.kernel.org>; Thu, 22 Jun 2023 02:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687424541; x=1690016541;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zKVeIBLjGDnMEk399X22nqGU5gR+IkjsspTDpWJPksU=;
        b=HjY0DB39Dcl5lSGLQjq20skrYCeeFmph379iAYLH+Ge7wfAKg53bPqsk6H2fP7EYBS
         t5DpaPmOpMe9PHj27s46dMLM2Bj/1z5x+ZEL5MvZJuXhJY2H/Zc1d9fn+QrQnej+vVdY
         vzCZGIIlTPo2rLaoGoYpJ1L3vbMVEY3NdkrXdCuf8JyzXegOrVS1Vjiyr+OQJLWRHhKk
         EYYaud7eSqVUu6DRfGnsjIklhfOOGSE9DMnkFqVVNxWwjgF6B/w1c5xtOvh0H76XPlTG
         hJ3GGBNx4/T/av8JLo7MkeEFcvm+/A4v85iddIKGKlUHLAO6ueBAEAbEtaFjl/PvtvxB
         9ScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687424541; x=1690016541;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zKVeIBLjGDnMEk399X22nqGU5gR+IkjsspTDpWJPksU=;
        b=GoO9N70/uOmH1EIOBm4gYdAuBN//OdYhaqwfRCQlcwXMrHQiE/6uhtOtBw2Zt4T5z/
         Gr0dP9laHIAKCX4OoPlbbtgLM0lJou2DKJ4RAP/NnwgwvC+boK0tUsk3eolDjkZkj5/u
         WkfuCBCe7sYLeawWO0S9W03USTbJkgLyhyqu60c6aEg46d624Bpk82w9qyBYysVUkpv2
         FYEg57p/CfBkf0PY66/307EPWnb+rKgXXI8nAnV6bQDPapuqAULhEmZWmbna/YNBewVV
         RWNUE8LAadtA/SpHHoLXICPHhsi7ENucNPLVWQTbzjBPyeqpe73RiS/J9pxL70ST077n
         azoQ==
X-Gm-Message-State: AC+VfDwlqblUGMQJ1c0DmevYISzuR+MGjJ+SxfZwkkt3efsYolCAWyY6
        b9cKJ9haunhFxJih6Qw6KojIjQ==
X-Google-Smtp-Source: ACHHUZ7vbwmhYAYkPUIyhZunGrGDutPqIs+afT9QzkvrLydl1MlC9S7gSKJ8cU+dWHpEZBjCPLu5gw==
X-Received: by 2002:aa7:8556:0:b0:668:728e:64d8 with SMTP id y22-20020aa78556000000b00668728e64d8mr12967640pfn.1.1687424541033;
        Thu, 22 Jun 2023 02:02:21 -0700 (PDT)
Received: from [10.4.168.167] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id c12-20020aa78e0c000000b0063f2a5a59d1sm4124268pfr.190.2023.06.22.02.02.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 02:02:20 -0700 (PDT)
Message-ID: <ab40cfba-94c3-bcea-10b0-c2cc20809f3d@bytedance.com>
Date:   Thu, 22 Jun 2023 17:02:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 00/29] use refcount+RCU method to implement lockless slab
 shrink
Content-Language: en-US
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, dm-devel@redhat.com,
        linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20230622085335.77010-1-zhengqi.arch@bytedance.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20230622085335.77010-1-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi all,

Well, this one was sent successfully.

Since I always get the following error message, I deleted the original
cc people and only kept the mailing lists.

	4.7.1 Error: too many recipients from 49.7.199.173

Thanks,
Qi
