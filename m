Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2493B607940
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Oct 2022 16:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiJUOKD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Oct 2022 10:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiJUOKB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Oct 2022 10:10:01 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2DA4E18F
        for <linux-nfs@vger.kernel.org>; Fri, 21 Oct 2022 07:09:50 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id a13so6399411edj.0
        for <linux-nfs@vger.kernel.org>; Fri, 21 Oct 2022 07:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=SpQxrppC0nW13OTdQP89OwPOpEznB78xxNiAXpsnhu8=;
        b=T8TfSQKDwTb3mo0d1gl49YVhY1TT+MwdfvWPtvrOR9bxZa79w72yvxReVEbo7SxOyA
         +EcEjQuDlBfC0Kz4zb9Kw6iZQ8eHQLaKWCiXLfsKO2brSb3u/3tqFPFHXWpZkc1mJTgs
         Ga3wUhSyGY+E/uILwAEbkyMy+ykEELltNe8XEciKZWkce8LSB6yAfdr0TTOLCrXURtGR
         riZGxCPfLvzeJSAHX34v9TWpH/ojQF/0h8HV7QpKi/MDgH2rEpEJlZB5dAOzpzHyvrgp
         AN3gTylqug3/cgGo8pl0UGk4/e/G/NRRnFfBtTJI9yl8dLOSzXkn0DqiOdyp7lNQ6enI
         6fGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SpQxrppC0nW13OTdQP89OwPOpEznB78xxNiAXpsnhu8=;
        b=PRYrUJ8RHKrP46vtWSBHp/uktLXUmXRODkfxfY2PJnxxkCYShUYHo0NEBnAZ+C4kAB
         K96O0q+n5fEWJDmrXjefLfqrHqIbJnmbX9kZOuZ/G5n4Ikiyypx7U2WgzaeBCnT9sQWF
         cXYTBSxpKmzMzvor7CR0uqIXaf9aiz3kABPYZzQVotjgojOuB5I/iMi2jYsNTK97JQMe
         yXjTVeEbV0NVzCL5WPQfa/74Cc/1nVMuXBQvNT+PWnkVgnpEDwLv+OUiHUFfygRL0bUx
         +ZCJs5mkAZcnqC8KvzjX4oqTOg60Aq4+k2SfN574dmJuTVkQUL0AK5ULWrBOh0RGfnED
         F22w==
X-Gm-Message-State: ACrzQf0vBDyk8kxCTvkYUO9sxGjWlTvW8ck/Bozyqau6iG4JTn1ANvoU
        xqj9XhLLLQzv0pNmOpZEHTw=
X-Google-Smtp-Source: AMsMyM7NXUPMpucyUJ82lEyIO2E8xy8TERJVHvn8RJYu8ORSWol78ZqRdr05RvC5oGTvYO0ChLdf9A==
X-Received: by 2002:a05:6402:3806:b0:450:bad8:8cd5 with SMTP id es6-20020a056402380600b00450bad88cd5mr18057625edb.305.1666361389390;
        Fri, 21 Oct 2022 07:09:49 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906211200b00780b1979adesm11645621ejt.218.2022.10.21.07.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 07:09:48 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id CC9F9BE2DE0; Fri, 21 Oct 2022 16:09:47 +0200 (CEST)
Date:   Fri, 21 Oct 2022 16:09:47 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     NeilBrown <neilb@suse.de>, Steve Dickson <steved@redhat.com>,
        linux-nfs@vger.kernel.org
Subject: systemd/50-nfs.conf and interoperability issue with intramfs-tools
 not including sunrpc into initrd
Message-ID: <Y1KoKwu88PulcokW@eldamar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Neil, hi Steve,

In Debian for the update including the systemd/50-nfs.conf there was a
report that sunrpc is not included anymore in the initrd through the
initramfs-tools hooks. 

The report is at https://bugs.debian.org/1022172

As we would not start to diverge again from nfs-utils upstream and
keep in sync with upstream as much as possible I would like to retain
whatever is from nfs-utils upstream downstream as well.

Marco d'Intri suggested there three possible solutions, of which one
could be done in nfs-utils (whereas the other two are either in kmod
upstream or initramfs-tools upstream). The nfs-utils one would be to
replace the modprobe configuration with a set of udev rules instead.

What do you think?

Regards,
Salvatore
