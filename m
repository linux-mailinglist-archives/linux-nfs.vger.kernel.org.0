Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD64775B900
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jul 2023 22:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjGTU4Z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jul 2023 16:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjGTU4Y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Jul 2023 16:56:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E647E1999
        for <linux-nfs@vger.kernel.org>; Thu, 20 Jul 2023 13:56:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79FDE61BBD
        for <linux-nfs@vger.kernel.org>; Thu, 20 Jul 2023 20:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C47C433C8
        for <linux-nfs@vger.kernel.org>; Thu, 20 Jul 2023 20:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689886582;
        bh=sYaN5iU1O9Qq9d0sWY6sNPBgeCTfRBwFJAEzCDd5OCE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KStJnafvWnPlA1gkMeKMxsY5stRhlKbsRDCfcv0UUdJ1QMWa1v+Z9WC2AIjBrpGGJ
         nVJh48FHaueOMlpfoz0aGYJPoiBSH9UkdKbUlybactqYmZdWHLjp6LmS+J3JevtlLw
         Ft7Ct+OR64DGF579E5XqWshq+u1NmbUNlUNpCy4/+Ca9ogGNx3+NRuFkbI53kXMpWe
         7j4XIuTvtNzKNChUu2QJXAGsbknmSiApBw3Om68xKnV7mJ0wXWdnyj7x28wEdpLZkO
         iQ1v3RbtQsogHqnhzuXWkxD8Fss1tdlZy8PVDlUxK10dWjN8S5EaZU2cDBasHA7tDu
         eS5brULUAM4uA==
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-40398ccdaeeso9433721cf.3
        for <linux-nfs@vger.kernel.org>; Thu, 20 Jul 2023 13:56:22 -0700 (PDT)
X-Gm-Message-State: ABy/qLZkbTnKkOlQUOCPRT5QMhCPntKp1WSVvSmWAlKL8sdX9SiD0mqc
        LgRdSs1e1r5WMxtihkq9UOCq3tYXlnIwM/okpcA=
X-Google-Smtp-Source: APBJJlHWFOOairb+PwVnyJ329Zo1f57/GgpXPgN3htI1FJSj8FeYBiqoGqRujZLcoudjRCIZoaGSJL3xBfpBV+SDNnQ=
X-Received: by 2002:ac8:5c01:0:b0:400:8d99:48db with SMTP id
 i1-20020ac85c01000000b004008d9948dbmr233414qti.41.1689886581899; Thu, 20 Jul
 2023 13:56:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAB6yy374gQmrAjtLmFWGDVq9GBfxFoA-L95oELo=k+W9TF7cyg@mail.gmail.com>
 <ECE48590-218F-4304-A043-B9AEB04CD3DA@redhat.com> <6901cae4-a257-62dd-64fa-b4f201fc1b07@gmail.com>
In-Reply-To: <6901cae4-a257-62dd-64fa-b4f201fc1b07@gmail.com>
From:   Anna Schumaker <anna@kernel.org>
Date:   Thu, 20 Jul 2023 16:56:06 -0400
X-Gmail-Original-Message-ID: <CAFX2Jf=yNj-UPrbQWnZvz_SuggAYXdNUeAmDsV=rEkBtawkxGw@mail.gmail.com>
Message-ID: <CAFX2Jf=yNj-UPrbQWnZvz_SuggAYXdNUeAmDsV=rEkBtawkxGw@mail.gmail.com>
Subject: Re: [PATCH v2] nfs: fix redundant readdir request after get eof
To:     Kinglong Mee <kinglongmee@gmail.com>
Cc:     Benjamin Coddington <bcodding@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jul 19, 2023 at 9:14=E2=80=AFPM Kinglong Mee <kinglongmee@gmail.com=
> wrote:
>
>
>
> On 2023/7/19 9:24 PM, Benjamin Coddington wrote:
> > On 18 Jul 2023, at 8:44, Kinglong Mee wrote:
> >
> >> When a directory contains 17 files (except . and ..), nfs client sends
> >> a redundant readdir request after get eof.
> >>
> >> A simple reproduce,
> >> At NFS server, create a directory with 17 files under exported directo=
ry.
> >>  # mkdir test
> >>  # cd test
> >>  # for i in {0..16}  ; do touch $i; done
> >>
> >> At NFS client, no matter mounting through nfsv3 or nfsv4,
> >> does ls (or ll) at the created test directory.
> >>
> >> A tshark output likes following (for nfsv4),
> >>
> >>  # tshark -i eth0 tcp port 2049 -Tfields -e ip.src -e ip.dst -e nfs -e
> >> nfs.cookie4
> >>
> >> srcip   dstip   SEQUENCE, PUTFH, READDIR        0
> >> dstip   srcip   SEQUENCE PUTFH READDIR
> >> 909539109313539306,2108391201987888856,2305312124304486544,25663354524=
63141496,2978225129081509984,4263037479923412583,4304697173036510679,466670=
3455469210097,4759208201298769007,4776701232145978803,5338408478512081262,5=
949498658935544804,5971526429894832903,6294060338267709855,6528840566229532=
529,8600463293536422524,9223372036854775807
> >> srcip   dstip
> >> srcip   dstip   SEQUENCE, PUTFH, READDIR        9223372036854775807
> >> dstip   srcip   SEQUENCE PUTFH READDIR
> >>
> >> The READDIR with cookie 9223372036854775807(0x7FFFFFFFFFFFFFFF) is
> >> redundant.
> >>
> >> Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
> >
> > Weird, I never got a copy from linux-nfs.   The plain-text version of t=
his
> > is whitespace damaged, but the HTML version looks right.
> >
> > Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
>
> Anna,
>
> Sometimes my email client cannot send email correctly,
> so I send this path at web gmail.

Ah, I bet that's why `b4 shazam` is having trouble finding the patch
if I go to apply it.

>
> Are you OK for this HTML version?
> If not, I will resend it through my email client.

What email client are you using? I've had good luck using
Documentation/process/email-clients.rst for setting up clients to send
and receive patches.  Have you tried using `git send-email` at all? It
would be great if you can repost a plain-text version instead of html.

Thanks,
Anna
>
> thanks,
> Kinglong Mee
