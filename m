Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C7E352FA5
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Apr 2021 21:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235938AbhDBTVC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Apr 2021 15:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhDBTVB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 2 Apr 2021 15:21:01 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AACC0613E6
        for <linux-nfs@vger.kernel.org>; Fri,  2 Apr 2021 12:21:00 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 18070449B; Fri,  2 Apr 2021 15:20:59 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 18070449B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1617391259;
        bh=ur+7PZL1ihxU9tiacpQ/5rYrTABPUZEJmNKSidvHBnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iYo8TyUFIIutkgTz2/T6p8aJTeOuEVtx4G7y0/dY8BhtMLW5njVSArDe4TGHVnrGK
         /+nb99G9wCqN6Kbvh3M6Ejwufx1aCwqZvq/dqZLJ+QNzlxwl9HVj7LJ3EVylka6pKx
         dMbuWcib5vMhnXBDPdQ+xdlc23f8MUxPm2xs05yQ=
Date:   Fri, 2 Apr 2021 15:20:59 -0400
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Nix <nix@esperi.org.uk>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: steam-associated reproducible hard NFSv4.2 client hang (5.9,
 5.10)
Message-ID: <20210402192059.GA16427@fieldses.org>
References: <877dourt7c.fsf@esperi.org.uk>
 <20210223225701.GD8042@fieldses.org>
 <fde7a43ac9b61a1aff53381d0ab7b48b78cb79db.camel@hammerspace.com>
 <20210224020140.GA26848@fieldses.org>
 <875z16m8oh.fsf@esperi.org.uk>
 <20210401134442.GB13277@fieldses.org>
 <87eeftlljk.fsf@esperi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87eeftlljk.fsf@esperi.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Apr 01, 2021 at 10:52:47PM +0100, Nix wrote:
> On 1 Apr 2021, bfields@fieldses.org outgrape:
> 
> > On Thu, Apr 01, 2021 at 02:33:02PM +0100, Nix wrote:
> >> [Sorry about the huge delay: your replies got accidentally marked as
> >>  read in a MUA snafu. I'll be getting some more debugging dumps -- and
> >>  seeing if this still happens! -- when I reboot into 5.11 this weekend.]
> >> 
> >> On 24 Feb 2021, bfields@fieldses.org said:
> >> 
> >> > On Tue, Feb 23, 2021 at 11:58:51PM +0000, Trond Myklebust wrote:
> >> >> On Tue, 2021-02-23 at 17:57 -0500, J. Bruce Fields wrote:
> >> >> > On Sun, Jan 03, 2021 at 02:27:51PM +0000, Nick Alcock wrote:
> >> >> > > Relevant exports, from /proc/fs/nfs/exports:
> >> >> > > 
> >> >> > > /       192.168.16.0/24,silk.wkstn.nix(ro,insecure,no_root_squash,s
> >> >> > > ync,no_wdelay,no_subtree_check,v4root,fsid=0,uuid=0a4a4563:00764033
> >> >> > > :8c827c0e:989cf534,sec=390003:390004:390005:1)
> >> >> > > /home/.loom.srvr.nix    *.srvr.nix,fold.srvr.nix(rw,root_squash,syn
> >> >> > > c,wdelay,no_subtree_check,uuid=0a4a4563:00764033:8c827c0e:989cf534,
> >> >> > > sec=1)
> >> >> 
> >> >> Isn't that trying to export the same filesystem as '/' on the line
> >> >> above using conflicting export options?
> >> 
> >> Hmm. I don't actually have a / mount in /etc/exports (and haven't had
> >> one since I finished building this machine, last year), and looking at
> >> /proc/fs/nfs/exports on the server now, it's not there.
> >
> > Right, but even though you're not exporting /, you're exporting
> > /home/.loom.srvr.nix, and that's on the same filesystem as /, isn't it?
> 
> Yes, but I'm *not* exporting /. (I just checked my backups, and no such
> export existed at the time I sent the original mail, nor was I importing
> it on the client).
> 
> This export is prsumably automatically generated, and likely indicates
> nothing more than that I am exporting from different subtrees off the
> root (which I am: various subdirectories of /home, /usr, /trees,
> /.transient, /.nfs, and /pkg are exported).

Right, the "/" export is automatically generated.

I don't have any real hypothesis here, I'm just thinking if the server's
failing to reply, one possible culprit is that it's waiting for
rpc.mountd.  The server depends on rpc.mountd for export information.
And it sounds like you have a relatively complicated export setup, so
there's perhaps more that could go wrong there.

Might be worth, on the server:

	rpcdebug -m rpc -s cache

and then dumping the contents of all the files /proc/net/rpc/*/content.
That should show us whether the server's waiting on userspace helpers
for anything.

Sorry, did you say whether nfsd threads or rpc.mountd are blocked?

--b.
