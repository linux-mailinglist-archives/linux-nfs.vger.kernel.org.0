Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99B35BD539
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Sep 2022 21:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiISTce (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Sep 2022 15:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiISTcc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Sep 2022 15:32:32 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7C644547
        for <linux-nfs@vger.kernel.org>; Mon, 19 Sep 2022 12:32:31 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so218586pjh.3
        for <linux-nfs@vger.kernel.org>; Mon, 19 Sep 2022 12:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=I4PAYFoIW/yRvF3L2ah8bcz3WMOSEv1LWVTu0uRWDMk=;
        b=imVVR7nCQ+IFVN+fWB6E8SZll45y1StK/2vj0qJ77cjIBV18QT9zFjhOz5Uek6Y9iA
         9/rQ/eKx2MNzjEmtMugAfOxG6+Lh/eNSijxwgi6TXiH1uMTrlo/aBoNlanyZh3LA/JRO
         /86Ko5pmFEIKu4+iZVeoFswXzo1/jW9chfiYsnXt3THlhhWJwF0tK6xHa0tD4d+rvmUL
         1buhwsEJU5gzgyuOAQcxLUQ6qn4qx4vKvcCwgXEUZP3PNIhZsKLydjcfKrLVhHYivcCc
         jkq07VCXLzGH8W0y6O2V23jxzEESfGpF0jYq6S7mHm/SqDJ1kbk1t7XFarifPh5FP4OB
         EXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=I4PAYFoIW/yRvF3L2ah8bcz3WMOSEv1LWVTu0uRWDMk=;
        b=BUUxWq+oDXIHeC33DXR3VRLsUBuP2czWDowKMVfKYDqP5irXkChkbQv4HR4Dl5luF2
         eBjz6F7Fgju6g5XbhysEvhNfM7wfkQb9d2TUmvX9ChCb6BXn8dP2XC2h+EehspGbGLLq
         u485rIDkLGIwRTcS1Imgi3RQl8C1BZV3cnYsdfu0ENbfYbDla+fUWXPnLqJttyxYlfJX
         yflu0idmhXw99NOBOKeLy+6ZhMXc8VOb1iSE6RWB68Ah/V8LTFrkZT+2Fx3EAyxpT4f/
         RmygYoetuaeGRIoLfPS4XrVWWS2rsPEW8BranRKrXxDAt79QIXax+5pXNUl4ifG+0yPW
         +NXg==
X-Gm-Message-State: ACrzQf1s1gLAfCrh+0TcGZe10EOc4epj0fFv6tyPWNsCvWnoDE5Lm92P
        Pj/g6NP5EvwLCTh8wO9DUai6ULoBnQFQjauiUHM=
X-Google-Smtp-Source: AMsMyM7O0xKA0hViIE10cqIFPU4/duGxp31VGJKWNWyYdL8KAP7yl7SqEq56XNYfprnV+MOSZYx1QVMI6O2wW4itGg4=
X-Received: by 2002:a17:903:25d4:b0:178:37ed:20b9 with SMTP id
 jc20-20020a17090325d400b0017837ed20b9mr1262590plb.125.1663615951194; Mon, 19
 Sep 2022 12:32:31 -0700 (PDT)
MIME-Version: 1.0
References: <BE5B3B9F-53EF-49E4-9734-CF89936D5F2C@oracle.com>
 <4e79b32842427aa92bf62c5c645430bd23b413e4.camel@hammerspace.com> <1BEBDDFF-EB65-47E4-83F4-DA2F680B940E@oracle.com>
In-Reply-To: <1BEBDDFF-EB65-47E4-83F4-DA2F680B940E@oracle.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 19 Sep 2022 15:32:19 -0400
Message-ID: <CAN-5tyF+-1k0d941zpMMFiXxsTVAbX3d0qv6X38bO49ReOqMdQ@mail.gmail.com>
Subject: Re: NFSv4.0 callback with Kerberos not working
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Steve Dickson <SteveD@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Sep 19, 2022 at 2:16 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Sep 19, 2022, at 1:59 PM, Trond Myklebust <trondmy@hammerspace.com> wrote:
> >
> > On Mon, 2022-09-19 at 15:31 +0000, Chuck Lever III wrote:
> >> Hi-
> >>
> >> I rediscovered recently that NFSv4.0 with Kerberos does not work on
> >> multi-homed hosts. This is true even with sec=sys because the client
> >> attempts to establish a GSS context when there is a keytab present.
> >>
> >> Basically my test environment has to work for sec=sys and sec=krb*
> >> and for all NFS versions and minor versions. Thus I keep a keytab
> >> on it.
> >>
> >> Now, I have three network interfaces on my client: one RoCE, one
> >> IB, and one GbE. They are each on their own subnet and each has
> >> a unique hostname (that varies in the domain part).
> >>
> >> But mounting one of my IB or RoCE test servers with NFSv4.0 results
> >> in the infamous "NFSv4: Invalid callback credential" message. The
> >> client always uses the principal for GbE interface.
> >>
> >> This was working at one point, but seems to have devolved over time.
> >>
> >>
> >> Here are some of the problems I found:
> >>
> >> 1. The kernel always asks for service=* .
> >>
> >> If your system's keytab has only "nfs" service principals in it,
> >> that should be OK. If it has a "host" principal in it, that's
> >> going to be the first one that gssd picks up.
> >>
> >> NFSv4.0 callback does not work with a host@ acceptor -- it wants
> >> nfs@.
> >>
> >> There are two possible workarounds:
> >>
> >> a. Remove all but the nfs@ keys from your system's keytab.
> >>
> >> b. Modify the kernel to use "service=nfs" in the upcall.
> >>
> >
> > There's also
> >
> > c. Put the nfs service principal in its own keytab and use the '-k'
> > option to tell rpc.gssd where to find it.
> >
> > However note that 'host/<hostname@REALM>' is normally the expected
> > principal name for authenticating as a specific hostname. So I'd expect
> > clients to want to authenticate using that credential so that it is
> > matched to the hostname entry in /etc/exports on the server.
> >
> > The 'nfs/<hostname@REALM>' would normally be considered a NFS service
> > principal name, so should really be used by the NFSv4 server to
> > identify its service (see RFC5661 Section 2.2.1.1.1.3.) rather than
> > being used by the NFS client.
>
> Fair enough, we can leave the client's service name alone.
>
>
> > The same principal is also used by the NFSv4 server to identify itself
> > when acting as a client to the NFS callback service according to
> > RFC7530 section 3.3.3.
> > So what I'm saying is that for the standard NFS client, then '*' is
> > probably the right thing to use (with a slight preference for 'host/'),
> > but for the NFS server use case of connecting to the callback service,
> > it should specify the 'nfs/' prefix. It can do that right now by
> > setting the clnt->cl_principal. As far as I can tell, the current
> > behaviour in knfsd is to set it to the same prefix as the server
> > svc_cred, and to default to 'nfs/' if the server svc_cred doesn't have
> > such a prefix.
>
> The server uses the client-provided service name in this case.
> If the client authenticates as "host@" then the server will
> authenticate to the "host@" service on the backchannel.
>
> Maybe the only mismatch is that my server is using
> "host@client.ib.example.net" on the backchannel, and it should
> be using "host@client.example.net" instead?

Given that the spec says: "therefore, the realm name for the server
   principal must be the same for the callback as it was for the
   SETCLIENTID." Doesn't it mean that the server needs to use the same
domain/realm name as what the client authenticated to in the
forechannel (ie server should be using @client.ib.example.net realm
for the callback channel)?

>
>
> --
> Chuck Lever
>
>
>
