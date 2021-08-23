Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623133F531C
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Aug 2021 23:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbhHWV73 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Aug 2021 17:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbhHWV71 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Aug 2021 17:59:27 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED553C061575
        for <linux-nfs@vger.kernel.org>; Mon, 23 Aug 2021 14:58:44 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 1A8796855; Mon, 23 Aug 2021 17:58:44 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 1A8796855
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1629755924;
        bh=Q/k9cDxPNHS5UfSKgYYGL9aKWi5Wr3d3+MPFz6iLX8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G/9kMWuWPTZWSxN7MNhT4FM8xrfdq2ss0cVxG0MMoUC/yOqG7ykcEGS+9vRERxH3P
         tQQfIGmCDBTlw/yr9jPxmJ1ixYgJnDNPzHUl8nOchic70njAUkFC5Jocy5rb2b77Zl
         +P2PHw2WHTUAldRsKF2FJe2za+uYTNJpFlY6+rRY=
Date:   Mon, 23 Aug 2021 17:58:44 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>,
        "daire@dneg.com" <daire@dneg.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 5/8] Keep read and write fds with each nlm_file
Message-ID: <20210823215844.GA10881@fieldses.org>
References: <1629493326-28336-1-git-send-email-bfields@redhat.com>
 <1629493326-28336-6-git-send-email-bfields@redhat.com>
 <FD16AB43-CC95-44FC-AB08-159AF5C3CAB7@oracle.com>
 <20210823185734.GG883@fieldses.org>
 <D4CAB684-DE35-4964-AB9C-43FD57FA003D@oracle.com>
 <20210823204400.GH883@fieldses.org>
 <B4927FC9-0B91-48FC-84B4-3F56CB03747A@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B4927FC9-0B91-48FC-84B4-3F56CB03747A@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Aug 23, 2021 at 09:54:20PM +0000, Chuck Lever III wrote:
> > On Aug 23, 2021, at 4:44 PM, Bruce Fields <bfields@fieldses.org> wrote:
> > +static int nlm_unlock_files(struct nlm_file *file)
> > +{
> > +	struct file_lock lock;
> > +	struct file *f;
> > +
> > +	lock.fl_type  = F_UNLCK;
> > +	lock.fl_start = 0;
> > +	lock.fl_end   = OFFSET_MAX;
> > +	for (f = file->f_file[0]; f <= file->f_file[1]; f++) {
> 
> O_RDONLY and O_WRONLY ?

I thought they looked weird as loop boundaries.

> > @@ -301,7 +305,8 @@ int           nlmsvc_unlock_all_by_ip(struct sockaddr *server_addr);
> > 
> > static inline struct inode *nlmsvc_file_inode(struct nlm_file *file)
> > {
> > -	return locks_inode(file->f_file);
> > +	return locks_inode(file->f_file[0] ?
> > +				file->f_file[0] : file->f_file[1]);
> 
> O_RDONLY and O_WRONLY ?

A little less weird.

OK, I admit, "looks weird" isn't much of an argument.

I say we leave it to whoever cares enough to make the change.

--b.
