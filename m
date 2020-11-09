Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09F22AC066
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Nov 2020 17:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbgKIQC6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Nov 2020 11:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729302AbgKIQC6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Nov 2020 11:02:58 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A92BC0613CF
        for <linux-nfs@vger.kernel.org>; Mon,  9 Nov 2020 08:02:58 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id A5203410D; Mon,  9 Nov 2020 11:02:56 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org A5203410D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1604937776;
        bh=7rRZbMVQ9R1NVanfiR3C5AILaE+qcFbAqiBdMCGKDLQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m9asprdr6BP7UF/XlTZ5MTv3iRD8CC0wZiOryyNI4ZPrS8Pz73NjDkNNy+VS2B5Y2
         rgvTL1UMbcrp/tMPh3k0fl5QF7TJc7mgQEO4Z309Y6yOpAg64eBWw7gwF2JjdjdXoR
         IBbSQSNqalL2twRQ8zE5bd0nlua1rsMDT6zCEkNY=
Date:   Mon, 9 Nov 2020 11:02:56 -0500
From:   bfields <bfields@fieldses.org>
To:     Daire Byrne <daire@dneg.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: Adventures in NFS re-exporting
Message-ID: <20201109160256.GB11144@fieldses.org>
References: <943482310.31162206.1599499860595.JavaMail.zimbra@dneg.com>
 <20200915172140.GA32632@fieldses.org>
 <4d1d7cd0076d98973a56e89c92e4ff0474aa0e14.camel@hammerspace.com>
 <1188023047.38703514.1600272094778.JavaMail.zimbra@dneg.com>
 <279389889.68934777.1603124383614.JavaMail.zimbra@dneg.com>
 <635679406.70384074.1603272832846.JavaMail.zimbra@dneg.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <635679406.70384074.1603272832846.JavaMail.zimbra@dneg.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 21, 2020 at 10:33:52AM +0100, Daire Byrne wrote:
> Trond has posted some (v3) patches to emulate lookupp for NFSv3 (a million thanks!) so I applied them to v5.9.1 and ran some more tests using that on the re-export server. Again, I just pathologically dropped inode & dentry caches every second on the re-export server (vfs_cache_pressure=100) while a client looped through some application loading tests.
> 
> Now for every combination of re-export (NFSv3 -> NFSv4.x or NFSv4.x -> NFSv3), I no longer see any stale file handles (/proc/net/rpc/nfsd) when dropping inode & dentry caches (yay!).
> 
> However, my assumption that some of the input/output errors I was seeing were related to the estales seems to have been misguided. After running these tests again without any estales, it now looks like a different issue that is unique to re-exporting NFSv3 from an NFSv4.0 originating server (either Linux or Netapp). The lookups are all fine (no estale) but reading some files eventually gives an input/output error on multiple clients which remain consistent until the re-export nfs-server is restarted. Again, this only occurs while dropping inode + dentry caches.
> 
> So in summary, while continuously dropping inode/dentry caches on the re-export server:

How continuously, exactly?

I recall that there are some situations where the best the client can do
to handle an ESTALE is just retry.  And that our code generally just
retries once and then gives up.

I wonder if it's possible that the client or re-export server can get
stuck in a situation where they can't guarantee forward progress in the
face of repeated ESTALEs.  I don't have a specific case in mind, though.

--b.

> 
> originating server NFSv4.x -> NFSv4.x re-export server = good (no estale, no input/output errors)
> originating server NFSv4.1/4.2 -> NFSv3 re-export server = good
> originating server NFSv4.0 -> NFSv3 re-export server = no estale but lots of input/output errors
> originating server NFSv3 -> NFSv3 re-export server = good (fixed by Trond's lookupp emulation patches)
> originating server NFSv3 -> NFSv4.x re-export server = good (fixed by Trond's lookupp emulation patches)
> 
> In our case, we are stuck with some old 7-mode Netapps so we only have two mount choices, NFSv3 or NFSv4.0 (hence our particular interest in the NFSv4.0 re-export behaviour). And as discussed previously, a re-export of an NFSv3 server requires my horrible hack in order to avoid excessive lookups and client cache invalidations.
> 
> But these lookupp emulation patches fix the ESTALEs for the NFSv3 re-export cases, so many thanks again for that Trond. When re-exporting an NFSv3 client mount, we no longer need to change vfs_cache_pressure=0.
> 
> Daire
