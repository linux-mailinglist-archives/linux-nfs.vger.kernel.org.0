Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06716FD3D6
	for <lists+linux-nfs@lfdr.de>; Wed, 10 May 2023 04:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbjEJC1P (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 May 2023 22:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235081AbjEJC1O (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 May 2023 22:27:14 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A37270D
        for <linux-nfs@vger.kernel.org>; Tue,  9 May 2023 19:27:13 -0700 (PDT)
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 63D9C3F202
        for <linux-nfs@vger.kernel.org>; Wed, 10 May 2023 02:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1683685631;
        bh=y5bI/misqR+WRX+BTmIKcOem6MQLYfoxEtgDnZLbuN4=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=c2OVFq1nZW2y3JfBbQ2JaHtAQXVn/cxTbueAZvzVysGPFcECOLY/G20lVwxUOvwSW
         Jd6qUQE6gJTuf/D7XKJwY2iJwsvck7+XqF6btLH7nAOUQIAzTJAJKKPs6Vbf2qIDl5
         9Er3JPzTL3SZaiYUlZq0IxPj1wCY245Zo1T2CIjxB9CRsGmWvvmj9HBck92W18xPDm
         e9Eh2cH5v/4UrllHoulo2f0jUggF8MGHS5LWqcrduRaZEJAFIWX5+fDGIvJ3qTPcFn
         hZaMS+0JO50RsjuLgwjPRZi5pjtJqkgq5Gym2YajFY5bPhUUpribI3jzPGb0JowXHl
         5S//ewfTYzYQg==
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-559ffd15df9so109065527b3.3
        for <linux-nfs@vger.kernel.org>; Tue, 09 May 2023 19:27:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683685630; x=1686277630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y5bI/misqR+WRX+BTmIKcOem6MQLYfoxEtgDnZLbuN4=;
        b=aPaCPvHVUmlnb7V7/NenCeO/KFP9vd4zUy83Fr0zVlGEtjSFFP82T5Xjsox6Hfx4Wx
         lPrlszHFwh2GC5OhXczax+qzOwcx8NGW+VOBRI3uolaYpUpxWDNy35D//tz51LzyOe+X
         1AztPqbS5jpqwkaVeA+qP5Wfw8hHczLsrhEM63m0Lnk4KzEhRbMtIz50Qw/klXcBcqeS
         rWiSa1paiSeICyv7lEJjdQvURmEqzeyBDBoVbJa6CylXMjBiNdq3prgkENINpgHe2+Wk
         VyhCrLDRf0PoN5FEuMVsftdHhZx4vUxaCpSajApP6MNGbmbfDIEDyg9wT5VbA7MXepN5
         x2iA==
X-Gm-Message-State: AC+VfDxfl8efMOOwjuHIOCsbv6qQRtQDy0BgK15euvaL8bX1uy6RSCml
        8k1TrUPJA092tTDIMSqTWxYkahlKBT4G5Neide4TJGtwmMLhFb57mqyADl71MfndqIjB7hhnyr8
        cM7JlydXAEIE9UrsR7cmr75iWxvcONaOFepkLj7qEhjaBVpwtAQ06Tg==
X-Received: by 2002:a81:4e0f:0:b0:559:e5e2:756d with SMTP id c15-20020a814e0f000000b00559e5e2756dmr17891972ywb.48.1683685630135;
        Tue, 09 May 2023 19:27:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ysxRGbPhh3hrAKvBnznvLCCCVJ3uzuJ1Yg5X6PBUfHMt+OMWxwnH1VViUQJuzIcznMT0IPRJI04nfd6Dbn5E=
X-Received: by 2002:a81:4e0f:0:b0:559:e5e2:756d with SMTP id
 c15-20020a814e0f000000b00559e5e2756dmr17891964ywb.48.1683685629916; Tue, 09
 May 2023 19:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230411030248.53356-1-chengen.du@canonical.com>
 <CAPt2mGNqqDeRMeCSVh6oX_=nS0UcGCfhBfVcuaVG9HpdwVSzVg@mail.gmail.com>
 <CAPza5qee7vHKwjwhS27xB8xXTgAFHEmv7eiFk6zGTUUc4s8=TQ@mail.gmail.com> <B9E03B97-F67C-48FC-B5EE-5B02E288C227@redhat.com>
In-Reply-To: <B9E03B97-F67C-48FC-B5EE-5B02E288C227@redhat.com>
From:   Chengen Du <chengen.du@canonical.com>
Date:   Wed, 10 May 2023 10:26:59 +0800
Message-ID: <CAPza5qeTqYfnpDa+h+d_nGTz4xh=aiFZZJuH81ZaTA0-t1iqpw@mail.gmail.com>
Subject: Re: [PATCH] NFS: Add mount option 'nofasc'
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     trond.myklebust@hammerspace.com, anna@kernel.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Benjamin,

Thank you so much for your valuable advice.
I truly appreciate your input and it has been very helpful for me.

In my humble opinion, users should base their decision on the remote
target they use to mount.
If the remote target has stable group membership or if they have
performance concerns,
they can consider skipping the clearing of the file access cache.
In order to avoid affecting current behavior, I will also change the
default to not clear the file access cache.

I understand that my choice may not be the best, but I will try to
propose the mount option first.
After I modify the man page description, I will resend the patches and
discuss with the upstream.

Once again, I really appreciate your help and guidance.

Best regards,
Chengen Du

On Tue, May 9, 2023 at 11:16=E2=80=AFPM Benjamin Coddington <bcodding@redha=
t.com> wrote:
>
> On 24 Apr 2023, at 21:41, Chengen Du wrote:
>
> > Hi,
> >
> > May I ask if there are any concerns or opinions regarding the
> > introduction of the new mount option?
> > If there is a more suitable solution, we can discuss it, and I can
> > work on implementing it.
>
> I suspect there's some weariness of mount options, we have a lot of them =
and
> they are not easily removed once implemented.  Additionally, requests to =
add
> them usually can show the appropriate changes to the nfs-utils mount.nfs =
and
> man pages required.  Incompleteness here may be the reason you're not
> hearing back from a maintainer.
>
> However, without guidance from a maintainer, you might end up doing extra
> work trying to meet unclear standards.
>
> There's a couple of other ways to address the access cache performance
> "degradation" that was introduced by the changes that other folks
> desperately needed for correctness.
>
> We can change nfs_access_login_time to have a module parameter modifying
> the behavior.  The downside is this would affect every mount.
>
> We can grow a sysfs knob to change the behavior.  Downside is we only hav=
e
> very preliminary sysfs scaffolding as of yet.
>
> However, if you want to keep pushing for the mount option, I'd suggest do=
ing
> a v2 with the userspace patches, and if that gets ignored then do a "PATC=
H
> RESEND" on that a month or so before each mainline merge window.
>
> I've found that bump-replying to old patches isn't as effective at gettin=
g
> work merged here.  I believe the maintainers want to see that you're
> rebasing as mainline progresses, and you have active ownership over the w=
ork
> to fix bugs that may follow or address other fallout from the community.
>
> Ben
>
