Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 023CF286698
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Oct 2020 20:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbgJGSLf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Oct 2020 14:11:35 -0400
Received: from elasmtp-kukur.atl.sa.earthlink.net ([209.86.89.65]:43136 "EHLO
        elasmtp-kukur.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727304AbgJGSLc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Oct 2020 14:11:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mindspring.com;
        s=dk12062016; t=1602094291; bh=Br2rQD3jMrNv1NIprJ/zpYYldTSj0JrSsG/J
        2UvF43A=; h=Received:From:To:Cc:References:In-Reply-To:Subject:Date:
         Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
         X-Mailer:Thread-Index:Content-Language:X-ELNK-Trace:
         X-Originating-IP; b=M2dRqrDoHRVA3nQPGOjt52Ka9gtsZU8DfpQt0loZsVrjqn
        BclkwiiEjKeLiDtHKhcbChzJJ5hFx20h7P1R8xYigTCjfC/WJyjRViJY9E3Spvip0/V
        rB2F2xaktGP8PeX36kCZKN/O/0llnccWcvPfT1fIa66U1bXJFbvwQdadftF2LKMMC/w
        yjmrNdTLm7PAAhLHoMLQzrqX5MkgD6fgL9TXNGHgdQt0a9zglwzrWkpl7xCIB1RYS0u
        FLJq0F0x8zz5aQ/nB2tnj/yp06eTyoze9Ty1OL1dlTd/EQJ0X/a5okXCiZR0qMlAhdu
        viNxNB0Nn+lbESSNJDZv+RMEeoBg==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk12062016; d=mindspring.com;
  b=eepsTJ3GHXkt86KVfUy75FEoSoZLOknLpyHKq3eKMXCQee0UIDg9zqHZi0RS0VNLwxjO4UQnTKU5nyZ/6HnkRhXY4IUpZvSjpV42J8h/euQJXZb/d+X32+GhfNnHgZc6ZAgXMfFLFse7j4d/F6UeM8dwijwMKaVlYdYGxwlnHuY5obiFgd9CcLrp2wk4XsM06NJZK20SWMiwUbMi43EzEQy8PU550dYzKMScwUflQt1p53IFyk8kgq3LabP+1dS/thoRWz1BbBIuxNkae1yBNRI0HRH/ZP9iNd8sPaFzFaW/VpGcWBo14VnkfqHDSKwbPPSP3m8OGtaYYaJ4DNIxgQ==;
  h=Received:From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:Thread-Index:Content-Language:X-ELNK-Trace:X-Originating-IP;
Received: from [76.105.143.216] (helo=FRANKSTHINKPAD)
        by elasmtp-kukur.atl.sa.earthlink.net with esmtpa (Exim 4)
        (envelope-from <ffilzlnx@mindspring.com>)
        id 1kQDuR-0007Mj-8K; Wed, 07 Oct 2020 14:11:27 -0400
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'Chuck Lever'" <chuck.lever@oracle.com>
Cc:     "'Bruce Fields'" <bfields@fieldses.org>,
        "'Kenneth Johansson'" <ken@kenjo.org>,
        "'Patrick Goetz'" <pgoetz@math.utexas.edu>,
        "'Linux NFS Mailing List'" <linux-nfs@vger.kernel.org>
References: <0ba0cd0c-eccd-2362-9958-23cd1fa033df@kenjo.org> <5326b6a3-0222-fc1a-6baa-ae2fbdaf209d@math.utexas.edu> <923003de-7fcf-abee-07a2-0691b25673d8@kenjo.org> <20201006181454.GB32640@fieldses.org> <07f3684e-482e-dc73-5c9a-b7c9329fc410@kenjo.org> <20201007131037.GA23452@fieldses.org> <031501d69cb6$f6843a10$e38cae30$@mindspring.com> <1FB71E67-8814-4C62-A9E0-CF7A4D10735F@oracle.com>
In-Reply-To: <1FB71E67-8814-4C62-A9E0-CF7A4D10735F@oracle.com>
Subject: RE: nfs home directory and google chrome.
Date:   Wed, 7 Oct 2020 11:11:25 -0700
Message-ID: <033c01d69cd5$46358cd0$d2a0a670$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQLIQ3s6wHv8ZbLs/sGOp0WaWyTAbgDSaKHBAKEdRl0BxfAQ1wDdQHzFAlI6bMQBwRKqywIRpzX7p1dFNGA=
Content-Language: en-us
X-ELNK-Trace: 136157f01908a8929c7f779228e2f6aeda0071232e20db4d22e5b4ff68ebbcf3cf52a10ebb9bf3db350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 76.105.143.216
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> -----Original Message-----
> From: Chuck Lever [mailto:chuck.lever@oracle.com]
> Sent: Wednesday, October 7, 2020 8:40 AM
> To: Frank Filz <ffilzlnx@mindspring.com>
> Cc: Bruce Fields <bfields@fieldses.org>; Kenneth Johansson
<ken@kenjo.org>;
> Patrick Goetz <pgoetz@math.utexas.edu>; Linux NFS Mailing List <linux-
> nfs@vger.kernel.org>
> Subject: Re: nfs home directory and google chrome.
> 
> 
> 
> > On Oct 7, 2020, at 10:34 AM, Frank Filz <ffilzlnx@mindspring.com> wrote:
> >
> >> -----Original Message-----
> >> From: J. Bruce Fields [mailto:bfields@fieldses.org] Maybe I
> >> overlooked the obvious: if Chrome holds a lock on that file when you
> >> suspend, and if you stay in suspend for longer than the NFSv4 lease
> >> time (default
> >> 90 seconds), then the client will lose its lease, hence any file
> >> locks.  I think these days the client then returns EIO on any further
IO to that
> file descriptor.
> >>
> >> Maybe there's some way to turn off that locking as a workaround.
> >>
> >> The simplest thing we can do to help might be implementing "courteous
> server"
> >> behavior: instead of automatically removing locks after a client's
> >> lease expires, it can wait until there's an actual lock conflict.
> >> That might be enough for your case.
> >>
> >> There's been a little planning done and it's not a big project, but I
> >> don't think it's actually at the top of anyone's todo list right now,
> >> so I'm not sure when that will get done.
> >
> > I've had courtesy locks on my back burner for Ganesha though I hadn't
thought
> about that there might actually be an important practical issue.
> 
> We've found that instantly bringing the hammer down on NFSv4 leases has
> negative operational consequences in environments where minutes-long
> network partitions are part of life.
> 
> Extending the lease period impacts the length an NFS server is in grace
after a
> reboot, so it's not always a good solution.
> 
> 
> > Does any other server implement them? If we suggest this as a solution
to the
> Chrome suspend issue, it might be good to assure that the major server
vendors
> implement this.
> 
> We think OnTAP does, at least.
> 
> 
> > There is a problem with the courtesy locks for this solution though...
The
> clientid is still going to be expired, and the locks are associated with
the clientid,
> so unless we allow courtesy re-instatement of expired clientids, courtesy
locks
> don't actually solve the problem...
> 
> An NFSv4 server is not required to expire a lease after the lease period
expires.
> 
> A courteous server would simply allow a conflicting lock request to take
an
> expired lock after a client's lease expired. If no conflicting lock
operations occur,
> then the missing client could come back and find its lease state intact
(unless of
> course the server has restarted or purged the lease for other reasons).
> 
> Oracle has an open design document that can be posted here for more
> comment and review. We agree that this is much better server behavior and
> would like more server implementations to adopt it.

Ah that document would be helpful. Does the document discuss conditions
where a server might abandon a courtesy hold on a client id and expire it
out anyway? For example, to conserve resources.

Thanks

Frank

