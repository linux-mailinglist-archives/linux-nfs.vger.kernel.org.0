Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE00638BD3
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Nov 2022 15:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiKYOHJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Nov 2022 09:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiKYOHI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Nov 2022 09:07:08 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70251EAFA
        for <linux-nfs@vger.kernel.org>; Fri, 25 Nov 2022 06:07:04 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id e13so6532948edj.7
        for <linux-nfs@vger.kernel.org>; Fri, 25 Nov 2022 06:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=3wBwisi2/T4XmK/puw67uqZFXuf3OTea2yFrkzIvKT8=;
        b=c55pw7CsonyMRciMjYVU5cAYdqTBA4/uvSmtEd6GOsYS0ZU66OHJt1+Cs0cO9iwLBZ
         dDTsCi70xemmGIy98jkLCHVkN9wivCT8IzIboKIw3vxe7QY16rxWP9OiPuUBQ0X+en+f
         YL0ixZBVW4xsrWbrp5cFHj2WvTKv61d0TvIaG9M17luhYYo8XAxEtY611mSXaxjkVzIv
         ZeG7m1KInyDTVthUD8Eg/HRW13cU/dVPQ15tFTUj1uykzYV7a+Zh77y6G7//SJdXbnLe
         4KuGGJL5k3iV82YBLgJsnZ1tNoggRtkzY2X+5oN3+Now4BlBfzNq93lCOj1bwwZsuUfW
         21Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wBwisi2/T4XmK/puw67uqZFXuf3OTea2yFrkzIvKT8=;
        b=onwTfEahqBHmTnQyIVtuclqCV+3dm9OucCEhv+7GGmySMn8O3MkC4+ihQcbGCsP52l
         Z4kLU7zUDG9lMSwR/79Bg/EHZdyIxT1mQ9QHMz0SBB4HKgDNpRQEP+Z2L3jf6iVD8zVD
         UN/C5bxwctes7n5H3pZXw+POF6ivV+0wc9GLU3P3cnaSDrmvQRoauuw48jUEgFZl5VmX
         BK1iqWxSG3C5nuS5CfrJYiNTEUt2WRdr+kbtRm2KjuNesHuRIxm8KNjdtKVPE8T0/u54
         fYLHGPm3F/GtGH4spT/kb3QB1k5Fdu6ofLbD2UVQrAALI3b5dMUXY/SNdiodjYEjs02R
         XvMQ==
X-Gm-Message-State: ANoB5pkqPbOVfnAT2R2pXG9AgzkFHhf0768xRfvBnWxvnv3x0EkfPl4F
        Gn7gQYyv9JQ0k7S9B6fAjV8=
X-Google-Smtp-Source: AA0mqf4/kEcstJr8Oe1XNdOuPJLBdRSsEuRU2oSC09NSyAJJLm8tKd0SwSv7y7j37rCbasM7K7cjVw==
X-Received: by 2002:a05:6402:189:b0:469:85d:2663 with SMTP id r9-20020a056402018900b00469085d2663mr32033596edv.56.1669385223366;
        Fri, 25 Nov 2022 06:07:03 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id e1-20020a170906c00100b00787f91a6b16sm1600914ejz.26.2022.11.25.06.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 06:07:02 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id 03AF0BE2DE0; Fri, 25 Nov 2022 15:07:01 +0100 (CET)
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     NeilBrown <neilb@suse.de>, Steve Dickson <steved@redhat.com>,
        linux-nfs@vger.kernel.org
Cc:     Andras Korn <korn-debbugs@elan.rulez.org>,
        Marco d'Itri <md@linux.it>, Michael Prokop <mika@debian.org>,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH v2 0/4] Replace sysctl setting invocations triggered from udev rule instead of modprobe configuration
Date:   Fri, 25 Nov 2022 15:06:52 +0100
Message-Id: <20221125140656.1985137-1-carnil@debian.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Neil, hi Steve

In Debian for the update including the systemd/50-nfs.conf there was a
report that sunrpc is not included anymore in the initrd through the
initramfs-tools hooks.

The report is at https://bugs.debian.org/1022172

Marco d'Itri suggested there three possible solutions, of which one
could be done in nfs-utils (whereas the other two are either in kmod
upstream or initramfs-tools upstream). The nfs-utils one would be to
replace the modprobe configuration with a set of udev rules instead.

This series reverts the commits which introduce the use of the modprobe
configuration and instead replaces it with an udev rule which triggers
setting the sysctl settings when the respective modules are loaded.

Regards,
Salvatore

Changes:
--------
v2:
 - Fix a series of spelling and typos in the commit messages.

Salvatore Bonaccorso (4):
  Revert "configure: make modprobe.d directory configurable."
  Revert "modprobe: protect against sysctl errors"
  Revert "systemd: Apply all sysctl settings when NFS-related modules
    are loaded"
  systemd: Apply all sysctl settings through udev rule when NFS-related
    modules are loaded

 configure.ac         | 12 ------------
 systemd/50-nfs.conf  | 16 ----------------
 systemd/60-nfs.rules | 21 +++++++++++++++++++++
 systemd/Makefile.am  | 15 ++++++---------
 4 files changed, 27 insertions(+), 37 deletions(-)
 delete mode 100644 systemd/50-nfs.conf
 create mode 100644 systemd/60-nfs.rules

-- 
2.38.1

