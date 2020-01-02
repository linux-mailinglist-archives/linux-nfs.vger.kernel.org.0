Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D49B12F1CB
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2020 00:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgABXbO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Jan 2020 18:31:14 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:44298 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgABXbO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 2 Jan 2020 18:31:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1578007873; x=1609543873;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fXudtcU/ryZBawNrA9rWmGmiFpp6nuz0owgxhPvOAmI=;
  b=JEgYoncNNfEP5x26yuApw5CMKLSYDvtdxjh5YfhB+W9ne6IoIGQcRwqU
   CPUPSI0Rl62esP1+stERREuckdFkshEcijMxs5fDxZRUP8Q4VsdIApSdD
   IpbNB/Z9ZpUl871bBBKsvpouQSCJZ1ZnjbebzgaCGWfvZuYJnaomTz7J9
   Y=;
IronPort-SDR: 7hLUdf6+W/hbVue1v7zts+KaeEl3RciCKVH7wHJXe2d9LhLBjMfm3s1rvgQaCfU13qdg8k3grt
 xMHcqQWATTPg==
X-IronPort-AV: E=Sophos;i="5.69,388,1571702400"; 
   d="scan'208";a="11342942"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-baacba05.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 02 Jan 2020 23:31:11 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-baacba05.us-west-2.amazon.com (Postfix) with ESMTPS id 25B64A1BFA;
        Thu,  2 Jan 2020 23:31:10 +0000 (UTC)
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 2 Jan 2020 23:31:10 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Thu, 2 Jan 2020 23:31:10 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 58865C28B0; Thu,  2 Jan 2020 23:31:10 +0000 (UTC)
Date:   Thu, 2 Jan 2020 23:31:10 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Olga Kornievskaia <aglo@umich.edu>
CC:     Andreas Gruenbacher <agruen@kernel.org>,
        "J. Bruce Fields" <bfields@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: extended attributes limitation of xattr_size_max
Message-ID: <20200102233109.GA8735@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <CAN-5tyEg2b1CnbJrc-Hf2406cPWCAOjYcpPq0FremYjFXsytDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAN-5tyEg2b1CnbJrc-Hf2406cPWCAOjYcpPq0FremYjFXsytDQ@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jan 02, 2020 at 05:28:44PM -0500, Olga Kornievskaia wrote:
> Hi Andreas and Bruce,
> 
> I thought of you folks as somebody who might have a strong opinion on
> the topic. Right now an NFS client is limited to setting and getting
> ACLs that can't be larger than 64K (XATTR_SIZE_MAX) (where some NFS
> server don't have such limit on the ACL size). There are limits in
> fs/xattr.c during getting and setting xattrs. I believe that's because
> linux local xattr system is limited to that particular constraint.
> However, an NFS acl that uses the xattr interface can be larger than
> that. Is it at all possible to suggest to the larger FS community to
> remove those limits or would that be a non-starter?
> 
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 90dd78f..52a3f91 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -428,8 +428,6 @@ int __vfs_setxattr_noperm(struct dentry *dentry,
> const char *name,
>   return error;
> 
>   if (size) {
> - if (size > XATTR_SIZE_MAX)
> - return -E2BIG;
>   kvalue = kvmalloc(size, GFP_KERNEL);
>   if (!kvalue)
>   return -ENOMEM;
> @@ -528,8 +526,6 @@ static int path_setxattr(const char __user *pathname,
>   return error;
> 
>   if (size) {
> - if (size > XATTR_SIZE_MAX)
> - size = XATTR_SIZE_MAX;
>   kvalue = kvzalloc(size, GFP_KERNEL);
>   if (!kvalue)
>   return -ENOMEM;

Aside from not wanting to allocate a raw amount of kernel memory based
on a system call parameter without any checks, I support the idea :-)

The internal xattr interface can be a little awkward to deal with,
the static upper limit being one of the issues that caused me some
problems when implementing user xattrs for NFS.

In general, I would love to see paged-based xattr kernel interfaces,
treating extended attributes as a secondary data stream, which would
make caching fit in a lot more naturally, and means all FS-specific
caching implementations could be removed in favor of a generic one.

One issue right now is that, an xattr not being a 'stream', a lot
of FS code caches the entire value in kmalloc-ed space, which becomes
unwieldy if the XATTR_SIZE_MAX limit is removed.

In other words, I think removing the limit won't work that well with
the current implementation, but I hope that the implementation can
be changed so that the limit can be removed.

- Frank
