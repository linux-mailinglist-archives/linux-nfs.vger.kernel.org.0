Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FB96ED45C
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Apr 2023 20:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjDXS2X (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Apr 2023 14:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjDXS2W (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Apr 2023 14:28:22 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CEE5FE8;
        Mon, 24 Apr 2023 11:28:20 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 38DD45C0144;
        Mon, 24 Apr 2023 14:28:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 24 Apr 2023 14:28:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benboeckel.net;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1682360898; x=
        1682447298; bh=VOtQWSe0xvxW1FIdIb1ccZwP8gLrLM7o39j9Dmdc54I=; b=m
        6j1KrD6/x0TIdAnTRPKggGG5tI7CITj3eG8steSjud4rqvfVVDKYdtxCuAmhMZo+
        CQ/bxc9mdhmEkCHHn0qaVGxnQ+IG05KmWBWSn8+WDLW/aFsgv2jd4MoU7kcs6taW
        y3JS6WxbsvY+4X3G5Ogo3OvEeFVCOzyeTjV+GrqBFMSzyC6BFVNt4vFJT5RFP6IC
        dPXISTIdlMu1wPczPNlFTQ9SWkNizg0+vvvkRXMUn6NkgASOAo63JmY7/Eu939sJ
        A3DEcd8BeIIrWcMhGU+gxkw/9cNgO7wTWvlb1sksOzOO5Xiv7E5h4YdxtEhDtFFd
        wVEKZkHuG5eHCld1vcK8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682360898; x=1682447298; bh=VOtQWSe0xvxW1
        FIdIb1ccZwP8gLrLM7o39j9Dmdc54I=; b=N2u01yyu5kC0PGXiOWLRGxUL1Bubo
        qlJYHyBkDTj+SVKwwsX3fpzowqCJ4KFbMXc7SEnm0xEm9GNoN7BTRWvyMx2BExgD
        imIhsWAw1w34DwGdJ2MJOcEDyqNLDEC4fiilDhKhFXDUeg2tkZNW2CqJpAtayWnR
        V+usxytGnw3QqsyBy2fc7z2mI9bsudMAzj/suY+xJuqcD/vzvOluKfERS5n6Gvd4
        6EYrgF2gCHzXaURMCp7+TNaX5cCMk86bqgt33FeGk6jGZ5EXAll4nDsoVDaLSaJv
        jC86spX1KyhGotgma19Cmh2QQJEMo1DSY6IZnlYD1aJRJZeewpoHjKmgQ==
X-ME-Sender: <xms:QcpGZD0WW6ziXWiFPxTpNJ2ubpD3tew5jtrT2wDBZQwq3Vxsy1spog>
    <xme:QcpGZCFi9ebkP4x4qlEAWETqp3gvZmwjAAOMgRz4RiHr2ltc221t1n6nlavcTASpI
    482oDkSTjzwclozda4>
X-ME-Received: <xmr:QcpGZD7GcNire0qVq8oj8Dd94z9zRfJrw0T1XwnOnuk5YgDJt8eCPLvCXg0S5L9RBD2dhh9_We9FtZSJ_76_rG6JkuVBQyYq_9mO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedutddguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjfgesthdtredttderjeenucfhrhhomhepuegv
    nhcuuehovggtkhgvlhcuoehmvgessggvnhgsohgvtghkvghlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeeghefgueekfeffffelieehhfejtdefjeefveffiefgvdfhheeujeeggfef
    teeijeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgvsegsvghnsghovggtkhgvlhdrnhgv
    th
X-ME-Proxy: <xmx:QspGZI2IK0SKF8slKZpfkDffJ_lg8XIiNekbvxmsawv74pLzfD7Mzg>
    <xmx:QspGZGGWd4eyoo3GwQZcREmz9ilmRkV2o7KIAwougOcFBlJXdRO3ZA>
    <xmx:QspGZJ_JWF8jSZEBhKb4TYzIvawNA5HdLyLFzupTDTsrzQSesQYSUQ>
    <xmx:QspGZIM4JD5bDxSDYK7YdxxrUWh-DR_lMET6FVuOWPOY3Lyu8jBqCA>
Feedback-ID: iffc1478b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Apr 2023 14:28:17 -0400 (EDT)
Date:   Mon, 24 Apr 2023 14:28:17 -0400
From:   Ben Boeckel <me@benboeckel.net>
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     linux-nfs@vger.kernel.org, keyrings@vger.kernel.org
Subject: Re: [RFC PATCH 5/5] SUNRPC: store GSS creds in keyrings
Message-ID: <20230424182817.GA1118847@farprobe>
References: <20230420202004.239116-1-smayhew@redhat.com>
 <20230420202004.239116-6-smayhew@redhat.com>
 <20230422212710.GA813856@farprobe>
 <ZEaL8Wueo5/vOGTg@aion.usersys.redhat.com>
 <20230424142309.GB1072182@farprobe>
 <ZEaZ5sLo2nBXUjl/@aion.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZEaZ5sLo2nBXUjl/@aion.usersys.redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Apr 24, 2023 at 11:01:58 -0400, Scott Mayhew wrote:
> Just to be clear, this isn't meant to be written or read by userspace.
> The user isn't explicitly requesting the creation of a key with the
> gss_cred key type.  It happens automatically when they access an NFS
> filesystem mounted with "sec=krb5{,i,p}", using the existing upcall
> mechanism to rpc.gssd.  The only difference is that instead of sticking
> the resulting gss_cred in the rpc_auth.au_credcache hash table, we're
> now creating a key with the address of the gss_cred and storing it in
> keyrings.

Ah, ok. I'm mostly interested in the userspace side as the author of
https://github.com/mathstuf/rust-keyutils which I try to keep some safe
wrappers around various keytypes.

> We definitely allow unlinking - that's sort of the whole point because
> it allows users to establish a new GSS credential (most likely with a
> different initiator principal that the old one).
> 
> It doesn't really make sense for the key to be on any other keyring besides
> the user keyring.  If it were on the session keyring, and if you were
> logged into multiple sessions, then those sessions would be constantly
> whacking each others GSS creds and they be constantly
> creating/destroying new GSS creds with the NFS server.
> 
> Having them on the session keyring also presents another problem because
> the NFS client caches NFSv4 open owners, which take a reference on a
> struct cred.  When you log out, pam_keyinit revokes the session keying.
> If you log back in and try to resume NFS access (generating a new key),
> the current request key code will find the cred with the revoked session
> keyring, and it will try to link the new key to that revoked session
> keyring, which will then fail with -EKEYREVOKED.  That's the reason
> for patches 3/5 and 4/5, to allow request_key_with_auxdata() to link the
> key directly to the user keyring.

Ok. These lifetime things definitely deserve docs.

Thanks,

--Ben
