Return-Path: <linux-nfs+bounces-11142-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C73DDA8A89E
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Apr 2025 21:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A1B43A3B46
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Apr 2025 19:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D815236431;
	Tue, 15 Apr 2025 19:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z4ZOuSjd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E406221549
	for <linux-nfs@vger.kernel.org>; Tue, 15 Apr 2025 19:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744747036; cv=none; b=gFiJBRHOlDIlB0Puv+6D+2d21IXF9yYTWoKpPyMq4Mzds+RDIMD/ANfP6y5s9uavnSAOJdmds2moo8MqdqoE/N3vR8Byz6j6CZr83PaIEtmrEnaCn19HmjRzTH0AqXjg3LEcujpvKjmdf2tJjFH0NQ6GFHdtL+T5pf+nGHXjueU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744747036; c=relaxed/simple;
	bh=jtaTGp2oWUstTk7YXI1Tgt5M3j+GP2T6KETqcJeSjfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GhW45AWuyxF+c75E9MdzxA0xNzF6MBvldBRGhPeoqijapDk+pzLKPWtbVIOKGDaGTNa2EZospk/mHqXB3x9e0IDGEOj60KueWZ/z1qkKJ3VmtnS2EciA5LBu2kgHWRlGzTa46DwY3kpTVG5keaNIhaLNTDxTn+R+jCV/a50/VeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z4ZOuSjd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744747033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KAAmttPKjpgLRaHDsA6XFVY5pxRH5AlJbPWbGbNk1eA=;
	b=Z4ZOuSjdQmm/8crolgTsEZ81TyQ0gWzc8EpofMxn4amhRFrYwii488W/TXhKx+Y5B5HAvc
	e/99NYqSd9vwehQuVYAWCYPWNVhdKjj+c0BrPNXY87mMOjSBXkcgC6D9lSW9TYbHG+/JKl
	gJfCpGEa+qYavDh5FU/zo/PKb0Swk8I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-56UlnMUhPB6P0NaU_z9hGA-1; Tue,
 15 Apr 2025 15:56:19 -0400
X-MC-Unique: 56UlnMUhPB6P0NaU_z9hGA-1
X-Mimecast-MFC-AGG-ID: 56UlnMUhPB6P0NaU_z9hGA_1744746978
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A4A7A1955BC5;
	Tue, 15 Apr 2025 19:56:18 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.64.98])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 09E6719560AD;
	Tue, 15 Apr 2025 19:56:18 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id 27FB6340E0B; Tue, 15 Apr 2025 15:56:16 -0400 (EDT)
Date: Tue, 15 Apr 2025 15:56:16 -0400
From: Scott Mayhew <smayhew@redhat.com>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: trondmy@kernel.org, anna@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFSv4: xattr handlers should check for absent nfs
 filehandles
Message-ID: <Z_654AzXgl06DShO@aion>
References: <20250411201612.2993634-1-smayhew@redhat.com>
 <2ae4daaf-5e6e-41d4-9d22-2fcda3246bd3@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ae4daaf-5e6e-41d4-9d22-2fcda3246bd3@oracle.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Mon, 14 Apr 2025, Anna Schumaker wrote:

> Hi Scott,
> 
> On 4/11/25 4:16 PM, Scott Mayhew wrote:
> > The nfs inodes for referral anchors that have not yet been followed have
> > their filehandles zeroed out.
> > 
> > Attempting to call getxattr() on one of these will cause the nfs client
> > to send a GETATTR to the nfs server with the preceding PUTFH sans
> > filehandle.  The server will reply NFS4ERR_NOFILEHANDLE, leading to -EIO
> > being returned to the application.
> > 
> > For example:
> > 
> > $ strace -e trace=getxattr getfattr -n system.nfs4_acl /mnt/t/ref
> > getxattr("/mnt/t/ref", "system.nfs4_acl", NULL, 0) = -1 EIO (Input/output error)
> > /mnt/t/ref: system.nfs4_acl: Input/output error
> > +++ exited with 1 +++
> > 
> > Have the xattr handlers return -ENODATA instead.
> 
> This looks like a lot of repeated code. I was wondering if there is a way to
> do this with a helper function that returns -ENODATA? Or could it be checked
> inside nfs4_proc_set_acl() / nfs4_proc_get_acl() / nfs4_server_supports_acls()
> to cut down on duplication?

I'll move the check down into nfs4_proc_set_acl() /
nfs4_proc_get_acl().

> 
> > 
> > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > ---
> >  fs/nfs/nfs4proc.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 71 insertions(+)
> > 
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index 970f28dbf253..a01592930370 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -7933,6 +7933,11 @@ static int nfs4_xattr_set_nfs4_acl(const struct xattr_handler *handler,
> >  				   const char *key, const void *buf,
> >  				   size_t buflen, int flags)
> >  {
> > +	struct nfs_fh *fh = NFS_FH(inode);
> > +
> > +	if (unlikely(fh->size == 0))
> > +		return -ENODATA;
> > +
> >  	return nfs4_proc_set_acl(inode, buf, buflen, NFS4ACL_ACL);
> >  }
> >  
> > @@ -7940,11 +7945,21 @@ static int nfs4_xattr_get_nfs4_acl(const struct xattr_handler *handler,
> >  				   struct dentry *unused, struct inode *inode,
> >  				   const char *key, void *buf, size_t buflen)
> >  {
> > +	struct nfs_fh *fh = NFS_FH(inode);
> > +
> > +	if (unlikely(fh->size == 0))
> > +		return -ENODATA;
> > +
> >  	return nfs4_proc_get_acl(inode, buf, buflen, NFS4ACL_ACL);
> >  }
> >  
> >  static bool nfs4_xattr_list_nfs4_acl(struct dentry *dentry)
> >  {
> > +	struct nfs_fh *fh = NFS_FH(d_inode(dentry));
> > +
> > +	if (unlikely(fh->size == 0))
> > +		return -ENODATA;
> 
> Note that the return value of this function is a boolean, and not an integer,
> so callers probably won't care about a specific return value.

Doh!  I blame the fact that I was fighting a severe head and chest cold
last week.  After a fresh look, I don't think we need to change the list
handlers at all - those get called by the listxattr inode operation,
which nfs_referral_inode_operations does not have.

-Scott
> 
> > +
> >  	return nfs4_server_supports_acls(NFS_SB(dentry->d_sb), NFS4ACL_ACL);
> >  }
> >  
> > @@ -7957,6 +7972,11 @@ static int nfs4_xattr_set_nfs4_dacl(const struct xattr_handler *handler,
> >  				    const char *key, const void *buf,
> >  				    size_t buflen, int flags)
> >  {
> > +	struct nfs_fh *fh = NFS_FH(inode);
> > +
> > +	if (unlikely(fh->size == 0))
> > +		return -ENODATA;
> > +
> >  	return nfs4_proc_set_acl(inode, buf, buflen, NFS4ACL_DACL);
> >  }
> >  
> > @@ -7964,11 +7984,21 @@ static int nfs4_xattr_get_nfs4_dacl(const struct xattr_handler *handler,
> >  				    struct dentry *unused, struct inode *inode,
> >  				    const char *key, void *buf, size_t buflen)
> >  {
> > +	struct nfs_fh *fh = NFS_FH(inode);
> > +
> > +	if (unlikely(fh->size == 0))
> > +		return -ENODATA;
> > +
> >  	return nfs4_proc_get_acl(inode, buf, buflen, NFS4ACL_DACL);
> >  }
> >  
> >  static bool nfs4_xattr_list_nfs4_dacl(struct dentry *dentry)
> >  {
> > +	struct nfs_fh *fh = NFS_FH(d_inode(dentry));
> > +
> > +	if (unlikely(fh->size == 0))
> > +		return -ENODATA;
> 
> Here's another boolean return type.
> 
> > +
> >  	return nfs4_server_supports_acls(NFS_SB(dentry->d_sb), NFS4ACL_DACL);
> >  }
> >  
> > @@ -7980,6 +8010,11 @@ static int nfs4_xattr_set_nfs4_sacl(const struct xattr_handler *handler,
> >  				    const char *key, const void *buf,
> >  				    size_t buflen, int flags)
> >  {
> > +	struct nfs_fh *fh = NFS_FH(inode);
> > +
> > +	if (unlikely(fh->size == 0))
> > +		return -ENODATA;
> > +
> >  	return nfs4_proc_set_acl(inode, buf, buflen, NFS4ACL_SACL);
> >  }
> >  
> > @@ -7987,11 +8022,21 @@ static int nfs4_xattr_get_nfs4_sacl(const struct xattr_handler *handler,
> >  				    struct dentry *unused, struct inode *inode,
> >  				    const char *key, void *buf, size_t buflen)
> >  {
> > +	struct nfs_fh *fh = NFS_FH(inode);
> > +
> > +	if (unlikely(fh->size == 0))
> > +		return -ENODATA;
> > +
> >  	return nfs4_proc_get_acl(inode, buf, buflen, NFS4ACL_SACL);
> >  }
> >  
> >  static bool nfs4_xattr_list_nfs4_sacl(struct dentry *dentry)
> >  {
> > +	struct nfs_fh *fh = NFS_FH(d_inode(dentry));
> > +
> > +	if (unlikely(fh->size == 0))
> > +		return -ENODATA;
> 
> Boolean return type.
> 
> Thanks,
> Anna
> 
> > +
> >  	return nfs4_server_supports_acls(NFS_SB(dentry->d_sb), NFS4ACL_SACL);
> >  }
> >  
> > @@ -8005,6 +8050,11 @@ static int nfs4_xattr_set_nfs4_label(const struct xattr_handler *handler,
> >  				     const char *key, const void *buf,
> >  				     size_t buflen, int flags)
> >  {
> > +	struct nfs_fh *fh = NFS_FH(inode);
> > +
> > +	if (unlikely(fh->size == 0))
> > +		return -ENODATA;
> > +
> >  	if (security_ismaclabel(key))
> >  		return nfs4_set_security_label(inode, buf, buflen);
> >  
> > @@ -8015,6 +8065,11 @@ static int nfs4_xattr_get_nfs4_label(const struct xattr_handler *handler,
> >  				     struct dentry *unused, struct inode *inode,
> >  				     const char *key, void *buf, size_t buflen)
> >  {
> > +	struct nfs_fh *fh = NFS_FH(inode);
> > +
> > +	if (unlikely(fh->size == 0))
> > +		return -ENODATA;
> > +
> >  	if (security_ismaclabel(key))
> >  		return nfs4_get_security_label(inode, buf, buflen);
> >  	return -EOPNOTSUPP;
> > @@ -8023,8 +8078,12 @@ static int nfs4_xattr_get_nfs4_label(const struct xattr_handler *handler,
> >  static ssize_t
> >  nfs4_listxattr_nfs4_label(struct inode *inode, char *list, size_t list_len)
> >  {
> > +	struct nfs_fh *fh = NFS_FH(inode);
> >  	int len = 0;
> >  
> > +	if (unlikely(fh->size == 0))
> > +		return -ENODATA;
> > +
> >  	if (nfs_server_capable(inode, NFS_CAP_SECURITY_LABEL)) {
> >  		len = security_inode_listsecurity(inode, list, list_len);
> >  		if (len >= 0 && list_len && len > list_len)
> > @@ -8056,9 +8115,13 @@ static int nfs4_xattr_set_nfs4_user(const struct xattr_handler *handler,
> >  				    const char *key, const void *buf,
> >  				    size_t buflen, int flags)
> >  {
> > +	struct nfs_fh *fh = NFS_FH(inode);
> >  	u32 mask;
> >  	int ret;
> >  
> > +	if (unlikely(fh->size == 0))
> > +		return -ENODATA;
> > +
> >  	if (!nfs_server_capable(inode, NFS_CAP_XATTR))
> >  		return -EOPNOTSUPP;
> >  
> > @@ -8093,9 +8156,13 @@ static int nfs4_xattr_get_nfs4_user(const struct xattr_handler *handler,
> >  				    struct dentry *unused, struct inode *inode,
> >  				    const char *key, void *buf, size_t buflen)
> >  {
> > +	struct nfs_fh *fh = NFS_FH(inode);
> >  	u32 mask;
> >  	ssize_t ret;
> >  
> > +	if (unlikely(fh->size == 0))
> > +		return -ENODATA;
> > +
> >  	if (!nfs_server_capable(inode, NFS_CAP_XATTR))
> >  		return -EOPNOTSUPP;
> >  
> > @@ -8120,6 +8187,7 @@ static int nfs4_xattr_get_nfs4_user(const struct xattr_handler *handler,
> >  static ssize_t
> >  nfs4_listxattr_nfs4_user(struct inode *inode, char *list, size_t list_len)
> >  {
> > +	struct nfs_fh *fh = NFS_FH(inode);
> >  	u64 cookie;
> >  	bool eof;
> >  	ssize_t ret, size;
> > @@ -8127,6 +8195,9 @@ nfs4_listxattr_nfs4_user(struct inode *inode, char *list, size_t list_len)
> >  	size_t buflen;
> >  	u32 mask;
> >  
> > +	if (unlikely(fh->size == 0))
> > +		return -ENODATA;
> > +
> >  	if (!nfs_server_capable(inode, NFS_CAP_XATTR))
> >  		return 0;
> >  
> 


