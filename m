Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B5A790305
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Sep 2023 22:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjIAU7Q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Sep 2023 16:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjIAU7P (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Sep 2023 16:59:15 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C11CC
        for <linux-nfs@vger.kernel.org>; Fri,  1 Sep 2023 13:59:13 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-271b102659fso270750a91.0
        for <linux-nfs@vger.kernel.org>; Fri, 01 Sep 2023 13:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693601952; x=1694206752; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M7cDGgyfa2Glk635UI1GLZHAac+kZu33Xb540YFX6pY=;
        b=sbWIn2RSNhA9oKNLMvqo48S9OWcGf51vcvesSsSBmCZuAmh138vLAqb9IN07nMrxkz
         UzN8i4hYOUVYGHbVoCujc2FxofrdiN+TcjE3T0epM+SBdXk6EDji2wXU2eZhwkx6qyXM
         G8YUZJm2VWjq9khZa1G/ove53Hr5JBLvoIx5j649EMvpjA33wes131faD/d4LXOPiSct
         L1Gsw9mFHvt5hLRqOoaB68MUTNqQK5jRkShqmnw/wSqJOkGN2qGF5H3LwYCfpqD6z5kT
         /XxQJVc1kt6BrC8T2ZN2OABW9mH7SZ595HdoJlIXQkNnG7B93Y7nyrifLYp3TEHgEt3D
         EbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693601952; x=1694206752;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M7cDGgyfa2Glk635UI1GLZHAac+kZu33Xb540YFX6pY=;
        b=VXFUCXnffglmS3yNTVwgxS17IKFRSli+3lfzqffoxIbjRoCkvb2Yk/OL8nHB3kDPpj
         KQQ4GB2QlCxvdMwoixpugfpTcmLwvWE6fKfAxlnB6CgQ5SjSMCNooaKaFydtTQGGrywd
         HrOw6iL0AOHivP9AOj1kMX7IBejcx2S162CwmOnXG5UywmEo/x2UDalC0KmypiZr6dBQ
         tuDYyj/Z/Bxxoj3IvvBvfMhaNIbJNB5B+2itRy6q9HbTO4dMLSyFrzyiqYCU2nfjMBJm
         IDBbq3L7XEljX3WiCLkV59EUqT9+40bDijvMZaybO0PRAQpRb3N7uacdgHcBq42/RfJF
         zE0A==
X-Gm-Message-State: AOJu0YxcUWEPDojxTXUNrjEBCiAVjtq1oKdPP+k0BJyEWbQ9M85t5NOY
        ehrIxRYhOImbyw+lL81amgvEQmpMkuHHjiNbdTENteM9u6fTOg==
X-Google-Smtp-Source: AGHT+IHbjzLsVm8QBFSIlmNWesI9/Z/Ub5ErOE3Vo7ZgdYzwHtKeYB0artdOJBT/WZxOXIvcHAGHx9FGp0pWA+JWOgg=
X-Received: by 2002:a17:90b:4a83:b0:26b:4e40:7be6 with SMTP id
 lp3-20020a17090b4a8300b0026b4e407be6mr4810477pjb.20.1693601952004; Fri, 01
 Sep 2023 13:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <CABXB=RSMkjoyshFZy5eGbuvAQfoHhFyQvReYNtO_+5f+OM66cA@mail.gmail.com>
 <CABXB=RR=67b-sksfcrJotivc_9G0vTesP3qtz9T_8G3N3H-15A@mail.gmail.com>
In-Reply-To: <CABXB=RR=67b-sksfcrJotivc_9G0vTesP3qtz9T_8G3N3H-15A@mail.gmail.com>
From:   J David <j.david.lists@gmail.com>
Date:   Fri, 1 Sep 2023 16:58:59 -0400
Message-ID: <CABXB=RRWwQ5gDwC5gocftH9dPMvQLGcTV4jFnVcBZ15t=Sqd-A@mail.gmail.com>
Subject: Re: Question about different gid management between versions
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

A helpful person from this list gave me the clue needed to sort this
out. They suggested summarizing it here for the possible benefit of a
future person in my situation.

The issue was that while our Bullseye servers were fully up-to-date,
they are also quite old.  They were originally installed back in the
era when "--manage-gids" was not the default setting in
/etc/default/nfs-kernel-server, and we have carried that forward ever
since.  In the case of gid mismatches, that flag essentially governs
whether an operation will use the client's gids for a uid (if not set)
or the server's (if set).  Disabling that flag (for newly-installed
older versions) or using the equivalent "manage-gids=n" in
/etc/nfs.conf in the new version of nfs-kernel-server gets us the
behavior we need.

No one who has perfectly synchronized uids & gids between client and
server would ever notice this, but since that's impossible in the
workload I have to support, it makes quite a difference to us.

Thanks!
