Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D14344606
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Mar 2021 14:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhCVNkp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Mar 2021 09:40:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40720 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbhCVNka (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Mar 2021 09:40:30 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12MDZKbF106261;
        Mon, 22 Mar 2021 13:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=jQ25x+ftjWyfzLJDEBnax4q4SW53NUcu8W2d2t+lfe8=;
 b=PvW+93Mud1kgpWhVYumd98VuZbY+SIEpEPbuDoJFJ1l418vCvqSGsHNgjtvMTLbbNQFA
 zDJsYGBgsOqKect2ObeQBoEn2SluyBb2BrWD/6GJ9Du3ibDXepNmGzspL5d/cbeFa+7C
 VL1gooNC/pUjJ1ebx91LONkI0xqJ2bCRb6l47JjeGftDDTCXhH8PXo8zaNJuWUwG28K9
 5/44HuJWpEsiChMkRY1ITotQ1oltvV3YRt7PRlFFAgQopqFsdltuNXi/u0FZ3rVSRcGV
 rhaG5j8/poMYHjn5C/PZKXu5pRmGa7BSyNG8hAxizr3YXthmwSAPmwWbOGQAbhscjfjX TA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 37d90mbggx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 13:40:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12MDaZVU145039;
        Mon, 22 Mar 2021 13:40:24 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 37dtyw3q66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 13:40:24 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 12MDeLjL016907;
        Mon, 22 Mar 2021 13:40:24 GMT
Received: from mwanda (/10.175.191.120)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Mar 2021 13:40:20 +0000
Date:   Mon, 22 Mar 2021 16:40:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [bug report] NFSv4: Deal more correctly with duplicate delegations
Message-ID: <YFieP4B3XmHsUn/a@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9930 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103220098
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9930 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 clxscore=1011 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103220098
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello Trond Myklebust,

The patch 57bfa89171e5: "NFSv4: Deal more correctly with duplicate
delegations" from Jan 25, 2008, leads to the following static checker
warning:

	fs/nfs/delegation.c:482 nfs_inode_set_delegation()
	warn: missing error code here? 'nfs_detach_delegation_locked()' failed. 'status' = '0'

fs/nfs/delegation.c
   421  int nfs_inode_set_delegation(struct inode *inode, const struct cred *cred,
   422                                    fmode_t type,
   423                                    const nfs4_stateid *stateid,
   424                                    unsigned long pagemod_limit)
   425  {
   426          struct nfs_server *server = NFS_SERVER(inode);
   427          struct nfs_client *clp = server->nfs_client;
   428          struct nfs_inode *nfsi = NFS_I(inode);
   429          struct nfs_delegation *delegation, *old_delegation;
   430          struct nfs_delegation *freeme = NULL;
   431          int status = 0;
                    ^^^^^^^^^^
"status" is always success.

   432  
   433          delegation = kmalloc(sizeof(*delegation), GFP_NOFS);
   434          if (delegation == NULL)
   435                  return -ENOMEM;
   436          nfs4_stateid_copy(&delegation->stateid, stateid);
   437          refcount_set(&delegation->refcount, 1);
   438          delegation->type = type;
   439          delegation->pagemod_limit = pagemod_limit;
   440          delegation->change_attr = inode_peek_iversion_raw(inode);
   441          delegation->cred = get_cred(cred);
   442          delegation->inode = inode;
   443          delegation->flags = 1<<NFS_DELEGATION_REFERENCED;
   444          spin_lock_init(&delegation->lock);
   445  
   446          spin_lock(&clp->cl_lock);
   447          old_delegation = rcu_dereference_protected(nfsi->delegation,
   448                                          lockdep_is_held(&clp->cl_lock));
   449          if (old_delegation == NULL)
   450                  goto add_new;
   451          /* Is this an update of the existing delegation? */
   452          if (nfs4_stateid_match_other(&old_delegation->stateid,
   453                                  &delegation->stateid)) {
   454                  spin_lock(&old_delegation->lock);
   455                  nfs_update_inplace_delegation(old_delegation,
   456                                  delegation);
   457                  spin_unlock(&old_delegation->lock);
   458                  goto out;

I think these used to return -EIO back in the day.

   459          }
   460          if (!test_bit(NFS_DELEGATION_REVOKED, &old_delegation->flags)) {
   461                  /*
   462                   * Deal with broken servers that hand out two
   463                   * delegations for the same file.
   464                   * Allow for upgrades to a WRITE delegation, but
   465                   * nothing else.
   466                   */
   467                  dfprintk(FILE, "%s: server %s handed out "
   468                                  "a duplicate delegation!\n",
   469                                  __func__, clp->cl_hostname);
   470                  if (delegation->type == old_delegation->type ||
   471                      !(delegation->type & FMODE_WRITE)) {
   472                          freeme = delegation;
   473                          delegation = NULL;
   474                          goto out;
   475                  }
   476                  if (test_and_set_bit(NFS_DELEGATION_RETURNING,
   477                                          &old_delegation->flags))
   478                          goto out;
   479          }
   480          freeme = nfs_detach_delegation_locked(nfsi, old_delegation, clp);
   481          if (freeme == NULL)
   482                  goto out;

status isn't set

   483  add_new:
   484          list_add_tail_rcu(&delegation->super_list, &server->delegations);
   485          rcu_assign_pointer(nfsi->delegation, delegation);
   486          delegation = NULL;
   487  
   488          atomic_long_inc(&nfs_active_delegations);
   489  
   490          trace_nfs4_set_delegation(inode, type);
   491  
   492          spin_lock(&inode->i_lock);
   493          if (NFS_I(inode)->cache_validity & (NFS_INO_INVALID_ATTR|NFS_INO_INVALID_ATIME))
   494                  NFS_I(inode)->cache_validity |= NFS_INO_REVAL_FORCED;
   495          spin_unlock(&inode->i_lock);
   496  out:
   497          spin_unlock(&clp->cl_lock);
   498          if (delegation != NULL)
   499                  __nfs_free_delegation(delegation);
   500          if (freeme != NULL) {
   501                  nfs_do_return_delegation(inode, freeme, 0);
   502                  nfs_free_delegation(freeme);
   503          }
   504          return status;
   505  }

regards,
dan carpenter
