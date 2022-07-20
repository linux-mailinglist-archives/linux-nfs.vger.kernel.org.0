Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FFE57BE09
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Jul 2022 20:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbiGTSrJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Jul 2022 14:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiGTSrJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Jul 2022 14:47:09 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D44D72EC9
        for <linux-nfs@vger.kernel.org>; Wed, 20 Jul 2022 11:47:08 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id r9so31730160lfp.10
        for <linux-nfs@vger.kernel.org>; Wed, 20 Jul 2022 11:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=JiBy/fr88DgKURawIAAsoW6DnbBMImuTQIFATprFxqQ=;
        b=b8fFsW+Rgsvep+WiIUol9u6eixPF1+JTKi8smdZu3YBoIfYsXeOyriWz6ExT1NPo1L
         upSTMWxOQdb3IXlw4AZrFp5SG83LgKd3cyuoD42K2dE0nzxlunh+IZPBi4S/nMw818Tv
         RaJkl1nX0fzknNB8Ls6J1/lB2r+xJ23MWn5WBvPnd1buh61YttWypxWJ13/r57/LSuGt
         qmaozmtGb7h4B4XxZD28etqYDRfF8+DGkdHl08EusEcCjrL33+j8dEVQcTijaFuMSW3o
         ng/Pn4uEjXuBsEm5iShP4G0rnflWhjPv9mK5p8kI1/zPYEetGorx6h2T/BFdcvhoGU1H
         ZC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=JiBy/fr88DgKURawIAAsoW6DnbBMImuTQIFATprFxqQ=;
        b=cwqZqzezMLC0Jk5vQvpdOfNygGoywTc7rMks5Bg1tihzTgJVeUEyTBypgM5OhtZBpL
         U9NtqcBY+63Y5KcHcQQ4GXAZMmG+e33flrWknZ5vf8L6+uy0vcEJRSTSaA+rVmsROYAZ
         vsWqx8iYEoxO0kp2fY9ez/tzTUf3+7OQbNwJ7VaKe4JmcPinfVJ01IUga5AJko2XGyup
         O6rw/EX15qLDMf6MLO29pYOYuNoYSvd40D7FA9f/0wH18h3pV+vHqoNEPqRQ5tV7RSvX
         8uvXmzK78JlF3CQfEl+2aDjcf6eDv0nqJCCBHNrlKv5tLVF/7c+xk35k6P9Er0T2iKi7
         ctkg==
X-Gm-Message-State: AJIora9lA5F6Cgs5Giv+D8/YsHEvLKdTQSTtjL0rLXGrIOAKFEV9MH6l
        w1rJ/VzNLyan6KEqt/KWqH/08bYGWACmbVV0RoP5VfYgZaQ=
X-Google-Smtp-Source: AGRyM1vQGYAfWAX5RL+qTjphLLgqR7QYNYlCpwT/usP7GKyN4YF5sKSSbACbQdGrmX5RyT5jA8sGCwsy05RIj+5hyBs=
X-Received: by 2002:a05:6512:a90:b0:488:943b:cb05 with SMTP id
 m16-20020a0565120a9000b00488943bcb05mr20914325lfu.56.1658342826021; Wed, 20
 Jul 2022 11:47:06 -0700 (PDT)
MIME-Version: 1.0
From:   Jan Kasiak <j.kasiak@gmail.com>
Date:   Wed, 20 Jul 2022 14:46:54 -0400
Message-ID: <CAD15GZd=sxsXiNmuN-FpRk3E_cKRF_CTLqxd5XJ4KhtON4XkPQ@mail.gmail.com>
Subject: NLM 4 Infinite Loop Bug
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi all,

I'm writing my own NFS client, and while trying to test it, I've come
across a way to get the lockd thread into an infinite loop and stop
accepting any new requests.

Kernel Version: Linux ubuntu-jammy 5.15.0-41-generic

The client is a python program, and it does not run rpcbind, NLM, etc...

I issue an NM_LOCK (procedure 22) request with block set to false, and
get a GRANTED reply.

I then issue a FREE_ALL (procedure 23) request, and the lockd thread
gets stuck in nlm_traverse_locks - it matches the host, calls
nlm_unlock_files, and then jumps to the again label, and repeats this
loop forever.

It's not clear to me who is supposed to unset the host from the lock?
Any pointers as to why there is a jump to again?

Thanks,
-Jan
