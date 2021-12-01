Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E16465951
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Dec 2021 23:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbhLAWgr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Dec 2021 17:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234078AbhLAWgq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Dec 2021 17:36:46 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9C3C061574
        for <linux-nfs@vger.kernel.org>; Wed,  1 Dec 2021 14:33:25 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 996396F29; Wed,  1 Dec 2021 17:33:24 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 996396F29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1638398004;
        bh=+3IMTAt7fjBhPsifRRONZjWtguLX1LrQ4oG97TrBIIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tA2GxjaqeYEhtXwmAFE3vzE03a59zV4o9GDkXvx0P4Lgdy0oDk9ct75UDlsNI+jVf
         p2SXi8SACKyfw9yLCmNgozxbYZ9VXbdz2FN/smAEQdkORdP2x5u4jrCVClRaGYqXB3
         1mCrzj6MD9yWuGvdiZwm0HyW1WkLtXlpGorsip2I=
Date:   Wed, 1 Dec 2021 17:33:24 -0500
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "olivier@bm-services.com" <olivier@bm-services.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "carnil@debian.org" <carnil@debian.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: Kernel panic / list_add corruption when in nfsd4_run_cb_work
Message-ID: <20211201223324.GA29834@fieldses.org>
References: <20201018093903.GA364695@eldamar.lan>
 <YV3vDQOPVgxc/J99@eldamar.lan>
 <3899037dd7d44e879d77bba67b3455ee@bm-services.com>
 <DACA385D-5BBF-46D0-890D-71572BD0CB8A@oracle.com>
 <20211124152947.GA30602@fieldses.org>
 <0dbe620703eb27f36c02b4e001e74d67390bce9e.camel@hammerspace.com>
 <20211124161038.GC30602@fieldses.org>
 <e17bbb0a22b154c77c6ec82aad63424f70bfda94.camel@hammerspace.com>
 <20211124220640.GE30602@fieldses.org>
 <9de992c0e9dc866c08f30587ce3fd99eaea9431a.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9de992c0e9dc866c08f30587ce3fd99eaea9431a.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Nov 24, 2021 at 10:17:51PM +0000, Trond Myklebust wrote:
> On Wed, 2021-11-24 at 17:06 -0500, bfields@fieldses.org wrote:
> > On Wed, Nov 24, 2021 at 05:14:53PM +0000, Trond Myklebust wrote:
> > > It is a little nasty that we hide the list_del() calls in several
> > > levels of function call, so they probably do deserve a comment.
> > > 
> > > That said, if, as in the case here, the delegation was unhashed, we
> > > still end up not calling list_del_init() in
> > > unhash_delegation_locked(),
> > > and since the list_add() is not conditional on it being successful,
> > > the
> > > global list is again corrupted.
> > > 
> > > Yes, it is an unlikely race, but it is possible despite your
> > > change.
> > 
> > Thanks, good point.
> > 
> > Probably not something anyone's actually hitting, but another sign
> > this
> > logic need rethinking.
> > 
> 
> I think it should be sufficient to let the laundromat skip that entry
> and leave it on the list if the unhash_delegation_locked() fails, since
> your fix should then be able to pick the delegation up and destroy it
> safely.
> 
> We can keep the code in __destroy_client() and
> nfs4_state_shutdown_net() unchanged, since those are presumably not
> affected by this race.

I think simplest is just not to put the thing on the lru at all if it's
not hashed:

--b.

commit 5011f84ef05e
Author: J. Bruce Fields <bfields@redhat.com>
Date:   Mon Nov 29 15:08:00 2021 -0500

    nfsd: fix use-after-free due to delegation race
    
    A delegation break could arrive as soon as we've called vfs_setlease.  A
    delegation break runs a callback which immediately (in
    nfsd4_cb_recall_prepare) adds the delegation to del_recall_lru.  If we
    then exit nfs4_set_delegation without hashing the delegation, it will be
    freed as soon as the callback is done with it, without ever being
    removed from del_recall_lru.
    
    Symptoms show up later as use-after-free or list corruption warnings,
    usually in the laundromat thread.
    
    Signed-off-by: J. Bruce Fields <bfields@redhat.com>

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index bfad94c70b84..1956d377d1a6 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1207,6 +1207,11 @@ hash_delegation_locked(struct nfs4_delegation *dp, struct nfs4_file *fp)
 	return 0;
 }
 
+static bool delegation_hashed(struct nfs4_delegation *dp)
+{
+	return !(list_empty(&dp->dl_perfile));
+}
+
 static bool
 unhash_delegation_locked(struct nfs4_delegation *dp)
 {
@@ -1214,7 +1219,7 @@ unhash_delegation_locked(struct nfs4_delegation *dp)
 
 	lockdep_assert_held(&state_lock);
 
-	if (list_empty(&dp->dl_perfile))
+	if (!delegation_hashed(dp))
 		return false;
 
 	dp->dl_stid.sc_type = NFS4_CLOSED_DELEG_STID;
@@ -4598,7 +4603,7 @@ static void nfsd4_cb_recall_prepare(struct nfsd4_callback *cb)
 	 * queued for a lease break. Don't queue it again.
 	 */
 	spin_lock(&state_lock);
-	if (dp->dl_time == 0) {
+	if (delegation_hashed(dp) && dp->dl_time == 0) {
 		dp->dl_time = ktime_get_boottime_seconds();
 		list_add_tail(&dp->dl_recall_lru, &nn->del_recall_lru);
 	}
