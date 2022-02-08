Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455734AE381
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Feb 2022 23:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385679AbiBHWW4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Feb 2022 17:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386388AbiBHUU7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Feb 2022 15:20:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE501C0613CB;
        Tue,  8 Feb 2022 12:20:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3AFF1B81D96;
        Tue,  8 Feb 2022 20:20:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E055AC004E1;
        Tue,  8 Feb 2022 20:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644351655;
        bh=Vhtge7hojtmGGF81piLOUYoshwDSD3PcrRHLoVd8ChY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ouM3q7IpGBRfIIkj26ZJaqT1Vv+qJC5irFIminsk2HYqRDEtMCrjnV4LS/5DNIrXt
         L/jgQfDyeFW+k97NTbtWRpnLDYBV5aN6Ivdgm84KzXGuXQWMjpxdZeXW1sZ6mrYM/T
         GuU8o7Na+YZxxCtNRlZMKN5BfKiM2UsDPI7ORfu4FeR1nayfG/9GwqMEl44vu41MHe
         t4jPgt0uIevWqZVY4tE1TUeFagxXLJ3i3GVY3rx+ZW3M+CyWRVG/uQExydAGAisoch
         S2nsqGbdnsy098E4xH/N7QpZ2FovV1GOwMOBT0tjbXuN8lUWuYjWKe4ciVn2OWuFsC
         e9C1u6XyTAMpQ==
Received: by mail-wm1-f41.google.com with SMTP id y6-20020a7bc186000000b0037bdc5a531eso1382915wmi.0;
        Tue, 08 Feb 2022 12:20:55 -0800 (PST)
X-Gm-Message-State: AOAM532F1t725c7tOE02mR1j9m2Gh/Fz3432Tkk6+9Qbk3+B8SvyFXou
        4lxLpZR/gjAN+xS/+9duESj4cxpqIlAuwytlBzk=
X-Google-Smtp-Source: ABdhPJwLIUg4euQ7vbczUVQ/hY1bQdVcNhbIv4x5leu70o7Ug5GAOttqCPqNgvpmrRDxSdb6ZTUKtzLNr+c0VWHOBM0=
X-Received: by 2002:a05:600c:1f0b:: with SMTP id bd11mr2484770wmb.82.1644351654529;
 Tue, 08 Feb 2022 12:20:54 -0800 (PST)
MIME-Version: 1.0
References: <20220208194800.482704-1-anna@kernel.org> <CAHk-=whxJC==PiWer8UJTOGhQBSKWzY6f78qkaUvfK-5e9H-Yw@mail.gmail.com>
In-Reply-To: <CAHk-=whxJC==PiWer8UJTOGhQBSKWzY6f78qkaUvfK-5e9H-Yw@mail.gmail.com>
From:   Anna Schumaker <anna@kernel.org>
Date:   Tue, 8 Feb 2022 15:20:38 -0500
X-Gmail-Original-Message-ID: <CAFX2JfmQFR3G3xtieHNK56_Auy0yt8Vbg=x-JEWM4WCfh=txUg@mail.gmail.com>
Message-ID: <CAFX2JfmQFR3G3xtieHNK56_Auy0yt8Vbg=x-JEWM4WCfh=txUg@mail.gmail.com>
Subject: Re: [GIT PULL] Please Pull NFS Client Bugfixes for Linux v5.17-rc
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Feb 8, 2022 at 3:13 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Feb 8, 2022 at 11:48 AM <anna@kernel.org> wrote:
> >
> >   git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-5.17-2
>
> Thanks, pulled.
>
> And this email setup works well and has proper dkim and so hopefully
> won't have the spam issue that your previous one had.

Good to hear!

>
> But can I please ask you to actually put your whole name in the
> "From:" field, not just "anna@kernel.org"? As is, it just looked a bit
> like spam in my (non-spam) inbox because I don't see your real name in
> the mail index..
>
> I suspect that's mainly a git-send-email config thing, or whatever you
> ended up sending this.

Yeah, I did end up using git-send-email for this instead of
copying-and-pasting into Gmail. I'll fix that up!

Anna

>
>                 Linus
