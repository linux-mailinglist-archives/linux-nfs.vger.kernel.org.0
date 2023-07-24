Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE1F75F7FF
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jul 2023 15:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjGXNN7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jul 2023 09:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjGXNN6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Jul 2023 09:13:58 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B883EDD
        for <linux-nfs@vger.kernel.org>; Mon, 24 Jul 2023 06:13:56 -0700 (PDT)
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CC5A63F42A
        for <linux-nfs@vger.kernel.org>; Mon, 24 Jul 2023 13:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1690204433;
        bh=5M/FbnS8MO3XQXGTUoAgzNgAnRdhNlOeSW+olbzvlEU=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=iPOps527wx0j/xGgj2nO58ZQNASQIbyFLMp+ZKHLgjsUOXDNAVybwvelFLj4UH59N
         qrijsI2boOVfbn6EMDFxnE0r7I2kT2PL2Z24w5WdOp1PeTQ21/WfVyg1RQaGxbBWJN
         AFFsQtxq12OqojNckdbkjbwIwDknm+6nqalrv1rUA8UWQCaWVm6BoMm7O7GA91Yr3S
         wiv4fiCgV9qqIV1Yzv+tF1QvlQzbNncXcV9oVhBSxeZv6zNCofk1D9XdtuYB4fIHzB
         W3b+TcT9fCRSGPGv/n7FdHYShZ5BKA9J7ufUGQY6EBLhZrvhc1DMRw/4hF55uB2/H4
         xZtSOxP082fVg==
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-58378ae25bfso55043127b3.0
        for <linux-nfs@vger.kernel.org>; Mon, 24 Jul 2023 06:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690204433; x=1690809233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5M/FbnS8MO3XQXGTUoAgzNgAnRdhNlOeSW+olbzvlEU=;
        b=cUxx8/PmgdKp2mle5yGQr+viNcyeABBKSlIXRWq9A1hA26w9vVgcanX127NeCuyQG2
         lpD0hmpKiRA4RwKhm7OT2K2b545SsozEzdVcnsqEvjK7OTGVbxe3GOKJcZFr1yESypq+
         oj+mNJH5OnRZmN/aUYIs3mk6HWIFFab1HdLbxqZsexAb48zs8yM3SBVB4uN/iqFF/fCe
         hDodZCc1T+i1nnDHNCFLkP03mg9sY6RtdlKM6KJMlU+YBuOxYmqSUsuM/GaD92SHNQ7Y
         aqsb9u4bvk+lIrWO6t/16keNUUX1D5gKd17biSsuA7UVEKy5VNG5U6XprMvDnzSIjtw4
         a9SQ==
X-Gm-Message-State: ABy/qLZzgY1yHvk6zqcSusnc6ih4WKdEs3+QvDaxnUUnZDsRTTsNDJdU
        SI0dRKejnv5wdqM7siiVPcsIQrgHaziGNZBi+F2LxK7dr9IiKvMD2tTiWz/qSaE/EaTFMAMpMV3
        r4UtZBakZLj9gvUtMkZ3U2cRDgAM1bvEgYl2Jr4wjfkdNFrYKXsRZgw==
X-Received: by 2002:a81:6643:0:b0:583:5b22:856f with SMTP id a64-20020a816643000000b005835b22856fmr9750826ywc.50.1690204432899;
        Mon, 24 Jul 2023 06:13:52 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEcmr8pBqLAHuz0Lb6IRJb6iC8r+rMguY1582ikadGYOJJrexesvWAUk2IKSZmUEsFk/newAj9Mjbipr1Lxb+o=
X-Received: by 2002:a81:6643:0:b0:583:5b22:856f with SMTP id
 a64-20020a816643000000b005835b22856fmr9750806ywc.50.1690204432628; Mon, 24
 Jul 2023 06:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <CANYNYEFSdBua3Ay6jGk2cacossVJ8_CzDgDBnFCjXfk5XSoGEQ@mail.gmail.com>
 <EE39279C-4E40-48C8-ABC9-707EB1AD6D79@redhat.com> <7bfafe56-0c13-a32d-093b-4d3684c4f2c7@redhat.com>
 <CANYNYEEA1CHwvZhrr2W0-BcGR1Rm50QSTdHwb0pygz4z0ZY=uQ@mail.gmail.com>
 <ZKpkDG2kTWVFSNiZ@eldamar.lan> <A172CCB3-973D-4A26-A8AF-3D654F4D444F@redhat.com>
 <ZL5AfARR1rrlPEdz@eldamar.lan>
In-Reply-To: <ZL5AfARR1rrlPEdz@eldamar.lan>
From:   Andreas Hasenack <andreas@canonical.com>
Date:   Mon, 24 Jul 2023 10:13:41 -0300
Message-ID: <CANYNYEF6oWx9g-qozxGsKzL2KTK0P_ZLGc7UBKDh8PU=7_GTUQ@mail.gmail.com>
Subject: Re: Always run rpc-pipefs-generator generator (was: Re: Why keep
 var-lib-nfs-rpc_pipefs.mount around?)
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     Benjamin Coddington <bcodding@redhat.com>,
        Steve Dickson <steved@redhat.com>,
        Scott Mayhew <smayhew@redhat.com>,
        Ben Hutchings <benh@debian.org>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On it, need to refresh some knowledge and think with an upstream hat on now=
 :)

On Mon, Jul 24, 2023 at 6:12=E2=80=AFAM Salvatore Bonaccorso <carnil@debian=
.org> wrote:
>
> Hi,
>
> On Mon, Jul 10, 2023 at 10:39:43AM -0400, Benjamin Coddington wrote:
> > On 9 Jul 2023, at 3:38, Salvatore Bonaccorso wrote:
> >
> > > Hi Steve,
> >
> > ...
> >
> > > FWIW, in Debian we have applied the respective change. The idea would
> > > be to only depend on a single mechanism for setting up the mounts
> > > rather than a combination of the two (the generator and the static
> > > mount unit). For this reason we have applied the attached patch, and
> > > are not installing the units that we will let the generator produce,
> > > that is var-lib-nfs-rpc_pipefs.mount and rpc_pipefs.target
> > >
> > > We in Debian for long have diverged too much from you upstream,
> > > causing that we lacked behind several new upstream version and stuck
> > > with old versions in stable releases. We want to avoid running into
> > > that again in future. So if this make sense to you, would you apply
> > > the same (or as you prefer similar) change to you upstream?
> > >
> > > On one side so you could apply Andreas Hasenack patch, secondly
> > > installing the var-lib-nfs-rpc_pipefs.mount and rpc_pipefs.target
> > > could be dropped (note no changes to the other units needed as the
> > > repsective needed dependencies are generated by the systemd
> > > generator).
> > >
> > > Ben, Andreas, please add what else is needed from your point of view
> > > please!
> >
> > I don't think I've seen the PATCH land on the list addressed to nfs-uti=
ls
> > maintainer yet, but I could have missed it.
> >
> > Otherwise it looks sane to me, but I could be missing some upstream cas=
e.
> >
> > > Thanks a lot for considering this. If you have any suggestion further
> > > how we can unify the Debian downstream to you upstream, let us know
> > > please.
> >
> > At Red Hat, we use "upstream first" as a leading principle.  If this ch=
ange
> > makes sense for upstream, send Adreas' patch along and I am sure Steve =
D will
> > consider it or let us know why its not acceptible for upstream.
>
> Andreas, could you sent a proper patchset please, so upstream can have
> a look at it for inclusion?
>
> Regards,
> Salvatore
