Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B246B5DC1
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Mar 2023 17:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjCKQUN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 11 Mar 2023 11:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjCKQUM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 11 Mar 2023 11:20:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A015C9C7
        for <linux-nfs@vger.kernel.org>; Sat, 11 Mar 2023 08:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678551563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u4E4cd19wg1UowOC95StuMC+v1vhaZ/NAdWYkX5Vb3Y=;
        b=dgpekQPP2od0B/yRwnRxwrs3xie6nMF2i91IbVzqobhd/7HQjbjMiDRGwVID1fchRePbRg
        DF3CdlbpEecNW3k/mm7mS9FSM5Y7t0nf5rQMYi02heQ6Bz3BioauodXt9DCxo9WhIe++m2
        R73yWy4L8lq4mTjIGF1Whvu/6BTgU+0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-SOAQoVTCNEykMDnOm1JglQ-1; Sat, 11 Mar 2023 11:19:22 -0500
X-MC-Unique: SOAQoVTCNEykMDnOm1JglQ-1
Received: by mail-qv1-f71.google.com with SMTP id y3-20020a0cec03000000b0056ee5b123bbso4617450qvo.7
        for <linux-nfs@vger.kernel.org>; Sat, 11 Mar 2023 08:19:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678551561;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u4E4cd19wg1UowOC95StuMC+v1vhaZ/NAdWYkX5Vb3Y=;
        b=8BezayCa2N4vTKb/DWLJf3sPP7R8w1o/wzOTJdsy/nHcXS5crsiCj3T787TfU7H7pS
         irBBxUKeJcyb+BgFVSD5WGqBazkYNgrUJLa59NBArIM+M4NWsQ4PtycMGAI4dyTRilKW
         7vfgTdt9L2hXQFfJKdEPLlaDJnqH+jjqjP1G1MTLYZQUftL1+vzOx4O5OTLjO6VfNFtb
         AfQ51WNcbn7/SoYwJUXugRpAyI38dhzgw/Sst6dtvfFDdc/gduGUKcHXWaFWxgvoNhFh
         LyN9Ny33PP2cihXpnzo0FsKVFkHPM82oeZZubcZouSbR8PgoFo5YipWSGiD1QJuE8E7y
         0sEg==
X-Gm-Message-State: AO0yUKW5nb/y4372ofhgYovkDyvQI1J1Cg2Fe1bKAZTnJzQB3CnVJM66
        ctnevwkwrrTX38s10idnqyQKpPN1x9hya0MyfGeW5XzQTOSq6+UHS7cWNv52HlDV4SFDYlgjPWv
        X1FMgY3aEM/ie30Ao+4aRVeuk4pqH
X-Received: by 2002:a05:622a:180f:b0:3bd:d8f:2da9 with SMTP id t15-20020a05622a180f00b003bd0d8f2da9mr11102089qtc.2.1678551561486;
        Sat, 11 Mar 2023 08:19:21 -0800 (PST)
X-Google-Smtp-Source: AK7set+7liJmS9Tl92Nn1a7oQejXghcxv6JWEokoTC5amzXW0y+eCuueBHwS1uNd0yiWMZGjjeVV8w==
X-Received: by 2002:a05:622a:180f:b0:3bd:d8f:2da9 with SMTP id t15-20020a05622a180f00b003bd0d8f2da9mr11102068qtc.2.1678551561145;
        Sat, 11 Mar 2023 08:19:21 -0800 (PST)
Received: from [172.31.1.6] ([70.109.165.181])
        by smtp.gmail.com with ESMTPSA id h14-20020a05622a170e00b003b6382f66b1sm2152363qtk.29.2023.03.11.08.19.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 08:19:20 -0800 (PST)
Message-ID: <655a8ee6-dd94-effd-738a-9ce8db8ebed7@redhat.com>
Date:   Sat, 11 Mar 2023 11:19:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: mountd: Possible bug in next_mnt()
Content-Language: en-US
To:     Richard Weinberger <richard@nod.at>,
        linux-nfs <linux-nfs@vger.kernel.org>
Cc:     trond.myklebust@hammerspace.com,
        chris chilvers <chris.chilvers@appsbroker.com>
References: <1497292229.221220.1678287959937.JavaMail.zimbra@nod.at>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <1497292229.221220.1678287959937.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

My apologies... Eating some PTO...

On 3/8/23 10:05 AM, Richard Weinberger wrote:
> Hi!
> 
> next_mnt() finds submounts below a given path p.
> While investigating into an issue in my crossmount patches for nfs-utils I noticed
> that it does not work when fsid=root, rootdir=/some/path/ and then "/" is being exported.
> In this case next_mnt() is asked to find submounts of "/" but returns none.
I'm not clear as what you are saying... "rootdir=/some/path/" is not an
export option.

> 
> In my opinion this wrong because every mount is a submount of "/".
> 
> The following change fixes the problem on my side but I'm not sure whether
> "/" is a special case in mountd where next_mnt() has to bail out.
> 
> diff --git a/support/export/cache.c b/support/export/cache.c
> index 2497d4f48df3..be20cb34adcb 100644
> --- a/support/export/cache.c
> +++ b/support/export/cache.c
> @@ -410,13 +410,13 @@ static char *next_mnt(void **v, char *p)
>                  *v = f;
>          } else
>                  f = *v;
> -       while ((me = getmntent(f)) != NULL && l > 1) {
> +       while ((me = getmntent(f)) != NULL && l >= 1) {
>                  char *mnt_dir = nfsd_path_strip_root(me->mnt_dir);
>   
>                  if (!mnt_dir)
>                          continue;
>   
> -               if (strncmp(mnt_dir, p, l) == 0 && mnt_dir[l] == '/')
> +               if (strncmp(mnt_dir, p, l) == 0 && (l == 1 || mnt_dir[l] == '/'))
>                          return mnt_dir;
>          }
>          endmntent(f);
> 
> Comments? :-)
Putting this is the correct patch format including a Signed-off-by
signature... would help.

steved.
> 
> Thanks,
> //richard
> 

