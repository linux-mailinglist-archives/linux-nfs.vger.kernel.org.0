Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9C57216A
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jul 2019 23:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731947AbfGWVWA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Jul 2019 17:22:00 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:35087 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbfGWVWA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Jul 2019 17:22:00 -0400
Received: by mail-lj1-f180.google.com with SMTP id x25so42496405ljh.2
        for <linux-nfs@vger.kernel.org>; Tue, 23 Jul 2019 14:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=CGoAJHJOYY0XCz6PNKXXj0mh8ALmMqnBj1useCnfDS4=;
        b=Fj19uvNmmyJKXat9zxA7KtVWhhXAQRJKIy/4RGcAi1DdCY8xla3ha8UyN5Bnh1zcWA
         hebzx6sAE3QTqMNcwqXaFtJHTdR0uUoC/69/8WeP+KXNX4AD+rrakj1DSeLIw/xuRq6y
         /lFT5xl0G1CI+0kM8tgM6ppyLTJlPurHt1s47WyZxUkEFRUHpvJVs+5BABchqbketWUq
         NygApL1XOITS/r2TWda2n++8vKO/rOMbxR4weXinZhoNz+UPPo69QfN2oardUP1tN43A
         2xj9lfHZZ/x5P1xG4WSsvQkqjn7pekCeT4DoFWeR53q9ZH62RzBdNEBG1E1/99mBB46e
         RCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=CGoAJHJOYY0XCz6PNKXXj0mh8ALmMqnBj1useCnfDS4=;
        b=UYqmypNGykFMYOaDHgX8SixY8YmwN2+8ix8ai/mI2EGMnf6jERLAwQkCRuEDdexKiF
         5wwGC28rrV9NcBClCYSfSYSCgwHf1MphnCIaTjsJf/pf6OrazI4UcqseEL0DxLc313Ac
         h/bPo3Jm7M2vhrAGHW+2UEDCoNP9dmxaKAVvR292KsJnu4SE1VGwloAzsMd7N3Su/RN8
         PLuunD2jX+nrBdif/AvKxujpSORv55kovMLgYXHwR+3aAB8t42CrtpCmHORyAOgG/3K0
         +KNiqbr126RDKYM0kVD5ioMJThQshmyz1bxqDYIVg20UtyTTGEM7Wy+a0LhNz2Z5d4hw
         Z1Sw==
X-Gm-Message-State: APjAAAUPAt8tEH4k3xv8VAJ/U7vaAXz0LIGLwgIehcz78GmQTgQtfYjK
        SY5Wr1+RnBEgwteffj9YlG16ytl83AzvS7tQm7U4Owah
X-Google-Smtp-Source: APXvYqw+80rBF8ACq5VLVrzYjDtwfOmVTyjRQ6Cle3/51HmzFL8JsYbcwKMYnfByYyKmVmu2tIVCO78RW2odxuZiGks=
X-Received: by 2002:a2e:2d12:: with SMTP id t18mr23721168ljt.175.1563916918208;
 Tue, 23 Jul 2019 14:21:58 -0700 (PDT)
MIME-Version: 1.0
From:   Diyu Zhou <zhoudiyupku@gmail.com>
Date:   Tue, 23 Jul 2019 14:21:46 -0700
Message-ID: <CAH19VSHOxn-S8bc88fgZn8K1yw5=a9=m1YQBcCt9Ro_MPZVC_A@mail.gmail.com>
Subject: Write Delegation
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey,

I just started studying the Linux NFS code and I found the comments on file
/fs/nfsd/nfs4state.c right above function nfs4_open_delegation, saying: "
Attempt to hand out a delegation. Note we don't support write delegations, and
won't until the vfs has proper support for them."

Does that mean the current implementation of nfs4 in Linux does not support
write delegation?

Thank you all for your effort in building the NFS for Linux and thanks in
advance for your help.

Best,
Diyu
