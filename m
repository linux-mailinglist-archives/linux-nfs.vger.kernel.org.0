Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437E6564E04
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Jul 2022 08:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiGDGzo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Jul 2022 02:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiGDGzn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Jul 2022 02:55:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07C6D2DE3
        for <linux-nfs@vger.kernel.org>; Sun,  3 Jul 2022 23:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656917740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D9SwbHm7cG4MvIR+YuKlAAPf8+jWvK9nWP+79bQ7ngw=;
        b=JeYDRRVCAvjyYJE6Z2pkdE+SJar++hIrCwKEsQ8wQVlj0az0Rt51MaHrhDt+XVwnQrANwq
        Ti/DUpV3ocB7YkxgJzRLqSX+LJ8M9KTP20wrVzLxh4zLcn4SAwHvfepq9YlIv44jxg1GL4
        t7IvANRF91JF9xEKnWKCXs75F313gQ8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-350-cTaQ-f4gNCynsqUtUYKluw-1; Mon, 04 Jul 2022 02:55:40 -0400
X-MC-Unique: cTaQ-f4gNCynsqUtUYKluw-1
Received: by mail-qt1-f199.google.com with SMTP id q21-20020ac84115000000b0031bf60d9b35so6111593qtl.4
        for <linux-nfs@vger.kernel.org>; Sun, 03 Jul 2022 23:55:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D9SwbHm7cG4MvIR+YuKlAAPf8+jWvK9nWP+79bQ7ngw=;
        b=1lUYbGtrhMFysepCLXu5S7xKcj1F+dD044Qway5w2CHBYlUK4+7eooN0RBmwBzuIGk
         SpgVdVFxiEUhM6UGSBJV8C0uTUH/IOy3Cx/2Cow1FcwZTTHE8fhVhSaNH+19Qp7bZOnF
         cJh19Cf6CRt/yoyn7puQr8A9HDLUWgtf5RlmU9M8LTF/nctlxK6ltexzizQSvJaQykly
         yNH1LN0E4vOAMG1Rwvg28mfD9slHOa3TlEXy/UtU86jgLKBJcUz+G7ZOWin2NwMnAX2+
         d/YeHW2GD146FvuusAojFjKOx4nLDES+qEX5MswcWPNgT+TaH7ZCdtWsKyZPDe119Gts
         /R6g==
X-Gm-Message-State: AJIora82FYVLFpAVn3aJQ19H5fw0tVqZBZgUWY46FzG9Icv8sxyH3ujj
        VPbN/sFtUg3dQcgJzLAhxa9TiKhdUJmjnzDiNWffiuQ4qOcfnaMN8sntt8jcY2N9+dJUYWY88gg
        G8MoTELlUmCBcdTb1Fzra
X-Received: by 2002:a05:620a:4708:b0:6b1:68c8:541e with SMTP id bs8-20020a05620a470800b006b168c8541emr17711899qkb.748.1656917739295;
        Sun, 03 Jul 2022 23:55:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uu8gHFrqvbN79QiGlHM6X0XTA9zvbkUmGuB2MUUVAfNDJ3FXYDsAMG2QpOGiK6QIS+7b8WIQ==
X-Received: by 2002:a05:620a:4708:b0:6b1:68c8:541e with SMTP id bs8-20020a05620a470800b006b168c8541emr17711890qkb.748.1656917739041;
        Sun, 03 Jul 2022 23:55:39 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c21-20020ac87d95000000b003172da668desm21341187qtd.50.2022.07.03.23.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 23:55:38 -0700 (PDT)
Date:   Mon, 4 Jul 2022 14:55:33 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, anna.schumaker@netapp.com,
        bfields@fieldses.org
Subject: Re: [PATCH v2] SUNRPC: Fix READ_PLUS crasher
Message-ID: <20220704065533.pfpvpn7ihxs7vagf@zlang-mailbox>
References: <165662209842.1459.4593520026847863736.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165662209842.1459.4593520026847863736.stgit@klimt.1015granger.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 30, 2022 at 04:48:18PM -0400, Chuck Lever wrote:
> Looks like there are still cases when "space_left - frag1bytes" can
> legitimately exceed PAGE_SIZE. Ensure that xdr->end always remains
> within the current encode buffer.
> 
> Reported-by: Bruce Fields <bfields@fieldses.org>
> Reported-by: Zorro Lang <zlang@redhat.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216151
> Fixes: 6c254bf3b637 ("SUNRPC: Fix the calculation of xdr->end in xdr_get_next_encode_buffer()")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---

I can't reproduce this bug by merging this patch:

FSTYP         -- nfs
PLATFORM      -- Linux/x86_64 ibm-xxxxx-08 5.19.0-rc4+ #1 SMP PREEMPT_DYNAMIC Sat Jul 2 09:59:50 EDT 2022
MKFS_OPTIONS  -- ibm-xxxxx-xx.xxx.xxx.xxx.xxxxxx.com:/mnt/xfstests/scratch/nfs-server
MOUNT_OPTIONS -- -o vers=4.2 -o context=system_u:object_r:root_t:s0 ibm-x3650m4-08.rhts.eng.pek2.redhat.com:/mnt/xfstests/scratch/nfs-server /mnt/xfstests/scratch/nfs-client

generic/465        12s
Ran: generic/465
Passed all 1 tests

>  net/sunrpc/xdr.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> index f87a2d8f23a7..5d2b3e6979fb 100644
> --- a/net/sunrpc/xdr.c
> +++ b/net/sunrpc/xdr.c
> @@ -984,7 +984,7 @@ static noinline __be32 *xdr_get_next_encode_buffer(struct xdr_stream *xdr,
>  	p = page_address(*xdr->page_ptr);
>  	xdr->p = p + frag2bytes;
>  	space_left = xdr->buf->buflen - xdr->buf->len;
> -	if (space_left - nbytes >= PAGE_SIZE)
> +	if (space_left - frag1bytes >= PAGE_SIZE)
>  		xdr->end = p + PAGE_SIZE;
>  	else
>  		xdr->end = p + space_left - frag1bytes;
> 
> 

