Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A19678D328
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Aug 2023 08:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239575AbjH3GLc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Aug 2023 02:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238336AbjH3GK7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Aug 2023 02:10:59 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41996CCB
        for <linux-nfs@vger.kernel.org>; Tue, 29 Aug 2023 23:10:56 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C03F93F65E
        for <linux-nfs@vger.kernel.org>; Wed, 30 Aug 2023 06:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1693375847;
        bh=RnIQo3VWGKo2jYdOWLsqgEFSEpzbuJCL+ZC0RfYr8WY=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=LoSRsC15t9vwwyuexMCeu5yFATQygoQZMIBGWsE4iskZbAGE16Md1ALaVzDNrSINj
         C0EBAKNrDS23OWZw+BKkLgInY/jWonzusg/danYo1Ivo5vEBRYT6DxWPNRUIszdKsC
         XDjZIjyrHiJjLez2cChMVqb40BttnaW7DLOoA8OvFh2Vi9DayXVRWK9gHriUh7eI9t
         4u0gMFQ5bdwhpsPbjAT/IOtsblWlSfk/VztBTNIFcIrxxPi45Abuq30WJCvjySylfq
         sjDtBAorQbimuoEwGK3apiKsskcZ+dBqlP+543BKVXDP9tWj7zvoTVktRen3o20q3L
         QEAczJDv5d//w==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-99df23d6926so377494566b.0
        for <linux-nfs@vger.kernel.org>; Tue, 29 Aug 2023 23:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693375779; x=1693980579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RnIQo3VWGKo2jYdOWLsqgEFSEpzbuJCL+ZC0RfYr8WY=;
        b=K+4LMtLTptf43Q2RVoCwt8jeUw4pOJdrZ56dSHaZ8PMSwV5aQxwSoANf82mgTG8jmF
         tOs2lHwsjvHx4hhQWRz4hRxv/WQqYHeUmcRRa6iX9xD3cO0SyIW6/n2a+kPX64jJg9JV
         hFMF8Rbtzj+FfwFAeZ4CJql44Jy1SwnIgSGhpRVCim3I6c1cmGRr4qmVVAItNN1WnLSe
         1zfjw3jZJLmXoL6LX7MqX3HgF+lPVwF4WPJQKaAbNJ7MVOqb5kC+fcbgVStEnWET18lT
         uqJEJM3g/0T+UKtJFFuYXhQVvyt+tQQWdt8FMf+4nOALjx9sLaqN3FgnoDr+X5tTdnto
         XB0Q==
X-Gm-Message-State: AOJu0YyZjyGVKxey20uqnum9oM8REzoy/FVvQADd2VR12729ZHqhiSPz
        qst29LllnGOSOxI9u6aLxEubkZge+j2In8fLXEm6+nCk9T0diB1nmZjLyEwv+RvVt98wVpC7CbC
        elS/7svZehGucwdb5NF5EHVySiv/4bAmJRzMI7yXCUe8tICgoNRXlSXtZEWoLgyLXYGQ=
X-Received: by 2002:a17:906:20e:b0:9a1:f6e0:12f4 with SMTP id 14-20020a170906020e00b009a1f6e012f4mr779896ejd.15.1693375202759;
        Tue, 29 Aug 2023 23:00:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8gKaL+YTHivPq1mxOTBt++hqwWULRhM6kPnw84P9cKjCmAliTJntlMQqIhVlZJxduCXn6AEPZik7LmYorxTo=
X-Received: by 2002:a17:906:20e:b0:9a1:f6e0:12f4 with SMTP id
 14-20020a170906020e00b009a1f6e012f4mr779878ejd.15.1693375202465; Tue, 29 Aug
 2023 23:00:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230828055310.21391-1-chengen.du@canonical.com>
 <CAPza5qe0NBWiKZ1yLyfdPGOsmM=VGqWMs=oWJqVzLRcd8AFyJQ@mail.gmail.com> <73E82F73-1621-4553-8019-2946EA573415@redhat.com>
In-Reply-To: <73E82F73-1621-4553-8019-2946EA573415@redhat.com>
From:   Chengen Du <chengen.du@canonical.com>
Date:   Wed, 30 Aug 2023 13:59:51 +0800
Message-ID: <CAPza5qeYvrn49Ow9TQ4WL=aO+5+p1SgP4dN3coRRX+hYxkgpzQ@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND] NFS: Add mount option 'fasc'
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     trond.myklebust@hammerspace.com, anna@kernel.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Benjamin,

I'd like to provide some context about the new behavior introduced by
the commit - 0eb43812c027 "NFS: Clear the file access cache upon
login."
This recent adoption has successfully resolved a long-standing issue.
The current outcome is that the file access cache gets cleared when a
user logs out and subsequently logs back in.

In specific scenarios, users might access NFS-mounted folders via a
'sudo'-like behavior, inadvertently adding to the NFS server's load
due to the inability to use the file cache efficiently.

To alleviate this performance overhead, my proposal centers on
reverting to the original behavior, where the file access cache
remains untouched upon user login.
This stems from the rationale that the cache should only be cleared
when the server's group membership changes after a user has already
logged in on the client.
This alteration rarely occurs in stable environments, thus rendering
the file access cache reliable.
With this in mind, my suggestion involves adding a mount option that
empowers administrators to dictate which NFS-mounted folders adhere to
the POSIX behavior - one that refreshes a user's supplementary group
information upon login.

The genesis of this patch places a premium on performance while also
maintaining alignment with the original behavior prior to the adoption
of the commit 0eb43812c027.
Transitioning to adhere strictly to the POSIX policy also carries merit.
I believe that further discussion can facilitate a consensus on this matter=
.

Thank you for lending your perspective to this discourse.

Best regards,
Chengen Du

On Tue, Aug 29, 2023 at 9:35=E2=80=AFPM Benjamin Coddington <bcodding@redha=
t.com> wrote:
>
> On 28 Aug 2023, at 3:14, Chengen Du wrote:
>
> > Hi,
> >
> > The performance issue has been brought to our attention by users
> > within the Ubuntu community.
> > However, it seems to be confined to specific user scenarios.
> > Canonical has taken proactive measures to tackle the problem by
> > implementing a temporary solution [1], which has effectively resolved
> > the issue at hand.
> > Nonetheless, our earnest desire is for a definitive resolution of the
> > performance concern at its source upstream.
> >
> > I've taken the initiative to send the patches addressing this matter.
> > Regrettably, as of now, I've yet to receive any response.
> > This situation leads me to consider the possibility of reservations or
> > deliberations surrounding this issue.
> > I am genuinely keen to gain insights and perspectives from the
> > upstream community.
> >
> > I kindly ask for your valuable input on this matter.
> > Your thoughts would significantly aid my progress and contribute to a
> > collective consensus.
>
> Hi Chengen Du,
>
> This patch changes the default behavior for everyone.  Instead of that,
> perhaps the new option should change the behavior.  That would reduce the
> change surface for all NFS users.
>
> The default behavior has already been hotly debated on this list and so I
> think changing the default would need to be accompanied by excellent
> reasons.
>
> Ben
>
