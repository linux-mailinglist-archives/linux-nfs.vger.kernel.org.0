Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7094C2B9B76
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Nov 2020 20:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgKSTYV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Nov 2020 14:24:21 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:9069 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727645AbgKSTYU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Nov 2020 14:24:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1605813860; x=1637349860;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=mEoh7eXhdYTEZqAjvJi5Bgx4LPvK46HS+yF2R+ciaJc=;
  b=VJ5lwTYk0uotvHw6yyl6RjmYARXkvTmHSQwFit7NIKlaiOTeMxs+G6SH
   1lSlP5kjDO3iF6PWZWzeRwo4Dc1vdUCZzi5UOU0btd0WCaSbZXWUmEqsn
   G2FKumuwnrBO4sUXU0BQBGtJ4tibrg9cO88to9cVqzjhSWXii7U377hiq
   s=;
X-IronPort-AV: E=Sophos;i="5.78,354,1599523200"; 
   d="scan'208";a="64709716"
Subject: Re: [PATCH] NFS: Retry the CLOSE if the embedded GETATTR is rejected with
 ERR_STALE
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-e7be2041.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 19 Nov 2020 19:24:12 +0000
Received: from EX13MTAUEB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-e7be2041.us-west-2.amazon.com (Postfix) with ESMTPS id 84206A17C9;
        Thu, 19 Nov 2020 19:24:10 +0000 (UTC)
Received: from EX13D25UEB002.ant.amazon.com (10.43.60.61) by
 EX13MTAUEB001.ant.amazon.com (10.43.60.129) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 19 Nov 2020 19:24:10 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D25UEB002.ant.amazon.com (10.43.60.61) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 19 Nov 2020 19:24:10 +0000
Received: from dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com
 (172.22.96.68) by mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Thu, 19 Nov 2020 19:24:09 +0000
Received: by dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com (Postfix, from userid 4335130)
        id AB29D4028E; Thu, 19 Nov 2020 19:24:09 +0000 (UTC)
Date:   Thu, 19 Nov 2020 19:24:09 +0000
From:   Anchal Agarwal <anchalag@amazon.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <20201119192409.GA10200@dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com>
References: <20201118002431.GA6941@dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com>
 <a0babbb7d58f02769a6ce40d029768e7221acf24.camel@hammerspace.com>
 <20201118212935.GA12762@dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com>
 <8f08df90240f8a040bec5e7cf8d280aab25f9ead.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8f08df90240f8a040bec5e7cf8d280aab25f9ead.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Nov 18, 2020 at 10:13:16PM +0000, Trond Myklebust wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> 
> 
> 
> On Wed, 2020-11-18 at 21:29 +0000, Anchal Agarwal wrote:
> > On Wed, Nov 18, 2020 at 03:17:20AM +0000, Trond Myklebust wrote:
> > > CAUTION: This email originated from outside of the organization. Do
> > > not click links or open attachments unless you can confirm the
> > > sender and know the content is safe.
> > >
> > >
> > >
> > > On Wed, 2020-11-18 at 00:24 +0000, Anchal Agarwal wrote:
> > > > If our CLOSE RPC call is rejected with an ERR_STALE error, then
> > > > we
> > > > should remove the GETATTR call from the compound RPC and retry.
> > > > This could happen in a scenario where two clients tries to access
> > > > the same file. One client opens the file and the other client
> > > > removes
> > > > the file while it's opened by first client. When the first client
> > > > attempts to close the file the server returns ESTALE and the file
> > > > ends
> > > > up being leaked on the server. This depends on how nfs server is
> > > > configured and is not reproducible if running against nfsd.
> > >
> > > That would be a seriously broken server. If you return
> > > NFS4ERR_STALE to
> > > the client, you cannot expect any further interaction with that
> > > file
> > > from the client. It won't try to send CLOSE or DELEGRETURN or any
> > > other
> > > stateful operation.
> > >
> > In this scenario, the setup we have at EFS is more of a distributed
> > fashion. Multiple
> > clients are connected to multiple servers with a common filesystem.
> > So the above
> > scenario leads to leaked open file handles on the client that tries
> > to close deleted
> > file. So I was of the view, in that case client could retry close
> > without getattr
> > in the close sequence without anything to do on server side.
> 
> 
> If you send the client an NFS4ERR_STALE, you are telling it that its
> access to the file has been revoked. That is not a temporary error, it
> is a fatal one. The client is not responsible for cleaning up any
> state.
>
Ok, I get what you are saying. So from what I am understanding this is not
a valid error to be sent to client on close call and its the server who is doing
something fatally wrong and should be cleaning up its own state or basically not
be allowing to let this scenario happen.
Thanks for bearing with me.

--
Anchal
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
> 
> 
