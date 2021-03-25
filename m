Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A633497FB
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Mar 2021 18:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbhCYR0w (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Mar 2021 13:26:52 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:8643 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhCYR0m (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 25 Mar 2021 13:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1616693202; x=1648229202;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wd1BvgQdWL0MLoNsn1WXyqQWkLt6/5B9VkeL90ESwP4=;
  b=SMknaQxJMF3IGzJpMtGZUlR6+LXm/C15UOjeIDWqyNv9EqLQWy0n94TT
   gAkNXDdBaiYvcf5k2Si2K8XJ8BCWD80ZDnWHOyf+klVyOQJUOTvbRuhBj
   /PupEqaMvKcos6FPbD4T6c2sOjU4EQc2VwKlOpNsuF7EiZL6Hs96SHogc
   w=;
X-IronPort-AV: E=Sophos;i="5.81,278,1610409600"; 
   d="scan'208";a="123064685"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-57e1d233.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 25 Mar 2021 17:26:41 +0000
Received: from EX13MTAUEB002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1e-57e1d233.us-east-1.amazon.com (Postfix) with ESMTPS id 045801417BE;
        Thu, 25 Mar 2021 17:26:41 +0000 (UTC)
Received: from EX13D28UEB001.ant.amazon.com (10.43.60.81) by
 EX13MTAUEB002.ant.amazon.com (10.43.60.12) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 25 Mar 2021 17:26:39 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D28UEB001.ant.amazon.com (10.43.60.81) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 25 Mar 2021 17:26:39 +0000
Received: from dev-dsk-gerardu-1d-3da90cb4.us-east-1.amazon.com
 (10.200.231.78) by mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Thu, 25 Mar 2021 17:26:39 +0000
Received: by dev-dsk-gerardu-1d-3da90cb4.us-east-1.amazon.com (Postfix, from userid 5408343)
        id 97F08317; Thu, 25 Mar 2021 17:26:39 +0000 (UTC)
Date:   Thu, 25 Mar 2021 17:26:39 +0000
From:   Geert Jansen <gerardu@amazon.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: RFC: return d_type for non-plus READDIR
Message-ID: <20210325172639.GA79259@gerardu>
References: <20210323010057.GA129497@dev-dsk-gerardu-1d-3da90cb4.us-east-1.amazon.com>
 <689DD4DF-17C0-4776-BE53-7F10F7FFE720@oracle.com>
 <20210324014713.GA44499@gerardu>
 <C70E02C8-DCB9-4096-B917-591A4EE21D76@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <C70E02C8-DCB9-4096-B917-591A4EE21D76@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck,

On Wed, Mar 24, 2021 at 01:50:52PM +0000, Chuck Lever III wrote:
 
> "How much of a problem is it" -- I guess what I really want to
> see is some quantification of the problem, in numbers.
> 
> - Exactly which workloads benefit from having the DT information?
> - How much do they improve?
> - Which workloads are negatively impacted, and how much?
> - How are workloads impacted if the client requests DT
> information from servers that cannot support it efficiently?
> 
> Seems to me there will be some caching effects -- there are at
> least two caches between the server's persistent storage and the
> application. So I expect this will be a complex situation, at
> best.

Customer applications that would benefit are those that periodically need to
scan a tree with large directories, e.g. to find new files for document
exchange or messaging applications. Most of the apps that I've seen do this
were custom developed. Some standard CLI apps also fall in this category,
including "find" (with no predicates other than for type and name), and
"updatedb". 

How much do these improve? I think there are three cases. On EFS:

- Case 1: READDIR returns DT_UNKNOWN. The client needs to do a stat() for
every entry to get the file type. Throughput is approximately 2K
entries/sec.
- Case 2: READDIR returns the actual d_type, but the server gets d_type
by reading the dirent inodes. Throughput is approximately 18K entries/s.
- Case 3: READDIR returns the actual d_type and does not need to read
inodes. Throughput is 200K entries/s.

(Caveat: EFS does not currently store d_type in our directories, so I did a
related test that should give the same results. For cases 2 and 3, I
measured a regular non-plus READDIR and tested it against two server
configurations, one where the server reads all dirent inodes and just
discards the results, and one where it does not read any inodes.)

If the server stores d_type in its directories, then the only negative
impact that I can think of would be the extra 4 bytes for each dirent in the
NFS response. The exact overhead depends on the file size, but should be
typically be less than 5-7% depending on file name size. On the other hand,
if requesting d_type requires the server to read inodes, where previously it
did not, then there's an 11x throughput regression (scenario 3 vs 2).

Regarding caching, yes, great question. This was something we looked into as
well. In our tests, reading dirent inodes only when needed (i.e. for
READDIRPLUS) got us an overall better cache hit rate, which we explained due
to lower pressure on the cache. That's a second reason why we want to only
request d_type if it's not going to force the server to read all inodes.

> So, alternatives might be:
> - Always requesting the DT information
> - Leveraging an existing mount option, like lookupcache=
> - A sysfs setting or a module parameter
> - A heuristic to guess when requesting the information is harmful
> - Enabling the request based on directory size or some other static
> feature of the directory
> - If this information is of truly great benefit, approaching server
> vendors to support it efficiently, and then have it always enabled
> on clients
> 
> Adding an administrative knob means we don't have a good understanding
> of how this setting is going to work. As an experimental feature, this
> is a great way to go, but for a permanent, long-term thing, let's keep
> in mind that client administration is a resource that has to scale
> well to cohorts of 100s of thousands of systems. The simpler and more
> automatic we can make it, the better off it will be for everyone.

Thanks for that! I'd be interested to hear if you think our data above is
compelling enough. Ideally we'd find a way to do this approach
experimentally at first. Whether we can make it a default, or whether we
need a way to discover the capbility, would depend on how other server
vendors handle this.

Geert
