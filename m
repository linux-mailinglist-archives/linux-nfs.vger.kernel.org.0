Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61B365CC6A
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jan 2023 05:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbjADEli convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Tue, 3 Jan 2023 23:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjADElg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Jan 2023 23:41:36 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B479FFE9
        for <linux-nfs@vger.kernel.org>; Tue,  3 Jan 2023 20:41:35 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id x11so26413050qtv.13
        for <linux-nfs@vger.kernel.org>; Tue, 03 Jan 2023 20:41:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RRpmbzzz0BcyhWZiwB31ia7/Q6rQ96FRM3h+JaRQMcM=;
        b=2DG7JmBnzKpMz0+u3IYNSU0W42Ehm0DIGlXyOyRYN+uNw48spgFVlx6vU2Q0X9x2Rn
         BBw1bFxz+4g1L1300sjD74ciqMaQwrhpmH6qHB7bkPAxsQYvfF/33h7mgROlzXWp2fdT
         fQmEZkxv6xfnMfnjAeYZ4loleisrUvh9+5h+FkmMFM0aylMoAat0s6vysDnWalOnGyU/
         76Hv0U3+4BeJUmvF7m2CE+NTBeEi1s6+KBK/TpsKF0DKRC27K/XsQSRW2DAlt1s9Lsxs
         chtwLyJebJD0meEQES9UXnglHI7GmaYtdTrn1WwB4V4MDzvz5Y3ep18+oDONKmKdG9d7
         LcIg==
X-Gm-Message-State: AFqh2ko4BuYZiIAVXLI8e33L2A8b5CvRspO+GxuQEXU4aUeB3zH1VGcT
        AijfIU6VDswVeRXh1tUwTM9nVQAJXA==
X-Google-Smtp-Source: AMrXdXu6Y2LjNHcidwauPkWhI25t6m8bB8U7ZS6325IL68bEaOGxDgXa3MbRIkj8TE7jtQnzmJS48g==
X-Received: by 2002:a05:622a:20a:b0:3a8:2bf6:85ea with SMTP id b10-20020a05622a020a00b003a82bf685eamr80324432qtx.49.1672807294681;
        Tue, 03 Jan 2023 20:41:34 -0800 (PST)
Received: from [192.168.75.138] (c-68-32-72-208.hsd1.mi.comcast.net. [68.32.72.208])
        by smtp.gmail.com with ESMTPSA id m3-20020a05620a24c300b006fef157c8aesm23820700qkn.36.2023.01.03.20.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 20:41:34 -0800 (PST)
Message-ID: <6ed7866da1e57a46da0108e9581242cd7f1ef2ce.camel@kernel.org>
Subject: Re: RFC:Doing a NFSv4.1/4.2 Kerberized mount without a machine
 credential
From:   Trond Myklebust <trondmy@kernel.org>
To:     Rick Macklem <rick.macklem@gmail.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 03 Jan 2023 23:41:33 -0500
In-Reply-To: <CAM5tNy7GM-5m-O2GUBwXCY=psSN2LKiE4bPPFyK=ABhObMdFCg@mail.gmail.com>
References: <CAM5tNy6nfvuqM30DwUVjTFHfewL8tSEQcyEJsSBzyWMTvDkEQw@mail.gmail.com>
         <e9fea39e926486146505c385dca50c116deb22f9.camel@kernel.org>
         <CAM5tNy7GM-5m-O2GUBwXCY=psSN2LKiE4bPPFyK=ABhObMdFCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
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

On Tue, 2023-01-03 at 19:16 -0800, Rick Macklem wrote:
> On Tue, Jan 3, 2023 at 6:12 PM Trond Myklebust <trondmy@kernel.org>
> wrote:
> > 
> > On Tue, 2023-01-03 at 17:28 -0800, Rick Macklem wrote:
> > > I have recently implemented a NFSv4.1/4.2 client mount
> > > on FreeBSD that uses AUTH_SYS for ExchangeID, CreateSession
> > > (and the other state maintenance operations)
> > > using SP4_NONE and then it defers an RPC that does:
> > >    PutRootFH { Lookup, Lookup,... Lookup } GetFH
> > > until a user process/thread attempts to use the mount.
> > > Once an attempt succeeds, the file handle for the mount
> > > point is filled in and the mount works normally.
> > > This works for both a FreeBSD NFSv4 server and a Linux
> > > 5.15 one.
> > > 
> > > Why do this?
> > > 
> > > It allows a sec=krb5 mount to work without any
> > > machine credential on the client. (Both installing
> > > a keytab entry for a host/nfs-client.domain in the
> > > client or doing the mount based on a user principal's
> > > TGT are bothersome.) The first user with a valid TGT
> > > that attempts to access the mount completes the mount's
> > > setup.
> > > 
> > > I envision that this will be used along with RPC-with-TLS
> > > (which can provide both on-the-wire encryption and
> > > peer authentication).  The seems to be a reasonable
> > > alternative to a machine credential and a requirement
> > > for RPCSEC_GSS integrity or privacy.
> > > 
> > > Why am I posting here?
> > > 
> > > I am wondering if the Linux client implementors are
> > > interested in doing the same thing?
> > > 
> > > I think it is possible to extend NFSv4.2 with a new
> > > enum state_protect_how4 value (SP4_PEER_AUTH?) that
> > > would allow the client to specify what operations must
> > > use RPC-with-TLS including peer authentication and which
> > > must be allowed for this case (similar to SP4_MECH_CRED).
> > > However, if the server forces the client to use RPC-with-TLS
> > > plus peer authentication, that may be sufficient and does
> > > not require any protocol extensions.
> > > 
> > > Comments?
> > > 
> > 
> > Are there really that many use cases for this? If you are using
> > krb5
> > authentication, then you pretty much have to support identity
> > mapping.
> > Unless you are talking about a hobby setup, then that usually means
> > backing your Kerberos server with either LDAP or Active Directory
> > to
> > serve up account mappings, and it usually means protecting those
> > databases with some form of strong authentication as well.
> > 
> > IOW: for most setups, I would expect the machine credential
> > requirement
> > to be a non-negotiable part of the total AD/Krb5+LDAP security
> > package
> > that is implemented in userspace. Am I wrong?
> > 
> For systems in machine rooms, you are probably correct, although I
> think many of these environments would just use AUTH_SYS, since they
> trust the clients.
> 
> What about mounts from mobile devices that do not have a fixed
> client IP host address?
> (I suspect that, currently, they seldom if ever use NFS, but I think
>  trying to support them could be useful.  A mobile client can use
>  a X.509 certificate to do a reasonable job of verifying its identity
>  if signed by a site local CA, although it cannot have a "wired-down"
>  DNS name in the certificate.)

Those aren't really likely to use krb5, though.

I've been thinking about how to use a public key infrastructure to
provide stronger authentication of multiple individual users' RPC calls
and multiplexing them across a shared TLS connection.

Since the client trusts the server through the TLS connection
authentication mechanism, and you have privacy guaranteed by that TLS
connection, then  really all you want to do is for each RPC call from
the client to be able to prove that the caller has a specific valid
identity in the PKI chain of trust.

So how about just defining a simple credential (AUTH_X509 ?) containing
a timestamp, and a distinguished name, and have it be signed using the
(trusted) private key of the user? Use the timestamp as the basis for a
TTL for the credential so that the client+server don't have to keep
signing a new cred for each and every RPC call for that user, and allow
the client to reuse the cred for a while as a shared secret, once the
signature has been verified by the server.

Such a mechanism would presumably allow you to continue to define
separate identities for the machine and the user, and multiplex them
over the same TLS connection.

-- 
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com


