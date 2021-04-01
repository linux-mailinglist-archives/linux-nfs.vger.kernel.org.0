Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969CA3521E8
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Apr 2021 23:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbhDAVws (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Apr 2021 17:52:48 -0400
Received: from icebox.esperi.org.uk ([81.187.191.129]:40730 "EHLO
        mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbhDAVws (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Apr 2021 17:52:48 -0400
Received: from loom (nix@sidle.srvr.nix [192.168.14.8])
        by mail.esperi.org.uk (8.16.1/8.16.1) with ESMTP id 131Lqlqh000324;
        Thu, 1 Apr 2021 22:52:47 +0100
From:   Nix <nix@esperi.org.uk>
To:     "bfields\@fieldses.org" <bfields@fieldses.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs\@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: steam-associated reproducible hard NFSv4.2 client hang (5.9, 5.10)
References: <877dourt7c.fsf@esperi.org.uk>
        <20210223225701.GD8042@fieldses.org>
        <fde7a43ac9b61a1aff53381d0ab7b48b78cb79db.camel@hammerspace.com>
        <20210224020140.GA26848@fieldses.org> <875z16m8oh.fsf@esperi.org.uk>
        <20210401134442.GB13277@fieldses.org>
Emacs:  if SIGINT doesn't work, try a tranquilizer.
Date:   Thu, 01 Apr 2021 22:52:47 +0100
In-Reply-To: <20210401134442.GB13277@fieldses.org> (bfields@fieldses.org's
        message of "Thu, 1 Apr 2021 09:44:42 -0400")
Message-ID: <87eeftlljk.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-DCC--Metrics: loom 1480; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 1 Apr 2021, bfields@fieldses.org outgrape:

> On Thu, Apr 01, 2021 at 02:33:02PM +0100, Nix wrote:
>> [Sorry about the huge delay: your replies got accidentally marked as
>>  read in a MUA snafu. I'll be getting some more debugging dumps -- and
>>  seeing if this still happens! -- when I reboot into 5.11 this weekend.]
>> 
>> On 24 Feb 2021, bfields@fieldses.org said:
>> 
>> > On Tue, Feb 23, 2021 at 11:58:51PM +0000, Trond Myklebust wrote:
>> >> On Tue, 2021-02-23 at 17:57 -0500, J. Bruce Fields wrote:
>> >> > On Sun, Jan 03, 2021 at 02:27:51PM +0000, Nick Alcock wrote:
>> >> > > Relevant exports, from /proc/fs/nfs/exports:
>> >> > > 
>> >> > > /       192.168.16.0/24,silk.wkstn.nix(ro,insecure,no_root_squash,s
>> >> > > ync,no_wdelay,no_subtree_check,v4root,fsid=0,uuid=0a4a4563:00764033
>> >> > > :8c827c0e:989cf534,sec=390003:390004:390005:1)
>> >> > > /home/.loom.srvr.nix    *.srvr.nix,fold.srvr.nix(rw,root_squash,syn
>> >> > > c,wdelay,no_subtree_check,uuid=0a4a4563:00764033:8c827c0e:989cf534,
>> >> > > sec=1)
>> >> 
>> >> Isn't that trying to export the same filesystem as '/' on the line
>> >> above using conflicting export options?
>> 
>> Hmm. I don't actually have a / mount in /etc/exports (and haven't had
>> one since I finished building this machine, last year), and looking at
>> /proc/fs/nfs/exports on the server now, it's not there.
>
> Right, but even though you're not exporting /, you're exporting
> /home/.loom.srvr.nix, and that's on the same filesystem as /, isn't it?

Yes, but I'm *not* exporting /. (I just checked my backups, and no such
export existed at the time I sent the original mail, nor was I importing
it on the client).

This export is prsumably automatically generated, and likely indicates
nothing more than that I am exporting from different subtrees off the
root (which I am: various subdirectories of /home, /usr, /trees,
/.transient, /.nfs, and /pkg are exported).
