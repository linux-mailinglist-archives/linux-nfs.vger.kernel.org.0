Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84308119B1
	for <lists+linux-nfs@lfdr.de>; Thu,  2 May 2019 15:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfEBNEY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 May 2019 09:04:24 -0400
Received: from verein.lst.de ([213.95.11.211]:59177 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbfEBNEY (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 2 May 2019 09:04:24 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id B32F368AFE; Thu,  2 May 2019 15:04:05 +0200 (CEST)
Date:   Thu, 2 May 2019 15:04:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/4] 9p: pass the correct prototype to read_cache_page
Message-ID: <20190502130405.GA2679@lst.de>
References: <20190501160636.30841-1-hch@lst.de> <20190501173443.GA19969@lst.de> <AEBFD2FC-F94A-4E5B-8E1C-76380DDEB46E@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AEBFD2FC-F94A-4E5B-8E1C-76380DDEB46E@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, May 02, 2019 at 12:08:29AM -0600, William Kucharski wrote:
> 1) You need to pass "filp" rather than "filp->private_data" to read_cache_pages()
> in v9fs_fid_readpage().

With this patch v9fs_fid_readpage takes a void pointer that must be
a FID, and we pass the FID everywhere:

 - v9fs_vfs_readpage passes filp->private_data
 - v9fs_vfs_readpages passes filp->private_data through
   read_cache_pages
 - v9fs_write_begin passes the local fid variable


> 
> The patched code passes "filp->private_data" as the "data" parameter to
> read_cache_pages(), which would generate a call to:
> 
>     filler(data, page)
> 
> which would become a call to:
> 
> static int v9fs_vfs_readpage(struct file *filp, struct page *page)
> {	
>         return v9fs_fid_readpage(filp->private_data, page);
> }

Except that we don't pass v9fs_vfs_readpage as the filler any more,
we now pass v9fs_fid_readpage.
