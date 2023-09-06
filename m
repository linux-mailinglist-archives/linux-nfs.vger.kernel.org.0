Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4E3794306
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Sep 2023 20:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242990AbjIFS2H convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Wed, 6 Sep 2023 14:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242800AbjIFS2F (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Sep 2023 14:28:05 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F0910C8
        for <linux-nfs@vger.kernel.org>; Wed,  6 Sep 2023 11:28:00 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6bda8559fddso132682a34.1
        for <linux-nfs@vger.kernel.org>; Wed, 06 Sep 2023 11:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694024880; x=1694629680;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FlWIEtxJQ9I9EOc6hgflvsGQBb8cmnXnoyi2yMti9/U=;
        b=f2fKiB/KXo7PiPewMxZ6X5BCA2LpoIlUi+WS5iTzJwTkc9K0qUnWlSl11GUutKjqn3
         0PV10ESIiWeGR6/rAv4yDXudRJOAh2hWIu1ePZm7rcYD7DdVz8vyexTdnHCN/ozOTIvF
         1KYgYJt9fxcSpGY5urkmJu5onjB5cZ28SoVPP/rR3muj7ovdu339efZ7iVj/B3moMNvS
         v/XTz3QTSBBMt2zHcYONDATyrd2X9rXy5QTjc+WP6juM9PRptmwV67qRkPMgj9Mm1546
         slNtRN+9HHlwiruFUFGXYtjQQMen+18RxlIG64vh/FzH4pnc4ajdeD6zFmSzg4GNMX2b
         VCpA==
X-Gm-Message-State: AOJu0YwMe5KMBhz1VF4j8gBLpvoWfF/7bHV4TGxqcssv6EYIpTwpDIpV
        CFyZErR9Pzow3F7RC10QdQ==
X-Google-Smtp-Source: AGHT+IG5+QXmsDpKdZpQJwqo73gDCwCT0CJApnFMjbQtfWSKM7+B4+DlF/rGdU4iGyk8oPJyxJuR+Q==
X-Received: by 2002:a05:6358:71c2:b0:135:47e8:76e2 with SMTP id u2-20020a05635871c200b0013547e876e2mr3784374rwu.4.1694024879943;
        Wed, 06 Sep 2023 11:27:59 -0700 (PDT)
Received: from [192.168.75.138] (c-68-32-72-208.hsd1.mi.comcast.net. [68.32.72.208])
        by smtp.gmail.com with ESMTPSA id e23-20020a0caa57000000b0064f4e0b2089sm5709332qvb.33.2023.09.06.11.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 11:27:59 -0700 (PDT)
Message-ID: <011062e833b692272e0fbe39119c9d9c82c92c80.camel@kernel.org>
Subject: Re: [PATCH] Revert "SUNRPC: Fail faster on bad verifier"
From:   Trond Myklebust <trondmy@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Russell Cattelan <cattelan@thebarn.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Wed, 06 Sep 2023 14:27:58 -0400
In-Reply-To: <36A61B31-5D22-480F-979B-82A1B512F555@oracle.com>
References: <20230906010328.54634-1-trondmy@kernel.org>
         <2854B02F-61E7-4AD0-BF7C-0DC132834416@oracle.com>
         <2308819c5942088713ae935a53d323d3d604cd8d.camel@kernel.org>
         <15DC398B-F481-4FD4-8265-603CEE2454B6@oracle.com>
         <453cd9f416164a026e0932778d2bbcaf04dbe572.camel@kernel.org>
         <36A61B31-5D22-480F-979B-82A1B512F555@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2023-09-06 at 18:05 +0000, Chuck Lever III wrote:
> 
> 
> > On Sep 6, 2023, at 12:18 PM, Trond Myklebust <trondmy@kernel.org>
> > wrote:
> > 
> > On Wed, 2023-09-06 at 15:20 +0000, Chuck Lever III wrote:
> > > 
> > > 
> > > > On Sep 6, 2023, at 10:33 AM, Trond Myklebust
> > > > <trondmy@kernel.org>
> > > > wrote:
> > > > 
> > > > On Wed, 2023-09-06 at 13:40 +0000, Chuck Lever III wrote:
> > > > > 
> > > > > 
> > > > > > On Sep 5, 2023, at 9:03 PM, trondmy@kernel.org wrote:
> > > > > > 
> > > > > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > > > > 
> > > > > > This reverts commit
> > > > > > 0701214cd6e66585a999b132eb72ae0489beb724.
> > > > > > 
> > > > > > The premise of this commit was incorrect. There are exactly
> > > > > > 2
> > > > > > cases
> > > > > > where rpcauth_checkverf() will return an error:
> > > > > > 
> > > > > > 1) If there was an XDR decode problem (i.e. garbage data).
> > > > > > 2) If gss_validate() had a problem verifying the RPCSEC_GSS
> > > > > > MIC.
> > > > > 
> > > > > There's also the AUTH_TLS probe:
> > > > > 
> > > > > https://www.rfc-editor.org/rfc/rfc9289.html#section-4.1-7
> > > > > 
> > > > > That was the purpose of 0701214cd6e6.
> > > > > 
> > > > > Reverting this commit is likely to cause problems when our
> > > > > TLS-capable client interacts with a server that knows
> > > > > nothing of AUTH_TLS.
> > > > 
> > > > The patch completely broke the semantics of the header
> > > > validation
> > > > code.
> > > 
> > > If that were truly the case, it's amazing that the client
> > > has hobbled along for the past 14 months with no-one
> > > noticing the breakage until now.
> > > 
> > > Seriously, though, treating a bad verifier as garbage args
> > > is not intuitive. If it's that critical there needs to be
> > > a comment in the code explaining why.
> > > 
> > 
> > It is necessary because of the peculiarities of RPCSEC_GSS and the
> > session semantics it implements.
> > See
> > https://datatracker.ietf.org/doc/html/rfc2203#section-5.3.3.1 and
> > in particular, the paragraph discussing retransmissions by the
> > client.
> 
> Retrying is fine.
> 
> But the counter in the client is called "garbage_retries".
> That's not what is going on the EACCES case, though the
> behavior is close enough -- it's code re-use (good) without
> appropriate documentation (bad).
> 
> The decoder treats EIO and EACCES exactly the same way.
> Again, code reuse (good) without appropriate documentation
> (bad).
> 
> I tried to address that in my RFC patch by adding a small
> explanatory comment and by adding an API contract for
> rpcauth_checkverf().
> 
> 
> > > > There is no discussion about whether or not it needs to be
> > > > reverted.
> > > 
> > > The patch description is wrong, though, to exclude AUTH_TLS.
> > > 
> > > The reverting patch description claims to be an exhaustive
> > > list of all the cases, but it doesn't mention the AUTH_TLS
> > > case at all.
> > > 
> > > 
> > > > If the TLS code needs special treatment, then a separate patch
> > > > is
> > > > needed to fix tls_validate() to return something that can be
> > > > caught
> > > > by
> > > > rpc_decode_header and interpreted differently to the EIO and
> > > > EACCES
> > > > error codes currently being returned by RPCSEC_GSS, AUTH_SYS
> > > > and
> > > > others.
> > > 
> > > That could have been brought up when 0701214cd6e6 was first
> > > posted for review. Interesting that the decoder currently
> > > does not distinguish between EIO and EACCES.
> > > 
> > > Thanks for the suggestion, I'll have a look.
> > > 
> > 
> > Now that I look at it, I think your approach to satisfying RFC9289
> > is
> > not correct.
> 
> I'm not following what aspect of the implementation is problematic.
> I'm going to assume you mean the implementation of opportunism.
> 
> 
> > Since this is a transport level issue, why should we not just mark
> > the
> > xprt for disconnection, and then retry? It is entirely possible
> > that
> > some load balancer/floating IP has just moved the connection to
> > some
> > node that was not expecting to do TLS.
> 
> Depending on the security policy chosen by the client's
> administrator,
> that could either be a security problem or a "don't care" situation.
> 
> If the administrator wants the client to _require_ TLS, then
> connecting to a load balancer where TLS suddenly becomes unavailable
> after a reconnect is a hard error. This prevents STRIPTLS attacks.
> That's good security.
> 
> If the administrator wants to allow operation to continue even if TLS
> is not available, then the client can recover by not using TLS.
> That's
> rather terrible security, but can be desirable to improve backward
> compatibility.
> 
> 
> > The only case where that should
> > not be assumed is the case where the error happens right at the
> > very
> > beginning of the mount, when disconnecting should normally suffice
> > to
> > trigger the RPC_TASK_SOFTCONN code anyway.
> 
> If TLS goes away after a reconnect, that's a problem. Whether
> further operation should stop depends on the administrator's
> chosen security policy.
> 
> The security policies are NFS-level settings (eg, mount options).
> RPC just indicates to NFS whether the traffic is protected or not.
> 
> When NFS asks RPC to ensure the communication channel is protected,
> that means every reconnect is protected. Communication with that
> security policy cannot happen without protection.
> 
> Trust me, the security community will have it no other way.
> 
> If you need opportunism in this case, then I can add back the
> "xprtsec=auto" mount option, which you asked me to remove a while
> back.

I don't see how described behaviour would cause the operation to
proceed without TLS. I'm saying disconnect and then retry TLS
negotiation, and then eventually fail.

> 
> 
> > > > > > In the second case, there are again 2 subcases:
> > > > > > 
> > > > > > a) The GSS context expires, in which case gss_validate()
> > > > > > will
> > > > > > force
> > > > > > a
> > > > > >   new context negotiation on retry by invalidating the
> > > > > > cred.
> > > > > > b) The sequence number check failed because an RPC call
> > > > > > timed
> > > > > > out,
> > > > > > and
> > > > > >   the client retransmitted the request using a new sequence
> > > > > > number,
> > > > > >   as required by RFC2203.
> > > > > > 
> > > > > > In neither subcase is this a fatal error.
> > > > > > 
> > > > > > Reported-by: Russell Cattelan <cattelan@thebarn.com>
> > > > > > Fixes: 0701214cd6e6 ("SUNRPC: Fail faster on bad verifier")
> > > > > > Cc: stable@vger.kernel.org
> > > > > > Signed-off-by: Trond Myklebust
> > > > > > <trond.myklebust@hammerspace.com>
> > > > > > ---
> > > > > > net/sunrpc/clnt.c | 2 +-
> > > > > > 1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> > > > > > index 12c46e129db8..5a7de7e55548 100644
> > > > > > --- a/net/sunrpc/clnt.c
> > > > > > +++ b/net/sunrpc/clnt.c
> > > > > > @@ -2724,7 +2724,7 @@ rpc_decode_header(struct rpc_task
> > > > > > *task,
> > > > > > struct xdr_stream *xdr)
> > > > > > 
> > > > > > out_verifier:
> > > > > > trace_rpc_bad_verifier(task);
> > > > > > - goto out_err;
> > > > > > + goto out_garbage;
> > > > > > 
> > > > > > out_msg_denied:
> > > > > > error = -EACCES;
> > > > > > -- 
> > > > > > 2.41.0
> > > > > > 
> > > > > 
> > > > > --
> > > > > Chuck Lever
> > > > > 
> > > > > 
> > > > 
> > > > -- 
> > > > Trond Myklebust
> > > > Linux NFS client maintainer, Hammerspace
> > > > trond.myklebust@hammerspace.com
> > > 
> > > 
> > > --
> > > Chuck Lever
> 
> 
> --
> Chuck Lever
> 
> 

-- 
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com


