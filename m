Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991C4531F91
	for <lists+linux-nfs@lfdr.de>; Tue, 24 May 2022 02:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiEXAH4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 May 2022 20:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiEXAH4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 May 2022 20:07:56 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A465E9BAD9
        for <linux-nfs@vger.kernel.org>; Mon, 23 May 2022 17:07:55 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id CDFEC7083; Mon, 23 May 2022 20:07:54 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org CDFEC7083
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1653350874;
        bh=zPKtMSnuEl/NXLzAIfOK128Jcnh9ul+Fd7xjm3yifHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=szHp7uhx0cffCD1NvbrGsA2uxklfNCkp1u20Yzs7oOweVEhAcnhqUheUKsIz1jfH2
         wuTmnIP3sdMESCOpbvtHqmTl4AVc1ma9f060Ivy23Axn/C+HAB4G15lUewHQOar8Ub
         oz7325/3Uk9TQe71WSrQwPCjYsVF/XvYZIjJYI48=
Date:   Mon, 23 May 2022 20:07:54 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC] NFSD: Fix possible sleep during
 nfsd4_release_lockowner()
Message-ID: <20220524000754.GB31155@fieldses.org>
References: <c357e63272de96f9e7595bf6688680879d83dc83.camel@kernel.org>
 <93d11e12532f5a10153d3702100271f70373bce6.camel@hammerspace.com>
 <a719ae7e8fb8b46f84b00b27d800330712486f40.camel@kernel.org>
 <5dfbc622c9ab70af5e4a664f9ae03b7ed659e8ac.camel@hammerspace.com>
 <f12bf8be7c8fe6cf1a9e6a440277a3eb8edd543a.camel@kernel.org>
 <A67AA343-E399-44AB-AFE5-02B82B38E79E@oracle.com>
 <17007994486027de807d80dfde1a716c3d127de1.camel@kernel.org>
 <20220523202938.GJ24163@fieldses.org>
 <d2b1b7e58ff93b3bedaaf62a8fd3390faba3080e.camel@kernel.org>
 <20220523212816.GA31155@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523212816.GA31155@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, May 23, 2022 at 05:28:16PM -0400, J. Bruce Fields wrote:
> On Mon, May 23, 2022 at 05:15:55PM -0400, Jeff Layton wrote:
> > On Mon, 2022-05-23 at 16:29 -0400, J. Bruce Fields wrote:
> > > On Mon, May 23, 2022 at 03:36:27PM -0400, Jeff Layton wrote:
> > > > The other lockowner _is_ involved. It's the one holding the conflicting
> > > > lock. nfs4_set_lock_denied copies info from the conflicting lockowner
> > > > into the LOCK/LOCKT response. That's safe now because it holds a
> > > > reference to the owner. At one point it wasn't (see commit aef9583b234a4
> > > > "NFSD: Get reference of lockowner when coping file_lock", which fixed
> > > > that).
> > > 
> > > I doubt that commit fixed the whole problem, for what it's worth.  What
> > > if the client holding the conflicting lock expires before we get to
> > > nfs4_set_lock_denied?
> > > 
> > 
> > Good point -- stateowners can't hold a client reference.
> > 
> > clientid_t is 64 bits, so one thing we could do is just keep a copy of
> > that in the lockowner. That way we wouldn't need to dereference
> > so_client in nfs4_set_lock_denied.
> > 
> > Maybe there are better ways to fix it though.
> 
> I kinda feel like lock and testlock should both take a 
> 
> 	struct conflock {
> 		void *data
> 		void (*copier)(struct file_lock, struct conflock)
> 	}
> 
> and the caller should provide a "copier" that they can use to extract
> the data they want while the flc_lock is held.
> 
> I'm probably overthinking it.

But in any case note the problem isn't just the copy of the clientid_t;
nfs4_put_stateowner also dereferences the client.

--b.
