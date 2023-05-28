Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1AE17137E9
	for <lists+linux-nfs@lfdr.de>; Sun, 28 May 2023 07:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjE1F5k (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 28 May 2023 01:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjE1F5j (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 28 May 2023 01:57:39 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF20C7
        for <linux-nfs@vger.kernel.org>; Sat, 27 May 2023 22:57:38 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 38308e7fff4ca-2af225e5b4bso21898261fa.3
        for <linux-nfs@vger.kernel.org>; Sat, 27 May 2023 22:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685253456; x=1687845456;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18FYzqA4T6+l2CILnAmRATSQIJ/KHY5CmUYxEp4xBL4=;
        b=YUMRuR/mlJVOaLsuL+11uUvHonRdUex5L6wfelfJonX9RjlcKTT2E2Xva/EDTDZ2+O
         TmEcxGfByzG6zoEEaI9RHnY7CW+8eKFd1ARbJ0OFiP+mj1Y0otQIfgotzgGXAt19V9ra
         MoqKMjV9U57CSo05KhAj6dwj+fb++wY7skyEI+fEdCJ8dZ6o38x/lOEfUg9Tkki7fEmO
         2lE8ouLJxXc2yTxg0LuQsw1wBnuWnCKtyEPWt/yekDBD0qt5Ah6fB/otQxcy8j8xj4id
         kx4D02oyishDg72RazhnGElGCdOmYbvAheF5CjsS3tC8+LqBAf+BJEyrqfWg64dsv49P
         wJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685253456; x=1687845456;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=18FYzqA4T6+l2CILnAmRATSQIJ/KHY5CmUYxEp4xBL4=;
        b=lfij2m2T3atTbNOSZ0M5H0h8gLoHQ6Gw/tpu5314aNMGLX8/0ZhIV2p3Jbrfzq4t5x
         AThyEdmukAe3XD0glc97JJUU/HF/66pGF59uCyffFeFPpTf5pYdZSre6q/2uZbVVAM0w
         LGIq8NwAWjrgfP/JTyQaUj7KIJz7TCD9FhhK6kmf88kCipihTtibJtGoh0JlPHBbyE1s
         SSWBua2xDKT4Q1t86EWTTCpwOC6sQs9ABGK+fHWk5Kv2L0vyvqzzBMdm9U0mSVkJLl13
         nxy3cnVWidnAwoPiRsqBt1AsmQ2ch3zOb0OtwzfqNJ1b57fZ1ginPU4rC1LqkVJE/5wv
         ljUg==
X-Gm-Message-State: AC+VfDxZWFH6ZPamTqjnxzRWjVMgThCT7A/7peB/TRHWaTouThMmk4Rk
        qM2Y3HH2kh0EYnaJ+xtjTiLkuinpwgcGf20pWU4=
X-Google-Smtp-Source: ACHHUZ6CANU+R+5WFcaB0QzrLqQDpf0SKGUP+i7YD6lOdlp4RnF9fjiYhSBMbyxFMumJyjtHYeTIwh8H+jq0vP3mUas=
X-Received: by 2002:a2e:6a17:0:b0:2a9:f94f:d304 with SMTP id
 f23-20020a2e6a17000000b002a9f94fd304mr2872558ljc.19.1685253456041; Sat, 27
 May 2023 22:57:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6520:4c3:b0:25c:d94c:27d3 with HTTP; Sat, 27 May 2023
 22:57:35 -0700 (PDT)
Reply-To: uyhte122@gmail.com
From:   "John & Jason Adams" <johnmohr13f@gmail.com>
Date:   Sat, 27 May 2023 22:57:35 -0700
Message-ID: <CAM3BTdFz=gzXq6SMUYqV8uV6AHhWX=-gmUZPh8kmQkxiRGid=g@mail.gmail.com>
Subject: Inquiry About CIF/FOB Price List
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

-- 
Dear Client,

The South African government is looking for anyone who can competently
meet the requirements of this emergency and urgent tender to supply
this equipment/instrument in line with one of  your company's  product
categories shown on your website. We have been appointed as the
contract agency's angel investor to finance this project in four SADC
member states through the South African government: www.salga.org.za
Payment terms are 100% TT.

Kindly email us your catalog and price if your company has the market
potential to trade with the South African government. I appreciate
your cooperation with this request.

Regards
Mohr and Jason Adams
Mobile: +14084265778
