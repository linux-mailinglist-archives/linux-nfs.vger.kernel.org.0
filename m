Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89206792786
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Sep 2023 18:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238286AbjIEQFq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Sep 2023 12:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354860AbjIEPJl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Sep 2023 11:09:41 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE91191
        for <linux-nfs@vger.kernel.org>; Tue,  5 Sep 2023 08:09:36 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31c3df710bdso2052502f8f.1
        for <linux-nfs@vger.kernel.org>; Tue, 05 Sep 2023 08:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693926575; x=1694531375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B+lygqBJ39E28GuPYBiDY+fsHyBNgoC7RrETyHCc0Xo=;
        b=QVx2uqz0zO/fXLnhgxcLkuRL/lcvTjEupb9Gu2xXQBdn81U8/IrxrEy88J+/6LFLAh
         tw+UTNAPuIkOmeIISd0VI7BSJRRXAjYKm138oL829Mw5AEKqh9NVXJ5eDlUHuY85Yexe
         jZ8FP0sQKknDLm11sLJ2V48hFTXzV67nNLdqF8t1vhSOY2v7SJmyD/xFrpsXLkLodxmh
         lFgi3WZtGQw/KNDuCFpSs0Op4tBpG2q9dIYSy1BNxOdcmjH8vsmu4QYtzP/5C2SFpA7e
         ao1BalHhO/U2c3SPwVqL8q20sRikgRzAXPrxNX03YKHzDm2YH0s26Efq37lE9dhzIT9k
         V7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693926575; x=1694531375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+lygqBJ39E28GuPYBiDY+fsHyBNgoC7RrETyHCc0Xo=;
        b=Tlx0NCD/oMxQy5zFc/IViAcvazKVDj+2liXWDeMfdfNH9NRkbMc6jt2wRw54y8vtJr
         lGJGhGd8Ypp0bEZpamiT5z9ZffW205/pPbjV+VJpTLjvA1mcrlchKzjcZm4HbEzPnt5O
         UWZVut0QdFXujDcWpb97jtbcMIvoDG+zzvAT+Ui6YiWjUdeQBQMR3d39ewVRlRCHugk3
         4keHGJITMp2lVrLmbJ+r51SqC445fnMGyY5ExDvmgxaluyPiasU1FLMvx1i8kWq7H4mu
         BqwY45WifnSiHhy13IjIrlw9i+tNPwICmbX1bMzMxZBqeQeo/D9oTxOt/MsA1fzNLYgX
         dyvg==
X-Gm-Message-State: AOJu0YwLwq9ACcGPFBHLWZrP+ry6iylZbVLIqQS7cM8wsQczav0Hx1H2
        KrI/bncg86+MUnZwz7xnsaA=
X-Google-Smtp-Source: AGHT+IEoQpUSFLg570FxdsCsXTHhn80L0S15ZurtNW9+hfs7dJR7krI8073u2RwRxN2QZzgU1biFRQ==
X-Received: by 2002:adf:fb10:0:b0:317:6efd:3a6b with SMTP id c16-20020adffb10000000b003176efd3a6bmr78580wrr.24.1693926574543;
        Tue, 05 Sep 2023 08:09:34 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id x18-20020a5d4452000000b0031431fb40fasm17737735wrr.89.2023.09.05.08.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 08:09:34 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id 96579BE2DE0; Tue,  5 Sep 2023 17:09:33 +0200 (CEST)
Date:   Tue, 5 Sep 2023 17:09:33 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Andreas Hasenack <andreas@canonical.com>,
        NeilBrown <neilb@suse.de>, Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org, Scott Mayhew <smayhew@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Ben Hutchings <benh@debian.org>
Subject: Re: [PATCH 0/2] Prefer generator to static systemd units
Message-ID: <ZPdErauSK2sXuh1T@eldamar.lan>
References: <CANYNYEEy2vf2rxLFeQ0hkstPrvF=eeA-joc0imGZt96Q+_r44w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANYNYEEy2vf2rxLFeQ0hkstPrvF=eeA-joc0imGZt96Q+_r44w@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Steve, Neil,

On Fri, Jul 28, 2023 at 01:06:49PM -0300, Andreas Hasenack wrote:
> Hi,
> 
> in Debian and Ubuntu, the configuration file /etc/nfs.conf is only
> placed on disk in the postinst script[1]. In this scenario it's possible
> to have the nfs-common generators run before /etc/nfs.conf exists[2],
> via another package's postinst calling systemctl daemon-reload. Since
> there is no /etc/nfs.conf yet, defaults are assumed and the generators
> exit silently, and the corresponding static units are used.
> 
> But in Debian/Ubuntu, the rpc_pipefs directory is /run/rpc_pipefs, and
> not the one specified in the static units, and thus we get it mounted in
> the wrong directory.
> 
> It seems best to always rely on the generators, as they will always be
> able to produce the correct target and mount units.
> 
> For reference, this was first brought up in this thread[3].
> 
> Producing an upstream set of patches was a bit confusing, since these
> systemd units are highly distro dependent. They are not even installed
> via `make install` because of this, so I have more confidence in the
> first patch of the series.
> 
> I produced a Debian package with these two patches applied on top of
> Debian's 2.6.3[6], and ran the DEP8 tests of nfs-utils[4] and autofs[5],
> which exercise some simple v3 and v4 mounts, with and without kerberos.
> These tests passed[7][8] (ephemeral links, will be gone once the PPA is
> destroyed).
> 
> 1. https://git.launchpad.net/ubuntu/+source/nfs-utils/tree/debian/nfs-common.postinst?h=applied/ubuntu/devel#n6
> 2. https://bugs.launchpad.net/ubuntu/+source/nfs-utils/+bug/1971935/comments/22
> 3. https://marc.info/?l=linux-nfs&m=165729895515639&w=4
> 4. https://git.launchpad.net/ubuntu/+source/nfs-utils/tree/debian/tests?h=applied/ubuntu/lunar-devel
> 5. https://git.launchpad.net/ubuntu/+source/autofs/tree/debian/tests?h=applied/ubuntu/lunar-devel
> 6. https://code.launchpad.net/~ahasenack/ubuntu/+source/nfs-utils/+git/nfs-utils/+ref/upstream-nfs-utils-test
> 7. https://autopkgtest.ubuntu.com/results/autopkgtest-mantic-ahasenack-nfs-upstream-test/mantic/amd64/a/autofs/20230728_135149_0895b@/log.gz
> 8. https://autopkgtest.ubuntu.com/results/autopkgtest-mantic-ahasenack-nfs-upstream-test/mantic/amd64/n/nfs-utils/20230728_150122_3ef18@/log.gz
> 
> Andreas Hasenack (2):
>   Always run the rpc_pipefs generator
>   Use the generated units instead of static ones
> 
>  configure.ac                            |  8 +-------
>  systemd/Makefile.am                     |  5 -----
>  systemd/rpc-pipefs-generator.c          |  3 ---
>  systemd/rpc_pipefs.target               |  3 ---
>  systemd/rpc_pipefs.target.in            |  3 ---
>  systemd/var-lib-nfs-rpc_pipefs.mount    | 10 ----------
>  systemd/var-lib-nfs-rpc_pipefs.mount.in | 10 ----------
>  7 files changed, 1 insertion(+), 41 deletions(-)
>  delete mode 100644 systemd/rpc_pipefs.target
>  delete mode 100644 systemd/rpc_pipefs.target.in
>  delete mode 100644 systemd/var-lib-nfs-rpc_pipefs.mount
>  delete mode 100644 systemd/var-lib-nfs-rpc_pipefs.mount.in

Is this patch series as prposed by Andreas acceptable upstream?

We have this change in Debian since the 1:2.6.3-1 upload,
https://tracker.debian.org/news/1442835/accepted-nfs-utils-1263-1-source-into-unstable/,
with no regression reported TTBOMK.

For reference, the patch series is here in the linux-nfs archives
(referencing it here explicitly as b4 mbox seems not to get all the 3
mails when requesting the cover letter):
https://lore.kernel.org/linux-nfs/CANYNYEEy2vf2rxLFeQ0hkstPrvF=eeA-joc0imGZt96Q+_r44w@mail.gmail.com/
https://lore.kernel.org/linux-nfs/CANYNYEFKtw+_Y-NrOoQt9G9eund2C0=XMrXBj8mt1L=ebrSkLQ@mail.gmail.com/
https://lore.kernel.org/linux-nfs/CANYNYEHETbcqmEhE7BB57bCH03J-XT986Bb+DucdpbV8KHeZug@mail.gmail.com/

Regards,
Salvatore
