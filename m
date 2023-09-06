Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4543879414C
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Sep 2023 18:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbjIFQSm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Wed, 6 Sep 2023 12:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjIFQSm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Sep 2023 12:18:42 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90447198B
        for <linux-nfs@vger.kernel.org>; Wed,  6 Sep 2023 09:18:38 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-76f036041b4so57260285a.1
        for <linux-nfs@vger.kernel.org>; Wed, 06 Sep 2023 09:18:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694017117; x=1694621917;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2AqAeJcj8vGDlD0vKA+bCe7YaRrzt5ZqRSF8KckuWKM=;
        b=D4Uk5cbibofmB/p2BaLQKjC4hWI0g8PTqWZIZkEENYar3KpBmVmtxGjngCuacqp5Vs
         F1iDD+BD1pAjXG/wilnDnqvJSfUBmxCsLVQ1ddKdNgVAcdsMdvTjzOirO6UjH+phm9xO
         tpICPiWGk8zAh+0OIayXvL0pxNkxK4RTQ5L7I4BxHUoZBWTDa63FZZZw3o152yMwlxGf
         eUKq6wULO5exS4bNFugsjQaIK2V9cbL8OG9ZPHfCP7A+BxMl1SShA/uAD0eNPN0Lzd9h
         DjEY6y9SSq/h3Jdu4fW17B8wZPsV4qn4oyThcB2kEuHsZK2f4zAr+5u9aAbABRc84Y8g
         ncKg==
X-Gm-Message-State: AOJu0YxXU9S3g9/8FA+OZhbTethGm5jejmELZH7TVCvguUFZt7LiJm1s
        OdorM5i5Hxr5P9YML5uFxwQYxNL25A==
X-Google-Smtp-Source: AGHT+IEYEbNm1ArGR5XhFGh52IKJJyaOeO5h8z2lZqUqbbxgkEI4X1QpS7Sa+oJeewEVKNRlJpfSVQ==
X-Received: by 2002:a05:620a:470d:b0:76c:ea67:38e4 with SMTP id bs13-20020a05620a470d00b0076cea6738e4mr127920qkb.12.1694017117473;
        Wed, 06 Sep 2023 09:18:37 -0700 (PDT)
Received: from [192.168.75.138] (c-68-32-72-208.hsd1.mi.comcast.net. [68.32.72.208])
        by smtp.gmail.com with ESMTPSA id o13-20020a05620a110d00b0076816153dcdsm5081209qkk.106.2023.09.06.09.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 09:18:37 -0700 (PDT)
Message-ID: <453cd9f416164a026e0932778d2bbcaf04dbe572.camel@kernel.org>
Subject: Re: [PATCH] Revert "SUNRPC: Fail faster on bad verifier"
From:   Trond Myklebust <trondmy@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Russell Cattelan <cattelan@thebarn.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Wed, 06 Sep 2023 12:18:35 -0400
In-Reply-To: <15DC398B-F481-4FD4-8265-603CEE2454B6@oracle.com>
References: <20230906010328.54634-1-trondmy@kernel.org>
         <2854B02F-61E7-4AD0-BF7C-0DC132834416@oracle.com>
         <2308819c5942088713ae935a53d323d3d604cd8d.camel@kernel.org>
         <15DC398B-F481-4FD4-8265-603CEE2454B6@oracle.com>
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

On Wed, 2023-09-06 at 15:20 +0000, Chuck Lever III wrote:
> 
> 
> > On Sep 6, 2023, at 10:33 AM, Trond Myklebust <trondmy@kernel.org>
> > wrote:
> > 
> > On Wed, 2023-09-06 at 13:40 +0000, Chuck Lever III wrote:
> > > 
> > > 
> > > > On Sep 5, 2023, at 9:03 PM, trondmy@kernel.org wrote:
> > > > 
> > > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > > 
> > > > This reverts commit 0701214cd6e66585a999b132eb72ae0489beb724.
> > > > 
> > > > The premise of this commit was incorrect. There are exactly 2
> > > > cases
> > > > where rpcauth_checkverf() will return an error:
> > > > 
> > > > 1) If there was an XDR decode problem (i.e. garbage data).
> > > > 2) If gss_validate() had a problem verifying the RPCSEC_GSS
> > > > MIC.
> > > 
> > > There's also the AUTH_TLS probe:
> > > 
> > > https://www.rfc-editor.org/rfc/rfc9289.html#section-4.1-7
> > > 
> > > That was the purpose of 0701214cd6e6.
> > > 
> > > Reverting this commit is likely to cause problems when our
> > > TLS-capable client interacts with a server that knows
> > > nothing of AUTH_TLS.
> > 
> > The patch completely broke the semantics of the header validation
> > code.
> 
> If that were truly the case, it's amazing that the client
> has hobbled along for the past 14 months with no-one
> noticing the breakage until now.
> 
> Seriously, though, treating a bad verifier as garbage args
> is not intuitive. If it's that critical there needs to be
> a comment in the code explaining why.
> 

It is necessary because of the peculiarities of RPCSEC_GSS and the
session semantics it implements.
See https://datatracker.ietf.org/doc/html/rfc2203#section-5.3.3.1 and
in particular, the paragraph discussing retransmissions by the client.

> > There is no discussion about whether or not it needs to be
> > reverted.
> 
> The patch description is wrong, though, to exclude AUTH_TLS.
> 
> The reverting patch description claims to be an exhaustive
> list of all the cases, but it doesn't mention the AUTH_TLS
> case at all.
> 
> 
> > If the TLS code needs special treatment, then a separate patch is
> > needed to fix tls_validate() to return something that can be caught
> > by
> > rpc_decode_header and interpreted differently to the EIO and EACCES
> > error codes currently being returned by RPCSEC_GSS, AUTH_SYS and
> > others.
> 
> That could have been brought up when 0701214cd6e6 was first
> posted for review. Interesting that the decoder currently
> does not distinguish between EIO and EACCES.
> 
> Thanks for the suggestion, I'll have a look.
> 

Now that I look at it, I think your approach to satisfying RFC9289 is
not correct.
Since this is a transport level issue, why should we not just mark the
xprt for disconnection, and then retry? It is entirely possible that
some load balancer/floating IP has just moved the connection to some
node that was not expecting to do TLS. The only case where that should
not be assumed is the case where the error happens right at the very
beginning of the mount, when disconnecting should normally suffice to
trigger the RPC_TASK_SOFTCONN code anyway.

> 
> > > > In the second case, there are again 2 subcases:
> > > > 
> > > > a) The GSS context expires, in which case gss_validate() will
> > > > force
> > > > a
> > > >   new context negotiation on retry by invalidating the cred.
> > > > b) The sequence number check failed because an RPC call timed
> > > > out,
> > > > and
> > > >   the client retransmitted the request using a new sequence
> > > > number,
> > > >   as required by RFC2203.
> > > > 
> > > > In neither subcase is this a fatal error.
> > > > 
> > > > Reported-by: Russell Cattelan <cattelan@thebarn.com>
> > > > Fixes: 0701214cd6e6 ("SUNRPC: Fail faster on bad verifier")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Trond Myklebust
> > > > <trond.myklebust@hammerspace.com>
> > > > ---
> > > > net/sunrpc/clnt.c | 2 +-
> > > > 1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> > > > index 12c46e129db8..5a7de7e55548 100644
> > > > --- a/net/sunrpc/clnt.c
> > > > +++ b/net/sunrpc/clnt.c
> > > > @@ -2724,7 +2724,7 @@ rpc_decode_header(struct rpc_task *task,
> > > > struct xdr_stream *xdr)
> > > > 
> > > > out_verifier:
> > > > trace_rpc_bad_verifier(task);
> > > > - goto out_err;
> > > > + goto out_garbage;
> > > > 
> > > > out_msg_denied:
> > > > error = -EACCES;
> > > > -- 
> > > > 2.41.0
> > > > 
> > > 
> > > --
> > > Chuck Lever
> > > 
> > > 
> > 
> > -- 
> > Trond Myklebust
> > Linux NFS client maintainer, Hammerspace
> > trond.myklebust@hammerspace.com
> 
> 
> --
> Chuck Lever
> 
> 

