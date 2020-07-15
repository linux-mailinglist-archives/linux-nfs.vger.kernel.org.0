Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586DD220FCF
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jul 2020 16:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbgGOOsO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Wed, 15 Jul 2020 10:48:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49723 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729690AbgGOOsN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Jul 2020 10:48:13 -0400
Received: from mail-pl1-f198.google.com ([209.85.214.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jvihe-0001zU-Tf
        for linux-nfs@vger.kernel.org; Wed, 15 Jul 2020 14:48:11 +0000
Received: by mail-pl1-f198.google.com with SMTP id y9so2504693plr.9
        for <linux-nfs@vger.kernel.org>; Wed, 15 Jul 2020 07:48:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=LCvS2Mg+NMZP1rAlw+7qixFYYr8UXQD9EiMJwb616iQ=;
        b=QUeyRK3SjYZBPthk7THHUbJ4VSKA/JUpJRt23aGH5+dUtDj67P4tJyCzcDl549hQ6A
         S6jP01mMCntFs+qa+fJRhS+M+PMoGap9ePMjkKu1AKPyZzgvN2u50/lNG5jMGODbgjBj
         iHvfQF3QttuycbGZv74ji3CTP+dnA+bO7s7jz6nInLcvQwC94lydjdV0RinFCZ5f27EX
         NRBWxuPmLIOBAYrxxQjWpS53spTcxzENB9yY6Du66ol9L6/E3CeuKgTV1FXFDHN3jMVk
         vUhTm+mjWcSuNQW8O6RG+dpBoU56llfx1pPkfrBFEUlQDw5rSbKnvNjr+cMnD/SKnKxW
         CTng==
X-Gm-Message-State: AOAM531Hevgodeo6QJ0aWM5+4Pa6whpxN/24CXDOBUUE0RBkKeAzT1HY
        htcG1PtaNMK7tPc8GXHMCZ1SfnmbOieUDuc/2fr37dgwCU2Ffe0lS1g4ws5bHNaE3xtMuG/aVnx
        YW3nWQU5usmxJ1rnqeT0qv0jLia1rvh586BZORQ==
X-Received: by 2002:a17:90a:c68e:: with SMTP id n14mr10261831pjt.182.1594824489583;
        Wed, 15 Jul 2020 07:48:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKrlh1HvbeAaJgRiC//V1igGnVxmU5HjSc1N2Q+BfJgRLVgPaPWhuIYiLFaQfZuLdvy30qlg==
X-Received: by 2002:a17:90a:c68e:: with SMTP id n14mr10261800pjt.182.1594824489274;
        Wed, 15 Jul 2020 07:48:09 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id f72sm2391275pfa.66.2020.07.15.07.48.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2020 07:48:08 -0700 (PDT)
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: [Regression] "SUNRPC: Add "@len" parameter to gss_unwrap()" breaks
 NFS Kerberos on upstream stable 5.4.y
Message-Id: <309E203B-8818-4E33-87F0-017E127788E2@canonical.com>
Date:   Wed, 15 Jul 2020 22:48:06 +0800
Cc:     matthew.ruffell@canonical.com,
        linux-stable <stable@vger.kernel.org>, linux-nfs@vger.kernel.org,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
To:     chuck.lever@oracle.com
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

Multiple users reported NFS causes NULL pointer dereference [1] on Ubuntu, due to commit "SUNRPC: Add "@len" parameter to gss_unwrap()" and commit "SUNRPC: Fix GSS privacy computation of auth->au_ralign".

The same issue happens on upstream stable 5.4.y branch.
The mainline kernel doesn't have this issue though.

Should we revert them? Or is there any missing commits need to be backported to v5.4?

[1] https://bugs.launchpad.net/bugs/1886277

Kai-Heng
