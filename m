Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CE04B80F9
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Feb 2022 08:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiBPHH0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Feb 2022 02:07:26 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiBPHHZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Feb 2022 02:07:25 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52862C8C6A
        for <linux-nfs@vger.kernel.org>; Tue, 15 Feb 2022 23:06:37 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id v6-20020a05683024a600b005ac1754342fso952338ots.5
        for <linux-nfs@vger.kernel.org>; Tue, 15 Feb 2022 23:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=lStkJgqPNIm74m5PFcb5ov0JOOgwce0nMHo0QlooSyQ=;
        b=QryzrThaJ3b+V/TNybsYrr6CVRepN6bUHJ8nBx2E0huQC/0AAQ9ApNE2fH62lLEkEb
         0YOUU+UEZPUwHGQMEc4ONQoQCcwLPbfkVHtxgkyTtMs2rJi+LQBITwSUx/VJ5dx+q1Vw
         yKXxciGzI0yqkseTBTrZYB96qLA2GqJrOstfARU3sP1146SLTBBV32raoo6bFSYs9sn0
         A59t/rhpLr9FjICqSGSWo0R21ND8HnnFTgmsjYn+ob3Aj3yZyKO/vQluzHLWI4p/SMUd
         Za9YZioRccstUI9H8a/MOdr8WbcKDWAteXZIqEfoloBeNmVrnFeweCtQQHd1/EL3v0W0
         JAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=lStkJgqPNIm74m5PFcb5ov0JOOgwce0nMHo0QlooSyQ=;
        b=w/Ol9nqxClNvCHu7kIAX9TaNZ9gnfH9Ei8BkRvWsYjWAC1vnVQb9QtcgKTDuw7XM7e
         i/NR5R/tlqcd3345LP8A+jCazjr1rt6u+TPKBjcpXyypjHD9Hp88MMSSmqBUXFkybKQn
         pdffrM6Ux/RUpzftlNxha2A5YL6pRAk4JZ9lbKeLo6D/4RPoI6839XC/cV2vuXLW19vF
         XCcXyxx6FI6daYBoPOKyqRHHclUVu0sQRvy14yIPLjVDgROyCEs/OVmlQd8n1kjQNAtQ
         0U3xo4jhSFuWGDiUu1OW1AByl5dkxpROomKm4O2HMwi8UZKS938yMoXyD7YPtQDyxOy7
         9HVg==
X-Gm-Message-State: AOAM5318DDUcsL8v5rq9IXN6JCTZbd7NpH9KzMdr/z2m/jixkQSrUeHG
        lpSUoSegbS+OXJnlQPxx9JcX8EfONXPC84N40htGgT5GAjd5wWkj
X-Google-Smtp-Source: ABdhPJwR8GVtYbJ13tNXRvz+Uvihxs7BOACR0Aoq6f7DZ2sPBgW+fP2dfraRSLkXZdDaX1AoC3r76c1cMeNHdUN5kaI=
X-Received: by 2002:a25:820e:0:b0:61d:fe85:5ca3 with SMTP id
 q14-20020a25820e000000b0061dfe855ca3mr1037828ybk.212.1644993984917; Tue, 15
 Feb 2022 22:46:24 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7010:8da9:b0:208:e95c:8015 with HTTP; Tue, 15 Feb 2022
 22:46:24 -0800 (PST)
Reply-To: wbuffett1930@vipmail.hu
From:   Warren Buffett <wb29505@gmail.com>
Date:   Wed, 16 Feb 2022 07:46:24 +0100
Message-ID: <CAM34SHsWkrt_=uk-0UXW4x6fRZFD=JPnfx7=kqrDAtX8Q6UtFw@mail.gmail.com>
Subject: Congratulations to you
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Congratulations!

You have successfully been granted the cumulative sum of US$4.8
Million as family donation from Warren Edward Buffett, We decided to
give this amount to randomly selected of individuals worldwide to help
fight against poverty and COVID -19, your email was selected online
while searching for random.

Kindly get back to me at your earliest convenience so I know your
email is still valid, Thank you for accepting our family donation, we
are indeed grateful as we believe you will use the money wisely.

Regards,
Warren Edward Buffett
Investor, and philanthropist
