Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF9C5B601A
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Sep 2022 20:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiILSZI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Sep 2022 14:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiILSZH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Sep 2022 14:25:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEBC12765
        for <linux-nfs@vger.kernel.org>; Mon, 12 Sep 2022 11:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663007103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w/O2152acNybUnF11LgP+w0G6ZjcUKAQ0WKD5UpZ9TI=;
        b=iqcmtZmBTOd8dCnoL3aK4hqdsxX824pEhPxwH5CqD15AVwO8nXgATjghMGDHELHVVeJg0w
        W8ZnTiK6EtHbBN4Mn8Sn7XgylY80G4yxr05usDHDkrae2leAGZBlXvCh7otAjYw93Sp5LX
        E+kQjSXM98T1YwPfR1ZEtMKxvImppqI=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-70-KNH18GS8M8SZvJ9IlvXgUA-1; Mon, 12 Sep 2022 14:25:02 -0400
X-MC-Unique: KNH18GS8M8SZvJ9IlvXgUA-1
Received: by mail-il1-f199.google.com with SMTP id d7-20020a056e02214700b002f3cbbcc8cbso3202937ilv.7
        for <linux-nfs@vger.kernel.org>; Mon, 12 Sep 2022 11:25:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=w/O2152acNybUnF11LgP+w0G6ZjcUKAQ0WKD5UpZ9TI=;
        b=BmE4X/M4of4JzdWy0CB8S/tSusfbPFUVjI4H44tlYRNp+GY7OoQvwikIouIbT6RBl7
         k8U9gCfS2yCZJyF3HP0ORx0xkVXXPdOtzYZIna6a7T1JrPdKOkzwxtyY9P1tQPB83auT
         ojAHUHtbLXfcAamFfIUQRWNcC76FfbwKntWcKgYK5CFQ9HqRQCYETjnIRkV1H9CvPeEX
         2SWq4R0qTl+DXPlbutMlZfAJ42v4V0nvrJPCDJ03QxNUgN+7W4ST77jUGldgFHRJHNWu
         xZYwULSTJ/X1pTcuhNqmMcvdz1Zav8moP0CH81n6IaA3Ju7j+4AvpTeKismYsifhRBdi
         l12A==
X-Gm-Message-State: ACgBeo2T4YsPkpxGtWBazqxrNPROvVcd1/7VL8gR1xnXj6QdtnuZesKO
        JEku0Axz601L0WstPKjc0G+3Fy6gZmZD3zikleIWVoack+9q5dDtwmhwqcYYzcWbfB+3O4Wmf11
        fV2Bog08sSjEkqb5MUuRCb05pA8umqFj/+RF/
X-Received: by 2002:a02:cf06:0:b0:358:341c:92c4 with SMTP id q6-20020a02cf06000000b00358341c92c4mr12722834jar.39.1663007099879;
        Mon, 12 Sep 2022 11:24:59 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4uEEHXxhwgf1uh5K6LNKoDUyhV73IsrZOdLHl0ShaR7ItxaPNr+fRVZ2tw1iBjvpOxFx7DP9QNb8SOAOH1VuY=
X-Received: by 2002:a02:cf06:0:b0:358:341c:92c4 with SMTP id
 q6-20020a02cf06000000b00358341c92c4mr12722827jar.39.1663007099681; Mon, 12
 Sep 2022 11:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220811194834.470072-1-kdsouza@redhat.com>
In-Reply-To: <20220811194834.470072-1-kdsouza@redhat.com>
From:   Kenneth Dsouza <kdsouza@redhat.com>
Date:   Mon, 12 Sep 2022 23:54:48 +0530
Message-ID: <CAA_-hQKTjLzm6vzdna-3kSas8BZ=0Ug2axLm-T20bNQMG1iR+w@mail.gmail.com>
Subject: Re: [PATCH v2] libnfs4acl: Check file mode before getxattr call
To:     linux-nfs@vger.kernel.org
Cc:     steved@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

ping

On Fri, Aug 12, 2022 at 1:19 AM Kenneth D'souza <kdsouza@redhat.com> wrote:
>
> Currently we are checking file mode after getxattr call.
> Due to this the return value would be 0, which would change the getxattr return value.
> As xattr_size will be 0, nfs4_getfacl will fail with error EINVAL.
> This patch fixes this issue by moving the file mode check before
> getxattr call.
>
> Signed-off-by: Kenneth D'souza <kdsouza@redhat.com>
> ---
>  libnfs4acl/nfs4_getacl.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/libnfs4acl/nfs4_getacl.c b/libnfs4acl/nfs4_getacl.c
> index 7821da3..aace5cd 100644
> --- a/libnfs4acl/nfs4_getacl.c
> +++ b/libnfs4acl/nfs4_getacl.c
> @@ -39,6 +39,13 @@ static struct nfs4_acl *nfs4_getacl_byname(const char *path,
>                 return NULL;
>         }
>
> +       ret = stat(path, &st);
> +       if (ret == -1)
> +               goto err;
> +
> +       if (S_ISDIR(st.st_mode))
> +               iflags = NFS4_ACL_ISDIR;
> +
>         /* find necessary buffer size */
>         ret = getxattr(path, xattr_name, NULL, 0);
>         if (ret == -1)
> @@ -53,13 +60,6 @@ static struct nfs4_acl *nfs4_getacl_byname(const char *path,
>         if (ret == -1)
>                 goto err_free;
>
> -       ret = stat(path, &st);
> -       if (ret == -1)
> -               goto err_free;
> -
> -       if (S_ISDIR(st.st_mode))
> -               iflags = NFS4_ACL_ISDIR;
> -
>         acl = acl_nfs41_xattr_load(buf, ret, iflags, type);
>
>         free(buf);
> --
> 2.31.1
>

