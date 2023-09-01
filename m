Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B686379026F
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Sep 2023 21:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237874AbjIATUm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Sep 2023 15:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjIATUl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Sep 2023 15:20:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2961B10E0
        for <linux-nfs@vger.kernel.org>; Fri,  1 Sep 2023 12:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693595991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ii5r/vAZeC09QugrQGe43ZgTvqdA6stlmbbV37mQ7qI=;
        b=Uf234oilqmsu4sqRB5Gy4HsdY9CldKbW/t9yozO9zVj6AvhwrLogegBQutH7Dv7mvIKSlz
        tmT7aK9DuSH7fnDPIdTVHumZ/BekYoGEqFsq6fgbgdGF6cryUSjCO2rb+ZWCfpOlP+4kNq
        Ur1NnFoeVSFI3jcMLnkNmF+qkPmdE9g=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-bHM6FKbmPxqUUtiT7HGfJw-1; Fri, 01 Sep 2023 15:19:49 -0400
X-MC-Unique: bHM6FKbmPxqUUtiT7HGfJw-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1bf681d3d04so28406325ad.2
        for <linux-nfs@vger.kernel.org>; Fri, 01 Sep 2023 12:19:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693595988; x=1694200788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ii5r/vAZeC09QugrQGe43ZgTvqdA6stlmbbV37mQ7qI=;
        b=VrsVKhvkIabjG5ZD4tbDTd3zxsB/nsgQDAyifA0miDNfSBV4zvHTdZWqIZcuZT7bN2
         TKqry9AFCQWkZiXiLolm/J7/SYBg5PUpvcEtH7SB+6fgItc6L7u5KLy0HCHIwmnnhKVx
         pr0s5b2BKpWllzTjzupnnS3TkXsa6559uWiIKJ8P6ijXp8iQFBM2RUCzY53BuQG9Intf
         VWv0/Y69nDUpCJwQGFyCBZPhjhSPxHCdjMtb0ZQkuwQEMdzGfz5nTaj4BBSigZPcaj5Z
         OmBsoV7HfEAFKyyQ6WUdE4rtfLUHllQKcjGU9s3Pu70QTaykIH/aacLkXh8vx37fBn7r
         30Tg==
X-Gm-Message-State: AOJu0YxInBO891Q54GGVRgOq1Pf45hSgvl5waV06vL7NL7Y2cSMBuLns
        AKInpiWpqmxxs64Tc/dkJQnkbewKhS/jsSWnCO3inM3RtZf30AqRERUQ1/G+SOXx88zPVc5qrtb
        qH8otC1IMyLagGNaT4+DE
X-Received: by 2002:a17:903:26ce:b0:1c0:cb4d:df7c with SMTP id jg14-20020a17090326ce00b001c0cb4ddf7cmr3249870plb.1.1693595988589;
        Fri, 01 Sep 2023 12:19:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBaKoMCKJ5v4n2H3VRQR/QtqSmbTiMKjaVnooQCXzx4f3LJJLCpbCzMitdrg1mvNNXT8pf5A==
X-Received: by 2002:a17:903:26ce:b0:1c0:cb4d:df7c with SMTP id jg14-20020a17090326ce00b001c0cb4ddf7cmr3249856plb.1.1693595988340;
        Fri, 01 Sep 2023 12:19:48 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id f14-20020a170902684e00b001b04c2023e3sm3359756pln.218.2023.09.01.12.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 12:19:47 -0700 (PDT)
Date:   Sat, 2 Sep 2023 03:19:44 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     fstests@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH fstests v2 1/3] generic/294: don't run this test on NFS
Message-ID: <20230901191944.lx3b643f2bwmcn3t@zlang-mailbox>
References: <20230901-nfs-skip-v2-0-9eccd59bc524@kernel.org>
 <20230901-nfs-skip-v2-1-9eccd59bc524@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901-nfs-skip-v2-1-9eccd59bc524@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Sep 01, 2023 at 01:39:55PM -0400, Jeff Layton wrote:
> When creating a new dentry (of any type), NFS will optimize away any
> on-the-wire lookups prior to the create since that means an extra
> round trip to the server. Because of that, it consistently fails this
> test.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  tests/generic/294 | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/294 b/tests/generic/294
> index 406b1b3954b9..46c7001234a5 100755
> --- a/tests/generic/294
> +++ b/tests/generic/294
> @@ -15,8 +15,10 @@ _begin_fstest auto quick
>  
>  # real QA test starts here
>  
> -# Modify as appropriate.
> -_supported_fs generic
> +# NFS will optimize away the on-the-wire lookup before attempting to
> +# create a new file (since that means an extra round trip).
> +_supported_fs ^nfs generic

If we use black list, don't need to use "generic" to specify white list. E.g.

  $ grep -rsn _supported_fs tests/generic/|grep \\^
  tests/generic/699:25:_supported_fs ^overlay
  tests/generic/631:41:_supported_fs ^overlay
  tests/generic/679:27:_supported_fs ^xfs
  tests/generic/500:45:_supported_fs ^btrfs

Anyway, others look good to me, if no objection from nfs list, I can help
to merge this patchset without the "generic" :)

Thanks,
Zorro

> +
>  _require_scratch
>  _require_symlinks
>  _require_mknod
> 
> -- 
> 2.41.0
> 

