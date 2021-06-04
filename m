Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD9E39BEC9
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jun 2021 19:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhFDRcO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Jun 2021 13:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbhFDRcO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Jun 2021 13:32:14 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DB9C061766;
        Fri,  4 Jun 2021 10:30:26 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 1F9BB6D0D; Fri,  4 Jun 2021 13:30:26 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 1F9BB6D0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1622827826;
        bh=Wuj0IKt0Pc7p1akbLXITb0c56GmYBfVqbBINXmOk27g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C9BoqMbqNr9Lkb4ChVvdxGNVwok6zBdoIDACuwxRHAQQPgU4RXzqdG4jAB+oHuZ9M
         TuOMh3MsDgUypxk5IO0jm+Eyd8bgErHnVHWZ+Gl0vpQvG4BT5lLpJXHytlyCFiYx9p
         kPmYnmjLM0v/9ZuUHyt+TDl4Nx5hILWhAl2TpC1I=
Date:   Fri, 4 Jun 2021 13:30:26 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next v2] NFSD: Fix error return code in
 nfsd4_interssc_connect()
Message-ID: <20210604173026.GD24620@fieldses.org>
References: <20210604101237.1661615-1-weiyongjun1@huawei.com>
 <20210604144019.GC24620@fieldses.org>
 <0b183ae2-29d7-06f3-d1aa-02b8ec698141@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b183ae2-29d7-06f3-d1aa-02b8ec698141@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jun 04, 2021 at 09:36:58AM -0700, dai.ngo@oracle.com wrote:
> 
> On 6/4/21 7:40 AM, J. Bruce Fields wrote:
> >On Fri, Jun 04, 2021 at 10:12:37AM +0000, Wei Yongjun wrote:
> >>'status' has been overwritten to 0 after nfsd4_ssc_setup_dul(), this
> >>cause 0 will be return in vfs_kern_mount() error case. Fix to return
> >>nfserr_nodev in this error.
> >Why is that the right error?
> 
> That was the original error before it was overwritten by
> nfsd4_ssc_setup_dul. However, it actually does not matter which
> error nfsd4_interssc_connect returns to caller since nfsd4_copy
> maps all errors to nfserr_offload_denied before returning it
> to the client.

OK, I overlooked that.--b.

> 
> -Dai
> 
> >I don't see it mentioned among the errors
> >COPY can return:
> >
> >	https://urldefense.com/v3/__https://datatracker.ietf.org/doc/html/rfc7862*page-50__;Iw!!GqivPVa7Brio!NSHjr5li4vkJl0VAWWz2mrW2wiVn9wcJfK7ZJON3bmM8REVUqI82bS4FFQdajQ$
> >
> >It might be reasonable to just map the error returned by vfs_kern_mount
> >to an nfs error, I don't know--we'd need to think about the different
> >errors vfs_kern_mount might return.
> >
> >OFFLOAD_DENIED seems safe as it should cause a fallback to a normal
> >copy.
> >
> >Same goes for the other spot here where we return nodev.
> >
> >--b.
> >
> >>Fixes: f4e44b393389 ("NFSD: delay unmount source's export after inter-server copy completed.")
> >>Reported-by: Hulk Robot <hulkci@huawei.com>
> >>Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> >>---
> >>v1 -> v2: change to return nfserr_nodev
> >>---
> >>  fs/nfsd/nfs4proc.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >>diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> >>index 0bd71c6da81d..b082cbde3e07 100644
> >>--- a/fs/nfsd/nfs4proc.c
> >>+++ b/fs/nfsd/nfs4proc.c
> >>@@ -1323,6 +1323,7 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
> >>  	ss_mnt = vfs_kern_mount(type, SB_KERNMOUNT, dev_name, raw_data);
> >>  	module_put(type->owner);
> >>  	if (IS_ERR(ss_mnt)) {
> >>+		status = nfserr_nodev;
> >>  		if (work)
> >>  			nfsd4_ssc_cancel_dul_work(nn, work);
> >>  		goto out_free_devname;
