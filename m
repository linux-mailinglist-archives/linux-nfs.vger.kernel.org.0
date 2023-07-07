Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9070374B477
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jul 2023 17:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbjGGPk5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 Jul 2023 11:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGGPk4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 7 Jul 2023 11:40:56 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D62AB2
        for <linux-nfs@vger.kernel.org>; Fri,  7 Jul 2023 08:40:55 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fb90f72062so584706e87.0
        for <linux-nfs@vger.kernel.org>; Fri, 07 Jul 2023 08:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1688744453; x=1691336453;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5R4eozUtjXLtDhhJAmJbsCY3yc0r3hvvLbsEttTUeK4=;
        b=rM99xSQXRUvsX9Fb7/+2CuxbOfAWei2FAHZ4vZQvK2AdmA3/2kdE+En5Tf+9qCmtF5
         QXHMAc96cgi8N9q8n3A8k/Po54kt6iCo93vmuJD8Ig2fc3ZxO9wHF8GzgZ+OuZPh/aiw
         IgTUoJX4XiuJKa7Hh6AM/yHzwhtW3KSj4YX8W1PapO/1zTPQZEFEM6ehxFKNvnrQ0zBX
         IMwdTot0rFoX26YUJsV7lh6xifMom2mDrO3c9DHnwRjbZXEAXdHfe/8VKfsp15Avlavy
         Mm+zon94ZztiHwk+SV5zXFZlueTUG9ZNkAbBFgvDsWiIU1u1f88E9LlZCFQA86+SIMMV
         aktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688744453; x=1691336453;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5R4eozUtjXLtDhhJAmJbsCY3yc0r3hvvLbsEttTUeK4=;
        b=XxFIqqsVsCUWB1tDMLaYTB+dwM+mu8DfQ74iSPXZUY1gTI5RhlAloPxivG4ZEFrTuN
         9La5uIg6nHFuX6+S7nRG4T6pfowBo/VcSpqog+QVSNAnkGR0lwaEkWwbrqc+LEtSaZrX
         EV+BZlpa7dZvr+PWn4hZthEQy9zUFGmVMsyJ4x8GJMUji5Lt7KVzLtbyvg9ZCzXsBCZV
         IvFRVX7KFZwETP4B2i5HEKgyttG66FwUFroZoD5p8Tw9QqDyUNe/6cC2gU64lv9TapZ5
         qui5XvYqyKGPbgSuH1LzjBhejFLp6YphDlTkH0aBo4w0aPTzbEm9I0V9VY0gbmxhVDjE
         lFgw==
X-Gm-Message-State: ABy/qLZKmYzD0RWGeol/g8T2EsV2EzpDq4gHSE9Nf4TEmjX5QtROpN2v
        Gq1YAIoX8Ksoh+zijvIm/76YuYM81/XgEqAfDoSq60Uc
X-Google-Smtp-Source: APBJJlHSWdpNRfHpciDGZTDz6YnFaosmvztUq3zfacF69ZSGIyYlyttgfTJN09aRXBJElIHns5tliM1CMjJN1AKh5jU=
X-Received: by 2002:a05:651c:989:b0:2b6:99a2:fe00 with SMTP id
 b9-20020a05651c098900b002b699a2fe00mr5332863ljq.2.1688744452614; Fri, 07 Jul
 2023 08:40:52 -0700 (PDT)
MIME-Version: 1.0
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 7 Jul 2023 11:40:41 -0400
Message-ID: <CAN-5tyGb0xb1-C9781gdkfPRNtKSixT_TfU44VV6FRCZooixXw@mail.gmail.com>
Subject: trunking rules
To:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi folks,

I'm looking for some guidance/consensus/agreement on what should be
trunking rules.

Prior to adding MDS session trunking, we had pnfs session trunking for
a long time. In GETDEVICEINFO the server would return a list of IPs
and the client, after verifying that it's allowed to trunk, would then
use. The number of IPs isn't limited by number but rather by the
sizeof deviceinfo structure (gdia_macount). At the same time, if
GETDEVICEINFO returned IPs that were in the same as MDS, then those
IPs would be squashed (I'm gathering the logic was if DS=MDS then it's
MDS trunking and that wasn't supported).

Fast forward now, MDS trunking is supported but controlled and limited
by the mount parameter max_connect.
What kind of rule should be used for trunking when DS=MDS now?
(1) Treat it strictly as MDS trunking. If no max_connect is given on
mount, then even if GETDEVICEINFO returns multiple IPs everything is
going to be squashed. If max_connect is given then it's the
max_connect that limits the number of trunks and not like other pnfs
trunking where it's the size of getdeviceinfo structure?
(2) Treat it as DS trunking and disregard max_connect constraints
because after all it is triggered as pnfs trunking not MDS trunking?

Or should max_connect be now required for any kind of trunking DS or
MDS trunking? Though I'm not in favor of this as it seems to defeat
the purpose of specifying a size of GETDEVICEINFO reply and just limit
it to max_connect always.

Thank you.
