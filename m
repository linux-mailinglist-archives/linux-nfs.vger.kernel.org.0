Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98529177B43
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Mar 2020 16:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbgCCP5N (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Mar 2020 10:57:13 -0500
Received: from fieldses.org ([173.255.197.46]:37232 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729553AbgCCP5N (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 3 Mar 2020 10:57:13 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id 4CB3F1C17; Tue,  3 Mar 2020 10:57:13 -0500 (EST)
Date:   Tue, 3 Mar 2020 10:57:13 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: set the server_scope during service startup
Message-ID: <20200303155713.GE17257@fieldses.org>
References: <20200219205215.3429408-1-smayhew@redhat.com>
 <20200219213230.GC23275@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219213230.GC23275@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Feb 19, 2020 at 04:32:30PM -0500, J. Bruce Fields wrote:
> On Wed, Feb 19, 2020 at 03:52:15PM -0500, Scott Mayhew wrote:
> > Currently, nfsd4_encode_exchange_id() encodes the utsname nodename
> > string in the server_scope field.  In a multi-host container
> > environemnt, if an nfsd container is restarted on a different host than
> > it was originally running on, clients will see a server_scope mismatch
> > and will not attempt to reclaim opens.
> > 
> > Instead, set the server_scope while we're in a process context during
> > service startup, so we get the utsname nodename of the current process
> > and store that in nfsd_net.
> 
> Thanks!  Just one nit:
> 
> > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > ---
> >  fs/nfsd/netns.h   | 1 +
> >  fs/nfsd/nfs4xdr.c | 3 ++-
> >  fs/nfsd/nfssvc.c  | 3 +++
> >  3 files changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> > index 2baf32311e00..c6d95700105e 100644
> > --- a/fs/nfsd/netns.h
> > +++ b/fs/nfsd/netns.h
> > @@ -172,6 +172,7 @@ struct nfsd_net {
> >  	unsigned int             longest_chain_cachesize;
> >  
> >  	struct shrinker		nfsd_reply_cache_shrinker;
> > +	char			server_scope[UNX_MAXNODENAME+1];
> >  };
> >  
> >  /* Simple check to find out if a given net was properly initialized */
> > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > index 9761512674a0..209174ee431a 100644
> > --- a/fs/nfsd/nfs4xdr.c
> > +++ b/fs/nfsd/nfs4xdr.c
> > @@ -4005,10 +4005,11 @@ nfsd4_encode_exchange_id(struct nfsd4_compoundres *resp, __be32 nfserr,
> >  	int major_id_sz;
> >  	int server_scope_sz;
> >  	uint64_t minor_id = 0;
> > +	struct nfsd_net *nn = net_generic(SVC_NET(resp->rqstp), nfsd_net_id);
> >  
> >  	major_id = utsname()->nodename;
> >  	major_id_sz = strlen(major_id);
> 
> We should do this one too.  I'll fix that up and apply if that's OK.

And then maybe "server_scope" isn't the best name for the variable any
more.  Applying as below if you don't see any objection.--b.

commit 9eb54e92718a
Author: Scott Mayhew <smayhew@redhat.com>
Date:   Wed Feb 19 15:52:15 2020 -0500

    nfsd: set the server_scope during service startup
    
    Currently, nfsd4_encode_exchange_id() encodes the utsname nodename
    string in the server_scope field.  In a multi-host container
    environemnt, if an nfsd container is restarted on a different host than
    it was originally running on, clients will see a server_scope mismatch
    and will not attempt to reclaim opens.
    
    Instead, set the server_scope while we're in a process context during
    service startup, so we get the utsname nodename of the current process
    and store that in nfsd_net.
    
    Signed-off-by: Scott Mayhew <smayhew@redhat.com>
    [bfields: fix up major_id too]
    Signed-off-by: J. Bruce Fields <bfields@redhat.com>

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 2baf32311e00..09aa545825bd 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -172,6 +172,8 @@ struct nfsd_net {
 	unsigned int             longest_chain_cachesize;
 
 	struct shrinker		nfsd_reply_cache_shrinker;
+	/* utsname taken from the the process that starts the server */
+	char			nfsd_name[UNX_MAXNODENAME+1];
 };
 
 /* Simple check to find out if a given net was properly initialized */
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 9761512674a0..ad38aed6f5c2 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4005,11 +4005,12 @@ nfsd4_encode_exchange_id(struct nfsd4_compoundres *resp, __be32 nfserr,
 	int major_id_sz;
 	int server_scope_sz;
 	uint64_t minor_id = 0;
+	struct nfsd_net *nn = net_generic(SVC_NET(resp->rqstp), nfsd_net_id);
 
-	major_id = utsname()->nodename;
-	major_id_sz = strlen(major_id);
-	server_scope = utsname()->nodename;
-	server_scope_sz = strlen(server_scope);
+	major_id = nn->nfsd_name;
+	major_id_sz = strlen(nn->nfsd_name);
+	server_scope = nn->nfsd_name;
+	server_scope_sz = strlen(nn->nfsd_name);
 
 	p = xdr_reserve_space(xdr,
 		8 /* eir_clientid */ +
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 3b77b904212d..ca9fd348548b 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -749,6 +749,9 @@ nfsd_svc(int nrservs, struct net *net, const struct cred *cred)
 	if (nrservs == 0 && nn->nfsd_serv == NULL)
 		goto out;
 
+	strlcpy(nn->nfsd_name, utsname()->nodename,
+		sizeof(nn->nfsd_name));
+
 	error = nfsd_create_serv(net);
 	if (error)
 		goto out;
