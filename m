Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F2D1AAF17
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Apr 2020 19:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410659AbgDORFZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Apr 2020 13:05:25 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34316 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410664AbgDORFX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Apr 2020 13:05:23 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03FH44wK062964;
        Wed, 15 Apr 2020 17:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : message-id : date :
 cc : to; s=corp-2020-01-29;
 bh=0mQ2OXjVFtnaj2pJ4iOC+jroIdIvRERqU/aiEEcQzNc=;
 b=jY5ZEd6TRPLGQRV11gKHnoryEh8ppf37KbvsXuj71XVrUiHuFZ4hRPfQrr/L0LsfJL57
 SPQ46t27tKDlxSz0G4/ZwdotXyas9tQ85d/cwR9THsvQmtGv0wRn43pn4Mugmx+MiuSP
 +pOZVlt9R5m/Oy+bWmkU7u+npvXftiDLRzN/nDBgz7if3HuvEal2WAydrdaNjcOMgf9s
 igREyyr9Of9pYqSH5R2XGAzG0CLjATPYPjFpLbJgG7B2hZmkRNkL0+OblsdvyNfbcVYK
 3xjzLi0CitdET2j9zu5czavRc3cdeqxkFTJzXI/lJDbbVtYzL2XGiIeIYOOfVuUTPH/w RA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 30e0bfa6j9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Apr 2020 17:05:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03FH3CGQ002716;
        Wed, 15 Apr 2020 17:05:17 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 30dn8wm8fd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Apr 2020 17:05:17 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03FH5ERu032441;
        Wed, 15 Apr 2020 17:05:15 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Apr 2020 10:05:14 -0700
From:   Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: GSS unwrapping breaks the DRC
Message-Id: <DAED9EC8-7461-48FF-AD6C-C85FB968F8A6@oracle.com>
Date:   Wed, 15 Apr 2020 13:05:11 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
To:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9592 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=809
 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004150124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9592 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 mlxlogscore=848
 impostorscore=0 adultscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004150124
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce and Jeff:

Testing intensive workloads with NFSv3 and NFSv4.0 on NFS/RDMA with krb5i
or krb5p results in a pretty quick workload failure. Closer examination
shows that the client is able to overrun the GSS sequence window with
some regularity. When that happens, the server drops the connection.

However, when the client retransmits requests with lost replies, they
never hit in the DRC, and that results in unexpected failures of non-
idempotent requests.

The retransmitted XIDs are found in the DRC, but the retransmitted request
has a different checksum than the original. We're hitting the "mismatch"
case in nfsd_cache_key_cmp for these requests.

I tracked down the problem to the way the DRC computes the length of the
part of the buffer it wants to checksum. nfsd_cache_csum uses

  head.iov_len + page_len

and then caps that at RC_CSUMLEN.

That works fine for krb5 and sys, but the GSS unwrap functions
(integ_unwrap_data and priv_unwrap_data) don't appear to update head.iov_len
properly. So nfsd_cache_csum's length computation is significantly larger
than the clear-text message, and that allows stale parts of the xdr_buf
to be included in the checksum.

Using xdr_buf_subsegment() at the end of integ_unwrap_data sets the xdr_buf
lengths properly and fixes the situation for krb5i.

I don't see a similar solution for priv_unwrap_data: there's no MIC len
available, and priv_len is not the actual length of the clear-text message.

Moreover, the comment in fix_priv_head() is disturbing. I don't see anywhere
where the relationship between the buf's head/len and how svc_defer works is
authoritatively documented. It's not clear exactly how priv_unwrap_data is
supposed to accommodate svc_defer, or whether integ_unwrap_data also needs
to accommodate it.

So I can't tell if the GSS unwrap functions are wrong or if there's a more
accurate way to compute the message length in nfsd_cache_csum. I suspect
both could use some improvement, but I'm not certain exactly what that
might be.


--
Chuck Lever



