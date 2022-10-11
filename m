Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159675FB7D6
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Oct 2022 17:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiJKP6L convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Tue, 11 Oct 2022 11:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiJKP55 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Oct 2022 11:57:57 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3292333A09
        for <linux-nfs@vger.kernel.org>; Tue, 11 Oct 2022 08:57:56 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id bb5so3170272qtb.11
        for <linux-nfs@vger.kernel.org>; Tue, 11 Oct 2022 08:57:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hNevc5MwbeWbbnLtkW4ygH2sRLSAP5bKJ05Qc4volRo=;
        b=UYgWeMc+xAGD0hiceSjpj98dbpQEws29oMeOfBxAcWceATsgZ9SJlpeEKknACSueyV
         KpP6LU2+Zzo+qUcir3I2z6bu8TFC4/a/FADBy/xlE1soSpFjgp9pLXace2E3ByiWPJRm
         e3j8itAwmkcgZVw8RqX7s7P2IgYbiJA4MiHwmnLOJZKcr0olTKedwInHMh5u5mkc9QTu
         IXFDKhHB+oQWzcM7zPX5yrBFxhQltNi+ze87VGYgdtZdh65XaM64172o+0s2wCZrkIcW
         EwDiaFT6xow+eSDcaKibFPR9mWbN4sIPQPWjdegDZgKE9oZUe1O8pOQrw11G028v1iVE
         uVUw==
X-Gm-Message-State: ACrzQf0iJXsJw9Rs7J9rQiGWkE8Ct86MPJP24J1EfOL92h3+dMtZOYCm
        CLqboJ6kmdKGXXNLdWLy5Gwj2VIOlT8+
X-Google-Smtp-Source: AMsMyM41HcMPKW/wAoG6frRujcywUgVwe6Gcj9m20w5Z2KsCniSl44ojYvnrOtbI4V6OphWUE4Wk0g==
X-Received: by 2002:a05:622a:15d5:b0:39a:e3c6:6f0f with SMTP id d21-20020a05622a15d500b0039ae3c66f0fmr6949873qty.514.1665503875197;
        Tue, 11 Oct 2022 08:57:55 -0700 (PDT)
Received: from [192.168.75.138] (c-68-56-145-227.hsd1.mi.comcast.net. [68.56.145.227])
        by smtp.gmail.com with ESMTPSA id n20-20020a05620a295400b006ee8d44175esm811747qkp.78.2022.10.11.08.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 08:57:54 -0700 (PDT)
Message-ID: <a0bf0d49a7a69d20cfe007d66586a2649557a30b.camel@kernel.org>
Subject: Re: [PATCH v2] sunrpc: Use GFP_NOFS to prevent use of
 current->task_frag.
From:   Trond Myklebust <trondmy@kernel.org>
To:     Guillaume Nault <gnault@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>
Date:   Tue, 11 Oct 2022 11:57:53 -0400
In-Reply-To: <20221011150057.GB3606@localhost.localdomain>
References: <de6d99321d1dcaa2ad456b92b3680aa77c07a747.1665401788.git.gnault@redhat.com>
         <Y0QyYV1Wyo4vof70@infradead.org>
         <20221010165650.GA3456@ibm-p9z-18-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com>
         <Y0UKq62ByUGNQpuY@infradead.org>
         <20221011150057.GB3606@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2022-10-11 at 17:00 +0200, Guillaume Nault wrote:
> On Mon, Oct 10, 2022 at 11:18:19PM -0700, Christoph Hellwig wrote:
> > On Mon, Oct 10, 2022 at 06:56:50PM +0200, Guillaume Nault wrote:
> > > That's what my RFC patch did. It was rejected because reading
> > > current->flags may incur a cache miss thus slowing down TCP fast
> > > path.
> > > See the discussion in the Link tag:
> > > https://lore.kernel.org/netdev/b4d8cb09c913d3e34f853736f3f5628abfd7f4b6.1656699567.git.gnault@redhat.com/
> > 
> > As GFP_NOFS/NOIO are on their way out the networking people will
> > have to
> > do this anyway.
> 
> We can always think of a nicer solution in the future. But right now
> we
> have a real bug to fix.
> 
> Commit a1231fda7e94 ("SUNRPC: Set memalloc_nofs_save() on all
> rpciod/xprtiod jobs") introduces a bug that crashes the kernel. I
> can't
> see anything wrong with a partial revert.
> 

How about instead just adding a dedicated flag to the socket that
switches between the two page_frag modes?

That would remain future proofed, and it would give kernel users a
lever with which to do the right thing without unnecessarily
constraining the allocation modes.

-- 
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com


