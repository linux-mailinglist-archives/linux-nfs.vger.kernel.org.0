Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB2753F712
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jun 2022 09:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbiFGHWq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Jun 2022 03:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237594AbiFGHWq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Jun 2022 03:22:46 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF65217ABE
        for <linux-nfs@vger.kernel.org>; Tue,  7 Jun 2022 00:22:44 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id z7so21731840edm.13
        for <linux-nfs@vger.kernel.org>; Tue, 07 Jun 2022 00:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=OHbou33WPhW0PDy9/CZae9mIrL4buN3/FALSld4obAM=;
        b=lv9PTbuSv56tx5HgyywnNYRnQv5swfyd5P5s282FiotNed9XVJXspvz6bz8EIjZSuE
         NLd0JFZp8982ocfg/zPt2iKi9KpBY6WzO10uj+0MumtJg2QVk937WIEAEnttP8jPD9/Y
         0tBkfMEgxZVmAEbknrxwT+gXsomzENGMUXiucYk72ENoP/hI0TjSIFvpKu+MNLFCe+zZ
         n5GMMpLWbaTIktb0b419LGNHyvxJm3vz6a2fqy+xSl1zqAc3FMdsSPPtb8O3r5gPEOa6
         2HhQY+dBQtWZ7mCNNYNAbtMuY+1Bpud32tgI8tllGyaYdZvgihC5T4UBf3zHimU5OSGZ
         TMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=OHbou33WPhW0PDy9/CZae9mIrL4buN3/FALSld4obAM=;
        b=S4KAkPP6KtfY2nNxFrldLEPh4LZI/+Hz9+CP5KYI7BWgmQYB81s1RnQsMAuiNJOiwG
         QDLmGCR7dxddZivhMe99o0FITU6p0uQgtE8n/rb49FK3pf/Nk/XGe2TWR1CTzeyqZ/nH
         iDFylc96Snpdr/qujKwUS5oCP2gWnoWxCjX0c3RkSilN6tCu3skBqzel+t5P+nShUKL6
         mYSx4vKLat4htP10bc2cS2Bqls95tBvZ/IOhYdGHFQM9PnsK2OUECqC39LUzNoXvRCdP
         4PfOOrUHZfhykbwIvPc9+X7SJag5PVele2shQj97h2ixfweaIDo5+TrHp3Iz3dJj7EQB
         JBFA==
X-Gm-Message-State: AOAM532GYbu9jdeIXHJ9S+6o377bMH6AqGI/F6c1vOhnWAmBTk0EiMK3
        YWRZCS08gPb66WvfdM4i2QmX6BskLqZmkLEGbGs=
X-Google-Smtp-Source: ABdhPJyoUIGhN6gl16ZlVFKf4ecv+pDlHmwd5/j9V0vTW6f78ls4sOXnCX4KhDCiiutfp69wU00Jq3iRGSoINev115U=
X-Received: by 2002:aa7:db8d:0:b0:42e:1cbc:5e28 with SMTP id
 u13-20020aa7db8d000000b0042e1cbc5e28mr27523543edt.366.1654586563440; Tue, 07
 Jun 2022 00:22:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6402:26c8:0:0:0:0 with HTTP; Tue, 7 Jun 2022 00:22:42
 -0700 (PDT)
Reply-To: andyhalford22@gmail.com
From:   Andy Halford <fameyemrf@gmail.com>
Date:   Tue, 7 Jun 2022 00:22:42 -0700
Message-ID: <CAATdNasdUagDd7AYTHH6yErxgmpL-Ri=+vHuUu78xzHc-Nt6og@mail.gmail.com>
Subject: Dear Friend
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.8 required=5.0 tests=BAYES_50,DEAR_FRIEND,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:544 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [fameyemrf[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [andyhalford22[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  2.6 DEAR_FRIEND BODY: Dear Friend? That's not very dear!
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.3 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

-- 
Hello Sir



  I am Andy Halford from London, UK. Nice to meet you. Sorry for the
inconvenience it's because of the time difference. I contacted you
specifically regarding an important piece of information I intend
sharing with you that will be of interest to you. Having gone through
an intelligent methodical search, I decided to specifically contact
you hoping that you will find this information useful. Kindly confirm
I got the correct email by replying via same email to ensure I don't
send the information to the wrong person.



REGARDS
Andy Halford
