Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804E265DC5B
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jan 2023 19:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239845AbjADSvN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Wed, 4 Jan 2023 13:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbjADSvN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Jan 2023 13:51:13 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A18313
        for <linux-nfs@vger.kernel.org>; Wed,  4 Jan 2023 10:51:12 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id c7so27949721qtw.8
        for <linux-nfs@vger.kernel.org>; Wed, 04 Jan 2023 10:51:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bpAtG7xSh5PErj/3NC4Svr+gRK92VosP9IWH/7RPulU=;
        b=mGbKgo6tvrJFl8GMeMHfjdlrSAb1hQcXM4tJWHKPJ1fYzFWFDaz4NRmd7PR8a3V3MV
         IdWTjrhOhJFDj8suYt1xAfSmnV6EqHfLUt9b5CuVa9O2QnHsaqP7e6rOAKv/sW5fCK9Y
         EztMcBb+qCeW4jPVtJsfroq4bfxajo8QoXHkTBOOGVjG2G0J22dgWM06ppcBGrXuMxMU
         Wo824o9yTcphjlxnanpzMdxEalTZlrX9tIMFj4WjKl7iAO3MoyHq66kPQlNdEHQfHwGy
         QOtHdvhG/AHvW39FzebQxUsVrpRbRpgnV2QuPIg2K3fAJicn97BQoirl6wwll3eXOTkP
         b9yQ==
X-Gm-Message-State: AFqh2kozGpc05IStaZ6JaOdND7cDuglVLJXAUQUM7HaexT/pPbHAzQ39
        vUv+dNTdLR2AfnOOAVfjQA==
X-Google-Smtp-Source: AMrXdXuUU4D9gC+zgPbf7bh+bLLQ01IVDt1Cbhv1AhyvNgXygQ5lvihtHgDJ0qT/4HturUa0GFYG6w==
X-Received: by 2002:ac8:4e44:0:b0:3a9:8842:5854 with SMTP id e4-20020ac84e44000000b003a988425854mr90000615qtw.52.1672858271041;
        Wed, 04 Jan 2023 10:51:11 -0800 (PST)
Received: from [192.168.75.138] (c-68-32-72-208.hsd1.mi.comcast.net. [68.32.72.208])
        by smtp.gmail.com with ESMTPSA id 6-20020ac85646000000b003a6947863e1sm20220187qtt.11.2023.01.04.10.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 10:51:10 -0800 (PST)
Message-ID: <7939d2dda6dd421035c65cfa85e58291d9871030.camel@kernel.org>
Subject: Re: RFC:Doing a NFSv4.1/4.2 Kerberized mount without a machine
 credential
From:   Trond Myklebust <trondmy@kernel.org>
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Rick Macklem <rick.macklem@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Wed, 04 Jan 2023 13:51:09 -0500
In-Reply-To: <CAN-5tyGFpV3s+kodEJYCQBNgXis35JC3gWTPU-9jYXJwec7YBg@mail.gmail.com>
References: <CAM5tNy6nfvuqM30DwUVjTFHfewL8tSEQcyEJsSBzyWMTvDkEQw@mail.gmail.com>
         <e9fea39e926486146505c385dca50c116deb22f9.camel@kernel.org>
         <CAM5tNy7GM-5m-O2GUBwXCY=psSN2LKiE4bPPFyK=ABhObMdFCg@mail.gmail.com>
         <6ed7866da1e57a46da0108e9581242cd7f1ef2ce.camel@kernel.org>
         <FBAF6EA3-D78E-4F62-ACDB-8582973B4A93@oracle.com>
         <52f00169bb54c082dbffbcbf999c8096cb16d25d.camel@kernel.org>
         <CAN-5tyGFpV3s+kodEJYCQBNgXis35JC3gWTPU-9jYXJwec7YBg@mail.gmail.com>
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

On Wed, 2023-01-04 at 13:34 -0500, Olga Kornievskaia wrote:
> On Wed, Jan 4, 2023 at 12:43 PM Trond Myklebust <trondmy@kernel.org>
> wrote:
> > 
> > On Wed, 2023-01-04 at 14:25 +0000, Chuck Lever III wrote:
> > > 
> > > 
> > > > On Jan 3, 2023, at 11:41 PM, Trond Myklebust
> > > > <trondmy@kernel.org>
> > > > wrote:
> > > > 
> > > > I've been thinking about how to use a public key infrastructure
> > > > to
> > > > provide stronger authentication of multiple individual users'
> > > > RPC
> > > > calls
> > > > and multiplexing them across a shared TLS connection.
> > > > 
> > > > Since the client trusts the server through the TLS connection
> > > > authentication mechanism, and you have privacy guaranteed by
> > > > that
> > > > TLS
> > > > connection, then  really all you want to do is for each RPC
> > > > call
> > > > from
> > > > the client to be able to prove that the caller has a specific
> > > > valid
> > > > identity in the PKI chain of trust.
> > > > 
> > > > So how about just defining a simple credential (AUTH_X509 ?)
> > > > containing
> > > > a timestamp, and a distinguished name, and have it be signed
> > > > using
> > > > the
> > > > (trusted) private key of the user? Use the timestamp as the
> > > > basis
> > > > for a
> > > > TTL for the credential so that the client+server don't have to
> > > > keep
> > > > signing a new cred for each and every RPC call for that user,
> > > > and
> > > > allow
> > > > the client to reuse the cred for a while as a shared secret,
> > > > once
> > > > the
> > > > signature has been verified by the server.
> > > 
> > > A laptop typically has a single user. The flexibility of identity
> > > multiplexing isn't necessary in this particular scenario.
> > > 
> > 
> > Yeah, I don't particularly care about laptop use cases. Most
> > enterprises set up VPNs for dealing with them because users
> > typically
> > need access to more services than just a NFS server.
> > 
> > I am interested in the general problem of authenticating RPC users
> > using certificates, since that is becoming more common due to the
> > rise
> > of S3 object storage and cloud services. While AD and krb5+LDAP can
> > be
> > extended into those environments too, there are plenty who choose
> > not
> > to, because PKI is generally sufficient, and can be more flexible.
> 
> It sounds like you want some kind of TLS channel binding (rfc 9266).
> 
> However I think in general it's frowned upon to share different
> authentication(s) over a secure channel. Or at least it sounds to me
> that in rfc 9266 they are not allowing sharing of different
> authentications over the same TLS session. But I could be wrong.

Channel bindings require mutual TLS authentication between the server
and the client because the idea is that the client can then be trusted
by the server to authenticate the users.

I'm looking for something that only requires the server to authenticate
to the client, and that then allows the applications running RPC calls
to authenticate their users to the server at the per-RPC level. That
requires stronger authentication at the RPC level, but doesn't need the
full-blown RPCSEC_GSS treatment because we already have privacy
guaranteed at the transport level.

-- 
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com


