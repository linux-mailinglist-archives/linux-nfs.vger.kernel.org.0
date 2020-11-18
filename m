Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626392B86EC
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Nov 2020 22:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgKRVjq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Nov 2020 16:39:46 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:27538 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgKRVjq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Nov 2020 16:39:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1605735586; x=1637271586;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=CFzTQ+Nhs2AflLk0S9gsqg4iJJjF2NZUiIgRPnV2kKc=;
  b=OoMRv75L+vo1f6bSfbybYdnFG258cj6izqBFCjZZtgPZLSXgP4tqAudZ
   7TFKW/uN1mnQado40vr5m4n9Kx07HsBUIDxzyOnmXy04LIAyTESIdQABR
   UBfZ6gRz9dswkwz7Bb/Me8fTFzkW4/yWZIfm818Hcc/u0cvF6Yy8z76dQ
   4=;
X-IronPort-AV: E=Sophos;i="5.77,488,1596499200"; 
   d="scan'208";a="67282979"
Subject: Re: [PATCH] NFS: Retry the CLOSE if the embedded GETATTR is rejected with
 ERR_STALE
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 18 Nov 2020 21:30:08 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com (Postfix) with ESMTPS id 40F09A0725;
        Wed, 18 Nov 2020 21:29:36 +0000 (UTC)
Received: from EX13D47UWA002.ant.amazon.com (10.43.163.30) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 18 Nov 2020 21:29:36 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D47UWA002.ant.amazon.com (10.43.163.30) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 18 Nov 2020 21:29:36 +0000
Received: from dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com
 (172.22.96.68) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Wed, 18 Nov 2020 21:29:36 +0000
Received: by dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com (Postfix, from userid 4335130)
        id 3967040E2B; Wed, 18 Nov 2020 21:29:35 +0000 (UTC)
Date:   Wed, 18 Nov 2020 21:29:35 +0000
From:   Anchal Agarwal <anchalag@amazon.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <20201118212935.GA12762@dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com>
References: <20201118002431.GA6941@dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com>
 <a0babbb7d58f02769a6ce40d029768e7221acf24.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a0babbb7d58f02769a6ce40d029768e7221acf24.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Nov 18, 2020 at 03:17:20AM +0000, Trond Myklebust wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> 
> 
> 
> On Wed, 2020-11-18 at 00:24 +0000, Anchal Agarwal wrote:
> > If our CLOSE RPC call is rejected with an ERR_STALE error, then we
> > should remove the GETATTR call from the compound RPC and retry.
> > This could happen in a scenario where two clients tries to access
> > the same file. One client opens the file and the other client removes
> > the file while it's opened by first client. When the first client
> > attempts to close the file the server returns ESTALE and the file
> > ends
> > up being leaked on the server. This depends on how nfs server is
> > configured and is not reproducible if running against nfsd.
> 
> That would be a seriously broken server. If you return NFS4ERR_STALE to
> the client, you cannot expect any further interaction with that file
> from the client. It won't try to send CLOSE or DELEGRETURN or any other
> stateful operation.
>
In this scenario, the setup we have at EFS is more of a distributed fashion. Multiple
clients are connected to multiple servers with a common filesystem. So the above
scenario leads to leaked open file handles on the client that tries to close deleted
file. So I was of the view, in that case client could retry close without getattr
in the close sequence without anything to do on server side.

Thanks,
Anchal Agarwal
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
> 
> 
