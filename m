Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988D02CF1BC
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Dec 2020 17:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbgLDQPl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Dec 2020 11:15:41 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:45824 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729019AbgLDQPl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Dec 2020 11:15:41 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B4G9lll072969;
        Fri, 4 Dec 2020 16:14:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=B4VAhZpHqY6eutSfZ8J9zr8uNCArKErdQs7I4DufXd0=;
 b=XZ0k3Xw6qRN7PtNzc6qpe3l6Gs2y6aaIkURQGt9VPYS5S6QavMObH5X5uj6PsHijDpQZ
 wAnycOraWrJoDD/UyfRvVsTuMGx/fZCXHDjgqxgfCCg/D5RBkCg6A2eE04N13RXr5Xrp
 9b1VLMyNntoHVviGkdWX8aGW2cvFUg+WXRRvgb85Qnxk0ID9kHhqdboPkzEmbAhMr7fa
 qvV6rLGW6ejj+44BT6tHLbtLrBy0lRdnxqSL6iH7F3n5p0dMzvSci9kLVJf7Jv8kL8RL
 8gaYj7BwS81M7tDDZss2ujwb2nIkxs/u0SmXbrCp9MWTzljFaAJmGOrU6+81q4z8gKpr BA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 353dyr3ygx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 04 Dec 2020 16:14:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B4GATQA065064;
        Fri, 4 Dec 2020 16:14:56 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 3540ay9m0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Dec 2020 16:14:56 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0B4GEtG3020890;
        Fri, 4 Dec 2020 16:14:55 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219) by default
 (Oracle Beehive Gateway v4.0) with ESMTP ; Fri, 04 Dec 2020 08:14:49 -0800
MIME-Version: 1.0
Message-ID: <8D97BD94-8518-4AAC-9789-996D956A02CF@oracle.com>
Date:   Fri, 4 Dec 2020 08:14:48 -0800 (PST)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     Anna Schumaker <schumaker.anna@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 2/3] NFS: Allocate a scratch page for READ_PLUS
References: <20201203201841.103294-1-Anna.Schumaker@Netapp.com>
 <20201203201841.103294-3-Anna.Schumaker@Netapp.com>
 <8CE5CE8C-9301-4250-B077-ACE23969C19A@oracle.com>
 <CAFX2JfnsHskDd+tsGcZ1-JNaWpZ9V4c-5=x2VE4mwC6p+MhfYQ@mail.gmail.com>
 <dc191256b163d0c824c911fe7272d5443f2fd045.camel@hammerspace.com>
In-Reply-To: <dc191256b163d0c824c911fe7272d5443f2fd045.camel@hammerspace.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9824 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012040093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9825 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 clxscore=1015 mlxscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012040093
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 3, 2020, at 3:39 PM, Trond Myklebust <trondmy@hammerspace.com> =
wrote:
>=20
> On Thu, 2020-12-03 at 15:31 -0500, Anna Schumaker wrote:
>> On Thu, Dec 3, 2020 at 3:27 PM Chuck Lever <chuck.lever@oracle.com>
>> wrote:
>>>=20
>>>=20
>>>=20
>>>> On Dec 3, 2020, at 3:18 PM, schumaker.anna@gmail.com wrote:
>>>>=20
>>>> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>>>=20
>>>> We might need this to better handle shifting around data in the
>>>> reply
>>>> buffer.
>>>>=20
>>>> Suggested-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>>> ---
>>>> fs/nfs/nfs42xdr.c       |  2 ++
>>>> fs/nfs/read.c           | 13 +++++++++++--
>>>> include/linux/nfs_xdr.h |  1 +
>>>> 3 files changed, 14 insertions(+), 2 deletions(-)
>>>>=20
>>>> diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
>>>> index 8432bd6b95f0..ef095a5f86f7 100644
>>>> --- a/fs/nfs/nfs42xdr.c
>>>> +++ b/fs/nfs/nfs42xdr.c
>>>> @@ -1297,6 +1297,8 @@ static int nfs4_xdr_dec_read_plus(struct
>>>> rpc_rqst *rqstp,
>>>>       struct compound_hdr hdr;
>>>>       int status;
>>>>=20
>>>> +     xdr_set_scratch_buffer(xdr, page_address(res->scratch),
>>>> PAGE_SIZE);
>>>=20
>>> I intend to submit this for v5.11:
>>>=20
>>> =
https://git.linux-nfs.org/?p=3Dcel/cel-2.6.git;a=3Dcommit;h=3D0ae4c3e8a64a=
ce1b8d7de033b0751afe43024416
>>=20
>> Thanks for the heads up! This patch can probably be deferred until
>> yours goes in.
>>=20
>>>=20
>>> But seems like enough callers need a scratch buffer that the XDR
>>> layer should set up it transparently for all requests.
>>=20
>> That could work too, and save some headache.
>>=20
>=20
> Why not just integrate it into xdr_init_decode_pages(), and then add a
> matching xdr_exit_decode_pages() to free up any allocated page?

Sounds OK.

For comparison, to support xdr_stream decoding on the server, I've
changed svc_rqst_alloc() to grab a page that stays around until the
nfsd thread dies. There is a new svcxdr_init_decode() API that
attaches that page for use as the decoding scratch buffer.

Since it's a new API, the call sites that set up new streams with
xdr_init_decode() are not affected.

See:

=
https://git.linux-nfs.org/?p=3Dcel/cel-2.6.git;a=3Dcommit;h=3D5191955d6fc6=
5e6d4efe8f4f10a6028298f57281


--
Chuck Lever



