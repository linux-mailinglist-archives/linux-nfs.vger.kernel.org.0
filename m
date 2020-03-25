Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE09193320
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2020 22:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbgCYVzj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Mar 2020 17:55:39 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54782 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbgCYVzj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Mar 2020 17:55:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02PLrEYM185339;
        Wed, 25 Mar 2020 21:55:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=MHIFLaqehNEzj2aaBi1COtgXhNQ6QwQXQLUeqcUoHrU=;
 b=dDFBncZQ6a1fQcRp62M1ddyVn96jLb2zXxhV7+oC46Vp7zOD5TB4D0Ym77R70pot7nIO
 Cf+zp9hjbsbmZvfDVjBMfOtNd44S1NwhW+OUCVjpkh8VeL3k8Tqc9ou1JR/ZRFdFBsXs
 UnRkPmiBGqAsvuk9IgQnCsx9At8L4ExLGIzUaxnOA8sZgeVeN4jiE5ivqMCcfXlE2/Yg
 xXrDO4Vqtb6r/N7uWUaORHuvyzCHtrDKNgYYwOiLtyI49wG4kdcNDXbXGZADJK0qC/9O
 VMkJY4Wz21yhHzWmWG/wjllXcOkVBx5a+To2i44ngldvmmElroAZW64IK2/wb2+rHr1D wQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2ywabrcc3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Mar 2020 21:55:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02PLqUOr002356;
        Wed, 25 Mar 2020 21:55:34 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2yxw4sabtq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Mar 2020 21:55:33 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02PLtWQk025398;
        Wed, 25 Mar 2020 21:55:32 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 25 Mar 2020 14:55:32 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 1/1] SUNRPC: fix krb5p mount to provide large enough
 buffer in rq_rcvsize
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <95dfed7d00d8d0d02a0705e8c1ceeb961456a554.camel@hammerspace.com>
Date:   Wed, 25 Mar 2020 17:55:31 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0D3443FF-0170-40E2-B3A5-54B486B88023@oracle.com>
References: <20200325210136.2826-1-olga.kornievskaia@gmail.com>
 <7363e7b550dc5adad3f00fb84d9586764b8ec4fb.camel@hammerspace.com>
 <8A8EC7E8-9EB6-49DA-8393-241B4977E67E@oracle.com>
 <95dfed7d00d8d0d02a0705e8c1ceeb961456a554.camel@hammerspace.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=2
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003250167
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=2
 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003250167
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 25, 2020, at 5:52 PM, Trond Myklebust <trondmy@hammerspace.com> =
wrote:
>=20
> On Wed, 2020-03-25 at 17:43 -0400, Chuck Lever wrote:
>>> On Mar 25, 2020, at 5:33 PM, Trond Myklebust <
>>> trondmy@hammerspace.com> wrote:
>>>=20
>>> Hi Olga,
>>>=20
>>> On Wed, 2020-03-25 at 17:01 -0400, Olga Kornievskaia wrote:
>>>> From: Olga Kornievskaia <kolga@netapp.com>
>>>>=20
>>>> Ever since commit 2c94b8eca1a2 ("SUNRPC: Use au_rslack when
>>>> computing
>>>> reply buffer size"). It changed how "req->rq_rcvsize" is
>>>> calculated.
>>>> It
>>>> used to use au_cslack value which was nice and large and changed
>>>> it
>>>> to
>>>> au_rslack value which turns out to be too small.
>>>>=20
>>>> Since 5.1, v3 mount with sec=3Dkrb5p fails against an Ontap server
>>>> because client's receive buffer it too small.
>>>>=20
>>>> For gss krb5p, we need to account for the mic token in the
>>>> verifier,
>>>> and the wrap token in the wrap token.
>>>>=20
>>>> RFC 4121 defines:
>>>> mic token
>>>> Octet no   Name        Description
>>>>        ---------------------------------------------------------
>>>> -
>>>> ----
>>>>        0..1     TOK_ID     Identification field.  Tokens emitted
>>>> by
>>>>                            GSS_GetMIC() contain the hex value 04
>>>> 04
>>>>                            expressed in big-endian order in this
>>>>                            field.
>>>>        2        Flags      Attributes field, as described in
>>>> section
>>>>                            4.2.2.
>>>>        3..7     Filler     Contains five octets of hex value FF.
>>>>        8..15    SND_SEQ    Sequence number field in clear text,
>>>>                            expressed in big-endian order.
>>>>        16..last SGN_CKSUM  Checksum of the "to-be-signed" data
>>>> and
>>>>                            octet 0..15, as described in section
>>>> 4.2.4.
>>>>=20
>>>> that's 16bytes (GSS_KRB5_TOK_HDR_LEN) + chksum
>>>>=20
>>>> wrap token
>>>> Octet no   Name        Description
>>>>        ---------------------------------------------------------
>>>> -
>>>> ----
>>>>         0..1     TOK_ID    Identification field.  Tokens emitted
>>>> by
>>>>                            GSS_Wrap() contain the hex value 05
>>>> 04
>>>>                            expressed in big-endian order in this
>>>>                            field.
>>>>         2        Flags     Attributes field, as described in
>>>> section
>>>>                            4.2.2.
>>>>         3        Filler    Contains the hex value FF.
>>>>         4..5     EC        Contains the "extra count" field, in
>>>> big-
>>>>                            endian order as described in section
>>>> 4.2.3.
>>>>         6..7     RRC       Contains the "right rotation count"
>>>> in
>>>> big-
>>>>                            endian order, as described in section
>>>>                            4.2.5.
>>>>         8..15    SND_SEQ   Sequence number field in clear text,
>>>>                            expressed in big-endian order.
>>>>         16..last Data      Encrypted data for Wrap tokens with
>>>>                            confidentiality, or plaintext data
>>>> followed
>>>>                            by the checksum for Wrap tokens
>>>> without
>>>>                            confidentiality, as described in
>>>> section
>>>>                            4.2.4.
>>>>=20
>>>> Also 16bytes of header (GSS_KRB5_TOK_HDR_LEN), encrypted data,
>>>> and
>>>> cksum
>>>> (other things like padding)
>>>>=20
>>>> RFC 3961 defines known cksum sizes:
>>>> Checksum
>>>> type              sumtype        checksum         section or
>>>>                               value            size         refe
>>>> ren
>>>> ce
>>>>  -------------------------------------------------------------
>>>> ---
>>>> -----
>>>>=20
>>>> CRC32                            1               4           6.1.
>>>> 3
>>>>  rsa-
>>>> md4                          2              16           6.1.2
>>>>  rsa-md4-
>>>> des                      3              24           6.2.5
>>>>  des-
>>>> mac                          4              16           6.2.7
>>>>  des-mac-
>>>> k                        5               8           6.2.8
>>>>  rsa-md4-des-
>>>> k                    6              16           6.2.6
>>>>  rsa-
>>>> md5                          7              16           6.1.1
>>>>  rsa-md5-
>>>> des                      8              24           6.2.4
>>>>  rsa-md5-
>>>> des3                     9              24             ??
>>>>  sha1
>>>> (unkeyed)                  10              20             ??
>>>>  hmac-sha1-des3-
>>>> kd               12              20            6.3
>>>>  hmac-sha1-
>>>> des3                  13              20             ??
>>>>  sha1
>>>> (unkeyed)                  14              20             ??
>>>>  hmac-sha1-96-
>>>> aes128             15              20         [KRB5-
>>>> AES]
>>>>  hmac-sha1-96-
>>>> aes256             16              20         [KRB5-
>>>> AES]
>>>>=20
>>>> [reserved]                  0x8003               ?         [GSS-
>>>> KRB5]
>>>>=20
>>>> Linux kernel now mainly supports type 15,16 so max cksum size is
>>>> 20bytes.
>>>> (GSS_KRB5_MAX_CKSUM_LEN)
>>>>=20
>>>> Re-use already existing define of GSS_KRB5_MAX_SLACK_NEEDED
>>>> that's
>>>> used
>>>> for encoding the gss_wrap tokens (same tokens are used in reply).
>>>>=20
>>>> Fixes: 2c94b8eca1a2 ("SUNRPC: Use au_rslack when computing reply
>>>> buffer size")
>>>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
>>>> ---
>>>> net/sunrpc/auth_gss/auth_gss.c | 5 ++++-
>>>> 1 file changed, 4 insertions(+), 1 deletion(-)
>>>>=20
>>>> diff --git a/net/sunrpc/auth_gss/auth_gss.c
>>>> b/net/sunrpc/auth_gss/auth_gss.c
>>>> index 24ca861..5a733a6 100644
>>>> --- a/net/sunrpc/auth_gss/auth_gss.c
>>>> +++ b/net/sunrpc/auth_gss/auth_gss.c
>>>> @@ -20,6 +20,7 @@
>>>> #include <linux/sunrpc/clnt.h>
>>>> #include <linux/sunrpc/auth.h>
>>>> #include <linux/sunrpc/auth_gss.h>
>>>> +#include <linux/sunrpc/gss_krb5.h>
>>>> #include <linux/sunrpc/svcauth_gss.h>
>>>> #include <linux/sunrpc/gss_err.h>
>>>> #include <linux/workqueue.h>
>>>> @@ -51,6 +52,8 @@
>>>> /* length of a krb5 verifier (48), plus data added before
>>>> arguments
>>>> when
>>>> * using integrity (two 4-byte integers): */
>>>> #define GSS_VERF_SLACK		100
>>>> +/* covers lengths of gss_unwrap() extra kerberos mic and wrap
>>>> token
>>>> */
>>>> +#define GSS_RESP_SLACK		(GSS_KRB5_MAX_SLACK_NEEDED <<
>>>> 2)
>>>>=20
>>>> static DEFINE_HASHTABLE(gss_auth_hash_table, 4);
>>>> static DEFINE_SPINLOCK(gss_auth_hash_lock);
>>>> @@ -1050,7 +1053,7 @@ static void gss_pipe_free(struct gss_pipe
>>>> *p)
>>>> 		goto err_put_mech;
>>>> 	auth =3D &gss_auth->rpc_auth;
>>>> 	auth->au_cslack =3D GSS_CRED_SLACK >> 2;
>>>> -	auth->au_rslack =3D GSS_VERF_SLACK >> 2;
>>>> +	auth->au_rslack =3D GSS_RESP_SLACK >> 2;
>>>> 	auth->au_verfsize =3D GSS_VERF_SLACK >> 2;
>>>> 	auth->au_ralign =3D GSS_VERF_SLACK >> 2;
>>>> 	auth->au_flags =3D 0;
>>>=20
>>> Is this a sufficient fix, though? It looks to me as if the above is
>>> just an initial value that gets adjusted on the fly in
>>> gss_unwrap_resp_priv():
>>>=20
>>>       auth->au_rslack =3D auth->au_verfsize + 2 +
>>>                         XDR_QUADLEN(savedlen - rcv_buf->len);
>>>       auth->au_ralign =3D auth->au_verfsize + 2 +
>>>                         XDR_QUADLEN(savedlen - rcv_buf->len);
>>=20
>> That's correct. The GSS_*_SLACK value is a _sz value that is
>> the largest possible expected size of the extra GSS data.
>>=20
>>=20
>>> My questions would be
>>>=20
>>> - Are we sure that the above calculation (in
>>> gss_unwrap_resp_priv()) is
>>> correct?
>>=20
>> Yes, this is the correct computation.
>>=20
>> We know this because if the initial au_rslack value is large
>> enough, then subsequent Replies have the correct amount of buffer
>> space and always succeed.
>>=20
>>=20
>>> - Are we sure that the above calculation always gives the same
>>> answer
>>> over time? We probably should not store a value that keeps
>>> changing.
>>=20
>> It does not change after the first Reply. au_rslack is typically
>> adjusted downwards from the initial value based on the size of the
>> first received Reply.
>>=20
>> Not setting these variables after the first Reply has been received
>> would be a minor optimization that could be done after Olga's fix.
>>=20
>=20
> OK. So you're both saying that as long as the initial value is =
correct,
> we're good for the duration of the GSS session? Fair enough, I'll =
apply
> this patch for 5.7 then.

Thanks, please see my one-line correction. I think the definition of
GSS_RESP_SLACK should not include the "<< 2", I would like Olga to
confirm.


> Let's also fix up the above in a separate patch to not keep setting
> auth->au_rslack / auth->au_ralign if their values are not changing.
> That should prevent unnecessary cache line bouncing.

I volunteer, unless Olga wants to take it.


--
Chuck Lever



