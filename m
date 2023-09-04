Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9AEE79159C
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Sep 2023 12:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjIDKS7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Sep 2023 06:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjIDKS6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Sep 2023 06:18:58 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C3C1B5
        for <linux-nfs@vger.kernel.org>; Mon,  4 Sep 2023 03:18:55 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-401d67434daso13722625e9.2
        for <linux-nfs@vger.kernel.org>; Mon, 04 Sep 2023 03:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693822733; x=1694427533; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YqoQwotzhMNaRU2qkT/+yRd7xaxRmvW/PXDwvubnW7I=;
        b=Tma/8Z5J35F0lsgiGpc1uBDabQqZxsWR2/70bdCrmipG53Vy6qz3m7l6Ns9loFOMTu
         YthxaAhSynDFZyNbnFviC5EbAq30EWgZOc/F4O7RTnAJTQ6aBljEy82gT/pQ6WfrwymF
         2kvd9ynng+UXJ2rhqz04Zh0yuFlalbd2GKRkiR/YNKv1EIzzu1rDYjn1ha1/1XJ6c9jJ
         k2TubPOhm2GH6tG6F0fxU5pPfba5FLVXQNgvtpUksc3WRs/sLfUPTkKi1w7Tsmrsmeb1
         Fp7hgEX2h6Vnzvr2oIRR6+qM7Qn1983QJrIsXW8Lknf8KKlViGAr2BGsTwMbDI3wR4bt
         EWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693822733; x=1694427533;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YqoQwotzhMNaRU2qkT/+yRd7xaxRmvW/PXDwvubnW7I=;
        b=co+opW6Ji71NyN6qxN/y/BNU8CExjoi3GDXsnMlO1dZeL4lU6MrjMJxssh22c1lC+4
         GrW4InAMd2UXRlC72jNQVdhaqe5YSa7OcBOPuvFkzYpZrEym3SIjfhx2bgul0Y865BbR
         eZhNHS5J6aZQ4XtBA2L4UR4gsSO4RgsK+CA7QtM/PwIEZZUiOBqjlMtdow8LQG/NlA1s
         +J+HNNVhyWlEKhWIV47BdC5SBJsr6lBo64TcIS7gIo3+LSiDJgW8YIcXdUJbCF2uhKNm
         x4MY5SvyVCc5bMAr5IgzImCP6spVeMBhnxDMI/wY8yAzvDjXcw5OqDBxEk7r+3I8PlDJ
         l3Ig==
X-Gm-Message-State: AOJu0YyFppJHh9ZzrBWCR+b13xS7CeJnX8M+r4YqwJyiiJFdnvx6paO7
        pTyh/U3UB+xD+79gubaWOKvPvRFkh4eW8t+Ak8A=
X-Google-Smtp-Source: AGHT+IFJby7vCb7MPhUt2fJZSRRaQoqKaKDL7gQRzQbvZTGmW6LH++rAQPgDsewBo3FZy3e1irB8ENwd8k+qFJ+dbBA=
X-Received: by 2002:a1c:7c19:0:b0:401:c0ef:c287 with SMTP id
 x25-20020a1c7c19000000b00401c0efc287mr6589642wmc.27.1693822733057; Mon, 04
 Sep 2023 03:18:53 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mrsnh001@gmail.com
Sender: hadjia.kadura@gmail.com
Received: by 2002:a5d:494c:0:b0:31a:e2af:8ad2 with HTTP; Mon, 4 Sep 2023
 03:18:52 -0700 (PDT)
From:   "Mrs. Holofcener" <001nicole.h@gmail.com>
Date:   Mon, 4 Sep 2023 11:18:52 +0100
X-Google-Sender-Auth: -Fc9enf3kJ7OHle1hP8Su5fna9A
Message-ID: <CAP5HwDbtR4haPOi2x7=1e91hRaaqi=ii6so1LZ3JTGLxxVizEw@mail.gmail.com>
Subject: Waiting to hear from you.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [2a00:1450:4864:20:0:0:0:334 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5556]
        *  0.7 FROM_STARTS_WITH_NUMS From: starts with several numbers
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mrsnh001[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [001nicole.h[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Good Day,

It's our pleasure communicating with you, I am Mrs. Nicole Holofcener
from the USA and I have been diagnosed with ovarian cancer for 2
years, I have a fund left in the bank which I want to donate to assist
the needy and to building an orphanage home for the less privilege,
please reply to me if you are willing to carry out the humanitarian
charity mission, it's very important I explain all in details to you
and you must assure me that 30% will be enough for you as your
share/gift, while the rest to of the 70% will be for the poor less
privilege and building of the orphanage homes.

Thanks for waiting to hear from you.

Yours sincerely,
Mrs. Nicole Holofcener.
Email: nicole.holo@yahoo.com
