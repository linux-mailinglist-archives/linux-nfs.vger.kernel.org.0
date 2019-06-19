Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA5F54C27E
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2019 22:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfFSUnC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jun 2019 16:43:02 -0400
Received: from fieldses.org ([173.255.197.46]:42490 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfFSUnC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 19 Jun 2019 16:43:02 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 93E818BF; Wed, 19 Jun 2019 16:43:01 -0400 (EDT)
Date:   Wed, 19 Jun 2019 16:43:01 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-rdma@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] svcrdma: Ignore source port when computing DRC hash
Message-ID: <20190619204301.GA3044@fieldses.org>
References: <20190611150116.4209.63309.stgit@klimt.1015granger.net>
 <FAF5EE39-8B5D-4F5C-9E9E-8FCA6EED8378@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FAF5EE39-8B5D-4F5C-9E9E-8FCA6EED8378@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jun 19, 2019 at 04:25:57PM -0400, Chuck Lever wrote:
> 
> > On Jun 11, 2019, at 11:01 AM, Chuck Lever <chuck.lever@oracle.com> wrote:
> > 
> > The DRC appears to be effectively empty after an RPC/RDMA transport
> > reconnect. The problem is that each connection uses a different
> > source port, which defeats the DRC hash.
> > 
> > Clients always have to disconnect before they send retransmissions
> > to reset the connection's credit accounting, thus every retransmit
> > on NFS/RDMA will miss the DRC.
> > 
> > An NFS/RDMA client's IP source port is meaningless for RDMA
> > transports. The transport layer typically sets the source port value
> > on the connection to a random ephemeral port. The server already
> > ignores it for the "secure port" check. See commit 16e4d93f6de7
> > ("NFSD: Ignore client's source port on RDMA transports").
> > 
> > The Linux NFS server's DRC resolves XID collisions from the same
> > source IP address by using the checksum of the first 200 bytes of
> > the RPC call header.
> > 
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > Cc: stable@vger.kernel.org # v4.14+
> > ---
> > net/sunrpc/xprtrdma/svc_rdma_transport.c |    7 ++++++-
> > 1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> > index 027a3b0..0004535 100644
> > --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
> > +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> > @@ -211,9 +211,14 @@ static void handle_connect_req(struct rdma_cm_id *new_cma_id,
> > 	/* Save client advertised inbound read limit for use later in accept. */
> > 	newxprt->sc_ord = param->initiator_depth;
> > 
> > -	/* Set the local and remote addresses in the transport */
> > 	sa = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.dst_addr;
> > 	svc_xprt_set_remote(&newxprt->sc_xprt, sa, svc_addr_len(sa));
> > +	/* The remote port is arbitrary and not under the control of the
> > +	 * client ULP. Set it to a fixed value so that the DRC continues
> > +	 * to be effective after a reconnect.
> > +	 */
> > +	rpc_set_port((struct sockaddr *)&newxprt->sc_xprt.xpt_remote, 0);
> > +
> > 	sa = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.src_addr;
> > 	svc_xprt_set_local(&newxprt->sc_xprt, sa, svc_addr_len(sa));
> 
> Hi Bruce, what's the disposition of this patch?

I've queued it up locally for 5.2 and stable.  Apologies, it got a
little buried in my inbox, thanks for the reminder.

--b.
