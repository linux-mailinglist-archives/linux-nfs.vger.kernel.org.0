Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFD451DCC8
	for <lists+linux-nfs@lfdr.de>; Fri,  6 May 2022 18:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbiEFQHd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 May 2022 12:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238563AbiEFQHc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 May 2022 12:07:32 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A253569CCB
        for <linux-nfs@vger.kernel.org>; Fri,  6 May 2022 09:03:49 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id j8-20020a17090a060800b001cd4fb60dccso7245790pjj.2
        for <linux-nfs@vger.kernel.org>; Fri, 06 May 2022 09:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=yEUud2b8R47zKUIouR1xspgHGmSBod8nEciqocIq7uA=;
        b=KKDRoYVkfgjBXTdCx5SWl9SOWBc9gjKvq7Ex09NG42tIxFpGr3/xjgrYP5AmRA54w8
         j8BT1HpjW/U30WtyIPIJf81yYjVpgb94f/HZy7WmkGydQ7FU7WmaJ57mLTNbS4diiBa+
         C6hbwf4OTzsWIm7RkUokU4x7ITbwjI6zS+I5+iFdDPjXSmpFPYMoPX4G77/gH/2zpamu
         d2GsdBPlQoSUcyEC0bJfumj3l1GsX4evpHMmbrT2v9RQKK0fck7NfS+bCSy7KpqwaJyE
         3+BL1p21F9SK0OD6RJEYU8ZEPmC6djDJMZEImTcgOfoLoLDZ5F+iu4soZyfVhDnaZ/Ds
         xong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=yEUud2b8R47zKUIouR1xspgHGmSBod8nEciqocIq7uA=;
        b=fdT8vLwSYgGaGY0pOFkn5a4rPgiIoqqgU33Qge4ZTE0kUE94+3SJDPSlCr9X8Ayyhj
         39cfFzgLn0sInGbxxNyPTDaHNPDmL2X2CXuIpiPEA4feBHy/JofzO5ac38O2zO+1vx4p
         YorS3XguUEZbxwiCH0KSpn41u4yZMYmpPQ3L0SVuAd96JoTy1KnDK30FhPVt8//Sc63y
         40GAsNmwy1rQBjOb88FSzdA+dsgaDs8XcIZzDX3wIM9KFn2MLQp9W3t74Q9hWAyn2u4v
         PTJA2j6bqfSxF08qZOHrIlphrt7BGxLyWueDfkUVEMXeC8RcatwMbms2cePx5TeIlyJA
         zRKA==
X-Gm-Message-State: AOAM532lT4Zm0Gs2b+0QltI6olsQTWTPHV3WFgyWdYNl+e4Y5DT225Ty
        3apH74GOplDPK6InvE9KHv1+I6Iodb5CQAx+kxQ=
X-Google-Smtp-Source: ABdhPJwxe++3VTUvEgPdCPX8KHERUSoug2dVY9hQVmKFy4ui3EiH2Xsz0OhTtJHSCNZ5F/kUntyF22sPobcrlUyro4Q=
X-Received: by 2002:a17:902:ce8b:b0:15e:c249:1bf8 with SMTP id
 f11-20020a170902ce8b00b0015ec2491bf8mr4257282plg.52.1651853029023; Fri, 06
 May 2022 09:03:49 -0700 (PDT)
MIME-Version: 1.0
From:   Jonathan Cormier <jjcf89@gmail.com>
Date:   Fri, 6 May 2022 12:03:37 -0400
Message-ID: <CAEzfL1kMJWEY7MkDkx6wyC9b5q6NKq=SMBA5Vb4za6YHMfOynA@mail.gmail.com>
Subject: Re: [PATCH] NFS: LOOKUP_DIRECTORY is also ok with symlinks
To:     trondmy@kernel.org
Cc:     Anna.Schumaker@netapp.com, linux-nfs@vger.kernel.org,
        pmenzel@molgen.mpg.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Tested patch on ubuntu kernel 5.13.0-40. And it resolved a regression
we were seeing on our build servers.

Reported bug: https://bugs.launchpad.net/ubuntu/+source/linux-signed-hwe-5.13/+bug/1971482

Tested-by: Jonathan Cormier <jcormier@criticallink.com>

Thanks

-- Sending again in plain text mode...
