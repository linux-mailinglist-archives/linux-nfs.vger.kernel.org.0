Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B311D351FBD
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Apr 2021 21:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbhDATZk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Apr 2021 15:25:40 -0400
Received: from icebox.esperi.org.uk ([81.187.191.129]:39802 "EHLO
        mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbhDATZD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Apr 2021 15:25:03 -0400
X-Greylist: delayed 3597 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Apr 2021 15:25:02 EDT
Received: from loom (nix@sidle.srvr.nix [192.168.14.8])
        by mail.esperi.org.uk (8.16.1/8.16.1) with ESMTP id 131DX2qO025000;
        Thu, 1 Apr 2021 14:33:02 +0100
From:   Nix <nix@esperi.org.uk>
To:     "bfields\@fieldses.org" <bfields@fieldses.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs\@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: steam-associated reproducible hard NFSv4.2 client hang (5.9, 5.10)
References: <877dourt7c.fsf@esperi.org.uk>
        <20210223225701.GD8042@fieldses.org>
        <fde7a43ac9b61a1aff53381d0ab7b48b78cb79db.camel@hammerspace.com>
        <20210224020140.GA26848@fieldses.org>
Emacs:  a compelling argument for pencil and paper.
Date:   Thu, 01 Apr 2021 14:33:02 +0100
In-Reply-To: <20210224020140.GA26848@fieldses.org> (bfields@fieldses.org's
        message of "Tue, 23 Feb 2021 21:01:40 -0500")
Message-ID: <875z16m8oh.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-DCC--Metrics: loom 1481; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

[Sorry about the huge delay: your replies got accidentally marked as
 read in a MUA snafu. I'll be getting some more debugging dumps -- and
 seeing if this still happens! -- when I reboot into 5.11 this weekend.]

On 24 Feb 2021, bfields@fieldses.org said:

> On Tue, Feb 23, 2021 at 11:58:51PM +0000, Trond Myklebust wrote:
>> On Tue, 2021-02-23 at 17:57 -0500, J. Bruce Fields wrote:
>> > On Sun, Jan 03, 2021 at 02:27:51PM +0000, Nick Alcock wrote:
>> > > Relevant exports, from /proc/fs/nfs/exports:
>> > > 
>> > > /       192.168.16.0/24,silk.wkstn.nix(ro,insecure,no_root_squash,s
>> > > ync,no_wdelay,no_subtree_check,v4root,fsid=0,uuid=0a4a4563:00764033
>> > > :8c827c0e:989cf534,sec=390003:390004:390005:1)
>> > > /home/.loom.srvr.nix    *.srvr.nix,fold.srvr.nix(rw,root_squash,syn
>> > > c,wdelay,no_subtree_check,uuid=0a4a4563:00764033:8c827c0e:989cf534,
>> > > sec=1)
>> 
>> Isn't that trying to export the same filesystem as '/' on the line
>> above using conflicting export options?

Hmm. I don't actually have a / mount in /etc/exports (and haven't had
one since I finished building this machine, last year), and looking at
/proc/fs/nfs/exports on the server now, it's not there.

The 'v4root' makes me wonder if this was automatically synthesised?

Exports explicitly named in /etc/exports for that machine are:

/home/.loom.srvr.nix -rw,no_subtree_check,sync fold.srvr.nix(root_squash) mutilate(no_root_squash) silk(no_root_squash)
/.nfs/nix/Graphics/Private -no_root_squash,sync,no_subtree_check mutilate(rw) silk(rw)
/.nfs/nix/share/phones -root_squash,async,no_subtree_check fold.srvr.nix(rw) mutilate(rw) silk(rw)
/.nfs/nix/.cache -root_squash,async,no_subtree_check fold.srvr.nix(rw) mutilate(rw) silk(rw)
/.nfs/nix/Mail/nnmh -root_squash,async,no_subtree_check fold.srvr.nix(ro) mutilate(rw) silk(rw)
/.nfs/compiler/.ccache -root_squash,async,no_subtree_check mutilate(rw) silk(rw)
/.nfs/compiler/.cache -root_squash,async,no_subtree_check fold.srvr.nix(rw) mutilate(rw) silk(rw)
/usr/doc -root_squash,no_subtree_check,async mutilate(ro) silk(ro)
/usr/info -root_squash,no_subtree_check,async mutilate(ro) silk(ro)
/usr/share/texlive -no_root_squash,no_subtree_check,async mutilate(rw) silk(rw)
/usr/share/xemacs -no_root_squash,no_subtree_check,async mutilate(rw) silk(rw)
/usr/share/xplanet -root_squash,no_subtree_check,async mutilate(ro) silk(ro)
/usr/share/nethack -root_squash,no_subtree_check,async mutilate(rw) silk(rw)
/pkg/non-free -no_root_squash,no_subtree_check,async mutilate(rw) chronix.wkstn.nix(rw) silk(rw)
/usr/lib/X11/fonts -root_squash,no_subtree_check,async mutilate(ro) silk(ro)
/usr/share/wine -root_squash,no_subtree_check,async mutilate(rw) silk(rw)
/usr/share/clamav -root_squash,no_subtree_check,async mutilate(ro) silk(ro)
/usr/share/emacs/site-lisp -no_root_squash,no_subtree_check,async mutilate(rw) silk(rw)
/usr/archive -root_squash,async,subtree_check mutilate(rw,root_squash,insecure) cinema.srvr.nix(ro,root_squash,insecure) chronix.wkstn.nix(ro) silk(rw,root_squash,insecure)
/usr/archive/music/Pete -root_squash,async,subtree_check mutilate(rw,root_squash,insecure) cinema.srvr.nix(ro,root_squash,insecure) chronix.wkstn.nix(ro) silk(rw,root_squash,insecure)
/var/log.real -root_squash,no_subtree_check,async mutilate(ro) silk(ro)
/etc/shai-hulud -no_root_squash,no_subtree_check,async mutilate(rw) silk(rw)
/usr/src -no_root_squash,no_subtree_check,async mutilate(rw) oracle.vm.nix(rw) 192.168.20.0/24(ro) scratch.vm.nix(rw) ubuntu.vm.nix(rw) cinema.srvr.nix(rw,root_squash) chronix.wkstn.nix(rw,root_squash) silk(rw)
/var/cache/CPAN -no_root_squash,no_subtree_check,async mutilate(rw) silk(rw)
/usr/share/flightgear -root_squash,async,no_subtree_check mutilate(ro) silk(ro)
/usr/local/tmp/encoding/mkv -no_subtree_check,root_squash,ro mutilate.wkstn.nix silk.wkstn.nix
/pkg/non-free/steam -rw,subtree_check,root_squash mutilate.wkstn.nix loom.srvr.nix chronix.wkstn.nix silk.wkstn.nix(insecure)
/.transient/workstations/silk -no_root_squash,async,subtree_check silk(rw)
/trees/mirrors/mutilate silk.wkstn.nix(no_root_squash,async,no_subtree_check,rw)
/trees/mirrors/silk silk.wkstn.nix(no_root_squash,async,no_subtree_check,rw)

... and, well, it's a bit of a mess and there are a lot of them, but
there are no nested mounts there, at least, not outside /usr/archive
which is probably not relevant for this. (The /.nfs stuff is
particularly ugly: if I try to export e.g. /home/nix/.cache rather than
/.nfs/nix/.cache the export simply never appears: /.nfs/$foo is just
built out of bind mounts for this purpose, but then /home/$name is also
a bind mount from /home/.loom.srvr.nix/$name on this network in any
case. /nfs/$foo is usually bind-mounted *back* under /home on the
client, too, but still from NFS's perspective I guess this means they
are distinct? I hope so...)
