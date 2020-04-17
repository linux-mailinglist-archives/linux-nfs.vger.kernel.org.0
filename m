Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2DCB1AE7C5
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Apr 2020 23:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbgDQVs4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Apr 2020 17:48:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46874 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbgDQVs4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Apr 2020 17:48:56 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03HLm4YC024708;
        Fri, 17 Apr 2020 21:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=2HoipNBekwatYfMungOiZ+8WtrftllmAdxsSG4rsxgA=;
 b=HH1nBFu/Up3OasgqNNkD3mz8kanYsOsBSxqUCVWELiY5WJftBQsErN7YfI8se92PR88j
 A0qdQ/2oX+NmzNQ3x4gHIgD4+ZN5CzDx7HQda2ZTYHQRht/ZirJYkjGb7pTOshShI70c
 hDq+1ob1CrS7GDoqZoEFHpKv+9gBBFHWv8roI+fn6W4MqL2pfOs+Kho7nMNABDPTlW4P
 s/wQFfJJEjLHZJOHJnUQpzuVivpx/sU7FZQb9JkZA8lZRv5D2QT3Vb1sr71/QkEIRHkI
 YLNX1kB3/KDqefCN2O+tZwpo7dsVFBEq6FSHW/9rCJdROCFU5sHkpRKOwl2XceJzptlz Rw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 30e0aaews8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Apr 2020 21:48:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03HLlMMw038589;
        Fri, 17 Apr 2020 21:48:44 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 30dn92929w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Apr 2020 21:48:44 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03HLmbJa010228;
        Fri, 17 Apr 2020 21:48:41 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 17 Apr 2020 14:48:37 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: GSS unwrapping breaks the DRC
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <39815C35-EAD8-4B2E-B48F-88F3D5B10C57@oracle.com>
Date:   Fri, 17 Apr 2020 17:48:35 -0400
Cc:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AA069628-0668-4F15-8C29-23997D04185B@oracle.com>
References: <DAED9EC8-7461-48FF-AD6C-C85FB968F8A6@oracle.com>
 <20200415192542.GA6466@fieldses.org>
 <0775FBE7-C2DD-4ED6-955D-22B944F302E0@oracle.com>
 <20200415215823.GB6466@fieldses.org>
 <39815C35-EAD8-4B2E-B48F-88F3D5B10C57@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>,
        Trond Myklebust <trondmy@hammerspace.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9594 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=396
 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004170158
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9594 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1011
 impostorscore=0 mlxlogscore=454 mlxscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004170158
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 15, 2020, at 6:23 PM, Chuck Lever <chuck.lever@oracle.com> =
wrote:
>=20
>=20
>=20
>> On Apr 15, 2020, at 5:58 PM, Bruce Fields <bfields@fieldses.org> =
wrote:
>>=20
>> On Wed, Apr 15, 2020 at 04:06:17PM -0400, Chuck Lever wrote:
>>>=20
>>>=20
>>>> On Apr 15, 2020, at 3:25 PM, Bruce Fields <bfields@fieldses.org> =
wrote:
>>>>=20
>>>> On Wed, Apr 15, 2020 at 01:05:11PM -0400, Chuck Lever wrote:
>>>>> Hi Bruce and Jeff:
>>>>>=20
>>>>> Testing intensive workloads with NFSv3 and NFSv4.0 on NFS/RDMA =
with krb5i
>>>>> or krb5p results in a pretty quick workload failure. Closer =
examination
>>>>> shows that the client is able to overrun the GSS sequence window =
with
>>>>> some regularity. When that happens, the server drops the =
connection.
>>>>>=20
>>>>> However, when the client retransmits requests with lost replies, =
they
>>>>> never hit in the DRC, and that results in unexpected failures of =
non-
>>>>> idempotent requests.
>>>>>=20
>>>>> The retransmitted XIDs are found in the DRC, but the retransmitted =
request
>>>>> has a different checksum than the original. We're hitting the =
"mismatch"
>>>>> case in nfsd_cache_key_cmp for these requests.
>>>>>=20
>>>>> I tracked down the problem to the way the DRC computes the length =
of the
>>>>> part of the buffer it wants to checksum. nfsd_cache_csum uses
>>>>>=20
>>>>> head.iov_len + page_len
>>>>>=20
>>>>> and then caps that at RC_CSUMLEN.
>>>>>=20
>>>>> That works fine for krb5 and sys, but the GSS unwrap functions
>>>>> (integ_unwrap_data and priv_unwrap_data) don't appear to update =
head.iov_len
>>>>> properly. So nfsd_cache_csum's length computation is significantly =
larger
>>>>> than the clear-text message, and that allows stale parts of the =
xdr_buf
>>>>> to be included in the checksum.
>>>>>=20
>>>>> Using xdr_buf_subsegment() at the end of integ_unwrap_data sets =
the xdr_buf
>>>>> lengths properly and fixes the situation for krb5i.
>>>>>=20
>>>>> I don't see a similar solution for priv_unwrap_data: there's no =
MIC len
>>>>> available, and priv_len is not the actual length of the clear-text =
message.
>>>>>=20
>>>>> Moreover, the comment in fix_priv_head() is disturbing. I don't =
see anywhere
>>>>> where the relationship between the buf's head/len and how =
svc_defer works is
>>>>> authoritatively documented. It's not clear exactly how =
priv_unwrap_data is
>>>>> supposed to accommodate svc_defer, or whether integ_unwrap_data =
also needs
>>>>> to accommodate it.
>>>>>=20
>>>>> So I can't tell if the GSS unwrap functions are wrong or if =
there's a more
>>>>> accurate way to compute the message length in nfsd_cache_csum. I =
suspect
>>>>> both could use some improvement, but I'm not certain exactly what =
that
>>>>> might be.
>>>>=20
>>>> I don't know, I tried looking through that code and didn't get any
>>>> further than you.  The gss unwrap code does look suspect to me.  It
>>>> needs some kind of proper design, as it stands it's just an =
accumulation
>>>> of fixes.
>>>=20
>>> Having recently completed overhauling the client-side equivalents, I
>>> agree with you there.
>>>=20
>>> I've now convinced myself that because nfsd_cache_csum might need to
>>> advance into the first page of the Call message, rq_arg.head.iov_len
>>> must contain an accurate length so that csum_partial is applied
>>> correctly to the head buffer.
>>>=20
>>> Therefore it is the preceding code that needs to set up =
rq_arg.head.iov_len
>>> correctly. The GSS unwrap functions have to do this, and therefore =
these
>>> must be fixed. I would theorize that svc_defer also depends on =
head.iov_len
>>> being set correctly.
>>>=20
>>> As far as how rq_arg.len needs to be set for svc_defer, I think I =
need
>>> to have some kind of test case to examine how that path is =
triggered. Any
>>> advice appreciated.
>>=20
>> It's triggered on upcalls, so for example if you flush the export =
caches
>> with exports -f and then send an rpc with a filehandle, it should =
call
>> svc_defer on that request.
>=20
> /me puts a brown paper bag over his head
>=20
> Reverting 241b1f419f0e ("SUNRPC: Remove xdr_buf_trim()") seems to fix =
both
> krb5i and krb5p.
>=20
> I'll post an official patch once I've done a little more testing. I =
promise
> to get the Fixes: tag right :-)

I've hit a snag here.

I reverted 241b1f419f0e on my server, and all tests completed
successfully.

I reverted 241b1f419f0e on my client, and now krb5p is failing. Using
xdr_buf_trim does the right thing on the server, but on the client it
has exposed a latent bug in gss_unwrap_resp_priv() (ie, the bug does
not appear to be harmful until 241b1f419f0e has been reverted).

The calculation of au_ralign in that function is wrong, and that forces
rpc_prepare_reply_pages to allocate a zero-length tail. xdr_buf_trim()
then lops off the end of each subsequent clear-text RPC message, and
eventually a short READ results in test failures.

After experimenting with this for a day, I don't see any way for
gss_unwrap_resp_priv() to estimate au_ralign based on what gss_unwrap()
has done to the xdr_buf. The kerberos_v1 unwrap method does not appear
to have any trailing checksum, for example, but v2 does.

The best approach for now seems to be to have the pseudoflavor-specific
unwrap methods return the correct ralign value. A straightforward way
to do this would be to add a *int parameter to ->gss_unwrap that would
be set to the proper value; or hide that value somewhere in the xdr_buf.

Any other thoughts or random bits of inspiration?


--
Chuck Lever



