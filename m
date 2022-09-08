Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6032B5B1CF5
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Sep 2022 14:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbiIHM3c (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Sep 2022 08:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbiIHM14 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 8 Sep 2022 08:27:56 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE81ED38A
        for <linux-nfs@vger.kernel.org>; Thu,  8 Sep 2022 05:27:53 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id o123so18136020vsc.3
        for <linux-nfs@vger.kernel.org>; Thu, 08 Sep 2022 05:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=i1yUeKSl7+V1QiCXx8cINoGbuohQMkhiH7Z99zqwsr0=;
        b=QBy5dSW9XpRq3E/7MyVHNIEAj3ccR6SXTOtspl0NSeZNQr++0ngaNdTnlS9l7OtbFW
         J2ZXVDPeqGdx5zG4ZLGg9VPa9K1dFjVYS6lh7f9XKfMC6aoZcggTTPwwLxUB4S2sCRao
         TFal3VACZ44orqbHisSr2aAxP/zxFlE91dSD5qwIzuv9bR+YE3ERhk4CEqN8S/8Gu2Oz
         9HKktVaFCI3sgRBA7imYdhARcRg03qDsUT9cEGDR9Yzd8CwHwKpIGdHPXrS7o3xDiAUL
         0sdACnHud0qBk8cEQNVmFF0Q1SfREmR1l3q1LU6z38v46BaXJe9Zq6AQE/dio+QF6zd/
         V/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=i1yUeKSl7+V1QiCXx8cINoGbuohQMkhiH7Z99zqwsr0=;
        b=pr2ch7u1X9Bl7iJShryzTfmAjJxlfGprPTDLMJwYeoFHtVugMbtJN/Nb2JHTRz+ekX
         CwKpzfgpkuG7M05ywI7oDZ1iEpRvKKcLDLWhQKD3i37BRnplBjghh2C2/ID+9BuC9nea
         cDck44BKDjOCbhOYQGgUVOggbh+6GKWUSyy4O39bQnuChKKzaE3nfLhDENbW4SMg9mab
         ZjI62XZf0HIu8OIvmvkvqKtYVwPpifNkIn9aTagzErXgKSLmqzgM7XEhz+BaRNMuQ+hV
         YtOTwsAM4+eOskJlCcLxGq4ahOVAATY4vrpJz20Doi8QWj1POrfY4eXalpMGdT2imPgn
         wvvA==
X-Gm-Message-State: ACgBeo0ygWhRuoiAdgI89xR4/aYHNw4XN1GHQJ/jCuEkRgaZ9/YAEyeu
        soB9uiey/5ZLQn/YDll7KirHxoW6saeBadvKYBN6V0Sg7EKX5g==
X-Google-Smtp-Source: AA6agR5XBt6lICKafBAm6VyjH7SbLe5noBPvK4xWkLSVBFoaS2nVwC65/PWbDOO1TkXzokSBmbjbkzipXlBrbSf/DQM=
X-Received: by 2002:a67:ac0b:0:b0:388:6b47:2b1d with SMTP id
 v11-20020a67ac0b000000b003886b472b1dmr2878087vse.37.1662640072084; Thu, 08
 Sep 2022 05:27:52 -0700 (PDT)
MIME-Version: 1.0
From:   battery dude <jyf007@gmail.com>
Date:   Thu, 8 Sep 2022 07:27:05 -0500
Message-ID: <CAMBbDaF2Ni0gMRKNeFTQwgAOPPYy7RLXYwDJyZ1edq=tfATFzw@mail.gmail.com>
Subject: Does NFS support Linux Capabilities
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SCC_BODY_URI_ONLY,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

According to https://access.redhat.com/solutions/2117321 this article,
I want to ask, how to make NFS support the penetration of Linux
Capabilities
