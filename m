Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5963B5FA241
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Oct 2022 18:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiJJQ46 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Oct 2022 12:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJJQ46 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Oct 2022 12:56:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4154B15A2D
        for <linux-nfs@vger.kernel.org>; Mon, 10 Oct 2022 09:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665421016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uPO6cayUxn155KLqJqdjdaVBf5rRxmPDtlmd3DNG1vQ=;
        b=h6ggHxYFMm/1Xspy8BpjDL8toqfhzIlw+HJpv1zCIfKSZgd+/wMR0J5jxA6Yj6EqlZ5PdV
        lGkH0acXCWbc0HrnTmXtPDQQXE2eXOHDqFzyMY3rJdnPN+JbBrmwjSbRMqSHARoPN2SxE4
        O/teFOkdE/6UAvaMh2EzLMk7qgAS7h8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-68-wvVq7o4pM5ShBvTFeQTkQw-1; Mon, 10 Oct 2022 12:56:55 -0400
X-MC-Unique: wvVq7o4pM5ShBvTFeQTkQw-1
Received: by mail-wm1-f70.google.com with SMTP id h10-20020a1c210a000000b003c56437e529so666833wmh.2
        for <linux-nfs@vger.kernel.org>; Mon, 10 Oct 2022 09:56:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPO6cayUxn155KLqJqdjdaVBf5rRxmPDtlmd3DNG1vQ=;
        b=3QSiQcE9cUhnubYbk1b5mHSGb6tgE4jWxQwK7oMK016cUKnxLnCNv2/WTRdxGx6MPW
         CIGO3gKHpopZcUevtoatxRL/DlsKxuyk+3SpN/d5a535tuZ44Ed+WcUmxAprGfxGq6hs
         5suWPL8Y/ZRQTdWwyXPczboa4fBpxQxR93K1Oia4WSldfAnpJXr0ukgSQQY+qTDp9B+X
         oXzQnJNB7bhmcllXKUDGGAMHCmXlbsgCNMMQ3SUvNoDjiHcryTfSuIxiJgztWyW7wMtC
         DgJdudIvIiEyKpMk3D0YXom3Me+kAUGENO5cWsaEYA6U6JDAV5nQpTPsk2OSSf1kUGvM
         QsnQ==
X-Gm-Message-State: ACrzQf1pTUZ4kJBHRTNzsAgAvK7vmf0vByVyuL8aHon4F8fiYmdpoQNl
        +w2uFtkY5lcVv67BBhHrv5DZfaF388pXOU+moJCRyCGdQcYPGTvc8BNwRXk08svivdABllcSDaW
        o6TMrUcudlSEFNGPxss8N
X-Received: by 2002:a05:600c:444b:b0:3b4:cb9e:bd93 with SMTP id v11-20020a05600c444b00b003b4cb9ebd93mr13574576wmn.39.1665421014075;
        Mon, 10 Oct 2022 09:56:54 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5fXr93j8YeAAeRCYTP9zLYutOx0m1LJxEDAvCjw5S6wtZzJyM7dyyUi1MAqv5PuSdt+EaZ9A==
X-Received: by 2002:a05:600c:444b:b0:3b4:cb9e:bd93 with SMTP id v11-20020a05600c444b00b003b4cb9ebd93mr13574567wmn.39.1665421013879;
        Mon, 10 Oct 2022 09:56:53 -0700 (PDT)
Received: from ibm-p9z-18-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com (ti0005q162-1960.bb.online.no. [212.251.164.190])
        by smtp.gmail.com with ESMTPSA id v132-20020a1cac8a000000b003a541d893desm10924420wme.38.2022.10.10.09.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 09:56:52 -0700 (PDT)
Date:   Mon, 10 Oct 2022 18:56:50 +0200
From:   Guillaume Nault <gnault@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>
Subject: Re: [PATCH v2] sunrpc: Use GFP_NOFS to prevent use of
 current->task_frag.
Message-ID: <20221010165650.GA3456@ibm-p9z-18-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com>
References: <de6d99321d1dcaa2ad456b92b3680aa77c07a747.1665401788.git.gnault@redhat.com>
 <Y0QyYV1Wyo4vof70@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0QyYV1Wyo4vof70@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Oct 10, 2022 at 07:55:29AM -0700, Christoph Hellwig wrote:
> On Mon, Oct 10, 2022 at 01:41:57PM +0200, Guillaume Nault wrote:
> > However, ->sk_allocation isn't used just by the memory allocator.
> > In particular, sk_page_frag() uses it to figure out if it can return
> > the page_frag from current or if it has to use the socket one.
> 
> Well, that just means sk_page_frag really needs to look at
> PF_MEMALLOC_* as well.  So instead of reverting the proper change
> please fix that.  A helper that looks at sk_allocation and
> current->flags is probably the right way to deal with that.

That's what my RFC patch did. It was rejected because reading
current->flags may incur a cache miss thus slowing down TCP fast path.
See the discussion in the Link tag:
https://lore.kernel.org/netdev/b4d8cb09c913d3e34f853736f3f5628abfd7f4b6.1656699567.git.gnault@redhat.com/

