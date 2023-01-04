Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7893E65DB3B
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jan 2023 18:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbjADR0G convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Wed, 4 Jan 2023 12:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234990AbjADR0B (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Jan 2023 12:26:01 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AED1180D
        for <linux-nfs@vger.kernel.org>; Wed,  4 Jan 2023 09:25:57 -0800 (PST)
Received: by mail-qt1-f169.google.com with SMTP id g7so27762415qts.1
        for <linux-nfs@vger.kernel.org>; Wed, 04 Jan 2023 09:25:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=plyf4QCQ/Za3eEh+MA/etLAPQ2vxjSA30kM8R50ifnk=;
        b=f5y1055cWaD5U0etNjn572H7y4O5D7bP7/sCzQ+6TxYg3W7R/hIyt8aGf2Dae3oh5X
         aqmoI0vh7BCx+s/RA4GGlvG425hYufWqBTDnrDV9QiGKdxvkfZlpmwh+Af1o8T7rhecp
         zEaGFinnGJ/NWHLYxKafNQNLR48WLOLAXs8CrrpJVa5wfiS8TIbiemyT+sHR0z8x30Wc
         RzEXuopJImyzyU93HVAoIdIB57jM55oFzya23fyKsvEaLN6TLS96LWdR30tMlIOExiOJ
         bvYdptRHHF3qQ6XqMof3DvLqKUonHh4gS83gza96lqXnHHN9vDHNPR6Qrnk+x+YTYpnB
         OXJw==
X-Gm-Message-State: AFqh2kqs4PKhDX9gak1VqMePRcDso3CQufC64cRvE3xkBrvvuKY+2fo+
        LPjc3h4z6VpO8dngvQYEVg==
X-Google-Smtp-Source: AMrXdXvGtx1uJphvkZ3pLfXo0rUWoGRdzq46b7zkPr6yHlHy0lim6is8ezPth8+r45SmsTTgDNPXGQ==
X-Received: by 2002:ac8:65da:0:b0:3a8:84f:1d59 with SMTP id t26-20020ac865da000000b003a8084f1d59mr64186151qto.19.1672853156821;
        Wed, 04 Jan 2023 09:25:56 -0800 (PST)
Received: from [192.168.75.138] (c-68-32-72-208.hsd1.mi.comcast.net. [68.32.72.208])
        by smtp.gmail.com with ESMTPSA id cn5-20020a05622a248500b003434d3b5938sm20770979qtb.2.2023.01.04.09.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 09:25:56 -0800 (PST)
Message-ID: <52f00169bb54c082dbffbcbf999c8096cb16d25d.camel@kernel.org>
Subject: Re: RFC:Doing a NFSv4.1/4.2 Kerberized mount without a machine
 credential
From:   Trond Myklebust <trondmy@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Rick Macklem <rick.macklem@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Wed, 04 Jan 2023 12:25:54 -0500
In-Reply-To: <FBAF6EA3-D78E-4F62-ACDB-8582973B4A93@oracle.com>
References: <CAM5tNy6nfvuqM30DwUVjTFHfewL8tSEQcyEJsSBzyWMTvDkEQw@mail.gmail.com>
         <e9fea39e926486146505c385dca50c116deb22f9.camel@kernel.org>
         <CAM5tNy7GM-5m-O2GUBwXCY=psSN2LKiE4bPPFyK=ABhObMdFCg@mail.gmail.com>
         <6ed7866da1e57a46da0108e9581242cd7f1ef2ce.camel@kernel.org>
         <FBAF6EA3-D78E-4F62-ACDB-8582973B4A93@oracle.com>
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

On Wed, 2023-01-04 at 14:25 +0000, Chuck Lever III wrote:
> 
> 
> > On Jan 3, 2023, at 11:41 PM, Trond Myklebust <trondmy@kernel.org>
> > wrote:
> > 
> > I've been thinking about how to use a public key infrastructure to
> > provide stronger authentication of multiple individual users' RPC
> > calls
> > and multiplexing them across a shared TLS connection.
> > 
> > Since the client trusts the server through the TLS connection
> > authentication mechanism, and you have privacy guaranteed by that
> > TLS
> > connection, then  really all you want to do is for each RPC call
> > from
> > the client to be able to prove that the caller has a specific valid
> > identity in the PKI chain of trust.
> > 
> > So how about just defining a simple credential (AUTH_X509 ?)
> > containing
> > a timestamp, and a distinguished name, and have it be signed using
> > the
> > (trusted) private key of the user? Use the timestamp as the basis
> > for a
> > TTL for the credential so that the client+server don't have to keep
> > signing a new cred for each and every RPC call for that user, and
> > allow
> > the client to reuse the cred for a while as a shared secret, once
> > the
> > signature has been verified by the server.
> 
> A laptop typically has a single user. The flexibility of identity
> multiplexing isn't necessary in this particular scenario.
> 

Yeah, I don't particularly care about laptop use cases. Most
enterprises set up VPNs for dealing with them because users typically
need access to more services than just a NFS server.

I am interested in the general problem of authenticating RPC users
using certificates, since that is becoming more common due to the rise
of S3 object storage and cloud services. While AD and krb5+LDAP can be
extended into those environments too, there are plenty who choose not
to, because PKI is generally sufficient, and can be more flexible.

-- 
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com


