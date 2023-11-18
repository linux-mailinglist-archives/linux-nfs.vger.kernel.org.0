Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAC47EFDFA
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Nov 2023 07:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjKRGZ0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Nov 2023 01:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjKRGZZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Nov 2023 01:25:25 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DD710C4
        for <linux-nfs@vger.kernel.org>; Fri, 17 Nov 2023 22:25:22 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9d2e7726d5bso354103666b.0
        for <linux-nfs@vger.kernel.org>; Fri, 17 Nov 2023 22:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700288720; x=1700893520; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z6C64t2VJ8UOBBCZlTgMFqiFe+Kb8NN48a6QSMAdoP8=;
        b=JDP9eRBaPgpYQwdPIU0vU686qBij9ZzQREm+lUKHFVBNLczZvGuxEmMImz+YdlzETH
         3bg5SXgGA59j0J3H2FFIVTZXS2HVgl/1vLMN3zsReI76poBrKtwj5aNR1h6MBDfO+evf
         F/+ua+QF9wPa7pOjJ/ST24kbcfoFIJ1G9eQRS2kxGBx8lnMt+SelPrCMYPp+5lZfYnOf
         ArHVNccJc0orL+r8F0nYE5M7GU++ZrSbvFpLufxHiyNiuHG6b7dx4SstLpvUmO2JchH8
         SklxMeXY89DAu3M/7ivH7SyDvbxMsIcNnBaWnYzdFXedzNWb0UzU8sYThcK/bjKS3do5
         UPHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700288720; x=1700893520;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z6C64t2VJ8UOBBCZlTgMFqiFe+Kb8NN48a6QSMAdoP8=;
        b=OlCBsjIFi2J15iJcBFN54/JQz6fwSu+Tw/08oQ2DnKtc/oGobSRBA6K80iNTz4jQPn
         4920BCqpJXdQX459ODdXDkPCIXoTF4XavF6ea3zAAL7qSKgCbtpb4rakjzveUWh0G72+
         jhPTkDOcHob5+D1y7oihrk2R12mJOuXVjA8C59UlRgQ4NG5egmEvz0bwiw5kaZ30q/M/
         XrLpAkrP11/ZUe3yl113mgIqQRxB/tTbGxsYZ0xy/XqpYbCIoP/fYKASli/eWjPUmu+f
         vB/la4ub8FLpCnnmnRpJTqBgSVzJRvaesdLjWf5W7OXEIFFxN0PA8j51xwwEAt+ZKAuT
         dwaA==
X-Gm-Message-State: AOJu0YwqSPHz8IH/yWiYBDdIb2qrsTBItvoHH9uytSrArkrUivBBbe8b
        IJsPNQnHpDdwJ3qCHcRR44emyF3OwigOb4YR3SGZg1cf
X-Google-Smtp-Source: AGHT+IHBNjiMnvLI9SxO/iAgZ+Kv5mLdLn0FhJ6HXFUXah1J3K2CzKMQsIHL2prX/jhl66WxHH/Mx1KUdRxpa+UHUiA=
X-Received: by 2002:a17:906:a014:b0:9e8:de5e:911a with SMTP id
 p20-20020a170906a01400b009e8de5e911amr1041720ejy.73.1700288720387; Fri, 17
 Nov 2023 22:25:20 -0800 (PST)
MIME-Version: 1.0
From:   Cedric Blancher <cedric.blancher@gmail.com>
Date:   Sat, 18 Nov 2023 07:24:44 +0100
Message-ID: <CALXu0UdcCKBGR8FUSEeEMngKqwz98Xc2HFXnhX5i_1ioEiuaQg@mail.gmail.com>
Subject: How to set the NFSv4 "HIDDEN" attribute on Linux?
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Good morning!

NFSv4 has a "hidden" filesystem object attribute. How can I set that
on a Linux NFSv4 server, or in a filesystem exported on Linux via
NFSv4, so that the NFSv4 client gets this attribute for a file?

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur
