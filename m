Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEFF5E64C8
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Sep 2022 16:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbiIVOLf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Sep 2022 10:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiIVOLK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Sep 2022 10:11:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5215857F7
        for <linux-nfs@vger.kernel.org>; Thu, 22 Sep 2022 07:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663855860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zPdNgvFs1bF+oDkeZWX8kHVlvs/CpJe6dbYRA6eY6sE=;
        b=Abb88FTG+7CYNQAMgOlfw20SAEqUTbWOoSaV0qfjPgXdd1HYCZxL9yGXVjpawDayAyysdS
        padPeRvr8LFfLdH7dsyDKpe0oNJWRxlvZ8W8XJToV5nHuXHyxcz6yRLDIR4lz9Amm50FkD
        HgaHf7q8eX9Aazc8IQ/bGRokDJaj7hY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-439-UMBC-o07M5eZUeeZ9A82vg-1; Thu, 22 Sep 2022 10:10:59 -0400
X-MC-Unique: UMBC-o07M5eZUeeZ9A82vg-1
Received: by mail-qv1-f71.google.com with SMTP id y7-20020ad45307000000b004ac7fd46495so6561099qvr.23
        for <linux-nfs@vger.kernel.org>; Thu, 22 Sep 2022 07:10:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=zPdNgvFs1bF+oDkeZWX8kHVlvs/CpJe6dbYRA6eY6sE=;
        b=xSuZ5eotkQ2uEPr80+1A9dT1zbJmPKsGqLOBykSipDoWqjCIiW2n8wvhBLRlyxvsE/
         iHSd4KyUxw4ShDfo2f4ala+5zHxxT96kNdfIOJ9nFIX8R9n6RdYj/QV6+/A+KnlzROtT
         INi3gvFe+kH9apdL2bf5uZYsdil9X9y07CpfSN+3akXcvtyY3KRFxuQETKmteeFfNnAE
         FO4YmMLWfBeJSvmLZlVKrNkY07WhNSUN9UfVbnZTkolos7wV9vJNtgJ/KHwXNRiCSFSl
         vxCNKYLch0DJ7Mmh4OkF1olkkVoD2ECyh9Red+sDuYdySA8OqmnVY/0AsWOvj6wSj/4w
         uJdw==
X-Gm-Message-State: ACrzQf3TVxFxGx2LyfkqFJOSIfm1LMaUn5Zu5DH24AKqeqmefVabAZZM
        rKsA1vEDJ0ghgp87TAZT5Mfqvj2mqCj/50TpdHfuK3ZDVdGissNWKPIe28b5XG2Nd8P+ZmW48I6
        4pwaPsx0kkLnNYuYR/88N
X-Received: by 2002:a05:620a:955:b0:6cb:deab:4966 with SMTP id w21-20020a05620a095500b006cbdeab4966mr2217688qkw.664.1663855858500;
        Thu, 22 Sep 2022 07:10:58 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM71gQY9DagAmvaKQxZ5AyZ4StUMX2TVLdWhOGJ1XRq7KR+bVcRHPR0AlNI3yv/TcOSuFKBkLw==
X-Received: by 2002:a05:620a:955:b0:6cb:deab:4966 with SMTP id w21-20020a05620a095500b006cbdeab4966mr2217650qkw.664.1663855858180;
        Thu, 22 Sep 2022 07:10:58 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-104-76.dyn.eolo.it. [146.241.104.76])
        by smtp.gmail.com with ESMTPSA id t6-20020a37ea06000000b006cf38fd659asm3793448qkj.103.2022.09.22.07.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 07:10:57 -0700 (PDT)
Message-ID: <b6c4c53945823eab9b353e8944c7b50636c93091.camel@redhat.com>
Subject: Re: [PATCH net] sunrpc: Use GFP_NOFS to prevent use of
 current->task_frag.
From:   Paolo Abeni <pabeni@redhat.com>
To:     Guillaume Nault <gnault@redhat.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>
Cc:     netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        Benjamin Coddington <bcodding@redhat.com>
Date:   Thu, 22 Sep 2022 16:10:54 +0200
In-Reply-To: <96a18bd00cbc6cb554603cc0d6ef1c551965b078.1663762494.git.gnault@redhat.com>
References: <96a18bd00cbc6cb554603cc0d6ef1c551965b078.1663762494.git.gnault@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2022-09-21 at 14:16 +0200, Guillaume Nault wrote:
> Commit a1231fda7e94 ("SUNRPC: Set memalloc_nofs_save() on all
> rpciod/xprtiod jobs") stopped setting sk->sk_allocation explicitly in
> favor of using memalloc_nofs_save()/memalloc_nofs_restore() critical
> sections.
> 
> However, ->sk_allocation isn't used just by the memory allocator.
> In particular, sk_page_frag() uses it to figure out if it can return
> the page_frag from current or if it has to use the socket one.
> With ->sk_allocation set to the default GFP_KERNEL, sk_page_frag() now
> returns current->page_frag, which might already be in use in the
> current context if the call happens during memory reclaim.
> 
> Fix this by setting ->sk_allocation to GFP_NOFS.
> Note that we can't just instruct sk_page_frag() to look at
> current->flags, because it could generate a cache miss, thus slowing
> down the TCP fast path.
> 
> This is similar to the problems fixed by the following two commits:
>   * cifs: commit dacb5d8875cc ("tcp: fix page frag corruption on page
>     fault").
>   * nbd: commit 20eb4f29b602 ("net: fix sk_page_frag() recursion from
>     memory reclaim").
> 
> Link: https://lore.kernel.org/netdev/b4d8cb09c913d3e34f853736f3f5628abfd7f4b6.1656699567.git.gnault@redhat.com/
> Fixes: a1231fda7e94 ("SUNRPC: Set memalloc_nofs_save() on all rpciod/xprtiod jobs")
> Signed-off-by: Guillaume Nault <gnault@redhat.com>

It's unfortunate, but I think we need to keep both memalloc_nofs_save()
and sk_allocation for the time being.

Thanks Guillaume, patch LGTM.

Acked-by: Paolo Abeni <pabeni@redhat.com>

