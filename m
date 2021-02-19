Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6CB320069
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Feb 2021 22:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhBSVwe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Feb 2021 16:52:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39868 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229515AbhBSVwe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 Feb 2021 16:52:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613771468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3H7HSCiAtpk+ifkFKRbfkEQE2Nw6QEyoXEQB+TqDIBg=;
        b=MSzK6f4lU0UeiEn1FVdk6hXiAR0oFzqPrCUAlMt4pNJ6aShbKXn/QmXb0WMepp1DeqfhFt
        Wyrj48c7B5WIXOQQQyKdaQao97yAjT262uagdGVLNdb2x22NAIVRhjd8j3lDysmqYcxlkd
        2qdJmpU0t6Z9wLivwafHG3ucnbtqhKM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-Gbtvn5lIOLmk5H1Af2kaQA-1; Fri, 19 Feb 2021 16:51:06 -0500
X-MC-Unique: Gbtvn5lIOLmk5H1Af2kaQA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 492D8100A61D;
        Fri, 19 Feb 2021 21:51:05 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-113-245.rdu2.redhat.com [10.10.113.245])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 25A5B1A49B;
        Fri, 19 Feb 2021 21:51:05 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 12E18120515; Fri, 19 Feb 2021 16:51:04 -0500 (EST)
Date:   Fri, 19 Feb 2021 16:51:04 -0500
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Calum Mackay <calum.mackay@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH] pynfs: add courteous server tests
Message-ID: <YDAyyOS6SM0wEgWd@pick.fieldses.org>
References: <20210219212447.15549-1-calum.mackay@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219212447.15549-1-calum.mackay@oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Feb 19, 2021 at 09:24:47PM +0000, Calum Mackay wrote:
> Add a first test that simply locks, sleeps for twice the lease period,
> then unlocks.
> 
> Signed-off-by: Calum Mackay <calum.mackay@oracle.com>
> ---
> 
> I plan to add some more tests shortly, but will send what I have now,
> in case it's useful for the upcoming BAT. This first test has been tried
> against Solaris & Linux (discourteous) servers.

Looks good to me.  Thanks!

--b.

> 
>  nfs4.1/server41tests/__init__.py    |  1 +
>  nfs4.1/server41tests/st_courtesy.py | 47 +++++++++++++++++++++++++++++
>  2 files changed, 48 insertions(+)
>  create mode 100644 nfs4.1/server41tests/st_courtesy.py
> 
> diff --git a/nfs4.1/server41tests/__init__.py b/nfs4.1/server41tests/__init__.py
> index a4d7ee65fb5e..ebb4e8847151 100644
> --- a/nfs4.1/server41tests/__init__.py
> +++ b/nfs4.1/server41tests/__init__.py
> @@ -25,4 +25,5 @@ __all__ = ["st_exchange_id.py", # draft 21
>             "st_sparse.py",
>             "st_flex.py",
>             "st_xattr.py",
> +           "st_courtesy.py",
>             ]
> diff --git a/nfs4.1/server41tests/st_courtesy.py b/nfs4.1/server41tests/st_courtesy.py
> new file mode 100644
> index 000000000000..5e13dad44a01
> --- /dev/null
> +++ b/nfs4.1/server41tests/st_courtesy.py
> @@ -0,0 +1,47 @@
> +from .st_create_session import create_session
> +from xdrdef.nfs4_const import *
> +
> +from .environment import check, fail, create_file, open_file, close_file
> +from .environment import open_create_file_op, use_obj
> +from xdrdef.nfs4_type import open_owner4, openflag4, createhow4, open_claim4
> +from xdrdef.nfs4_type import creatverfattr, fattr4, stateid4, locker4, lock_owner4
> +from xdrdef.nfs4_type import open_to_lock_owner4
> +import nfs_ops
> +op = nfs_ops.NFS4ops()
> +import threading
> +
> +
> +def _getleasetime(sess):
> +    res = sess.compound([op.putrootfh(), op.getattr(1 << FATTR4_LEASE_TIME)])
> +    return res.resarray[-1].obj_attributes[FATTR4_LEASE_TIME]
> +
> +def testLockSleepLockU(t, env):
> +    """test server courtesy by having LOCK and LOCKU
> +       in separate compounds, separated by a sleep of twice the lease period
> +
> +    FLAGS: courteous
> +    CODE: COUR1
> +    """
> +    sess1 = env.c1.new_client_session(env.testname(t))
> +
> +    res = create_file(sess1, env.testname(t))
> +    check(res)
> +
> +    fh = res.resarray[-1].object
> +    stateid = res.resarray[-2].stateid
> +    open_to_lock_owner = open_to_lock_owner4( 0, stateid, 0, lock_owner4(0, b"lock1"))
> +    lock_owner = locker4(open_owner=open_to_lock_owner, new_lock_owner=True)
> +    lock_ops = [ op.lock(WRITE_LT, False, 0, NFS4_UINT64_MAX, lock_owner) ]
> +    res = sess1.compound([op.putfh(fh)] + lock_ops)
> +    check(res, NFS4_OK)
> +
> +    lease_time = _getleasetime(sess1)
> +    env.sleep(lease_time * 2, "twice the lease period")
> +
> +    lock_stateid = res.resarray[-1].lock_stateid
> +    lock_ops = [ op.locku(WRITE_LT, 0, lock_stateid, 0, NFS4_UINT64_MAX) ]
> +    res = sess1.compound([op.putfh(fh)] + lock_ops)
> +    check(res, NFS4_OK, warnlist = [NFS4ERR_BADSESSION])
> +
> +    res = close_file(sess1, fh, stateid=stateid)
> +    check(res)
> -- 
> 2.18.4
> 

