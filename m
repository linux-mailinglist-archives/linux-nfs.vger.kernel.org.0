Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80A14115875
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2019 22:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfLFVOn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Dec 2019 16:14:43 -0500
Received: from fieldses.org ([173.255.197.46]:54212 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbfLFVOn (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 6 Dec 2019 16:14:43 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id 05EB51C95; Fri,  6 Dec 2019 16:14:43 -0500 (EST)
Date:   Fri, 6 Dec 2019 16:14:42 -0500
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [bug report] NFSD: allow inter server COPY to have a STALE
 source server fh
Message-ID: <20191206211442.GB17524@fieldses.org>
References: <20191204080039.ixjqetefkzzlldyt@kili.mountain>
 <CAN-5tyEG3C_Ebdr6dpMJ+gQ1pEAMNqbTv76dKu=KK9rspREr1A@mail.gmail.com>
 <20191204220435.GG40361@pick.fieldses.org>
 <20191205023826.GA43279@pick.fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205023826.GA43279@pick.fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Dec 04, 2019 at 09:38:26PM -0500, J. Bruce Fields wrote:
> So, stuff we could do:
> 
> 	- add an extra check of fh_export or something here.

So, I'm applying the following for now.

--b.

commit a0a906b965b0
Author: J. Bruce Fields <bfields@redhat.com>
Date:   Fri Dec 6 16:07:32 2019 -0500

    nfsd4: avoid NULL deference on strange COPY compounds
    
    With cross-server COPY we've introduced the possibility that the current
    or saved filehandle might not have fh_dentry/fh_export filled in, but we
    missed a place that assumed it was.  I think this could be triggered by
    a compound like:
    
            PUTFH(foreign filehandle)
            GETATTR
            SAVEFH
            COPY
    
    First, check_if_stalefh_allowed sets no_verify on the first (PUTFH) op.
    Then op_func = nfsd4_putfh runs and leaves current_fh->fh_export NULL.
    need_wrongsec_check returns true, since this PUTFH has OP_IS_PUTFH_LIKE
    set and GETATTR does not have OP_HANDLES_WRONGSEC set.
    
    We should probably also consider tightening the checks in
    check_if_stalefh_allowed and double-checking that we don't assume the
    filehandle is verified elsewhere in the compound.  But I think this
    fixes the immediate issue.
    
    Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
    Fixes: 4e48f1cccab3 "NFSD: allow inter server COPY to have... "
    Signed-off-by: J. Bruce Fields <bfields@redhat.com>

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index d33c39c18cdd..5c7f622fed29 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2368,7 +2368,8 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 			if (op->opdesc->op_flags & OP_CLEAR_STATEID)
 				clear_current_stateid(cstate);
 
-			if (need_wrongsec_check(rqstp))
+			if (current->fh->fh_export &&
+					need_wrongsec_check(rqstp))
 				op->status = check_nfsd_access(current_fh->fh_export, rqstp);
 		}
 encode_op:
