Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A1D29A699
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Oct 2020 09:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894916AbgJ0IcI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 27 Oct 2020 04:32:08 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53018 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2894915AbgJ0IcH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 27 Oct 2020 04:32:07 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09R8P0Xh075892;
        Tue, 27 Oct 2020 08:32:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=Hg/QmIYzKjjzFKZa5js2UNCXlaIpEHtyJlpu3DpD7t4=;
 b=DgVEqiroJfOyPOOaoCzHRDX2IPnVriJdtHtN8Y/Ykp0sv5xGNh6F/vh5Qji9pnkqz9ID
 2Y1tX781RMxThamqj+2brdxwS5wHEaoIeShf/WKGsjPHY0UTuZwDufGAUzzSgPSZtRS+
 FAGmWYk4tGyvXuN3PvmNZzCFBMbrS7lOqJMVr/+AAWe2O/CupBKh5J7ni06ffXFbbzlD
 OQp6fdWKFKAc2Vnwu3/1WNVlrMFbDBT1jGrBerc+VuZTGBF4b0/TbN/Uz+LyA5LgWVZL
 z8bSzTbkEgIxiyAxCIKrB4eqTyOLweBtg7lO3BiJxVfv0lgYy2B2pp1LqY4jKshcK55W kw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 34cc7krh8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Oct 2020 08:32:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09R8Q1J8105729;
        Tue, 27 Oct 2020 08:32:05 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 34cx5wujtf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Oct 2020 08:32:05 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09R8W49Z008726;
        Tue, 27 Oct 2020 08:32:04 GMT
Received: from mwanda (/10.175.160.91)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Oct 2020 01:32:03 -0700
Date:   Tue, 27 Oct 2020 11:31:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     arturmolchanov@gmail.com
Cc:     linux-nfs@vger.kernel.org
Subject: [bug report] net/sunrpc: Fix return value for sysctl
 sunrpc.transports
Message-ID: <20201027083158.GA2533809@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=3 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010270056
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1011 mlxscore=0 suspectscore=3
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010270056
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello Artur Molchanov,

The patch c09f56b8f68d: "net/sunrpc: Fix return value for sysctl
sunrpc.transports" from Oct 12, 2020, leads to the following static
checker warning:

	net/sunrpc/sysctl.c:75 proc_do_xprt()
	warn: unsigned '*lenp' is never less than zero.

net/sunrpc/sysctl.c
    62  static int proc_do_xprt(struct ctl_table *table, int write,
    63                          void *buffer, size_t *lenp, loff_t *ppos)
    64  {
    65          char tmpbuf[256];
    66          size_t len;
    67  
    68          if ((*ppos && !write) || !*lenp) {
                              ^^^^^^^
It's weird that we don't just return -EINVAL for writes or something.

    69                  *lenp = 0;
    70                  return 0;
    71          }
    72          len = svc_print_xprts(tmpbuf, sizeof(tmpbuf));
    73          *lenp = memory_read_from_buffer(buffer, *lenp, ppos, tmpbuf, len);
    74  
    75          if (*lenp < 0) {

"*lenp" is unsigned so it can't be less than zero.  memory_read_from_buffer()
only returns an error if ppos is negative but that's impossible because
this is a proc file so negatives are prevented in rw_verify_area().

In other words this bug can't affect runtime.

    76                  *lenp = 0;
    77                  return -EINVAL;
    78          }
    79          return 0;
    80  }

regards,
dan carpenter
