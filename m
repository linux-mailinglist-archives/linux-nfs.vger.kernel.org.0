Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2A42CAD20
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Dec 2020 21:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbgLAUOY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Dec 2020 15:14:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22854 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729845AbgLAUOY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Dec 2020 15:14:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606853577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iCuMo3ocJT8KWB8iCG2PAQE+ovELEJBn86EQ2ZEB4nI=;
        b=DvV/YnaIZmflqwXIeH4mxqmjCtGK5lRbsy7MPaUyOJj3yClUfc5FEOae6H8B66+Bf3oQ11
        4Fg0XIrgsDM6cXbG4lpJGIPxRGQtAB0EXvOBS7jcMhLCZoSbIGxOF0WDliZ93nswPQvrHY
        SVnvPLFOhKFErSxvynFzwSo39TJSAJg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-SsHaeEfIPYihXOmyeRb_3Q-1; Tue, 01 Dec 2020 15:12:53 -0500
X-MC-Unique: SsHaeEfIPYihXOmyeRb_3Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0BF21005E45;
        Tue,  1 Dec 2020 20:12:52 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-116-43.rdu2.redhat.com [10.10.116.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7AA3D5D9CA;
        Tue,  1 Dec 2020 20:12:52 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 2CDC61205B4; Tue,  1 Dec 2020 15:12:51 -0500 (EST)
Date:   Tue, 1 Dec 2020 15:12:51 -0500
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/5] nfsd: only call inode_query_iversion in the
 I_VERSION case
Message-ID: <20201201201251.GZ259862@pick.fieldses.org>
References: <1606776378-22381-1-git-send-email-bfields@fieldses.org>
 <e40e0b17e0eff20016b637b140b7fd4b2e367e34.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e40e0b17e0eff20016b637b140b7fd4b2e367e34.camel@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Dec 01, 2020 at 11:30:12AM -0500, Jeff Layton wrote:
> On Mon, 2020-11-30 at 17:46 -0500, J. Bruce Fields wrote:
> > From: "J. Bruce Fields" <bfields@redhat.com>
> > 
> > inode_query_iversion() can modify i_version.  Depending on the exported
> > filesystem, that may not be safe.  For example, if you're re-exporting
> > NFS, NFS stores the server's change attribute in i_version and does not
> > expect it to be modified locally.  This has been observed causing
> > unnecessary cache invalidations.
> > 
> > The way a filesystem indicates that it's OK to call
> > inode_query_iverson() is by setting SB_I_VERSION.
> > 
> > So, move the I_VERSION check out of encode_change(), where it's used
> > only in FATTR responses, to nfsd4_changeattr(), which is also called for
> > pre- and post- operation attributes.
> > 
> 
> "only in FATTR responses, to nfsd4_change_attribute(),"

Whoops, and also FATTR should have been GETATTR.

Fixed locally, I assume Chuck will just want to fix that up in his tree
(let me know if not).

--b.

