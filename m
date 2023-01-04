Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C498765DC39
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jan 2023 19:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239695AbjADSfX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Wed, 4 Jan 2023 13:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239561AbjADSez (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Jan 2023 13:34:55 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2207D13F05
        for <linux-nfs@vger.kernel.org>; Wed,  4 Jan 2023 10:34:54 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id j16so27930224qtv.4
        for <linux-nfs@vger.kernel.org>; Wed, 04 Jan 2023 10:34:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SXKiDzhMgDmnQim86BhlIPfQnUVuEnlNBro+a+7gmfc=;
        b=oHfH2U8/ngbmqg6yVEF7BCZ404cWuUZjLwqfBWp9In80JUjni7cgmlOkCbEkdj0VgY
         EPz7n2zV35Z1Mj85Q8wpX3Io2M4tgPXMtUf5sQR9WBjydVYUgw+zih9zoihG0EWKOWJd
         OexxOHKoluOdvijqt0lTtWlir7eFyLIiv8gCtFur9mg2nEukTWfmOulqgWAhP7aohBvH
         KPSDH3qcN/Mj/WnKo5hk14dLcH5NWNXv0PURU8gX46wSFxGG4Ia4Lkl80JFdISXMHfak
         POXvKasn4VBunkQ/euEFMPdswLFLj6j/3r0qp5NnX8TD/TVTrq75BP+VaAvj4vgpt27d
         mcNA==
X-Gm-Message-State: AFqh2kpgIW6XUKZ0piIbVBdcebS0twBDfGg9sUftFqWgfFkv7RC1q8xQ
        n2jgWo0xD5V1FL7d78Gv/gathu1BLQ==
X-Google-Smtp-Source: AMrXdXsCMoEZFnd2YS4LVztnj9dhntG0/yWja+Ay/re0dsD6RA47VfsdpvbNIeWr31X1ycZWmmU55g==
X-Received: by 2002:ac8:4f16:0:b0:3a7:ec99:56e4 with SMTP id b22-20020ac84f16000000b003a7ec9956e4mr79435874qte.39.1672857293131;
        Wed, 04 Jan 2023 10:34:53 -0800 (PST)
Received: from [192.168.75.138] (c-68-32-72-208.hsd1.mi.comcast.net. [68.32.72.208])
        by smtp.gmail.com with ESMTPSA id br24-20020a05622a1e1800b00397e97baa96sm20569442qtb.0.2023.01.04.10.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 10:34:52 -0800 (PST)
Message-ID: <e617a14573851ca7710b99249653c952e0f901fa.camel@kernel.org>
Subject: Re: RFC:Doing a NFSv4.1/4.2 Kerberized mount without a machine
 credential
From:   Trond Myklebust <trondmy@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Rick Macklem <rick.macklem@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Wed, 04 Jan 2023 13:34:51 -0500
In-Reply-To: <15C694E4-925B-47E6-A054-644A0A142F88@oracle.com>
References: <CAM5tNy6nfvuqM30DwUVjTFHfewL8tSEQcyEJsSBzyWMTvDkEQw@mail.gmail.com>
         <e9fea39e926486146505c385dca50c116deb22f9.camel@kernel.org>
         <CAM5tNy7GM-5m-O2GUBwXCY=psSN2LKiE4bPPFyK=ABhObMdFCg@mail.gmail.com>
         <6ed7866da1e57a46da0108e9581242cd7f1ef2ce.camel@kernel.org>
         <FBAF6EA3-D78E-4F62-ACDB-8582973B4A93@oracle.com>
         <52f00169bb54c082dbffbcbf999c8096cb16d25d.camel@kernel.org>
         <15C694E4-925B-47E6-A054-644A0A142F88@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2023-01-04 at 18:06 +0000, Chuck Lever III wrote:
> 
> 
> > On Jan 4, 2023, at 12:25 PM, Trond Myklebust <trondmy@kernel.org>
> > wrote:
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
> 
> The trend I've seen is that enterprises are moving their important
> services out of from behind VPNs and into the cloud. Each such
> service is responsible for providing appropriate levels of
> authentication and confidentiality via a single-sign on service
> and an in-transit encryption capability.
> 
> 
> > I am interested in the general problem of authenticating RPC users
> > using certificates, since that is becoming more common due to the
> > rise
> > of S3 object storage and cloud services. While AD and krb5+LDAP can
> > be
> > extended into those environments too, there are plenty who choose
> > not
> > to, because PKI is generally sufficient, and can be more flexible.
> 
> We had SPKM. Would that not work?

The SPKM spec was withdrawn following review by the IETF security
working groups. Reviving it and pushing it again would require
addressing those comments.

Furthermore, SPKM was always intended as a full blown RPCSEC_GSS
mechanism, which seems like overkill for this use case.

-- 
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com


