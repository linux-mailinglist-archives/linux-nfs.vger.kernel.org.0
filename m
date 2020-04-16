Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80301AC65B
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2020 16:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732461AbgDPOiF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Apr 2020 10:38:05 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50560 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409796AbgDPOHo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Apr 2020 10:07:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03GE3efS115561;
        Thu, 16 Apr 2020 14:07:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=94INsQji3onbNPF4lH8oXcQvjJmDrq+8CsoY9xMehL0=;
 b=LniX6rwyOJ2QruRHnME8UnmrLu3wXHUdm658o2di9/bN2TREevTtQoiYQ0tE88xoLG+m
 z8dhLzV0HVj4tGVuXOWf58KCU7QnhvJAQ6L3ZTDHq3BOEHAmIO+vt6yeAhx1qUKsuC+A
 jYIkPqd1etfBiVhJ5OegxOQu0LaQMBnlOcaswJ0KIyc2J9QtvEJUPI5Sdr+yUAkLYiJZ
 8GaGDN201JhQFU3NeEmjlO5ybMb8OKyTioaPafI8pxxELsWaq/bqdFcsR2OMk1byOYgm
 0GZCcBvBwqwHxe3mM7ZZ38EUaD52CffACUeXiW+ghbZaMM5zoxEURNvej/fD6mv6uVKP tg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 30e0aa75f1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Apr 2020 14:07:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03GE7NKT150366;
        Thu, 16 Apr 2020 14:07:38 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 30dn8yjvf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Apr 2020 14:07:37 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03GE7V8N026175;
        Thu, 16 Apr 2020 14:07:31 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 16 Apr 2020 07:07:31 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: GSS unwrapping breaks the DRC
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200416000009.GA13083@fieldses.org>
Date:   Thu, 16 Apr 2020 10:07:27 -0400
Cc:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B6923717-3396-4DC2-AD63-1C5797B2471C@oracle.com>
References: <DAED9EC8-7461-48FF-AD6C-C85FB968F8A6@oracle.com>
 <20200415192542.GA6466@fieldses.org>
 <0775FBE7-C2DD-4ED6-955D-22B944F302E0@oracle.com>
 <20200415215823.GB6466@fieldses.org>
 <39815C35-EAD8-4B2E-B48F-88F3D5B10C57@oracle.com>
 <20200416000009.GA13083@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9592 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004160101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9592 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004160101
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 15, 2020, at 8:00 PM, Bruce Fields <bfields@fieldses.org> =
wrote:
>=20
> On Wed, Apr 15, 2020 at 06:23:57PM -0400, Chuck Lever wrote:
>>=20
>>=20
>>> On Apr 15, 2020, at 5:58 PM, Bruce Fields <bfields@fieldses.org> =
wrote:
>>>=20
>>> On Wed, Apr 15, 2020 at 04:06:17PM -0400, Chuck Lever wrote:
>>>>=20
>>>>=20
>>>>> On Apr 15, 2020, at 3:25 PM, Bruce Fields <bfields@fieldses.org> =
wrote:
>>>>>=20
>>>>> On Wed, Apr 15, 2020 at 01:05:11PM -0400, Chuck Lever wrote:
>>>>>> Hi Bruce and Jeff:
>>>>>>=20
>>>>>> Testing intensive workloads with NFSv3 and NFSv4.0 on NFS/RDMA =
with krb5i
>>>>>> or krb5p results in a pretty quick workload failure. Closer =
examination
>>>>>> shows that the client is able to overrun the GSS sequence window =
with
>>>>>> some regularity. When that happens, the server drops the =
connection.
>>>>>>=20
>>>>>> However, when the client retransmits requests with lost replies, =
they
>>>>>> never hit in the DRC, and that results in unexpected failures of =
non-
>>>>>> idempotent requests.
>>>>>>=20
>>>>>> The retransmitted XIDs are found in the DRC, but the =
retransmitted request
>>>>>> has a different checksum than the original. We're hitting the =
"mismatch"
>>>>>> case in nfsd_cache_key_cmp for these requests.
>>>>>>=20
>>>>>> I tracked down the problem to the way the DRC computes the length =
of the
>>>>>> part of the buffer it wants to checksum. nfsd_cache_csum uses
>>>>>>=20
>>>>>> head.iov_len + page_len
>>>>>>=20
>>>>>> and then caps that at RC_CSUMLEN.
>>>>>>=20
>>>>>> That works fine for krb5 and sys, but the GSS unwrap functions
>>>>>> (integ_unwrap_data and priv_unwrap_data) don't appear to update =
head.iov_len
>>>>>> properly. So nfsd_cache_csum's length computation is =
significantly larger
>>>>>> than the clear-text message, and that allows stale parts of the =
xdr_buf
>>>>>> to be included in the checksum.
>>>>>>=20
>>>>>> Using xdr_buf_subsegment() at the end of integ_unwrap_data sets =
the xdr_buf
>>>>>> lengths properly and fixes the situation for krb5i.
>>>>>>=20
>>>>>> I don't see a similar solution for priv_unwrap_data: there's no =
MIC len
>>>>>> available, and priv_len is not the actual length of the =
clear-text message.
>>>>>>=20
>>>>>> Moreover, the comment in fix_priv_head() is disturbing. I don't =
see anywhere
>>>>>> where the relationship between the buf's head/len and how =
svc_defer works is
>>>>>> authoritatively documented. It's not clear exactly how =
priv_unwrap_data is
>>>>>> supposed to accommodate svc_defer, or whether integ_unwrap_data =
also needs
>>>>>> to accommodate it.
>>>>>>=20
>>>>>> So I can't tell if the GSS unwrap functions are wrong or if =
there's a more
>>>>>> accurate way to compute the message length in nfsd_cache_csum. I =
suspect
>>>>>> both could use some improvement, but I'm not certain exactly what =
that
>>>>>> might be.
>>>>>=20
>>>>> I don't know, I tried looking through that code and didn't get any
>>>>> further than you.  The gss unwrap code does look suspect to me.  =
It
>>>>> needs some kind of proper design, as it stands it's just an =
accumulation
>>>>> of fixes.
>>>>=20
>>>> Having recently completed overhauling the client-side equivalents, =
I
>>>> agree with you there.
>>>>=20
>>>> I've now convinced myself that because nfsd_cache_csum might need =
to
>>>> advance into the first page of the Call message, =
rq_arg.head.iov_len
>>>> must contain an accurate length so that csum_partial is applied
>>>> correctly to the head buffer.
>>>>=20
>>>> Therefore it is the preceding code that needs to set up =
rq_arg.head.iov_len
>>>> correctly. The GSS unwrap functions have to do this, and therefore =
these
>>>> must be fixed. I would theorize that svc_defer also depends on =
head.iov_len
>>>> being set correctly.
>>>>=20
>>>> As far as how rq_arg.len needs to be set for svc_defer, I think I =
need
>>>> to have some kind of test case to examine how that path is =
triggered. Any
>>>> advice appreciated.
>>>=20
>>> It's triggered on upcalls, so for example if you flush the export =
caches
>>> with exports -f and then send an rpc with a filehandle, it should =
call
>>> svc_defer on that request.
>>=20
>> /me puts a brown paper bag over his head
>>=20
>> Reverting 241b1f419f0e ("SUNRPC: Remove xdr_buf_trim()") seems to fix =
both
>> krb5i and krb5p.
>=20
> Well, it has my ack too....
>=20
>> I'll post an official patch once I've done a little more testing. I =
promise
>> to get the Fixes: tag right :-)
>=20
> I did have it in the back of my mind that one of us had fixed a =
similar
> bug before.  Indeed, Jeff's:
>=20
> 	4c190e2f913f "sunrpc: trim off trailing checksum before
> 		returning decrypted or integrity authenticated buffer"
>=20
> explains exactly the bug you saw.

Yep, I agree with the purpose of 4c190e2f913f.

The operation of xdr_bufs is different on the client and server in
many subtle ways, which I probably still don't completely understand.
The piece I missed was that the server ignores buf->len in many cases,
preferring instead to use the xdr_buf segment lengths. So simply
updating buf->len is insufficient on the server side.


> Maybe some of that changelog should move into a code comment instead.

The patch I'm testing is a mechanical revert. It doesn't improve the
comments, and restores a BUG_ON that 241b1f419f0e removed. I'm putting
off clean-ups for the moment because I'd like to see this fix in 5.7-rc.


> And I still think the code is more accidents waiting to happen.

The bigger picture is updating the server to use xdr_stream throughout
its XDR stack. That's the main reason I worked on the client-side GSS
wrap and unwrap functions last year.

Using xdr_stream would move the server and client sides closer together
in style and implementation, then hopefully we could share more code.


--
Chuck Lever



