Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 792871776F1
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Mar 2020 14:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgCCN2G (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Mar 2020 08:28:06 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44570 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbgCCN2G (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Mar 2020 08:28:06 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 023DRi1V137872;
        Tue, 3 Mar 2020 13:27:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 content-transfer-encoding : from : mime-version : subject : date :
 message-id : references : cc : in-reply-to : to; s=corp-2020-01-29;
 bh=4uBQXbohBCPauxNVBKSxVlDkr8ZiGTYylup1XtPFb74=;
 b=qvWUvyofWNdLYID3nouKJng8I+ktdkDuu9PTPttN0xsNqttHjuuJOJ5XXSlFHXm0P/06
 8zKulKVc7kp6nut+MmqDFhRwgz+cMC7GXNrSbH5RYdXRBEAnmZX+aE0siQB1CUEn6fS1
 qKo/D4lofGONyCJRO8cGNaGfWg/xacZLxwNUMd4IJV/YYCbfi2BAmnoQU/LhaOta+hAZ
 hLSzhEKQLsNf4bu8NQBVSwTzQamfN6PfY65UbgOOTcqcHAKmzjXhaqNY7B2nm/yDYz00
 wcRNhSa9FXsKzSUi93NS9Zkzx9Zx/i2DRmZKmwqG3ZwvE0uXNO1wJNurRenTIb9JNktQ 8g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2yffcuf8q3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Mar 2020 13:27:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 023DMhVF002241;
        Tue, 3 Mar 2020 13:27:57 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2yg1ekq86d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Mar 2020 13:27:56 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 023DRr6a000921;
        Tue, 3 Mar 2020 13:27:53 GMT
Received: from [192.168.1.139] (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Mar 2020 05:27:52 -0800
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Chuck Lever <chuck.lever@oracle.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 2/8] nfsd: Add tracing to nfsd_set_fh_dentry()
Date:   Tue, 3 Mar 2020 08:27:51 -0500
Message-Id: <26084E44-0677-42A6-8DC8-71169070FE8D@oracle.com>
References: <3fa96b3a1ec599624d464085854a39a6b2b86447.camel@hammerspace.com>
Cc:     "chucklever@gmail.com" <chucklever@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>
In-Reply-To: <3fa96b3a1ec599624d464085854a39a6b2b86447.camel@hammerspace.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
X-Mailer: iPhone Mail (17D50)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9548 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003030102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9548 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003030103
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Mar 3, 2020, at 12:59 AM, Trond Myklebust <trondmy@hammerspace.com> wro=
te:
>=20
> =EF=BB=BFOn Mon, 2020-03-02 at 19:22 -0500, Chuck Lever wrote:
>>> On Mar 1, 2020, at 6:21 PM, Trond Myklebust <trondmy@gmail.com>
>>> wrote:
>>>=20
>>> Add tracing to allow us to figure out where any stale filehandle
>>> issues
>>> may be originating from.
>>>=20
>>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>>> ---
>>> fs/nfsd/nfsfh.c | 13 ++++++++++---
>>> fs/nfsd/trace.h | 30 ++++++++++++++++++++++++++++++
>>> 2 files changed, 40 insertions(+), 3 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
>>> index b319080288c3..37bc8f5f4514 100644
>>> --- a/fs/nfsd/nfsfh.c
>>> +++ b/fs/nfsd/nfsfh.c
>>> @@ -14,6 +14,7 @@
>>> #include "nfsd.h"
>>> #include "vfs.h"
>>> #include "auth.h"
>>> +#include "trace.h"
>>>=20
>>> #define NFSDDBG_FACILITY        NFSDDBG_FH
>>>=20
>>> @@ -209,11 +210,14 @@ static __be32 nfsd_set_fh_dentry(struct
>>> svc_rqst *rqstp, struct svc_fh *fhp)
>>>    }
>>>=20
>>>    error =3D nfserr_stale;
>>> -    if (PTR_ERR(exp) =3D=3D -ENOENT)
>>> -        return error;
>>> +    if (IS_ERR(exp)) {
>>> +        trace_nfsd_set_fh_dentry_badexport(rqstp, fhp,
>>> PTR_ERR(exp));
>>> +
>>> +        if (PTR_ERR(exp) =3D=3D -ENOENT)
>>> +            return error;
>>>=20
>>> -    if (IS_ERR(exp))
>>>        return nfserrno(PTR_ERR(exp));
>>> +    }
>>>=20
>>>    if (exp->ex_flags & NFSEXP_NOSUBTREECHECK) {
>>>        /* Elevate privileges so that the lack of 'r' or 'x'
>>> @@ -267,6 +271,9 @@ static __be32 nfsd_set_fh_dentry(struct
>>> svc_rqst *rqstp, struct svc_fh *fhp)
>>>        dentry =3D exportfs_decode_fh(exp->ex_path.mnt, fid,
>>>                data_left, fileid_type,
>>>                nfsd_acceptable, exp);
>>> +        if (IS_ERR_OR_NULL(dentry))
>>> +            trace_nfsd_set_fh_dentry_badhandle(rqstp, fhp,
>>> +                    dentry ?  PTR_ERR(dentry) :
>>> -ESTALE);
>>=20
>> If you'll be respinning this series, a handful of nits:
>>=20
>=20
> I see no need to respin the entire series. Just the last patch.

Fair enough.


>> - the line above has a double space
>> - the trace point names here are a little long, will result in
>>  hard-to-read formatting in the trace log
>> - checkpatch.pl complains about a couple of the later patches,
>>  where one arm of an "if" statement has braces but the other
>>  does not
>>=20
>>>    }
>>>    if (dentry =3D=3D NULL)
>>>        goto out;
>>> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
>>> index 06dd0d337049..9abd1591a841 100644
>>> --- a/fs/nfsd/trace.h
>>> +++ b/fs/nfsd/trace.h
>>> @@ -50,6 +50,36 @@ TRACE_EVENT(nfsd_compound_status,
>>>        __get_str(name), __entry->status)
>>> )
>>>=20
>>> +DECLARE_EVENT_CLASS(nfsd_fh_err_class,
>>> +    TP_PROTO(struct svc_rqst *rqstp,
>>> +         struct svc_fh    *fhp,
>>> +         int        status),
>>> +    TP_ARGS(rqstp, fhp, status),
>>> +    TP_STRUCT__entry(
>>> +        __field(u32, xid)
>>> +        __field(u32, fh_hash)
>>> +        __field(int, status)
>>> +    ),
>>> +    TP_fast_assign(
>>> +        __entry->xid =3D be32_to_cpu(rqstp->rq_xid);
>>> +        __entry->fh_hash =3D knfsd_fh_hash(&fhp->fh_handle);
>>> +        __entry->status =3D status;
>>> +    ),
>>> +    TP_printk("xid=3D0x%08x fh_hash=3D0x%08x status=3D%d",
>>> +          __entry->xid, __entry->fh_hash,
>>> +          __entry->status)
>>> +)
>>> +
>>> +#define DEFINE_NFSD_FH_ERR_EVENT(name)        \
>>> +DEFINE_EVENT(nfsd_fh_err_class, nfsd_##name,    \
>>> +    TP_PROTO(struct svc_rqst *rqstp,    \
>>> +         struct svc_fh    *fhp,        \
>>> +         int        status),    \
>>> +    TP_ARGS(rqstp, fhp, status))
>>> +
>>> +DEFINE_NFSD_FH_ERR_EVENT(set_fh_dentry_badexport);
>>> +DEFINE_NFSD_FH_ERR_EVENT(set_fh_dentry_badhandle);
>>> +
>>> DECLARE_EVENT_CLASS(nfsd_io_class,
>>>    TP_PROTO(struct svc_rqst *rqstp,
>>>         struct svc_fh    *fhp,
>>> --=20
>>> 2.24.1
>>>=20
>>=20
>> --
>> Chuck Lever
>> chucklever@gmail.com
>>=20
>>=20
>>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>=20
>=20

