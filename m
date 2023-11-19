Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CACB37F0829
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Nov 2023 18:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjKSRic (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Nov 2023 12:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbjKSRib (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Nov 2023 12:38:31 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD6311A
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 09:38:27 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5440f25dcc7so5179224a12.0
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 09:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700415505; x=1701020305; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rLNEOgya0tLef8peYQm5o//Xh/5RPh6e0mHQzjAPOf0=;
        b=MAxN10TLR18vwZoLBKy6PU3LJTwBPmEVcSPgNJH4f+/18wQRtxT8ixWXj7zt0u3GjH
         j5jIYSY6yBIe+y/z5jKbxv7NuksumRKbIUU5mFW0gQgk/HE3YPprcg0+Bhlb0h56ZKMX
         +eUfCTD3iD/lUUbgetGuoe+Qz1WHg+9M1A550pT0lgnbk7/71cMM/Qd15menRBjoNQF0
         7liFQi1Af4OzI2nOukvt9TBBK5BdmDQ17llwCoSi4cdD1xe9NhcTXrJb6mnYfhfz27Eh
         H8Arjsb7Xc1/6FLW0SAAoe5E6I61kM1fbO/POJmgoUXvSR4uTKYURqN1w8P2Ao6xWhej
         xwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700415505; x=1701020305;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rLNEOgya0tLef8peYQm5o//Xh/5RPh6e0mHQzjAPOf0=;
        b=LvJqrwLF8okf8oGb2RIk/KFey5HmPrbgg3yHhwlAs/p0gQmqJp3PvUXXmrHs6bh4RX
         9moHL9E0RN+22+N5grLMBJSPadwwK4LeIQeNubT1ftLm6y3Y3dFOmaKmZo55sxk1tFlx
         GwVqs7QnB0bBdkUfRTcGkSqXJYsR3NSRT5n9uuJJJmPQm0y17OToVftWtw476rV5leCC
         i3EHKG2lN3axCzvDCIdhFy8kIcLPV/BEp6110i18pSyn9wD5ovORN/yeTX2IAOdQP1DE
         6F9o2whg17Z0NLSpFGeuLzwa5tCQBi95eIv8gHxYxtzEoRa3fSo6+RB9NmOP/pZdOUtD
         8N0w==
X-Gm-Message-State: AOJu0Yydf0u810k3ppTbS/Aa5lZ9ncTKh4Iz7tYLhkqSGkCmZORie8rE
        AwjDnEDNy/gmue8/o533XBoNBJlvdsgK5BnCBQqJfvmAPac=
X-Google-Smtp-Source: AGHT+IHbDnjOHfwNJkqq5VdUNxBPucmGXVZfuAWKZDXT/9jJyWd10eGpsK+F5v4izKtMwa5RDzje1e3R769THU7rG7c=
X-Received: by 2002:a05:6402:1484:b0:548:63bf:1123 with SMTP id
 e4-20020a056402148400b0054863bf1123mr3377554edv.40.1700415505587; Sun, 19 Nov
 2023 09:38:25 -0800 (PST)
MIME-Version: 1.0
From:   Cedric Blancher <cedric.blancher@gmail.com>
Date:   Sun, 19 Nov 2023 18:37:49 +0100
Message-ID: <CALXu0UeGnSvBbrfgnRNqdNGjDTag5Lz8uWOvuy_n57RHO3CRqw@mail.gmail.com>
Subject: How does READ_PLUS differ from READ?
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

Good evening!

How does READ_PLUS differ from READ? Has anyone made a simpler
presentation (PowerPoint slides) than the RFCs?

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur
