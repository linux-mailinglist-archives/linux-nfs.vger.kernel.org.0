Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50F8910F1F2
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Dec 2019 22:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbfLBVNN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Dec 2019 16:13:13 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:34246 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfLBVNM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Dec 2019 16:13:12 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB2LCLow024902;
        Mon, 2 Dec 2019 21:13:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=RLMNGTnMvGagg+SU0pR8PePiR9AlAviI4SDxG3Tt8XY=;
 b=otWxC50YX/YI1KSdtZQ8URNzsVdwjkMMf2nPk8tRaveIT9Mm81l0YLa0oOz2MKYWHokZ
 21Rs4Ke7OSeugNacd3lZzr8v9sGyALo8vpgFDU6LhDFqF2xJ7FDaCOmKJ4BKlE0kVA9t
 SKFpFNC8xEuy0M7iFV1pKJqEH94j2ALr88aO8fz3/5Q1pjzMrtqE87dkIR66XQueuMAV
 Df6mM97eIRtftesK3kv187QPNBuJK8pUtBoAxcmTkJuWSiZNwknKpbTS9i9Bnpd4Haj3
 i1GOvsUraZmnZOjZMBMJUcV5ZOee23LR3+ESkDSf4CWphon3Bseg7NJBdQeVXQGixBR6 Ug== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2wkh2r2t81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Dec 2019 21:13:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB2L4cZn140446;
        Mon, 2 Dec 2019 21:11:08 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2wn4qneb3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Dec 2019 21:11:08 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB2LB4xu024568;
        Mon, 2 Dec 2019 21:11:05 GMT
Received: from bills-mac-pro.lan (/68.203.6.244)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Dec 2019 13:11:04 -0800
From:   Bill Baker <Bill.Baker@Oracle.com>
Subject: Announcing Spring 2020 NFS Bake-a-thon
To:     nfsv4@ietf.org, linux-nfs <linux-nfs@vger.kernel.org>,
        fall-2019-bakeathon@googlegroups.com
Message-ID: <19da1170-82fe-37c5-3e23-da29bf468bab@Oracle.com>
Date:   Mon, 2 Dec 2019 15:11:04 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9459 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=947
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912020179
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9459 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912020179
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


Greetings,

I am pleased to announce that Oracle will be hosting the Spring
2020 Bake-a-thon at the Oracle offices in Ann Arbor, MI.  The event
will run from the morning of May 11th through Friday, May 15th, 2020.

I will be running the registration process, so please send me
your attendee list.  The event is free of charge, but only
individuals and organizations with legitimate testing interests
will be allowed to participate.

If you need to ship gear, the shipping address is:

Oracle America Inc.
attn: Matthew Gravel
777 E. Eisenhower Pkwy, Ste. 950
Ann Arbor, MI 48108
734-887-8450 (ask for Matthew)

There are several decent and reasonably priced hotels near
Eisenhower and Boardwalk.  The office has plenty of free parking
behind the building.

We look forward to seeing you at Bake-a-thon!

-- 
Bill Baker - Oracle Linux NFS development
