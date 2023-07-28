Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8573576717C
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jul 2023 18:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjG1QHJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Jul 2023 12:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235025AbjG1QHI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Jul 2023 12:07:08 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC8D2686
        for <linux-nfs@vger.kernel.org>; Fri, 28 Jul 2023 09:07:05 -0700 (PDT)
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D9CB33F189
        for <linux-nfs@vger.kernel.org>; Fri, 28 Jul 2023 16:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1690560423;
        bh=VGKDtuRAPZGAWg88VlGexTNJNyyT4L+ygCbCelBAKJI=;
        h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
        b=YVwtGYwDtyU/NMC3yldIcnaSJl2Z64xTwvTjyFOcfxVfO/HrG+bI9ILM8V+R9eQEj
         4n65f4AbnmX+LUTRxCaatrAS4fgyvLlWrmuhAdRoSrU4soO5tdkoy4tMxlMizpLbBY
         JpAZgEypYAI1YWkuKChVq2c6I6HhgJAtSh066MUbRdVm2kLX1FVXpMbYDza1ohmsS7
         +XVNNWwXzTIe+0MsiJ6pS+ZvByzBlhVJKydEKY2+gWuTWm9HScHAw/y2xTqjqMkpJ5
         jY+xr6zyI4Mno1POsh3ymrKS/OjG0867nkt9D7tyYMs36QLXRD3LFkmeUdQPmpM1/y
         GRbbrWCz4eWFw==
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-565dd317fe8so3633382eaf.0
        for <linux-nfs@vger.kernel.org>; Fri, 28 Jul 2023 09:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690560422; x=1691165222;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VGKDtuRAPZGAWg88VlGexTNJNyyT4L+ygCbCelBAKJI=;
        b=BD1jzOS0pgoDLGiw0e1lRTDwN8QOKzYfU0ZuMB7R08WbAUCdqG3dS1hQJG5wPlC5Qu
         pWPqHhbtF+5cxfYf248WpQsmdyXQ7J/9rQOQ/xnb+PDhUlzUiiXgKa1g/GxI4SxXnjEn
         vvCbpvBwI+8MigLa6PDPLhP6K5W1b6WxLWPTCiXcU23MFTW2TmHQFXOp9ZEGp7j8R0zd
         VweyDhn3eZkaHsDR+w5fI12mZ130WzRflkBOqXAirEAqs5yCjjFokw43MIKNzNa8dofk
         uxgN18PkGSvrWxfG15BgaRqvGs9Hyyfydc1gDecLFry3s7aSiIW+ZxO0I2+DDc+Q967H
         oX7Q==
X-Gm-Message-State: ABy/qLbj1ce/QzpGcWgZ9WWEP4SBMOuAj5CCk79GAh6uyykN8pG7dY90
        Ed40Lh0c1VAhMs9jpEsbGe+IanCBCCV6o/e4CQsjzX0PS9iZMY2ADdq+vS8t2d8LrdqwKgTj9M9
        Zxpv3y71mNUOwULwlVVkgCznDbz8j7Wws/3PjvvatBwbwkNnyrMIzLBsS+F4QnI2M
X-Received: by 2002:aca:2308:0:b0:3a1:e85f:33ee with SMTP id e8-20020aca2308000000b003a1e85f33eemr3059033oie.56.1690560422026;
        Fri, 28 Jul 2023 09:07:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGZBrSapoxLUJAH0Mu7Ejmb26xsjQBLJlOUSMDSx/tUlyf8lRYDBJkewghwCMAAqbBPlqeAopwX9eZwMz08s6c=
X-Received: by 2002:aca:2308:0:b0:3a1:e85f:33ee with SMTP id
 e8-20020aca2308000000b003a1e85f33eemr3058924oie.56.1690560420315; Fri, 28 Jul
 2023 09:07:00 -0700 (PDT)
MIME-Version: 1.0
From:   Andreas Hasenack <andreas@canonical.com>
Date:   Fri, 28 Jul 2023 13:06:49 -0300
Message-ID: <CANYNYEEy2vf2rxLFeQ0hkstPrvF=eeA-joc0imGZt96Q+_r44w@mail.gmail.com>
Subject: [PATCH 0/2] Prefer generator to static systemd units
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

in Debian and Ubuntu, the configuration file /etc/nfs.conf is only
placed on disk in the postinst script[1]. In this scenario it's possible
to have the nfs-common generators run before /etc/nfs.conf exists[2],
via another package's postinst calling systemctl daemon-reload. Since
there is no /etc/nfs.conf yet, defaults are assumed and the generators
exit silently, and the corresponding static units are used.

But in Debian/Ubuntu, the rpc_pipefs directory is /run/rpc_pipefs, and
not the one specified in the static units, and thus we get it mounted in
the wrong directory.

It seems best to always rely on the generators, as they will always be
able to produce the correct target and mount units.

For reference, this was first brought up in this thread[3].

Producing an upstream set of patches was a bit confusing, since these
systemd units are highly distro dependent. They are not even installed
via `make install` because of this, so I have more confidence in the
first patch of the series.

I produced a Debian package with these two patches applied on top of
Debian's 2.6.3[6], and ran the DEP8 tests of nfs-utils[4] and autofs[5],
which exercise some simple v3 and v4 mounts, with and without kerberos.
These tests passed[7][8] (ephemeral links, will be gone once the PPA is
destroyed).

1. https://git.launchpad.net/ubuntu/+source/nfs-utils/tree/debian/nfs-common.postinst?h=applied/ubuntu/devel#n6
2. https://bugs.launchpad.net/ubuntu/+source/nfs-utils/+bug/1971935/comments/22
3. https://marc.info/?l=linux-nfs&m=165729895515639&w=4
4. https://git.launchpad.net/ubuntu/+source/nfs-utils/tree/debian/tests?h=applied/ubuntu/lunar-devel
5. https://git.launchpad.net/ubuntu/+source/autofs/tree/debian/tests?h=applied/ubuntu/lunar-devel
6. https://code.launchpad.net/~ahasenack/ubuntu/+source/nfs-utils/+git/nfs-utils/+ref/upstream-nfs-utils-test
7. https://autopkgtest.ubuntu.com/results/autopkgtest-mantic-ahasenack-nfs-upstream-test/mantic/amd64/a/autofs/20230728_135149_0895b@/log.gz
8. https://autopkgtest.ubuntu.com/results/autopkgtest-mantic-ahasenack-nfs-upstream-test/mantic/amd64/n/nfs-utils/20230728_150122_3ef18@/log.gz

Andreas Hasenack (2):
  Always run the rpc_pipefs generator
  Use the generated units instead of static ones

 configure.ac                            |  8 +-------
 systemd/Makefile.am                     |  5 -----
 systemd/rpc-pipefs-generator.c          |  3 ---
 systemd/rpc_pipefs.target               |  3 ---
 systemd/rpc_pipefs.target.in            |  3 ---
 systemd/var-lib-nfs-rpc_pipefs.mount    | 10 ----------
 systemd/var-lib-nfs-rpc_pipefs.mount.in | 10 ----------
 7 files changed, 1 insertion(+), 41 deletions(-)
 delete mode 100644 systemd/rpc_pipefs.target
 delete mode 100644 systemd/rpc_pipefs.target.in
 delete mode 100644 systemd/var-lib-nfs-rpc_pipefs.mount
 delete mode 100644 systemd/var-lib-nfs-rpc_pipefs.mount.in

-- 
2.39.2
