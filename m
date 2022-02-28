Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D184C600D
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 01:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiB1AFZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 27 Feb 2022 19:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiB1AFY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 27 Feb 2022 19:05:24 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3BA49F10
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 16:04:46 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id r10so12867297wrp.3
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 16:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=ixHVzoz696qN1Cmrg9x1bmR8vdWLOLbXCVjc9DtTLhI=;
        b=nbRsMrVxS+6GTIg5AYNnec9Cn3AKXYUocmpTfsIML1ub6Ljdp43vKcseNO/EgUTztk
         J8i/Hs7Gp6Obcpv1Ff9By5/3Bege4rNgpu/MW22OWkA4WApaBW0+GNIubjNUililAzSM
         ah6QmjSQSx79oZLF4Q881ITiQEfCH23rMs1q+gWtwl0c4NJQU/xPnGFDSdGD/jos/t7E
         sYT91/W3TgZdn7R+NyFmeNjdcH/xpNGBVjQ10IJ0KcGmp0AfzOtQAdbU0xCLujnGmgNy
         YHyl5z+PI5wQjeTvNlgH6pM1m2Acy4LrsJBuwXWtveixNDbx3FJCrI9h51ml8PzrWL/w
         Palg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=ixHVzoz696qN1Cmrg9x1bmR8vdWLOLbXCVjc9DtTLhI=;
        b=40218jRD55xeak5R6Q7IklNWleFOT0qgU4dzpbTzGLyGum63Ywm6iTjcrpPEOfLW94
         hqvOLzIcyjYcBUgn00R0Y2KQvB84IwtTqmzvBkIHPB5Yc1I7INUnkbRcr8Sy4LSAJO2D
         jCOz9qd2lib0gkizmMKTqRzGXZrLjHDSpJfYgokFGE5hVDXiC+i6R5rzbCYFS4JKu/HD
         xgO5pUYYLBRobkXRdSdPYPrT5oBxSFpUF+/ahQ8oZkQZabOW0DP1x6ItqQwPk4+x2DHS
         VAjg2FQeBmcqsOfbkG/N7ZB/weXZ6Nt+Y3Tr1On8tsRU/4UA5+P+OSXpS2MA8hPdPyz0
         PiRQ==
X-Gm-Message-State: AOAM532sch11nZZczEIozvFomvK1QuJyv5qiYX2KnYX2COobrtr74xov
        sdCFd3Wig7Gmdnf6iPn1qo4=
X-Google-Smtp-Source: ABdhPJx0JDgE9vy4No5zuvlJUhVz8hjgdxpphpgc0MyrKDv0tLW/r/ZxbvXPTNRb4ca8yHt11ZEBEw==
X-Received: by 2002:adf:c74d:0:b0:1ed:9ce9:752c with SMTP id b13-20020adfc74d000000b001ed9ce9752cmr14292561wrh.331.1646006685166;
        Sun, 27 Feb 2022 16:04:45 -0800 (PST)
Received: from [192.168.0.133] ([5.193.9.142])
        by smtp.gmail.com with ESMTPSA id m18-20020a5d56d2000000b001edc00dbeeasm8544255wrw.69.2022.02.27.16.04.41
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 27 Feb 2022 16:04:44 -0800 (PST)
Message-ID: <621c119c.1c69fb81.b8af3.b72d@mx.google.com>
From:   Mrs Maria Elisabeth Schaeffler <olondon73@gmail.com>
X-Google-Original-From: Mrs Maria Elisabeth Schaeffler
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Spende
To:     Recipients <Mrs@vger.kernel.org>
Date:   Mon, 28 Feb 2022 04:04:37 +0400
Reply-To: mariaeisaeth001@gmail.com
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,TO_MALFORMED,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hallo,

Ich bin Frau Maria Elisabeth Schaeffler, eine deutsche Wirtschaftsmagnatin,=
 Investorin und Philanthropin. Ich bin der Vorsitzende von Wipro Limited. I=
ch habe 25 Prozent meines pers=F6nlichen Verm=F6gens f=FCr wohlt=E4tige Zwe=
cke ausgegeben. Und ich habe auch versprochen zu geben
der Rest von 25% geht dieses Jahr 2021 an Einzelpersonen. Ich habe mich ent=
schlossen, Ihnen 1.500.000,00 Euro zu spenden. Wenn Sie an meiner Spende in=
teressiert sind, kontaktieren Sie mich f=FCr weitere Informationen.

Sie k=F6nnen auch =FCber den untenstehenden Link mehr =FCber mich lesen


https://en.wikipedia.org/wiki/Maria-Elisabeth_Schaeffler

Sch=F6ne Gr=FC=DFe
Gesch=E4ftsf=FChrer Wipro Limited
Maria-Elisabeth_Schaeffler
Email: mariaeisaeth001@gmail.com
