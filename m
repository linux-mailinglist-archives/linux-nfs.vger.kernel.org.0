Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 913849EC4F
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2019 17:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfH0PVQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 27 Aug 2019 11:21:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42518 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbfH0PVP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 27 Aug 2019 11:21:15 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7RFJOmg136201;
        Tue, 27 Aug 2019 15:20:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=nKdOe2NjQQ/QOzX3hakv1W4OMjckDYxdgPCafvsYBwo=;
 b=pZBNivYYaIoqPUcS8z/PMKMg6XBbdwZwOE4cQ9fE+apwAg+DY/YNmh3HhehZsByRDrC2
 sgGtmnM0KP9TI4/VlMAJTnCKKoZZcRRhk5E4oqCY12xw3RhpAeX1JIEwFNGRYyYzp+Ri
 66XoWh3xfvdiCWS/AFzBATG8QNoRTTq6FNT893lfsmw7k6HEK3kNX6njRNH00zWQBGu0
 uKjt5xyp5R/9tqOk7YAr2hQWIQf5ThNfxnAgJp7cSOHOrOtdL3jfLmoLVfZBjQ9+6uEX
 qhvWuWIxKJyTebECDEudE6vkQu15vVXXXfq+I+HfeUsEFgyUL0G09Di8FzLlX5l9aoLv zA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2un6qtr73g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Aug 2019 15:20:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7RFIcs2030966;
        Tue, 27 Aug 2019 15:20:46 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2umj2ytss3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Aug 2019 15:20:46 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7RFKjTd030330;
        Tue, 27 Aug 2019 15:20:45 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Aug 2019 08:20:45 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 0/3] Handling NFSv3 I/O errors in knfsd
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <1ee75165d548b336f5724b6d655aa2545b9270c3.camel@hammerspace.com>
Date:   Tue, 27 Aug 2019 11:20:44 -0400
Cc:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Bruce Fields <bfields@redhat.com>,
        Jeff Layton <jlayton@poochiereds.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7FDE5284-AD41-46B6-A257-DE9D5F24932D@oracle.com>
References: <20190826165021.81075-1-trond.myklebust@hammerspace.com>
 <20190826205156.GA27834@fieldses.org>
 <ef9f2791ef395d7c968a386ce0a32ea503d6478f.camel@hammerspace.com>
 <61F77AD6-BD02-4322-B944-0DC263EB9BD8@oracle.com>
 <ec7a06f8e74867e65c26580e8504e2879f4cd595.camel@hammerspace.com>
 <20190827145819.GB9804@fieldses.org> <20190827145912.GC9804@fieldses.org>
 <1ee75165d548b336f5724b6d655aa2545b9270c3.camel@hammerspace.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9362 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908270156
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9362 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908270156
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 27, 2019, at 11:15 AM, Trond Myklebust =
<trondmy@hammerspace.com> wrote:
>=20
> On Tue, 2019-08-27 at 10:59 -0400, bfields@fieldses.org wrote:
>> On Tue, Aug 27, 2019 at 10:58:19AM -0400, bfields@fieldses.org wrote:
>>> On Tue, Aug 27, 2019 at 02:53:01PM +0000, Trond Myklebust wrote:
>>>> The one problem is that the looping forever client can cause
>>>> other
>>>> clients to loop forever on their otherwise successful writes on
>>>> other
>>>> files.
>>>=20
>>> Yeah, that's the case I was wondering about.
>>>=20
>>>> That's bad, but again, that's due to client behaviour that is
>>>> toxic even today.
>>>=20
>>> So my worry was that if write errors are rare and the consequences
>>> of
>>> the single client looping forever are relatively mild, then there
>>> might
>>> be deployed clients that get away with that behavior.
>>>=20
>>> But maybe the behavior's a lot more "toxic" than I imagined, hence
>>> unlikely to be very common.
>>=20
>> (And, to be clear, I like the idea, just making sure I'm not
>> overlooking
>> any problems....)
>>=20
> I'm open to other suggestions, but I'm having trouble finding one that
> can scale correctly (i.e. not require per-client tracking), prevent
> silent corruption (by causing clients to miss errors), while not
> relying on optional features that may not be implemented by all NFSv3
> clients (e.g. per-file write verifiers are not implemented by *BSD).
>=20
> That said, it seems to me that to do nothing should not be an option,
> as that would imply tolerating silent corruption of file data.

Agree, we should move forward. I'm not saying "do nothing," I'm
just trying to understand what is improved and what is still left
to do (maybe nothing).


--
Chuck Lever



