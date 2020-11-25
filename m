Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F7D2C4272
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Nov 2020 15:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbgKYOux (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Nov 2020 09:50:53 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:41083 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgKYOux (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Nov 2020 09:50:53 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1khw8B-0004os-VH; Wed, 25 Nov 2020 14:50:52 +0000
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
From:   Colin Ian King <colin.king@canonical.com>
Subject: re: nfsd: skip some unnecessary stats in the v4 case
Message-ID: <de7dc4f1-cbf2-6bcd-1466-d67b418dcc5f@canonical.com>
Date:   Wed, 25 Nov 2020 14:50:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

Static analysis on today's linux-next has found an issue with the
following commit:

commit 55ea6691d52875b921d3712f9a08db8e81e059b4
Author: J. Bruce Fields <bfields@redhat.com>
Date:   Fri Nov 20 17:39:19 2020 -0500

    nfsd: skip some unnecessary stats in the v4 case


The analysis is as follows:

286 /*
287  * Fill in the post_op attr for the wcc data
288  */
289 void fill_post_wcc(struct svc_fh *fhp)
290 {
291        bool v4 = (fhp->fh_maxsize == NFS4_FHSIZE);
292        struct inode *inode = d_inode(fhp->fh_dentry);

   1. var_decl: Declaring variable err without initializer.

293        __be32 err;
294

   2. Condition fhp->fh_post_saved, taking true branch.

295        if (fhp->fh_post_saved)
296                printk("nfsd: inode locked twice during operation.\n");
297
298

   3. Condition !v4, taking false branch.
   4. Condition !inode->i_sb->s_export_op->fetch_iversion, taking false
branch.

299        if (!v4 || !inode->i_sb->s_export_op->fetch_iversion)
300                err = fh_getattr(fhp, &fhp->fh_post_attr);

   5. Condition v4, taking true branch.

301        if (v4)
302                fhp->fh_post_change =
303                        nfsd4_change_attribute(&fhp->fh_post_attr,
inode);

Uninitialized scalar variable (UNINIT)6. uninit_use: Using uninitialized
value err.

304        if (err) {
305                fhp->fh_post_saved = false;
306                /* Grab the ctime anyway - set_change_info might use
it */
307                fhp->fh_post_attr.ctime = inode->i_ctime;
308        } else
309                fhp->fh_post_saved = true;
310 }

Prior to this commit, variable err used to be always assigned by the
call to err = fh_getattr(fhp, &stat), but now it is only called on
specific conditions, so now we have this unassigned err issue.

Colin
