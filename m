Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DFF788B5B
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Aug 2023 16:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbjHYOOG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Aug 2023 10:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343709AbjHYONx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Aug 2023 10:13:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E2A2682
        for <linux-nfs@vger.kernel.org>; Fri, 25 Aug 2023 07:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692972695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vbKQBDak5hl4LAl/oQgyykEHIqEzzDyXxUCIsWAfmDA=;
        b=Nn2gMMnXZmOpW0mfRbj8+85NH5cRWGPAljMvik9gVK+YMWEbu8RGUIVTsCTDJFaIQCNzke
        LK2Iv2tOCX/cQYvH1Zeqw5832XbEhW+p41fm/aUf/z+BqgJpNlOSH+v4c01jriVkWHemhQ
        poQqBM4SFlIkBmXMdOK7yva+QhvVDQo=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-uy7Mx6yjP9aKWl79V55IYQ-1; Fri, 25 Aug 2023 10:11:33 -0400
X-MC-Unique: uy7Mx6yjP9aKWl79V55IYQ-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-55afcc54d55so2027655a12.0
        for <linux-nfs@vger.kernel.org>; Fri, 25 Aug 2023 07:11:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692972691; x=1693577491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbKQBDak5hl4LAl/oQgyykEHIqEzzDyXxUCIsWAfmDA=;
        b=Tume5WJNg0YzhtH8qO6tLO0x2IYjp9TqNbOvB9+/fEbq6QL6DhtNM1ZZVlHEBCjWT3
         6T068/09NJ0LLd8xgnYUOdCUCdNidQFLc/JQ7OeECJqtaVgNJObCCJQG2NvAAycph2nW
         klB9BWPDS9NdR7unr7rMSVYWVDV/ONQ3vKjdfLBzYQso7UmZzSSjRyocfPdsgrBqxZob
         0PYb0gq0zGGxilmUO9B9JsapPRN5PcMO360tgEzPjGleAHH30skIcn26PBUNBamu/Rqo
         MK1aYdIilPisP5jhuoMojJLAeGHGW6LNldfGsT7anxa80dYCJSik4/FPmxzAU5h4mi4I
         M2RA==
X-Gm-Message-State: AOJu0YwV4hP7n3fr+A6v9EwLOrT8e44zvjq5iaJrxEubpvRAMWlE6the
        2PZC8muomUcQsddx5GMXSO0zbjmNHOGWRMpnOIkK5MoYC3m5MF6Zk4PMmn3T9GirSdtX8XLKKNt
        9EBAOUIxsAbqDEjXw4LxPfNW1sBoJEeY=
X-Received: by 2002:a17:90b:378f:b0:26b:374f:97c2 with SMTP id mz15-20020a17090b378f00b0026b374f97c2mr27791105pjb.6.1692972689492;
        Fri, 25 Aug 2023 07:11:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9Zc5uEZF4xZ2onoUZA2BvHZjsLlVtg14k+brKht9HvqHaz/Zv4GjWBRyj/R5XzcIugOYQqg==
X-Received: by 2002:a17:90b:378f:b0:26b:374f:97c2 with SMTP id mz15-20020a17090b378f00b0026b374f97c2mr27790951pjb.6.1692972687482;
        Fri, 25 Aug 2023 07:11:27 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d24-20020a17090ac25800b00263ba6a248bsm3563040pjx.1.2023.08.25.07.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 07:11:27 -0700 (PDT)
Date:   Fri, 25 Aug 2023 22:11:23 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     fstests@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH fstests v2 2/3] generic/513: limit to filesystems that
 support capabilities
Message-ID: <20230825141123.wexv7kuxk75gr5os@zlang-mailbox>
References: <20230824-fixes-v2-0-d60c2faf1057@kernel.org>
 <20230824-fixes-v2-2-d60c2faf1057@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824-fixes-v2-2-d60c2faf1057@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Aug 24, 2023 at 12:44:18PM -0400, Jeff Layton wrote:
> This test requires being able to set file capabilities which some
> filesystems (namely NFS) do not support. Add a _require_setcap test
> and only run it on filesystems that pass it.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  common/rc         | 13 +++++++++++++
>  tests/generic/513 |  1 +
>  2 files changed, 14 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 5c4429ed0425..33e74d20c28b 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -5048,6 +5048,19 @@ _require_mknod()
>  	rm -f $TEST_DIR/$seq.null
>  }
>  
> +_require_setcap()
> +{
> +	local testfile=$TEST_DIR/setcaptest.$$
> +
> +	touch $testfile
> +	$SETCAP_PROG "cap_sys_module=p" $testfile > $testfile.out 2>&1

Actually we talked about the capabilities checking helper last year, as below:

https://lore.kernel.org/fstests/20220323023845.saj5en74km7aibdx@zlang-mailbox/

As you bring this discussion back, how about the _require_capabilities() in
above link?

Thanks,
Zorro

> +	if grep -q 'Operation not supported' $testfile.out; then
> +	  _notrun "File capabilities are not supported on this filesystem"
> +	fi
> +
> +	rm -f $testfile $testfile.out
> +}
> +
>  _getcap()
>  {
>  	$GETCAP_PROG "$@" | _filter_getcap
> diff --git a/tests/generic/513 b/tests/generic/513
> index dc082787ae4e..52f9eb916b4a 100755
> --- a/tests/generic/513
> +++ b/tests/generic/513
> @@ -18,6 +18,7 @@ _supported_fs generic
>  _require_scratch_reflink
>  _require_command "$GETCAP_PROG" getcap
>  _require_command "$SETCAP_PROG" setcap
> +_require_setcap
>  
>  _scratch_mkfs >>$seqres.full 2>&1
>  _scratch_mount
> 
> -- 
> 2.41.0
> 

