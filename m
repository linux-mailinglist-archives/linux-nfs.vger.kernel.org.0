Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CFB720EF7
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Jun 2023 11:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjFCJd5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 3 Jun 2023 05:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjFCJd4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 3 Jun 2023 05:33:56 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951A6E49
        for <linux-nfs@vger.kernel.org>; Sat,  3 Jun 2023 02:33:55 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 496845C0140;
        Sat,  3 Jun 2023 05:33:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 03 Jun 2023 05:33:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685784833; x=1685871233; bh=G+26Y7LTbSx5p
        PxMyCY0C/ca8ZBZskQsUKX1JfLcFD0=; b=R6CJCLKPbjiydOk7GOke4wlcYj65p
        FPRc0/TFalRaTHHlC4sB1PFpA3zUn7uBT12vO8zVF00mtZ07rtinNxKwl3zqWUA0
        zoDMmKZ93J6zRr8FZMtrNd2BGKNuWDNYnJrGCw1wW012/f+f7dRvTKgO6PfoFB2x
        7RMLv+nMeG06e19xPUgp6jWunZQX/wlXCt2UbIrSDdRFyAvBEZJHtRZvM5cElQi/
        O5lvtoZruUlgZrIwdbDYDMMkWnrnQcMsC1QT/CT4SrKfYXeJvKfRNYmRA5dDgHu3
        8uQ5Z1nvfsSredOPMjBhZzAU1O1Vkr9vWkIp0+f0XZskzvdUMTK45qDBA==
X-ME-Sender: <xms:AAl7ZNxMktGxnVIfhTgvWaWv1VkUTU2NxyzSOdPG3DLI81yZd7YJcw>
    <xme:AAl7ZNR9HpfbwLW8bAz8rKtXd6so8RkimTk-GZM27TjsROLm0tGgypNzOND_1f_Zs
    W5eGHVm1VMZRj8>
X-ME-Received: <xmr:AAl7ZHVj2Iudqtplu-EqrbDOwFtJPXIMnyd9sk57niJgXSS8fbSDStrEOqN8t9khL0BVnts31n70HhAoxb-zLXJXbBU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelhedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeg
    gefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:AAl7ZPjiPF-EVTLbKaA1uTJJYh_V2rk_OamwLviGnRQ9NXGwKYvqBg>
    <xmx:AAl7ZPA3u8lKkz3h6i3Z7g2KWusOzg2tZIX8cabb0KuHj3hlq_vQgA>
    <xmx:AAl7ZIINH0sE_OHuL35HjrQ_9recJNe3KNSPjV4fD4r5b5LEa70w6g>
    <xmx:AQl7ZE5VAAkYkfYWTjZ8AdmGEMYgCOqjX_zlDDRyg2ngMDc-nsZ62A>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Jun 2023 05:33:52 -0400 (EDT)
Date:   Sat, 3 Jun 2023 12:33:48 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     NeilBrown <neilb@suse.de>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 13/20] lockd: move lockd_start_svc() call into
 lockd_create_svc()
Message-ID: <ZHsI/H16VX9kJQX1@shredder>
References: <163816133466.32298.13831616524908720974.stgit@noble.brown>
 <163816148560.32298.15560175172815507979.stgit@noble.brown>
 <ZHoO3GRH6h/bcRjm@shredder>
 <168574130862.10905.10707785007987424080@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168574130862.10905.10707785007987424080@noble.neil.brown.name>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Jun 03, 2023 at 07:28:28AM +1000, NeilBrown wrote:
> From: NeilBrown <neilb@suse.de>
> Date: Sat, 3 Jun 2023 07:14:14 +1000
> Subject: [PATCH] lockd: drop inappropriate svc_get() from locked_get()
> 
> The below-mentioned patch was intended to simplify refcounting on the
> svc_serv used by locked.  The goal was to only ever have a single
> reference from the single thread.  To that end we dropped a call to
> lockd_start_svc() (except when creating thread) which would take a
> reference, and dropped the svc_put(serv) that would drop that reference.
> 
> Unfortunately we didn't also remove the svc_get() from
> lockd_create_svc() in the case where the svc_serv already existed.
> So after the patch:
>  - on the first call the svc_serv was allocated and the one reference
>    was given to the thread, so there are no extra references
>  - on subsequent calls svc_get() was called so there is now an extra
>    reference.
> This is clearly not consistent.
> 
> The inconsistency is also clear in the current code in lockd_get()
> takes *two* references, one on nlmsvc_serv and one by incrementing
> nlmsvc_users.   This clearly does not match lockd_put().
> 
> So: drop that svc_get() from lockd_get() (which used to be in
> lockd_create_svc().
> 
> Reported-by: Ido Schimmel <idosch@idosch.org>
> Fixes: b73a2972041b ("lockd: move lockd_start_svc() call into lockd_create_svc()")
> Signed-off-by: NeilBrown <neilb@suse.de>

Thanks for the quick fix. I no longer see the memory leak with this
patch.

Tested-by: Ido Schimmel <idosch@nvidia.com>
