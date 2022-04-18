Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6505504B21
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Apr 2022 05:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbiDRDHF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 17 Apr 2022 23:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiDRDHE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 17 Apr 2022 23:07:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0905418B06
        for <linux-nfs@vger.kernel.org>; Sun, 17 Apr 2022 20:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650251064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kqhFZT5SobYTnPgdFY0kzfO4S6KCKic7s1jHUjYq5VQ=;
        b=QZQXczM4R/+uLIMc9MyttOz/6ZNaa84TlU1IfO2JBX+GS6PKRknApoawALAVAHjxWHxoqi
        MdxolFav9EFudsxK2kMHq2cx8f+I56OAa4uVXG+MtZHMNWmGaPCfZKTWojvxnhnjPbasw/
        qbBqjfULeqqGpdKs+NVzmDoM4KfK3iQ=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-3-bkYPk-2fOX29XqRWqVFyDg-1; Sun, 17 Apr 2022 23:04:22 -0400
X-MC-Unique: bkYPk-2fOX29XqRWqVFyDg-1
Received: by mail-pg1-f197.google.com with SMTP id 78-20020a630651000000b0039d993c3c55so7982721pgg.14
        for <linux-nfs@vger.kernel.org>; Sun, 17 Apr 2022 20:04:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=kqhFZT5SobYTnPgdFY0kzfO4S6KCKic7s1jHUjYq5VQ=;
        b=bGn0wHbtzINZ0+2Zffo7Bl8ZFEuUQgEoA2zvtNvx+VaHaFLRjnIzvQj2RFup0kSLSw
         AnkDCNt+G9U6H+ZxRCZ9Oy+chNC6GAn/fJZZEXHw2HUPnNQ8klorqzY3wcXqv+lQkZhg
         9fZRIjVSC4wwNWsUy/aQNY8T41VPgwVhu/Z4xpeFBFhAovhNrvujI9nBz1PBBn+q4ES/
         FP1Odv43ohryMTfoV70rerF6723Fbgjn1+eardpTgnocZ/f6+PfyRswYR3W7kYi3ejwN
         bCU44JE4qXDyFPygXSYULXIWv/66uJBs8/E3jnxmCePwnFk0t3H16WfORSmR5jTexGbu
         oepA==
X-Gm-Message-State: AOAM532NbMEn+9RFiM11KKyEbpXQZdKAtmygVJMyy7wKZWGtbKYMjVIw
        ztEELvnuqhxO80PuH4M9JlUkOG/f8p/g3V+bjdDE3HiSWFnJ2F6/IZirNZziEPnMbRaZU62UqCI
        QUacYy9cGVeYI11fgJ87R
X-Received: by 2002:a17:902:854c:b0:158:35ce:9739 with SMTP id d12-20020a170902854c00b0015835ce9739mr8880073plo.150.1650251061644;
        Sun, 17 Apr 2022 20:04:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFmGkrLS7i0nLz7OIAzvk++53AKMXfM0Mx8XUkioDfWxX6+VSI8xm58OPKZutB5XT3pPdu4w==
X-Received: by 2002:a17:902:854c:b0:158:35ce:9739 with SMTP id d12-20020a170902854c00b0015835ce9739mr8880057plo.150.1650251061397;
        Sun, 17 Apr 2022 20:04:21 -0700 (PDT)
Received: from [10.72.12.77] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id m10-20020a17090a414a00b001cb776494a5sm15419779pjg.0.2022.04.17.20.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Apr 2022 20:04:20 -0700 (PDT)
Subject: Re: [PATCH v3 7/7] ceph: Remove S_ISGID clear code in
 ceph_finish_async_create
To:     Yang Xu <xuyang2018.jy@fujitsu.com>, david@fromorbit.com,
        djwong@kernel.org, brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        viro@zeniv.linux.org.uk, jlayton@kernel.org
References: <1650020543-24908-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1650020543-24908-7-git-send-email-xuyang2018.jy@fujitsu.com>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <c26f5638-b97e-babf-3177-99fbcd4bbec2@redhat.com>
Date:   Mon, 18 Apr 2022 11:04:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1650020543-24908-7-git-send-email-xuyang2018.jy@fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 4/15/22 7:02 PM, Yang Xu wrote:
> Since vfs has stripped S_ISGID, we don't need this code any more.
>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>   fs/ceph/file.c | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 6c9e837aa1d3..8e3b99853333 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -651,10 +651,6 @@ static int ceph_finish_async_create(struct inode *dir, struct dentry *dentry,
>   		/* Directories always inherit the setgid bit. */
>   		if (S_ISDIR(mode))
>   			mode |= S_ISGID;
> -		else if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP) &&
> -			 !in_group_p(dir->i_gid) &&
> -			 !capable_wrt_inode_uidgid(&init_user_ns, dir, CAP_FSETID))
> -			mode &= ~S_ISGID;

Could you point me where has done this for ceph ?

-- Xiubo


>   	} else {
>   		in.gid = cpu_to_le32(from_kgid(&init_user_ns, current_fsgid()));
>   	}

