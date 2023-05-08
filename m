Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2209C6FB2EB
	for <lists+linux-nfs@lfdr.de>; Mon,  8 May 2023 16:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235404AbjEHOak (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 May 2023 10:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbjEHOaJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 May 2023 10:30:09 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE037EF1
        for <linux-nfs@vger.kernel.org>; Mon,  8 May 2023 07:29:46 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f19323259dso46841315e9.3
        for <linux-nfs@vger.kernel.org>; Mon, 08 May 2023 07:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683556184; x=1686148184;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hUor3hnZlV6CjNv1XT2yupcGqO1CT/IUMKuxwy2d4BY=;
        b=a3JJVfp1vlOSFO7cUVXrHY8brqAsJkP+DihHSIV6ePrjyL6qwbaXQ2QQRAX3cosQzW
         cc05YH7IGKxha0KqGX5pCb6Z9RNQU4FlSjSQS1IQBnVswZ4bnJOzgBFsFr/YFbX6YB86
         1wMNJsynmq14ud1KKOAGmCLkgX3dQQ+gcrcwTl7liL0rLmYF/tABOx5d15/TCVpDbwDx
         76vXmUEwSobNTiwqxNtg0N3QMhdRhvvXxhaz8iX+VhrYxT4isyuqN6CpiXP53+GHu7M+
         poDc4YCwjhLiYeNNedygWPgsHthTUJyWnGqHHeFdp5x8a0lAVbAfaEGAR6ouKtrNJnMv
         jsKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683556184; x=1686148184;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hUor3hnZlV6CjNv1XT2yupcGqO1CT/IUMKuxwy2d4BY=;
        b=HT4Wkg6pODFreylP+yds7nhAompMH/pzXOytTPPLnxILPUh4CYqi+JUb4WiGbFse1r
         sjpVquwaIkRJqzhKHeb7h503U4RoFF7UjcLBTmFgjB1S2qJRBj0McbzV4/Z3TrxfFF4x
         MYhpWS/5Sz9dQZzGNHqadEqXm9I8BKo09NeVdLyjCzKGe8Ez3iFsITnrAAJqFSc/nyRL
         lhDkZO5bKDsRwttaeNCZF+rCoK2EaLfLTWURIJYqCFK+DVx9QvyryFeS9drxWCMS5kDX
         L2dfNk/+Qlyvylxag0ezz3oV9nR45FZbiT50YYd4pK+3dvXDlpIpALad43Lb39UJsn37
         9M8Q==
X-Gm-Message-State: AC+VfDw8ACEY5//k9ckPwhdjdcvPJW9l++7BMyNNdE7CxLxNve0ktFLo
        gmSbQaQZYuIgfbbIRd19td7NA3EnBTVGQf01dgM=
X-Google-Smtp-Source: ACHHUZ5tFC4Upq8+BMRe1mhCQabZOBDzRCVGWu9Cnqoh7fuga/3WHyjwVVDANytpXs4vPhoGohTk20Q2nAQOLVyfbLk=
X-Received: by 2002:a7b:cc15:0:b0:3f0:9564:f4f6 with SMTP id
 f21-20020a7bcc15000000b003f09564f4f6mr6832933wmh.1.1683556184311; Mon, 08 May
 2023 07:29:44 -0700 (PDT)
MIME-Version: 1.0
Sender: rev.john.koffi2@gmail.com
Received: by 2002:a5d:684b:0:b0:307:95b2:be01 with HTTP; Mon, 8 May 2023
 07:29:43 -0700 (PDT)
From:   Sandrina Omaru <sandrina.omaru2022@gmail.com>
Date:   Mon, 8 May 2023 16:29:43 +0200
X-Google-Sender-Auth: vZyXBWTw0GwrSvQbT0O_RVnDG_0
Message-ID: <CAF9xu2SqS4u4RipVUqD8FD+hHF2Kco6VW4esX24dOv30t0xxOA@mail.gmail.com>
Subject: Hello Dearest,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.7 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:32c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [rev.john.koffi2[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [sandrina.omaru2022[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello Dearest,

I deep it a respect and humble submission, I beg to state the
following few lines for your kind consideration, I hope you will spare
some of your valuable minutes to read the following appeal with
sympathetic mind. I must confess that it is with great hopes, joy and
enthusiasm that I write you this email which I know and believe by
faith that it must surely find you in good condition of health.

My name is Sandrina Omaru; I am the only child of my late parents
Chief. Mr. Williams Omaru. My father was a highly reputable business
magnet who operated in the capital of Ivory Coast during his days.

It is sad to say that he passed away mysteriously in France during one
of his business trips abroad Though his sudden death was linked or
rather suspected to have been masterminded by an uncle of mine who
travelled with him at that time. But God knows the truth! My mother
died when I was just 6yrs old, and since then my father took me so
special.

Before the death of my father, he called me and informed me that he
has the sum of Three Million, Six Hundred thousand
Euro.(=E2=82=AC3,600,000.00) he deposited in a private Bank here in Abidjan
Cote D'Ivoire.. He told me that he deposited the money in my name, and
also gave me all the necessary legal documents regarding to this
deposit with the Bank,

I am just 22 years old and a university undergraduate and really don't
know what to do. Now I want an honest and GOD fearing partner overseas
who I can transfer this money with his assistance and after the
transaction I will come and reside permanently in your country till
such a time that it will be convenient for me to return back home if I
so desire. This is because I have suffered a lot of set backs as a
result of incessant political crisis here in Ivory coast.

The death of my father actually brought sorrow to my life. I also want
to invest the fund under your care because I am ignorant of business
world. I am in a sincere desire of your humble assistance in these
regards.Your suggestions and ideas will be highly regarded.

Please, consider this and get back to me as soon as possible.
Immediately I confirm your willingness, I will send to you my Picture
and also inform you more details involved in this matter.

Kind Regards,

Sandrina Omaru.
