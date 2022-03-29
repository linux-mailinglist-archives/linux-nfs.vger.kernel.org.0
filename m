Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166204EB5CE
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Mar 2022 00:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236718AbiC2WV1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Mar 2022 18:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236825AbiC2WV0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Mar 2022 18:21:26 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFA35D5E0
        for <linux-nfs@vger.kernel.org>; Tue, 29 Mar 2022 15:19:37 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id r7so11176170wmq.2
        for <linux-nfs@vger.kernel.org>; Tue, 29 Mar 2022 15:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:mime-version:content-transfer-encoding
         :content-description:subject:to:from:date:reply-to;
        bh=+v//v9bV1cKxYYqp6E5HrJfuFydY/JXcjMGnmfr7lM0=;
        b=WQ7pQ/gRixwOZ8GKV+qSOpEES18l19LT+/PdblsMXwhg8KqMHuDCUQ5ia0XnhTCNeC
         gLj+FuV1QNr6/c34fBs3GVIA93ZzSPai9T1s1xZRnM8t+gHDyAfk1SaT9L8rdNl+ANhS
         q46mBEhenvQx9fQxlcwy4qvAss4SeYZq/AfAu1mfGH7rSni0KeyVwvMGrfbHsLnLD41D
         QYnjLKj1pmuWuH8qgTEZH41BdHdnAwn3KJuEkay0aTa/voX+SV6NplXgskfiwia7SNbx
         bM1n9Ia2dylUKuwVvE7zCLTghpDuZjIvqvdgGhkBbKo4UJf+JPbJNIbUVdAa59IT4X5E
         LcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:content-description:subject:to:from:date
         :reply-to;
        bh=+v//v9bV1cKxYYqp6E5HrJfuFydY/JXcjMGnmfr7lM0=;
        b=sJbfsJBv8gOYk5Eo+HJRvOTKbys+uFXXgQ0SYvr/WqDJ3GBQfkjWJ302gwjmaqeEHL
         DX+0GTEfyZeqI4zJpJURSQq04/NAeDawRjJkawKMv0NEn6OU5+hGrfMZW8snjp/6GOFz
         sgTljHb6ZjQEtDY2nijWkBoDbG4FwX+LlAvSTmS4idmYlwrwJx47eHAvO5thf/kh5w4g
         PzYhTp6wsV5/QsO2IPqnnGhh/6MpRyN2ePxYpe7TnwX3cUoF7MH+AQPy0lyh2RLCrUrp
         ZJ/eFoJ4vAi63pkKvwQT6qTX38paFelPy3NUQtJyAvsYiGkHPD5mddks+8JnlxWBAvki
         SJnA==
X-Gm-Message-State: AOAM533tLiG8/PelD6IdkY2szAe85L5o52LNjsJRGaAzGKshNrY+ya4s
        M461YKj16SMgwHt+dfuIL+U=
X-Google-Smtp-Source: ABdhPJyDnWgHbbnhc+AX4Z4hRW+vkAiLO9Lve4DeYUpyR/8lENtZ2rqRbduRvgYPQiGA9MenfuR96w==
X-Received: by 2002:a05:600c:198f:b0:38c:a9e9:754a with SMTP id t15-20020a05600c198f00b0038ca9e9754amr1574382wmq.146.1648592375670;
        Tue, 29 Mar 2022 15:19:35 -0700 (PDT)
Received: from [172.20.10.4] ([197.210.71.189])
        by smtp.gmail.com with ESMTPSA id x3-20020a5d6b43000000b001e317fb86ecsm15642619wrw.57.2022.03.29.15.19.30
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 29 Mar 2022 15:19:34 -0700 (PDT)
Message-ID: <624385f6.1c69fb81.af85d.d5d6@mx.google.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Gefeliciteerd, er is geld aan je gedoneerd
To:     Recipients <adeboyejofolashade55@gmail.com>
From:   adeboyejofolashade55@gmail.com
Date:   Tue, 29 Mar 2022 23:19:23 +0100
Reply-To: mike.weirsky.foundation003@gmail.com
X-Spam-Status: No, score=2.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_US_DOLLARS_3
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Beste begunstigde,

 Je hebt een liefdadigheidsdonatie van ($ 10.000.000,00) van Mr. Mike Weirs=
ky, een winnaar van een powerball-jackpotloterij van $ 273 miljoen.  Ik don=
eer aan 5 willekeurige personen als je deze e-mail ontvangt, dan is je e-ma=
il geselecteerd na een spin-ball. Ik heb vrijwillig besloten om het bedrag =
van $ 10 miljoen USD aan jou te doneren als een van de geselecteerde 5, om =
mijn winst te verifi=EBren
 =

  Vriendelijk antwoord op: mike.weirsky.foundation003@gmail.com
 Voor uw claim.
