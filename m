Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACA8351BCA
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Apr 2021 20:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbhDASLE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Apr 2021 14:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238170AbhDASFi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Apr 2021 14:05:38 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5F1C08EC3D
        for <linux-nfs@vger.kernel.org>; Thu,  1 Apr 2021 06:44:43 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 7893E6D19; Thu,  1 Apr 2021 09:44:42 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 7893E6D19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1617284682;
        bh=o7/zNVLaslc33ZPtpR4CWCWsbUS2OhkHiVpqWm3INJs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EkBLvBrQTSTrmeXd6tW6iHIh1LT3sb58lWttmiYMe4tkIWw3cyr+sC0tKjpZ+RXrG
         EimY3amhAqYrIP9BKFzkvrCSJCmFKAxrMOq7TdhK59/Ycea7Jxi64nEG1+guKeIMNP
         GDjv0zSNk7cEGis01MHz4Pod40LXx7y80Iqv0qZE=
Date:   Thu, 1 Apr 2021 09:44:42 -0400
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Nix <nix@esperi.org.uk>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: steam-associated reproducible hard NFSv4.2 client hang (5.9,
 5.10)
Message-ID: <20210401134442.GB13277@fieldses.org>
References: <877dourt7c.fsf@esperi.org.uk>
 <20210223225701.GD8042@fieldses.org>
 <fde7a43ac9b61a1aff53381d0ab7b48b78cb79db.camel@hammerspace.com>
 <20210224020140.GA26848@fieldses.org>
 <875z16m8oh.fsf@esperi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875z16m8oh.fsf@esperi.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Apr 01, 2021 at 02:33:02PM +0100, Nix wrote:
> [Sorry about the huge delay: your replies got accidentally marked as
>  read in a MUA snafu. I'll be getting some more debugging dumps -- and
>  seeing if this still happens! -- when I reboot into 5.11 this weekend.]
> 
> On 24 Feb 2021, bfields@fieldses.org said:
> 
> > On Tue, Feb 23, 2021 at 11:58:51PM +0000, Trond Myklebust wrote:
> >> On Tue, 2021-02-23 at 17:57 -0500, J. Bruce Fields wrote:
> >> > On Sun, Jan 03, 2021 at 02:27:51PM +0000, Nick Alcock wrote:
> >> > > Relevant exports, from /proc/fs/nfs/exports:
> >> > > 
> >> > > /       192.168.16.0/24,silk.wkstn.nix(ro,insecure,no_root_squash,s
> >> > > ync,no_wdelay,no_subtree_check,v4root,fsid=0,uuid=0a4a4563:00764033
> >> > > :8c827c0e:989cf534,sec=390003:390004:390005:1)
> >> > > /home/.loom.srvr.nix    *.srvr.nix,fold.srvr.nix(rw,root_squash,syn
> >> > > c,wdelay,no_subtree_check,uuid=0a4a4563:00764033:8c827c0e:989cf534,
> >> > > sec=1)
> >> 
> >> Isn't that trying to export the same filesystem as '/' on the line
> >> above using conflicting export options?
> 
> Hmm. I don't actually have a / mount in /etc/exports (and haven't had
> one since I finished building this machine, last year), and looking at
> /proc/fs/nfs/exports on the server now, it's not there.

Right, but even though you're not exporting /, you're exporting
/home/.loom.srvr.nix, and that's on the same filesystem as /, isn't it?

--b.

> 
> The 'v4root' makes me wonder if this was automatically synthesised?
> 
> Exports explicitly named in /etc/exports for that machine are:
> 
> /home/.loom.srvr.nix -rw,no_subtree_check,sync fold.srvr.nix(root_squash) mutilate(no_root_squash) silk(no_root_squash)
> /.nfs/nix/Graphics/Private -no_root_squash,sync,no_subtree_check mutilate(rw) silk(rw)
> /.nfs/nix/share/phones -root_squash,async,no_subtree_check fold.srvr.nix(rw) mutilate(rw) silk(rw)
> /.nfs/nix/.cache -root_squash,async,no_subtree_check fold.srvr.nix(rw) mutilate(rw) silk(rw)
> /.nfs/nix/Mail/nnmh -root_squash,async,no_subtree_check fold.srvr.nix(ro) mutilate(rw) silk(rw)
> /.nfs/compiler/.ccache -root_squash,async,no_subtree_check mutilate(rw) silk(rw)
> /.nfs/compiler/.cache -root_squash,async,no_subtree_check fold.srvr.nix(rw) mutilate(rw) silk(rw)
> /usr/doc -root_squash,no_subtree_check,async mutilate(ro) silk(ro)
> /usr/info -root_squash,no_subtree_check,async mutilate(ro) silk(ro)
> /usr/share/texlive -no_root_squash,no_subtree_check,async mutilate(rw) silk(rw)
> /usr/share/xemacs -no_root_squash,no_subtree_check,async mutilate(rw) silk(rw)
> /usr/share/xplanet -root_squash,no_subtree_check,async mutilate(ro) silk(ro)
> /usr/share/nethack -root_squash,no_subtree_check,async mutilate(rw) silk(rw)
> /pkg/non-free -no_root_squash,no_subtree_check,async mutilate(rw) chronix.wkstn.nix(rw) silk(rw)
> /usr/lib/X11/fonts -root_squash,no_subtree_check,async mutilate(ro) silk(ro)
> /usr/share/wine -root_squash,no_subtree_check,async mutilate(rw) silk(rw)
> /usr/share/clamav -root_squash,no_subtree_check,async mutilate(ro) silk(ro)
> /usr/share/emacs/site-lisp -no_root_squash,no_subtree_check,async mutilate(rw) silk(rw)
> /usr/archive -root_squash,async,subtree_check mutilate(rw,root_squash,insecure) cinema.srvr.nix(ro,root_squash,insecure) chronix.wkstn.nix(ro) silk(rw,root_squash,insecure)
> /usr/archive/music/Pete -root_squash,async,subtree_check mutilate(rw,root_squash,insecure) cinema.srvr.nix(ro,root_squash,insecure) chronix.wkstn.nix(ro) silk(rw,root_squash,insecure)
> /var/log.real -root_squash,no_subtree_check,async mutilate(ro) silk(ro)
> /etc/shai-hulud -no_root_squash,no_subtree_check,async mutilate(rw) silk(rw)
> /usr/src -no_root_squash,no_subtree_check,async mutilate(rw) oracle.vm.nix(rw) 192.168.20.0/24(ro) scratch.vm.nix(rw) ubuntu.vm.nix(rw) cinema.srvr.nix(rw,root_squash) chronix.wkstn.nix(rw,root_squash) silk(rw)
> /var/cache/CPAN -no_root_squash,no_subtree_check,async mutilate(rw) silk(rw)
> /usr/share/flightgear -root_squash,async,no_subtree_check mutilate(ro) silk(ro)
> /usr/local/tmp/encoding/mkv -no_subtree_check,root_squash,ro mutilate.wkstn.nix silk.wkstn.nix
> /pkg/non-free/steam -rw,subtree_check,root_squash mutilate.wkstn.nix loom.srvr.nix chronix.wkstn.nix silk.wkstn.nix(insecure)
> /.transient/workstations/silk -no_root_squash,async,subtree_check silk(rw)
> /trees/mirrors/mutilate silk.wkstn.nix(no_root_squash,async,no_subtree_check,rw)
> /trees/mirrors/silk silk.wkstn.nix(no_root_squash,async,no_subtree_check,rw)
> 
> ... and, well, it's a bit of a mess and there are a lot of them, but
> there are no nested mounts there, at least, not outside /usr/archive
> which is probably not relevant for this. (The /.nfs stuff is
> particularly ugly: if I try to export e.g. /home/nix/.cache rather than
> /.nfs/nix/.cache the export simply never appears: /.nfs/$foo is just
> built out of bind mounts for this purpose, but then /home/$name is also
> a bind mount from /home/.loom.srvr.nix/$name on this network in any
> case. /nfs/$foo is usually bind-mounted *back* under /home on the
> client, too, but still from NFS's perspective I guess this means they
> are distinct? I hope so...)
