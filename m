Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 081AA183A64
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2020 21:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgCLUKv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Mar 2020 16:10:51 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50896 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgCLUKv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Mar 2020 16:10:51 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CK9Ztf175621;
        Thu, 12 Mar 2020 20:10:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=z1VPTfUFLRYWU2bmOeD+4Z+7iI9wdcSfpNKQamXDT+I=;
 b=vE2H+breGMfxX0sKGPouTXlyDtWgGpcynnqSvXzsu1k7GgkC5Wy5NSDMl9LdZw5GqF4d
 UUBp91jQo819jbWyS9LzhgoNMVMlbS02Ip1OJUcHGPg1R+kVhYGrkp4YI210OGb2yESZ
 ehiyWxtMMVf1RtbSuGK6cqaNBcg89P5Ds+wYq5YkhZ2vjA6Htduasx+3IcL00J7T874t
 YfkL+QRtS2O4xM3zBBHiX2Eef3Zd7lQoOZLU4j2Y/OmW4GINTcsvvLD1idY+IIgnPRUw
 qSpKfvCNlqVxL52SxL1knyThRMW4XjqxuF5ojiFQO7FaDRc63imVKZp9b43BwTX/l+f3 2A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2yqtavggkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 20:10:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CK29Yw147627;
        Thu, 12 Mar 2020 20:10:44 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2yqtaayq92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 20:10:43 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02CKAeZH025605;
        Thu, 12 Mar 2020 20:10:40 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Mar 2020 13:10:40 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [RFC PATCH] fix krb5p mount not providing large enough buffer in
 rq_rcvsize
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN-5tyHjrNcSc+h62dBiYhNmLxWcR1Pj7fLJOnSfgR6JDZbEAA@mail.gmail.com>
Date:   Thu, 12 Mar 2020 16:10:39 -0400
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E8169251-A626-4FD6-9A62-42C218AB79DF@oracle.com>
References: <CAN-5tyHegg96s7mr1YeoPbVd0UA7_cd2GEPYNWx98uUcx-0ARw@mail.gmail.com>
 <FF0659E0-8F04-4005-96D0-5D513881EDFE@oracle.com>
 <CAN-5tyHQpS7AmPX1cDxKpD=5gyAM7+nmLX+iA29QV7sLwhoX9Q@mail.gmail.com>
 <EE167593-39A6-4E29-B690-31D1D985DCC0@oracle.com>
 <CAN-5tyHjrNcSc+h62dBiYhNmLxWcR1Pj7fLJOnSfgR6JDZbEAA@mail.gmail.com>
To:     Olga Kornievskaia <aglo@umich.edu>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003120099
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003120099
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 12, 2020, at 3:17 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
>=20
> On Tue, Mar 10, 2020 at 7:56 PM Chuck Lever <chuck.lever@oracle.com> =
wrote:
>>=20
>>=20
>>=20
>>> On Mar 10, 2020, at 5:07 PM, Olga Kornievskaia <aglo@umich.edu> =
wrote:
>>>=20
>>> Hi Chuck,
>>>=20
>>> On Tue, Mar 10, 2020 at 3:57 PM Chuck Lever <chuck.lever@oracle.com> =
wrote:
>>>>=20
>>>> Hi Olga-
>>>>=20
>>>>> On Mar 10, 2020, at 2:58 PM, Olga Kornievskaia <aglo@umich.edu> =
wrote:
>>>>>=20
>>>>> Ever since commit 2c94b8eca1a26 "SUNRPC: Use au_rslack when =
computing
>>>>> reply buffer size". It changed how "req->rq_rcvsize" is =
calculated. It
>>>>> used to use au_cslack value which was nice and large and changed =
it to
>>>>> au_rslack value which turns out to be too small.
>>>>>=20
>>>>> Since 5.1, v3 mount with sec=3Dkrb5p fails against an Ontap server
>>>>> because client's receive buffer it too small.
>>>>=20
>>>> Can you be more specific? For instance, why is 100 bytes adequate =
for
>>>> Linux servers, but not OnTAP?
>>>=20
>>> I don't know why Ontap sends more data than Linux server.
>>=20
>> Let's be sure we are fixing the right problem. Yes, au_rslack is
>> smaller in v5.1, and that results in a behavioral regression. But
>> exactly which part of the new calculation is incorrect is not yet
>> clear. Simply bumping GSS_VERF_SLACK could very well plaster over
>> the real problem.
>>=20
>>=20
>>> The opaque_len is just a lot larger. For the first message Linux
>>> opaque_len is 120bytes and Ontap it's 206. So it could be for =
instance
>>> for FSINFO that sends the file handle, for Netapp the file handle is
>>> 44bytes and for Linux it's only 28bytes.
>>=20
>> The maximum filehandle size should already be accounted for in the
>> maxsize macro for FSINFO.
>>=20
>> Is this problem evident only with NFSv3 plus krb5p?
>=20
> So far that seems to be the case. Every other version and security =
flavor works.
>=20
>>>> Is this explanation for the current value not correct?
>>>>=20
>>>> 51 /* length of a krb5 verifier (48), plus data added before =
arguments when
>>>> 52  * using integrity (two 4-byte integers): */
>>>=20
>>> I'm not sure what it is suppose to be. Isn't "data before arguments"
>>> can vary in length and thus explain why linux and onto sizes are
>>> different?
>>> Looking at the network trace the krb5 verifier I see is 36bytes.
>>=20
>> GSS_VERF_SLACK is only for the extra length added by GSS data. The
>> length of the RPC message itself is handled separately, see above.
>>=20
>> Can you post a Wireshark dissection of the problematic FSINFO reply?
>> (Having a working reply from Linux and a failing reply from OnTAP
>> would be even better).
>=20
> I'm attaching two files. I mount against linux and mount against =
ontap.
>=20
>=20
>=20
>=20
>>>>> For GSS, au_rslack is calculated from GSS_VERF_SLACK value which =
is
>>>>> currently 100. And it's not enough. Changing it to 104 works and =
then
>>>>> au_rslack is recalculated based on actual received mic.len and not
>>>>> just the default buffer size.
>>=20
>> What are the computed au_ralign and au_rslack values after the first
>> successful operation?
>=20
> With GSS_VERF_SLACK 100
> Linux run:
>=20
> Mar 12 13:14:29 localhost kernel: AGLO: gss_create_new setting for
> auth=3D00000000e14fdc39 cslack=3D200 and rslack=3D25
> Mar 12 13:14:29 localhost kernel: AGLO: gss_create_new setting for
> auth=3D00000000e14fdc39 ralign=3D25
> Mar 12 13:14:29 localhost kernel: NFS call  fsinfo
> ... <gssd upcall>
> Mar 12 13:14:29 localhost kernel: AGLO: call_allocate
> auth=3D00000000e14fdc39 au_cslack=3D200 au_rslack=3D25 rq_rcvsize=3D256
> p_replen=3D35
> Mar 12 13:14:29 localhost kernel: AGLO: gss_unwrap_resp_priv rcv_buf
> len=3D176 is ok offset=3D56 opaque=3D120
> Mar 12 13:14:29 localhost kernel: AGLO: gss_unwrap_resp_priv ****
> auth=3D00000000e14fdc39 resetting au_rslack=3D26
> Mar 12 13:14:29 localhost kernel: AGLO: gss_unwrap_resp_priv ****
> auth=3D00000000e14fdc39 resetting au_ralign=3D26
> Mar 12 13:14:29 localhost kernel: NFS reply fsinfo: 0
>=20
> Ontap run:
> Mar 12 13:16:46 localhost kernel: AGLO: gss_create_new setting for
> auth=3D00000000e02d9e6e cslack=3D200 and rslack=3D25
> Mar 12 13:16:46 localhost kernel: AGLO: gss_create_new setting for
> auth=3D00000000e02d9e6e ralign=3D25
> Mar 12 13:16:46 localhost kernel: NFS call  fsinfo
> ... <gssd upcall>
> Mar 12 13:16:46 localhost kernel: AGLO: call_allocate
> auth=3D00000000e02d9e6e au_cslack=3D200 au_rslack=3D25 rq_rcvsize=3D256
> p_replen=3D35
> Mar 12 13:16:46 localhost kernel: AGLO: gss_unwrap_resp_priv rcv_buf
> len=3D256 too small offset=3D56 opaque=3D204
> Mar 12 13:16:46 localhost kernel: NFS reply fsinfo: -5
>=20
> With GSS_VERF_SLACK 104
> Mar 12 13:33:23 localhost kernel: AGLO: gss_create_new setting for
> auth=3D000000004a545ea2 cslack=3D200 and rslack=3D26
> Mar 12 13:33:23 localhost kernel: AGLO: gss_create_new setting for
> auth=3D000000004a545ea2 ralign=3D26
> Mar 12 13:33:23 localhost kernel: NFS call  fsinfo
> ... <gssd upcall>
> Mar 12 13:33:23 localhost kernel: AGLO: call_allocate
> auth=3D000000004a545ea2 au_cslack=3D200 au_rslack=3D26 rq_rcvsize=3D260
> p_replen=3D35
> Mar 12 13:33:23 localhost kernel: AGLO: gss_unwrap_resp_priv rcv_buf
> len=3D260 is ok offset=3D56 opaque=3D204
> Mar 12 13:33:23 localhost kernel: AGLO: gss_unwrap_resp_priv ****
> auth=3D000000004a545ea2 resetting au_rslack=3D26
> Mar 12 13:33:23 localhost kernel: AGLO: gss_unwrap_resp_priv ****
> auth=3D000000004a545ea2 resetting au_ralign=3D26
> Mar 12 13:33:23 localhost kernel: NFS reply fsinfo: 0
>=20
> difference in actual packets in fsinfo is that ontap sends postattrs
> so that's 84bytes.
>=20
>        req->rq_rcvsize =3D RPC_REPHDRSIZE + auth->au_rslack + \
>                        max_t(size_t, proc->p_replen, 2);
>=20
> RPC_REPHDRSIZE is defined to be 4 (*4)  (it says it doesn't include
> the verifier ???)

> rslack needs to cover kerberos blob 25 (*4)  (but that's the kerberos
> part a part of the wrap and not the verifier)
> p_replen to cover fs_info args 35 (*4) (seems like the right number)
>=20
> So we are missing the GSS to include the verifier and the kerberos
> blob of the wrapper (and lengths!!). Basically we need GSS_VERF_SLACK
> to cover 2 kerberos blobs (or more specifically KRB_TOKEN_CFX_GetMic
> 9*4 and KRB_TOKEN_CFS_WRAP 15*4 + 2 lengths before the kerberos blobs
> =3D 104 and we are only giving 100).

GSS_VERF_SLACK is also used for setting au_verfsize, so please don't
change its value. Define a new constant for initializing au_rslack.

Let's construct that constant using the KRB5_TOKEN constants you mention
here... include/linux/sunrpc/gss_krb5.h has

221 /*
222  * This compile-time check verifies that we will not exceed the
223  * slack space allotted by the client and server auth_gss code
224  * before they call gss_wrap().
225  */
226 #define GSS_KRB5_MAX_SLACK_NEEDED \
227         (GSS_KRB5_TOK_HDR_LEN     /* gss token header */         \
228         + GSS_KRB5_MAX_CKSUM_LEN  /* gss token checksum */       \
229         + GSS_KRB5_MAX_BLOCKSIZE  /* confounder */               \
230         + GSS_KRB5_MAX_BLOCKSIZE  /* possible padding */         \
231         + GSS_KRB5_TOK_HDR_LEN    /* encrypted hdr in v2 token */\
232         + GSS_KRB5_MAX_CKSUM_LEN  /* encryption hmac */          \
233         + 4 + 4                   /* RPC verifier */             \
234         + GSS_KRB5_TOK_HDR_LEN                                   \
235         + GSS_KRB5_MAX_CKSUM_LEN)

So this, or something like this, plus the comment below.


> The reason things work against linux is because it has a nice buffer
> of 84bytes of post attributes that it doesn't send.

Missing post-attributes makes sense. Thank you for the analysis.


> To address your later point that kerberos blob is encryption type
> depended and that once some other encryption is added to gss-kerberos
> that's larger than existing checksum then this value would need to be
> adjusted again.

> If you agree with my reasoning for the number then I'd like to send
> out a patch now.

The current numbers are based on the kernel GSS implementation =
supporting
only Kerberos with a narrow set of enctypes. That needs to be made clear
in a documenting comment.

The reason this has been bothersome is because the existing setting is
a magic number (100), and its documenting comment has been stale since
2006. Any proposed fix has to address the missing documentation.


>>>>> I would like to propose to change it to something a little larger =
than
>>>>> 104, like 120 to give room if some other server might reply with
>>>>> something even larger.
>>>>=20
>>>> Why does it need to be larger than 104?
>>>=20
>>> I don't know why 100 was chosen and given that I think arguments are
>>> taken into the account and arguments can change. I think NetApp has
>>> changed their file handle sizes (at some point, not in the near past
>>> but i think so?). Perhaps they might want to do that again so the =
size
>>> will change again.
>>>=20
>>> Honestly, I would have like for 100 to be 200 to be safe.
>>=20
>> To be safe, I would like to have a good understanding of the details,
>> rather than guessing at an arbitrary maximum value. Let's choose a
>> rational maximum and include a descriptive comment about why that =
value
>> is the best choice.
>>=20
>>=20
>>>>> Thoughts? Will send an actual patch if no objections to this one.
>>>>>=20
>>>>> diff --git a/net/sunrpc/auth_gss/auth_gss.c =
b/net/sunrpc/auth_gss/auth_gss.c
>>>>> index 24ca861..44ae6bc 100644
>>>>> --- a/net/sunrpc/auth_gss/auth_gss.c
>>>>> +++ b/net/sunrpc/auth_gss/auth_gss.c
>>>>> @@ -50,7 +50,7 @@
>>>>> #define GSS_CRED_SLACK         (RPC_MAX_AUTH_SIZE * 2)
>>>>> /* length of a krb5 verifier (48), plus data added before =
arguments when
>>>>> * using integrity (two 4-byte integers): */
>>>>> -#define GSS_VERF_SLACK         100
>>>>> +#define GSS_VERF_SLACK         120
>>>>>=20
>>>>> static DEFINE_HASHTABLE(gss_auth_hash_table, 4);
>>>>> static DEFINE_SPINLOCK(gss_auth_hash_lock);
>>>>=20
>>>> --
>>>> Chuck Lever
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>>=20
> <linux-v3-krb5p-mount.pcap.gz><ontap-v3-krb5-mount.pcap.gz>

--
Chuck Lever



