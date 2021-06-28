Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A793B699C
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Jun 2021 22:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbhF1UZ7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Jun 2021 16:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhF1UZ6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Jun 2021 16:25:58 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E462DC061574
        for <linux-nfs@vger.kernel.org>; Mon, 28 Jun 2021 13:23:32 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id DA1F94F7D; Mon, 28 Jun 2021 16:23:31 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org DA1F94F7D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1624911811;
        bh=M/ZI+fR7xzOufqjz6CjIM03nGbp0CiJvlYAcVd7HdUc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cUmZ9tY3UBdFMeMdlZBr/P7zrYAJ8k8qdycbynC5cMffoQQ+uyHtkgCqyDnKuIi9e
         hAM6diQkPDggsB4aT6p7vCAjAQGXrL4JXMspbQwmEm4kPzCWAHT4QIvRSWLbkR0G3D
         UgDxaoZe2driIX1n1fwS+VSyqUh30TwRhDAUgDsA=
Date:   Mon, 28 Jun 2021 16:23:31 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC 1/1] nfsd: Initial implementation of NFSv4 Courteous
 Server
Message-ID: <20210628202331.GC6776@fieldses.org>
References: <20210603181438.109851-1-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603181438.109851-1-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 03, 2021 at 02:14:38PM -0400, Dai Ngo wrote:
> @@ -6875,7 +6947,12 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	case -EAGAIN:		/* conflock holds conflicting lock */
>  		status = nfserr_denied;
>  		dprintk("NFSD: nfsd4_lock: conflicting lock found!\n");
> -		nfs4_set_lock_denied(conflock, &lock->lk_denied);
> +
> +		/* try again if conflict with courtesy client  */
> +		if (nfs4_set_lock_denied(conflock, &lock->lk_denied) == -EAGAIN && !retried) {
> +			retried = true;
> +			goto again;
> +		}

Ugh, apologies, this was my idea, but I just noticed it only handles conflicts
from other NFSv4 clients.  The conflicting lock could just as well come from
NLM or a local process.  So we need cooperation from the common locks.c code.

I'm not sure what to suggest....

Maybe something like:

@@ -1159,6 +1159,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
        }
 
        percpu_down_read(&file_rwsem);
+retry:
        spin_lock(&ctx->flc_lock);
        /*
         * New lock request. Walk all POSIX locks and look for conflicts. If
@@ -1169,6 +1170,11 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
                list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
                        if (!posix_locks_conflict(request, fl))
                                continue;
+                       if (fl->fl_lops->fl_expire_lock(fl, 1)) {
+                               spin_unlock(&ctx->flc_lock);
+                               fl->fl_lops->fl_expire_locks(fl, 0);
+                               goto retry;
+                       }
                        if (conflock)
                                locks_copy_conflock(conflock, fl);
                        error = -EAGAIN;


where ->fl_expire_lock is a new lock callback with second argument "check"
where:

	check = 1 means: just check whether this lock could be freed
	check = 0 means: go ahead and free this lock if you can

--b.
