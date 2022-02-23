Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821FA4C1A37
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 18:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbiBWRuM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 12:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiBWRuL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 12:50:11 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A40E3AF
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 09:49:43 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id p15so53919379ejc.7
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 09:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HhUYvNlKvKeuar3LIm24j30DTCZB1D0Lxdvz2XqTJGY=;
        b=gbLNHCHvHzDjM2RgRhrD8U3Qfmu+zgeceRj0lEz3d3WFnNZARUUBe84pi2uMpXx0SE
         1iY9WfusEtlfUNsdaN41sN3mmHuspOsvn2Sga+V9xEJ2LYk8q8VGzDjIc4PGlBQBHC8z
         IsjCPT3jkJwl1LWg5YV6ks3lDrww26wG5yKRHEBnkXH0+Dn4CJ8pqpJ2SjrIoOhWVz1C
         LUHmevsOsYFWeA6MpZMQUSTzc2D3HgtQaMKuIqv8agF6O3MRNkrriWEbNuDr5I8dGKx5
         vD4vCnKKetDhG1jWB1Gq83kNk3aIyXB534mBiN4OtCLo5X7gRtuu11yy2CbdTQ8KGV35
         Sarw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HhUYvNlKvKeuar3LIm24j30DTCZB1D0Lxdvz2XqTJGY=;
        b=XAfo+OhGHKseGQTCMuwvPZL/Ni0L+hcBelWZkoGWL1TkSnRD1WKfOQ7uxkq6e2+LS6
         ampxvZxVbWMQClvAAjFQR6SEqWa545d5HKsnrDbaeGNeUIVpfOoHfsRtHbG9AdN8Gflg
         9XajOeI0yezCXSnCV4YuEO8/ffK1DafiFn+ndU94cXWDirGH6IB7yea4OWqXESpO6VBr
         ofytuA4G0y9Gh0NPfd6wkNy4sDWJEmO3ZqViHMw2i3wtEmsrEo1s2IDIScyGo9NrN7sk
         RB0/6YnHj4122RLGJ7t2USc0fQ87kD/OBSERgokje85n/I9Bx+H/EZmbno8pqQLrfV8r
         XuUw==
X-Gm-Message-State: AOAM532uO1T7oBv10+QQD1HP65APxdDgG8P3CBQDNHu/9P8D7l+ljE2t
        Hnsu3LyPCvtJneIWgUSSY0pGHSL1nUmnOVuuxdtfRejG
X-Google-Smtp-Source: ABdhPJwINLQvtWyij39imshFvWVkUlBtIEMprjOoqADAPtFZDGwoHtwTkWO+SAPz3UXB+pJpr/uQ0S1SvUhk1Dflocw=
X-Received: by 2002:a17:906:40da:b0:6ce:51b:a593 with SMTP id
 a26-20020a17090640da00b006ce051ba593mr656636ejk.604.1645638581806; Wed, 23
 Feb 2022 09:49:41 -0800 (PST)
MIME-Version: 1.0
References: <50bd4b4d-3730-4048-fcce-6c79dfe70acf@garloff.de>
 <8957291b-ecd1-931e-5d0c-7ef20c401e5d@garloff.de> <F693AC98-DCB4-4086-AC19-EE1B71DB2551@netapp.com>
 <be851303-b1bb-7d8d-832e-a1a3db529662@garloff.de> <10d55787-7b97-8636-9426-73fdeda0a122@garloff.de>
 <6401c5e1-8f05-5644-9bea-207640a21b77@garloff.de> <CAN-5tyHC0m8nLgEi89EdKUo-kpEWsi-LUNHqAXc=gBzW+u52NA@mail.gmail.com>
 <53040065-a88b-1b60-3430-27d2acd761b7@garloff.de>
In-Reply-To: <53040065-a88b-1b60-3430-27d2acd761b7@garloff.de>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Wed, 23 Feb 2022 12:49:30 -0500
Message-ID: <CAN-5tyHToHJKoqc38ybp9+DMVdUrapu+4u0i7YMpG86ZQFOw5w@mail.gmail.com>
Subject: Re: 6f283634 / 1976b2b3 breaks NFS (QNAP/Linux kNFSD)
To:     Kurt Garloff <kurt@garloff.de>
Cc:     "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Schumaker, Anna" <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Feb 23, 2022 at 12:31 PM Kurt Garloff <kurt@garloff.de> wrote:
>
> Hi Olga,
>
> thanks for coming back!
>
> On 23.02.22 15:22, Olga Kornievskaia wrote:
> > Hi Kurt,
> > I apologize for the late response. I have looked at the network trace.
> > The problem stems from the broken server that claims to support
> > fs_locations but then decides to never reply to the query.
> >
> > I can implement a mount option to say fs_locquery=off to handle mounts
> > against the broken servers?
> >

I have posted a patch where you can mount with "notrunkdiscovery" and
that should fix the problem with the Qnap server?

> > However I would like to ask if the better path forward isn't to update
> > to the knfsd where the problem is fixed?
>
> Well, I have ran self-compiled kernels on Qnap appliances before (to
> work around Qnap's ext4 breakage when doing the case-independent
> name lookup), but it was a painful and cumbersome process and I don't
> want to repeat it. Appliances are not meant to use with custom
> kernels.
> Even if I do: This does not help many many other users ... Unless we
> convince Qnap to provide patches for old appliances, we'll experience
> breakage.
>
> On my end, I have applied the attached patch, restricting the use
> of FS_LOCATIONS to servers that advertize NFS v4.2 or later.
>
> In the patch, you'll also see clearing the bit before it gets set.
> This was spotted by seth, see
> https://bbs.archlinux.org/viewtopic.php?pid=2023983#p2023983
> In latest upstream kernels you'd also need to clear
> NFS_CAP_CASE_PRESERVING | NFS_CAP_CASE_INSENSITIVE
> so I wonder whether we should not just nullify the caps
> bit field prior to testing and selectively setting flags.
>
> With this patch, I can mount NFS volumes from Qnap knfsd
> again without any special workarounds (such as nfsver=3 or the
> to-be-implemented setting that you suggest). I have no idea
> whether or not we leave a lot features behind by restricting
> FS_LOCATIONS on the client side to servers >= NFS v4.2.
> But certainly better than breaking in a -stable kernel update,
> even if the server might be to blame.
>
> Best,
>
> --
> Kurt Garloff <kurt@garloff.de>
> Cologne, Germany
