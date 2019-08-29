Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A48CA0ED1
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2019 03:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfH2BNS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Aug 2019 21:13:18 -0400
Received: from fieldses.org ([173.255.197.46]:49602 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbfH2BNS (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 28 Aug 2019 21:13:18 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 4ED8B1CB4; Wed, 28 Aug 2019 21:13:17 -0400 (EDT)
Date:   Wed, 28 Aug 2019 21:13:17 -0400
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "aglo@umich.edu" <aglo@umich.edu>,
        "louis.devandiere@atos.net" <louis.devandiere@atos.net>
Subject: Re: Maximum Number of ACL on NFSv4
Message-ID: <20190829011317.GA1982@fieldses.org>
References: <AM5PR0202MB2564874D2AD5845AE3CD13DAE7A10@AM5PR0202MB2564.eurprd02.prod.outlook.com>
 <CAN-5tyHjQfrFU_iGXKSDSLnR6ywXizAqtU=5et1ESgKLCgHkAA@mail.gmail.com>
 <AM5PR0202MB2564D07CBF6B765EDABAAAB1E7A10@AM5PR0202MB2564.eurprd02.prod.outlook.com>
 <20190828180541.GC29148@fieldses.org>
 <CAN-5tyEth0YYiuS0oe8Q_LN-7Z8NXiF3hJPj1sL5MYCXjF-jnQ@mail.gmail.com>
 <20190828192931.GA30217@fieldses.org>
 <848b2abbedb5147e7a7e527111018fb04ec9ed7d.camel@hammerspace.com>
 <20190828210615.GA32010@fieldses.org>
 <a55b35b61987255d51c73d91c3e15fb99621250b.camel@hammerspace.com>
 <20190828214431.GB32010@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828214431.GB32010@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 28, 2019 at 05:44:31PM -0400, bfields@fieldses.org wrote:
> On Wed, Aug 28, 2019 at 09:26:20PM +0000, Trond Myklebust wrote:
> > On Wed, 2019-08-28 at 17:06 -0400, bfields@fieldses.org wrote:
> > > On Wed, Aug 28, 2019 at 08:25:16PM +0000, Trond Myklebust wrote:
> > > > Umm... Don't forget that NFSv4 ACL aces are typically much larger
> > > > than
> > > > POSIX ACL aces because the user/group names are encoded as strings,
> > > > not
> > > > binary uids and gids.
> > > > 
> > > > IOW: The size of the RPC message is likely to be a lot larger than
> > > > the
> > > > resulting POSIX ACL...
> > > 
> > > Actually this limit is post-idmapping, but, yes, before NFSv4->Posix
> > > mapping (complicated in itself), which is why I talked about having
> > > to
> > > estimate.
> > > 
> > > More interested to hear what you think about whether we need a limit
> > > at
> > > all.  Do we have any ideas how big is too big a number to pass to
> > > kmalloc?  Or is it OK to just let anything through and let kmalloc
> > > fail?
> > > 
> > 
> > A NFSv4.x client is always required to respect the max request size as
> > negotiated during CREATE_SESSION, so there is an upper limit right
> > there. On Linux, the client will never try to negotiate a limit greater
> > than 1MB.
> 
> The limit's actually a sanity check on the number of ACEs.  Since that's
> what we're about to use in the kmalloc; in the ACL xdr decoding:
> 
> 	if (nace > NFS4_ACL_MAX)
> 		return nfserr_fbig;
> 
> 	*acl = svcxdr_tmpalloc(argp, nfs4_acl_bytes(nace));
> 
> Maybe the simplest thing is only to reject an nace value that'd be
> impossible given the size of the rpc call.

Or I guess we could realloc as necessary as we actually read the
entries.

But the below seems simplest.  It still provides some check on the ace
count, but it'll ensure we're no longer imposing artificial limits not
already required by the session or the filesystem.

struct nfs4_ace is 20 bytes on my system so in practice this is limiting
that kmalloc to about a megabyte.

--b.

diff --git a/fs/nfsd/acl.h b/fs/nfsd/acl.h
index 4cd7c69a6cb9..ba14d2f4b64f 100644
--- a/fs/nfsd/acl.h
+++ b/fs/nfsd/acl.h
@@ -39,14 +39,6 @@ struct nfs4_acl;
 struct svc_fh;
 struct svc_rqst;
 
-/*
- * Maximum ACL we'll accept from a client; chosen (somewhat
- * arbitrarily) so that kmalloc'ing the ACL shouldn't require a
- * high-order allocation.  This allows 204 ACEs on x86_64:
- */
-#define NFS4_ACL_MAX ((PAGE_SIZE - sizeof(struct nfs4_acl)) \
-			/ sizeof(struct nfs4_ace))
-
 int nfs4_acl_bytes(int entries);
 int nfs4_acl_get_whotype(char *, u32);
 __be32 nfs4_acl_write_who(struct xdr_stream *xdr, int who);
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 565d2169902c..c1fc2641e3e7 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -204,6 +204,13 @@ static __be32 *read_buf(struct nfsd4_compoundargs *argp, u32 nbytes)
 	return p;
 }
 
+static unsigned int compoundargs_bytes_left(struct nfsd4_compoundargs *argp)
+{
+	unsigned int this = (char *)argp->end - (char *)argp->p;
+
+	return this + argp->pagelen;
+}
+
 static int zero_clientid(clientid_t *clid)
 {
 	return (clid->cl_boot == 0) && (clid->cl_id == 0);
@@ -348,7 +355,12 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 		READ_BUF(4); len += 4;
 		nace = be32_to_cpup(p++);
 
-		if (nace > NFS4_ACL_MAX)
+		if (nace > compoundargs_bytes_left(argp)/20)
+			/*
+			 * Even with 4-byte names there wouldn't be
+			 * space for that many aces; something fishy is
+			 * going on:
+			 */
 			return nfserr_fbig;
 
 		*acl = svcxdr_tmpalloc(argp, nfs4_acl_bytes(nace));
