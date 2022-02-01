Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDA04A5E6D
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Feb 2022 15:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239405AbiBAOii (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Feb 2022 09:38:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:47909 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239419AbiBAOih (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Feb 2022 09:38:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643726317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yP1bs/cD6ul5vF2aW3mHYFKWpId1PYYPSFAUCUmS+ys=;
        b=TM532U95K5++PgKb8ATxqaKsuN1Q6+ArioWfyqWLPjbW2I9x3htxO8TY9Epe+knGzsy0kI
        J5aTnrYYdTSOlvnJJDZaC00AnH/X5hJbLG/vLj8oCjOIp3m+KNyGTXbgLh8gb6tId82dJz
        OHVRMfe/6WPypfO+jMaxCdmqNHnI8q0=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-93-k-Ml-GbqNr25_YJRslvrQw-1; Tue, 01 Feb 2022 09:38:34 -0500
X-MC-Unique: k-Ml-GbqNr25_YJRslvrQw-1
Received: by mail-yb1-f199.google.com with SMTP id g67-20020a25db46000000b0061437d5e4b3so32932917ybf.10
        for <linux-nfs@vger.kernel.org>; Tue, 01 Feb 2022 06:38:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yP1bs/cD6ul5vF2aW3mHYFKWpId1PYYPSFAUCUmS+ys=;
        b=mE9Ko2Q7lRpOpriPF813CO9cc0QwgnIRJPDn1C/Sk1dsd7jSO+58uCt3xlFYU9pFeS
         QuxucToUyxyg647XVqucJqGbnQPZkiytYl5VkD/7ouBhFGgH1yOO6BX4bkp5gX9hAzAo
         WP/BmGp9QUs5lZipNA8Vj4X09WlP5vy9YM2NcO6R1d/SfxsiOu4HHI/GtM0YbmJ9Ozjg
         sIz/sYEgurfAcwoWr841jQUSmEIel/ggLbDhlRf0GFxiqLG5zJhXH6iacM2bXI1TVfEm
         zxSNPmizOHdnlzXgA7Pdrt1UbQAVqA6NLu/tFOGFGAHVdADKIbjll4YVf/Itw61xV9n5
         PP7g==
X-Gm-Message-State: AOAM5312TA2Tu1aSJxdgmrJGM+rn6Up+dp9lpP/V/eOq3MzCSbqQbpFd
        u4Wb4Oim26iKgSbze0+VuPcr07LUiQkw7o0UhZP50zzxo2wkiYAE+IE+3OXaJiyyO4inh1/WcQN
        QAArV6MgB6fvGSZg7oxOhz5EfZvn7CrG0+Qis
X-Received: by 2002:a25:7382:: with SMTP id o124mr34766808ybc.318.1643726313973;
        Tue, 01 Feb 2022 06:38:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzxAXD5P65F6JW0OiYGwB7dqy0nRCCl4tn2Upv5lN7vsS5B73WmEMitmQBqmvRWfJpdSzuWlZrc30QHIx/QgY4=
X-Received: by 2002:a25:7382:: with SMTP id o124mr34766786ybc.318.1643726313750;
 Tue, 01 Feb 2022 06:38:33 -0800 (PST)
MIME-Version: 1.0
References: <20220120214948.3637895-1-smayhew@redhat.com> <20220120214948.3637895-2-smayhew@redhat.com>
 <CAFqZXNv7=ROfyzZGojy2DQvY0xp4Dd5oHW_0KG6BLiD7A8zeKQ@mail.gmail.com>
 <CAHC9VhQKVdbLNn=eOqebWaktDVeq5bjTjXea68MmcAhKoSa09w@mail.gmail.com>
 <CAFqZXNvny0zJmEMzFeMFuy0DzjAAaB5uqRpQoSMbZwVcUxTDAQ@mail.gmail.com> <CAHC9VhQE4JPhTjkKwV3ovRSuPceiHDrP3MDW4RPDcNtLkb7tAQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQE4JPhTjkKwV3ovRSuPceiHDrP3MDW4RPDcNtLkb7tAQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 1 Feb 2022 15:38:16 +0100
Message-ID: <CAFqZXNs7P+p0B-uZ2owMH1qa04unbq870tMqQ4Kwup7dXJ9z=g@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/2] selinux: Fix selinux_sb_mnt_opts_compat()
To:     Paul Moore <paul@paul-moore.com>
Cc:     Scott Mayhew <smayhew@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jan 31, 2022 at 5:16 PM Paul Moore <paul@paul-moore.com> wrote:
> On Mon, Jan 31, 2022 at 7:46 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > On Fri, Jan 28, 2022 at 3:28 AM Paul Moore <paul@paul-moore.com> wrote:
> > > On Thu, Jan 27, 2022 at 4:54 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > I wonder if we could make this all much simpler by *always* doing the
> > > > label parsing in selinux_add_opt() and just returning an error when
> > > > !selinux_initialized(&selinux_state). Before the new mount API, mount
> > > > options were always passed directly to the mount(2) syscall, so it
> > > > wasn't possible to pass any SELinux mount options before the SELinux
> > > > policy was loaded. I don't see why we need to jump through hoops here
> > > > just to support this pseudo-feature of stashing an unparsed label into
> > > > an fs_context before policy is loaded... Userspace should never need
> > > > to do that.
> > >
> > > I could agree with that, although part of my mind is a little nervous
> > > about the "userspace should *never* ..." because that always seems to
> > > bite us.  Although I'm struggling to think of a case where userspace
> > > would need to set explicit SELinux mount options without having a
> > > policy loaded.
> >
> > I get that, but IMO this is enough of an odd "use case" that I
> > wouldn't worry too much ...
>
> I understand, but seeing as I'm the only one that defends these things
> with Linus and others lets do this:

It's not all black and white:
https://lore.kernel.org/lkml/Pine.LNX.4.64.0512291322560.3298@g5.osdl.org/

> 1. Fix what we have now using Scott's patches once he incorporates the feedback.
> 2. Merge another patch (separate patch(set) please!) which does the
> parsing in selinux_add_opt().
>
> ... this was if we have to revert #2 we still have the fixes in #1.

Sounds good to me. I can prepare the simplification patch. If anyone
does come to complain, then by all means, let's revert it.

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

