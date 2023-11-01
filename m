Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C587DDE96
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Nov 2023 10:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjKAJk3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Nov 2023 05:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjKAJk3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Nov 2023 05:40:29 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6966DB
        for <linux-nfs@vger.kernel.org>; Wed,  1 Nov 2023 02:40:26 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1dc9c2b2b79so2977977fac.0
        for <linux-nfs@vger.kernel.org>; Wed, 01 Nov 2023 02:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698831626; x=1699436426; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=azeGzuh7l1LOuR52v7MVURnLEuWp8lU2DGqNMX3vXsY=;
        b=K9OSTJjlJMfroA5lSsbPs8XHLrM+xsWQFJ4ukL75lGcJnRfGgQIfxgVCXrficeK4l7
         H0OWnXzru8Axp3M3keAhGIT6imjjs58X1v9X3fbZmuQ3/6yUmSMlWQWQ5cxskRsBoNWv
         BmQDJ4+zqFbc2ckP8NJK+mkHH8mXk6zVdVgy+X4zHxXmxMFso+P9vr6jS6btffVWrYp+
         EWgKheUeXM571Vh+6uISYgMJ1KgAJ+r+XCIoDBY4KpCrtVQuq8aN8B07bTGPM+3LVh/q
         G1aPzDx/3C0ukqKpDH/BkExflEd3YhF3KuyjpNBMjtVFH3cDA6G2W3KGDoNOjQidKsQg
         MDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698831626; x=1699436426;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=azeGzuh7l1LOuR52v7MVURnLEuWp8lU2DGqNMX3vXsY=;
        b=XCC9IFDPofavgYfNErBWDCF4wbQkvFQwHBUMldluzS+kPpZ/Nyy4335z0mu8p1U3ca
         GhoNUHiBbbVS26op3pFz6oyGJ2Z5sdTzrrMUQXB/OwNVPnczzRl/q209VPGVKLg1sXx8
         C1jxrN5/zzP7W+xcXymlnUCErNdnv80eUGxh91U7ZFh7k5LDYEaqTYNILQEU5siLmG2R
         GbHuMD3uYeqjti9STBpW62UYkxO1rV5erVNTMYaNeVefu+qKisojvWq6HdSKq5Quil/v
         n9oPTZjGvxgjYqxsoQpt0WRxuHo4QV++icZ11y7b6/nYyikar7E1PEnBGW/vyA7IXCKG
         CUaA==
X-Gm-Message-State: AOJu0YzciQ3mzGp5dTw83NFPtXxdVO55rWyrzVLIne1zrM1uDlHamRwM
        GTEdnQ/FDcNlKvKaZUlvQsCWbY7ltsowkNVICAqraqbs
X-Google-Smtp-Source: AGHT+IGMGbR9MYNEoXegIkZpoNP9TrEWQOIK/s8Gp+IDz1+kdvH0KpL/pduNqhJjwO8nmeu9+zzZtLRrB/n+isqYDjo=
X-Received: by 2002:a05:6870:10cf:b0:1ea:f1a5:51f6 with SMTP id
 15-20020a05687010cf00b001eaf1a551f6mr13164333oar.0.1698831625687; Wed, 01 Nov
 2023 02:40:25 -0700 (PDT)
MIME-Version: 1.0
From:   Martin Wege <martin.l.wege@gmail.com>
Date:   Wed, 1 Nov 2023 10:40:14 +0100
Message-ID: <CANH4o6MYtA60MJ6=4Gg3ApzpZ42TzQiD13g1EE9OXkyM+8_Ssg@mail.gmail.com>
Subject: Linux NFSv4 client maintainer?
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Good morning!

Who is the NFSv4 client maintainer these days?

Thanks,
Martin
