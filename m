Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7054E78F3CD
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Aug 2023 22:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243651AbjHaURM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Aug 2023 16:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbjHaURM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Aug 2023 16:17:12 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED380E5B
        for <linux-nfs@vger.kernel.org>; Thu, 31 Aug 2023 13:17:05 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bf55a81eeaso8949645ad.0
        for <linux-nfs@vger.kernel.org>; Thu, 31 Aug 2023 13:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693513025; x=1694117825; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lcdUpHPHlS6oKqWNaQkZCdbGjsHXLKSG46mNGxAKXmY=;
        b=nhdm1GJkzLVCY85v9cW/rLitzDcE/d5MFeaxzoRSGn3G8fUvWBYgsGyOcxbgDdKcAR
         BP1kFWG9QM7qcd24Oo3vcLhvtwoUhdDaeqITI9g0uCmXdudS5y9Wnr1w3AaHqP3OQkC6
         h2WnAlS6eEZBJmf2ttEAadH5FEHSgdrocR5T9GR+bKwDnTKugMXn1P9FtoPdm6apuD9W
         S2oRrzeOjqAGjHTdj9WBIscpNdKKMqwJHoEomo/xamtTDwQ3IP0EdR/Povhp4f80sKF3
         yZ//ukssosu3oK1qPt1EWAdOnLiUIF4pZnh73bMmKZFyibIuBhi6yY5zr1rASnbpHMrs
         Hl3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693513025; x=1694117825;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lcdUpHPHlS6oKqWNaQkZCdbGjsHXLKSG46mNGxAKXmY=;
        b=FxLJ+0SqBBJqZn+wH65ram8jqxCJ6E+fBEMpW0sdNfn+W770hgf/BVpy5y/F0FwaW5
         vML5HeqsvJm5CwqbFLjjir28jEp1xCWgqWZsuAFBih2733vGVZPHyISb1cs2cezQDufH
         PsXN5oQgiVEh2xF+E3ZYRP5/lsYuMEU3BpUl6MCMcndvrKJd46eoWFOC3/PbE74mXEXJ
         a6b45J4SFJSrQmNvpgqzTFbSLF8oN7Y0ubyCaM/VOuAghCCGnvAsCO+h6rThOupizmet
         QC1yg0VIVSn6xtwcUiqL290I04oB+MfM/plcCYe7rke3LIczu5MVRba3mglQHUFFJULn
         ioiw==
X-Gm-Message-State: AOJu0YyEN8lhuY9h9890WNThWgFZkxnTEZ/OpRTciKprkmRy12x1xvln
        CZ+sgPGu2AcdGbnZLxTXOWBR40T9nP2TiOEKQZR7Z7DmJQ==
X-Google-Smtp-Source: AGHT+IF7/1leeDAWYPi/YF1261bYV+Zw7om7ebVBgZn7r1Ja+Xhe37Tg7UYgJ3sKzYeNq3n8ZjTSkqdDdZKW6qhxjrg=
X-Received: by 2002:a17:90a:bd8e:b0:269:5adb:993 with SMTP id
 z14-20020a17090abd8e00b002695adb0993mr378768pjr.22.1693513025408; Thu, 31 Aug
 2023 13:17:05 -0700 (PDT)
MIME-Version: 1.0
From:   Rick Macklem <rick.macklem@gmail.com>
Date:   Thu, 31 Aug 2023 13:16:54 -0700
Message-ID: <CAM5tNy49ZSOpZKZrx4QzGZCo68EX1Ge4323s_nczQdatz+fuUA@mail.gmail.com>
Subject: Directory delegation testing at the Oct. bakeathon
To:     NFSv4 <nfsv4@ietf.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I dusted off some old directory delegation patches I have
and am making pretty good progress with them.
As such, I will probably have an experimental directory
delegation implementation for the October Bakeathon.

Does anyone else have any directory delegation code for
testing?

Thanks for any info, rick
