Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C03B6987C2
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Feb 2023 23:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjBOWXH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Feb 2023 17:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjBOWXE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Feb 2023 17:23:04 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3D443935
        for <linux-nfs@vger.kernel.org>; Wed, 15 Feb 2023 14:23:03 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 7so88799pga.1
        for <linux-nfs@vger.kernel.org>; Wed, 15 Feb 2023 14:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1676499782;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9G5vl3Y9jdPWD98mqfxeMO54mJhLhMeKkOPVrCY2Z28=;
        b=h+YrteV4nzYBjjMB0BerUhzA7L2JD/qxMPlVv6rls5rmukftozNnDwN2uMf4OaG4fA
         YX9fyYzdkFeTPv7FsQJL0SNjOXjvbpEWQik6jd7cLzQzHdsyAYUzhvpDO3bAJ2cvL1MQ
         pGHSrwXXlp385V/QZhWAQGw8LtLbAmKGlVAzdW/Q3U5FxAJFgPIoB9N2xAoARNm942g+
         CXHXTIMc1qCK3Xc49mkXa7aEHfIqrZY4hH1N1kL+ZVP0p7F20gZn/vnwgRHPYo7YILL2
         cLRmjb9ohuDG8FXTPa6C+9E/0dAZ+vle/p2QCyhPU1JSxeMMOpOPzdR+1hh9GIhUj7Ef
         202w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676499782;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9G5vl3Y9jdPWD98mqfxeMO54mJhLhMeKkOPVrCY2Z28=;
        b=GtDnT/o8azo7VAeHXuy18LPDlicOMYyVrvLOuy3bHfBZ3uaj25/Tv/UXFF5jpgW1xW
         rwpe8Ji7iEG8S2fSkubvqM7VU5QCOf73IGdBfMoVNXpV+fz/7t0+7qCYSA4CuytVVmvB
         1kjDbrZ/UN+hYgGkKcDyN2rJbkg/YMHEjH4IDz4LnOPOjbTrcRiHU9DcnKfx71uFfrE3
         bbVVoehRQhyVIPZJuMCmHReHJ9o6brfyImVqJgbmvSVAMJXwkxbgjlhIu8lKRATVVG32
         k8cUo6JubDTZ4RZkA6ibuZUO4r+F2zPBJWVdw938OefZ1EJ88QyDt/Zn+1R6wKCu8eJQ
         0zsA==
X-Gm-Message-State: AO0yUKVx/wsu83PFMZMhNxg4DMQ9sV4n9mb5vYXuRH3o8J4QPaszB8jo
        HR9TPjWAAC3QYV7YVisigAjALSCmEIFqVDWwf9Yv69Dc6WI8
X-Google-Smtp-Source: AK7set+uKYQwEs+fnLTwrSPrhl60CbZz/wQYX+TtYaNdhLiyELg8Bj34FkXkO7kjpdjTvidnpfVtlrwkxw/qJCw8Jtg=
X-Received: by 2002:aa7:979b:0:b0:5a8:a9f1:48f with SMTP id
 o27-20020aa7979b000000b005a8a9f1048fmr605854pfp.21.1676499782617; Wed, 15 Feb
 2023 14:23:02 -0800 (PST)
MIME-Version: 1.0
References: <398eee20-8e08-6ccc-0b2f-4596fc996fd6@redhat.com>
In-Reply-To: <398eee20-8e08-6ccc-0b2f-4596fc996fd6@redhat.com>
From:   Rick Macklem <rick.macklem@gmail.com>
Date:   Wed, 15 Feb 2023 14:22:48 -0800
Message-ID: <CAM5tNy4Z0Es0iZJSTEarm6MrEjKyC93px51PmkUXiq4Tfpfbxw@mail.gmail.com>
Subject: Re: Spring Virtual Bakeathon
To:     Steve Dickson <steved@redhat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>,
        NFSv4 <nfsv4@ietf.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Feb 15, 2023 at 8:50 AM Steve Dickson <steved@redhat.com> wrote:
>
> CAUTION: This email originated from outside of the University of Guelph. Do not click links or open attachments unless you recognize the sender and know the content is safe. If in doubt, forward suspicious emails to IThelp@uoguelph.ca
>
>
> Hello All,
>
> Red Hat is considering hosting a spring bakeathon,
> virtually (since a lot of us don't have travel budgets,
> including Red Hat).
>
> But before we build the network, I wanted to take the
> pulse of the community.... Do people still find these
> events useful? Is it worth people's time? I say YES
> to both those questions... but that is just me :-)
>
I say yes as well.  I actually have code that does the
NFSv4.1/4.2 mount using SP4_NONE/AUTH_SYS for
machine credentials, but the users provide Kerberos
credential for user authentication.  (I mentioned this
in an email thread on nfsv4@ietf.org.)
Anyhow, I would like to be able to test it against other
NFSv4.1/4.2 servers than Linux and FreeBSD.

> I would also like to attract new participants,
> hopefully some cloud vendors would be good,
> but any type of new attendance would be good too!
> We'll be more that willing to tailor the event
> to help make that happen.
>
Definitely agree. Unfortunately I don't have any contacts,
but a few candidates might be...
- Amazon's EFS server
- Microsoft's client in Windows server
- VMware's ESXi client

> So if anybody has contacts in those areas and are
> willing to share, please let me know... I will do
> the leg work.
>
> We were thinking the last week in March (27 -31).
> But being virtual... that is an open date.
>
These dates sound fine to me, although I am
pretty wide open for any other dates as well.

> So please let me know, on list or off list.
>
Thanks for doing this, rick

> Again just tying to see if is  still a pulse for
> these types of events.. I hope so  because
> Red Hat is more that willing to host them!!
>
> Also any likely new participants... please
> send them my way.
>
> steved.
>
> --
> You received this message because you are subscribed to the Google Groups "winter-2021-bakeathon" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to winter-2021-bakeathon+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/winter-2021-bakeathon/398eee20-8e08-6ccc-0b2f-4596fc996fd6%40redhat.com.
> For more options, visit https://groups.google.com/d/optout.
