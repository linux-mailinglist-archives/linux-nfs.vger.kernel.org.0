Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFEA9D1CB
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2019 16:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732564AbfHZOiR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Aug 2019 10:38:17 -0400
Received: from fieldses.org ([173.255.197.46]:46604 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbfHZOiR (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 26 Aug 2019 10:38:17 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id E12333F0; Mon, 26 Aug 2019 10:38:16 -0400 (EDT)
Date:   Mon, 26 Aug 2019 10:38:16 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Alex Lyakas <alex@zadara.com>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        Shyam Kaushik <shyam@zadara.com>
Subject: Re: [RFC-PATCH] nfsd: when unhashing openowners, increment
 openowner's refcount
Message-ID: <20190826143816.GD22759@fieldses.org>
References: <1566406146-7887-1-git-send-email-alex@zadara.com>
 <CAOcd+r0bXefi79dnwrwsDN1OecScfTjc8DYS5_9A8D5XKrh7QQ@mail.gmail.com>
 <20190826133951.GC22759@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826133951.GC22759@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Aug 26, 2019 at 09:39:51AM -0400, J. Bruce Fields wrote:
> On Sun, Aug 25, 2019 at 01:12:34PM +0300, Alex Lyakas wrote:
> > You are listed as maintainers of nfsd. Can you please take a look at
> > the below patch?
> 
> Thanks!
> 
> I take it this was found by some kind of code analysis or fuzzing, not
> use in production?
> 
> Asking because I've been considering just deprecating it, so:

So, unless someone objects I'd like to queue this up for 5.4.

--b.

commit 9d60d93198c6
Author: J. Bruce Fields <bfields@redhat.com>
Date:   Mon Aug 26 10:28:58 2019 -0400

    Deprecate nfsd fault injection
    
    This is only useful for client testing.  I haven't really maintained it,
    and reference counting and locking are wrong at this point.  You can get
    some of the same functionality now from nfsd/clients/.
    
    It was a good idea but I think its time has passed.
    
    In the unlikely event of users, hopefully the BROKEN dependency will
    prompt them to speak up.  Otherwise I expect to remove it soon.
    
    Reported-by: Alex Lyakas <alex@zadara.com>
    Signed-off-by: J. Bruce Fields <bfields@redhat.com>

diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index bff8456220e0..10cefb0c07c7 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -148,7 +148,7 @@ config NFSD_V4_SECURITY_LABEL
 
 config NFSD_FAULT_INJECTION
 	bool "NFS server manual fault injection"
-	depends on NFSD_V4 && DEBUG_KERNEL && DEBUG_FS
+	depends on NFSD_V4 && DEBUG_KERNEL && DEBUG_FS && BROKEN
 	help
 	  This option enables support for manually injecting faults
 	  into the NFS server.  This is intended to be used for
