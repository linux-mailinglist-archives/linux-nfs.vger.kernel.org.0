Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB9A12836C
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Dec 2019 21:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfLTU5k (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Dec 2019 15:57:40 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:60226 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfLTU5k (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Dec 2019 15:57:40 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBKKsACO062374;
        Fri, 20 Dec 2019 20:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=7seFl66qgjRX1tWmlQ99VOm8wsOFyejWlwIU7ot/H6M=;
 b=i5YVdzN/kqK8H3q+X7JMedZfiyyI58HgPVB34DSfHurxv2g8fAOVrHkxy9SeIXziXybi
 k2K8PTmIR77Q9hQRn8PWTYr3z03YAXAlon1kJ+mtM6STVFIXXj9teYLnAFN0zEWK0hqW
 WHVjxW7j5OsPwaGQB2QD/JcqYx+E2/9q+mEmDSZfFZ7xB8Fg8oO1psVviRwOQTMI3akH
 7mRFkI0tle8St/ol+KTgUZZ1vcMJWw2mwiJOAzQJRIX3ucdq2lzA/wYvbY9jVbWJuH05
 0idhIOV6QOovHb2nfos+Tsm3t5ScrUKq7nnswmBT0Z1snUGhmfWCgxqOt0HaLtFyiSEA dw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2x01kntwpg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Dec 2019 20:57:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBKKrM8q143781;
        Fri, 20 Dec 2019 20:57:31 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2x0vc4j401-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Dec 2019 20:57:31 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBKKvR01026486;
        Fri, 20 Dec 2019 20:57:28 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 20 Dec 2019 12:57:27 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: acls+kerberos (limitation)
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN-5tyErUmHiC5S=EM-kFmdPPxs0Kg8nLNK=juc6eFm2SdWEhw@mail.gmail.com>
Date:   Fri, 20 Dec 2019 15:57:26 -0500
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5ABD9A2F-64D5-406C-A28D-5FEA70B0AD4A@oracle.com>
References: <CAN-5tyHJLh8+htpb47Uz+ojo5EfrpP=zyE-Vfk=HjvBgK591=g@mail.gmail.com>
 <f4595e80487d9ace332e2ae69bc0c539a5c029bb.camel@hammerspace.com>
 <CAN-5tyGXUhhZVkrBxTwGP-Y2FXoMdN9kYtc9r0wS8P8EQuxyoQ@mail.gmail.com>
 <C5067A0A-5FA4-4FC0-B5B6-828EB3E83373@oracle.com>
 <CAN-5tyEv4UTfCmkkrYFnOB7nHAV8qX7opfSb=RJT_=PA5tih4g@mail.gmail.com>
 <E086E39A-E140-420F-87CA-A6959F301AD8@oracle.com>
 <CAN-5tyF1iJsm6CSezZ4HGaWSU-5w4Q1W3_e8f6V6v9Uk+B6+Ag@mail.gmail.com>
 <AD3D5C4D-25C5-4457-9F3A-4EFC703911B4@oracle.com>
 <CAN-5tyErUmHiC5S=EM-kFmdPPxs0Kg8nLNK=juc6eFm2SdWEhw@mail.gmail.com>
To:     Olga Kornievskaia <aglo@umich.edu>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9477 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912200159
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9477 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912200159
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 20, 2019, at 3:53 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
>=20
> On Fri, Dec 20, 2019 at 3:11 PM Chuck Lever <chuck.lever@oracle.com> =
wrote:
>>=20
>>=20
>>=20
>>> On Dec 20, 2019, at 3:04 PM, Olga Kornievskaia <aglo@umich.edu> =
wrote:
>>>=20
>>> On Fri, Dec 20, 2019 at 1:28 PM Chuck Lever <chuck.lever@oracle.com> =
wrote:
>>>>=20
>>>>=20
>>>>=20
>>>>> On Dec 20, 2019, at 1:15 PM, Olga Kornievskaia <aglo@umich.edu> =
wrote:
>>>>>=20
>>>>> On Wed, Dec 18, 2019 at 2:34 PM Chuck Lever =
<chuck.lever@oracle.com> wrote:
>>>>>>=20
>>>>>>=20
>>>>>>=20
>>>>>>> On Dec 18, 2019, at 2:31 PM, Olga Kornievskaia <aglo@umich.edu> =
wrote:
>>>>>>>=20
>>>>>>> On Wed, Dec 18, 2019 at 2:05 PM Trond Myklebust =
<trondmy@hammerspace.com> wrote:
>>>>>>>>=20
>>>>>>>> On Wed, 2019-12-18 at 12:47 -0500, Olga Kornievskaia wrote:
>>>>>>>>> Hi folks,
>>>>>>>>>=20
>>>>>>>>> Is this a well know but undocumented fact that you can't set =
large
>>>>>>>>> amount of acls (over 4096bytes, ~90acls) while mounted using
>>>>>>>>> krb5i/krb5p? That if you want to get/set large acls, it must =
be done
>>>>>>>>> over auth_sys/krb5?
>>>>>>>>>=20
>>>>>>>>=20
>>>>>>>> It's certainly not something that I was aware of. Do you see =
where that
>>>>>>>> limitation is coming from?
>>>>>>>=20
>>>>>>> I haven't figure it exactly but gss_unwrap_resp_integ() is =
failing in
>>>>>>> if (mic_offset > rcv_buf->len). I'm just not sure who sets up =
the
>>>>>>> buffer (or why  rvc_buf->len is (4280) larger than a page can a
>>>>>>> page-limit might make sense to for me but it's not). So you =
think it
>>>>>>> should have been working.
>>>>>>=20
>>>>>> The buffer is set up in the XDR encoder. But pages can be added
>>>>>> by the transport... I guess rcv_buf->len isn't updated when that
>>>>>> happens.
>>>>>>=20
>>>>>=20
>>>>> Here's why the acl+krbi/krb5p is failing.
>>>>>=20
>>>>> acl tool first calls into the kernel to find out how large of a =
buffer
>>>>> it needs to supply and gets acl size then calls down again then =
code
>>>>> in __nfs4_get_acl_uncached() allocates a number of pages (this =
what
>>>>> set's the available buffer length later used by the sunrpc code). =
That
>>>>> works for non-integrity because in call_decode() the call
>>>>> rpc_unwrap_resp() doesn't try to calculate the checksum on the =
buffer
>>>>> that was just read. However, when its krb5i/krb5p we have =
truncated
>>>>> buffer and mic offset that's larger than the existing buffer.
>>>>>=20
>>>>> I think something needs to be marked to skip doing gss for the =
initial
>>>>> acl query?  I first try providing more space in
>>>>> __nfs4_get_acl_uncached() for when authflavor=3Dkrb5i/krb5p and =
buflen=3D0
>>>>> but no matter what the number is the received acl can be larger =
than
>>>>> that thus I don't think that's a good approach.
>>>>=20
>>>> It's not strictly true that the received ACL can be always be =
larger.
>>>> There is an upper bound on request sizes.
>>>>=20
>>>> My preference has always been to allocate a receive buffer of the =
maximum
>>>> size before the call, just like every other request works. I can't =
think
>>>> of any reason why retrieving an ACL has to be different. Then we =
can get
>>>> rid of the hack in the transports to fill in those pages behind the =
back
>>>> of the upper layers.
>>>>=20
>>>> The issue here has always been that there's no way for the client =
to
>>>> discover the number of bytes it needs to retrieve before it sets up =
the
>>>> GETACL.
>>>>=20
>>>> For NFSv4.1+ you can probably assume that the ACL will never be =
larger
>>>> than the session's maximum reply size.
>>>>=20
>>>> For NFSv4.0 you'll have to make something up.
>>>>=20
>>>> But allocating a large receive buffer for this request is the only =
way to
>>>> make the receive reliable. You should be able to do that by =
stuffing the
>>>> recv XDR buffer with individual pages, just like nfsd does, in =
GETACL's
>>>> encoding function.
>>>>=20
>>>> Others might have a different opinion. Or I might have completely
>>>> misunderstood the issue.
>>>>=20
>>>=20
>>> Putting a limit would be easier. I thought of using rsize (wsize) as
>>> we can't get anything larger than in the payload that but that's not
>>> possible. Because the code sets limits based on XATTR_MAX_SIZE which
>>> is a linux server side limitation and it doesn't seem to be
>>> appropriate to be applied as a generic implementation. Would it be =
ok
>>> to change the static memory allocation to be dynamic and based on =
the
>>> rsize? Thoughts?
>>=20
>> Why is using the NFSv4.1 session max reply size not possible? For
>> NFSv4.0, rsize seems reasonable to me.
>=20
> It's not possible because there is a hard limit of number of pages the
> code will allocate (right now).
>=20
> static ssize_t __nfs4_get_acl_uncached(struct inode *inode, void *buf,
> size_t buflen)
> {
>        struct page *pages[NFS4ACL_MAXPAGES + 1] =3D {NULL, };
>=20
> NFS4ACL_MAXPAGES are based on the 64K limit (from the XATTR_MAX_SIZE).
>=20
>        if (npages > ARRAY_SIZE(pages))
>                return -ERANGE;
>=20
> Typically session size (or r/wsizes) are something like 262K or 1M.
>=20
> I was just saying that I'd then would need to remove the static
> structure for pages and make it dynamic based on the (rsize or session
> size).

IMO you should do that. There should be a page array available in
the recv XDR buffer.


> I thought that r/wsize was set to whatever the session sizes
> are so using the r/wsize values would make it work for both 4.0 and
> 4.1+.

<shrug> OK... that choice should be documented in a comment.

--
Chuck Lever



