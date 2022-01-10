Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D42489E38
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jan 2022 18:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238152AbiAJRVI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jan 2022 12:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbiAJRVH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jan 2022 12:21:07 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5657CC06173F
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jan 2022 09:21:07 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 5C92A707A; Mon, 10 Jan 2022 12:21:06 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 5C92A707A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1641835266;
        bh=i/eLhivxWIOsQ3+vr/ri2Vj0kJcRQScgKJBOoBwRepE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mj43iiXXHozniwUuR0WRC+lvnePOev+4YMRK2VdEwIvCJ+XPvWnrAwPBAuYFF+kYY
         1cXGekcoOf1YbbywFYFjHuJjG2EmS+3e6T+nmdfOJdfgmF3qrBPteFws6VoIwkwwsF
         Dbfml3nOLg+g2lqoDsh74yGffGd34Kx7Sg5KDQsQ=
Date:   Mon, 10 Jan 2022 12:21:06 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Daire Byrne <daire@dneg.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: nconnect & repeating BIND_CONN_TO_SESSION?
Message-ID: <20220110172106.GC18213@fieldses.org>
References: <CAPt2mGNF=iZkXGa93yjKQG5EsvUucun1TMhN5zM-6Gp07Bni2g@mail.gmail.com>
 <20220107171755.GD26961@fieldses.org>
 <CAPt2mGPtxNzigMEYXKFX0ayVc__gyJcQJVHU51CKqU+ujqh7Cg@mail.gmail.com>
 <20220110145210.GA18213@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110145210.GA18213@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jan 10, 2022 at 09:52:10AM -0500, J. Bruce Fields wrote:
> On Mon, Jan 10, 2022 at 09:21:44AM +0000, Daire Byrne wrote:
> > On Fri, 7 Jan 2022 at 17:17, J. Bruce Fields <bfields@fieldses.org> wrote:
> > >
> > > Hm, doesn't each of these use up a reserved port on the client by
> > > default?  I forget the details of that.  Does "noresvport" help?
> > 
> > Yes, I think this might be the issue. It seems like only 13/16
> > connections actually initially get setup at mount time and then it
> > tries to connect the full 16 once some activity to the mountpoint
> > starts. My guess is that we run out of reserved ports at that point
> > and continually trigger the BIND_CONN_TO_SESSION.
> > 
> > I can use noresvport with an NFSv3 client mount and it seems to do the
> > right thing (with the server exporting "insecure), but it doesn't seem
> > to have any effect on a NFSv4.2 mount (still uses ports <1024). Is
> > that expected?
> 
> No.  Sounds like something's going wrong.

Looks to me like the mount option may just be getting lost on the way
down to the rpc client somehow, but I'm not quite sure how it's supposed
to work, and a naive attempt to copy what v3 is doing (below) wasn't
sufficient.

--b.

diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index d8b5a250ca05..d0196dfb48a1 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -895,7 +895,8 @@ static int nfs4_set_client(struct nfs_server *server,
 		int proto, const struct rpc_timeout *timeparms,
 		u32 minorversion, unsigned int nconnect,
 		unsigned int max_connect,
-		struct net *net)
+		struct net *net,
+		bool noresvport)
 {
 	struct nfs_client_initdata cl_init = {
 		.hostname = hostname,
@@ -915,6 +916,8 @@ static int nfs4_set_client(struct nfs_server *server,
 		__set_bit(NFS_CS_REUSEPORT, &cl_init.init_flags);
 	else
 		cl_init.max_connect = max_connect;
+	if (noresvport)
+		set_bit(NFS_CS_NORESVPORT, &cl_init.init_flags);
 	if (proto == XPRT_TRANSPORT_TCP)
 		cl_init.nconnect = nconnect;
 
@@ -1156,7 +1159,8 @@ static int nfs4_init_server(struct nfs_server *server, struct fs_context *fc)
 				ctx->minorversion,
 				ctx->nfs_server.nconnect,
 				ctx->nfs_server.max_connect,
-				fc->net_ns);
+				fc->net_ns,
+				ctx->flags & NFS_MOUNT_NORESVPORT);
 	if (error < 0)
 		return error;
 
@@ -1246,7 +1250,8 @@ struct nfs_server *nfs4_create_referral_server(struct fs_context *fc)
 				parent_client->cl_mvops->minor_version,
 				parent_client->cl_nconnect,
 				parent_client->cl_max_connect,
-				parent_client->cl_net);
+				parent_client->cl_net,
+				ctx->flags & NFS_MOUNT_NORESVPORT);
 	if (!error)
 		goto init_server;
 #endif	/* IS_ENABLED(CONFIG_SUNRPC_XPRT_RDMA) */
@@ -1262,7 +1267,8 @@ struct nfs_server *nfs4_create_referral_server(struct fs_context *fc)
 				parent_client->cl_mvops->minor_version,
 				parent_client->cl_nconnect,
 				parent_client->cl_max_connect,
-				parent_client->cl_net);
+				parent_client->cl_net,
+				ctx->flags & NFS_MOUNT_NORESVPORT);
 	if (error < 0)
 		goto error;
 
@@ -1335,7 +1341,8 @@ int nfs4_update_server(struct nfs_server *server, const char *hostname,
 	error = nfs4_set_client(server, hostname, sap, salen, buf,
 				clp->cl_proto, clnt->cl_timeout,
 				clp->cl_minorversion,
-				clp->cl_nconnect, clp->cl_max_connect, net);
+				clp->cl_nconnect, clp->cl_max_connect, net,
+				test_bit(NFS_CS_NORESVPORT, &clp->cl_flags));
 	clear_bit(NFS_MIG_TSM_POSSIBLE, &server->mig_status);
 	if (error != 0) {
 		nfs_server_insert_lists(server);
