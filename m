Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003C635A546
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Apr 2021 20:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbhDISIH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 9 Apr 2021 14:08:07 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39426 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234407AbhDISIG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 9 Apr 2021 14:08:06 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 139I4oEr099477;
        Fri, 9 Apr 2021 18:07:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=Z+WZUUJGXXZ8f7LTpqoWP0fjA5jBQa/FvLQd0NX1Tlg=;
 b=fowRgwcZOA2efrg6pGAG8ghXMCej65TxYGpy5UovxtggZnyEH6fdGbhEhzG0LtDFJylG
 AwsilU0sFWM/OQ5Ugos/9p5VuSFv7bAAetXyg6HeGU2+IWZlEHYsCSSwZZNqPJ6MFD3V
 YauJw+vlD0KxJ7tPalx831rj4708QkVoFStWsUTmeEfwUgs2uibOCrszYZ50j63FA6Ge
 a579fsWpzDS0agWK2n0IdHv71ovTHRMe279eSLuRCcRS9BtINnpuSERaSJOPE2UlZrcB
 ZK7/bJQZ96OElXrP3vqRx6el4EElzDWiWpVuuHvpNvR8EdXklS7Fgd8geTm43i6mhCri Lg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 37rvagj9qh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 18:07:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 139I6ELk029094;
        Fri, 9 Apr 2021 18:07:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 37rvbhvum5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 18:07:44 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 139I7iZs033412;
        Fri, 9 Apr 2021 18:07:44 GMT
Received: from aserp3020.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by aserp3030.oracle.com with ESMTP id 37rvbhvuku-1;
        Fri, 09 Apr 2021 18:07:44 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     olga.kornievskaia@gmail.com
Cc:     linux-nfs@vger.kernel.org, trondmy@hammerspace.com,
        bfields@fieldses.org, chuck.lever@oracle.com
Subject: [PATCH v3 0/2] NFSD: delay unmount source's export after inter-server copy completed.
Date:   Fri,  9 Apr 2021 14:05:17 -0400
Message-Id: <20210409180519.25405-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 1B8w8CZolRt-caesrkfXK676zwBh1w6V
X-Proofpoint-ORIG-GUID: 1B8w8CZolRt-caesrkfXK676zwBh1w6V
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9949 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104090131
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Olga,

Currently the source's export is mounted and unmounted on every
inter-server copy operation. This causes unnecessary overhead
for each copy.

This patch series is an enhancement to allow the export to remain
mounted for a configurable period (default to 15 minutes). If the 
export is not being used for the configured time it will be unmounted
by a delayed task. If it's used again then its expiration time is
extended for another period.

Since mount and unmount are no longer done on each copy request,
this overhead is no longer used to decide whether the copy should
be done with inter-server copy or generic copy. The threshold is
now a module configuration parameter, default to 16MB.

-Dai

v2: fix compiler warning of missing prototype.
v3: remove the used of semaphore.
    eliminated all RPC calls for subsequence mount by allowing
       all exports from one server to share one vfsmount.
    make inter-server threshold a module configuration parameter.


