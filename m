Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D924C22B51E
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jul 2020 19:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgGWRq1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Jul 2020 13:46:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57684 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgGWRq1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Jul 2020 13:46:27 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06NHavYp160702;
        Thu, 23 Jul 2020 17:46:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : message-id : date :
 cc : to; s=corp-2020-01-29;
 bh=vh2adqeBmjt9wvvZYlrQfuZg9Kyw6/qIp1oXYO6WY+c=;
 b=RzQZYGcrSbpQg9EB5ERSm/kDSjKTkIf402KlURj4MdAeT/sSiaOYxaWSOQU/k6WeYt+a
 7H+5gAiCz2hETkweHlmxUNozWM1341c2BVGId1Y0bj1YVp3Z1hxhpNfpmYbg9a4g4IG0
 7Fs9bfSFykgWnRAwIQyvWLBsnIsJ+Qh832BsOFS/YZ6zZVwMJWIaSJcRR5jQMPmahYdg
 oVxoKswRCUlGTqIrbYsrdJZuZXIg9rpVd6vw/1b9w/U2x+0TSpLXMh5U3pXTfbZsBBnl
 DE3BwX/x1lGTzYvjbONunKGIioHsDBsRu3vlEEiDcWdkGs7rrUIa1SQOwVJ+ICfuV65S UQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 32brgrtwmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Jul 2020 17:46:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06NHfv2K144636;
        Thu, 23 Jul 2020 17:46:21 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 32fc5nvvk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jul 2020 17:46:21 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06NHkKBl012340;
        Thu, 23 Jul 2020 17:46:20 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 23 Jul 2020 10:46:19 -0700
From:   Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: fix_priv_head
Message-Id: <3799C9E0-DFF3-450C-A815-14BAFAC97EA8@oracle.com>
Date:   Thu, 23 Jul 2020 13:46:19 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9691 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=975 malwarescore=0
 phishscore=0 mlxscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007230129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9691 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007230129
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce-

I'm trying to figure out if fix_priv_head is still necessary. This
was introduced by 7c9fdcfb1b64 ("[PATCH] knfsd: svcrpc: gss:
server-side implementation of rpcsec_gss privacy").

static void
fix_priv_head(struct xdr_buf *buf, int pad)
{
        if (buf->page_len == 0) {
                /* We need to adjust head and buf->len in tandem in this
                 * case to make svc_defer() work--it finds the original
                 * buffer start using buf->len - buf->head[0].iov_len. */
                buf->head[0].iov_len -= pad;
        }
}

It doesn't seem like unwrapping can ever result in a buffer length that
is not quad-aligned. Is that simply a characteristic of modern enctypes?

--
Chuck Lever



