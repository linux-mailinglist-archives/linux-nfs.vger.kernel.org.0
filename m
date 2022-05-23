Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A8C531B26
	for <lists+linux-nfs@lfdr.de>; Mon, 23 May 2022 22:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbiEWU3k (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 May 2022 16:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbiEWU3j (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 May 2022 16:29:39 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFBA41F90
        for <linux-nfs@vger.kernel.org>; Mon, 23 May 2022 13:29:38 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 1F39E6C90; Mon, 23 May 2022 16:29:38 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 1F39E6C90
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1653337778;
        bh=SBHIo/znkHovymBT+o2wP7JsHvO6Lw/1F6kQ+mmf6vc=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=jGCaYgRvGM2QITiQanrZFaPxIajGNlfHFVwpKQykNkLpC6tIL0zqfBLgFRATaiLdL
         ISLPNzI9XUhQeZw8A4UgWbrvRclOOgzUOhfZmPzOegM+yft3KzETpnLBv923mJQeBY
         6LEzvWECH3qzPiLJkLlzDrxH79manpvuOWnF/lWU=
Date:   Mon, 23 May 2022 16:29:38 -0400
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC] NFSD: Fix possible sleep during
 nfsd4_release_lockowner()
Message-ID: <20220523202938.GJ24163@fieldses.org>
References: <510282CB-38D3-438A-AF8A-9AC2519FCEF7@oracle.com>
 <c3d053dc36dd5e7dee1267f1c7107bbf911e4d53.camel@kernel.org>
 <1A37E2B5-8113-48D6-AF7C-5381F364D99E@oracle.com>
 <c357e63272de96f9e7595bf6688680879d83dc83.camel@kernel.org>
 <93d11e12532f5a10153d3702100271f70373bce6.camel@hammerspace.com>
 <a719ae7e8fb8b46f84b00b27d800330712486f40.camel@kernel.org>
 <5dfbc622c9ab70af5e4a664f9ae03b7ed659e8ac.camel@hammerspace.com>
 <f12bf8be7c8fe6cf1a9e6a440277a3eb8edd543a.camel@kernel.org>
 <A67AA343-E399-44AB-AFE5-02B82B38E79E@oracle.com>
 <17007994486027de807d80dfde1a716c3d127de1.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17007994486027de807d80dfde1a716c3d127de1.camel@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, May 23, 2022 at 03:36:27PM -0400, Jeff Layton wrote:
> The other lockowner _is_ involved. It's the one holding the conflicting
> lock. nfs4_set_lock_denied copies info from the conflicting lockowner
> into the LOCK/LOCKT response. That's safe now because it holds a
> reference to the owner. At one point it wasn't (see commit aef9583b234a4
> "NFSD: Get reference of lockowner when coping file_lock", which fixed
> that).

I doubt that commit fixed the whole problem, for what it's worth.  What
if the client holding the conflicting lock expires before we get to
nfs4_set_lock_denied?

--b.
