Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF1A346B73
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Mar 2021 22:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbhCWV5M (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Mar 2021 17:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbhCWV4s (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Mar 2021 17:56:48 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829D9C061574
        for <linux-nfs@vger.kernel.org>; Tue, 23 Mar 2021 14:56:48 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo136689wmq.4
        for <linux-nfs@vger.kernel.org>; Tue, 23 Mar 2021 14:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=CGeu6tPzlXD8o2sQKsQ9ODKH4jAq/vSXWik5vlItOtM=;
        b=u9WPhhDEpFo5O+ErNMPjjrh+8xgv0WxxXOCipTwlGoaImlrZ6LzTbe6p8MggF2v+xe
         iAaGQU89QbGhn8y2WGoJ13VsvBh0Eg0yi6YbVXhttrVrvIXX8dZax3Lj3W93046RsqaZ
         0S8N32ja3+kqFZwG4O6E4IgIE1MoudYj7OFFsP0o8boleXtkkIDDsC/6/7oXEBLOQwY6
         umZ2BOzoUSs0vZ2JM8kXdkg3tN3LCBV6PKbZKV8NORg7Uqq6La2Dx+ULePK4QtZ6u0G0
         PCUpryPYsEswt9Wl+TKkoGInsAFfzm5ST6mql/LZ/3joIX3PMGoTJvi/9IHQdNNR9FX8
         a4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=CGeu6tPzlXD8o2sQKsQ9ODKH4jAq/vSXWik5vlItOtM=;
        b=WM89HLIi8Aq7+7lFVL+z/lCMrWb/JLbZBcBWms5AM4MjzainYSaNWQzFvbYDfU5AU0
         HrFp9ovLxfpZ2l+gjL070df5wW05WC3y0iId1pLqjPu+A43EP7YGPxUZn86e/YB+hdd9
         +T44FG+TBZ9ahqkIdPloMn0Mp1KrFl0hzfXi4ufxWJnMdBaHIQUHZFcmcurN4QcatuKa
         Jz8TWtaYUbx1gxDTp+d5fTVvqkkAfKN/aO8gJyoeul1abi/ITn0xTtc5aPwrXjC4cT4R
         n+gbbm9WtF6TLPHFQMeOnLo3gmxz0Weh54PjLb8f9fmlnK3YAeCiGpOQ9AwiAECZwCCJ
         tbPQ==
X-Gm-Message-State: AOAM531o4NgMDzPQoUcaczF4GN4wojS+SRsk3hhGJlolqV//xy9hAdRz
        h7773vJF902nbKPAv8x52yd1KS5rFguNhTZxBmXhM+BgKEQ=
X-Google-Smtp-Source: ABdhPJx3aJTkos6Fap3JaaDV9r55VRgLWpPGa50bzR25frHTSKbyOMRyXroXBMJ5soHY5SFySzsqAzTbwUsmmk3bA9Q=
X-Received: by 2002:a7b:cb99:: with SMTP id m25mr103966wmi.64.1616536606976;
 Tue, 23 Mar 2021 14:56:46 -0700 (PDT)
MIME-Version: 1.0
From:   Pradeep <pradeepthomas@gmail.com>
Date:   Tue, 23 Mar 2021 14:56:36 -0700
Message-ID: <CAD8zhTB-ie445UwCJnd9qW242EzcFX9SuWJxvaU3KnB1h-dFyg@mail.gmail.com>
Subject: NFSv4 referrals with FQDN.
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

While testing NFSv4 referrals, I noticed that if the server name in FS
locations does not have IPv4 mapping (server name has AAAA record for
IPv6; but no A record in DNS), the referral mount fails. With debug
enabled, I get something like this:

 nfs_follow_referral: referral at /nfs_export_1
 nfs4_path: path server-1.domain.com:/nfs_export_1 from nfs_path
 nfs4_path: path component /nfs_export_1
 nfs4_validate_fspath: comparing path /nfs_export_1 with fsroot /nfs_export_1
 ==> dns_query((null),server-2.domain.com,19,(null))
 call request_key(,server-2.domain.com,)
 <== dns_query() = -126
 nfs_follow_referral: done
 nfs_do_refmount: done
 RPC:       shutting down nfs client for server-1.domain.com
 RPC:       rpc_release_client(ffff97fdf170c600)
 RPC:       destroying nfs client for server-1.domain.com
 <-- nfs_d_automount(): error -2

It looks like NFS client does an upcall to "/sbin/key.dns_resolver".
"/sbin/key.dns_resolver" works if callout info is set to 'ipv6'.
Otherwise it fails too.

Does this mean setups with only IPv6 records (AAAA records in DNS),
NFSv4 referrals won't work if server returns FQDN in referral? If
anyone has tried this and made it work, please let me know.

Thanks,
Pradeep
