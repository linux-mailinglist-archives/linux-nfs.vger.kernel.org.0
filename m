Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7EF514381
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Apr 2022 09:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355322AbiD2H7X (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Apr 2022 03:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355298AbiD2H7W (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Apr 2022 03:59:22 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762DD4FC6D
        for <linux-nfs@vger.kernel.org>; Fri, 29 Apr 2022 00:56:01 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id e23so8103124eda.11
        for <linux-nfs@vger.kernel.org>; Fri, 29 Apr 2022 00:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eQULLIKpjE7NoY3COKX52N0M21TDJLjSZcyQhXw2gk0=;
        b=vTdHDNrFIwlrMk4WnusZ5INz223z+SPO3YXjbo0C5Oyb3DDtgoiFe+7G5yerDTOkFr
         0+depJyJ516ksrqtym5moobtRUCV/8zgLqplwtKXHkqvEHjp2z0KMn1ERBt3/u0lpjJl
         ODcYn4yVTUyqpcvJBnO31wh789reoJa4+GMmWZE53FLP/IbZCAGJLg53ohpNdf95zLdS
         Gje/oOSLas/vPifUwN6obwrWBA+fIBPtb+XRJYAx2R7vBFmuAsQxrcUJyzoBTuADyF1x
         Mm8bpnvj1m7R3gk7YEtyvmQ424eVSEiGjJwGLIHQlCXWPQT5H5SiTrUtDzGx7yuyaSH7
         u27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eQULLIKpjE7NoY3COKX52N0M21TDJLjSZcyQhXw2gk0=;
        b=v/dPNWNNN47aC+w47YIGwRAJeZbNEFAQbtpoetxhayTF9d5YCwocmA8ZLSOflQyMu/
         NPoUobmz4ZgFlk6e79nekg82eEdj7Y1FObXqPO3vgIsRvL1jfsVTyHCyUXdB2gd/87rj
         A+5EtTbn4DNCbjDubrjD6s11a4nzCvh4sO8tyh8jOr++v8Lv1fuDfKd1rSIbM1Ch7COl
         O1PfB91TIqgv51+5HFM/UrjW6Coa6JgVpwZ0T/WYzY3RBFqC+/O47274V1tA8cKxo7q8
         y7Q8phLU0f38RPV77VPGYYvWzrRCLc4dwKspB3/m6PgNvyw5kx2tOJFmQBtWAAAwKank
         p2JQ==
X-Gm-Message-State: AOAM5323DKEcVA7k9CGqBV+RuZbqN1PHQizZvcLZVMEtzB+/mr0HBnuD
        vsTtHuCACrJgyZ9+Sw/Q9w4dNyNiqlA32oBOxe1Ma6QiDK95Yg==
X-Google-Smtp-Source: ABdhPJxmxDTja63zmiJGPr9rgxauEBy5vZVT5w6EFL8XVgDB6tjOThU5gfnDhMUhsoteUYEz37tRG//rDdgYaRoWfF4=
X-Received: by 2002:a05:6402:510c:b0:424:2fe:62c4 with SMTP id
 m12-20020a056402510c00b0042402fe62c4mr40186438edd.293.1651218959966; Fri, 29
 Apr 2022 00:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220126025722.GD17638@fieldses.org> <CAPt2mGP2guMMf1C9VoQ0AvZ819jPuz0vDoEzJJhtL8q5DJ300A@mail.gmail.com>
 <CAPt2mGNXq==1KUskF3U6-CDeoX57=d7NW4Qn_esDqarf9bTBaw@mail.gmail.com>
 <20220211155949.GA4941@fieldses.org> <CAPt2mGOx0qNTWoY9vmyVBtZ3gxdbv5qQ-2qVbtqWW9FiZFRhEg@mail.gmail.com>
 <164517040900.10228.8956772146017892417@noble.neil.brown.name>
 <CAPt2mGMLQCEPqsYGeaMd3BPGRne4F4h-2-pzqm1a8nwfKqv1ug@mail.gmail.com>
 <CAPt2mGMt3Sq66qmPBeGYE0CASTTy7nY2K_LjQK6VZx-uz2P-wg@mail.gmail.com>
 <20220425132232.GA24825@fieldses.org> <CAPt2mGMtBH=jzK0cTT7+PTbX-iR-iSx1RmF2beCDxBjXY5sj8A@mail.gmail.com>
 <20220425160236.GB24825@fieldses.org> <CAPt2mGPR9c9=rh4p_D7RPo+4S=DgH7VNpqvOKryKsYwaCAtnJA@mail.gmail.com>
 <165093700757.1648.16863178337904278508@noble.neil.brown.name>
 <CAPt2mGPVWuut=ESWicSw0Ser2PGTeuyb+ACL41N6p_FAAuOUwg@mail.gmail.com> <165112480439.1648.3067400915036759878@noble.neil.brown.name>
In-Reply-To: <165112480439.1648.3067400915036759878@noble.neil.brown.name>
From:   Daire Byrne <daire@dneg.com>
Date:   Fri, 29 Apr 2022 08:55:24 +0100
Message-ID: <CAPt2mGP35TPH6KBk+NWL3HcAUAECdC7pnoWfYxYNY9bTeGyhdQ@mail.gmail.com>
Subject: Re: parallel file create rates (+high latency)
To:     NeilBrown <neilb@suse.de>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Patrick Goetz <pgoetz@math.utexas.edu>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 28 Apr 2022 at 06:46, NeilBrown <neilb@suse.de> wrote:
>
> On Tue, 26 Apr 2022, Daire Byrne wrote:
> > On Tue, 26 Apr 2022 at 02:36, NeilBrown <neilb@suse.de> wrote:
> > >
> > > On Tue, 26 Apr 2022, Daire Byrne wrote:
> > > >
> > > > I'll stare at fs/nfsd/vfs.c for a bit but I probably lack the
> > > > expertise to make it work.
> > >
> > > Staring at code is good for the soul ....  but I'll try to schedule time
> > > to work on this patch again - make it work from nfsd and also make it
> > > handle rename.
> >
> > Yea, I stared at it for quite a while this morning and no amount of
> > coffee was going to help me figure out how best to proceed.
>
> yes, it isn't at all straight forward - is it?
> We probably need quite a bit of surgery in nfsd/vfs.c to make it more
> similar to fs/namei.c.  In particularly we will need to use
> filename_create() instead of lookup_one_len().
>
> There is a potential cost to doing this though.  The NFS protocol allows
> the server to report the change-id of the directory before and after a
> create/unlink operation so that the client can determine if it is the
> only one making changes to the directory, and so can keep its cache.
> This requires the pre/post to be atomic - which requires an exclusive
> lock.
> If we change nfsd to use a shared lock on the directory, then it cannot
> report atomic pre/post attributes, so the client will have to flush its
> cache more often.
>
> Support parallel creates and atomic attributes we would need to enhance
> the filesystem interface so the fs can report the attributes for each
> create.   Could get messy.
>
> This doesn't actually matter for NFS re-export because it doesn't
> support atomic attributes anyway.  It also doesn't matter if multiple
> clients are changing tghe one directory.  But I think we do want to keep atomic
> attributes for exporting other filesystems in other use-cases.
>
> It's starting to get messy.  Not impossible, just messy.  Messy takes
> longer :-)

Thanks for looking Neil. I don't feel quite so dumb admitting that it
was way above my level! :)

Like I said, this isn't a blocker for us but definitely a nice to have
feature. Slow progress is still good progress.

Cheers,

Daire
