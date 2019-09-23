Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A506ABB98B
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Sep 2019 18:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbfIWQZj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Sep 2019 12:25:39 -0400
Received: from fieldses.org ([173.255.197.46]:57730 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728457AbfIWQZj (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 23 Sep 2019 12:25:39 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 25B0C8BF; Mon, 23 Sep 2019 12:25:39 -0400 (EDT)
Date:   Mon, 23 Sep 2019 12:25:39 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Alex Lyakas <alex@zadara.com>
Cc:     linux-nfs@vger.kernel.org, Shyam Kaushik <shyam@zadara.com>
Subject: Re: [RFC-PATCH] nfsd: provide a procfs entry to release stateids of
 a particular local filesystem
Message-ID: <20190923162539.GC1228@fieldses.org>
References: <1567518908-1720-1-git-send-email-alex@zadara.com>
 <20190906161236.GF17204@fieldses.org>
 <CAOcd+r0GRaXP3bes2xw6CFJmPJDTfAAMB7j6G3gzCVKDTC8Sgw@mail.gmail.com>
 <20190910202533.GC26695@fieldses.org>
 <8F0FAB980E6F4594A8C61D927FE022E5@alyakaslap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8F0FAB980E6F4594A8C61D927FE022E5@alyakaslap>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Sep 22, 2019 at 09:52:36AM +0300, Alex Lyakas wrote:
> I do see in the code that a delegation stateid also holds an open
> file on the file system. In my experiments, however, the
> nfs4_client::cl_delegations list was always empty. I put an extra
> print to print a warning if it's not, but did not hit this.

Do you know what version of NFS the clients are using?  (4.0, 4.1, 4.2?)

--b.

> 
> Thanks,
> Alex.
> 
> 
> 
> -----Original Message----- From: J. Bruce Fields
> Sent: Tuesday, September 10, 2019 11:25 PM
> To: Alex Lyakas
> Cc: linux-nfs@vger.kernel.org ; Shyam Kaushik
> Subject: Re: [RFC-PATCH] nfsd: provide a procfs entry to release
> stateids of a particular local filesystem
> 
> On Tue, Sep 10, 2019 at 10:00:24PM +0300, Alex Lyakas wrote:
> >I addressed your comments, and ran the patch through checkpatch.pl.
> >Patch v2 is on its way.
> 
> Thanks for the revision!  I need to spend the next week or so catching
> up on some other review and then I'll get back to this.
> 
> For now:
> 
> >On Fri, Sep 6, 2019 at 7:12 PM J. Bruce Fields
> ><bfields@fieldses.org> wrote:
> >> You'll want to cover delegations as well.  And probably pNFS layouts.
> >> It'd be OK to do that incrementally in followup patches.
> >Unfortunately, I don't have much understanding of what these are, and
> >how to cover them)
> 
> Delegations are give the client the right to cache files across opens.
> I'm a little surprised your patches are working for you without handling
> delegations.  There may be something about your environment that's
> preventing delegations from being given out.  In the NFSv4.0 case they
> require the server to make a tcp connection back the client, which is
> easy blocked by firewalls or NAT.  Might be worth testing with v4.1 or
> 4.2.
> 
> Anyway, so we probably also want to walk the client's dl_perclnt list
> and look for matching files.
> 
> --b.
