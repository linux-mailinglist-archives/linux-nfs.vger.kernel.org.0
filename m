Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C6749D457
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jan 2022 22:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbiAZVNx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Jan 2022 16:13:53 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:7752 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231972AbiAZVNw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Jan 2022 16:13:52 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20QKZM2e022462
        for <linux-nfs@vger.kernel.org>; Wed, 26 Jan 2022 21:13:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2021-07-09;
 bh=n+/KhuY3zJ8ueAuxcoQnSAnKUeY7prGE407rUzQHjhA=;
 b=l43qtiWzRLico/ogV2cIgPvQVZta5/oiUb+Wn4rXfc3t/YuCR9EnYpg1D0nqLa0XmgR7
 +HSQay7/DyP304O67lppoXo0no5LaoD3ld32z/CM9ilcZ9wSjLqNLZJLFV4kmPDeO7Of
 3eI74V5WqFTPGTx1aDua3m/mPg/n1VzYXkcP4COv8rBdqry6lTrEjb5IG8oeDExeW+oh
 VWNlGlz2vcyHaMxeYIdZHGMo1E1Tnqjb02nqeANfhDERxDDtDG8JM512cPBCaeRoxA10
 9+qthFgHlwjAVUGBN7Xmov/0yuEgEa/do5hpS2SXIm4UEGLnC7/DSSZpZP/QOXE0HqFg KQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsxvfq3ye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Wed, 26 Jan 2022 21:13:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20QL6op3049987
        for <linux-nfs@vger.kernel.org>; Wed, 26 Jan 2022 21:13:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 3dtax94wqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Wed, 26 Jan 2022 21:13:45 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 20QLDjP4070092
        for <linux-nfs@vger.kernel.org>; Wed, 26 Jan 2022 21:13:45 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by aserp3020.oracle.com with ESMTP id 3dtax94wq8-1;
        Wed, 26 Jan 2022 21:13:45 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] nfsd: nfsd4_setclientid_confirm mistakenly expires confirmed client.
Date:   Wed, 26 Jan 2022 13:13:38 -0800
Message-Id: <1643231618-24342-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-GUID: sb3omM7jdUTLiqkcfFlM5f46uN18jqBB
X-Proofpoint-ORIG-GUID: sb3omM7jdUTLiqkcfFlM5f46uN18jqBB
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From RFC 7530 Section 16.34.5:

o  The server has not recorded an unconfirmed { v, x, c, *, * } and
   has recorded a confirmed { v, x, c, *, s }.  If the principals of
   the record and of SETCLIENTID_CONFIRM do not match, the server
   returns NFS4ERR_CLID_INUSE without removing any relevant leased
   client state, and without changing recorded callback and
   callback_ident values for client { x }.

The current code intents to do what the spec describes above but
it forgot to set 'old' to NULL resulting to the confirmed client
to be expired.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 72900b89cf84..32063733443d 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4130,8 +4130,10 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
 			status = nfserr_clid_inuse;
 			if (client_has_state(old)
 					&& !same_creds(&unconf->cl_cred,
-							&old->cl_cred))
+							&old->cl_cred)) {
+				old = NULL;
 				goto out;
+			}
 			status = mark_client_expired_locked(old);
 			if (status) {
 				old = NULL;
-- 
2.9.5

