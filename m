Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51517638AE2
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Nov 2022 14:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiKYNIO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Nov 2022 08:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiKYNIK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Nov 2022 08:08:10 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6273BF
        for <linux-nfs@vger.kernel.org>; Fri, 25 Nov 2022 05:08:05 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id m19so5092224edj.8
        for <linux-nfs@vger.kernel.org>; Fri, 25 Nov 2022 05:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=evmKp5tDkAX6OHAl/3z7pwagPxmvC+zZZlqq+VXixoE=;
        b=KmYtoSCbrE8/f3Y/xdVtPznZPBKd9EtM//8HwBCJxd4dL6rGFyXbJuxeFKPIhMQbwN
         PQJmahnoFsaTmyifFd4NI1Jlcyvjo3n4z/4uVORzE5WNq8DkG1cQkgHvId1xemY/0EsV
         vabenhHS5sdDWuBf2PgT9TEhPNvz2wmeygSmumLsdjIOU7k6y6GZjZqmZzJouEiMtM5A
         odi+G57Oqb3UC9YQrT8NzKn/2Pw9SglwqE4sESZsHc+kTiCCrG1Ct+2BXd+1hYoRDTAG
         pujCgLGoDSbi/VPsmHDDkhVE8oJcvG5s7UYC+0UdFPonrhYa7rbuKSETAU32wn6VUr9c
         sVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evmKp5tDkAX6OHAl/3z7pwagPxmvC+zZZlqq+VXixoE=;
        b=hoaserikajWf4V0ZA1WGQfPF4y0XscERJQ1oYC1QKidfffr8CmYrakldWn5Uv3BB6P
         9VbUVJOx4maFKnV+sisk4waPNiM4p0DSWG89RBxjbbGPiQ5kOlEDVv5xwlh2XC7oBIIq
         tQv0CD69tfz6xJU+Je34CbeSBU4ix6kePukWa5YtTgYvVQbp0VE4Z1k5ZcRwgvS6wbK4
         ugqvmQAqJU+/xTXPuDhGxnuz3XN4DhnAEcfzj8plLf0YNcRnSeClTwkXA88Z2iPqRIB0
         HFiVedLOaLhYrnosn3xAXrO0SXzHGv225eRBGuaPbYnLsjs2dRcYCS4I1XtEjG4XqCUu
         BZYA==
X-Gm-Message-State: ANoB5pk3Fcz/kgL7MLpBHYvzrV8EJgZI39pN7Q4m/EJX0jBdgY8mxQe+
        MZvzBLpuUCn/8Y8HRttAVLY=
X-Google-Smtp-Source: AA0mqf6/HpvtITHq25CxZNUPEeML+cp+tsLijpcswch1r4342KpNx5gJgDUfGDg3BzK9JYhOOg8mhQ==
X-Received: by 2002:a05:6402:181:b0:461:ea0c:e151 with SMTP id r1-20020a056402018100b00461ea0ce151mr20655846edv.376.1669381683890;
        Fri, 25 Nov 2022 05:08:03 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id e19-20020a170906315300b007803083a36asm1548303eje.115.2022.11.25.05.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 05:08:03 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id C40AABE2DE0; Fri, 25 Nov 2022 14:08:01 +0100 (CET)
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     NeilBrown <neilb@suse.de>, Steve Dickson <steved@redhat.com>,
        linux-nfs@vger.kernel.org
Cc:     Andras Korn <korn-debbugs@elan.rulez.org>,
        Marco d'Itri <md@linux.it>, Michael Prokop <mika@debian.org>,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH 0/4] Replace sysctl setting invocations triggered from udev rule instead of modprobe configuration
Date:   Fri, 25 Nov 2022 14:07:21 +0100
Message-Id: <20221125130725.1977606-1-carnil@debian.org>
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

Marco d'Intri suggested there three possible solutions, of which one
could be done in nfs-utils (whereas the other two are either in kmod
upstream or initramfs-tools upstream). The nfs-utils one would be to
replace the modprobe configuration with a set of udev rules instead.

This series reverts the commit wich intorduce the use of the modprobe
configuration and instead replaces it with an udev rule which triggers
setting the sysctl settings when the respective modules are loaded

Regards,
Salvatore

Salvatore Bonaccorso (4):
  Revert "configure: make modprobe.d directory configurable."
  Revert "modprobe: protect against sysctl errors"
  Revert "systemd: Apply all sysctl settings when NFS-related modules
    are loaded"
  systemd: Apply all sysctl settings through udev rule  when NFS-related
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

