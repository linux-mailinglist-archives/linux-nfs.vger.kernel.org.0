Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F5C74CF35
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jul 2023 09:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbjGJH4n (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jul 2023 03:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbjGJH4k (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jul 2023 03:56:40 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AB9106;
        Mon, 10 Jul 2023 00:56:38 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6454D67373; Mon, 10 Jul 2023 09:56:35 +0200 (CEST)
Date:   Mon, 10 Jul 2023 09:56:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Chuck Lever <cel@kernel.org>
Subject: Re: NFS workload leaves nfsd threads in D state
Message-ID: <20230710075634.GA30120@lst.de>
References: <7A57C7AE-A51A-4254-888B-FE15CA21F9E9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7A57C7AE-A51A-4254-888B-FE15CA21F9E9@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Jul 08, 2023 at 06:30:26PM +0000, Chuck Lever III wrote:
> Hi -
> 
> I have a "standard" test of running the git regression suite with
> many threads against an NFS mount. I found that with 6.5-rc, the
> test stalled and several nfsd threads on the server were stuck
> in D state.

Can you paste the exact reproducer here?

> I can reproduce this stall 100% with both an xfs and an ext4
> export, so I bisected with both, and both bisects landed on the
> same commit:

> On system 1: the exports are on top of /dev/mapper and reside on
> an "INTEL SSDSC2BA400G3" SATA device.
> 
> On system 2: the exports are on top of /dev/mapper and reside on
> an "INTEL SSDSC2KB240G8" SATA device.
> 
> System 1 was where I discovered the stall. System 2 is where I ran
> the bisects.

Ok. I'd be curious if this reproducers without either device mapper
or on a non-SATA device.  If you have an easy way to run it in a VM
that'd be great.  Otherwise I'll try to recreate it in various
setups if you post the exact reproducer.

