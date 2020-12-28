Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E2E2E6BEC
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Dec 2020 00:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730561AbgL1Wzu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Dec 2020 17:55:50 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:40234 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729350AbgL1TyN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Dec 2020 14:54:13 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BSJmlYG140030;
        Mon, 28 Dec 2020 19:53:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=JkxEpTInV7VH/7slk37crAAiKYmgGIWLoCtN265JWTo=;
 b=cI4auMbl7ttvbTKuSyCSVAqDlRKZ5JHee3fJlsqgmIr9fkxTYKStIi+pNNJm8dunYc0U
 Wc0i0WSmZkbU8Vr1f4FXSOSP2hnV5dt42xCHvujsSZYg1aVyQK9CPy3dAYqkZP5MyY/T
 22DjMkzt+XsRhRM1tRXHeTUE805nHbiJ/B8CpwYsoVhEctGkXb+Z1EHAkX/TlIqRXa24
 95xtjYZu9vJ+Buar7I9xmxOHT6Bnp67oKH/dFZQNQswpkAI0QEvIOLwYYTdZUlB9wEuA
 1OyC4s7llP8063uSs/qmxTOFzbpprS9IClIj/uJds9CS1skEh/+9k4tvDkCArAgOTKbz 0A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 35phm1bequ-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Dec 2020 19:53:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BSJnvfO149107;
        Mon, 28 Dec 2020 19:53:25 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 35perkxgdn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Dec 2020 19:53:25 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BSJrKRu017229;
        Mon, 28 Dec 2020 19:53:23 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 28 Dec 2020 11:53:20 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 1/2] nfsd: protect concurrent access to nfsd stats
 counters
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201228170344.22867-2-amir73il@gmail.com>
Date:   Mon, 28 Dec 2020 14:53:19 -0500
Cc:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <39707AFE-4542-4016-A695-7D605A8B3CB5@oracle.com>
References: <20201228170344.22867-1-amir73il@gmail.com>
 <20201228170344.22867-2-amir73il@gmail.com>
To:     Amir Goldstein <amir73il@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9848 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012280121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9848 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 priorityscore=1501
 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 impostorscore=0 phishscore=0 clxscore=1011 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012280121
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello Amir -

> On Dec 28, 2020, at 12:03 PM, Amir Goldstein <amir73il@gmail.com> wrote:
> 
> nfsd stats counters can be updated by concurrent nfsd threads without any
> protection.
> 
> Convert some nfsd_stats and nfsd_net struct members to use percpu counters.
> 
> There are several members of struct nfsd_stats that are reported in file
> /proc/net/rpc/nfsd by never updated. Those have been left untouched.
> 
> The longest_chain* members of struct nfsd_net remain unprotected.

I like the idea of converting these to per-CPU variables, and the
use of standards kernel helpers is clean. I haven't looked closely
at the NFSD-specific parts of 1/2 yet.

Looking forward to Bruce and Jeff's commentary.

--
Chuck Lever



