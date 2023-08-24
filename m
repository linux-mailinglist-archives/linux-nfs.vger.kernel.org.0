Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EE7787738
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Aug 2023 19:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbjHXRka (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Aug 2023 13:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbjHXRj6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Aug 2023 13:39:58 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EC61BD4
        for <linux-nfs@vger.kernel.org>; Thu, 24 Aug 2023 10:39:56 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d650a22abd7so100533276.3
        for <linux-nfs@vger.kernel.org>; Thu, 24 Aug 2023 10:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google; t=1692898795; x=1693503595;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vvEf7P1kBLK23j8glsUxDmRXaSuFMsNQTilLxvc9BiQ=;
        b=BpEXSHk1Zu9UV4n1qaII8dUlOPQV5D+CLf+6EZnHKYfoDcxCNjFX2EZoXHC5mbKO77
         SVM0dL5Qdvsq2mflvgz4lVNPsJFKSdvWvxh/BghmqmY/N7UriLPnuLlfyy63hnnDxim4
         JdpraLv5dODWIOj6e4STkX/9J973Ai46SELOuPz9sq2KdYNa6OTEp3qFG6tbcqgnMTW9
         DOgBu18nOMeI66pjt7/PXp33DkTd7BAy/VNcPaec2dLXuDrzWc8ghgNrWkvRqcHfamdE
         Fkz1U/wjXWUEIQ4htGL+KjXyTWtg7Ch/h1mkv7e//N/tf/MAEkjWLL8Z4zGALc/G21wC
         42gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692898795; x=1693503595;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vvEf7P1kBLK23j8glsUxDmRXaSuFMsNQTilLxvc9BiQ=;
        b=HGMBrCmuTzaCKL2BWz6LLDi0rLkS3Ta0GD73np8rr949rZTbaEdisdJVkbKIsnsykp
         gOu/1LvhJpGnpS8kHPPYAR/+Sv5AtLeUFXtJ359ySqetQpZJNy2c40JaSKHDkyYrwoz2
         LvsEK59ZPe7A7EgrWvwr9upD+rmwisEFcU/Xy9msjzGlfF2hdKk/w0bN54P+lK8sy4gv
         eb2pfrI9+NnYVtjrO9br8MMW9WNh9NAL+RZc0tBhVut6XFy/qZKmmEkmkNUAuiYLqS25
         dT1Q6hVKayWjpIrSMluojcgNn5LwIaQPixqZO9cqo3u8nSf7PdTLEu1Wt/vfC/v1s+/2
         veog==
X-Gm-Message-State: AOJu0YxmL0cZXQdklxKefxPXUI8Atg6zWRs3rZ2lDCQbGXEUfknlzlFF
        8dwPcj1V+XAh1Cir6Mm6/sAU/7LL0vqG8fXU0+zsSvV0W3NMn1xwqOY=
X-Google-Smtp-Source: AGHT+IEMpjpN5s9qglPlru57sU4Zi8UZROVVRhDMvXkh6uFQgy6+oHvhiY9ucc7TdhgRmsp1a5krjqKEN2Kzu8BalL0=
X-Received: by 2002:a25:2d25:0:b0:d47:8db3:8bcf with SMTP id
 t37-20020a252d25000000b00d478db38bcfmr16720709ybt.49.1692898795398; Thu, 24
 Aug 2023 10:39:55 -0700 (PDT)
MIME-Version: 1.0
From:   Daire Byrne <daire@dneg.com>
Date:   Thu, 24 Aug 2023 18:39:19 +0100
Message-ID: <CAPt2mGOcf+y1acYqzB+a3aZOJM0kE=FcWr-Xs15ECswGXP8-yA@mail.gmail.com>
Subject: rpc.mountd & manage-gids behaviour change?
To:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

We have lots of Linux storage servers running combinations of RHEL7,
RHEL8 and more recently RHEL9. We also use "manage-gids" and have lots
of groups of users and apply permissions to directories on the
exported filesystems.

We also use sssd and AD/LDAP on these storage servers to resolve the
groups and do the user lookups. This setup has worked great for our
needs for many years but we have noticed a change in RHEL9 which
results in many more uid/gid lookups hitting our LDAP servers.

It seems like with RHEL7 & 8 era kernels and nfs-utils, sssd/nss would
receive a single request from rpc.mountd whereas with RHEL9 we now get
duplicated requests for each rpc.mountd thread (8 by default) even for
a single client mount. So 8 uid/gid requests hit sssd at the same
time, and because it's not in cache, all those 8 requests go out over
the wire to our AD server.

So for lookups not in the cache, we have 8 times more requests hitting
our LDAP servers. Not to mention that sssd sometimes crashes or loses
connectivity with the LDAP server with this increased load.

I had a look through the changes for linux-nfs but nothing jumped out
at me in that time frame (other than code to make exportd
multi-threaded). Does anyone have any ideas where this change of
behaviour might be coming from?

RHEL9: nfs-utils-2.5.4
RHEL8: nfs-utils-2.3.3

Cheers,

Daire
