Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27301BF64F
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Sep 2019 17:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfIZP5e (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Sep 2019 11:57:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57974 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfIZP5e (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Sep 2019 11:57:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8QFsIrS166909;
        Thu, 26 Sep 2019 15:57:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=2Hw/Sm09QHOEmZJdMnRZcVYoCA+8BqfdS8wPQI62ouo=;
 b=shvcgf+i/gvm9/DsawF9NHRSlwiEP3n1IE1iu1BoCLjLJ3YarhwIccv9vNSDMXj0TsTk
 g+1x6Pzt03p3DIyMcg9Filg0OY3bajg7o1PMKQZekOLVrancrdG6hNAkiP7zPma86XjT
 TFXFBgd+bXYutHPSAnWpqTbjHXGuq2D93NUTCmiUYEPkqRGmRzf6z70mhCnMQ3W7wL76
 BR84ljJT2rXwt13RBFyGo/p6ZpztGbkGy2/P7wi7WCTg6HdKrknCsCgFaQAMn6qL5eKg
 Yg+88QK1U+2JukHJNNAZusnVgEoeS3XGPqurlDhwnerHA6pE/QJceavypCzcLU14WscY Ow== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2v5cgrcqf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Sep 2019 15:57:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8QFsUtE005259;
        Thu, 26 Sep 2019 15:55:23 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2v8yjwubsw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Sep 2019 15:55:23 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8QFtIxN027981;
        Thu, 26 Sep 2019 15:55:21 GMT
Received: from [172.20.1.219] (/12.203.202.9)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Sep 2019 08:55:18 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: NFSv4 client locks up on larger writes with Kerberos enabled
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20190925200723.GA11954@fieldses.org>
Date:   Thu, 26 Sep 2019 08:55:17 -0700
Cc:     Kevin Vasko <kvasko@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <1BC54D7A-073E-40FD-9AA3-552F1E1BD214@oracle.com>
References: <CAMd28E-pJp4=kvp62FJqGLZo-jGA2rH2OT6-hK_N=TvMiJuT2A@mail.gmail.com>
 <20190925164831.GA9366@fieldses.org>
 <57192382-86BE-4878-9AE0-B22833D56367@oracle.com>
 <CAMd28E-zcjuCfVbDCra4Av3Ewsdd-Ai=E0j3tF2GKJ8P6nG8=w@mail.gmail.com>
 <FCAD9EFD-26AD-41F0-BCCA-80E475219731@oracle.com>
 <20190925200723.GA11954@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9392 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909260142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9392 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909260142
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 25, 2019, at 1:07 PM, Bruce Fields <bfields@fieldses.org> wrote:
> 
> On Wed, Sep 25, 2019 at 11:49:14AM -0700, Chuck Lever wrote:
>> Sounds like the NFS server is dropping the connection. With
>> GSS enabled, that's usually a sign that the GSS window has
>> overflowed.
> 
> Would that show up in the rpc statistics on the client somehow?

More likely on the server. The client just sees a disconnect
without any explanation attached.

gss_verify_header is where the checking is done on the server.
Disappointingly, I see some dprintk's in there, but no static
trace events.


> In that case--I seem to remember there's a way to configure the size of
> the client's slot table, maybe lowering that (decreasing the number of
> rpc's allowed to be outstanding at a time) would work around the
> problem.

> Should the client be doing something different to avoid or recover from
> overflows of the gss window?

The client attempts to meter the request stream so that it stays
within the bounds of the GSS sequence number window. The stream
of requests is typically unordered coming out of the transmit
queue.

There is some new code (since maybe v5.0?) that handles the
metering: gss_xmit_need_reencode().


--
Chuck Lever



