Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1512EF525
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Jan 2021 16:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbhAHPu5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 Jan 2021 10:50:57 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:45614 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbhAHPuz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 8 Jan 2021 10:50:55 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 108Fn0nT190041;
        Fri, 8 Jan 2021 15:50:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=J1Xe9qrgf7K6iyFCzzBkOi2WvC73iTDCLrVbdzNagb4=;
 b=wb2X+kchIJelvNTc0TCG5TTKh6RPe1yXtkRbu0bdvoDI6/0M+8GaiMZY0uorto0to+zO
 1zfdG7+4+u3fmtV2eyOG0imXyO9IDkdzt1OHhIcCjfttcR6Jnquz3d9TH6Akj+izVvtn
 48zegHoaqd5yIaRw5VEphIAuHea/vVrlCHYfuzORBojbVUPwKDe3RkGvRR+cZHXbYEtd
 P7IXihT8v3jPAGJqByYZsgHTjoNb4YpncIcDLi+bOeYxI4OmTILG5JiTUzcC6pIPQOS7
 u1IqfPCvyrCpen/fmXrkIrCYtaobSBk8lmn1qxaz4X1gzGLYj3f/+xIOh3zVx0r/R1U+ 0w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 35wcuy21w8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 08 Jan 2021 15:50:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 108FUYP6021302;
        Fri, 8 Jan 2021 15:50:11 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 35w3qvkw05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Jan 2021 15:50:11 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 108FoAQQ009584;
        Fri, 8 Jan 2021 15:50:11 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 Jan 2021 15:50:09 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v1 00/42] Update NFSD XDR functions
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20210108031800.GA13604@fieldses.org>
Date:   Fri, 8 Jan 2021 10:50:09 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <FDB7EF17-AD34-4CB5-824D-0DB2F5FA6F6A@oracle.com>
References: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
 <20210108031800.GA13604@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9857 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101080089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9857 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101080090
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 7, 2021, at 10:18 PM, bfields@fieldses.org wrote:
> 
> I haven't had a chance to review these, but thought I should mention I'm
> seeing a failure in xfstests generic/465 that I don't *think* is
> reproduceable before this series.  Unfortunately it's intermittent,
> though, so I'm not certain yet.

Confirming: does that failure occur with NFSv3?

--
Chuck Lever



