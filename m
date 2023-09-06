Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059A5793EEE
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Sep 2023 16:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241651AbjIFOd0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Wed, 6 Sep 2023 10:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235334AbjIFOdZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Sep 2023 10:33:25 -0400
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B564019AA
        for <linux-nfs@vger.kernel.org>; Wed,  6 Sep 2023 07:33:10 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-64a5f9a165eso18989186d6.1
        for <linux-nfs@vger.kernel.org>; Wed, 06 Sep 2023 07:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694010789; x=1694615589;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SKakrlaECmoqu5CUgp0OjDmhylNJMx7Jeao8/Lqwwww=;
        b=Inup+MypCsmJqLt4TfmnCevArnNOdlW0hjUbGWqDc3XaeO7UvMTnEL5YXwV7vs4Uti
         8WhrYMDnKNGltaxxCJ2ANWYQaVGKcl+X4D9325UOPSHFtRNGwQIj7HSeUnhDz79WlSiu
         ac0HdIeRhHhpS/zwL1F8FwDgHimhZa7E4Og9nIcTy8CDArH21cmQAdLvAQbt92ov62f5
         xY1PrrMhL1HIadcPMCcFrCt4lGsXGlJ7rrsditaZjavbx9RrOIfVlgpp87eFaEwL71DV
         u9YJOYpdXZsETMP91j/OQtfc5Er3GbKJANAMUmHH8RSAKs3yNWq1RvhwzPwFE1zKd11/
         Dnqg==
X-Gm-Message-State: AOJu0Yw6tGMJUvYFKlNm9hzu47VGsrxzJ2EV1oVr6WPtBjbHgMhQhXgh
        YN3DQV0l0SVw82x7zD7vVw==
X-Google-Smtp-Source: AGHT+IFlOTbn4HcbheED+y+CBRi87TE4hOM8qmYCgjSORLk8iOLdpod+/N4f7mf28kVBux0XXm2hnw==
X-Received: by 2002:a0c:b395:0:b0:649:c4f:8d81 with SMTP id t21-20020a0cb395000000b006490c4f8d81mr15458631qve.5.1694010789587;
        Wed, 06 Sep 2023 07:33:09 -0700 (PDT)
Received: from [192.168.75.138] (c-68-32-72-208.hsd1.mi.comcast.net. [68.32.72.208])
        by smtp.gmail.com with ESMTPSA id k16-20020a0cb250000000b006490a9946b6sm5543758qve.119.2023.09.06.07.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 07:33:08 -0700 (PDT)
Message-ID: <2308819c5942088713ae935a53d323d3d604cd8d.camel@kernel.org>
Subject: Re: [PATCH] Revert "SUNRPC: Fail faster on bad verifier"
From:   Trond Myklebust <trondmy@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Russell Cattelan <cattelan@thebarn.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Wed, 06 Sep 2023 10:33:07 -0400
In-Reply-To: <2854B02F-61E7-4AD0-BF7C-0DC132834416@oracle.com>
References: <20230906010328.54634-1-trondmy@kernel.org>
         <2854B02F-61E7-4AD0-BF7C-0DC132834416@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2023-09-06 at 13:40 +0000, Chuck Lever III wrote:
> 
> 
> > On Sep 5, 2023, at 9:03 PM, trondmy@kernel.org wrote:
> > 
> > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > 
> > This reverts commit 0701214cd6e66585a999b132eb72ae0489beb724.
> > 
> > The premise of this commit was incorrect. There are exactly 2 cases
> > where rpcauth_checkverf() will return an error:
> > 
> > 1) If there was an XDR decode problem (i.e. garbage data).
> > 2) If gss_validate() had a problem verifying the RPCSEC_GSS MIC.
> 
> There's also the AUTH_TLS probe:
> 
> https://www.rfc-editor.org/rfc/rfc9289.html#section-4.1-7
> 
> That was the purpose of 0701214cd6e6.
> 
> Reverting this commit is likely to cause problems when our
> TLS-capable client interacts with a server that knows
> nothing of AUTH_TLS.

The patch completely broke the semantics of the header validation code.
There is no discussion about whether or not it needs to be reverted.

If the TLS code needs special treatment, then a separate patch is
needed to fix tls_validate() to return something that can be caught by
rpc_decode_header and interpreted differently to the EIO and EACCES
error codes currently being returned by RPCSEC_GSS, AUTH_SYS and
others.

> > In the second case, there are again 2 subcases:
> > 
> > a) The GSS context expires, in which case gss_validate() will force
> > a
> >   new context negotiation on retry by invalidating the cred.
> > b) The sequence number check failed because an RPC call timed out,
> > and
> >   the client retransmitted the request using a new sequence number,
> >   as required by RFC2203.
> > 
> > In neither subcase is this a fatal error.
> > 
> > Reported-by: Russell Cattelan <cattelan@thebarn.com>
> > Fixes: 0701214cd6e6 ("SUNRPC: Fail faster on bad verifier")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > ---
> > net/sunrpc/clnt.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> > index 12c46e129db8..5a7de7e55548 100644
> > --- a/net/sunrpc/clnt.c
> > +++ b/net/sunrpc/clnt.c
> > @@ -2724,7 +2724,7 @@ rpc_decode_header(struct rpc_task *task,
> > struct xdr_stream *xdr)
> > 
> > out_verifier:
> > trace_rpc_bad_verifier(task);
> > - goto out_err;
> > + goto out_garbage;
> > 
> > out_msg_denied:
> > error = -EACCES;
> > -- 
> > 2.41.0
> > 
> 
> --
> Chuck Lever
> 
> 

-- 
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com


