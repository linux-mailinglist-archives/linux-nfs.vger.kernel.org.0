Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8933F8A71
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Aug 2021 16:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbhHZOwS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Aug 2021 10:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbhHZOwS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Aug 2021 10:52:18 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081FEC061757
        for <linux-nfs@vger.kernel.org>; Thu, 26 Aug 2021 07:51:31 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 7EA236855; Thu, 26 Aug 2021 10:51:29 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 7EA236855
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1629989489;
        bh=lQ2zrkHOl8VS9TBcA1g6LrDnAbacfXDRMDa4fMX7Hho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WRZzfx3/NJgstdiLNFPVstztxmMSHmyd5m5SQrsDyCHDs6P1K+02Na4a5al8Vvnk1
         tQEOdSx5QpXkAb+59RnX5OdMBqbIQEzAsc55v93LqjERz9UYuSzR6PqsrWC15HgrZO
         EHmad6ANCd7OtCd1eGvo9EhtGMD4ETlfnGa7V+4M=
Date:   Thu, 26 Aug 2021 10:51:29 -0400
From:   "J.  Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Christoph Hellwig <hch@lst.de>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFSD: drop support for ancient file-handles
Message-ID: <20210826145129.GA3616@fieldses.org>
References: <162995209561.7591.4202079352301963089@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162995209561.7591.4202079352301963089@noble.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Aug 26, 2021 at 02:28:15PM +1000, NeilBrown wrote:
> 
> File-handles not in the "new" or "version 1" format have not been handed
> out for new mounts since Linux 2.4 which was released 20 years ago.
> I think it is safe to say that no such file handles are still in use,
> and that we can drop support for them.
> 
> This patch also moves the nfsfh.h from the include/uapi directory into
> fs/nfsd.  I can find no evidence of it being used anywhere outside the
> kernel.  Certainly nfs-utils and wireshark do not use it.
> 
> fh_base and fh_pad are occasionally used to refer to the whole
> filehandle.  These are replaced with "fh_raw" which is hopefully more
> meaningful.

Oh boy, I will not miss those (fh_version == 1) cases in nfsfh.c.
Excellent.

Looks like it just needs the following folded in.

--b.

diff --git a/fs/nfsd/flexfilelayout.c b/fs/nfsd/flexfilelayout.c
index db7ef07ae50c..2e2f1d5e9f62 100644
--- a/fs/nfsd/flexfilelayout.c
+++ b/fs/nfsd/flexfilelayout.c
@@ -61,7 +61,7 @@ nfsd4_ff_proc_layoutget(struct inode *inode, const struct svc_fh *fhp,
 		goto out_error;
 
 	fl->fh.size = fhp->fh_handle.fh_size;
-	memcpy(fl->fh.data, &fhp->fh_handle.fh_base, fl->fh.size);
+	memcpy(fl->fh.data, &fhp->fh_handle.fh_raw, fl->fh.size);
 
 	/* Give whole file layout segments */
 	seg->offset = 0;
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 4872b9519a72..3f7e59ec4e32 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1383,7 +1383,7 @@ nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
 	s_fh = &cstate->save_fh;
 
 	copy->c_fh.size = s_fh->fh_handle.fh_size;
-	memcpy(copy->c_fh.data, &s_fh->fh_handle.fh_base, copy->c_fh.size);
+	memcpy(copy->c_fh.data, &s_fh->fh_handle.fh_raw, copy->c_fh.size);
 	copy->stateid.seqid = cpu_to_be32(s_stid->si_generation);
 	memcpy(copy->stateid.other, (void *)&s_stid->si_opaque,
 	       sizeof(stateid_opaque_t));
