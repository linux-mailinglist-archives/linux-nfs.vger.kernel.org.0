Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A295A98F7
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Sep 2022 15:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbiIANfH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Sep 2022 09:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbiIANel (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Sep 2022 09:34:41 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14C912A9B
        for <linux-nfs@vger.kernel.org>; Thu,  1 Sep 2022 06:33:05 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id lx1so34675698ejb.12
        for <linux-nfs@vger.kernel.org>; Thu, 01 Sep 2022 06:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=RxaY+6oeNV1od+oXjpJs3OJKVDjPWxUbCmxSZ08fyOY=;
        b=QOUPjMeJtohDg592pIZaW3CfDe86J04RPRtXWwS+xknr3U2RkG0GO61g1hNT8KI0G5
         c1WlJTD0rDz+wlOg8J+3xWKiamhz82KQYJzUH5rXINL9N1mflhIGrmyihYfJbTwaKRoT
         8HMIcX52oVThHBeLHFyso0EKsByF6lkaUMaEF+PRRhHt6tgJ2AWEIhLAvn+fpapYrVox
         OY+/zqKsvr+kNZ6FHGqdTzMdEThZJf1yPybxVrBXcXds6Jt80m9CP5hvCtDYZ8kfqGDo
         uNRej+S8egMTpfgfjXAO8XigZTaBvyxreLa2SohNZ2TRjEfTTMO9TeWSQetaaev1UjUl
         txOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=RxaY+6oeNV1od+oXjpJs3OJKVDjPWxUbCmxSZ08fyOY=;
        b=ui7VZE0KecRG7ZiI77SyNkP3EZZxP3OAp+zye9QBRxeVzsoiiNpiQqLo4SkoP2x6eA
         hTJc72752tbnUr1QU/41GFR6k9bGxaW1V6L/NwwMo4Yc17CQcyuOHrZhGrt0ddQOg/iG
         TGCJ5tr8HmMBGDh7J50vNCo+CssCC9JyKd61OPAxGdrB2ahlzz2c1wUwIAo7UfiFjOye
         wk7WbDJVBZaR/YioND6UoLApPL4aozvcK2LRTiwK65Ct8kB5dlocMAh8Fi2W798w/jRC
         UKOM/f6mm3PZL0sr9lAIS8F40x/yiVQqJQy77zzbDMmwHwQH9CB/v0Gn1TegEIjZmLkm
         4sOg==
X-Gm-Message-State: ACgBeo2ElctZAM7m6zJ6c1mqnM61E3cSX59ZZyJK96CkqFG3Qax8ZsZW
        jWTFLp3cgSO5UR+Xqs4969GfUNK6n17IOVwfZT/mx2Yt4zF6AHCR
X-Google-Smtp-Source: AA6agR755/EZBx78s1A9gtZ8kW5yP1uP+1BxkHTjw+Wdwsnb7P+P9SuSyzJq1kuTTcxLW1uIQYQmDlRSJCHtfvxkoz0=
X-Received: by 2002:a17:907:a062:b0:73d:dec1:6692 with SMTP id
 ia2-20020a170907a06200b0073ddec16692mr20206061ejc.685.1662039183335; Thu, 01
 Sep 2022 06:33:03 -0700 (PDT)
MIME-Version: 1.0
From:   Daire Byrne <daire@dneg.com>
Date:   Thu, 1 Sep 2022 14:32:27 +0100
Message-ID: <CAPt2mGOnsA9pcmZQkr2q40d7A+NLj7=xr+dzFh7XwJPdGYW6Hw@mail.gmail.com>
Subject: directory caching & negative file lookups?
To:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

So I have a bit of a newbie question (apologies) that came to me while
debugging some code that was spamming our NFS servers with lookups for
nonexistent files.

If we can cache directory entries (readdir) and even all their
attributes (readdirplus) for some specified period of time (actimeo,
nocto) on a client, then why can't we use that data to serve negative
lookups for files in that directory too (if we so choose)?

There are probably very good reasons you always need to do a
(negative) file lookup, like being able to read files recently created
on another client (despite your local cache for that directory), but
I'm just curious what the official reasons are. If we could choose to
serve negative lookups using the directory entries cache for a
read-only or unchanging filesystem, would that still be bad? We
already choose to use nocto for some workloads...

In our case we see these kinds of heavy negative lookup workloads for
network installed software (100 entries in PYTHONPATH is bad) and in
buggy software (randomly generated filename lookups are really bad!).
Of course, this overhead gets really bad as you add latency between
the client and server.

Daire
