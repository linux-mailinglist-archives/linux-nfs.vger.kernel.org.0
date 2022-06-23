Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F4C557238
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jun 2022 06:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbiFWEnw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Jun 2022 00:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237185AbiFWDXB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Jun 2022 23:23:01 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F5A637C
        for <linux-nfs@vger.kernel.org>; Wed, 22 Jun 2022 20:22:57 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z7so26583355edm.13
        for <linux-nfs@vger.kernel.org>; Wed, 22 Jun 2022 20:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:date:message-id:user-agent:subject:mime-version
         :content-transfer-encoding;
        bh=wjunn4+x2QEs4HRrQcozT7INn2DM0lGSHIZkmkDz3T0=;
        b=Uk2Qo3qYqnwxZ+HtXcI42cQf9+KCOOsApCyJUbZ3URu9DyVao3PwrXoP0hRyxkzlI8
         lVBtWfLK0f6SMFZA0NzPRGDW3SPIoxKL1q/nG+pZZImeQ4vMAkHT58h6yQrwK4WCctVh
         rERPbHlA8gA9niAQRYdxVbJlk3+lKRnlrBroKOGi/tP8pd4y7ZvcfiDT14ZsWWfgrnVj
         z6/RDNjW+ayn/1rIb3TTuLtoXnvtVzwKLOqW8WNG6zaHvPgdunBhYwUSEn51sU40FMjB
         +JXGFsh0rNE5CPkKlGbtOfbWISSRm05S5K5bFbA6uSAWa/s06FdndLKyzAxh9MbUg89T
         IPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:date:message-id:user-agent:subject
         :mime-version:content-transfer-encoding;
        bh=wjunn4+x2QEs4HRrQcozT7INn2DM0lGSHIZkmkDz3T0=;
        b=3L+f4Tw3S6yRD+rxX52spehQLcB8bicYpIkY083DTrk7FPV/hDqdd0o4YaC6YtU3Kp
         AXn+r1TutjcUAZ9CWCKfZI95S4I5Wy45acz6mx64RLaHCk+yhdJGFOVZ98iRQF3f9J4s
         5poQH3kBAjYjp8RySgQ6mNhReXeDZbbQohXcNqILYp3yKDaVH2upEu2/s2OLXP/+A4xg
         eOh4+0JnhLL/i95JtBSs9cDrSDbp2/o5ZFLcviz+D373JkydMd9XGhqOktaZ8Cpf8fTT
         /YN3IZUBCL1z7VIIqAGTkgrnW/9n9upPAVLojWHvDNge7d9jhANfmw0ghALBc1xH5dc6
         AS2A==
X-Gm-Message-State: AJIora/nWubi/WkcvtlLYfpJp9Ttg2T4T7mKr5vg+x3mbsAyQZCemlf6
        e9+dyZUXXAG/YyTkL2rQ7PWiLO1v1Fs=
X-Google-Smtp-Source: AGRyM1tPcJJFXwAkaRPGYi/bk3kobz5d85byXINFn6nuhDQ3z1ccGarRX90G5DsAaIA/xtpVQolpMA==
X-Received: by 2002:a05:6402:2710:b0:435:bf54:8569 with SMTP id y16-20020a056402271000b00435bf548569mr4159047edd.165.1655954575962;
        Wed, 22 Jun 2022 20:22:55 -0700 (PDT)
Received: from [192.168.178.67] (aftr-62-216-205-150.dynamic.mnet-online.de. [62.216.205.150])
        by smtp.gmail.com with ESMTPSA id a12-20020a50858c000000b0042617ba638esm16168917edh.24.2022.06.22.20.22.55
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Jun 2022 20:22:55 -0700 (PDT)
From:   "Holger B. A. Rauch" <rauch.holger@gmail.com>
To:     <linux-nfs@vger.kernel.org>
Date:   Thu, 23 Jun 2022 05:22:54 +0200
Message-ID: <1818e958ab0.2a06.5e117a29f51efed2e27b76f62c3ffe17@gmail.com>
User-Agent: AquaMail/1.37.0 (build: 103700163)
Subject: unsubsctibe
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,BODY_SINGLE_WORD,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SCC_BODY_SINGLE_WORD,SPF_HELO_NONE,SPF_PASS,
        TVD_SPACE_RATIO,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

unsubscribe


