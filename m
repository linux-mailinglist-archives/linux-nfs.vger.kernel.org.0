Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D9269AE29
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Feb 2023 15:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjBQOg5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Feb 2023 09:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjBQOg4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Feb 2023 09:36:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98FA644FB
        for <linux-nfs@vger.kernel.org>; Fri, 17 Feb 2023 06:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Hy7R6pUoLyXk8q5BPXC91cZkdh7iE9VZjgKoS7H5N+8=; b=I3rHblFPiAL91WsWUhBX3idbrx
        nOv9wuzzAN2GvZ0oAWXL5lnn9wLjVZFJOQhNK3SLeOP/1dVYtQTeZ7O9TT7LrGNuOmXFeN6ey6oIs
        UN9mgWV+CdYEtCau33u+ZwWFWs3qrj1L22RC2hyCVpWnf/3KD4fgjO7jQiYXMF2drCBrRRVTBqVSB
        Hzj4BpxwpLJul7esCk2PPeJc3ttfhBUabYXqmOgZKI5DRoQx0gK6qQ/oteWtl5/0/XQRythGtaPLY
        OE0gbLlnWEwEu329bvwu3drwRy1olUTJKn6zVltvhB8Js7L55wUC/K9+DZqS1UdG5Jlm9EAaIoTQb
        k62rYGpg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pT1r1-009O9S-Aj; Fri, 17 Feb 2023 14:36:51 +0000
Date:   Fri, 17 Feb 2023 14:36:51 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Wysochanski <dwysocha@redhat.com>
Cc:     Daire Byrne <daire@dneg.com>, linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: /proc/PID/io/read_bytes accounting regression?
Message-ID: <Y++RA7YXtymaQJ05@casper.infradead.org>
References: <CAPt2mGNEYUk5u8V4abe=5MM5msZqmvzCVrtCP4Qw1n=gCHCnww@mail.gmail.com>
 <CALF+zO=e+d3sdLA4MZ_-SZh3epWBKF=hY=8FB+aB8+H4rxe4KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALF+zO=e+d3sdLA4MZ_-SZh3epWBKF=hY=8FB+aB8+H4rxe4KA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Feb 17, 2023 at 09:08:27AM -0500, David Wysochanski wrote:
> On Fri, Feb 17, 2023 at 6:56 AM Daire Byrne <daire@dneg.com> wrote:
> > On newer kernels, it looks like the task io accounting is not
> > incrementing the read_bytes when reading from a NFS mount? This was
> > definitely working on v5.16 downwards, but has not been working since
> > v5.18 up to v6.2 (I haven't tested v5.17 yet).
> 
> In v5.16 we had this call to task_io_account_read(PAGE_SIZE); on line 109
> of read_cache_pages();
> 
> But there's no call to task_io_account_read() anymore in the new
> readahead code paths that I could tell,
> but maybe I'm missing something.
> 
> Willy,
> Does each caller of readahead_page() now need to call
> task_io_account_read() or should we add that into
> readahead_page() or maybe inside read_pages()?

I think the best way is to mimic what the block layer does as closely as
possible.  Unless we can pull it out of the block layer & all
filesystems and put it in the VFS (which we can't; the VFS doesn't
know which blocks are recorded by the filesystem as holes and will not
result in I/O).

The block layer does it as part of the BIO submission path (and also
counts PGPGIN and PGPGOUT, which no network filesystems seem to do?)
You're more familiar with the NFS code than I am, so you probably
have a better idea than __nfs_pageio_add_request().
