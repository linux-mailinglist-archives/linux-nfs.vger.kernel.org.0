Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECF3582456
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Jul 2022 12:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiG0Kah (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Jul 2022 06:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbiG0Kaf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Jul 2022 06:30:35 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136BFB497
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 03:30:35 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 70so15772006pfx.1
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 03:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=O28LB3VJeo/kKOVhLcFL4DSdRmxftwkXFxjSliaVTfs=;
        b=VCMubn+Xlb/DmCZl2pGfF9KDt7HzEd0+ho4I91ni8fm+vPUvS6t9f4gChhQbNl3DQ8
         sDVuWE7BL3YtPLf2KPfUHChSA5UeLQ0JwD4XNvaGib2L6RAyDo+hz8iF5j8bfqXJ3CKR
         dbku8UqFZUzYRXTV+JdVChpRVz7nFnINmmKv4g/jUVMRvl/K6xI59fgQAj2qf/DeLA+X
         nHt8H13nF/zUmt1ijGKMlcj6zJ9JW1UtMW0cCB/NnHUjsgM3R0VBbClfkcxee7I8JbRe
         mKbWpTGVXrcFig2I++FTLDtJAm35uSQYD4qSmHDx45bBRHwArbul6l3cjPSBnbHbfqkO
         b4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=O28LB3VJeo/kKOVhLcFL4DSdRmxftwkXFxjSliaVTfs=;
        b=JEY3PxUbHOm1wDHp18eHmrp02L8QMuxr03CzVv/bipwVXS3efuqiBAliedCwrxb30a
         FKWK6zehyrdncJsfZhKQnPie4ZsWlTeAYI02oaNn4oW8uynyy3kX0Z8lLCCYa2SDePOg
         26WC+3UCTFuav5RYeLpN9ssAn21XvkURHjknUhuhx4qzM5kcpSMEdL1YolxN8JN2UTPO
         jiG55Spx33CRQw66vD0BGFUhfH7FNE2i0n94ihvYqFkITvR5S4Xh3GwoLdfooqbqvDB4
         wk6PaakeamofOrEUNpqFNCcqW+KBhHr/k2YIrydYAfCFtHvUOIMO8nyEhwL8f9rp9Dla
         q4Zw==
X-Gm-Message-State: AJIora+3NSYKzujGtt8fpVwFwNzTc9qsF8taQuh7zINPrK+Zw9wheK+u
        pW5ZYwglWrQg/4+jzm4lpNUJQxQFXWyh16I8VRM=
X-Google-Smtp-Source: AGRyM1t0VEyMEulxgRmqaTe8AK4wZHpcHICTYgA1mWDjd1k04IxO9JEosrkFWpHM3iluRXvssG4na7EAtgZ8Nx4z18o=
X-Received: by 2002:a63:8a42:0:b0:41a:8419:4e4a with SMTP id
 y63-20020a638a42000000b0041a84194e4amr18951562pgd.534.1658917834196; Wed, 27
 Jul 2022 03:30:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7022:419d:b0:42:ce88:5865 with HTTP; Wed, 27 Jul 2022
 03:30:33 -0700 (PDT)
Reply-To: keenjr73@gmail.com
From:   "Keen J. Richardson" <kuntemrjoshua@gmail.com>
Date:   Wed, 27 Jul 2022 10:30:33 +0000
Message-ID: <CAFhr1xC30S3prMtmUZOJh0H3v=R4kA4tgJ3LFRcGj0dW0MSgXw@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

-- 
A mail was sent to you sometime last week with the expectation of
having a return mail from you but to my surprise you never bothered to replied.
Kindly reply for further explanations.

Respectfully yours,
Keen J. Richardson
