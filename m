Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF82D654181
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Dec 2022 14:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbiLVNGS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Dec 2022 08:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbiLVNGR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Dec 2022 08:06:17 -0500
Received: from out20-50.mail.aliyun.com (out20-50.mail.aliyun.com [115.124.20.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937A8186C0
        for <linux-nfs@vger.kernel.org>; Thu, 22 Dec 2022 05:06:14 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04598278|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.472669-0.014453-0.512878;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047203;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.QbPLQDc_1671714371;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.QbPLQDc_1671714371)
          by smtp.aliyun-inc.com;
          Thu, 22 Dec 2022 21:06:12 +0800
Date:   Thu, 22 Dec 2022 21:06:13 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Jeff Layton <jlayton@kernel.org>
Subject: Re: a nfsd_file_free panic when shudown
Cc:     linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <4e218538a081da09ab82b18cf7185602b62c18d7.camel@kernel.org>
References: <20221222173854.61D6.409509F4@e16-tech.com> <4e218538a081da09ab82b18cf7185602b62c18d7.camel@kernel.org>
Message-Id: <20221222210612.729F.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,


> On Thu, 2022-12-22 at 17:38 +0800, Wang Yugui wrote:
> > Hi, Jeff Layton 
> > 
> > > Hi,
> > > > a nfsd_file_free panic when shudown.
> > > > 
> > > > This is a kernel 6.1.1 with some nfsd 6.2 pathes.
> > > > It happened when os shutdown.
> > > > 
> > > > but the reproducer is yet not clear.
> > > > we just gather the info of the attachment file.
> > > 
> > > Now I can reproduce it.
> > > 1)  'tail -f xxx' to keep a file is open from nfs4 client
> > > 2) 'shutdow -r now' the nfs server.
> > > 
> > > more panic info in the attachment files (panic-2.txt/panic-3.txt)
> > > 
> > > > 
> > > > It happened just after 'Subject: nfsd: rework refcounting in filecache'
> > > > is added, so this patch maybe related.
> > 
> > It is confirmed that this panic is caused by the patch
> > 'nfsd: rework refcounting in filecache'.
> > 
> > the problem is 100% reproduced when this patch is applied.
> > the problem is yet not reproduced when this patch is not applied.
> > 
> > Best Regards
> > Wang Yugui (wangyugui@e16-tech.com)
> > 2022/12/22
> > 
> 
> Thanks for the bug report! This patch seems to fix the problem for me.
> Can you test it and let me know whether it also fixes it for you? If so,
> I'll send this to Chuck and the list for inclusion soon.

This new patch fix the problem here too.  Thanks a lot.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/12/22


> 
> Thanks!
> --?
> Jeff Layton <jlayton@kernel.org>
> 
> --------------------8<--------------------------
> 
> [PATCH] nfsd: shut down the NFSv4 state objects before the filecache
> 
> Currently, we shut down the filecache before trying to clean up the
> stateids that depend on it, which can lead to an oops at shutdown time
> due to a refcount imbalance. Change the shutdown procedures to bring
> down the state handling infrastructure prior to shutting down the
> filecache.
> 
> Reported-by: Wang Yugui <wangyugui@e16-tech.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfssvc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 56fba1cba3af..325d3d3f1211 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -453,8 +453,8 @@ static void nfsd_shutdown_net(struct net *net)
>  {
>  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>  
> -	nfsd_file_cache_shutdown_net(net);
>  	nfs4_state_shutdown_net(net);
> +	nfsd_file_cache_shutdown_net(net);
>  	if (nn->lockd_up) {
>  		lockd_down(net);
>  		nn->lockd_up = false;
> -- 
> 2.38.1
> 


