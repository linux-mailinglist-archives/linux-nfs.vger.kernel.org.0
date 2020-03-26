Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEC11940A3
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2020 15:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbgCZOAE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Mar 2020 10:00:04 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56218 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727737AbgCZOAD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Mar 2020 10:00:03 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02QDsO17013311;
        Thu, 26 Mar 2020 13:59:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=Ys62YPBxbQteKtVH1hJ97oFGfigshoTuejt6I3cQw2A=;
 b=X4dQKDnMFDPidU3jEte26R42nGb82bvMaMnKV09XL8SAWLy+znwNUUlnPT3WRqAHgkqP
 cnG1Iv7JPoRssZtgZ91q/6uns7RhOoAskqzs1NQ9ASdy3YnRREp9Ire7yltXKGG1DB+A
 6+TU0i1MMr/n9qXVY9JcNO8yERX8Lb8hklgmaTfoMvs+RH4JzGYAlYYj8kbogluzkH9u
 VZpT4XuggWL8CWtnsw7nKw3HX8mMDHGDgWKl4AebYhhE6wUE/JdKFmv4Dno4StYppXlI
 lw6wAPhSz6MHPo2FHy6bReY//K+EB3Im6yFbRHsX/HQwpHg0L+yP/N6x0mceJo7Bb9zk tg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 300urk0nhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Mar 2020 13:59:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02QDpf8h100966;
        Thu, 26 Mar 2020 13:59:57 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 3003gkwq0n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Mar 2020 13:59:57 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02QDxrtE011565;
        Thu, 26 Mar 2020 13:59:53 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Mar 2020 06:59:53 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 1/1] SUNRPC: fix krb5p mount to provide large enough
 buffer in rq_rcvsize
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN-5tyEDRQZX-saVrbfn7G7pzmSOyROipEzxjVPxF1WV8rK+vg@mail.gmail.com>
Date:   Thu, 26 Mar 2020 09:59:51 -0400
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F59C7AF3-E11B-47BB-BD92-38EDF7C9B07C@oracle.com>
References: <20200325210136.2826-1-olga.kornievskaia@gmail.com>
 <B6EFDEA3-BEB0-4ED0-8288-34CAE4BE9B8A@oracle.com>
 <CAN-5tyEDRQZX-saVrbfn7G7pzmSOyROipEzxjVPxF1WV8rK+vg@mail.gmail.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 adultscore=0 spamscore=0 malwarescore=0 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003260107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 spamscore=0
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 mlxscore=0 phishscore=0
 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003260107
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 26, 2020, at 8:04 AM, Olga Kornievskaia =
<olga.kornievskaia@gmail.com> wrote:
>=20
> On Wed, Mar 25, 2020 at 5:34 PM Chuck Lever <chuck.lever@oracle.com> =
wrote:
>>=20
>>=20
>>=20
>>> On Mar 25, 2020, at 5:01 PM, Olga Kornievskaia =
<olga.kornievskaia@gmail.com> wrote:
>>>=20
>>> From: Olga Kornievskaia <kolga@netapp.com>
>>>=20
>>> Ever since commit 2c94b8eca1a2 ("SUNRPC: Use au_rslack when =
computing
>>> reply buffer size"). It changed how "req->rq_rcvsize" is calculated. =
It
>>> used to use au_cslack value which was nice and large and changed it =
to
>>> au_rslack value which turns out to be too small.
>>>=20
>>> Since 5.1, v3 mount with sec=3Dkrb5p fails against an Ontap server
>>> because client's receive buffer it too small.
>>>=20
>>> For gss krb5p, we need to account for the mic token in the verifier,
>>> and the wrap token in the wrap token.
>>>=20
>>> RFC 4121 defines:
>>> mic token
>>> Octet no   Name        Description
>>>        =
--------------------------------------------------------------
>>>        0..1     TOK_ID     Identification field.  Tokens emitted by
>>>                            GSS_GetMIC() contain the hex value 04 04
>>>                            expressed in big-endian order in this
>>>                            field.
>>>        2        Flags      Attributes field, as described in section
>>>                            4.2.2.
>>>        3..7     Filler     Contains five octets of hex value FF.
>>>        8..15    SND_SEQ    Sequence number field in clear text,
>>>                            expressed in big-endian order.
>>>        16..last SGN_CKSUM  Checksum of the "to-be-signed" data and
>>>                            octet 0..15, as described in section =
4.2.4.
>>>=20
>>> that's 16bytes (GSS_KRB5_TOK_HDR_LEN) + chksum
>>>=20
>>> wrap token
>>> Octet no   Name        Description
>>>        =
--------------------------------------------------------------
>>>         0..1     TOK_ID    Identification field.  Tokens emitted by
>>>                            GSS_Wrap() contain the hex value 05 04
>>>                            expressed in big-endian order in this
>>>                            field.
>>>         2        Flags     Attributes field, as described in section
>>>                            4.2.2.
>>>         3        Filler    Contains the hex value FF.
>>>         4..5     EC        Contains the "extra count" field, in big-
>>>                            endian order as described in section =
4.2.3.
>>>         6..7     RRC       Contains the "right rotation count" in =
big-
>>>                            endian order, as described in section
>>>                            4.2.5.
>>>         8..15    SND_SEQ   Sequence number field in clear text,
>>>                            expressed in big-endian order.
>>>         16..last Data      Encrypted data for Wrap tokens with
>>>                            confidentiality, or plaintext data =
followed
>>>                            by the checksum for Wrap tokens without
>>>                            confidentiality, as described in section
>>>                            4.2.4.
>>>=20
>>> Also 16bytes of header (GSS_KRB5_TOK_HDR_LEN), encrypted data, and =
cksum
>>> (other things like padding)
>>>=20
>>> RFC 3961 defines known cksum sizes:
>>> Checksum type              sumtype        checksum         section =
or
>>>                               value            size         =
reference
>>>  =
---------------------------------------------------------------------
>>>  CRC32                            1               4           6.1.3
>>>  rsa-md4                          2              16           6.1.2
>>>  rsa-md4-des                      3              24           6.2.5
>>>  des-mac                          4              16           6.2.7
>>>  des-mac-k                        5               8           6.2.8
>>>  rsa-md4-des-k                    6              16           6.2.6
>>>  rsa-md5                          7              16           6.1.1
>>>  rsa-md5-des                      8              24           6.2.4
>>>  rsa-md5-des3                     9              24             ??
>>>  sha1 (unkeyed)                  10              20             ??
>>>  hmac-sha1-des3-kd               12              20            6.3
>>>  hmac-sha1-des3                  13              20             ??
>>>  sha1 (unkeyed)                  14              20             ??
>>>  hmac-sha1-96-aes128             15              20         =
[KRB5-AES]
>>>  hmac-sha1-96-aes256             16              20         =
[KRB5-AES]
>>>  [reserved]                  0x8003               ?         =
[GSS-KRB5]
>>>=20
>>> Linux kernel now mainly supports type 15,16 so max cksum size is =
20bytes.
>>> (GSS_KRB5_MAX_CKSUM_LEN)
>>>=20
>>> Re-use already existing define of GSS_KRB5_MAX_SLACK_NEEDED that's =
used
>>> for encoding the gss_wrap tokens (same tokens are used in reply).
>>>=20
>>> Fixes: 2c94b8eca1a2 ("SUNRPC: Use au_rslack when computing reply =
buffer size")
>>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
>>> ---
>>> net/sunrpc/auth_gss/auth_gss.c | 5 ++++-
>>> 1 file changed, 4 insertions(+), 1 deletion(-)
>>>=20
>>> diff --git a/net/sunrpc/auth_gss/auth_gss.c =
b/net/sunrpc/auth_gss/auth_gss.c
>>> index 24ca861..5a733a6 100644
>>> --- a/net/sunrpc/auth_gss/auth_gss.c
>>> +++ b/net/sunrpc/auth_gss/auth_gss.c
>>> @@ -20,6 +20,7 @@
>>> #include <linux/sunrpc/clnt.h>
>>> #include <linux/sunrpc/auth.h>
>>> #include <linux/sunrpc/auth_gss.h>
>>> +#include <linux/sunrpc/gss_krb5.h>
>>> #include <linux/sunrpc/svcauth_gss.h>
>>> #include <linux/sunrpc/gss_err.h>
>>> #include <linux/workqueue.h>
>>> @@ -51,6 +52,8 @@
>>> /* length of a krb5 verifier (48), plus data added before arguments =
when
>>> * using integrity (two 4-byte integers): */
>>> #define GSS_VERF_SLACK                100
>>> +/* covers lengths of gss_unwrap() extra kerberos mic and wrap token =
*/
>>> +#define GSS_RESP_SLACK               (GSS_KRB5_MAX_SLACK_NEEDED << =
2)
>>=20
>> GSS_KRB5_MAX_SLACK_NEEDED is already in bytes. Shouldn't need the "<< =
2" here.
>=20
>=20
> Ok yes just for my own understanding I convinced myself that indeed
> "<<2" is not needed here because clnt.c will do rq_rcvsize is <<=3D2.
>=20
> Now question: Do I even need to introduce GSS_RES_SLACK at all or
> perhaps just use GSS_KRB5_MAX_SLACK_NEEDED to initialize?

For the moment, Kerberos is the only supported security flavor,
so we're using that value without any other modification. I guess
the extra "#define GSS_RESP_SLACK" seems pointless in that case.

I'm OK with using the KRB5_MAX_SLACK macro directly if there's no
objection from others.


>>> static DEFINE_HASHTABLE(gss_auth_hash_table, 4);
>>> static DEFINE_SPINLOCK(gss_auth_hash_lock);
>>> @@ -1050,7 +1053,7 @@ static void gss_pipe_free(struct gss_pipe *p)
>>>              goto err_put_mech;
>>>      auth =3D &gss_auth->rpc_auth;
>>>      auth->au_cslack =3D GSS_CRED_SLACK >> 2;
>>> -     auth->au_rslack =3D GSS_VERF_SLACK >> 2;
>>> +     auth->au_rslack =3D GSS_RESP_SLACK >> 2;
>>>      auth->au_verfsize =3D GSS_VERF_SLACK >> 2;
>>>      auth->au_ralign =3D GSS_VERF_SLACK >> 2;
>>>      auth->au_flags =3D 0;
>>> --
>>> 1.8.3.1
>>>=20
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



