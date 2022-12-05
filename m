Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988ED642D9B
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Dec 2022 17:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbiLEQuQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 5 Dec 2022 11:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbiLEQtp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 5 Dec 2022 11:49:45 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C322ECE1
        for <linux-nfs@vger.kernel.org>; Mon,  5 Dec 2022 08:49:04 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id ay27-20020a05600c1e1b00b003d070f4060bso10531458wmb.2
        for <linux-nfs@vger.kernel.org>; Mon, 05 Dec 2022 08:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O4WPtqOs6pYDke8VCfpzwsIX+8zN33o8tLS2XMy/lFU=;
        b=Z2wBWagY9UnEZ+M5YPDdGkg6nVUsQfYS1BhjpcwGEao2GhG01+Mm/qvV+1fKOq1lbu
         EFS78qR+UGfEwXQVt6IRXk6jTGT8mo+KAwwjj0fZxBmjE1jztugOoJP4/rka0x6XFhxu
         W6iUCvsIDO6eHcdCHFvdIDlIVpJCsES5SD3xSnapoHClZmLcHlXbjXoeix+TX99ab7ry
         BqOOHDFzUlmJeyU3OvUitATOsPkFA0DOczbi/Afsjm9NHI/YtApk72ny0qjFhFTXO+XP
         yKXAtBeMHMlIwSKvmuRpEfOfWiK9b959mo8P7Fx64Ot+uHxQXUUrd10S+RG2s/yWLOX2
         BSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O4WPtqOs6pYDke8VCfpzwsIX+8zN33o8tLS2XMy/lFU=;
        b=sS7V/dX9y3e6hcKZ3VuGy7fUj1BODcoPEdMKwt9A63Q2fKN2HdkSPEONw91yjBt1mu
         pmYnBUeyvXPg58FWbc8Mf5V2IlonubvkLikDnSMHYFb0IvJ5n1UsVv2vueUTekIW9pd7
         XBO0Nypm8H4W6+/mTQI34CDp+yrmOslqvLNB5ZjVbxSqnF3bDdAIInzSnpc28g2LxdH5
         0MExfMefqoncxSrFCzGXL6vhjiBvUOTKjElCp3aEw0GYHuqCulw46VDxZMGLWZr7ji/O
         CESIpF5sptkx8dKLQzHCyOjuCujbU6bYPyF1/OZfNQcWw+BghncomGf6/sd6hT6NqtLB
         9Dbw==
X-Gm-Message-State: ANoB5pmdwh/Py1b62rcZZud7ctwP5ktYKiEpVAV24zQp7LG5t76XwAtc
        l0xh3kuq74hQS/oK2pQ/XhZykT4yWYDdo+phBJ0=
X-Google-Smtp-Source: AA0mqf6LlThRqxALxahU+d5CDCL5XgA0Iri4oQFEx6hETTBFBZxUw9iI5CXyM5b3WvWotoaM22oBvK+CwFtVO/zgxX4=
X-Received: by 2002:a7b:c8d0:0:b0:3cf:ca91:7094 with SMTP id
 f16-20020a7bc8d0000000b003cfca917094mr60628535wml.24.1670258943314; Mon, 05
 Dec 2022 08:49:03 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6000:5c1:0:0:0:0 with HTTP; Mon, 5 Dec 2022 08:49:02
 -0800 (PST)
Reply-To: phmanu14@hotmail.com
From:   Philip Manul <zagbamdjala@gmail.com>
Date:   Mon, 5 Dec 2022 08:49:02 -0800
Message-ID: <CAPCnorG0wZz4L65xmUUzHEvxvuhrsq0nQnSPJqno3Ah89AhSwA@mail.gmail.com>
Subject: REP:
To:     in <in@proposal.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=20
Guten tag,
Mein Name ist Philip Manul. Ich bin von Beruf Rechtsanwalt. Ich habe
einen verstorbenen Kunden, der zuf=C3=A4llig denselben Namen mit Ihnen
teilt. Ich habe alle Papierdokumente in meinem Besitz. Ihr Verwandter,
mein verstorbener Kunde, hat hier in meinem Land einen nicht
beanspruchten Fonds zur=C3=BCckgelassen. Ich warte auf Ihre Antwort zum
Verfahren.
Philip Manul.
