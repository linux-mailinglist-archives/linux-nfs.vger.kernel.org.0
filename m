Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B48F5B549F
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Sep 2022 08:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiILGkw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Sep 2022 02:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiILGkv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Sep 2022 02:40:51 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E24023BD2
        for <linux-nfs@vger.kernel.org>; Sun, 11 Sep 2022 23:40:49 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-3450990b0aeso88315467b3.12
        for <linux-nfs@vger.kernel.org>; Sun, 11 Sep 2022 23:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date;
        bh=93ghi4l8pMNtxXocmybwcVFaw2Qy/YsSmcGD+5j2BJM=;
        b=YK7Qdwz3w7G9HKaUcL+FIUfAIZBTZxXaj2PKuXHkw/rgz1NjCwAHQA9d2/CvKWT5WI
         x5G33ffzkw1tfDHYOBbbtBEsSftT0yawSkbKt9cDvMnkdw+qgt/0Nk1gCGh88JYPdHSv
         eS0uU72uq/5VsvfkxOlb56SANn2qlhxWkjKq+1TwP6seWVbTC12Yv/ONvZ0YmLCa92pZ
         DpINxMtIe9p+rqbGdWXnHgmjQzPU5erqrlWW2hf+rjUxTqOq2ppvS5GGN0NNFnhifTII
         NcWqUc51HSAMXbQG4j6bfcvd5QNJS0LI2jFXksleup+HCRQh383laNNV/5Jrk+nnqoiB
         JZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=93ghi4l8pMNtxXocmybwcVFaw2Qy/YsSmcGD+5j2BJM=;
        b=iYsy2m9t4RM6b/OHZHM8SHTrPwzW1/wDEQMNRddlN89YD3PQa1n2bKffw5UKnkZHhl
         AFPUQWTtu75syj09zZ2UFTW3YAygumkHZI/ipEd5/Kz0g8AoypbKLP5OL3ctnbZLszVy
         7hxfXVuzOCvUTINvhqGJ1X9/uAThc64iM9O4Pp7QmnHNzj9R0jAqFfgB5+AGVBYHzr2P
         rFdUqCwAsZsxY90Mr5+OfM4dg/VIiWP/2/onEyEq4J0R8MMmo2uIr0wDC9aHNgGfcJ5Y
         TB9CebE8HVELQyWUs4gT7pDUbNKTfmHkTS/ASUCpF/peieqfE96EjMXeIzYbpFG6PvKt
         /EVQ==
X-Gm-Message-State: ACgBeo279isQu5DTlBntTQfbOkyJZhwMG3qEvwlcQ0ZZIW1RTTMUB+LR
        PVZKRPUBmsi4XW/XqUxdphkT4QGlAvzW1Rvpmo4=
X-Google-Smtp-Source: AA6agR7mQwjiODk2s4phyv9Wwr2RjA4gDJd4/gxZA4NzWvgMhmUyW0WqCj0OgMM/PT9KEir7oePCHyW0X6UoYbBu+tA=
X-Received: by 2002:a81:7d45:0:b0:345:3855:e56 with SMTP id
 y66-20020a817d45000000b0034538550e56mr20769005ywc.27.1662964848441; Sun, 11
 Sep 2022 23:40:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:b58c:0:0:0:0 with HTTP; Sun, 11 Sep 2022 23:40:47
 -0700 (PDT)
Reply-To: dietmarhoppdonation86@aol.com
From:   spende <sadiqabatcha535@gmail.com>
Date:   Sun, 11 Sep 2022 23:40:47 -0700
Message-ID: <CABiTF=QuQDcAjYfft4P+=+TcOtcjstT4xZ2Y2RVVCuajjkOjAA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1133 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5152]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [sadiqabatcha535[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [dietmarhoppdonation86[at]aol.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [sadiqabatcha535[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  1.5 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  0.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=20
Gr=C3=BC=C3=9Fe, herzlichen Gl=C3=BCckwunsch, Sie wurden soeben angenommen,=
 eine
Spende von 1.200.000,00 Euro zu erhalten, f=C3=BCr weitere Informationen
antworten Sie bitte zur=C3=BCck
