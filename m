Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AA365CB4B
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jan 2023 02:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238948AbjADBPv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Tue, 3 Jan 2023 20:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238646AbjADBPo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Jan 2023 20:15:44 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC0F1759F
        for <linux-nfs@vger.kernel.org>; Tue,  3 Jan 2023 17:15:38 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id h26so26196517qtu.2
        for <linux-nfs@vger.kernel.org>; Tue, 03 Jan 2023 17:15:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iMTmoF0rbqVRNdBp5WbVbXP7Ihcau9fKD6Sn/lBfPHI=;
        b=2DbXubQ8UAZgS2ajj2Ld5xmAD8goLJgaI+o6PqJqZeRwl4Kj5Mc9MCXVSaZYlVHsDY
         nUigYXtdZsH1JIQOyo4w3C7Vf4gL79WNCaVN2QqEW6lAKUDs90TJzSQt6SiE+N197onG
         wS1pkn6dfQyyYzpgcO0VvCfHRnweO/Wio265jmJxB7YER1PclIM+qwxDJiuFI7a5wh9/
         S2z2YKzMyRoC/ZG2KAl3Ik+YngkntXvK0mZUe13WRGS1hKbW93DrSDjD6Y4YxQh3sP2g
         KsoCRcAiLSE8yW4Sw2OxqUmNpG/zhrVaz43ERS//o/nwtDj0zw8mgaQfJreFa1X3BOFe
         skmA==
X-Gm-Message-State: AFqh2koEuCKV0TvNVJb6tTGzvbD3Ce/tewPee6qnGQe/8d3udefj9gMH
        gKMTYd4ksyGsM+DrX79haiaGxidBOg==
X-Google-Smtp-Source: AMrXdXuUVLRZe2NU2feTzsHdS5kzx6mDIfx9CScVRHOuZYUig6rRA/7N2hSD3o+QVYIH908gdIi4ow==
X-Received: by 2002:ac8:7093:0:b0:3a7:ed21:ac45 with SMTP id y19-20020ac87093000000b003a7ed21ac45mr55054065qto.20.1672794937376;
        Tue, 03 Jan 2023 17:15:37 -0800 (PST)
Received: from [192.168.75.138] (c-68-32-72-208.hsd1.mi.comcast.net. [68.32.72.208])
        by smtp.gmail.com with ESMTPSA id u26-20020a05622a199a00b003ab1ee36ee7sm19894270qtc.51.2023.01.03.17.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 17:15:36 -0800 (PST)
Message-ID: <210f08ae5f0ba47c289293981f490fca848dd2ed.camel@kernel.org>
Subject: Re: [PATCH] NFS: Handle missing attributes in OPEN reply
From:   Trond Myklebust <trondmy@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Olga Kornievskaia <aglo@umich.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Tue, 03 Jan 2023 20:15:36 -0500
In-Reply-To: <167279409373.13974.16504090316814568327@noble.neil.brown.name>
References: <167279203612.13974.15063003557908413815@noble.neil.brown.name>
        , <7a98c3e70bae70c44418ce8ac4b84f387b4ff850.camel@kernel.org>
         <167279409373.13974.16504090316814568327@noble.neil.brown.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2023-01-04 at 12:01 +1100, NeilBrown wrote:
> On Wed, 04 Jan 2023, Trond Myklebust wrote:
> > 
> > 
> > If the server starts to reply NFS4ERR_STALE to GETATTR requests,
> > why do
> > we care about stateid values? Just mark the inode as stale and drop
> > it
> > on the floor.
> 
> We have a valid state from the server - we really shouldn't just
> ignore
> it.
> 
> Maybe it would be OK to mark the inode stale.  I don't know if
> various
> retry loops abort properly when the inode is stale.

Yes, they are all supposed to do that. Otherwise we would end up
looping forever in close(), for instance, since the PUTFH, GETATTR and
CLOSE can all return NFS4ERR_STALE as well.


-- 
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com


