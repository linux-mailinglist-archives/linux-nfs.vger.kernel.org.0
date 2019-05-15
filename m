Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB61A1F642
	for <lists+linux-nfs@lfdr.de>; Wed, 15 May 2019 16:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfEOOOC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 May 2019 10:14:02 -0400
Received: from fieldses.org ([173.255.197.46]:60774 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbfEOOOB (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 15 May 2019 10:14:01 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 8CAD21D39; Wed, 15 May 2019 10:14:01 -0400 (EDT)
Date:   Wed, 15 May 2019 10:14:01 -0400
To:     Trond Myklebust <trondmy@gmail.com>
Cc:     steved@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH 4/5] Add support for chrooted exports
Message-ID: <20190515141401.GB9291@fieldses.org>
References: <20190514204153.79603-1-trond.myklebust@hammerspace.com>
 <20190514204153.79603-2-trond.myklebust@hammerspace.com>
 <20190514204153.79603-3-trond.myklebust@hammerspace.com>
 <20190514204153.79603-4-trond.myklebust@hammerspace.com>
 <20190514204153.79603-5-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514204153.79603-5-trond.myklebust@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, May 14, 2019 at 04:41:52PM -0400, Trond Myklebust wrote:
> diff --git a/utils/nfsd/nfsd.man b/utils/nfsd/nfsd.man
> index d83ef869d26e..8fb23721daf6 100644
> --- a/utils/nfsd/nfsd.man
> +++ b/utils/nfsd/nfsd.man
> @@ -167,6 +167,10 @@ Setting these to "off" or similar will disable the selected minor
>  versions.  Setting to "on" will enable them.  The default values
>  are determined by the kernel, and usually minor versions default to
>  being enabled once the implementation is sufficiently complete.
> +.B chroot
> +Setting this to a valid path causes the nfs server to act as if the
> +supplied path is being prefixed to all the exported entries.

I don't feel like this is completely clear.  Maybe add an example like:
"If the export file contains a line like "/path *(rw)", clients will
mount "/path" but the filesystem they see will be the one at
"$chroot/path"". ?

--b.
