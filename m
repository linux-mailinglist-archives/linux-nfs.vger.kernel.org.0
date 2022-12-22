Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F63653EEE
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Dec 2022 12:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbiLVLTB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Dec 2022 06:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235465AbiLVLSv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Dec 2022 06:18:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A316928720
        for <linux-nfs@vger.kernel.org>; Thu, 22 Dec 2022 03:18:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2BE1AB81D1C
        for <linux-nfs@vger.kernel.org>; Thu, 22 Dec 2022 11:18:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90576C433D2;
        Thu, 22 Dec 2022 11:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671707918;
        bh=oAMwMlf5lIJMJQt+2SUXxJObeKAH8QFwEoGpX0QuNws=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hIGSKrH7/xVcVm3eDfUjTupBM4FJtTs8kO9oUMILM2YtmHikD5Vz0rolynrhtjw34
         VEd3bpJ3McReatMkbxy68STIzSbhWR1uMZtyuS2IpRCBx/lszfRfveV5mvuBzOmE56
         Nze4O5cqzP1puy2Ic1UOzdJ4a23yNNe7fZMNDZ1W3Ts0Uv8NjRE88bxDLZBjuYf1DG
         eUkp23JJTfD4qO6JpTO2WmD9MV1UqpVv+ycTxqwvEJle1DDFbtP5xpZD9VE0UQvY4p
         UD3QkkNl5kprCTkSLUTEmqi4GfgrKRT5cUQ9TaXRuUJzYa7jo62vK5ks7x6JpAsttP
         xLVH0W0nKx7vg==
Message-ID: <4e218538a081da09ab82b18cf7185602b62c18d7.camel@kernel.org>
Subject: Re: a nfsd_file_free panic when shudown
From:   Jeff Layton <jlayton@kernel.org>
To:     Wang Yugui <wangyugui@e16-tech.com>, linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Thu, 22 Dec 2022 06:18:37 -0500
In-Reply-To: <20221222173854.61D6.409509F4@e16-tech.com>
References: <20221222141515.3AE5.409509F4@e16-tech.com>
         <20221222161514.FC5C.409509F4@e16-tech.com>
         <20221222173854.61D6.409509F4@e16-tech.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2022-12-22 at 17:38 +0800, Wang Yugui wrote:
> Hi, Jeff Layton=20
>=20
> > Hi,
> > > a nfsd_file_free panic when shudown.
> > >=20
> > > This is a kernel 6.1.1 with some nfsd 6.2 pathes.
> > > It happened when os shutdown.
> > >=20
> > > but the reproducer is yet not clear.
> > > we just gather the info of the attachment file.
> >=20
> > Now I can reproduce it.
> > 1)  'tail -f xxx' to keep a file is open from nfs4 client
> > 2) 'shutdow -r now' the nfs server.
> >=20
> > more panic info in the attachment files (panic-2.txt/panic-3.txt)
> >=20
> > Best Regards
> > Wang Yugui (wangyugui@e16-tech.com)
> > 2022/12/22
> >=20
> > >=20
> > > the path list that applied to kernel 6.1.1.
> > > Subject: nfsd: don't call nfsd_file_put from client states seqfile di=
splay
> > > Subject: NFSD: Pass the target nfsd_file to nfsd_commit()
> > > Subject: NFSD: Revert "NFSD: NFSv4 CLOSE should release an nfsd_file
> > > Subject: NFSD: Add an NFSD_FILE_GC flag to enable nfsd_file garbage c=
ollection
> > > Subject: nfsd: fix up the filecache laundrette scheduling
> > > Subject: NFSD: Flesh out a documenting comment for filecache.c
> > > Subject: NFSD: Clean up nfs4_preprocess_stateid_op() call sites
> > > Subject: NFSD: Trace stateids returned via DELEGRETURN
> > > Subject: NFSD: Trace delegation revocations
> > > Subject: NFSD: Use const pointers as parameters to fh_ helpers
> > > Subject: NFSD: Update file_hashtbl() helpers
> > > Subject: NFSD: Clean up nfsd4_init_file()
> > > Subject: NFSD: Add a nfsd4_file_hash_remove() helper
> > > Subject: NFSD: Clean up find_or_add_file()
> > > Subject: NFSD: Refactor find_file()
> > > Subject: NFSD: Use rhashtable for managing nfs4_file objects
> > > Subject: NFSD: Fix licensing header in filecache.c
> > > Subject: nfsd: remove the pages_flushed statistic from filecache
> > > Subject: nfsd: reorganize filecache.c
> > > Subject: NFSD: Add an nfsd_file_fsync tracepoint
> > > Subject: nfsd: rework refcounting in filecache
> > > Subject: nfsd: under NFSv4.1, fix double svc_xprt_put on rpc_create f=
ailure
> > > Subject: NFSD: fix use-after-free in __nfs42_ssc_open()
> > >=20
> > >=20
> > > It happened just after 'Subject: nfsd: rework refcounting in filecach=
e'
> > > is added, so this patch maybe related.
>=20
> It is confirmed that this panic is caused by the patch
> 'nfsd: rework refcounting in filecache'.
>=20
> the problem is 100% reproduced when this patch is applied.
> the problem is yet not reproduced when this patch is not applied.
>=20
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/12/22
>=20

Thanks for the bug report! This patch seems to fix the problem for me.
Can you test it and let me know whether it also fixes it for you? If so,
I'll send this to Chuck and the list for inclusion soon.

Thanks!
--=A0
Jeff Layton <jlayton@kernel.org>

--------------------8<--------------------------

[PATCH] nfsd: shut down the NFSv4 state objects before the filecache

Currently, we shut down the filecache before trying to clean up the
stateids that depend on it, which can lead to an oops at shutdown time
due to a refcount imbalance. Change the shutdown procedures to bring
down the state handling infrastructure prior to shutting down the
filecache.

Reported-by: Wang Yugui <wangyugui@e16-tech.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfssvc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 56fba1cba3af..325d3d3f1211 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -453,8 +453,8 @@ static void nfsd_shutdown_net(struct net *net)
 {
 	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
=20
-	nfsd_file_cache_shutdown_net(net);
 	nfs4_state_shutdown_net(net);
+	nfsd_file_cache_shutdown_net(net);
 	if (nn->lockd_up) {
 		lockd_down(net);
 		nn->lockd_up =3D false;
--=20
2.38.1


