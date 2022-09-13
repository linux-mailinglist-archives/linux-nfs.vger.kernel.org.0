Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE615B76B4
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Sep 2022 18:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbiIMQr7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Sep 2022 12:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbiIMQrb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Sep 2022 12:47:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA76BD1C2
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 08:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663083600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3JPboGONJDKMkiniqT3OEGQtjk1+k+ROHzupL6jDjw0=;
        b=JLc76ldhzXF71WvgR9b/ybfiZWvVPz5rXRgiFTM7QzNy/6824o9kee1jcUx1FyLJqExowx
        Y9H79uastCYBIMDNbgJLXrt7SK2d/xHpWd+SfExCmyNElKDHuauz8sHeuUC1hPAde0dtIl
        fqzL+Cj+5q7yfWG62FUrvahAjhFhLMQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-617-TAt15wjOM-64MStJkF-mSg-1; Tue, 13 Sep 2022 11:36:29 -0400
X-MC-Unique: TAt15wjOM-64MStJkF-mSg-1
Received: by mail-qt1-f200.google.com with SMTP id ci6-20020a05622a260600b0034370b6f5d6so10164207qtb.14
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 08:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=3JPboGONJDKMkiniqT3OEGQtjk1+k+ROHzupL6jDjw0=;
        b=uSLbxwCAyqjzhzQm4UEPCa1mjFU7UylGnlTVIoK2MEzgsxcRTl/5hnIZyezotEwTS6
         wsRKAtgMF95kKE3/RoSCcB2W4+zvgUTxUk4u08bNdGMHG96mStBS6BoYOB/UM1Tp62DA
         XErhCij5jUL8YN2uja3hSCwMfMpKJMFVcQ9we42NM1mirvOLZFSG3HSAIT+IBX0SsnE0
         zk4BwLyUEvtWlQouz+UYmJWSq8OfSib2Uej5yZo4WGO//6+adqKoLob3foSAA9WNXTAP
         PPGT9lmGM7+XU4kCsGUYMEqGJOUhZvTwN+/VXZ+tJYMzRBknZRXOvg/AcGFEF8A8LlH4
         wuaA==
X-Gm-Message-State: ACgBeo39fwXQ3a2yDKBNGHvdpSYYJZrTRzjaZV8Zlsw3EQah3aj625dv
        OqOBPXkBCCPI6gNJ3F5Lww7uRHUPo1J+41oM7svFiTPhCJ3t/Zn0xiTmhOzyQVKqlyQylxupLT2
        d+afUCWutqUq65G0u+1rb
X-Received: by 2002:ac8:7d90:0:b0:35b:b5b2:e05a with SMTP id c16-20020ac87d90000000b0035bb5b2e05amr8380042qtd.513.1663083388390;
        Tue, 13 Sep 2022 08:36:28 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5GDiBHFk4c7ypB1LYj9McIq496tHMayFui8OElEfeMq6i67fxDdoxJRWzwmy07p5pKmqbG+Q==
X-Received: by 2002:ac8:7d90:0:b0:35b:b5b2:e05a with SMTP id c16-20020ac87d90000000b0035bb5b2e05amr8380019qtd.513.1663083388118;
        Tue, 13 Sep 2022 08:36:28 -0700 (PDT)
Received: from [10.19.60.33] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id i2-20020a05620a248200b006bba46e5eeasm10340551qkn.37.2022.09.13.08.36.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 08:36:26 -0700 (PDT)
Message-ID: <6da609ed-13f8-9cc7-b988-ad46d3f9ed93@redhat.com>
Date:   Tue, 13 Sep 2022 11:36:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2] libnfs4acl: Check file mode before getxattr call
Content-Language: en-US
To:     Kenneth Dsouza <kdsouza@redhat.com>, linux-nfs@vger.kernel.org
References: <20220811194834.470072-1-kdsouza@redhat.com>
 <CAA_-hQKTjLzm6vzdna-3kSas8BZ=0Ug2axLm-T20bNQMG1iR+w@mail.gmail.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <CAA_-hQKTjLzm6vzdna-3kSas8BZ=0Ug2axLm-T20bNQMG1iR+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 9/12/22 2:24 PM, Kenneth Dsouza wrote:
> ping
Sorry about that... Thanks for the ping!

> 
> On Fri, Aug 12, 2022 at 1:19 AM Kenneth D'souza <kdsouza@redhat.com> wrote:
>>
>> Currently we are checking file mode after getxattr call.
>> Due to this the return value would be 0, which would change the getxattr return value.
>> As xattr_size will be 0, nfs4_getfacl will fail with error EINVAL.
>> This patch fixes this issue by moving the file mode check before
>> getxattr call.
>>
>> Signed-off-by: Kenneth D'souza <kdsouza@redhat.com>
Committed... (tag: nfs4-acl-tools-0.4.1-rc2)

steved.
>> ---
>>   libnfs4acl/nfs4_getacl.c | 14 +++++++-------
>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/libnfs4acl/nfs4_getacl.c b/libnfs4acl/nfs4_getacl.c
>> index 7821da3..aace5cd 100644
>> --- a/libnfs4acl/nfs4_getacl.c
>> +++ b/libnfs4acl/nfs4_getacl.c
>> @@ -39,6 +39,13 @@ static struct nfs4_acl *nfs4_getacl_byname(const char *path,
>>                  return NULL;
>>          }
>>
>> +       ret = stat(path, &st);
>> +       if (ret == -1)
>> +               goto err;
>> +
>> +       if (S_ISDIR(st.st_mode))
>> +               iflags = NFS4_ACL_ISDIR;
>> +
>>          /* find necessary buffer size */
>>          ret = getxattr(path, xattr_name, NULL, 0);
>>          if (ret == -1)
>> @@ -53,13 +60,6 @@ static struct nfs4_acl *nfs4_getacl_byname(const char *path,
>>          if (ret == -1)
>>                  goto err_free;
>>
>> -       ret = stat(path, &st);
>> -       if (ret == -1)
>> -               goto err_free;
>> -
>> -       if (S_ISDIR(st.st_mode))
>> -               iflags = NFS4_ACL_ISDIR;
>> -
>>          acl = acl_nfs41_xattr_load(buf, ret, iflags, type);
>>
>>          free(buf);
>> --
>> 2.31.1
>>
> 

