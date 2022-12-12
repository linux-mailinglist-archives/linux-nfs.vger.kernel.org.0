Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5DF649F07
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Dec 2022 13:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbiLLMpH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Dec 2022 07:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbiLLMo4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Dec 2022 07:44:56 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C313B11A2F
        for <linux-nfs@vger.kernel.org>; Mon, 12 Dec 2022 04:44:55 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 8A94C32002E2;
        Mon, 12 Dec 2022 07:44:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 12 Dec 2022 07:44:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1670849092; x=1670935492; bh=cF/Fc5/kC0
        StQ3XpMddKpJOQaJOFVBAehdUw/Rj6mnA=; b=PvlVaTmFdCX7tjuYGgRPy6QbSF
        IU4TTVLzOpTEZi0m8oGg0/YmCVgQkitWibTkVuHNpblp6y5xlFp59lBy+mzHP9En
        zTS2NFXWlYnpDTv58FBGQ0otEqNX140PTtVdjfFyghCKayAzx2WwNjcWhS8Wo7qY
        ANLSVwB7MQv1+rss1VbzRePeVABvIAoKOE8Nin3pjh4befKTLTbLnjlEOupbokny
        1IWUx3dG+nDunzWXjLU/DgTSlAgZ8FNc//N2QPvnEwBLizGWxRRIIdtcYEHJ4uvm
        zMh9x3b6tfhjdGllrTA02ck67ifQ1O7xJj8B2GFegXdOMKadu+SRUUELT3rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1670849092; x=1670935492; bh=cF/Fc5/kC0StQ3XpMddKpJOQaJOF
        VBAehdUw/Rj6mnA=; b=l0PDXATkX//56F36L2sLmBO+qCJlogsyWyF6yh9wifcS
        9XXy/VN0JwSr76CayQmdntOfHCo1ITtMPeZyDaMecn1gj7mYngJP37aFuGwmSRdt
        wcX6zxTr2M/KY2yTe1UXIxNEyJ+bZwGdKOo55nvZTjyLvCYNt0zM1wuYH4c45DEZ
        DmpZcABT0zCh5on1KWfbW/OqHk/jTlHnXDbVWsC9pMPwv+XOd2vugWECAvQJweBp
        FMY38s8CyJltJ7HOwyCgHyOsbQMxiwyqYf2YGyrlZJxo7mO6tFgmmTWiEqQaQ27k
        w08an9jReMMxW2jExNMVKGtnWvgds8lCh/NedmZRjQ==
X-ME-Sender: <xms:QyKXY7dg9fmJ_zPH8PLAfq2MNBs6BmfgcFe61mRBKRiI2KKinn4e5w>
    <xme:QyKXYxO0CAUEBkdiUDY821Qg9zXed1Qf_9XDGvBUgiK4kvb-wJz3FmjNj4eADeFio
    Qu_oRJhq3tYJQ>
X-ME-Received: <xmr:QyKXY0gWYmmtwN3x-DEX8nh1MakoMVrgNmCWRUjEwNA8E0wstXhInEXPgYz2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekgddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvve
    dvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:QyKXY8-YCz7M5lJeR0S-xHJdYqRmNdIdJcxiKnl1JSWSyvFghBrHGQ>
    <xmx:QyKXY3vOUXP7VzLzx3qcu3s5j4BACYIYlWQGfcZl6RtmEqyOWEqZng>
    <xmx:QyKXY7EIoh1YqVWsS1yWcccD_lzPsvrR5ZTy8sjKuqSr5Gd63Nf-tA>
    <xmx:RCKXYwHKRm1G7_gfDQJUhwZ4z9cqbOIo7peATdFyUYt4xt5DvpOXOQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Dec 2022 07:44:49 -0500 (EST)
Date:   Mon, 12 Dec 2022 13:44:45 +0100
From:   Greg KH <greg@kroah.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Xingyuan Mo <hdthky0@gmail.com>, Dai Ngo <dai.ngo@oracle.com>,
        chuck.lever@oracle.com, kolga@netapp.com,
        linux-nfs@vger.kernel.org, security@kernel.org
Subject: Re: [PATCH 1/1] NFSD: fix use-after-free in __nfs42_ssc_open()
Message-ID: <Y5ciPU5rNaukLUB7@kroah.com>
References: <1670786549-27041-1-git-send-email-dai.ngo@oracle.com>
 <CALV6CNOO-Ppv7QfqHo9RKivv-1NUrezbuYN2krrNu4REuchtMA@mail.gmail.com>
 <Y5cXkyWUVf433sd5@kroah.com>
 <74076faddd6a92de8c293aad317860a65f8a779a.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74076faddd6a92de8c293aad317860a65f8a779a.camel@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Dec 12, 2022 at 07:26:27AM -0500, Jeff Layton wrote:
> On Mon, 2022-12-12 at 12:59 +0100, Greg KH wrote:
> > On Mon, Dec 12, 2022 at 07:22:38PM +0800, Xingyuan Mo wrote:
> > > Can I share the patch with the linux-distros list, so that
> > > distros can do their own testing and preparations?
> > 
> > Be _VERY_ aware of the rules regarding that list before you send
> > anything as you are going to have some very strict rules put on you with
> > regards to what you must do once you post to them.
> > 
> > Personally, I would prefer if this gets into Linus's tree first so that
> > we can get it into a stable release before letting distros know about
> > it, otherwise you are forcing me into a very tight schedule that might
> > require you to tell the world about the problem _BEFORE_ the fix is in
> > Linus's or any stable kernel trees.
> > 
> 
> I think that ship has sailed, as the linux-nfs list was cc'ed on this
> patch.

Ah, missed that, nice!

So no need to let linux-distros know about it either :)

thanks,

greg k-h
