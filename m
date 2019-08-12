Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74E3B8A7AB
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2019 22:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfHLUAi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Aug 2019 16:00:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49456 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbfHLUAh (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 12 Aug 2019 16:00:37 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8EF897BDCE;
        Mon, 12 Aug 2019 20:00:37 +0000 (UTC)
Received: from parsley.fieldses.org (ovpn-122-197.rdu2.redhat.com [10.10.122.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 653311001947;
        Mon, 12 Aug 2019 20:00:37 +0000 (UTC)
Received: by parsley.fieldses.org (Postfix, from userid 2815)
        id BE622180A60; Mon, 12 Aug 2019 16:00:36 -0400 (EDT)
Date:   Mon, 12 Aug 2019 16:00:36 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v5 5/9] NFSD add COPY_NOTIFY operation
Message-ID: <20190812200036.GC29812@parsley.fieldses.org>
References: <20190808201848.36640-1-olga.kornievskaia@gmail.com>
 <20190808201848.36640-6-olga.kornievskaia@gmail.com>
 <CAN-5tyF6ZMf_jiKycK1rk9v7xATDb=j_e5d0QBp9LOgdvn-utA@mail.gmail.com>
 <CAN-5tyEyvjJB+4_bKZmEYhv2KrVvk7dDvF27i6mx4naDt33Nww@mail.gmail.com>
 <20190812200019.GB29812@parsley.fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812200019.GB29812@parsley.fieldses.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 12 Aug 2019 20:00:37 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Aug 12, 2019 at 04:00:19PM -0400, J. Bruce Fields wrote:
> On Mon, Aug 12, 2019 at 03:16:47PM -0400, Olga Kornievskaia wrote:
> > On Mon, Aug 12, 2019 at 12:19 PM Olga Kornievskaia
> > <olga.kornievskaia@gmail.com> wrote:
> > > While this passes my testing, in theory this allows for the race that
> > > we get the copy notify size but then offload_cancel arrive and change
> > > the value. Then refcount_sub_and test_check would have an incorrect
> > > value (can subtract larger than an actual reference count). I have no
> > > solution for that as there is no refcount_sub_and_lock() that will
> > > allow to decrement by a multiple under a lock. Thoughts?
> > 
> > I tried not to use the client's cl_lock but instead use a specific
> > lock to protect the copy notifies stateid on the stateid list. But
> > since stateid's reference counter (sc_count) is protected by it, I
> > think by getting rid of the special lock and using cl_lock will solve
> > the problem of coordinating access between the sc_count and the
> > copy_notify stateid list. Are the any problems with using such a big
> > lock?
> 
> Probably not.  But it can be confusing when a single lock is used for
> several different things.  A comment explaining why you need it might
> help.

(By which I mean, a comment in the code.)

--b.
