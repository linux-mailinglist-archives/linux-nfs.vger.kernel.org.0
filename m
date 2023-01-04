Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D280665D74A
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jan 2023 16:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjADPd2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Jan 2023 10:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239536AbjADPdN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Jan 2023 10:33:13 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7515426FB
        for <linux-nfs@vger.kernel.org>; Wed,  4 Jan 2023 07:33:12 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id c6so2994711pls.4
        for <linux-nfs@vger.kernel.org>; Wed, 04 Jan 2023 07:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5jGIvBUGQQ0EvMGsYrD2swtfadElu4Mc8LHA5ZA3TF8=;
        b=P2+0HGRY3CqhbZ2tXAyXroH2Cc1UR+Gu0xV4uWR81G/RUm/RnDahfENoFXBUW8QLV4
         NULkEQPZJjJ3aKsAM4caq6DT281WwwwOSgWpwN0QqjMLVCZrDleNgU9EgN/AHo757SQ9
         U8eK/UDHQRjiG6IydMKDbjLNgfEnmq9qhkEPwTn4Ca8mohphNoMJzDPLfwFGIVO7VT+X
         4ql9cXbWyc72UZ5WvsuQ8VsVyvFLj1eKqnlSONL2R9kq/X8LAtWhEMsyBQx4Lfdo47dK
         CaVO7CKG0+n1Q70ayfm7V8+tgXeXLZei0vXGGPVrRsAbpymShOzG6wtqmNwTQhCl+a+H
         ca8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5jGIvBUGQQ0EvMGsYrD2swtfadElu4Mc8LHA5ZA3TF8=;
        b=n+eJeJDn/3ZwqDyaXixwc4luljL2I4Ugle5zrzTjhrBg5dGGyXApjxCENx1csZux7b
         uZQo1gD2gYNOKpI1V6oKL4JbBw493/qQYKO/KoO6b8CyectfkF+yP6MV5JXYYR5D3/i6
         7H1UPyw9a1fPZQqCZ9s8/26ytzddrlQtWrUbt9lGoTMGPh6xNk20E3Du50Haan7riTFB
         WZzENOJpyEI8GvmtWfgcHQ3S3eB3woJxB7q0X1UiWaZElD1jKlC71G1XDCSk1i99Fim0
         dDNyLyqQb8Vn9AGkaA4JbCdq4GtBRRQxnhll60md23EstpwxaN6kzIAD8ZETd/Le3KKd
         8l4w==
X-Gm-Message-State: AFqh2ko5EWqaaU7VKqEQ1mlpKGxPoadKQ9WY4AWi26/4sI832by7EW5R
        piekjhbKgtRZzZ5bp00mxiu98FrS2/MQx65nuLeeswU=
X-Google-Smtp-Source: AMrXdXvwhXVqnfJTVq66065PXceW849lBaNaGDUtt8ozVAYqrh7v9ImuqmQooG30xfrAWFmY37LRf5syoUcdYcOO/VY=
X-Received: by 2002:a17:90b:3605:b0:225:dd78:f4db with SMTP id
 ml5-20020a17090b360500b00225dd78f4dbmr2271486pjb.183.1672846391823; Wed, 04
 Jan 2023 07:33:11 -0800 (PST)
MIME-Version: 1.0
References: <CAM5tNy6nfvuqM30DwUVjTFHfewL8tSEQcyEJsSBzyWMTvDkEQw@mail.gmail.com>
 <e9fea39e926486146505c385dca50c116deb22f9.camel@kernel.org>
 <CAM5tNy7GM-5m-O2GUBwXCY=psSN2LKiE4bPPFyK=ABhObMdFCg@mail.gmail.com>
 <6ed7866da1e57a46da0108e9581242cd7f1ef2ce.camel@kernel.org> <FBAF6EA3-D78E-4F62-ACDB-8582973B4A93@oracle.com>
In-Reply-To: <FBAF6EA3-D78E-4F62-ACDB-8582973B4A93@oracle.com>
From:   Rick Macklem <rick.macklem@gmail.com>
Date:   Wed, 4 Jan 2023 07:32:56 -0800
Message-ID: <CAM5tNy5wjS-E2qgBfSkPhbCrpQVV19r7AJAz+q2LDEvfV9PPPg@mail.gmail.com>
Subject: Re: RFC:Doing a NFSv4.1/4.2 Kerberized mount without a machine credential
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trondmy@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jan 4, 2023 at 6:25 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Jan 3, 2023, at 11:41 PM, Trond Myklebust <trondmy@kernel.org> wrote:
> >
> > On Tue, 2023-01-03 at 19:16 -0800, Rick Macklem wrote:
> >> On Tue, Jan 3, 2023 at 6:12 PM Trond Myklebust <trondmy@kernel.org>
> >> wrote:
> >>>
> >>> On Tue, 2023-01-03 at 17:28 -0800, Rick Macklem wrote:
> >>>> I have recently implemented a NFSv4.1/4.2 client mount
> >>>> on FreeBSD that uses AUTH_SYS for ExchangeID, CreateSession
> >>>> (and the other state maintenance operations)
> >>>> using SP4_NONE and then it defers an RPC that does:
> >>>>    PutRootFH { Lookup, Lookup,... Lookup } GetFH
> >>>> until a user process/thread attempts to use the mount.
> >>>> Once an attempt succeeds, the file handle for the mount
> >>>> point is filled in and the mount works normally.
> >>>> This works for both a FreeBSD NFSv4 server and a Linux
> >>>> 5.15 one.
> >>>>
> >>>> Why do this?
> >>>>
> >>>> It allows a sec=krb5 mount to work without any
> >>>> machine credential on the client. (Both installing
> >>>> a keytab entry for a host/nfs-client.domain in the
> >>>> client or doing the mount based on a user principal's
> >>>> TGT are bothersome.) The first user with a valid TGT
> >>>> that attempts to access the mount completes the mount's
> >>>> setup.
> >>>>
> >>>> I envision that this will be used along with RPC-with-TLS
> >>>> (which can provide both on-the-wire encryption and
> >>>> peer authentication).  The seems to be a reasonable
> >>>> alternative to a machine credential and a requirement
> >>>> for RPCSEC_GSS integrity or privacy.
> >>>>
> >>>> Why am I posting here?
> >>>>
> >>>> I am wondering if the Linux client implementors are
> >>>> interested in doing the same thing?
> >>>>
> >>>> I think it is possible to extend NFSv4.2 with a new
> >>>> enum state_protect_how4 value (SP4_PEER_AUTH?) that
> >>>> would allow the client to specify what operations must
> >>>> use RPC-with-TLS including peer authentication and which
> >>>> must be allowed for this case (similar to SP4_MECH_CRED).
> >>>> However, if the server forces the client to use RPC-with-TLS
> >>>> plus peer authentication, that may be sufficient and does
> >>>> not require any protocol extensions.
> >>>>
> >>>> Comments?
> >>>>
> >>>
> >>> Are there really that many use cases for this? If you are using
> >>> krb5
> >>> authentication, then you pretty much have to support identity
> >>> mapping.
> >>> Unless you are talking about a hobby setup, then that usually means
> >>> backing your Kerberos server with either LDAP or Active Directory
> >>> to
> >>> serve up account mappings, and it usually means protecting those
> >>> databases with some form of strong authentication as well.
> >>>
> >>> IOW: for most setups, I would expect the machine credential
> >>> requirement
> >>> to be a non-negotiable part of the total AD/Krb5+LDAP security
> >>> package
> >>> that is implemented in userspace. Am I wrong?
> >>>
> >> For systems in machine rooms, you are probably correct, although I
> >> think many of these environments would just use AUTH_SYS, since they
> >> trust the clients.
> >>
> >> What about mounts from mobile devices that do not have a fixed
> >> client IP host address?
> >> (I suspect that, currently, they seldom if ever use NFS, but I think
> >>  trying to support them could be useful.  A mobile client can use
> >>  a X.509 certificate to do a reasonable job of verifying its identity
> >>  if signed by a site local CA, although it cannot have a "wired-down"
> >>  DNS name in the certificate.)
> >
> > Those aren't really likely to use krb5, though.
>
> My intuition is Rick's usage scenario would be common if we made
> it possible. It's similar to how Windows/SMB works on laptops,
> and is a common deployment scenario in campus environments.
>
Although I won't claim to have any idea how widely used this might
be, I suppose a "shared desktop or laptop" such as you might find
in a college campus is a better example.

Another possible case, which I hesitate to even mention because
I have no understanding of it, is use in container like environments.
In FreeBSD, there is something called a vnet prison. Each of these
has their own password database, etc.  I had never thought that
running an nfsd inside one of these made sense, but others indicated
that this was desirable, so I have generated patches to do it.
(An nfsd running in one of these vnet prisons is what I actually used
 to test the NFSv4 client mount changes, although it certainly is not
 specific to this case.)

Similar to what Chuck notes below, when a mobile device is only used by one
user, Kerberos is not needed. (See below.)

>
> > I've been thinking about how to use a public key infrastructure to
> > provide stronger authentication of multiple individual users' RPC calls
> > and multiplexing them across a shared TLS connection.
> >
> > Since the client trusts the server through the TLS connection
> > authentication mechanism, and you have privacy guaranteed by that TLS
> > connection, then  really all you want to do is for each RPC call from
> > the client to be able to prove that the caller has a specific valid
> > identity in the PKI chain of trust.
> >
> > So how about just defining a simple credential (AUTH_X509 ?) containing
> > a timestamp, and a distinguished name, and have it be signed using the
> > (trusted) private key of the user? Use the timestamp as the basis for a
> > TTL for the credential so that the client+server don't have to keep
> > signing a new cred for each and every RPC call for that user, and allow
> > the client to reuse the cred for a while as a shared secret, once the
> > signature has been verified by the server.
All certainly doable, but to me it just sounds like you are re-inventing
Kerberos, but using X.509 certificates instead of Kerberos tickets.
(Isn't the main purpose of a KDC handling trusted private keys for users?)

Having said the above "Maybe such a system would catch on where
Kerberos has not?)

To me, part of the problem with Kerberized NNFSv4 is that it (mis)uses
Kerberos to create the machine credentials.

>
> A laptop typically has a single user. The flexibility of identity
> multiplexing isn't necessary in this particular scenario.
>
Yes, Chuck, I (and others) had a discussion on nfsv4@ietf.org some
time ago w.r.t. using the X.509 certificate presented during TLS handshake
to identify a specific user and then use credentials for that user for all
compound RPCs, ignoring the credentials in the RPC header.

Chuck labelled this "TLS Identity squashing" (he's much better at
naming things than I am).

I think we agreed that the concept is useful. We disagreed on what
would be the most appropriate way to implement it.
- The FreeBSD server currently expects the "user" to be identified
  right in the X.509 certificate, using the otherName component of
  the SubjectAltName field.
- Chuck preferred a database on the server keyed on <issuer, serial#>
  of the certificate.
However, these are implementation details and a NFSv4 server could
easily support either or both of these techniques.

rick

> --
> Chuck Lever
>
>
>
