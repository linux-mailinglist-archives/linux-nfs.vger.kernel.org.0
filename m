Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8E738B889
	for <lists+linux-nfs@lfdr.de>; Thu, 20 May 2021 22:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbhETUkb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 May 2021 16:40:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:40034 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237358AbhETUkb (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 20 May 2021 16:40:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 446BEABB1;
        Thu, 20 May 2021 20:39:07 +0000 (UTC)
Date:   Thu, 20 May 2021 22:39:05 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Steve Dickson <SteveD@redhat.com>
Cc:     NeilBrown <neilb@suse.de>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Alexey Kodanev <alexey.kodanev@oracle.com>
Subject: Re: [PATCH/RFC v2 nfs-utils] Fix NFSv4 export of tmpfs filesystems.
Message-ID: <YKbI6Sj1QuMq3U4H@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210422191803.31511-1-pvorel@suse.cz>
 <20210422202334.GB25415@fieldses.org>
 <YILQip3nAxhpXP9+@pevik>
 <162035212343.24322.12361160756597283121@noble.neil.brown.name>
 <162122673178.19062.96081788305923933@noble.neil.brown.name>
 <289c5819-917a-39a7-9aa4-2a27ae7248c0@RedHat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <289c5819-917a-39a7-9aa4-2a27ae7248c0@RedHat.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Steve, all,

> Hey!

> On 5/17/21 12:45 AM, NeilBrown wrote:

> > Some filesystems cannot be exported without an fsid or uuid.
> > tmpfs is the main example.

> > When mountd (or exportd) creates nfsv4 pseudo-root exports for the path
> > leading down to an export point it exports each directory without any
> > fsid or uuid.  If one of these directories is on tmp, that will fail.

> > The net result is that exporting a subdirectory of a tmpfs filesystem
> > will not work over NFSv4 as the parents within the filesystem cannot be
> > exported.  It will either fail, or fall-back to NFSv3 (depending on the
> > version of the mount.nfs program).

> > To fix this we need to provide an fsid or uuid for these pseudo-root
> > exports.  This patch does that by creating an RFC-4122 V5 compatible
> > UUID based on an arbitrary seed and the path to the export.

> > To check if an export needs a uuid, text_export() is moved from exportfs
> > to libexport.a, modified slightly and renamed to export_test().
> Well.... it appears you guys did not compile with the --with-systemd
> config flag... Because if you did you would have seeing this compile error
> the in systemd code: 

You're right, I didn't :(.

> /usr/bin/ld: ../support/nfs/.libs/libnfs.a(cacheio.o): in function `stat':
> /usr/include/sys/stat.h:455: undefined reference to `etab'
> collect2: error: ld returned 1 exit status
> make[1]: *** [Makefile:560: nfs-server-generator] Error 1
> make[1]: Leaving directory '/home/src/up/nfs-utils/systemd'
> make: *** [Makefile:479: all-recursive] Error 1

> It turns out the moving of export_test() in to the libexport.a
> is causing any binary linking with libexport.a to have a 
> global definition of struct state_paths etab;

> The reason is export_test() calls qword_add(). Now qword_add()
> does not use an etab, but the file qword_add() lives in is
> cacheio.c which does have a extern struct state_paths etab
> which is the reason libnfs.a(cacheio.o) is mentioned in
> the error. At least that is what I *think* is going on... 
> The extern came from  commit a15bd94.

> Now the work around is to simply define a  
> struct state_paths etab; in nfs-server-generator.c
> which will not be used at least by the systemd code.

> Now is that something we want continue doing... make any
> binaries linking with libexport.a define a global etab.

> It seems a little messy but the interface is not documented
> and the alternative, moving a bunch of code around see a lot
> more messy that simple adding one definition.

+1

Kind regards,
Petr

> Other than not compiling... Things looks good! ;-) 

> Thoughts?

> steved.
...
