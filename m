Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B174729F481
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Oct 2020 20:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbgJ2TH0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Oct 2020 15:07:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49640 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgJ2THZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Oct 2020 15:07:25 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09TJ5Get138169;
        Thu, 29 Oct 2020 19:07:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=70LXYRhe2LNxNrmgoGYO8cWKvd/na14zPZhGFfpswHA=;
 b=osBzDlOciOm2IvIcsExsOEkEd/lnUI0lSV/fVB4SQxZFqGcW/pO1yqAXhKlAqe2cadUG
 VU5dLgecRg3GlCZpSc93gEwI+1vSZXcUb0B+TrvQBbTqtChDoOvln5BT3HEn66p8PgSk
 R632GocLKxJgljao7cDOf9wHKSxC/3xhiEpO4aTPUb/3e420MYCvrXYPAJ2Q3t0WMfvt
 hUdM6Q5rzV4y0waXt+SS3vMzFk61T7PBBh9s+AY5diEDLtbqf1xG8Iwy8UPZKoEu5FGE
 UvtFl5roxy6vMIMXVlZrTYtJfMzkj+0aJObdcqGDjqdXD4X0jSjkGYFsf7M1y9cjRMDM wQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 34cc7m6hs4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Oct 2020 19:07:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09TJ69NZ089706;
        Thu, 29 Oct 2020 19:07:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 34cx60v0uq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Oct 2020 19:07:19 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09TJ71Hf092200;
        Thu, 29 Oct 2020 19:07:18 GMT
Received: from userp3030.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by aserp3020.oracle.com with ESMTP id 34cx60v0ug-1;
        Thu, 29 Oct 2020 19:07:18 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/2] NFSD: Fix use-after-free warning when doing inter-server copy
Date:   Thu, 29 Oct 2020 15:07:14 -0400
Message-Id: <20201029190716.70481-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=3
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=919 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010290131
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Observed use-after-free messages in /var/log/messages of destination
server when doing inter-server copy. These come from 2 different places
in the code, one from the nfsd4_cleanup_inter_ssc when nfsd_file_put
is called for the source file and the other from nfs4_put_copy when
it's called from nfsd4_cb_offload_release.

Fixed by removing the call to nfsd_file_put; the object is not allocated
by nfsd_file_alloc, and by initializing refcount for nfsd4_copy in
nfsd4_do_async_copy.

 fs/nfsd/nfs4proc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


