Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54767AD851
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Sep 2023 14:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbjIYM4U (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Sep 2023 08:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIYM4T (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Sep 2023 08:56:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DC6FC
        for <linux-nfs@vger.kernel.org>; Mon, 25 Sep 2023 05:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695646525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IWebPD/uKB34xJmGvJW4lS2xamPS27xaa673BfP5oZw=;
        b=jItUBm/TCgX9K7o6uodRRoffgacT6rhC/PwywO9GLD85zR50ML3S70A9dCazFF44hJcRLY
        HJqB46gbSd3BHxnkMj3P2cOoPKONv25CAJQpuv4jL1f6CDnKCXJifyD82snvX6SXaTHHt+
        +jWvEK8Iz9yo54E4QmM5QfgFs1yeSTU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-0Zc-kBL9OXOMfxlWgw5h6g-1; Mon, 25 Sep 2023 08:55:23 -0400
X-MC-Unique: 0Zc-kBL9OXOMfxlWgw5h6g-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-77422b20b13so163861185a.1
        for <linux-nfs@vger.kernel.org>; Mon, 25 Sep 2023 05:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695646523; x=1696251323;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IWebPD/uKB34xJmGvJW4lS2xamPS27xaa673BfP5oZw=;
        b=GR8bGwKLJ9udcKUUcuqoVHyETP8qDkZC8TcGgS/HDv5SDzP3wn4DlVxksz6KNlfli7
         6vFG+tyVY581QOlqcxpFIZugYTfE27o3/yoJtD1OuqJKttrJcZqxDOqgsqtIqkR5kPa6
         wuuKwh9NW85mE9G2RWFUIourlpYvCDgRN/n11RYPSQUg/kK7CLUM6a9LoK1X4lseUvUu
         7q4BbQ3Dr3D3B7lr7sbvSpFju94AzXrv6VqOcRvmchezm5UGUNio6y0rlTLYZ4zvL6GV
         ZH87zxIMS6Ks2M90WzyhK9Ig0etUxptMZZYKQ52VVDlscoD4nIgxYnaqn9hrn0pTyvp5
         Bjdw==
X-Gm-Message-State: AOJu0Yy5l42elZ2g1l5/wt6vU7aG+H1uuuBeTlfNznFbnkyXXW6dMdvO
        maTSm4Bn30aWDYTBss2IUL+s52rdNm6B3b5gooetVRig+EsHk/pC/LJxlhAG/GtpskBFutKgQuH
        eCYDYE2LpHF8RvUM8GysecWBHRich
X-Received: by 2002:a05:620a:2992:b0:76d:95d3:800f with SMTP id r18-20020a05620a299200b0076d95d3800fmr8498362qkp.3.1695646522832;
        Mon, 25 Sep 2023 05:55:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7LSZsNCzQ8VNM4jFsUaoxcHONiFUEtwgLDrIHe37YEksdGmOv+mCO7cepmDyjfeICT9JMPw==
X-Received: by 2002:a05:620a:2992:b0:76d:95d3:800f with SMTP id r18-20020a05620a299200b0076d95d3800fmr8498345qkp.3.1695646522474;
        Mon, 25 Sep 2023 05:55:22 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.164.53])
        by smtp.gmail.com with ESMTPSA id ou2-20020a05620a620200b0076768dfe53esm3752584qkn.105.2023.09.25.05.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 05:55:22 -0700 (PDT)
Message-ID: <732e6116-94c2-d246-256a-fac4f26ad504@redhat.com>
Date:   Mon, 25 Sep 2023 08:55:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Remove extraneous words left behind by commit 522837f.
Content-Language: en-US
To:     James Youngman <james@youngman.org>, linux-nfs@vger.kernel.org
Cc:     1051088@bugs.debian.org
References: <20230904085047.1053192-1-james@youngman.org>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20230904085047.1053192-1-james@youngman.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 9/4/23 4:50 AM, James Youngman wrote:
> ---
>   utils/mount/nfs.man | 1 -
>   1 file changed, 1 deletion(-)
Committed...

steved.

> 
> diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
> index 7a410422..c9850f29 100644
> --- a/utils/mount/nfs.man
> +++ b/utils/mount/nfs.man
> @@ -986,7 +986,6 @@ file. See
>   .BR nfsmount.conf(5)
>   for details.
>   .SH EXAMPLES
> -mount option.
>   To mount using NFS version 3,
>   use the
>   .B nfs

