Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21724C25D5
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Feb 2022 09:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiBXIUZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Feb 2022 03:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiBXIUX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Feb 2022 03:20:23 -0500
Received: from new2-smtp.messagingengine.com (unknown [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439291C8D87
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 00:18:14 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8214F5803A4;
        Thu, 24 Feb 2022 03:17:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 24 Feb 2022 03:17:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=8MbxVUqXYeDf78XUdZk/GXWOBpFOLzHOZO6xdx
        h6Wl4=; b=IRG9zuV3tFMNkzHi/AgJip2dQr9FIETKYXKPWRrluqY60jM+T6EnVG
        Gdkw/4QZ7okHmvpU4PPRHS+DcrGbUZWlRxw5ZA6k91OtQAnEUr/FtoFYvrb+jyLG
        uE5aKQcuYkaTQbhxA/AvtqoxIbJ3EqMPCqPbY7+gcZxRRa6crreC0bWWIQGIB0p7
        qw8gBcGbqhw7e9h1P7EtzjCkozWaOa3dXiRA5+DLqVb13V7Q6eXt0350NUvJYjb+
        NNs000OQM/KdIa7CRgharijOZsTr0Rd/Lfq/b4hgq9zl0NrSyo3SuvzUNEjAfbVb
        mQokwcLRZoEbiw935WO24k+GG7a479Gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=8MbxVUqXYeDf78XUd
        Zk/GXWOBpFOLzHOZO6xdxh6Wl4=; b=KrJZsEAEBFYkfZsRU4WPilVTVN+ncZixZ
        WKtWpweCfBfYirRAeDzNgYjLaqTzgC/1nDkIOJmvjOeBoXVxuRtGacqvKY1RUOQA
        JZwefi9t8BCKeM+yIjWi0NgKivcKSwdlpnkmOOsgevYPUn7lZHo1XPhqDTJOJwxS
        bUQoFf8HQ3XtYd/PTWWLaKC8ntijD3DCKWqezbO2sTXaw0TJV/V3y7NaOR86WW5a
        hKH7WcCrZz/r8OWnMNWT5bJSh4+YqxxiVdNjqX1TSLkTvU9WpaiLhCfywZQ1qxrV
        jwLJpN1/dxQND+8CYKxv3lhPIpsPXi4wXliHhwrrNV2JjY+w72yJQ==
X-ME-Sender: <xms:NT8XYn_y8tG0o-6vtGra1U7b6mptwhF1W3_bC5ulAwX5EWPtMuBiDQ>
    <xme:NT8XYjt2WaF2L6pCCfaSV9d9xKOLoKi0g-i29jmExO2uoPmFr3hte0yfBY1bGNopU
    DatB-0DZeghrg>
X-ME-Received: <xmr:NT8XYlCxFDMEppJUtzZuF1PY4_7vZZ0Sd709iU8vNUIRopdaXDWw1me_mNjsmO5i0VURF-xUw1T2ghcQT5aN45r8fajOYmsa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrledugdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mfhrohgrhhdqjfgrrhhtmhgrnhcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrf
    grthhtvghrnhepfeeuveektddutdduiedukeeufedtjeekhefhieevhefhleduffehfffh
    vefhtdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:Nj8XYjfLwHFjZXimCxJqUeBJgrcYC4O5Bpsys37SdZLgdm5wX_d23w>
    <xmx:Nj8XYsO0oeq7HRuWsGO9OFGckUPsiI4OW8vE4xSZw57B7vayqDSp4g>
    <xmx:Nj8XYlnF623gU0xm0S-YbeuC4CPigsqMwPAEyKZnPAGybnYj7sZk4g>
    <xmx:Nj8XYtH9Om91qFnN4DJtYP9iVF0fbH5ECrKXVLj5J61BSsCRu5TL8A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Feb 2022 03:17:57 -0500 (EST)
Date:   Thu, 24 Feb 2022 09:17:56 +0100
From:   Greg Kroah-Hartman <greg@kroah.com>
To:     Kurt Garloff <kurt@garloff.de>
Cc:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Schumaker, Anna" <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: Re: 6f283634 / 1976b2b3 breaks NFS (QNAP/Linux kNFSD)
Message-ID: <Yhc/NNNuNJ+PVTuj@kroah.com>
References: <50bd4b4d-3730-4048-fcce-6c79dfe70acf@garloff.de>
 <8957291b-ecd1-931e-5d0c-7ef20c401e5d@garloff.de>
 <F693AC98-DCB4-4086-AC19-EE1B71DB2551@netapp.com>
 <be851303-b1bb-7d8d-832e-a1a3db529662@garloff.de>
 <10d55787-7b97-8636-9426-73fdeda0a122@garloff.de>
 <6401c5e1-8f05-5644-9bea-207640a21b77@garloff.de>
 <CAN-5tyG+CiPVi=wQDvMp0rWyt9TgCYnb_1_g_TYQSrxEFz7sAw@mail.gmail.com>
 <691bc46a-637c-5bc7-add9-d6da2f429750@garloff.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <691bc46a-637c-5bc7-add9-d6da2f429750@garloff.de>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Feb 23, 2022 at 11:24:41PM +0100, Kurt Garloff wrote:
> Hi Olga,
> 
> On 23/02/2022 18:56, Olga Kornievskaia wrote:
> > On Wed, Feb 23, 2022 at 8:20 AM Kurt Garloff <kurt@garloff.de> wrote:
> > > Hi Olga,
> > > 
> > > any updates? Were you able to investigate the traces?
> > > 
> > > Breaking NFS mounts from Qnap (knfsd with 3.4.6 kernel here,
> > > though Qnap might have patched it),is not something that
> > > should happen with a -stable kernel update, even if the problem
> > > would be on the Qnap side, which would not be completely
> > > surprising.
> > > 
> > > So I think we should revert this patch at least for -stable,
> > > unless we understand what's going on and have a better fix
> > > than a plain revert.
> > I haven't commented on your ask of requesting a revert in the stable
> > version. I'm not sure what the philosophy there. I don't see why we
> > can't ask for this feature to only be available from the kernel
> > version it has been accepted into and not before. If you think the
> > kernel version that you want to use will always be before this feature
> > was accepted, then asking folks responsible for "stable" kernels seems
> > like a good idea. At the time of inclusion to stable, I wasn't aware
> > of the broken legacy server implementations out there.
> 
> I guess Greg would need to comment on the detailed policies
> for stable kernels.
> One of the goals for sure is to avoid regressions. If that causes
> bugs not to be fixable or features not to be available, than that's
> a price that might need to be accepted. A regression is just many many
> times worse than an unfixed issue, twice so for something that claims
> to be stable.

The policy for the stable kernel releases is the same as for Linus's
releases, "no user visible regressions are allowed".

There is no difference here, if something changes in one of Linus's
releases that breaks a working system, then it needs to be fixed.  The
stable kernels are not unique here at all.  Any user must be able to
always upgrade to a new kernel version without having to worry about
anything breaking.

So if there is a kernel change in Linus's tree that breaks existing
systems, it needs to be reverted or fixed to not do this.

thanks,

greg k-h
