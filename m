Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885FB78F7EF
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Sep 2023 07:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348227AbjIAFPa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Sep 2023 01:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345883AbjIAFPa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Sep 2023 01:15:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C1E10C7
        for <linux-nfs@vger.kernel.org>; Thu, 31 Aug 2023 22:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693545285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GHEkg5etuCJBxRlFV9m9y4/3lnWWZvbQz9Kgowny85Q=;
        b=XGrVlqzG0XS7rXU4nlMLdOtyA7+1asrgslUh+oSFAaTtWWffhGLyeb2LJvHFkOM8qp2RjW
        b+9Si2W/5JePtwjpm0d27DY1Q1yWYSfYrG5T7UziNs6yEWcqr/YGnws7Bb8mPlUrA6yZcD
        I8Umu0mPsArzpYbucd5GeRyWHoGK9uc=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-nXTrm2r2PcG4MJj8j_WJAQ-1; Fri, 01 Sep 2023 01:14:43 -0400
X-MC-Unique: nXTrm2r2PcG4MJj8j_WJAQ-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-34bb89fa29eso9637845ab.3
        for <linux-nfs@vger.kernel.org>; Thu, 31 Aug 2023 22:14:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693545283; x=1694150083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHEkg5etuCJBxRlFV9m9y4/3lnWWZvbQz9Kgowny85Q=;
        b=KWSW/xwvYV69EoZ93tRfROKAul9aZOUSXlShGs+fwhEGaFi687Jy1x3fkv+tNjAua0
         8NJ9fgYIo3V/QAwn9IVjMIv6kYNRk5AGXYD4dSKxVS7gD8aOf9h7TnBOOONbaWHXoE27
         zQUfhTEQCeAoEgvJJPflkH4SqUswdJNClXjnkDyB/K3ZOJg0tX1l9l4xjZukW+KQryqU
         D0Bnp8ixuXULWG8cqiTupAcnEyu9aU9rAXJSLsOcTkyhuRRSNvLyaQMxqfjQA+dzRQcl
         PAHXVnSv6pB/Jy5orVJL4/3RMBw2Ph9GtvbK+KmtvY6KHUn/CxW8Uhwn9y6SDYKr9Uaz
         vCaw==
X-Gm-Message-State: AOJu0YzLQlRDHOfYE8EzvXgSzPH6gI61VugGbN3E78XKEiTM+uxV11EZ
        aRjjRbpj5800P5DAKW8SH1AIEsouUsb+qdnjTdMe3htf0BaN9VyK2/A2DqZiOvNmc97bELRxq3b
        NitBCsg2ZG+8v05hHyqgj
X-Received: by 2002:a92:c144:0:b0:34c:cc37:3064 with SMTP id b4-20020a92c144000000b0034ccc373064mr1729121ilh.15.1693545282869;
        Thu, 31 Aug 2023 22:14:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFm1O89Ri4TQyQNfpT5+w0sJ3E/uQVXKi3e8LsI5uu3LznX2mZvNh4qtJVaoJY/gHuZDDHJuA==
X-Received: by 2002:a92:c144:0:b0:34c:cc37:3064 with SMTP id b4-20020a92c144000000b0034ccc373064mr1729115ilh.15.1693545282633;
        Thu, 31 Aug 2023 22:14:42 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q1-20020a639801000000b0056946623d7esm2028377pgd.55.2023.08.31.22.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 22:14:42 -0700 (PDT)
Date:   Fri, 1 Sep 2023 13:14:39 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     fstests@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH fstests 1/3] generic/294: don't run this test on NFS
Message-ID: <20230901051439.j5jduasrkmh67g6g@zlang-mailbox>
References: <20230831-nfs-skip-v1-0-d54c1c6a9af2@kernel.org>
 <20230831-nfs-skip-v1-1-d54c1c6a9af2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831-nfs-skip-v1-1-d54c1c6a9af2@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Aug 31, 2023 at 02:40:28PM -0400, Jeff Layton wrote:
> When creating a new dentry (of any type), NFS will optimize away any
> on-the-wire lookups prior to the create since that means an extra
> round trip to the server. Because of that, it consistently fails this
> test.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  tests/generic/294 | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tests/generic/294 b/tests/generic/294
> index 406b1b3954b9..777b62aec9ad 100755
> --- a/tests/generic/294
> +++ b/tests/generic/294
> @@ -15,6 +15,10 @@ _begin_fstest auto quick
>  
>  # real QA test starts here
>  
> +# NFS will optimize away the on-the-wire lookup before attempting to
> +# create a new file (since that means an extra round trip).
> +test $FSTYP = "nfs"  && _notrun "NFS optmizes away lookups on exclusive creates"
> +
>  # Modify as appropriate.
>  _supported_fs generic

I don't know if nfs-list wants to skip these test cases on nfs. Anyway, if
there's not an objection from nfs team, the _supported_fs helper can use
a black list, likes:

  _supported_fs ^nfs

If a test case doesn't support nfs totally, you can use this and give it a
proper comment.

Thanks,
Zorro

>  _require_scratch
> 
> -- 
> 2.41.0
> 

