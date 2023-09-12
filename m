Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DEC79C385
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 05:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241447AbjILDBb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Sep 2023 23:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241692AbjILDBV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Sep 2023 23:01:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C13C7991;
        Mon, 11 Sep 2023 18:30:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B213C116A1;
        Tue, 12 Sep 2023 01:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1694482226;
        bh=tT5AR8ExWn/1md74OJRAUxFuwJ+Te4kYQ5KJli+PF+A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=juChOnAnOoct4hJ1ym1PhysnDu87Z5ALN94QFwGTO7F03yuUUZw6tZu4NrcMvp6RN
         0UIK75W7o3wI3TclaJg7qnC42dsWF8/B0hdGqvjEcJ3DYLOhd1RsUsV+1P3AWkv73O
         GoFmB7RMqKPxwgkC68jLHtF5k4MSW+k75OlXiUxw=
Date:   Mon, 11 Sep 2023 18:30:25 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "NeilBrown" <neilb@suse.de>
Cc:     "Chuck Lever III" <chuck.lever@oracle.com>,
        "Chuck Lever" <cel@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        "Liam Howlett" <liam.howlett@oracle.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "David Gow" <davidgow@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 11/17] lib: add light-weight queuing mechanism.
Message-Id: <20230911183025.5f808a70a62df79a3a1e349e@linux-foundation.org>
In-Reply-To: <169447439989.19905.9386812394578844629@noble.neil.brown.name>
References: <169444233785.4327.4365499966926096681.stgit@bazille.1015granger.net>
        <169444318342.4327.18355944158180782708.stgit@bazille.1015granger.net>
        <20230911111333.4d1a872330e924a00acb905b@linux-foundation.org>
        <4D5C2693-40E9-467D-9F2F-59D92CBE9D3B@oracle.com>
        <20230911140439.b273bf9e120881f038da0de7@linux-foundation.org>
        <169447439989.19905.9386812394578844629@noble.neil.brown.name>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 12 Sep 2023 09:19:59 +1000 "NeilBrown" <neilb@suse.de> wrote:

> Plain old list_heads (which the code currently uses) require a spinlock
> to be taken to insert something into the queue.  As this is usually in
> bh context, it needs to be a spin_lock_bh().  My understanding is that
> the real-time developers don't much like us disabling bh.  It isn't an
> enormous win switching from a list_head list to a llist_node list, but
> there are small gains such as object size reduction and less locking.  I
> particularly wanted an easy-to-use library facility that could be
> plugged in to two different uses cases in the sunrpc code and there
> didn't seem to be one.  I could have written one using list_head, but
> llist seemed a better fix.  I think the code in sunrpc that uses this
> lwq looks a lot neater after the conversion.

Thanks.  Could we please get words such as these into the changelog,
describing why it was felt necessary to add more library code?

And also into the .c file, to help people who are looking at it and
wondering "can I use this".  And to help reviewers who are wondering
"could they have used Neil's thing".
