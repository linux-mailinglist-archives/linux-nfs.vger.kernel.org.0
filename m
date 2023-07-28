Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632757666D3
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jul 2023 10:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbjG1IUI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Jul 2023 04:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbjG1ITV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Jul 2023 04:19:21 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2F93590
        for <linux-nfs@vger.kernel.org>; Fri, 28 Jul 2023 01:19:15 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6862d4a1376so444350b3a.0
        for <linux-nfs@vger.kernel.org>; Fri, 28 Jul 2023 01:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690532355; x=1691137155;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Vz5i3f1KwBqEHtOj3kkD+u+idA4hMEDLOXYQ/Zmb7I=;
        b=L2+elQ31DoTndDMbULUpYhAiCoRfDRGWwRsLhePlw7WW3kXFI6RoGNteAO7MNCCxPK
         FYWrT0NCxgniYdOvtk354oC7lAaEYLaI5+6nbBgCsJS7Z9F7PQNW+ZUGwlLgRq4XIWCd
         IlyzJlPUeNX37jF32KJvYLJePzYsZ7ze/fbSuG8EqYw256JXY3KCKzS1wluS9KcnHJgS
         wVJn5VLovDZDoJav6s/8z2Nev3fZMa4BKzS6r7L/dPmXUhh82k37p3M1JnHGLMc145hK
         MLBcl9i8u/Uj6MSDKzSJ+fdKEdHQ4PpsFlNhyTOhfKom9VA3y6JlxMc/+2lHqKKi6hTK
         U83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690532355; x=1691137155;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Vz5i3f1KwBqEHtOj3kkD+u+idA4hMEDLOXYQ/Zmb7I=;
        b=LVftACZgn+GEnhi5tZb+vEsekdRuD3oz9R9iQhpaAmnKWXuijCLeiWpE+4Yql1A65v
         pLs2LiE5jHtxM31HAFE+YIAr00CUpS+xmb+A6EzTEL6BTE1MQS6+rnaRxFM6NFtFNwxL
         ePq+M9dFIey6GVxXaRfoKOnLnci4/CF2uBKjUJJFLm/HLqaJWZuiLcPvVMsIUQxzAu3U
         V9cXxcmfeI4SUytND9VHx+lUb2cG3UvXTyzfGsfz7sp8uYJ+ZZMyYtAmbVQ53VPDtT6W
         MOytFww+sWoKgaR3vQbgYtaBYZNMGDHmYDG2HSpz/6RlPoJQ91aZTwkzL/MUsF0sSeAj
         Y8LQ==
X-Gm-Message-State: ABy/qLasijZjVVsohR4mDvmhijqonEsru4r+6EV5owCmefc7RUqRopPD
        ud+P1WsB9cxJ21UcWTloCQnvHo+LKcHEpCmoKck=
X-Google-Smtp-Source: APBJJlFUUUMvBrf6ibd1LKjgOpEN2XEkSNdXdEqaA3c50PeJDSflhjqiMTE27IMY1LDD8QpZTvY8yg==
X-Received: by 2002:a05:6a21:329f:b0:134:76d6:7f7 with SMTP id yt31-20020a056a21329f00b0013476d607f7mr2068612pzb.4.1690532355159;
        Fri, 28 Jul 2023 01:19:15 -0700 (PDT)
Received: from [10.70.252.135] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id j63-20020a638b42000000b005637030d00csm2862658pge.30.2023.07.28.01.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 01:19:14 -0700 (PDT)
Message-ID: <99d0958d-8446-6fe9-a0fb-f562cb04c7c8@bytedance.com>
Date:   Fri, 28 Jul 2023 16:19:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 04/49] mm: shrinker: remove redundant shrinker_rwsem in
 debugfs operations
Content-Language: en-US
To:     Simon Horman <simon.horman@corigine.com>
Cc:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
References: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
 <20230727080502.77895-5-zhengqi.arch@bytedance.com>
 <ZMN4mjsF1QEsvW7D@corigine.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <ZMN4mjsF1QEsvW7D@corigine.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Simon,

On 2023/7/28 16:13, Simon Horman wrote:
> On Thu, Jul 27, 2023 at 04:04:17PM +0800, Qi Zheng wrote:
>> The debugfs_remove_recursive() will wait for debugfs_file_put() to return,
>> so the shrinker will not be freed when doing debugfs operations (such as
>> shrinker_debugfs_count_show() and shrinker_debugfs_scan_write()), so there
>> is no need to hold shrinker_rwsem during debugfs operations.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>>   mm/shrinker_debug.c | 14 --------------
>>   1 file changed, 14 deletions(-)
>>
>> diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
>> index 3ab53fad8876..f1becfd45853 100644
>> --- a/mm/shrinker_debug.c
>> +++ b/mm/shrinker_debug.c
>> @@ -55,11 +55,6 @@ static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
>>   	if (!count_per_node)
>>   		return -ENOMEM;
>>   
>> -	ret = down_read_killable(&shrinker_rwsem);
>> -	if (ret) {
>> -		kfree(count_per_node);
>> -		return ret;
>> -	}
>>   	rcu_read_lock();
> 
> Hi Qi Zheng,
> 
> As can be seen in the next hunk, this function returns 'ret'.
> However, with this change 'ret' is uninitialised unless
> signal_pending() returns non-zero in the while loop below.

Thanks for your feedback, the 'ret' should be initialized to 0,
will fix it.

Thanks,
Qi

> 
> This is flagged in a clan-16 W=1 build.
> 
>   mm/shrinker_debug.c:87:11: warning: variable 'ret' is used uninitialized whenever 'do' loop exits because its condition is false [-Wsometimes-uninitialized]
>           } while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   mm/shrinker_debug.c:92:9: note: uninitialized use occurs here
>           return ret;
>                  ^~~
>   mm/shrinker_debug.c:87:11: note: remove the condition if it is always true
>           } while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                    1
>   mm/shrinker_debug.c:77:7: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
>                   if (!memcg_aware) {
>                       ^~~~~~~~~~~~
>   mm/shrinker_debug.c:92:9: note: uninitialized use occurs here
>           return ret;
>                  ^~~
>   mm/shrinker_debug.c:77:3: note: remove the 'if' if its condition is always false
>                   if (!memcg_aware) {
>                   ^~~~~~~~~~~~~~~~~~~
>   mm/shrinker_debug.c:52:9: note: initialize the variable 'ret' to silence this warning
>           int ret, nid;
>                  ^
>                   = 0
> 
>>   
>>   	memcg_aware = shrinker->flags & SHRINKER_MEMCG_AWARE;
>> @@ -92,7 +87,6 @@ static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
>>   	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
>>   
>>   	rcu_read_unlock();
>> -	up_read(&shrinker_rwsem);
>>   
>>   	kfree(count_per_node);
>>   	return ret;
> 
> ...
