Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AE2756F20
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jul 2023 23:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjGQVuF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Jul 2023 17:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGQVuE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Jul 2023 17:50:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F57318C
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jul 2023 14:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689630556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SUsbOV58nTmrf8yVoHZfbYogGzZNZw+5WJGeG44s1AM=;
        b=VMUHfrGK3VeABXl6wi8LZuSvARRSalxR/ConhlWPBdNnUj85UAsIbRtKMbnY99sGH5Nb5C
        qKmIxSLr6Qyq/mLFdbzXgfeXPFSJgBUhgRZg9Cc8zdpwh8+YE23+Kxl0T3gCj1XM7Rth8N
        mOLHKeaIlnTcw5WvWRydy5H3N5ZXOVo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-vSNtojDyNZKmYRRIwqsA1Q-1; Mon, 17 Jul 2023 17:49:14 -0400
X-MC-Unique: vSNtojDyNZKmYRRIwqsA1Q-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-401e1fc831fso9031101cf.1
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jul 2023 14:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689630554; x=1692222554;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SUsbOV58nTmrf8yVoHZfbYogGzZNZw+5WJGeG44s1AM=;
        b=Ve0yQGF1fxe8yapTnJYHzt9vaWE5Eggl8j2J6nbLqKYzzUIk0y5Z5emmZmDE4O5IEl
         wCS+xnlLe7U8nPYBJKSBGNlgR0OGBIQqZzGU5nicWtA0jtmPoii0lo9s9tKFVzz/eI2i
         J2WfAOI50FDJ/U7denVjPAnblLGDpInW/nsdfYb9X8Nt1VPNcc1Mc+8pCYm5+MRE6cXM
         MZvdXQX2gNnL/vm2d3IE5nlrzEkhD6ooYb7wuoxzpmsFv3w68fV0jAtfLdcgVMSyxO/Z
         wnHl+sC3Xo2Oyj/mteTpKg2wJHUYAWTpnO4OVpKH8B0UlA/7P8pj5upEjrHApKH1augK
         Z82g==
X-Gm-Message-State: ABy/qLYXPoaBqpnbYKZbCkKKMz7gR6gw17ihC8n819PZzC4ha+/wSZ2t
        EO7K5uEXgrk2vNPMnVG4C0/6ZfnqniB3bDAABCUbGyy6zk+q5EL+bDtb+HZ09Cw5iK99O0yoRYG
        6BTsMY4/TcufPeA24N5UA
X-Received: by 2002:a05:6214:2aa8:b0:625:86ed:8ab4 with SMTP id js8-20020a0562142aa800b0062586ed8ab4mr9935683qvb.3.1689630553867;
        Mon, 17 Jul 2023 14:49:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFalgQZ4qvKzPaXLVGInV8DQnwXdKZtgu+9cFviEGWrApTb5CQt2cXQ9MyF/Dc4LUkLur+pzg==
X-Received: by 2002:a05:6214:2aa8:b0:625:86ed:8ab4 with SMTP id js8-20020a0562142aa800b0062586ed8ab4mr9935668qvb.3.1689630553530;
        Mon, 17 Jul 2023 14:49:13 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.251.231])
        by smtp.gmail.com with ESMTPSA id g15-20020a0caacf000000b006263c531f61sm222521qvb.24.2023.07.17.14.49.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 14:49:13 -0700 (PDT)
Message-ID: <b2663a92-7947-d528-b852-fab3552ea867@redhat.com>
Date:   Mon, 17 Jul 2023 17:49:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH nfs-utils] start-statd: Fix shellcheck warnings
Content-Language: en-US
To:     Salvatore Bonaccorso <carnil@debian.org>, NeilBrown <neilb@suse.de>
Cc:     linux-nfs@vger.kernel.org, Ben Hutchings <benh@debian.org>
References: <20230709072028.829990-1-carnil@debian.org>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20230709072028.829990-1-carnil@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 7/9/23 3:20 AM, Salvatore Bonaccorso wrote:
> From: Ben Hutchings <benh@debian.org>
> 
> shellcheck currently complains:
> 
> In utils/statd/start-statd line 14:
>         [ 1`cat /run/rpc.statd.pid` -gt 1 ] &&
>            ^----------------------^ SC2046 (warning): Quote this to prevent word splitting.
>            ^----------------------^ SC2006 (style): Use $(...) notation instead of legacy backticks `...`.
> 
> Did you mean:
>         [ 1$(cat /run/rpc.statd.pid) -gt 1 ] &&
> 
> In utils/statd/start-statd line 15:
>         kill -0 `cat /run/rpc.statd.pid` > /dev/null 2>&1
>                 ^----------------------^ SC2046 (warning): Quote this to prevent word splitting.
>                 ^----------------------^ SC2006 (style): Use $(...) notation instead of legacy backticks `...`.
> 
> Did you mean:
>         kill -0 $(cat /run/rpc.statd.pid) > /dev/null 2>&1
> 
> Use quotes and $() as recommended.
> 
> Signed-off-by: Ben Hutchings <benh@debian.org>
> Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
Committed (tag: nfs-utils-2-6-4-rc3)

steved.
> ---
>   utils/statd/start-statd | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/utils/statd/start-statd b/utils/statd/start-statd
> index 2baf73c385cf..b11a7d91a7f6 100755
> --- a/utils/statd/start-statd
> +++ b/utils/statd/start-statd
> @@ -11,8 +11,8 @@ exec 9> /run/rpc.statd.lock
>   flock -e 9
>   
>   if [ -s /run/rpc.statd.pid ] &&
> -       [ 1`cat /run/rpc.statd.pid` -gt 1 ] &&
> -       kill -0 `cat /run/rpc.statd.pid` > /dev/null 2>&1
> +       [ "1$(cat /run/rpc.statd.pid)" -gt 1 ] &&
> +       kill -0 "$(cat /run/rpc.statd.pid)" > /dev/null 2>&1
>   then
>       # statd already running - must have been slow to respond.
>       exit 0

