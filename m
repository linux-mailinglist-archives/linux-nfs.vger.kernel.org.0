Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F86545C8A6
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Nov 2021 16:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbhKXPc6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Nov 2021 10:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhKXPc5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 24 Nov 2021 10:32:57 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3070CC061574
        for <linux-nfs@vger.kernel.org>; Wed, 24 Nov 2021 07:29:48 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 44C8B14D8; Wed, 24 Nov 2021 10:29:47 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 44C8B14D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1637767787;
        bh=gP3GLVBG4zrhLrPaCxVQ6al9PBUZFocNzSQdIIgSA2A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fWqrj2RkJukHB2AKE1wfXGVzm14lqwLOyKbcy79Zfw9myMh6IGjMoR9ceW0SWNOpP
         q+67BjvgYFfj9uPFDGw/M7HZLiVdAMTKeNWNS1l0MUa9MHqkNQrQNy2PMi3cq8t9Fq
         v8ijpiErj5+fx6LtkyhSx/Mm62nZqiXP4YnIjlZ8=
Date:   Wed, 24 Nov 2021 10:29:47 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Olivier Monaco <olivier@bm-services.com>,
        Salvatore Bonaccorso <carnil@debian.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Kernel panic / list_add corruption when in nfsd4_run_cb_work
Message-ID: <20211124152947.GA30602@fieldses.org>
References: <20201011075913.GA8065@eldamar.lan>
 <20201012142602.GD26571@fieldses.org>
 <20201012154159.GA49819@eldamar.lan>
 <20201012163355.GF26571@fieldses.org>
 <20201018093903.GA364695@eldamar.lan>
 <YV3vDQOPVgxc/J99@eldamar.lan>
 <3899037dd7d44e879d77bba67b3455ee@bm-services.com>
 <DACA385D-5BBF-46D0-890D-71572BD0CB8A@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DACA385D-5BBF-46D0-890D-71572BD0CB8A@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Nov 22, 2021 at 03:17:28PM +0000, Chuck Lever III wrote:
> 
> 
> > On Nov 22, 2021, at 4:15 AM, Olivier Monaco <olivier@bm-services.com> wrote:
> > 
> > Hi,
> > 
> > I think my problem is related to this thread.
> > 
> > We are running a VMware vCenter platform running 9 groups of virtual machines. Each group includes a VM with NFS for file sharing and 3 VMs with NFS clients, so we are running 9 independent file servers.
> 
> I've opened https://bugzilla.linux-nfs.org/show_bug.cgi?id=371
> 
> Just a random thought: would enabling KASAN shed some light?

In fact, we've gotten reports from Redhat QE of a KASAN use-after-free
warning in the laundromat thread, which I think might be the same bug.
We've been getting occasional reports of problems here for a long time,
but they've been very hard to reproduce.

After fooling with their reproducer, I think I finally have it.
Embarrasingly, it's nothing that complicated.  You can make it much
easier to reproduce by adding an msleep call after the vfs_setlease in
nfs4_set_delegation.

If it's possible to run a patched kernel in production, you could try
the following, and I'd definitely be interested in any results.

Otherwise, you can probably work around the problem by disabling
delegations.  Something like

	sudo echo "fs.leases-enable = 0" >/etc/sysctl.d/nfsd-workaround.conf

should do it.

Not sure if this fix is best or if there's something simpler.

--b.

commit 6de51237589e
Author: J. Bruce Fields <bfields@redhat.com>
Date:   Tue Nov 23 22:31:04 2021 -0500

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
index bfad94c70b84..8e063f49240b 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5159,15 +5159,16 @@ nfs4_set_delegation(struct nfs4_client *clp, struct svc_fh *fh,
 		locks_free_lock(fl);
 	if (status)
 		goto out_clnt_odstate;
+
 	status = nfsd4_check_conflicting_opens(clp, fp);
-	if (status)
-		goto out_unlock;
 
 	spin_lock(&state_lock);
 	spin_lock(&fp->fi_lock);
-	if (fp->fi_had_conflict)
+	if (status || fp->fi_had_conflict) {
+		list_del_init(&dp->dl_recall_lru);
+		dp->dl_time++;
 		status = -EAGAIN;
-	else
+	} else
 		status = hash_delegation_locked(dp, fp);
 	spin_unlock(&fp->fi_lock);
 	spin_unlock(&state_lock);
