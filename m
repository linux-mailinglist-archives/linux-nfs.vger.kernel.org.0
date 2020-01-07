Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46DE1132ADF
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2020 17:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgAGQPh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Jan 2020 11:15:37 -0500
Received: from fieldses.org ([173.255.197.46]:53600 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbgAGQPh (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 7 Jan 2020 11:15:37 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id 6F49C153E; Tue,  7 Jan 2020 11:15:36 -0500 (EST)
Date:   Tue, 7 Jan 2020 11:15:36 -0500
To:     NeilBrown <neilb@suse.de>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH/RFC] NFS: handle NFSv4.1 server that doesn't support
 NFS4_OPEN_CLAIM_DELEG_CUR_FH
Message-ID: <20200107161536.GA944@fieldses.org>
References: <87y2v9fdz8.fsf@notabene.neil.brown.name>
 <3afd2d5c631d8e3429e025e204a7b1c95b3c1415.camel@hammerspace.com>
 <87v9qdf2gh.fsf@notabene.neil.brown.name>
 <d3299fefa94d6959d848b765ce60e2467ce1b253.camel@hammerspace.com>
 <87pngkg9ga.fsf@notabene.neil.brown.name>
 <9f5f220e64245d7f1b0359149876b5dc056dcf12.camel@hammerspace.com>
 <87lfr7fu9v.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lfr7fu9v.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Dec 20, 2019 at 04:19:56PM +1100, NeilBrown wrote:
> I was a bit surprised that nfs4_map_atomic_open_claim() exists at all,
> but given that it did, I assumed it would be used more uniformly.
> 
> So this all implies that Linux NFS server claimed to support NFSv4.1
> before it actually did - which seems odd.  This is just a bug (which are
> expected), but a clear ommission.

For what it's worth, I did make some attempt to keep 4.1 by default
until 3.11 (see d109148111cd "nfsd4: support minorversion 1 by default")
but probably could have communicated that better.  This isn't the only
blatant known issue in older code.

--b.
