Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 626CC180CA7
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2020 00:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgCJX4n (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Mar 2020 19:56:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38644 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgCJX4n (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Mar 2020 19:56:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02ANrQiB180107;
        Tue, 10 Mar 2020 23:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=21SvJWEk2E+Aqm68uaD3CEp+jglEOIKbCoojg5zGiCA=;
 b=UqESqA+0eaAq7jAnR/jo5gpUx5eCn7Mzdexy40CCxniFS9vgy9qlQUhmORQXfieWiZOI
 /o+HzKCg0+UjkPxs+fFTOqdw53JIPXoUra7b8kLNlVyjW09JoOIK5OtwPtnwn8mcK/bT
 lz8PbneY758QX7HqUoBXUx4w0p/FpSmbvw5BjeGohBFboOwl2unnZhkWQ1I+yHAYOAVU
 udzuy1JxY9ePOrNYp9cUr+R2MTittY6n0i06xWQKtD3zdxZU0iFHzvJdOo1C1OTjRJjY
 EpTdTbdMjcDZGUx43OZ/8TOZ5fv0T4dQT67F3j0bzrK2p7BapY9gGnIbRDCwDKJTmtNw Vg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2yp7hm4xtp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 23:56:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02ANqOEt089006;
        Tue, 10 Mar 2020 23:56:35 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2yp8nwqt73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 23:56:34 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02ANuVw1018460;
        Tue, 10 Mar 2020 23:56:31 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Mar 2020 16:56:31 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [RFC PATCH] fix krb5p mount not providing large enough buffer in
 rq_rcvsize
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN-5tyHQpS7AmPX1cDxKpD=5gyAM7+nmLX+iA29QV7sLwhoX9Q@mail.gmail.com>
Date:   Tue, 10 Mar 2020 19:56:30 -0400
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EE167593-39A6-4E29-B690-31D1D985DCC0@oracle.com>
References: <CAN-5tyHegg96s7mr1YeoPbVd0UA7_cd2GEPYNWx98uUcx-0ARw@mail.gmail.com>
 <FF0659E0-8F04-4005-96D0-5D513881EDFE@oracle.com>
 <CAN-5tyHQpS7AmPX1cDxKpD=5gyAM7+nmLX+iA29QV7sLwhoX9Q@mail.gmail.com>
To:     Olga Kornievskaia <aglo@umich.edu>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100143
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 10, 2020, at 5:07 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
>=20
> Hi Chuck,
>=20
> On Tue, Mar 10, 2020 at 3:57 PM Chuck Lever <chuck.lever@oracle.com> =
wrote:
>>=20
>> Hi Olga-
>>=20
>>> On Mar 10, 2020, at 2:58 PM, Olga Kornievskaia <aglo@umich.edu> =
wrote:
>>>=20
>>> Ever since commit 2c94b8eca1a26 "SUNRPC: Use au_rslack when =
computing
>>> reply buffer size". It changed how "req->rq_rcvsize" is calculated. =
It
>>> used to use au_cslack value which was nice and large and changed it =
to
>>> au_rslack value which turns out to be too small.
>>>=20
>>> Since 5.1, v3 mount with sec=3Dkrb5p fails against an Ontap server
>>> because client's receive buffer it too small.
>>=20
>> Can you be more specific? For instance, why is 100 bytes adequate for
>> Linux servers, but not OnTAP?
>=20
> I don't know why Ontap sends more data than Linux server.

Let's be sure we are fixing the right problem. Yes, au_rslack is
smaller in v5.1, and that results in a behavioral regression. But
exactly which part of the new calculation is incorrect is not yet
clear. Simply bumping GSS_VERF_SLACK could very well plaster over
the real problem.


> The opaque_len is just a lot larger. For the first message Linux
> opaque_len is 120bytes and Ontap it's 206. So it could be for instance
> for FSINFO that sends the file handle, for Netapp the file handle is
> 44bytes and for Linux it's only 28bytes.

The maximum filehandle size should already be accounted for in the
maxsize macro for FSINFO.

Is this problem evident only with NFSv3 plus krb5p?


>> Is this explanation for the current value not correct?
>>=20
>>  51 /* length of a krb5 verifier (48), plus data added before =
arguments when
>>  52  * using integrity (two 4-byte integers): */
>=20
> I'm not sure what it is suppose to be. Isn't "data before arguments"
> can vary in length and thus explain why linux and onto sizes are
> different?
> Looking at the network trace the krb5 verifier I see is 36bytes.

GSS_VERF_SLACK is only for the extra length added by GSS data. The
length of the RPC message itself is handled separately, see above.

Can you post a Wireshark dissection of the problematic FSINFO reply?
(Having a working reply from Linux and a failing reply from OnTAP
would be even better).


>>> For GSS, au_rslack is calculated from GSS_VERF_SLACK value which is
>>> currently 100. And it's not enough. Changing it to 104 works and =
then
>>> au_rslack is recalculated based on actual received mic.len and not
>>> just the default buffer size.

What are the computed au_ralign and au_rslack values after the first
successful operation?


>>> I would like to propose to change it to something a little larger =
than
>>> 104, like 120 to give room if some other server might reply with
>>> something even larger.
>>=20
>> Why does it need to be larger than 104?
>=20
> I don't know why 100 was chosen and given that I think arguments are
> taken into the account and arguments can change. I think NetApp has
> changed their file handle sizes (at some point, not in the near past
> but i think so?). Perhaps they might want to do that again so the size
> will change again.
>=20
> Honestly, I would have like for 100 to be 200 to be safe.

To be safe, I would like to have a good understanding of the details,
rather than guessing at an arbitrary maximum value. Let's choose a
rational maximum and include a descriptive comment about why that value
is the best choice.


>>> Thoughts? Will send an actual patch if no objections to this one.
>>>=20
>>> diff --git a/net/sunrpc/auth_gss/auth_gss.c =
b/net/sunrpc/auth_gss/auth_gss.c
>>> index 24ca861..44ae6bc 100644
>>> --- a/net/sunrpc/auth_gss/auth_gss.c
>>> +++ b/net/sunrpc/auth_gss/auth_gss.c
>>> @@ -50,7 +50,7 @@
>>> #define GSS_CRED_SLACK         (RPC_MAX_AUTH_SIZE * 2)
>>> /* length of a krb5 verifier (48), plus data added before arguments =
when
>>> * using integrity (two 4-byte integers): */
>>> -#define GSS_VERF_SLACK         100
>>> +#define GSS_VERF_SLACK         120
>>>=20
>>> static DEFINE_HASHTABLE(gss_auth_hash_table, 4);
>>> static DEFINE_SPINLOCK(gss_auth_hash_lock);
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



