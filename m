Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0B8318D8E8
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Mar 2020 21:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgCTUSZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Mar 2020 16:18:25 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37654 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgCTUSZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Mar 2020 16:18:25 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02KK982F175796;
        Fri, 20 Mar 2020 20:18:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=VlGpEjdhoMfERf4UiOlGuDn9vMdSi2dnZIno0OS2yoo=;
 b=DfJmtugaVshZTjMqGfDeMw7k+8cEuKdFOsWL2pYILXV153Wh+BiIzIQVGxRFnF7RU9Fv
 GTPGMVdlmkKJac4bRUzw5zh6Y71v1CaTvnAg7LIMJUZTw2u+CcBTr4oLRaBFBFD+KScZ
 iloBHn7RhvfmvdPEmL5kxoTvFdW0QmtBAYiEV72ZbfhtI1+VNmVrLt7WBNUQGBOFr3QK
 HndckrNRd5poFpkUHUMZb/lrMlKTbukruYfVDaUs8KkXCmNprCg1zzhPCYEoCIru+QOD
 lD9BI6D8BoMQceyraKFOd4JMNHSOKsxgzYIfoftTDlE6lLPs5bvBhHtCLrup1DaWw9eM 0g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2yrpprqpkc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Mar 2020 20:18:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02KKGp85162241;
        Fri, 20 Mar 2020 20:18:16 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2ys8rqrw29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Mar 2020 20:18:16 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02KKIATg018707;
        Fri, 20 Mar 2020 20:18:10 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 20 Mar 2020 13:18:10 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [RFC PATCH] fix krb5p mount not providing large enough buffer in
 rq_rcvsize
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN-5tyGvi_KBZHr0YKqhtyB5CNAtKk77+c0dkmb=u=4FCD7daw@mail.gmail.com>
Date:   Fri, 20 Mar 2020 16:18:07 -0400
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <98545F5F-D2DC-40A1-ACC7-10BAFA17343A@oracle.com>
References: <CAN-5tyHegg96s7mr1YeoPbVd0UA7_cd2GEPYNWx98uUcx-0ARw@mail.gmail.com>
 <FF0659E0-8F04-4005-96D0-5D513881EDFE@oracle.com>
 <CAN-5tyHQpS7AmPX1cDxKpD=5gyAM7+nmLX+iA29QV7sLwhoX9Q@mail.gmail.com>
 <EE167593-39A6-4E29-B690-31D1D985DCC0@oracle.com>
 <CAN-5tyHjrNcSc+h62dBiYhNmLxWcR1Pj7fLJOnSfgR6JDZbEAA@mail.gmail.com>
 <E8169251-A626-4FD6-9A62-42C218AB79DF@oracle.com>
 <CAN-5tyGvi_KBZHr0YKqhtyB5CNAtKk77+c0dkmb=u=4FCD7daw@mail.gmail.com>
To:     Olga Kornievskaia <aglo@umich.edu>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9566 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003200080
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9566 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=2 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003200079
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 20, 2020, at 3:28 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
>=20
> On Thu, Mar 12, 2020 at 4:10 PM Chuck Lever <chuck.lever@oracle.com> =
wrote:
>>=20
>>=20
>>=20
>>> On Mar 12, 2020, at 3:17 PM, Olga Kornievskaia <aglo@umich.edu> =
wrote:
>>>=20
>>> On Tue, Mar 10, 2020 at 7:56 PM Chuck Lever <chuck.lever@oracle.com> =
wrote:
>>>>=20
>>>>=20
>>>>=20
>>>>> On Mar 10, 2020, at 5:07 PM, Olga Kornievskaia <aglo@umich.edu> =
wrote:
>>>>>=20
>>>>> Hi Chuck,
>>>>>=20
>>>>> On Tue, Mar 10, 2020 at 3:57 PM Chuck Lever =
<chuck.lever@oracle.com> wrote:
>>>>>>=20
>>>>>> Hi Olga-
>>>>>>=20
>>>>>>> On Mar 10, 2020, at 2:58 PM, Olga Kornievskaia <aglo@umich.edu> =
wrote:
>>>>>>>=20
>>>>>>> Ever since commit 2c94b8eca1a26 "SUNRPC: Use au_rslack when =
computing
>>>>>>> reply buffer size". It changed how "req->rq_rcvsize" is =
calculated. It
>>>>>>> used to use au_cslack value which was nice and large and changed =
it to
>>>>>>> au_rslack value which turns out to be too small.
>>>>>>>=20
>>>>>>> Since 5.1, v3 mount with sec=3Dkrb5p fails against an Ontap =
server
>>>>>>> because client's receive buffer it too small.
>>>>>>=20
>>>>>> Can you be more specific? For instance, why is 100 bytes adequate =
for
>>>>>> Linux servers, but not OnTAP?
>>>>>=20
>>>>> I don't know why Ontap sends more data than Linux server.
>>>>=20
>>>> Let's be sure we are fixing the right problem. Yes, au_rslack is
>>>> smaller in v5.1, and that results in a behavioral regression. But
>>>> exactly which part of the new calculation is incorrect is not yet
>>>> clear. Simply bumping GSS_VERF_SLACK could very well plaster over
>>>> the real problem.
>>>>=20
>>>>=20
>>>>> The opaque_len is just a lot larger. For the first message Linux
>>>>> opaque_len is 120bytes and Ontap it's 206. So it could be for =
instance
>>>>> for FSINFO that sends the file handle, for Netapp the file handle =
is
>>>>> 44bytes and for Linux it's only 28bytes.
>>>>=20
>>>> The maximum filehandle size should already be accounted for in the
>>>> maxsize macro for FSINFO.
>>>>=20
>>>> Is this problem evident only with NFSv3 plus krb5p?
>>>=20
>>> So far that seems to be the case. Every other version and security =
flavor works.
>>>=20
>>>>>> Is this explanation for the current value not correct?
>>>>>>=20
>>>>>> 51 /* length of a krb5 verifier (48), plus data added before =
arguments when
>>>>>> 52  * using integrity (two 4-byte integers): */
>>>>>=20
>>>>> I'm not sure what it is suppose to be. Isn't "data before =
arguments"
>>>>> can vary in length and thus explain why linux and onto sizes are
>>>>> different?
>>>>> Looking at the network trace the krb5 verifier I see is 36bytes.
>>>>=20
>>>> GSS_VERF_SLACK is only for the extra length added by GSS data. The
>>>> length of the RPC message itself is handled separately, see above.
>>>>=20
>>>> Can you post a Wireshark dissection of the problematic FSINFO =
reply?
>>>> (Having a working reply from Linux and a failing reply from OnTAP
>>>> would be even better).
>>>=20
>>> I'm attaching two files. I mount against linux and mount against =
ontap.
>>>=20
>>>=20
>>>=20
>>>=20
>>>>>>> For GSS, au_rslack is calculated from GSS_VERF_SLACK value which =
is
>>>>>>> currently 100. And it's not enough. Changing it to 104 works and =
then
>>>>>>> au_rslack is recalculated based on actual received mic.len and =
not
>>>>>>> just the default buffer size.
>>>>=20
>>>> What are the computed au_ralign and au_rslack values after the =
first
>>>> successful operation?
>>>=20
>>> With GSS_VERF_SLACK 100
>>> Linux run:
>>>=20
>>> Mar 12 13:14:29 localhost kernel: AGLO: gss_create_new setting for
>>> auth=3D00000000e14fdc39 cslack=3D200 and rslack=3D25
>>> Mar 12 13:14:29 localhost kernel: AGLO: gss_create_new setting for
>>> auth=3D00000000e14fdc39 ralign=3D25
>>> Mar 12 13:14:29 localhost kernel: NFS call  fsinfo
>>> ... <gssd upcall>
>>> Mar 12 13:14:29 localhost kernel: AGLO: call_allocate
>>> auth=3D00000000e14fdc39 au_cslack=3D200 au_rslack=3D25 =
rq_rcvsize=3D256
>>> p_replen=3D35
>>> Mar 12 13:14:29 localhost kernel: AGLO: gss_unwrap_resp_priv rcv_buf
>>> len=3D176 is ok offset=3D56 opaque=3D120
>>> Mar 12 13:14:29 localhost kernel: AGLO: gss_unwrap_resp_priv ****
>>> auth=3D00000000e14fdc39 resetting au_rslack=3D26
>>> Mar 12 13:14:29 localhost kernel: AGLO: gss_unwrap_resp_priv ****
>>> auth=3D00000000e14fdc39 resetting au_ralign=3D26
>>> Mar 12 13:14:29 localhost kernel: NFS reply fsinfo: 0
>>>=20
>>> Ontap run:
>>> Mar 12 13:16:46 localhost kernel: AGLO: gss_create_new setting for
>>> auth=3D00000000e02d9e6e cslack=3D200 and rslack=3D25
>>> Mar 12 13:16:46 localhost kernel: AGLO: gss_create_new setting for
>>> auth=3D00000000e02d9e6e ralign=3D25
>>> Mar 12 13:16:46 localhost kernel: NFS call  fsinfo
>>> ... <gssd upcall>
>>> Mar 12 13:16:46 localhost kernel: AGLO: call_allocate
>>> auth=3D00000000e02d9e6e au_cslack=3D200 au_rslack=3D25 =
rq_rcvsize=3D256
>>> p_replen=3D35
>>> Mar 12 13:16:46 localhost kernel: AGLO: gss_unwrap_resp_priv rcv_buf
>>> len=3D256 too small offset=3D56 opaque=3D204
>>> Mar 12 13:16:46 localhost kernel: NFS reply fsinfo: -5
>>>=20
>>> With GSS_VERF_SLACK 104
>>> Mar 12 13:33:23 localhost kernel: AGLO: gss_create_new setting for
>>> auth=3D000000004a545ea2 cslack=3D200 and rslack=3D26
>>> Mar 12 13:33:23 localhost kernel: AGLO: gss_create_new setting for
>>> auth=3D000000004a545ea2 ralign=3D26
>>> Mar 12 13:33:23 localhost kernel: NFS call  fsinfo
>>> ... <gssd upcall>
>>> Mar 12 13:33:23 localhost kernel: AGLO: call_allocate
>>> auth=3D000000004a545ea2 au_cslack=3D200 au_rslack=3D26 =
rq_rcvsize=3D260
>>> p_replen=3D35
>>> Mar 12 13:33:23 localhost kernel: AGLO: gss_unwrap_resp_priv rcv_buf
>>> len=3D260 is ok offset=3D56 opaque=3D204
>>> Mar 12 13:33:23 localhost kernel: AGLO: gss_unwrap_resp_priv ****
>>> auth=3D000000004a545ea2 resetting au_rslack=3D26
>>> Mar 12 13:33:23 localhost kernel: AGLO: gss_unwrap_resp_priv ****
>>> auth=3D000000004a545ea2 resetting au_ralign=3D26
>>> Mar 12 13:33:23 localhost kernel: NFS reply fsinfo: 0
>>>=20
>>> difference in actual packets in fsinfo is that ontap sends postattrs
>>> so that's 84bytes.
>>>=20
>>>       req->rq_rcvsize =3D RPC_REPHDRSIZE + auth->au_rslack + \
>>>                       max_t(size_t, proc->p_replen, 2);
>>>=20
>>> RPC_REPHDRSIZE is defined to be 4 (*4)  (it says it doesn't include
>>> the verifier ???)
>>=20
>>> rslack needs to cover kerberos blob 25 (*4)  (but that's the =
kerberos
>>> part a part of the wrap and not the verifier)
>>> p_replen to cover fs_info args 35 (*4) (seems like the right number)
>>>=20
>>> So we are missing the GSS to include the verifier and the kerberos
>>> blob of the wrapper (and lengths!!). Basically we need =
GSS_VERF_SLACK
>>> to cover 2 kerberos blobs (or more specifically KRB_TOKEN_CFX_GetMic
>>> 9*4 and KRB_TOKEN_CFS_WRAP 15*4 + 2 lengths before the kerberos =
blobs
>>> =3D 104 and we are only giving 100).
>>=20
>> GSS_VERF_SLACK is also used for setting au_verfsize, so please don't
>> change its value. Define a new constant for initializing au_rslack.
>>=20
>> Let's construct that constant using the KRB5_TOKEN constants you =
mention
>> here... include/linux/sunrpc/gss_krb5.h has
>>=20
>> 221 /*
>> 222  * This compile-time check verifies that we will not exceed the
>> 223  * slack space allotted by the client and server auth_gss code
>> 224  * before they call gss_wrap().
>> 225  */
>> 226 #define GSS_KRB5_MAX_SLACK_NEEDED \
>> 227         (GSS_KRB5_TOK_HDR_LEN     /* gss token header */         =
\
>> 228         + GSS_KRB5_MAX_CKSUM_LEN  /* gss token checksum */       =
\
>> 229         + GSS_KRB5_MAX_BLOCKSIZE  /* confounder */               =
\
>> 230         + GSS_KRB5_MAX_BLOCKSIZE  /* possible padding */         =
\
>> 231         + GSS_KRB5_TOK_HDR_LEN    /* encrypted hdr in v2 token =
*/\
>> 232         + GSS_KRB5_MAX_CKSUM_LEN  /* encryption hmac */          =
\
>> 233         + 4 + 4                   /* RPC verifier */             =
\
>> 234         + GSS_KRB5_TOK_HDR_LEN                                   =
\
>> 235         + GSS_KRB5_MAX_CKSUM_LEN)
>>=20
>> So this, or something like this, plus the comment below.
>>=20
>=20
> I'm not sure this particular structure can we re-used as it computes
> something different (as it can be seen below what RFC structures are
> for mic and wrap cksums).
>=20
> I have 2 ways this can be solved. A simple patch that eliminates
> quartering the rslack of the GSS_VERF_SLACK that produces too small of
> a buffer. GSS_VERF_SLACK value in itself is a good approximation of
> what Kerberos needs.
>=20
> diff --git a/net/sunrpc/auth_gss/auth_gss.c =
b/net/sunrpc/auth_gss/auth_gss.c
> index 24ca861..e3b6ea2 100644
> --- a/net/sunrpc/auth_gss/auth_gss.c
> +++ b/net/sunrpc/auth_gss/auth_gss.c
> @@ -1050,7 +1050,7 @@ static void gss_pipe_free(struct gss_pipe *p)
>                goto err_put_mech;
>        auth =3D &gss_auth->rpc_auth;
>        auth->au_cslack =3D GSS_CRED_SLACK >> 2;
> -       auth->au_rslack =3D GSS_VERF_SLACK >> 2;
> +       auth->au_rslack =3D GSS_VERF_SLACK;
>        auth->au_verfsize =3D GSS_VERF_SLACK >> 2;
>        auth->au_ralign =3D GSS_VERF_SLACK >> 2;
>        auth->au_flags =3D 0;

The GSS_YADA_SLACK numbers are in bytes, these variables
are in XDR words. So ">> 2" is always the right thing to
do here. Not doing it for rslack would be confusing and
arbitrary.

(It really should be XDR_QUADLEN here, not a raw ">> 2").

It's simply happenstance that you get a value close to
what is needed when you take off the divide-by-four.

So this approach looks pretty hacky to me: it will confuse
anyone who looks at this code in the future. I don't feel
good about trading one magic number for another.


> Or I can introduce a new variable but I'm having a hard time figuring
> out what are the appropriate values for the checksums

IMO this is the correct approach, and one that mirrors the
approach taken with the _sz macros in nfs?xdr.c, (that is,
everywhere else where there is a requirement to estimate
the maximum size of an XDR data item).


> (I've added what
> I'm getting on the wire):
> diff --git a/include/linux/sunrpc/gss_krb5.h =
b/include/linux/sunrpc/gss_krb5.h
> index c1d77dd..9ef77eb 100644
> --- a/include/linux/sunrpc/gss_krb5.h
> +++ b/include/linux/sunrpc/gss_krb5.h
> @@ -234,6 +234,26 @@ enum seal_alg {
>        + GSS_KRB5_TOK_HDR_LEN                                   \
>        + GSS_KRB5_MAX_CKSUM_LEN)
>=20
> +/* to decode a GSS wrap reply the RPC code allocates buffer size =
based
> + * on GSS_KRB5 tokens (mic, wrap) and the max operation reply size
> + * provide MIC and WRAP token sizes in bytes
> + */
> +#define GSS_KRB5_TOKEN_GETMIC \
> +       (2 /*KRB5_TOKEN_ID*/ \
> +       + 1 /*KRB5_CTX_FLAGS*/ \
> +       + 5 /*KRB5_MIC_FILLER*/ \
> +       + 8 /*KRB5_CTX_SEQ*/ \
> +       + 12 /*KRB5_MIC_CKSUM_LEN*/)
> +
> +#define GSS_KRB5_TOKEN_WRAP \
> +       (2 /*KRB5_TOKEN_ID*/ \
> +       + 1 /*KRB5_CTX_FLAGS*/ \
> +       + 1 /*KRB5_WRAP_FILLER*/ \
> +       + 2 /*KRB5_CTX_EC*/ \
> +       + 2 /*KRB5_CTX_RRC*/ \
> +       + 8 /*KRB5_CTX_SEQ*/ \
> +       + 44 /*KRB5_WRAP_CKSUM_LEN */)

These appear to be in bytes? The documenting comment looks
unfinished. But, I'm with you so far.


> +
> u32
> make_checksum(struct krb5_ctx *kctx, char *header, int hdrlen,
>                struct xdr_buf *body, int body_offset, u8 *cksumkey,
> diff --git a/net/sunrpc/auth_gss/auth_gss.c =
b/net/sunrpc/auth_gss/auth_gss.c
> index 24ca861..d6a52dc 100644
> --- a/net/sunrpc/auth_gss/auth_gss.c
> +++ b/net/sunrpc/auth_gss/auth_gss.c
> @@ -25,6 +25,7 @@
> #include <linux/workqueue.h>
> #include <linux/sunrpc/rpc_pipe_fs.h>
> #include <linux/sunrpc/gss_api.h>
> +#include <linux/sunrpc/gss_krb5.h>
> #include <linux/uaccess.h>
> #include <linux/hashtable.h>
>=20
> @@ -52,6 +53,12 @@
>  * using integrity (two 4-byte integers): */
> #define GSS_VERF_SLACK         100
>=20
> +#define GSS_RAU_SLACK \
> +(4 /* GSS verf token length */ \
> ++ GSS_KRB5_TOKEN_GETMIC /* verifier's getmic */ \
> ++ 4 /* GSS warp token length */ \

"wrap" not "warp" ...?

> ++ GSS_KRB5_TOKEN_WRAP) /* wrap verifier */ \
> +
> static DEFINE_HASHTABLE(gss_auth_hash_table, 4);
> static DEFINE_SPINLOCK(gss_auth_hash_lock);
>=20
> @@ -1050,7 +1057,7 @@ static void gss_pipe_free(struct gss_pipe *p)
>                goto err_put_mech;
>        auth =3D &gss_auth->rpc_auth;
>        auth->au_cslack =3D GSS_CRED_SLACK >> 2;
> -       auth->au_rslack =3D GSS_VERF_SLACK >> 2;
> +       auth->au_rslack =3D GSS_RAU_SLACK;

I like the outlines of this approach. What's "RAU" ?
Maybe GSS_RESP_SLACK or GSS_REPL_SLACK might be clearer?

The slack variables are in XDR words. Should you have a
">> 2" or XDR_QUADLEN() here?


>        auth->au_verfsize =3D GSS_VERF_SLACK >> 2;
>        auth->au_ralign =3D GSS_VERF_SLACK >> 2;
>        auth->au_flags =3D 0;
>=20
>=20
> Here's the KRB5 RFC structure for MIC:

Is this RFC 4121? Just so we're on the same page.


> Octet no   Name        Description
>         --------------------------------------------------------------
>         0..1     TOK_ID     Identification field.  Tokens emitted by
>                             GSS_GetMIC() contain the hex value 04 04
>                             expressed in big-endian order in this
>                             field.
>         2        Flags      Attributes field, as described in section
>                             4.2.2.
>         3..7     Filler     Contains five octets of hex value FF.
>         8..15    SND_SEQ    Sequence number field in clear text,
>                             expressed in big-endian order.
>         16..last SGN_CKSUM  Checksum of the "to-be-signed" data and
>                             octet 0..15, as described in section =
4.2.4.
>=20
> for wrap:
>=20
> Octet no   Name        Description
>         --------------------------------------------------------------
>          0..1     TOK_ID    Identification field.  Tokens emitted by
>                             GSS_Wrap() contain the hex value 05 04
>                             expressed in big-endian order in this
>                             field.
>          2        Flags     Attributes field, as described in section
>                             4.2.2.
>          3        Filler    Contains the hex value FF.
>          4..5     EC        Contains the "extra count" field, in big-
>                             endian order as described in section =
4.2.3.
>          6..7     RRC       Contains the "right rotation count" in =
big-
>                             endian order, as described in section
>                             4.2.5.
>          8..15    SND_SEQ   Sequence number field in clear text,
>                             expressed in big-endian order.
>          16..last Data      Encrypted data for Wrap tokens with
>                             confidentiality, or plaintext data =
followed
>                             by the checksum for Wrap tokens without
>                             confidentiality, as described in section
>                             4.2.4.
>=20
> Variable parts are cksum lengths based on the encryption used.

Exactly, so we want to know the largest possible checksum size
that will be needed, based on the set of supported KRB5 enctypes
the kernel can use. As far as I know, the encryption algorithms
do not alter the cleartext message size.

For now, just pick the biggest such number and make that a C
macro with a nice comment. We can embellish this with an
indirection later.


> Current code has GSS_KRB5_MAX_CKSUM_LEN to be 20 (bytes?. Is that for
> hmac signature) in WRAP cksum sent is 44bytes.
>=20
> Looking for guidance here.

I'm not quite sure where to find a mapping of enctype to maximum
checksum size. Probably some code auditing needed, or maybe there
is an RFC for each enctype that can impart that size information.


> Thank you.
>=20
>>> The reason things work against linux is because it has a nice buffer
>>> of 84bytes of post attributes that it doesn't send.
>>=20
>> Missing post-attributes makes sense. Thank you for the analysis.
>>=20
>>=20
>>> To address your later point that kerberos blob is encryption type
>>> depended and that once some other encryption is added to =
gss-kerberos
>>> that's larger than existing checksum then this value would need to =
be
>>> adjusted again.
>>=20
>>> If you agree with my reasoning for the number then I'd like to send
>>> out a patch now.
>>=20
>> The current numbers are based on the kernel GSS implementation =
supporting
>> only Kerberos with a narrow set of enctypes. That needs to be made =
clear
>> in a documenting comment.
>>=20
>> The reason this has been bothersome is because the existing setting =
is
>> a magic number (100), and its documenting comment has been stale =
since
>> 2006. Any proposed fix has to address the missing documentation.
>>=20
>>=20
>>>>>>> I would like to propose to change it to something a little =
larger than
>>>>>>> 104, like 120 to give room if some other server might reply with
>>>>>>> something even larger.
>>>>>>=20
>>>>>> Why does it need to be larger than 104?
>>>>>=20
>>>>> I don't know why 100 was chosen and given that I think arguments =
are
>>>>> taken into the account and arguments can change. I think NetApp =
has
>>>>> changed their file handle sizes (at some point, not in the near =
past
>>>>> but i think so?). Perhaps they might want to do that again so the =
size
>>>>> will change again.
>>>>>=20
>>>>> Honestly, I would have like for 100 to be 200 to be safe.
>>>>=20
>>>> To be safe, I would like to have a good understanding of the =
details,
>>>> rather than guessing at an arbitrary maximum value. Let's choose a
>>>> rational maximum and include a descriptive comment about why that =
value
>>>> is the best choice.
>>>>=20
>>>>=20
>>>>>>> Thoughts? Will send an actual patch if no objections to this =
one.
>>>>>>>=20
>>>>>>> diff --git a/net/sunrpc/auth_gss/auth_gss.c =
b/net/sunrpc/auth_gss/auth_gss.c
>>>>>>> index 24ca861..44ae6bc 100644
>>>>>>> --- a/net/sunrpc/auth_gss/auth_gss.c
>>>>>>> +++ b/net/sunrpc/auth_gss/auth_gss.c
>>>>>>> @@ -50,7 +50,7 @@
>>>>>>> #define GSS_CRED_SLACK         (RPC_MAX_AUTH_SIZE * 2)
>>>>>>> /* length of a krb5 verifier (48), plus data added before =
arguments when
>>>>>>> * using integrity (two 4-byte integers): */
>>>>>>> -#define GSS_VERF_SLACK         100
>>>>>>> +#define GSS_VERF_SLACK         120
>>>>>>>=20
>>>>>>> static DEFINE_HASHTABLE(gss_auth_hash_table, 4);
>>>>>>> static DEFINE_SPINLOCK(gss_auth_hash_lock);
>>>>>>=20
>>>>>> --
>>>>>> Chuck Lever
>>>>=20
>>>> --
>>>> Chuck Lever
>>>>=20
>>>>=20
>>>>=20
>>> <linux-v3-krb5p-mount.pcap.gz><ontap-v3-krb5-mount.pcap.gz>
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



