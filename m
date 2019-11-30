Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECA410DF22
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Nov 2019 20:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfK3T6H (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 30 Nov 2019 14:58:07 -0500
Received: from fieldses.org ([173.255.197.46]:44838 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbfK3T6H (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 30 Nov 2019 14:58:07 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id 58348150A; Sat, 30 Nov 2019 14:58:07 -0500 (EST)
Date:   Sat, 30 Nov 2019 14:58:07 -0500
To:     kbuild test robot <lkp@intel.com>
Cc:     Trond Myklebust <trondmy@gmail.com>, kbuild-all@lists.01.org,
        "J. Bruce Fields" <bfields@redhat.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: Ensure CLONE persists data and metadata changes to
 the target file
Message-ID: <20191130195807.GA19460@fieldses.org>
References: <20191127220551.36159-1-trond.myklebust@hammerspace.com>
 <201911290023.E0Ae2YFx%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201911290023.E0Ae2YFx%lkp@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Nov 29, 2019 at 01:53:13AM +0800, kbuild test robot wrote:
>    fs//nfsd/vfs.c: In function 'nfsd4_clone_file_range':
> >> fs//nfsd/vfs.c:540:5: error: 'commit_is_datasync' undeclared (first use in this function); did you mean 'commit_metadata'?
...
>    539			int status = vfs_fsync_range(dst, dst_pos, dst_end,
>  > 540					commit_is_datasync);

I've replaced commit_is_datasync by 0.  Trond, correct me if I got that
wrong.

--b.

>    541			if (status < 0)
>    542				return nfserrno(status);
>    543		}
>    544		return 0;
>    545	}
>    546	
> 
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology Center
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation


