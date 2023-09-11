Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D73579C32C
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 04:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239077AbjILCmS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Sep 2023 22:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240095AbjILCl6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Sep 2023 22:41:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02F110459E;
        Mon, 11 Sep 2023 19:07:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4045AC43140;
        Mon, 11 Sep 2023 21:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1694466280;
        bh=PSrTXoaCkMqB25RCHK4NE97OZaul62KlU0MSCOVqCUs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sMCF6iaRqgwVigUxFRLF1Ahh66xljEvSW6gMnyW6Wz7ahzgfSGIf5eSCAhwKG1map
         92+N3vZMF+n+AWjJrL80Ca1REYC9r+zk0/UtC8J+MlqFBSnbUQzWVtlT6wMNK78hCj
         1r7zjFzHKLFwZIWG5KkxCFP0+pCA8bEnycT87hHU=
Date:   Mon, 11 Sep 2023 14:04:39 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>,
        Liam Howlett <liam.howlett@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Gow <davidgow@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 11/17] lib: add light-weight queuing mechanism.
Message-Id: <20230911140439.b273bf9e120881f038da0de7@linux-foundation.org>
In-Reply-To: <4D5C2693-40E9-467D-9F2F-59D92CBE9D3B@oracle.com>
References: <169444233785.4327.4365499966926096681.stgit@bazille.1015granger.net>
        <169444318342.4327.18355944158180782708.stgit@bazille.1015granger.net>
        <20230911111333.4d1a872330e924a00acb905b@linux-foundation.org>
        <4D5C2693-40E9-467D-9F2F-59D92CBE9D3B@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 11 Sep 2023 20:30:40 +0000 Chuck Lever III <chuck.lever@oracle.com> wrote:

> 
> 
> > On Sep 11, 2023, at 2:13 PM, Andrew Morton <akpm@linux-foundation.org> wrote:
> > 
> > On Mon, 11 Sep 2023 10:39:43 -0400 Chuck Lever <cel@kernel.org> wrote:
> > 
> >> lwq is a FIFO single-linked queue that only requires a spinlock
> >> for dequeueing, which happens in process context.  Enqueueing is atomic
> >> with no spinlock and can happen in any context.
> > 
> > What is the advantage of this over using one of the library
> > facilities which we already have?
> 
> I'll let the patch author respond to that question, but let me pose
> one of my own: What pre-existing facilities are you thinking of, so
> that I may have a look?

Well, I assume that plain old list_heads could be recruited for this
requirement.  And I hope that a FIFO could be implemented using kfifo ;)
