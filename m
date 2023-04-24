Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A357C6ED03E
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Apr 2023 16:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjDXOXP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Apr 2023 10:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjDXOXP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Apr 2023 10:23:15 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F18E49;
        Mon, 24 Apr 2023 07:23:14 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id A016B320091F;
        Mon, 24 Apr 2023 10:23:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 24 Apr 2023 10:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benboeckel.net;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1682346191; x=1682432591; bh=Zej36Fnt4xYpnHBwhKPosCsz4
        nEINbQ9DukrU6uFcns=; b=NFTxX5xqk1sKo49+zZeQ5zZdZAyN4WBuNM6q/opet
        HAmVt0B/pliCra36kIiaHG3WqT3xDue6XQSJN5SYLyy0VJDcUytrzuZN/aEaqhom
        XgzGGm/FxlX0Y1j0CstbMmSZzvgsPD6aSS1fURXxI5xyDEeGRvFjNZ0q9wTMmF2j
        nBjlUNB58Uadr6nmhnGcjOtnSdnvepYtD3IdmMNhU0biSmcFTZ5oLqp9K0shoKg+
        kuvcyP8qnG1PnpuaEfBNeXuY2nY2V+yohX2lliv8Gd1vT6rXhu27cI7QfWxz9r47
        G5fUKgKpY2lIiXw+zXPSPQdEgyXVwj4iGuBPhpuIdXHZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1682346191; x=1682432591; bh=Zej36Fnt4xYpnHBwhKPosCsz4nEINbQ9Duk
        rU6uFcns=; b=WpCMpHuWH/kYNdzKO6Q1ZAQ/iXIiGUjgOv7dMat/Zn4nkxR1A+q
        1l3KP90pdB5Es2ziwMS6DumFYIbAxwSAmU+DuOdCaOM0gTdLGrFIqGGWbu4aPJh3
        mqkocJi5nrcVVkiF36tWwc/Czl8aak7BDx0NizKZLT5X2ndhf0X8DXD0Z/mFBbQa
        aPb1UQNdIetr9gDt/MN7SFHD9gjyA8uEeO3CDtStutYyxmkTO4tkpulWij8LxPUz
        zvFTMDZVnwVuEEEngH96dYfEaP1A8xtNhndjVNmFoa/1UTrJ6bFsJaK5DEOUevdF
        ifiv4UYKDwAtoc12ySV0KJlB18zaFVbHIhw==
X-ME-Sender: <xms:z5BGZMTQmHJfI3LngQkXgBFiTaTbteeMjSJuwxu9ii5pa_F2Z2AQyw>
    <xme:z5BGZJwXR8tW-WS0IjSKpfoBLs7yYitkfdU8WQrjKVu8XYT9xjaS4vpk9_jHm2mk3
    rm8Hrzt99BwsglipAQ>
X-ME-Received: <xmr:z5BGZJ2Nq288AagStAE0oc-7BEm6XW2KtLMb-RxcSDyrVhVTiHe3qCe67pE8TEVIo_bKS1bHSXp0kz7ZeDD13PP8vtTO4bnuraaq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedutddgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjfgesthekredttderjeenucfhrhhomhepuegv
    nhcuuehovggtkhgvlhcuoehmvgessggvnhgsohgvtghkvghlrdhnvghtqeenucggtffrrg
    htthgvrhhnpedukedvjeetueduffevfffhleefgfejhefffefhhfegieeiudevheefjeff
    teevfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmvgessggvnhgsohgvtghkvghlrdhnvght
X-ME-Proxy: <xmx:z5BGZADG5aSDPgJIQs4cdkbYMMRmy2XLI8DpGbHdTZLWRGZhXQxCHA>
    <xmx:z5BGZFgS_WlEpIPa90fhxXDiln3L8q5GnL_1tdRawRPL8r74X0ScRA>
    <xmx:z5BGZMp7QjmDmXOVI7alIvllOrloZXrLc15-WQTRpwU1wIYwDzSiWg>
    <xmx:z5BGZFaR77DJUSdYoeWZzCLR9HQamhUfCLBecaXgqMKb9MipkbBrrg>
Feedback-ID: iffc1478b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Apr 2023 10:23:10 -0400 (EDT)
Date:   Mon, 24 Apr 2023 10:23:09 -0400
From:   Ben Boeckel <me@benboeckel.net>
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     linux-nfs@vger.kernel.org, keyrings@vger.kernel.org
Subject: Re: [RFC PATCH 5/5] SUNRPC: store GSS creds in keyrings
Message-ID: <20230424142309.GB1072182@farprobe>
References: <20230420202004.239116-1-smayhew@redhat.com>
 <20230420202004.239116-6-smayhew@redhat.com>
 <20230422212710.GA813856@farprobe>
 <ZEaL8Wueo5/vOGTg@aion.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZEaL8Wueo5/vOGTg@aion.usersys.redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Apr 24, 2023 at 10:02:25 -0400, Scott Mayhew wrote:
> On Sat, 22 Apr 2023, Ben Boeckel wrote:
> > What is the format of this within the bytes?
> 
> The format is "clid: <client-id> id: <fsuid> princ:<princ>", where
> client-id and fsuid are unsigned ints and princ is either "(none)" or
> "*" if it's a machine cred:
> 
> crash> p ((struct key *) 0xffff8b4410197900)->description
> $1 = 0xffff8b4446cbd740 "clid:1 id:1000 princ:(none)"

Thanks. A bit annoying to parse, but doable.

> > > - The key payload contains the address of the gss_cred.
> > 
> > What is the format of this within the bytes?
> 
> The payload is just a pointer:
> 
> crash> p ((struct key *) 0xffff8b4410197900)->payload.data[0]
> $2 = (void *) 0xffff8b44381cd480

This looks less useful to userspace (beyond some kind of unique
ID…though can it be used to extract information about ASLR or any other
security mechanism?). Can userspace somehow write to this payload to
confuse things at all?

I'm no security expert so this is just a "random idea" to at least
hopefully trigger Cunningham's Law, but storing it `xor`'d with some
per-boot secret could help muddle any information
leak/extraction/targeting usefulness.

> > > - The key is linked to the user's user keyring (KEY_SPEC_USER_KEYRING)
> > >   as well as to the keyring on the gss_auth struct.
> > 
> > Where is this documented? Can the key be moved later?
> 
> It's not - I can add that to the documentation for the new key type.
> The key should not be moved.  I haven't tested if it's possible to move
> it, but it's something that we'd want to disallow.

If it shouldn't be unlinked that's one thing, there's still the
possibility of also linking it from another keyring (I don't see why
that should be a problem at least).

Also, to be clear I was talking about the `KEY_SPEC_USER_KEYRING`
keyring. Keeping it in the `gss_auth`'s keyring makes 100% sense (though
if there's no way to keep it there, that seems like a corner case that
would need considered).

Thanks,

--Ben
