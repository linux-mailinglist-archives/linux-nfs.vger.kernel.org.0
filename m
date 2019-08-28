Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF631A0075
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2019 13:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfH1LGB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Aug 2019 07:06:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59178 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbfH1LGB (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 28 Aug 2019 07:06:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D53278980E2;
        Wed, 28 Aug 2019 11:06:00 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-112-84.rdu2.redhat.com [10.10.112.84])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CA3525C221;
        Wed, 28 Aug 2019 11:05:59 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org, Anna.Schumaker@netapp.com,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH] NFSv3: nfs_instantiate() might succeed leaving dentry
 negative unhashed
Date:   Wed, 28 Aug 2019 07:05:57 -0400
Message-ID: <19F3F549-6C84-4DD6-A8E9-2562DAE70CF0@redhat.com>
In-Reply-To: <720c018fc83192cdea73f8f26ca737e5ac393902.camel@hammerspace.com>
References: <d2076a27c1f3faa0d732e64d49bcbab054cae23b.1566850914.git.bcodding@redhat.com>
 <e3b9ff47b2b195796ac30e8580764ce549d3c325.camel@hammerspace.com>
 <D44A2F26-920E-427A-90E2-D800606EA748@redhat.com>
 <720c018fc83192cdea73f8f26ca737e5ac393902.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Wed, 28 Aug 2019 11:06:01 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 27 Aug 2019, at 7:46, Trond Myklebust wrote:
> On Tue, 2019-08-27 at 06:33 -0400, Benjamin Coddington wrote:
>> On 26 Aug 2019, at 16:39, Trond Myklebust wrote:
>>> If this is a consequence of a race in nfs_instantiate, then why are
>>> we
>>> not fix it there? Won't we otherwise end up having to duplicate the
>>> above code in all the other callers?
>>>
>>> IOW: why not simply modify nfs_instantiate() to return the dentry
>>> from
>>> d_splice_alias(), much like we already do for nfs_lookup()?
>>
>> None of the other callers care about the dentry and it seemed more
>> invasive.
>> It is also an accepted pattern for VFS - that's why Al justified it
>> in
>> b0c6108ecf64.
>
> It is racy, though. Nothing guarantees that a dentry for that file is
> still hashed under the same name when you look it up again, so it is
> better to pass it back directly from the d_splice_alias() call.
>
>> If you'd rather change all the callers, let me know and I can send
>> that.
>
> If you'd prefer not to have to change all the callers, then perhaps
> split the function into two parts:
> - The inner part that returns the dentry from d_splice_alias() on
> success, and which can be called directly from nfs3_do_create().
> - Then a wrapper that works like nfs_instantiate() by dput()ing the
> valid dentry (and returning 0) or otherwise converting the ERR_PTR()
> and returning that.

Ok, sounds fine.

One thing that strikes me as odd is the d_drop() at the top of
nfs_instantiate().  That seems wrong if the next check for positive bypasses
the work of hashing it again.

Can you give me a hint as to why the paths are that way?  Otherwise, I think
it should change as:

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 8d501093660f..7720a19b38d3 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1682,11 +1682,12 @@ int nfs_instantiate(struct dentry *dentry, struct
nfs_fh *fhandle,
        struct dentry *d;
        int error = -EACCES;

-       d_drop(dentry);
-
        /* We may have been initialized further down */
        if (d_really_is_positive(dentry))
                goto out;
+
+       d_drop(dentry);

        if (fhandle->size == 0) {
                error = NFS_PROTO(dir)->lookup(dir, &dentry->d_name,
fhandle, fattr, NULL);
                if (error)

Ben
