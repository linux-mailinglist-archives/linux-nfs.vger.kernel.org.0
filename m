Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3CE22C3662
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Nov 2020 02:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgKYByF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Nov 2020 20:54:05 -0500
Received: from elasmtp-mealy.atl.sa.earthlink.net ([209.86.89.69]:48780 "EHLO
        elasmtp-mealy.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726298AbgKYByE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Nov 2020 20:54:04 -0500
X-Greylist: delayed 13084 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Nov 2020 20:54:04 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mindspring.com;
        s=dk12062016; t=1606269244; bh=migQkz81kWicdVymydTsI6/MV+Q/8ZBZ/8OO
        M0bVADs=; h=Received:From:To:Cc:References:In-Reply-To:Subject:Date:
         Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
         X-Mailer:Thread-Index:Content-Language:X-ELNK-Trace:
         X-Originating-IP; b=X3KssIG/UCNvznnHBX4t3JOIkRdmlJDBsQ3m2cxVsDFetA
        +9QrsmibtX+O/XBAA8MVFGdwIqKc8NSOLbuk6eoqL28jCkIJkfTrgcb+zeNEFGVWyTP
        C1JeUJysuv0ye2MDOTekGFIH4DbsmXNaGLdshs4By/n+auVwnRoLRjIdqWA5JdRh4L3
        K7a86vsPHTQ8Bpg5mpYRocNDozyTSUM0+2PlwS64p/v8GzHxxIOc8V+cne5xmgGOmXj
        IVBZBuHm1ApUZ7h8SPTW6C7lJqoeSVXkk8jWMqTWlOPR/tbADHwCpBkZWPvihx+K52M
        wzK8EPhM4P93FU8oQ2jQ2k1NK0ag==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk12062016; d=mindspring.com;
  b=RvDhKIIgbQUkWclDZl+V+s9PvPDXoAcDFXTSoteuWdvs1YuBQEzvf+xYqONNJ81vmQmFopSHXhVKISYl62DmAkTdHIpIpEoHbPn5wLxTBchNhuKeK8FrnfnU50AfRxh178CyPExdjhtHiOlXkmRAPFX6Tecwfcl19pQ1wvfUrS7tl33QSER3dgY2ce0I8LxXWGpJU5dK+rSa+to2b74OB3qTqFD1lgprZgWXbow0uSbXKcR2Vj0T8alW5BGTs3mE7eZjS1dGObpl7oWD8EkHz4cdptJ46XaSqdXUUtKbgx0sx+coQE9SYsMA7k3SEKp9vV9+Hkuh7HQwsFS4sy1z7A==;
  h=Received:From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:Thread-Index:Content-Language:X-ELNK-Trace:X-Originating-IP;
Received: from [76.105.143.216] (helo=FRANKSTHINKPAD)
        by elasmtp-mealy.atl.sa.earthlink.net with esmtpa (Exim 4)
        (envelope-from <ffilzlnx@mindspring.com>)
        id 1khgbN-000CgU-J5; Tue, 24 Nov 2020 17:15:57 -0500
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'bfields'" <bfields@fieldses.org>,
        "'Daire Byrne'" <daire@dneg.com>
Cc:     "'Trond Myklebust'" <trondmy@hammerspace.com>,
        "'linux-cachefs'" <linux-cachefs@redhat.com>,
        "'linux-nfs'" <linux-nfs@vger.kernel.org>
References: <943482310.31162206.1599499860595.JavaMail.zimbra@dneg.com> <20200915172140.GA32632@fieldses.org> <4d1d7cd0076d98973a56e89c92e4ff0474aa0e14.camel@hammerspace.com> <1188023047.38703514.1600272094778.JavaMail.zimbra@dneg.com> <279389889.68934777.1603124383614.JavaMail.zimbra@dneg.com> <635679406.70384074.1603272832846.JavaMail.zimbra@dneg.com> <20201109160256.GB11144@fieldses.org> <1744768451.86186596.1605186084252.JavaMail.zimbra@dneg.com> <1055884313.92996091.1606250106656.JavaMail.zimbra@dneg.com> <20201124211522.GC7173@fieldses.org>
In-Reply-To: <20201124211522.GC7173@fieldses.org>
Subject: RE: Adventures in NFS re-exporting
Date:   Tue, 24 Nov 2020 14:15:57 -0800
Message-ID: <0fc201d6c2af$62b039f0$2810add0$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQFnsTuWEsgY2WPwTcQ0fYvcmUGZKgIMJHTNAj0KZ+kC20c0vQH6EgB+ATmqgtcBmvnx5gFd2itFAYsKXvUCY0qgxqor/wtQ
Content-Language: en-us
X-ELNK-Trace: 136157f01908a8929c7f779228e2f6aeda0071232e20db4d40750170795307db90ea33c32f0615bb350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 76.105.143.216
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> On Tue, Nov 24, 2020 at 08:35:06PM +0000, Daire Byrne wrote:
> > Sometimes I have seen clusters of 16 GETATTRs for the same file on the
> > wire with nothing else inbetween. So if the re-export server is the
> > only "client" writing these files to the originating server, why do we
> > need to do so many repeat GETATTR calls when using nconnect>1? And why
> > are the COMMIT calls required when the writes are coming via nfsd but
> > not from userspace on the re-export server? Is that due to some sort
> > of memory pressure or locking?
> >
> > I picked the NFSv3 originating server case because my head starts to
> > hurt tracking the equivalent packets, stateids and compound calls with
> > NFSv4. But I think it's mostly the same for NFSv4. The writes through
> > the re-export server lead to lots of COMMITs and (double) GETATTRs but
> > using nconnect>1 at least doesn't seem to make it any worse like it
> > does for NFSv3.
> >
> > But maybe you actually want all the extra COMMITs to help better
> > guarantee your writes when putting a re-export server in the way?
> > Perhaps all of this is by design...
> 
> Maybe that's close-to-open combined with the server's tendency to
open/close
> on every IO operation?  (Though the file cache should have helped with
that, I
> thought; as would using version >=4.0 on the final
> client.)
> 
> Might be interesting to know whether the nocto mount option makes a
> difference.  (So, add "nocto" to the mount options for the NFS mount that
> you're re-exporting on the re-export server.)
> 
> By the way I made a start at a list of issues at
> 
> 	http://wiki.linux-nfs.org/wiki/index.php/NFS_re-export
> 
> but I was a little vague on which of your issues remained and didn't take
much
> time over it.
> 
> (If you want an account on that wiki BTW I seem to recall you just have to
ask
> Trond (for anti-spam reasons).)

How much conversation about re-export has been had at the wider NFS
community level? I have an interest because Ganesha  supports re-export via
the PROXY_V3 and PROXY_V4 FSALs. We currently don't have a data cache though
there has been discussion of such, we do have attribute and dirent caches.

Looking over the wiki page, I have considered being able to specify a
re-export of a Ganesha export without encapsulating handles. Ganesha
encapsulates the export_fs handle in a way that could be coordinated between
the original server and the re-export so they would both effectively have
the same encapsulation layer.

I'd love to see some re-export best practices shared among server
implementations, and also what we can do to improve things when two server
implementations are interoperating via re-export.

Frank

