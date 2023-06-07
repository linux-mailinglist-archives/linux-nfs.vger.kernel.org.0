Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E187267B6
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jun 2023 19:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbjFGRqT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Jun 2023 13:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbjFGRqS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Jun 2023 13:46:18 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670701BFF
        for <linux-nfs@vger.kernel.org>; Wed,  7 Jun 2023 10:46:16 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 2adb3069b0e04-4f644dffd71so1001784e87.1
        for <linux-nfs@vger.kernel.org>; Wed, 07 Jun 2023 10:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686159974; x=1688751974;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8rp6ZHL5PmCeF04JU131WzURIZPiHL9lAqS/dpMLSvs=;
        b=InTpaeWT/+kUpI4fq3l/woKgeZPt3aVFZrxq+r3uV/hc8eWKhtB+YhO7LetLVtHFHH
         lsZu2FmlPcORDbrQ66sHg9VdX2VoakjjkB+cqbahqYOgJU+/q2ylCjVh2tBn532i2Jnk
         QUilZ9SxR4jhb7m7h2jG4MTRJuWA/As7lnerZ+8z7cbTtpekNUzRIWSrksv5N33Ybvxc
         nGrQJDzwD9KZlXd5ncEL34mTaNZ30qe2/C0Qo0EHxFKJverrx3cg9DBRLhUzwEKVWBmn
         AMx2mZhmdOHUPPRc/b+bwKvOzlIooO4olHxV2nR2mOvk9sxku8+iCmgLRCnarv4KcDhD
         PSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686159974; x=1688751974;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8rp6ZHL5PmCeF04JU131WzURIZPiHL9lAqS/dpMLSvs=;
        b=bPtsI14xMF7Ek35D4YWPAXXls9/imp+MnHxB3l5OkvqvwBaC+LeEeiJgDbcqxHkk4s
         LyRzTcdqX7Tz3rZaVcvyF/Lf8faOphmxB8SMTPy5p6SMLorsFlAJ0qAqXxaNciUqx98c
         CzLAchmtgV38LJ5FV+FL33nKV+68FHWx3gg/34EI2WLLZEq2ocP3ip6aeCDV0gltv/Qd
         lkx3xmqhpfvxPppY3Z8f0zvoSaVGXx9GEZkwyth+Q8+NK12NKM2MCVDXhdRLdOgOnGzB
         Hik3LcV3XB8IJ+4KC8q83TbyOLJobNOUiEDvVVL7PmZOTGUODqsstW6EwyODIl+dFjMC
         IH4g==
X-Gm-Message-State: AC+VfDyBUJVVV4Bh1Dc+OArrkJWYwqUPEizkdFvNyPxKp+y/yiX65Mnu
        3XlLM/bwVGvpxLjSkgssjsZegcGQvBuJ5hiaafk=
X-Google-Smtp-Source: ACHHUZ6BgWbxm8/sK7Fmr2auKqhtADoZSZRFbsezNyLp2BgIbvCJgx2eW15+AQUEZJIN+nCuFZNASCOFzhTOJO8DE2A=
X-Received: by 2002:a2e:b618:0:b0:2ab:bd1:93da with SMTP id
 r24-20020a2eb618000000b002ab0bd193damr2408446ljn.10.1686159974379; Wed, 07
 Jun 2023 10:46:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:3c02:0:b0:2b1:ead1:b545 with HTTP; Wed, 7 Jun 2023
 10:46:13 -0700 (PDT)
Reply-To: mrdanikouyate1965@gmail.com
From:   "Mr.Dani G Kouyate" <drsalifmusa800@gmail.com>
Date:   Wed, 7 Jun 2023 10:46:13 -0700
Message-ID: <CAOTALFO1uMQCWsqcWMt9Lu8TH-UOqjMFj6sjLZGUP7G=kM++nQ@mail.gmail.com>
Subject: READ AND REPLY
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MILLION_HUNDRED,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:144 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [drsalifmusa800[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [drsalifmusa800[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mrdanikouyate1965[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.9 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  0.2 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  1.3 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

My name is Mr. Dani G Kouyate, I=E2=80=99m from Ukrainian=E2=80=99 State. I=
=E2=80=99m
interested in investing in any good profitable yielding business and I
would appreciate any viable ideas you could come up with. I=E2=80=99m
proposing to invest the sum of $15.5m, Fifteen Million Five Hundred
Thousand Dollars)

I don=E2=80=99t know if you can be of help to me and trusted for this, I wi=
ll
give you more details once I receive your response.
Mr. Dani G Kouyate,
