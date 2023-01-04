Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEAE65DC37
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jan 2023 19:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbjADSeu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Jan 2023 13:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240194AbjADSec (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Jan 2023 13:34:32 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274783F108
        for <linux-nfs@vger.kernel.org>; Wed,  4 Jan 2023 10:34:14 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id z7so17789666pfq.13
        for <linux-nfs@vger.kernel.org>; Wed, 04 Jan 2023 10:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RPgYkJ0i83Y01RHBwaRIBGOfWGFVz6IKaNYe7yC/XfM=;
        b=PZc1KZuDKc54VadRieyofBPvIpO3F1bsYd5gFQhGWgefHST6rMHw7MqZYx6RZQ8e/B
         7jrtqaS/QRWQvLRk2O5r3qXvUJjXK697TFQkjGddjUoEDUqQx+FIPNy1kjm3Fxomw9fJ
         I1ftE7oX1ZrTDYuqnBulweRCcl0s7RZkbbUhOcrQpwJGFGTa96G0EShKl3tdmb+KBzDF
         kGVMGhfPw/D+TddCxWscchTjHr1S6shmp6MM/LntW2bdxb8Qz89xlSf4cUMBFIUP0zGO
         8PTEIzPzLnfKPSUgHP/FClW0yvVvuhtSC0gisBVTIi/bXfD8whqU4YcMl1Iq2ZT3CSRc
         1CIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RPgYkJ0i83Y01RHBwaRIBGOfWGFVz6IKaNYe7yC/XfM=;
        b=x4t/GALipE+L6MbAMFhL37KNSktPtXRgmBtC71ApS967amB91gLq1msnnkzNFXZlIX
         u8Z6Bt8pjTIcNzgdwtxULZcNd7xrzAfHRozPbdH8nL47Ltu/kyvxottPCu31oJlJpyHI
         bU1kcLbe8zWyMDtqVkAssB0NksACB+eBwLc5WHxYk4JsHk2/bQ9OQ3rlUt/Ulia8iVIt
         txmUHpGelUEGczrMPWafKQ1WjPHS4qzet4pFaPSKwFsCiQawE1LqWJNwuEXCvf0p70VM
         JipKa5UogxOM80enWrJZWOuR79VduYmRDciHUAj6LKaPAaltq/eiNonCxUaulQobn7k7
         5I9w==
X-Gm-Message-State: AFqh2krj/uphl4S2nXZHJJeuNEGX8dtno1LoOzmWit1lYOUj1uvoIUGq
        kryHd0Gt/u68AvGyi5LTWGVIy5rCP0dE6v8Zs0U=
X-Google-Smtp-Source: AMrXdXs3uC+zVc/VDL/0rKHGbeT8RF8mWjoKMKj7SUspRWhe5UJT2+WKU7rf1OEkdugeabp9kci3mLHUaywtWvnjclY=
X-Received: by 2002:a63:1964:0:b0:478:d94b:3227 with SMTP id
 36-20020a631964000000b00478d94b3227mr3220054pgz.114.1672857253648; Wed, 04
 Jan 2023 10:34:13 -0800 (PST)
MIME-Version: 1.0
References: <CAM5tNy6nfvuqM30DwUVjTFHfewL8tSEQcyEJsSBzyWMTvDkEQw@mail.gmail.com>
 <e9fea39e926486146505c385dca50c116deb22f9.camel@kernel.org>
 <CAM5tNy7GM-5m-O2GUBwXCY=psSN2LKiE4bPPFyK=ABhObMdFCg@mail.gmail.com>
 <6ed7866da1e57a46da0108e9581242cd7f1ef2ce.camel@kernel.org>
 <FBAF6EA3-D78E-4F62-ACDB-8582973B4A93@oracle.com> <52f00169bb54c082dbffbcbf999c8096cb16d25d.camel@kernel.org>
In-Reply-To: <52f00169bb54c082dbffbcbf999c8096cb16d25d.camel@kernel.org>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 4 Jan 2023 13:34:02 -0500
Message-ID: <CAN-5tyGFpV3s+kodEJYCQBNgXis35JC3gWTPU-9jYXJwec7YBg@mail.gmail.com>
Subject: Re: RFC:Doing a NFSv4.1/4.2 Kerberized mount without a machine credential
To:     Trond Myklebust <trondmy@kernel.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Rick Macklem <rick.macklem@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
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

On Wed, Jan 4, 2023 at 12:43 PM Trond Myklebust <trondmy@kernel.org> wrote:
>
> On Wed, 2023-01-04 at 14:25 +0000, Chuck Lever III wrote:
> >
> >
> > > On Jan 3, 2023, at 11:41 PM, Trond Myklebust <trondmy@kernel.org>
> > > wrote:
> > >
> > > I've been thinking about how to use a public key infrastructure to
> > > provide stronger authentication of multiple individual users' RPC
> > > calls
> > > and multiplexing them across a shared TLS connection.
> > >
> > > Since the client trusts the server through the TLS connection
> > > authentication mechanism, and you have privacy guaranteed by that
> > > TLS
> > > connection, then  really all you want to do is for each RPC call
> > > from
> > > the client to be able to prove that the caller has a specific valid
> > > identity in the PKI chain of trust.
> > >
> > > So how about just defining a simple credential (AUTH_X509 ?)
> > > containing
> > > a timestamp, and a distinguished name, and have it be signed using
> > > the
> > > (trusted) private key of the user? Use the timestamp as the basis
> > > for a
> > > TTL for the credential so that the client+server don't have to keep
> > > signing a new cred for each and every RPC call for that user, and
> > > allow
> > > the client to reuse the cred for a while as a shared secret, once
> > > the
> > > signature has been verified by the server.
> >
> > A laptop typically has a single user. The flexibility of identity
> > multiplexing isn't necessary in this particular scenario.
> >
>
> Yeah, I don't particularly care about laptop use cases. Most
> enterprises set up VPNs for dealing with them because users typically
> need access to more services than just a NFS server.
>
> I am interested in the general problem of authenticating RPC users
> using certificates, since that is becoming more common due to the rise
> of S3 object storage and cloud services. While AD and krb5+LDAP can be
> extended into those environments too, there are plenty who choose not
> to, because PKI is generally sufficient, and can be more flexible.

It sounds like you want some kind of TLS channel binding (rfc 9266).

However I think in general it's frowned upon to share different
authentication(s) over a secure channel. Or at least it sounds to me
that in rfc 9266 they are not allowing sharing of different
authentications over the same TLS session. But I could be wrong.

>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
