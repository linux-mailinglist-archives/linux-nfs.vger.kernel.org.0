Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E66C27B173
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Sep 2020 18:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgI1QKb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Sep 2020 12:10:31 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:52506 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgI1QKb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Sep 2020 12:10:31 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08SG9kSs138085;
        Mon, 28 Sep 2020 16:10:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=HNQq/zN9ayqpTbzS7onlq5lp0HRZ/lucYE/BgjXlXXU=;
 b=TzHzVeSlOhH0jKqdCHrVSTZIxoCjIzytVJVDppp0bkoaCpXVSiL5jMfB3U2ffJ690Epn
 +1grJClDYX/opeVLct7EyAfgNWa5MsMLlRGtpEP6M3MfFoA+f50/U5NvIwI4ejOBgq0M
 1t/oeRjAKn6zdapLuoIAIRjER+fIqM7Rnssb7eFDvXcw8Z5EUMFb2J3gdo9i1QkOlohV
 H87p52Q56c/PXqwkf1q1sOXobOIxfK67sONoA3Tuwl+3bQw+6I7IDldh2fQOqkX19lVs
 BjRK0mlSEOYDYsyevT2AKYXq6jSYQz4kSMFWLf8HzshqPKsKVXmfgukt9Dtw7+ZXxmca Ww== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 33su5ap2th-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Sep 2020 16:10:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08SG4hnU040906;
        Mon, 28 Sep 2020 16:08:19 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 33tfdqc93m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Sep 2020 16:08:19 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08SG8BTN011123;
        Mon, 28 Sep 2020 16:08:12 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 28 Sep 2020 09:08:10 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: Adventures in NFS re-exporting
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200928154949.GA14702@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
Date:   Mon, 28 Sep 2020 12:08:09 -0400
Cc:     Daire Byrne <daire@dneg.com>, Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-cachefs <linux-cachefs@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B38FC84D-2658-47A6-9531-EFB6D0A64D4A@oracle.com>
References: <943482310.31162206.1599499860595.JavaMail.zimbra@dneg.com>
 <20200915172140.GA32632@fieldses.org>
 <2001715792.39705019.1600358470997.JavaMail.zimbra@dneg.com>
 <20200917190931.GA6858@fieldses.org>
 <20200917202303.GA29892@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <76A4DC7D-D4F7-4A17-A67D-282E8522132A@oracle.com>
 <1790619463.44171163.1600892707423.JavaMail.zimbra@dneg.com>
 <20200923210157.GA1650@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <108670779.52656705.1601110822013.JavaMail.zimbra@dneg.com>
 <20200928154949.GA14702@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
To:     Frank van der Linden <fllinden@amazon.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9758 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009280123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9758 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009280124
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 28, 2020, at 11:49 AM, Frank van der Linden =
<fllinden@amazon.com> wrote:
>=20
> Bruce - if you want me to 'formally' submit a version of the patch, =
let me
> know. Just disabling the cache for v4, which comes down to reverting a =
few
> commits, is probably simpler - I'd be able to test that too.

I'd be interested in seeing that. =46rom what I saw, the mechanics of
unhooking the cache from NFSv4 simply involve reverting patches, but
there appear to be some recent changes that depend on the open
filecache that might be difficult to deal with, like

b66ae6dd0c30 ("nfsd: Pass the nfsd_file as arguments to =
nfsd4_clone_file_range()")


--
Chuck Lever



