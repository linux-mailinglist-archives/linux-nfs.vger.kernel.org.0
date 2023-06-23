Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CC273AFCB
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jun 2023 07:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjFWF0K (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Jun 2023 01:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbjFWF0I (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 23 Jun 2023 01:26:08 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2652134
        for <linux-nfs@vger.kernel.org>; Thu, 22 Jun 2023 22:26:02 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b505665e2fso10271975ad.0
        for <linux-nfs@vger.kernel.org>; Thu, 22 Jun 2023 22:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687497961; x=1690089961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I74A3FzNlMiWSwenHJ0qW6K9Kk3RrnXa52gDQFbNI94=;
        b=FE8O7Vw+I3Rj3/ymdkfv8Bc+lpDZ080s6kF+VZ6KYuJ8IcvSDzEvJHrYtehbevzDKJ
         k39KSog3mD45RBSDswKQweqzUA8WL0SL0uOXty3tY4QBaCgZzpYfPiVwVN0bS3NDj5Wp
         Vlnc7que1gB/FOXny+Xqd3OrpA8296BqQ44lM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687497961; x=1690089961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I74A3FzNlMiWSwenHJ0qW6K9Kk3RrnXa52gDQFbNI94=;
        b=PyJAAzdWK5mxLzg+6PCtlL/9JbuayeXRU2oU8rHgJTnry4+pdlhlGKMlfvogaWeZkA
         sUF0ZOzxnTiMMsGoZryAFnsnd4bNVairqSY8Nk5SL/ICttjjzFog7L+ZPZpHOkrKNJDg
         lthuYwaS94z2YS0mCCvTT7HE0DHk+s0r5wqMpjJ1H4sI+9dzdS8gOXLFd4ji+gLpD6RX
         /CzqpB6XCniQH/uc6o8Wlk/s3x1WfIfTUlRQ33eAjS57JehZ8+CaUnxEBoEUgPqcwjhH
         wtcd4obFLzrDOZRXbVzs3KS3zdXATUpIkvu8qqTITjR83G79Ftjgx5HZwL392ZQccEt9
         bObQ==
X-Gm-Message-State: AC+VfDwGU55jHIVbVJVsEwUUQQP8Y7sT5iuUQv8OlIIR4SmML0s/zJKg
        pCR3whGBXV5hJ4CcjqEmJLQwsg==
X-Google-Smtp-Source: ACHHUZ5sPbLx4vVXAJjIGembGjCJJyMTydKicDo1snyQX4c1P9pglVj/z3vqORh1yZ2I9l32bGJbWQ==
X-Received: by 2002:a17:902:ecc6:b0:1ae:8fa:cd4c with SMTP id a6-20020a170902ecc600b001ae08facd4cmr41235916plh.7.1687497961344;
        Thu, 22 Jun 2023 22:26:01 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:3383:b451:fa2:1538])
        by smtp.gmail.com with ESMTPSA id c1-20020a170902d48100b00192aa53a7d5sm6288753plg.8.2023.06.22.22.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 22:26:00 -0700 (PDT)
Date:   Fri, 23 Jun 2023 14:25:54 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, dm-devel@redhat.com,
        linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 29/29] mm: shrinker: move shrinker-related code into a
 separate file
Message-ID: <20230623052554.GA11471@google.com>
References: <20230622085335.77010-1-zhengqi.arch@bytedance.com>
 <20230622085335.77010-30-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622085335.77010-30-zhengqi.arch@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On (23/06/22 16:53), Qi Zheng wrote:
> +/*
> + * Remove one
> + */
> +void unregister_shrinker(struct shrinker *shrinker)
> +{
> +	struct dentry *debugfs_entry;
> +	int debugfs_id;
> +
> +	if (!(shrinker->flags & SHRINKER_REGISTERED))
> +		return;
> +
> +	shrinker_put(shrinker);
> +	wait_for_completion(&shrinker->completion_wait);
> +
> +	mutex_lock(&shrinker_mutex);
> +	list_del_rcu(&shrinker->list);

Should this function wait for RCU grace period(s) before it goes
touching shrinker fields?

> +	shrinker->flags &= ~SHRINKER_REGISTERED;
> +	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> +		unregister_memcg_shrinker(shrinker);
> +	debugfs_entry = shrinker_debugfs_detach(shrinker, &debugfs_id);
> +	mutex_unlock(&shrinker_mutex);
> +
> +	shrinker_debugfs_remove(debugfs_entry, debugfs_id);
> +
> +	kfree(shrinker->nr_deferred);
> +	shrinker->nr_deferred = NULL;
> +}
> +EXPORT_SYMBOL(unregister_shrinker);

[..]

> +void shrinker_free(struct shrinker *shrinker)
> +{
> +	kfree(shrinker);
> +}
> +EXPORT_SYMBOL(shrinker_free);
> +
> +void unregister_and_free_shrinker(struct shrinker *shrinker)
> +{
> +	unregister_shrinker(shrinker);
> +	kfree_rcu(shrinker, rcu);
> +}

Seems like this

	unregister_shrinker();
	shrinker_free();

is not exact equivalent of this

	unregister_and_free_shrinker();
