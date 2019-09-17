Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9648AB5026
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Sep 2019 16:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfIQOQ1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 Sep 2019 10:16:27 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33134 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfIQOQ0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 17 Sep 2019 10:16:26 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8HEEHD0045442;
        Tue, 17 Sep 2019 14:16:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=6sq6UDKb/yYMAX9vCZmgG1J3rbo80CYwETuCoZvo678=;
 b=QxqznBrM9rcbhNDzGzZpoRDFCfqHfW5N12GJfe7Ogkph8dm+Mj2KSrWZ6nNt+QU2uuBI
 2FJlzWdZAdSMK80o03uSgpHc1PgC6zXvw767KEkRCqVOHqt1Ngak3DgqmUNGlPgXFl33
 netGY2gSzU9b8c07aMw2JRjuUAGY09jViJQ8ASKFur7NniLcwuaAwEfvDqitcYYVmeD0
 LS2gNyLMpDv81jPsMDxD81qpw2YiH0fQy7UYhY/bit7l2tEvrtNw/z0rZ6LfNW6eeBMK
 kSpO9PrTgyJNPk43/R8vFpXEQFPIEv3rty58h0SObr3Y77B2IMA9FL9F6XdSxnbDkIau WQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2v0r5pervx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Sep 2019 14:16:23 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8HEAqJl181528;
        Tue, 17 Sep 2019 14:16:22 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2v2nmv6bha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Sep 2019 14:16:22 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8HEGL4N000962;
        Tue, 17 Sep 2019 14:16:21 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Sep 2019 07:16:21 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [RFC-PATCH] nfsd: provide a procfs entry to release stateids of a
 particular local filesystem
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CANHi-ReAFifZwBrRniLBiRnQOWeJKu-EYp18LDHwtr50eifVMw@mail.gmail.com>
Date:   Tue, 17 Sep 2019 10:16:20 -0400
Cc:     alex@zadara.com, Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <38D8C6AD-9550-415F-8A76-BC990810DAD1@oracle.com>
References: <1567518908-1720-1-git-send-email-alex@zadara.com>
 <CANHi-ReAFifZwBrRniLBiRnQOWeJKu-EYp18LDHwtr50eifVMw@mail.gmail.com>
To:     John Gallagher <john.gallagher@delphix.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9382 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=754
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909170137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9382 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=834 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909170139
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 16, 2019, at 6:28 PM, John Gallagher =
<john.gallagher@delphix.com> wrote:
>=20
> On Tue, Sep 3, 2019 at 6:57 AM Alex Lyakas <alex@zadara.com> wrote:
>> This patch allows user-space to tell nfsd to release stateids of a =
particular local filesystem.
>> After that, it is possible to unmount the local filesystem.
>=20
> We recently ran into this exact same issue. A solution along these
> lines would be very useful to us as well. I am curious, though, is it
> feasible to release all state related to a filesystem immediately when
> it is unexported? It seems like that would be ideal from the
> perspective of the administrator of the server, but perhaps there are
> technical reasons why that isn't easy or even possible.

My two cents: I was surprised by Bruce's claim that simply unexporting a
local filesystem does not reliably render it unmountable. IMO that =
behavior
would also be surprising (and possibly inconvenient) to server =
administrators,
especially in this era of elastic and automated system configuration.


--
Chuck Lever



