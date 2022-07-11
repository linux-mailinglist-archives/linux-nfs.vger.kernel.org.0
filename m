Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9534A56FFEF
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Jul 2022 13:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiGKLPE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Jul 2022 07:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiGKLOk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Jul 2022 07:14:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC80726129
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jul 2022 03:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657535587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7SouKYlMkWzuBqZN4rXZnGRyOzkCR8tKbjyAs7q8HvU=;
        b=YSOhjSUUsfQf4RZJ9KhA4xJFNPrpZchme5VaNhCX3QntJyTvLnOzuLHCqHUt+8I4Mg1HMQ
        yLywTyost7vWKQfXXNnUJ93aXAntJGxgvHAN8de3ivsZP5tM+pt4ShNzcpHVuezofbaaDs
        a6tAKRs41F97li3IhI5pJj9Gp5WJtwo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-119-1nYCyH2AMcG7XVoQcfyczg-1; Mon, 11 Jul 2022 06:33:07 -0400
X-MC-Unique: 1nYCyH2AMcG7XVoQcfyczg-1
Received: by mail-qv1-f71.google.com with SMTP id mh1-20020a056214564100b00472fcc5ae9eso35389qvb.11
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jul 2022 03:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=7SouKYlMkWzuBqZN4rXZnGRyOzkCR8tKbjyAs7q8HvU=;
        b=5XCESY8RzsMtEImKFhX737m2bUofRWe7kMDcOu50WrCz7rYAQgapNC8gU3B+RTi7+x
         qZ5LxJT5BaPPACFnhU+9QCVHdYrIP/tW/giOcQc8emTq/RyOLAfzKLdpAb2Nlvm1Iar4
         AH3q1I4S35UjgvONgAwHJAbxe0nIE5CU59GXovu7Uai9aQF1Imy/zAkMDHacB27IAzJB
         iZW5HRDR/gDWyLXp7lL49dWgWwwzUZ5veEQwsMGHyd8pv+/SEZ22LSq5y0ROJMQUh+8c
         bjgIQuhc8VFXQO4Stxl7KJduMtRGbNn3kMwDh6lEVh9FKVoFUi5OCWeFReYMvsxowDlo
         8yXg==
X-Gm-Message-State: AJIora9RsosATHS6Z2jJFGeHiuFZXT5DmJlEqL8/MVxWv9DKyO28U3Vm
        8hFY+MOhhtceCEbG9FCScYZGTVOEl8kZDYCZWKiEzGawu00yQonbIwX2du6QntYtAALkvO7YuEi
        NjADqH0eYvJ8Ns6QkYakv
X-Received: by 2002:a05:620a:248b:b0:6af:4f9b:b0b3 with SMTP id i11-20020a05620a248b00b006af4f9bb0b3mr10744910qkn.408.1657535586067;
        Mon, 11 Jul 2022 03:33:06 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sVs/FGj4fU/SHmbL6FO7aKqyMJktULJSdpAV9Q8sEhXC5/1g0kdZI7wuRnJVLLrBO2Fvn7aw==
X-Received: by 2002:a05:620a:248b:b0:6af:4f9b:b0b3 with SMTP id i11-20020a05620a248b00b006af4f9bb0b3mr10744892qkn.408.1657535585813;
        Mon, 11 Jul 2022 03:33:05 -0700 (PDT)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id w22-20020ac87e96000000b0031eb5648b86sm2016792qtj.41.2022.07.11.03.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 03:33:05 -0700 (PDT)
Message-ID: <5268baed1650b4cba32978ad32d14a5ef00539f2.camel@redhat.com>
Subject: Re: [GIT PULL] nfsd changes for 5.18
From:   Jeff Layton <jlayton@redhat.com>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Igor Mammedov <imammedo@redhat.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Ondrej Valousek <ondrej.valousek.xm@renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bruce Fields <bfields@fieldses.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Jul 2022 06:33:04 -0400
In-Reply-To: <B62B3A57-A8F7-478B-BBAB-785D0C2EE51C@oracle.com>
References: <EF97E1F5-B70F-4F9F-AC6D-7B48336AE3E5@oracle.com>
         <20220710124344.36dfd857@redhat.com>
         <B62B3A57-A8F7-478B-BBAB-785D0C2EE51C@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, 2022-07-10 at 16:42 +0000, Chuck Lever III wrote:
>=20
> > On Jul 10, 2022, at 6:43 AM, Igor Mammedov <imammedo@redhat.com> wrote:
> >=20
> > On Mon, 21 Mar 2022 14:12:31 +0000
> > Chuck Lever III <chuck.lever@oracle.com> wrote:
> >=20
> > couldn't find offender patch on ML so replying here
>=20
> Probably:
>=20
> https://lore.kernel.org/linux-nfs/AEC24099-5BC9-49C8-B759-920824F23F3C@or=
acle.com/
>=20
>=20
> > > Hi Linus-
> > >=20
> > > The following changes since commit 7e57714cd0ad2d5bb90e50b5096a0e671d=
ec1ef3:
> > >=20
> > > Linux 5.17-rc6 (2022-02-27 14:36:33 -0800)
> > >=20
> > > are available in the Git repository at:
> > >=20
> > > git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd=
-5.18
> > >=20
> > > for you to fetch changes up to 4fc5f5346592cdc91689455d83885b0af65d71=
b8:
> > >=20
> > > nfsd: fix using the correct variable for sizeof() (2022-03-20 12:49:3=
8 -0400)
> > >=20
> > > ----------------------------------------------------------------
> > > New features:
> > > - NFSv3 support in NFSD is now always built
> > > - Added NFSD support for the NFSv4 birth-time file attribute
> > [...]
> >=20
> > > Ondrej Valousek (1):
> > > nfsd: Add support for the birth time attribute
>=20
> Thank you for the report, Igor.
>=20
>=20
> > This patch regressed clients that support TIME_CREATE attribute.
> > Starting with this patch client might think that server supports
> > TIME_CREATE and start sending this attribute in its requests.
>=20
> Indeed, e377a3e698fb ("nfsd: Add support for the birth time
> attribute") does not include a change to nfsd4_decode_fattr4()
> that decodes the birth time attribute.
>=20
> I don't immediately see another storage protocol stack in our
> kernel that supports a client setting the birth time, so NFSD
> might have to ignore the client-provided value.
>=20

Cephfs allows this. My thinking at the time that I implemented it was
that it should be settable for backup purposes, but this was possibly a
mistake. On most filesystems, the btime seems to be equivalent to inode
creation time and is read-only.

>=20
> > However kernel on server side (since this patch and to
> > current master) upon getting such request will return EINVAL.
> > (my guess is that TIME_CREATE not being decoded properly and
> > that messes up request parsing).
>=20
> I'll send a quick-and-dirty fix your way as we explore the
> question of whether NFSD needs to ignore the birth time value
> in this case.
>=20
>=20
> > End result is unusable mount (unless it's treated as readonly).
>=20
> That seems odd, and not clear whether that's a client or server
> problem. I hope that will clear up once the server deals with
> the time_create attribute appropriately.
>=20
>=20
> > Reproduces with current master (HEAD at e5524c2a1fc40) and MacOS
> > client (Big Sur or newest Monterey).
> >=20
> > server is typical setup exporting files from XFS (Fedora36)
> >=20
> > #  rpcdebug -m nfsd -s all
> >=20
> > on client:
> >=20
> > % mount -t nfs -o vers=3D4,rw,nfc,sec=3Dsys testnas:/mnt  ~/test
> > % touch ~/test/fff
> >     touch: test/fff: Invalid argument
> >=20
> > server logs:
> >=20
> > nfsd: fh_compose(exp fd:00/128 fff, ino=3D0)
> > NFSD: nfsd4_open filename  op_openowner 0000000000000000
> >=20
> > Here is a request the touch generates:
> >        Network File System, Ops(6): PUTFH, SAVEFH, OPEN, GETATTR, RESTO=
REFH, GETATTR
> >            [Program Version: 4]
> >            [V4 Procedure: COMPOUND (1)]
> >            Tag: create
> >            minorversion: 0
> >            Operations (count: 6): PUTFH, SAVEFH, OPEN, GETATTR, RESTORE=
FH, GETATTR
> >                Opcode: PUTFH (22)
> >                Opcode: SAVEFH (32)
> >                Opcode: OPEN (18)
> >                    seqid: 0x00000004
> >                    share_access: OPEN4_SHARE_ACCESS_BOTH (3)
> >                    share_deny: OPEN4_SHARE_DENY_NONE (0)
> >                    clientid: 0xba93c9620aec46ea
> >                    owner: <DATA>
> >                    Open Type: OPEN4_CREATE (1)
> >                        Create Mode: UNCHECKED4 (0)
> >                        Attr mask: 0x00040002 (Mode, Time_Create)
> >                            reco_attr: Mode (33)
> >                            reco_attr: Time_Create (50)
> >                    Claim Type: CLAIM_NULL (0)
> >                        Name: fff
> >=20
> >        [...]
> >=20
> > when trying to copy file via GUI (Finder) it goes a different route
> > but ends up with error anyway and with leftover 0-length file on server
> > with messed up permissions, i.e.
>=20
> The current NFSv4 OPEN(CREATE) code path is still not right. Fixing
> the TIME_CREATE problem should make this symptom go away for now,
> but eventually that path will need to be restructured so that it
> cannot leave a turd if the whole create process was not able to
> complete.
>=20
>=20
> > open/create without Time_Create succeeds but followup
> > setattr with Time_Create fails EINVAL.
> >=20
> >        Network File System, Ops(3): PUTFH, SETATTR, GETATTR
> >            [Program Version: 4]
> >            [V4 Procedure: COMPOUND (1)]
> >            Tag: setattr
> >            minorversion: 0
> >            Operations (count: 3): PUTFH, SETATTR, GETATTR
> >                Opcode: PUTFH (22)
> >                Opcode: SETATTR (34)
> >                    StateID
> >                    Attr mask: 0x00450002 (Mode, Time_Access_Set, Time_C=
reate, Time_Modify_Set)
> >                        reco_attr: Mode (33)
> >                        reco_attr: Time_Access_Set (48)
> >                        reco_attr: Time_Create (50)
> >                        reco_attr: Time_Modify_Set (54)
> >                Opcode: GETATTR (9)
> >            [Main Opcode: SETATTR (34)]
> >=20
> > [...]
> > > --
> > > Chuck Lever
>=20
> --
> Chuck Lever
>=20
>=20
>=20

--=20
Jeff Layton <jlayton@redhat.com>

