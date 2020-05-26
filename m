Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57C31E314C
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2020 23:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390002AbgEZVhv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 May 2020 17:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388740AbgEZVhv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 26 May 2020 17:37:51 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EF9C061A0F
        for <linux-nfs@vger.kernel.org>; Tue, 26 May 2020 14:37:51 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id z3so17588836otp.9
        for <linux-nfs@vger.kernel.org>; Tue, 26 May 2020 14:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigabort-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=MkSDZ/trj1xJQUlQZjGLrdB76W0CoTARyFU3JsdF6Pk=;
        b=TqbufuEY9kTQA0or6br2gUAE5ENNH17WPoPjeQPHFIhV96+gG9jkAu66qifB+ga9xy
         Y3nHx3kPXMLzCDaOxHUHUCfu2rzRoGowa7ZIKdU/B6CpS9pTTeFIDR+5cI4DRggJXG6b
         IwDtmEoxz8/J5r6UFOFpJeAXk8FpdorvH9BHxHWM4sBuFTjQrNlB1UsyWUb1ud6fhJJC
         E163lOvamouOrgJwF6tzCyhwvS4WtOhchpdDLpC9cIUJ/U2oWa+rOwl8jgxaFsn91o4K
         DTxls2ycFzhBYoY+wgkgjwcg2YPo5ydCZVpfh+3KzN0rcZR5WV70nD6801sFGraV+8cY
         0Vew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=MkSDZ/trj1xJQUlQZjGLrdB76W0CoTARyFU3JsdF6Pk=;
        b=YDVtllHoQ7eVacGK6PxFL9hOwir6NkZPclZflStkyRIuhs3QbFz0t8C0b7Fp21+jLy
         dLFaXvP3YQ5pF34Zyh1EQZO05QXebHUex+uGamAmAZL7NocRcih+N8P53qO/cPlrTzFS
         lBT4XdV5qt+Wv0KdiX8d6JQgjDkfyO2H+ks/vRj34krTcvyiIE/Ds2U59KtB/vRCG+1M
         Hb7rnsc9p5byF3/YctpYVZFqn62sNL5FF8xOIlv9hmxu2mZXkHlCqaGd6hY/DgITUyEb
         3mtNrgGm2XCbr2CTPN6I4RA7hR6V8YSvQHkoQs/h7EeeC+tu49jsszDSUJySZn9KEtzZ
         HidA==
X-Gm-Message-State: AOAM53128pj6cfW4TKfheMtduMunjbnnxz25shCsNhJJ5DHZeWamyCbU
        XP7rn0tHvBu3UvAyJxEFHxQwMqk5OtP6xuTDElOSHqBMG8c=
X-Google-Smtp-Source: ABdhPJziweyN25tz122T5kf/zGKhRT0n/egIGaSzSPjnnWPNQeg3B4hNaCzd/1AmlQaWVBNWAITFa/6SowSbfyHHq8E=
X-Received: by 2002:a05:6830:1df6:: with SMTP id b22mr2444841otj.74.1590529070165;
 Tue, 26 May 2020 14:37:50 -0700 (PDT)
MIME-Version: 1.0
From:   Abdul Basit <axbasit@sigabort.com>
Date:   Tue, 26 May 2020 17:37:39 -0400
Message-ID: <CAEe9qsCzDiiBeyC20awJYJhjKh-pR6Y3KhUXggdOPj2yXqfWZg@mail.gmail.com>
Subject: nfsv4 referral using non-default port
To:     linux-nfs@vger.kernel.org
Cc:     Abdul Basit <axbasit@sigabort.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi

Looking into the NFS code it appears that NFSv4.x implementation does
not support referrals using non-default port i-e something other than
2049.
NFS server does not support it and client code always uses default
2049 to make a connection regardless of getting it from fs_location
attr.

Running NFS Ganesha as a server it can provide the correct port number
in server opaque data for fs_location but NFS Linux client code
appears to always use 2049 hence
the referral fails. I can provide the screenshot of the wireshark
trace for ganesha server.

Question: Is this simply a bug that needs to be fixed and no one asked
for it before? or is there any rationale behind this?

Thank you
-Abdul
