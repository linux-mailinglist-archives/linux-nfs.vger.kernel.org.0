Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8840178F2DE
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Aug 2023 20:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238740AbjHaSsZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Aug 2023 14:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbjHaSsZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Aug 2023 14:48:25 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5B2E65
        for <linux-nfs@vger.kernel.org>; Thu, 31 Aug 2023 11:48:22 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6bdc27e00a1so943478a34.3
        for <linux-nfs@vger.kernel.org>; Thu, 31 Aug 2023 11:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693507701; x=1694112501; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TtF2lDkLh2fQs1BJdRF6c3BGLPnxp6tEVYD8JP7X8Yo=;
        b=Mcjw5WzVvscTkPiPU/p9CZ7uMB589l/50IXWX/qDmVGYeEHNoMUFZ73nO9ZmRzCGG4
         mMvas4tL0Eg+FV2dBnFlx1ylhua1eCL9P1fzSwxRVd1YmIeWqdu0XcMOu+5iiwPvBFeK
         6k8TPwWBWlThC1iK4u0OqjK+IKO9sifMgZvahCBJRR/johAPBlY/X0pqEk2ZD0uA0NdH
         LixMdGzJol/5l7nTRHmDdl9aAQeiPWywPkSw0ITgXtKJzOGyeznV4n8rwNaB2JpR7G4R
         4lyBx7qZAZ6GZ/Z1cUx60T05S5Q8cQ34NjLWho2V5UiT3aQto2wIx3SH0Jfu0Ew0rr+7
         Jc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693507701; x=1694112501;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TtF2lDkLh2fQs1BJdRF6c3BGLPnxp6tEVYD8JP7X8Yo=;
        b=Pj4oqQoe07GM/9/cudODmRCM9bDKmuOcdMQCpXyVgco9sYW/pQ+H5/eDp2MmYkTH6g
         ZCCbfNo6BsKUCq8yeixIKUecYghA3FFIyh8D2kk5cf1sm2hy53z/IHhNBBiznlrNAggg
         ono5L3cDeslnLGZshI4ahNuMCmUp2wvo15595rZBb6THTL59At+Domhu83Bb0v816Om7
         wCMWZ7vnNMW2d8yJ4hOwCWvnqXJqidPQykGxfbvte39I0xP5AqADQw04CNPkKNfAJkov
         36QhjYs8PSE1Ri+mMmEp9LFykqV00El2OXoBF94iGSRN5vlG5gs94JeIITZuOJFhrKb8
         2xQA==
X-Gm-Message-State: AOJu0YzYzLCEw8toUY64QGFpkD+V2uZNYK16De0YavhkDHCn+WWrVV5X
        NEa7q0+H3YRZ9VCH06ZFwukMSbUfl5QyhMzXetFk0qmD
X-Google-Smtp-Source: AGHT+IFZijYGq9vkYIXTIjjdcl7V+cnntxDgiEydrDjRqye5Aly9fazGRLcNtLEHVg3UfLjVuNDR6Ds7Jw9lnBwpiCY=
X-Received: by 2002:a05:6870:819c:b0:1c4:d735:38e9 with SMTP id
 k28-20020a056870819c00b001c4d73538e9mr284863oae.57.1693507700890; Thu, 31 Aug
 2023 11:48:20 -0700 (PDT)
MIME-Version: 1.0
From:   Joshuah Hurst <joshhurst@gmail.com>
Date:   Thu, 31 Aug 2023 20:48:08 +0200
Message-ID: <CAEEMktOKikRnJ+U5p-NaOAsyUBTQT0L1AFOZ_8eNuT92V2WFCg@mail.gmail.com>
Subject: Tuning NFSv4 for high latency links?
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Does the Linux NFSv4 client or server have tuneables to improve
latency (i.e. /usr/bin/find -ls performance) over high (satelite)
latency links?

Josh
