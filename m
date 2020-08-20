Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB5C24BD9A
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Aug 2020 15:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgHTNIz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Aug 2020 09:08:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34750 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbgHTNIx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Aug 2020 09:08:53 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07KD1oIf005200;
        Thu, 20 Aug 2020 13:08:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : message-id : date :
 cc : to; s=corp-2020-01-29;
 bh=0TSlWx2NTeqXkYNgWGtHrFfZC2Kjd8GMuixo7m+X7NE=;
 b=pJkYAy/nwW34Yy0eCAaR/hpqcBXb+SW/9JoZX+Qeg8MK4bwUmb6Ae40duZjCeIgnsQuo
 SiqBbEOGW9ygJs7q/rHX8WWZ6SjRxlZkssHmI9Z2qx89z70/fPvQGmB8uIBHdMvheQnv
 YXpU5aEK7vHZkO6qjnjcjhOvmjNrdmHugBzIJw3P3Us4wB0fcIIJJ3Z2c64hidN38ed/
 i44zpXw1cPdXScbRGM4IqnMxdRaHVo9cLk0NXPlfMva8eDxDPIlk+k7r8hgj2l7E5Kep
 iwSe1X/FXeOtVt/CPh/3kkW1Bi80tGh3LpFOc6COth5PPf/heAUORJt76fdT1/l009DG yg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 32x7nmred5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Aug 2020 13:08:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07KD4S95180107;
        Thu, 20 Aug 2020 13:08:49 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 331b2dk6na-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Aug 2020 13:08:49 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07KD8mSE014920;
        Thu, 20 Aug 2020 13:08:48 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Aug 2020 06:08:48 -0700
From:   Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: "svc: RPC fragment too large" on client during NFSv4.0 mount
Message-Id: <6B3D16D6-26CA-4A82-AD10-F04E677A760C@oracle.com>
Date:   Thu, 20 Aug 2020 09:08:47 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
To:     Steve Dickson <SteveD@redhat.com>,
        Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9718 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008200108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9718 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008200108
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi!

I've filed https://bugzilla.linux-nfs.org/show_bug.cgi?id=345

to document a misbehavior I've been seeing for a while. The deets are
in the bug, but looks like the server's gssd is sending garbage after
it sets up the GSS context for the server's callback channel.

My current guess is this is either a gssd or libtirpc problem.


--
Chuck Lever



