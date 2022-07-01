Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31DD563C16
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Jul 2022 23:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbiGAVwh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Jul 2022 17:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbiGAVwa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Jul 2022 17:52:30 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D28599D9
        for <linux-nfs@vger.kernel.org>; Fri,  1 Jul 2022 14:52:28 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id dn9so978080ejc.7
        for <linux-nfs@vger.kernel.org>; Fri, 01 Jul 2022 14:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/96lfPgxyeYWItPL0GqeIfIZW1m1l6mW0bCfbfK6/G4=;
        b=tM6FkB9TQSdtXLsbo9GSt0El+C6GsVSa0qgIzryHlb4YMh8EUqGDNiJffB/uKMX7ld
         8ykgWJWHh3bpyfJiPApyauP7W9hZCAMZYman3NVxtOxw/CJU2/tlRwtg62Zs349a60Br
         PD/5TS2+BEIchA750jKxRh5H4XnBUsBM022+BFmdPjfYOEiKzI84XxAoUFP4rWgkyfJ8
         X6F9KoHTR0oziYxm/y8i710qApWqXOhvb+WzidVXBfcr29SwEYB3c4nOw1EWu/GtgzDu
         5AyNEU03AtVPWemwpQY7Wyrm1xf5siZsxYid34qO7dQvSCtdJKZsBj5dfmZzOCud7Xt4
         79Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/96lfPgxyeYWItPL0GqeIfIZW1m1l6mW0bCfbfK6/G4=;
        b=WsFVUBK2fgBzodQgTvazHtHum+7+mgS8OZcFLX/kxAlKtNm2pvp1/GHXGwLzGCtG36
         CK/6Ec1awY0C4esHSan5kJzwPTt8amPBERZzRTA6rQh90vxxH7HdiAGiHuMUCG6+sTlW
         flvxz7Mm4rE601oJ3L1BlbggBA+ww3Vqf1dwj0puoKLd5yvByBeF8fQPr+oCBpeJEPvj
         U+vy5mh/hpYDk5k8UCZ/+yiqWA+wVIuc9WBQnlmtZmURIo0axy4H8ydod8TBiMuy9rh/
         l+YEYQ1s7rpjkpRP1M++pbOH0ZghQfte/sle9vrguGKDLQSmcFYRZPPCHZ6uKRuSngnP
         9QPg==
X-Gm-Message-State: AJIora+2q7GW/KsTI3CfcXt5pK0xqSceVLnPVU/yyrkKhJfeO5Zd7eUD
        nMbZ2i4WJQHB51x7CRCzwhQRwsbBwkOEgTM8bSBJicltHRp7v2za
X-Google-Smtp-Source: AGRyM1uUztfHeS8SN5JmNFnLtJtd+AsE6UvK/BMIS7qUeOLZoijjqeTnACaRjCCBWboojN2/pRfiF0Y4KTLK71C1NTM=
X-Received: by 2002:a17:906:730f:b0:726:ca34:e605 with SMTP id
 di15-20020a170906730f00b00726ca34e605mr16713083ejc.347.1656712347023; Fri, 01
 Jul 2022 14:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <737440541.1127428.1656698294694.JavaMail.zimbra@desy.de> <05f3b4e144ec5d12ab87d861222128181e805321.camel@hammerspace.com>
In-Reply-To: <05f3b4e144ec5d12ab87d861222128181e805321.camel@hammerspace.com>
From:   Daire Byrne <daire@dneg.com>
Date:   Fri, 1 Jul 2022 22:51:51 +0100
Message-ID: <CAPt2mGO3HsM6ixecvNioZ=jNCNBZ-DuPWmq+LzEnzJdR3McC9A@mail.gmail.com>
Subject: Re: Per user rate limiter
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "tigran.mkrtchyan@desy.de" <tigran.mkrtchyan@desy.de>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
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

On Fri, 1 Jul 2022 at 19:23, Trond Myklebust <trondmy@hammerspace.com> wrote:
> 2) Define QoS policies for the connections using the kernel Traffic

If it helps, we use HTB qdisc/classes on our Linux NFS servers to
optionally limit the total egress and ingress (ifb) bandwidth to/from
our renderfarm.

User workstations are exempt from these limits so always get full speed.

We can do this fairly easily because our network is well defined and
split into subnet ranges so filtering by these allows us to
differentiate between host classes (farm/workstations etc).

Strictly speaking, it's a bit more complicated in that we only apply
limits and change them dynamically based on the "load" of the server
and how well it is keeping up with demand. This is just a bash script
running in a loop looking at the state, scaling the HTB limits and
applying filters.

Our goal is to always ensure that taff have a good experience on their
interactive desktops and we'll happily slow batch farm jobs to keep it
that way.

It is basically a low-pass filter that limits server load spikes.

To do something similar by user or process, you could run your jobs in
a cgroup and have it mark the packets that the server could then use
to filter. But I think this only works for the client writes to the
server as you have no way to mark and act on the egress packets out of
the server?

Daire
