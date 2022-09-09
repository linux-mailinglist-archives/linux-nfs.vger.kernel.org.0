Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58D25B2EC6
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Sep 2022 08:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiIIGYt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 9 Sep 2022 02:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiIIGYs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 9 Sep 2022 02:24:48 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08348220FA
        for <linux-nfs@vger.kernel.org>; Thu,  8 Sep 2022 23:24:43 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso484780otb.6
        for <linux-nfs@vger.kernel.org>; Thu, 08 Sep 2022 23:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=ZwPxd8LtjEuPX3lP8M/ewsRzKiwOr4k1fCds3gC7Jk4=;
        b=WcH6UHGbsWFkewU/wT0fJawZxX15Zl4hkDGkeADuGdJGmv3t1iQNtgSoMnFwdIiKsl
         x0SFF8bkohRdk9mKGKM+s9gauDKjJXrvYE2yTKQmchoZQEeCIon6bMdclwr30NYYePtN
         LlWsahNYX+ZnmYtHuo+L3HiSHKxAxOAJsjY/zT5bRdtKkslqggYR6PeuSVU/Upq3p6Lx
         v7+3Sl0ycmpNJAkDyyfB3vDmj0Ku1DLMT5UNXcPYiD+ne677L4tBdx+wZ+UEyMq3qhuC
         L3qiWtmRltydGdTH8yRtHUUCoYBmNYblSu9kOey2R0GaJCd4zJFwUrFzR3gFC4Ma5YBK
         ywXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ZwPxd8LtjEuPX3lP8M/ewsRzKiwOr4k1fCds3gC7Jk4=;
        b=U4pouLFkfLIEwXA71Rv0DSsJGwfqGGcxYxjOcDNQ/QOrNBe55Mr8VwBh7YzzdM/O2r
         c+pTEBOUYS+LqF0HnfJ/FzhIBOqvGMyctBxWcPeELwifdY4h8Qbx3u+3KEYfsE5kzxb9
         SZUvaeR2H10qSBBtzPKqr/A+OBAptxZO+y3M+ynlSc7Yau2/SdajZ+lNa3Jn7isrr5uh
         QlabpfbB2gm2dIkY2Y2MntE4B9VI+2bjCgHdfzrJjJxWKNDrsMGGemxiiSJiEEsLIL7/
         Vir2fzypJL1LC0rTBLhkIpf+QhHShx3NvVRzeNWskHJDXcqZKcHSFC2fokvPGUpDJOf8
         uuxA==
X-Gm-Message-State: ACgBeo3eC/rXC+7rvdNVtlKK2HKyTcv0Gcu+nCf77KtxlNxYZeCcAeSv
        lFLKhtz4Yi/wF4ibAAe77otOHPMpXNtjKjVjiyA=
X-Google-Smtp-Source: AA6agR5oQwYexb5IuYa5dQgOTrJVTByrVtuS9dapD7VlJ47FKqY17GiN0xDTC5NddRnxIwHXasBmKTYYBxKZ43rAUg0=
X-Received: by 2002:a9d:6e0e:0:b0:652:6ed2:eb83 with SMTP id
 e14-20020a9d6e0e000000b006526ed2eb83mr3789515otr.308.1662704682511; Thu, 08
 Sep 2022 23:24:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:c27:b0:bc:944f:7c4e with HTTP; Thu, 8 Sep 2022
 23:24:42 -0700 (PDT)
Reply-To: stefanopessina14@gmail.com
From:   Stefano Pessina <prniceugochukwu@gmail.com>
Date:   Thu, 8 Sep 2022 23:24:42 -0700
Message-ID: <CA+eeEkAUSxvd2fRt0O=B0KtG8hzLpcviCGXBvO_1bui7P5TghQ@mail.gmail.com>
Subject: Donation
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:344 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [stefanopessina14[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [prniceugochukwu[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  0.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

-- 
I am Stefano Pessina, an  Italian business tycoon, investor, and
philanthropist. the vice chairman, chief executive officer (CEO), and
the single largest shareholder of Walgreens Boots Alliance. I gave
away 25 percent of my personal wealth to charity. And I also pledged
to give away the rest of 25% this year 2022 to Individuals.. I have
decided to donate $2,200,000.00 to you. If you are interested in my
donation, do contact me for more info
