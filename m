Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110181AB3C4
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2020 00:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731952AbgDOWYH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Apr 2020 18:24:07 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46154 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbgDOWYD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Apr 2020 18:24:03 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03FMNsu3008855;
        Wed, 15 Apr 2020 22:24:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=n3+x+gmMEM/N9gJM/DlzYcNc8h1hpvgciQ/J/bvcZQE=;
 b=RDFZA85BkmMRpWoVSJ0GoLtgqiB11X1QtOZduOlR7Yk007pFgXozmSsysEJoz/QeQUYL
 sy1K7foWrQEZtIPKTprrl4uAmWwdiIpaQMj7eFbfu85PAi/EA7+pwcPee1vevncADge5
 YhMCjQdfz6PAgm5CYJOzuoBViukPWXHvWOvSqfzGYneXHkofnRv1YIYClsuld/Hhvp2k
 wi5LbhnmiosjNYURf8gCnO8gTSlZ3kUzT0gOwMqJ7YFJIDEn5uP48YDs0tJs77i84QLi
 OFIM+peUW+La2iT7jXFnujeJBaMwrdtuW9GwXfaub27rCMl6swK1pjwfQxghHPZ/UprH SQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 30e0bfbqt1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Apr 2020 22:24:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03FMLp25102597;
        Wed, 15 Apr 2020 22:24:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 30dynwp5n4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Apr 2020 22:24:00 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03FMNxMX023139;
        Wed, 15 Apr 2020 22:23:59 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Apr 2020 15:23:59 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: GSS unwrapping breaks the DRC
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200415215823.GB6466@fieldses.org>
Date:   Wed, 15 Apr 2020 18:23:57 -0400
Cc:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <39815C35-EAD8-4B2E-B48F-88F3D5B10C57@oracle.com>
References: <DAED9EC8-7461-48FF-AD6C-C85FB968F8A6@oracle.com>
 <20200415192542.GA6466@fieldses.org>
 <0775FBE7-C2DD-4ED6-955D-22B944F302E0@oracle.com>
 <20200415215823.GB6466@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9592 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=515 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004150168
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9592 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 mlxlogscore=567
 impostorscore=0 adultscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004150168
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 15, 2020, at 5:58 PM, Bruce Fields <bfields@fieldses.org> =
wrote:
>=20
> On Wed, Apr 15, 2020 at 04:06:17PM -0400, Chuck Lever wrote:
>>=20
>>=20
>>> On Apr 15, 2020, at 3:25 PM, Bruce Fields <bfields@fieldses.org> =
wrote:
>>>=20
>>> On Wed, Apr 15, 2020 at 01:05:11PM -0400, Chuck Lever wrote:
>>>> Hi Bruce and Jeff:
>>>>=20
>>>> Testing intensive workloads with NFSv3 and NFSv4.0 on NFS/RDMA with =
krb5i
>>>> or krb5p results in a pretty quick workload failure. Closer =
examination
>>>> shows that the client is able to overrun the GSS sequence window =
with
>>>> some regularity. When that happens, the server drops the =
connection.
>>>>=20
>>>> However, when the client retransmits requests with lost replies, =
they
>>>> never hit in the DRC, and that results in unexpected failures of =
non-
>>>> idempotent requests.
>>>>=20
>>>> The retransmitted XIDs are found in the DRC, but the retransmitted =
request
>>>> has a different checksum than the original. We're hitting the =
"mismatch"
>>>> case in nfsd_cache_key_cmp for these requests.
>>>>=20
>>>> I tracked down the problem to the way the DRC computes the length =
of the
>>>> part of the buffer it wants to checksum. nfsd_cache_csum uses
>>>>=20
>>>> head.iov_len + page_len
>>>>=20
>>>> and then caps that at RC_CSUMLEN.
>>>>=20
>>>> That works fine for krb5 and sys, but the GSS unwrap functions
>>>> (integ_unwrap_data and priv_unwrap_data) don't appear to update =
head.iov_len
>>>> properly. So nfsd_cache_csum's length computation is significantly =
larger
>>>> than the clear-text message, and that allows stale parts of the =
xdr_buf
>>>> to be included in the checksum.
>>>>=20
>>>> Using xdr_buf_subsegment() at the end of integ_unwrap_data sets the =
xdr_buf
>>>> lengths properly and fixes the situation for krb5i.
>>>>=20
>>>> I don't see a similar solution for priv_unwrap_data: there's no MIC =
len
>>>> available, and priv_len is not the actual length of the clear-text =
message.
>>>>=20
>>>> Moreover, the comment in fix_priv_head() is disturbing. I don't see =
anywhere
>>>> where the relationship between the buf's head/len and how svc_defer =
works is
>>>> authoritatively documented. It's not clear exactly how =
priv_unwrap_data is
>>>> supposed to accommodate svc_defer, or whether integ_unwrap_data =
also needs
>>>> to accommodate it.
>>>>=20
>>>> So I can't tell if the GSS unwrap functions are wrong or if there's =
a more
>>>> accurate way to compute the message length in nfsd_cache_csum. I =
suspect
>>>> both could use some improvement, but I'm not certain exactly what =
that
>>>> might be.
>>>=20
>>> I don't know, I tried looking through that code and didn't get any
>>> further than you.  The gss unwrap code does look suspect to me.  It
>>> needs some kind of proper design, as it stands it's just an =
accumulation
>>> of fixes.
>>=20
>> Having recently completed overhauling the client-side equivalents, I
>> agree with you there.
>>=20
>> I've now convinced myself that because nfsd_cache_csum might need to
>> advance into the first page of the Call message, rq_arg.head.iov_len
>> must contain an accurate length so that csum_partial is applied
>> correctly to the head buffer.
>>=20
>> Therefore it is the preceding code that needs to set up =
rq_arg.head.iov_len
>> correctly. The GSS unwrap functions have to do this, and therefore =
these
>> must be fixed. I would theorize that svc_defer also depends on =
head.iov_len
>> being set correctly.
>>=20
>> As far as how rq_arg.len needs to be set for svc_defer, I think I =
need
>> to have some kind of test case to examine how that path is triggered. =
Any
>> advice appreciated.
>=20
> It's triggered on upcalls, so for example if you flush the export =
caches
> with exports -f and then send an rpc with a filehandle, it should call
> svc_defer on that request.

/me puts a brown paper bag over his head

Reverting 241b1f419f0e ("SUNRPC: Remove xdr_buf_trim()") seems to fix =
both
krb5i and krb5p.

I'll post an official patch once I've done a little more testing. I =
promise
to get the Fixes: tag right :-)


--
Chuck Lever



