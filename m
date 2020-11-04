Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9560F2A635E
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Nov 2020 12:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgKDLdw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Nov 2020 06:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728700AbgKDLdv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Nov 2020 06:33:51 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0E9C0613D3;
        Wed,  4 Nov 2020 03:33:51 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id r10so16354705pgb.10;
        Wed, 04 Nov 2020 03:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sHxsYW7dtDokTqOCqyvEtWMH1g82kxcGZGcMhLeJhSU=;
        b=oYuqdfNizbvNgx8VPH1L01MrjPlZsZtJxceSbmq7LYgdG1+2iy9po61wNSyJPKRdbs
         2f3sRPHfbyd4Z4T38rGVUg7ZPz3ec8vTVQeFnevtT54eh4dL7JrtSTM8erjbNMyCIPt0
         PBTrkwCMbI+hl0tm5Q08GOW2wzsG/SWy+3g2Y4wV1NBUO4+xyK86oXRyTI4KikVdP67g
         aQNHqMmxvJDNaWQZYrlm9IIxVpdcUSxyjT2+/vkszZMwc+6MtvaJOiznu1Lg3xgbxe2w
         0CWmhOJeQjVMYUUQ7FbWmkoUUPf+16AyezGz2wRMrLf7AU0woCZv5JE8qB4reNbm2OS0
         gDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sHxsYW7dtDokTqOCqyvEtWMH1g82kxcGZGcMhLeJhSU=;
        b=ZPPfjW9baMO9Jvw5vo2vXR3OoX6LWLAjxiHyGwX33Go5Th1/nsnng2O7Ja/8EY9sdV
         BiR5TwHZk6m0P/dDT78Jzc8GD7lOQGhqphiST9C5404ojfY0bBQaGgHGKPFQ6MnaK26L
         cvSJP5WgS0Y6iTUJ76CgJwdJdGPslDU9t48ORHlBTU8ehdMkCjjcbqQyAnbdBvKuuvE4
         V2nskTPwl47BwVPZdqcTZ5PW/qZusFmOZmV5AQ1ect5kST+z+ussaB3YU92pK21XclYg
         h4cpZSwPeyykpekeuG6R+MJgvLDTKqdysIEYnZ49hRdLxfnoeSI7AJNr0hKEF1ytze7a
         qrNQ==
X-Gm-Message-State: AOAM531H2DsJ46qg0tcKTGj2dkMumwhVcfLpTQAwfNJ3akUuWYW2hDDR
        MiNmkGvjKWWaYC5OgJspmvk=
X-Google-Smtp-Source: ABdhPJxOdiul8E+jhKKH45WgaL4MKudEULwBb/xgCz8OIUkXhn35zZpOSufsarqCQCXAWG62WfzgwA==
X-Received: by 2002:a62:7e14:0:b029:18a:d515:dc47 with SMTP id z20-20020a627e140000b029018ad515dc47mr16809540pfc.78.1604489631399;
        Wed, 04 Nov 2020 03:33:51 -0800 (PST)
Received: from soladeMBP.lan (173.28.92.34.bc.googleusercontent.com. [34.92.28.173])
        by smtp.gmail.com with ESMTPSA id h20sm2061216pgv.23.2020.11.04.03.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 03:33:50 -0800 (PST)
Subject: Re: [PATCH 2/2] NFS: Limit the number of retries
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Cc:     "chenwenle@huawei.com" <chenwenle@huawei.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nixiaoming@huawei.com" <nixiaoming@huawei.com>
References: <20201102162438.14034-1-chenwenle@huawei.com>
 <20201102162438.14034-3-chenwenle@huawei.com>
 <8db50c039cb8b8325bb428c60ff005b899654fb4.camel@hammerspace.com>
From:   Wenle Chen <solomonchenclever@gmail.com>
Message-ID: <ebee08ee-ecbe-c47c-1f7c-799f86b3879c@gmail.com>
Date:   Wed, 4 Nov 2020 19:33:48 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <8db50c039cb8b8325bb428c60ff005b899654fb4.camel@hammerspace.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



Trond Myklebust 於 2020/11/3 上午1:45 寫道:
> On Tue, 2020-11-03 at 00:24 +0800, Wenle Chen wrote:
>>    We can't wait forever, even if the state
>> is always delayed.
>>
>> Signed-off-by: Wenle Chen <chenwenle@huawei.com>
>> ---
>>   fs/nfs/nfs4proc.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>> index f6b5dc792b33..bb2316bf13f6 100644
>> --- a/fs/nfs/nfs4proc.c
>> +++ b/fs/nfs/nfs4proc.c
>> @@ -7390,15 +7390,17 @@ int nfs4_lock_delegation_recall(struct
>> file_lock *fl, struct nfs4_state *state,
>>   {
>>          struct nfs_server *server = NFS_SERVER(state->inode);
>>          int err;
>> +       int retry = 3;
>>   
>>          err = nfs4_set_lock_state(state, fl);
>>          if (err != 0)
>>                  return err;
>>          do {
>>                  err = _nfs4_do_setlk(state, F_SETLK, fl,
>> NFS_LOCK_NEW);
>> -               if (err != -NFS4ERR_DELAY)
>> +               if (err != -NFS4ERR_DELAY || retry == 0)
>>                          break;
>>                  ssleep(1);
>> +               --retry;
>>          } while (1);
>>          return nfs4_handle_delegation_recall_error(server, state,
>> stateid, fl, err);
>>   }
> 
> This patch will just cause the locks to be silently lost, no?
> 
This loop was introduced in commit 3d7a9520f0c3e to simplify the delay 
retry loop. Before this, the function nfs4_lock_delegation_recall would 
return a -EAGAIN to do a whole retry loop.

When we retried three times and waited three seconds, it was still in 
delay. I think we can get a whole loop and check the other points if it 
was changed or not. It is just a proposal.
