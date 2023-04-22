Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A81A6EBB81
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Apr 2023 23:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjDVV1R (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 22 Apr 2023 17:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjDVV1Q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 22 Apr 2023 17:27:16 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349C1198B;
        Sat, 22 Apr 2023 14:27:14 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 6DD2D5C0131;
        Sat, 22 Apr 2023 17:27:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 22 Apr 2023 17:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benboeckel.net;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1682198832; x=
        1682285232; bh=DruTjwzpMyWiIaxUQ/8q7NTY33luPc4IWWsktpThtlA=; b=p
        ntWKjmNvW464H3DEa1QjgffP+BkP5pSkxOjdbjag3QNuOsO1EKhu/O1ufAuGl41m
        KFVhW+7VegwXKihHB89Np1Xinsdvgm1GXPveAPijsVT/ps564DTYg2Afr12FtfEV
        H7qlHFv9bjVxh0vW9nq7l8Zc4wAHuUL+GWo5hcMhEHpsvL4UWVa0yaQyGVdqFAKh
        nry0yih3UaBOsxF3MVln/S4ONDXQn483LiOG26iFPnier6YxXuQ/cNqotFGGGmby
        kTe+nIZog2WF5r/VxoA3ulo45mw4Gjai+wH9MRrgfjMJX/AHm/F9juDkulO8dGO3
        zhJQ7PBoKhbAu2h849f+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682198832; x=1682285232; bh=DruTjwzpMyWiI
        axUQ/8q7NTY33luPc4IWWsktpThtlA=; b=ALt6Ka2MGjdVJdZ3yvLZusE2FHG5l
        VMlPrLcNAKntOsP468QvUSsj4exf9NLF00KMgcfdSur/rRzu4sd8APDnMqfKgAqw
        YjEBPhBVe/n13CkN80fPxC6HjU2fVtlbX43YmqUVZAIEGV0eoRUsrVsC0l8JKpXD
        o8dze49KeoT2zyidhjM/qJ+sFI5JYrepOuo70pObBFh4JHjocDHh5NjXgjmVI/8+
        XKtICci6UXn6bqkjn3VgRS+R+xpH/XDN0d8tw3u/gGqiaiUk54UHN2gY7Xweq/Lu
        Bjzz9SKzqVb+fIw7lH/MG3H/KPS3EUtoQTI1x5+ikMPjVZ9YCCWU1YayA==
X-ME-Sender: <xms:MFFEZGM851jqSBH46GzTeZhAzZ2XGrqLPLuF0QYx4kYeI2ufhLP8qg>
    <xme:MFFEZE_E72cTaL7A-akDbHA2cyzd-OoTWDUH5BEbIz1d-FOSdDuEAenyXwBAzBT7I
    PF0gy93Viv5QHuknNU>
X-ME-Received: <xmr:MFFEZNTnqR0rIy2h1vCNkjyK6ZIQ1tYhF4KcEakcrJ-JroUi1q8vVcKZAc_e69_eP3mJHG5HE6SaQmU0AisJg58mrXJAGBcmTmls>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedtiedgudeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjfgesthdtredttderjeenucfhrhhomhepuegv
    nhcuuehovggtkhgvlhcuoehmvgessggvnhgsohgvtghkvghlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeffleegffevleekffekheeigfdtleeuvddtgffhtddvfefgjeehffduueev
    kedvvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmvgessggvnhgsohgvtghkvghlrdhnvght
X-ME-Proxy: <xmx:MFFEZGuZ8xsTe5jeu6Em6Q2lRlLeTFmyfTMWw-6EBURIND8B-3-F-w>
    <xmx:MFFEZOc4djfI--aNovrzQJehiBtgfpjCzlu30P_ivptBvkBZGcbMZw>
    <xmx:MFFEZK1gUBzdsBKWimv_shvOXk7_m76fKHK8wMlywSNPReXtPF6vMw>
    <xmx:MFFEZCFHfqPOL7ubleIW1VhPY_6q5SuhKfVK59_oeLsZ0dXx6rpkAw>
Feedback-ID: iffc1478b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 22 Apr 2023 17:27:12 -0400 (EDT)
Date:   Sat, 22 Apr 2023 17:27:10 -0400
From:   Ben Boeckel <me@benboeckel.net>
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     linux-nfs@vger.kernel.org, keyrings@vger.kernel.org
Subject: Re: [RFC PATCH 5/5] SUNRPC: store GSS creds in keyrings
Message-ID: <20230422212710.GA813856@farprobe>
References: <20230420202004.239116-1-smayhew@redhat.com>
 <20230420202004.239116-6-smayhew@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230420202004.239116-6-smayhew@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Apr 20, 2023 at 16:20:04 -0400, Scott Mayhew wrote:
> This patch adds the option to store GSS credentials in keyrings as an
> alternative to the RPC credential cache, to give users the ability to
> destroy their GSS credentials on demand via 'keyctl unlink'.

Can documentation please be added to `Documentation/security/keys` about
this key type?

> Summary of the changes:
> 
> - Added key_type key_type_gss_cred and associated functions.  The
>   request_key function makes use of the existing upcall mechanism to
>   gssd.
> 
> - Added a keyring to the gss_auth struct to allow all of the assocated
>   GSS credentials to be destroyed on RPC client shutdown (when the
>   filesystem is unmounted).
> 
> - The key description contains the RPC client id, the user id, and the
>   principal (for machine creds).

What is the format of this within the bytes?

> - The key payload contains the address of the gss_cred.

What is the format of this within the bytes?

> - The key is linked to the user's user keyring (KEY_SPEC_USER_KEYRING)
>   as well as to the keyring on the gss_auth struct.

Where is this documented? Can the key be moved later?

> - gss_cred_init() now takes an optional pointer to an authkey, which is
>   passed down to gss_create_upcall() and gss_setup_upcall(), where it is
>   added to the gss_msg.  This is used for complete_request_key() after
>   the upcall is done.
> 
> - put_rpccred() now returns a bool to indicate whether it called
>   crdestroy(), and is used by gss_key_revoke() and gss_key_destroy() to
>   determine whether to clear the key payload.
> 
> - gss_fill_context() now returns the GSS context's timeout via the tout
>   parameter, which is used to set the timeout of the key.
> 
> - Added the module parameter 'use_keyring'.  When set to true, the GSS
>   credentials are stored in the keyrings.  When false, the GSS
>   credentials are stored in the RPC credential caches.
> 
> - Added a tracepoint to log the result of the key request, which prints
>   either the key serial or an error return value.
> 
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
>  include/linux/sunrpc/auth.h    |   4 +-
>  include/trace/events/rpcgss.h  |  46 ++++-
>  net/sunrpc/auth.c              |   9 +-
>  net/sunrpc/auth_gss/auth_gss.c | 338 +++++++++++++++++++++++++++++++--
>  4 files changed, 376 insertions(+), 21 deletions(-)

Thanks,

--Ben
