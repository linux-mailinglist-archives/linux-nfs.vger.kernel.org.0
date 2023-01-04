Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E84165CC18
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jan 2023 04:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjADDQT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Jan 2023 22:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjADDQS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Jan 2023 22:16:18 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F9017409
        for <linux-nfs@vger.kernel.org>; Tue,  3 Jan 2023 19:16:18 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id n12so21985405pjp.1
        for <linux-nfs@vger.kernel.org>; Tue, 03 Jan 2023 19:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NzBVY4q9BsCDRZYkMk89RJsdhKSh3MIh3CE3YbE9vWw=;
        b=f7olWPXPEMmlXkTJS+zv0prKgltppNbaFyvZQrDEmP7r9VTTzXj9+c22Hi/mFccVmT
         MNo4NtkvhLiWKyarAOQqBAyBXapjkQzaIV7s+UudyE7fLXLtACibehgn40FIDm6y5m52
         itejPFZGjAYohNDzRV8yw+n8kSuLr/ED5XJd4pMyleBICPZua9XJuXa7T0mIeHi3a5ez
         /7HqAFoRdZl5aUBCs6F20DsYZwFI1+3HeX+g8pUdpsk+1jJII8uuncyV3VSHSwFthI9N
         3L5Go791xvEyrL31QR2Mu0nJs/N859WrsfwgEiIzHilwf4RGfoLNvQUMoKRqWcMC4Buu
         SgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NzBVY4q9BsCDRZYkMk89RJsdhKSh3MIh3CE3YbE9vWw=;
        b=WKiw0XEUkfIVZQF06ugJtm/DWWHFhRbC/lZ3HWkGrwQA4BWuLX6ldo7CRJJZWlTAhO
         02v1SCBWCtcYC8PUawd2uO9+Na8wP30203X790z33pjqmZT6TvkurEHpk8kOkXVLtq1L
         To4EVLFwifcKvC+ALUaZ7x4TNiHT2JnFPJqyYg6ABb8hpQcv+JV6Yn4TYg/VTnNTTbpJ
         7xogIfWqZD5bqPQwTnyOs/2ePGH20HjUthpxzk4WjNMDvaSKwiRuqN767EUF7It4t9jU
         mQTm/DId1MJilr9iMg8gP05Pzfqre4EgNoEBAgTtXtPr4wyeZZ9NMm+HKWIBEOTePgVf
         TWSw==
X-Gm-Message-State: AFqh2kqTrJH+tT2GRulueE7v/n4O4PRvcnXRWRr84vO1SS7+R3o5Ibwu
        E/OOdqpm0ehshKYcvQnXciyD6ewZq2mpLUHbqwAMeWo=
X-Google-Smtp-Source: AMrXdXuzJHUeo0a+5fOI0T31Pwm/9R4k3TFn5RDD5xCp02x/21vh3VwvDZ3MvEgaW7Jp5Aw4bWQebV+Yfqn49EwE1+I=
X-Received: by 2002:a17:90a:c909:b0:219:cc70:4726 with SMTP id
 v9-20020a17090ac90900b00219cc704726mr3376428pjt.30.1672802177503; Tue, 03 Jan
 2023 19:16:17 -0800 (PST)
MIME-Version: 1.0
References: <CAM5tNy6nfvuqM30DwUVjTFHfewL8tSEQcyEJsSBzyWMTvDkEQw@mail.gmail.com>
 <e9fea39e926486146505c385dca50c116deb22f9.camel@kernel.org>
In-Reply-To: <e9fea39e926486146505c385dca50c116deb22f9.camel@kernel.org>
From:   Rick Macklem <rick.macklem@gmail.com>
Date:   Tue, 3 Jan 2023 19:16:02 -0800
Message-ID: <CAM5tNy7GM-5m-O2GUBwXCY=psSN2LKiE4bPPFyK=ABhObMdFCg@mail.gmail.com>
Subject: Re: RFC:Doing a NFSv4.1/4.2 Kerberized mount without a machine credential
To:     Trond Myklebust <trondmy@kernel.org>
Cc:     linux-nfs@vger.kernel.org
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

On Tue, Jan 3, 2023 at 6:12 PM Trond Myklebust <trondmy@kernel.org> wrote:
>
> On Tue, 2023-01-03 at 17:28 -0800, Rick Macklem wrote:
> > I have recently implemented a NFSv4.1/4.2 client mount
> > on FreeBSD that uses AUTH_SYS for ExchangeID, CreateSession
> > (and the other state maintenance operations)
> > using SP4_NONE and then it defers an RPC that does:
> >    PutRootFH { Lookup, Lookup,... Lookup } GetFH
> > until a user process/thread attempts to use the mount.
> > Once an attempt succeeds, the file handle for the mount
> > point is filled in and the mount works normally.
> > This works for both a FreeBSD NFSv4 server and a Linux
> > 5.15 one.
> >
> > Why do this?
> >
> > It allows a sec=krb5 mount to work without any
> > machine credential on the client. (Both installing
> > a keytab entry for a host/nfs-client.domain in the
> > client or doing the mount based on a user principal's
> > TGT are bothersome.) The first user with a valid TGT
> > that attempts to access the mount completes the mount's
> > setup.
> >
> > I envision that this will be used along with RPC-with-TLS
> > (which can provide both on-the-wire encryption and
> > peer authentication).  The seems to be a reasonable
> > alternative to a machine credential and a requirement
> > for RPCSEC_GSS integrity or privacy.
> >
> > Why am I posting here?
> >
> > I am wondering if the Linux client implementors are
> > interested in doing the same thing?
> >
> > I think it is possible to extend NFSv4.2 with a new
> > enum state_protect_how4 value (SP4_PEER_AUTH?) that
> > would allow the client to specify what operations must
> > use RPC-with-TLS including peer authentication and which
> > must be allowed for this case (similar to SP4_MECH_CRED).
> > However, if the server forces the client to use RPC-with-TLS
> > plus peer authentication, that may be sufficient and does
> > not require any protocol extensions.
> >
> > Comments?
> >
>
> Are there really that many use cases for this? If you are using krb5
> authentication, then you pretty much have to support identity mapping.
> Unless you are talking about a hobby setup, then that usually means
> backing your Kerberos server with either LDAP or Active Directory to
> serve up account mappings, and it usually means protecting those
> databases with some form of strong authentication as well.
>
> IOW: for most setups, I would expect the machine credential requirement
> to be a non-negotiable part of the total AD/Krb5+LDAP security package
> that is implemented in userspace. Am I wrong?
>
For systems in machine rooms, you are probably correct, although I
think many of these environments would just use AUTH_SYS, since they
trust the clients.

What about mounts from mobile devices that do not have a fixed
client IP host address?
(I suspect that, currently, they seldom if ever use NFS, but I think
 trying to support them could be useful.  A mobile client can use
 a X.509 certificate to do a reasonable job of verifying its identity
 if signed by a site local CA, although it cannot have a "wired-down"
 DNS name in the certificate.)

rick

> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
