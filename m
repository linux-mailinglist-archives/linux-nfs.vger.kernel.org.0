Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7D5A068D
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2019 17:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfH1Pqt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Aug 2019 11:46:49 -0400
Received: from fieldses.org ([173.255.197.46]:49096 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbfH1Pqt (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 28 Aug 2019 11:46:49 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 0435F7CC; Wed, 28 Aug 2019 11:46:49 -0400 (EDT)
Date:   Wed, 28 Aug 2019 11:46:48 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Rick Macklem <rmacklem@uoguelph.ca>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/3] Handling NFSv3 I/O errors in knfsd
Message-ID: <20190828154648.GB26284@fieldses.org>
References: <20190827145912.GC9804@fieldses.org>
 <1ee75165d548b336f5724b6d655aa2545b9270c3.camel@hammerspace.com>
 <20190828134839.GA26492@fieldses.org>
 <ed2a86da204cbf644ef2dada4bda2b899da48764.camel@redhat.com>
 <45582F32-69C7-4DC8-A608-E45038A44D42@oracle.com>
 <20190828140044.GA14249@parsley.fieldses.org>
 <990B7B57-53B8-4ECB-A08B-1AFD2FCE13A6@oracle.com>
 <31658faabfbe3b4c2925bd899e264adf501fbc75.camel@redhat.com>
 <20190828144031.GB14249@parsley.fieldses.org>
 <YT1PR01MB29075543EF1DD94AE0101631DDA30@YT1PR01MB2907.CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YT1PR01MB29075543EF1DD94AE0101631DDA30@YT1PR01MB2907.CANPRD01.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 28, 2019 at 03:12:26PM +0000, Rick Macklem wrote:
> J. Bruce Fields wrote:
> >On Wed, Aug 28, 2019 at 10:16:09AM -0400, Jeff Layton wrote:
> >> For the most part, these sorts of errors tend to be rare. If it turns
> >> out to be a problem we could consider moving the verifier into
> >> svc_export or something?
> >
> >As Trond says, this isn't really a server implementation issue, it's a
> >protocol issue.  If a client detects when to resend writes by storing a
> >single verifier per server, then returning different verifiers from
> >writes to different exports will have it resending every time it writes
> >to one export then another.
> 
> Well, here's what RFC-1813 says about the write verifier:
>          This cookie must be consistent during a single instance
>          of the NFS version 3 protocol service and must be
>          unique between instances of the NFS version 3 protocol
>          server, where uncommitted data may be lost.
> You could debate what "service" means in the above, but I'd say it isn't "per file".
> 
> However, since there is no way for an NFSv3 client to know what a "server" is,
> the FreeBSD client (and maybe the other *BSD, although I haven't been involved
> in them for a long time) stores the write verifier "per mount".
> --> So, for the FreeBSD client, it is at the granularity of what the NFSv3 client sees as
>      a single file system. (Typically a single file system on the server unless the knfsd
>      plays the game of coalescing multiple file systems by uniquifying the I-node#, etc.)

Oh, well, that would be nice if we could at least count on per-filesystem.

> It is conceivable that some other NFSv3 client might assume "same
> server IP address --> same server" and store it "per server IP", but I
> have no idea if any such client exists.

Hm.

--b.
