Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4416AF242
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Sep 2019 22:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbfIJUZe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Sep 2019 16:25:34 -0400
Received: from fieldses.org ([173.255.197.46]:33118 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbfIJUZe (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 10 Sep 2019 16:25:34 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id B96291B96; Tue, 10 Sep 2019 16:25:33 -0400 (EDT)
Date:   Tue, 10 Sep 2019 16:25:33 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Alex Lyakas <alex@zadara.com>
Cc:     linux-nfs@vger.kernel.org, Shyam Kaushik <shyam@zadara.com>
Subject: Re: [RFC-PATCH] nfsd: provide a procfs entry to release stateids of
 a particular local filesystem
Message-ID: <20190910202533.GC26695@fieldses.org>
References: <1567518908-1720-1-git-send-email-alex@zadara.com>
 <20190906161236.GF17204@fieldses.org>
 <CAOcd+r0GRaXP3bes2xw6CFJmPJDTfAAMB7j6G3gzCVKDTC8Sgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOcd+r0GRaXP3bes2xw6CFJmPJDTfAAMB7j6G3gzCVKDTC8Sgw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Sep 10, 2019 at 10:00:24PM +0300, Alex Lyakas wrote:
> I addressed your comments, and ran the patch through checkpatch.pl.
> Patch v2 is on its way.

Thanks for the revision!  I need to spend the next week or so catching
up on some other review and then I'll get back to this.

For now:

> On Fri, Sep 6, 2019 at 7:12 PM J. Bruce Fields <bfields@fieldses.org> wrote:
> > You'll want to cover delegations as well.  And probably pNFS layouts.
> > It'd be OK to do that incrementally in followup patches.
> Unfortunately, I don't have much understanding of what these are, and
> how to cover them)

Delegations are give the client the right to cache files across opens.
I'm a little surprised your patches are working for you without handling
delegations.  There may be something about your environment that's
preventing delegations from being given out.  In the NFSv4.0 case they
require the server to make a tcp connection back the client, which is
easy blocked by firewalls or NAT.  Might be worth testing with v4.1 or
4.2.

Anyway, so we probably also want to walk the client's dl_perclnt list
and look for matching files.

--b.
