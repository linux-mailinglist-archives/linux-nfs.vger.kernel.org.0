Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824243D13F4
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jul 2021 18:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235990AbhGUPkL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 21 Jul 2021 11:40:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60529 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235945AbhGUPkJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 21 Jul 2021 11:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626884446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YkZTscC6KpmV7ZPZQ/arpngaCqGBZg3nbQ0knfcsigA=;
        b=OoNHUArlPziuidJkqum5NZbzWl39kZjrq4df41R5oo6znE6t+yLYc7yQp+RG/+GR/O3JGL
        i4A+KrgqRY9y6V+MOcv+m5i9kIoMjtMX0RYriMvGWgiNuPci8UQwpf51MkFl21mJgESsH4
        ob8TyMIRz1KtdFpJc6sqena2XP/IT7o=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-ryy5jf5DNCCV2_ioW0j_Dg-1; Wed, 21 Jul 2021 12:20:45 -0400
X-MC-Unique: ryy5jf5DNCCV2_ioW0j_Dg-1
Received: by mail-qk1-f198.google.com with SMTP id o14-20020a05620a0d4eb02903a5eee61155so2036953qkl.9
        for <linux-nfs@vger.kernel.org>; Wed, 21 Jul 2021 09:20:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=YkZTscC6KpmV7ZPZQ/arpngaCqGBZg3nbQ0knfcsigA=;
        b=UMzcP7MlPst0jWO5T9sXTwnwIJmCFokk4T/uoUyxISXq4SxRqZ/hjAt52bqAsMwB62
         xsb/PWJ26eyPT3RSSRytikEIhFHlCt40fXxiR2eewp7okPSdDH+kf9ZBWYqUQr+WkIR8
         DW559NzitIYhCr2hIOWJMV68QaVqeeMnT1rmrvSKZOdqzAFUXZobBznBJq4mXdqcbLQj
         GjYW9EWHAXdI/UyMaNPitF8apoRYwd7CryB/LiXDjPIcH/NJScvaOVozh0Z5CM1o9Rui
         1ZT61BLpoD7hN8RFCsBetMabk2Tc3f9stySqX7vqxvHe+m/h2xuPfSCsfmPV4UStYCmp
         tryQ==
X-Gm-Message-State: AOAM530Lp23tvZ9G3OBboSn5vwejGj64X59RrRSqvRMIKFdDBeKclxb8
        NIkvvobGvoAEYPMP9cvqQYTKkzmAUOFCvLOvvKD0tzh+CaH5wQwdO87L64sRmVOfJDdOeTso9ht
        /gVcHATPDgFtrENRaWIhJ
X-Received: by 2002:a0c:a223:: with SMTP id f32mr37104014qva.8.1626884444601;
        Wed, 21 Jul 2021 09:20:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+t6fxG/ixd7o7dlSLuaUhbdIrVbCJpvX027HWNZq9vT5wDnkVq2oxjwvDHG0JV/G1ddMkig==
X-Received: by 2002:a0c:a223:: with SMTP id f32mr37103999qva.8.1626884444411;
        Wed, 21 Jul 2021 09:20:44 -0700 (PDT)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id i4sm9475118qka.130.2021.07.21.09.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 09:20:43 -0700 (PDT)
Message-ID: <35ecb577315f486f1636b2316c2051ad004f6f7b.camel@redhat.com>
Subject: Re: [RFC PATCH 01/12] afs: Sort out symlink reading
From:   Jeff Layton <jlayton@redhat.com>
To:     David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Mike Marshall <hubcap@omnibond.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        devel@lists.orangefs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 21 Jul 2021 12:20:42 -0400
In-Reply-To: <162687508008.276387.6418924257569297305.stgit@warthog.procyon.org.uk>
References: <162687506932.276387.14456718890524355509.stgit@warthog.procyon.org.uk>
         <162687508008.276387.6418924257569297305.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2021-07-21 at 14:44 +0100, David Howells wrote:
> afs_readpage() doesn't get a file pointer when called for a symlink, so
> separate it from regular file pointer handling.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  fs/afs/file.c     |   14 +++++++++-----
>  fs/afs/inode.c    |    6 +++---
>  fs/afs/internal.h |    3 ++-
>  3 files changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/afs/file.c b/fs/afs/file.c
> index ca0d993add65..c9c21ad0e7c9 100644
> --- a/fs/afs/file.c
> +++ b/fs/afs/file.c
> @@ -19,6 +19,7 @@
>  
>  static int afs_file_mmap(struct file *file, struct vm_area_struct *vma);
>  static int afs_readpage(struct file *file, struct page *page);
> +static int afs_symlink_readpage(struct file *file, struct page *page);
>  static void afs_invalidatepage(struct page *page, unsigned int offset,
>  			       unsigned int length);
>  static int afs_releasepage(struct page *page, gfp_t gfp_flags);
> @@ -46,7 +47,7 @@ const struct inode_operations afs_file_inode_operations = {
>  	.permission	= afs_permission,
>  };
>  
> -const struct address_space_operations afs_fs_aops = {
> +const struct address_space_operations afs_file_aops = {
>  	.readpage	= afs_readpage,
>  	.readahead	= afs_readahead,
>  	.set_page_dirty	= afs_set_page_dirty,
> @@ -60,6 +61,12 @@ const struct address_space_operations afs_fs_aops = {
>  	.writepages	= afs_writepages,
>  };
>  
> +const struct address_space_operations afs_symlink_aops = {
> +	.readpage	= afs_symlink_readpage,
> +	.releasepage	= afs_releasepage,
> +	.invalidatepage	= afs_invalidatepage,
> +};
> +
>  static const struct vm_operations_struct afs_vm_ops = {
>  	.fault		= filemap_fault,
>  	.map_pages	= filemap_map_pages,
> @@ -321,7 +328,7 @@ static void afs_req_issue_op(struct netfs_read_subrequest *subreq)
>  	afs_fetch_data(fsreq->vnode, fsreq);
>  }
>  
> -static int afs_symlink_readpage(struct page *page)
> +static int afs_symlink_readpage(struct file *file, struct page *page)
>  {
>  	struct afs_vnode *vnode = AFS_FS_I(page->mapping->host);
>  	struct afs_read *fsreq;


I wonder...would you be better served here by not using page_readlink
for symlinks and instead use simple_get_link and roll your own readlink
operation. It seems a bit more direct, and AFS seems to be the only
caller of page_readlink.

> @@ -386,9 +393,6 @@ const struct netfs_read_request_ops afs_req_ops = {
>  
>  static int afs_readpage(struct file *file, struct page *page)
>  {
> -	if (!file)
> -		return afs_symlink_readpage(page);
> -
>  	return netfs_readpage(file, page, &afs_req_ops, NULL);
>  }
>  
> diff --git a/fs/afs/inode.c b/fs/afs/inode.c
> index bef6f5ccfb09..cf7b66957c6f 100644
> --- a/fs/afs/inode.c
> +++ b/fs/afs/inode.c
> @@ -105,7 +105,7 @@ static int afs_inode_init_from_status(struct afs_operation *op,
>  		inode->i_mode	= S_IFREG | (status->mode & S_IALLUGO);
>  		inode->i_op	= &afs_file_inode_operations;
>  		inode->i_fop	= &afs_file_operations;
> -		inode->i_mapping->a_ops	= &afs_fs_aops;
> +		inode->i_mapping->a_ops	= &afs_file_aops;
>  		break;
>  	case AFS_FTYPE_DIR:
>  		inode->i_mode	= S_IFDIR |  (status->mode & S_IALLUGO);
> @@ -123,11 +123,11 @@ static int afs_inode_init_from_status(struct afs_operation *op,
>  			inode->i_mode	= S_IFDIR | 0555;
>  			inode->i_op	= &afs_mntpt_inode_operations;
>  			inode->i_fop	= &afs_mntpt_file_operations;
> -			inode->i_mapping->a_ops	= &afs_fs_aops;
> +			inode->i_mapping->a_ops	= &afs_symlink_aops;
>  		} else {
>  			inode->i_mode	= S_IFLNK | status->mode;
>  			inode->i_op	= &afs_symlink_inode_operations;
> -			inode->i_mapping->a_ops	= &afs_fs_aops;
> +			inode->i_mapping->a_ops	= &afs_symlink_aops;
>  		}
>  		inode_nohighmem(inode);
>  		break;
> diff --git a/fs/afs/internal.h b/fs/afs/internal.h
> index 791cf02e5696..ccdde00ada8a 100644
> --- a/fs/afs/internal.h
> +++ b/fs/afs/internal.h
> @@ -1050,7 +1050,8 @@ extern void afs_dynroot_depopulate(struct super_block *);
>  /*
>   * file.c
>   */
> -extern const struct address_space_operations afs_fs_aops;
> +extern const struct address_space_operations afs_file_aops;
> +extern const struct address_space_operations afs_symlink_aops;
>  extern const struct inode_operations afs_file_inode_operations;
>  extern const struct file_operations afs_file_operations;
>  extern const struct netfs_read_request_ops afs_req_ops;
> 
> 

Regardless, this is more reasonable than what's there now.

Reviewed-by: Jeff Layton <jlayton@redhat.com>

