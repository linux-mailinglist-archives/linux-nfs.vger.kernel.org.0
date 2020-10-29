Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A445829F48A
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Oct 2020 20:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbgJ2TJm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Oct 2020 15:09:42 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:38476 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgJ2TJf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Oct 2020 15:09:35 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09TJ5Ln5015557;
        Thu, 29 Oct 2020 19:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=GTCo8juy2dN6x04TRpEuKIn2+s7YXqsIgOprFSrG9VU=;
 b=mVQxWW6I+SMa6+Ih77WZHD1tJngVwqpAJDfFt2PCeeWrDUbUARErPY6BoEPFZznBbeMW
 NFeYgTRJ7nKlIXzfqvZ1d+gCfTA5eVoSNiO9rYLZbT41m18YgMMiiFG61H5efeMxAZF3
 hDYuKeYDCnZVwQMiidtaNo1I0lhyN2nO5B1mJdP3uessBXvLW0u5EieTgakB2KujK2HB
 aCc/SyOwNPXc94k1MOdCQsFhSbb0p+y/+AS4TVOWQIKysPwbcplE5eme9C6UqudME3Am
 8cG9RYjSIzv04DvA4ytJGHTdEDDlBOS8aFqmbmxJTqwVAxxxzalq7by7wq7Fxvyt93/f eQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 34c9sb6q0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Oct 2020 19:09:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09TJ6BPo089949;
        Thu, 29 Oct 2020 19:07:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 34cx60v0va-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Oct 2020 19:07:20 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09TJ71Hj092200;
        Thu, 29 Oct 2020 19:07:19 GMT
Received: from userp3030.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by aserp3020.oracle.com with ESMTP id 34cx60v0ug-3;
        Thu, 29 Oct 2020 19:07:19 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFSD: fix missing refcount in nfsd4_copy by nfsd4_do_async_copy
Date:   Thu, 29 Oct 2020 15:07:16 -0400
Message-Id: <20201029190716.70481-3-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
In-Reply-To: <20201029190716.70481-1-dai.ngo@oracle.com>
References: <20201029190716.70481-1-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015 suspectscore=3
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010290131
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Need to initialize nfsd4_copy's refcount to 1 to avoid use-after-free
warning when nfs4_put_copy is called from nfsd4_cb_offload_release.

Fixes: ce0887ac96d3 ("NFSD add nfs4 inter ssc to nfsd4_copy")
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4proc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 9c43cad7e408..e83b21778816 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1486,6 +1486,7 @@ static int nfsd4_do_async_copy(void *data)
 	cb_copy = kzalloc(sizeof(struct nfsd4_copy), GFP_KERNEL);
 	if (!cb_copy)
 		goto out;
+	refcount_set(&cb_copy->refcount, 1);
 	memcpy(&cb_copy->cp_res, &copy->cp_res, sizeof(copy->cp_res));
 	cb_copy->cp_clp = copy->cp_clp;
 	cb_copy->nfserr = copy->nfserr;
-- 
2.20.1.1226.g1595ea5.dirty

