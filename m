Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A10B3181BE0
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2020 15:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbgCKO5v (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Mar 2020 10:57:51 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43376 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729584AbgCKO5v (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Mar 2020 10:57:51 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02BEqPiJ019602;
        Wed, 11 Mar 2020 14:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=LAXIx8AoNARGQFmIbaPyZoREQfBRH6fns2Us/Kj8mmE=;
 b=SD1SPekLFIrUrl2Q5S4XTe2TLS+s77uNVPFpNxxfwWcp2jz7+PCVBdXzGzxt5rrTBIEJ
 ojA0ofldYciXKinAwi4T2eO91gyCT4HrNRA57VXdtyqMAtNUmmHJK+VmkUo2AvwBXKcu
 ines0uNDWbnXI7ecckNj2bDZydjLX6DirlCGEBxSll9YaqHr5iCmBIJcB4PzkIDChd5w
 0zOijjD4txK9DY8tj8uFCwXGqjZWVyTfyTR1HB6r0XWjBMlEdxsw9VDp2lnEBgHOn3+u
 5YO8UrMSmOdki3TG+dDcTsWHQc50tIt+vh1P4q7l7tIUvem8aUacrsCHxAlwc26TCEbW 5A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2yp9v679vq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Mar 2020 14:57:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02BEq9YG146705;
        Wed, 11 Mar 2020 14:57:42 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2ypv9v70md-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Mar 2020 14:57:41 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02BEvcZF025443;
        Wed, 11 Mar 2020 14:57:38 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Mar 2020 07:57:38 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [RFC PATCH] fix krb5p mount not providing large enough buffer in
 rq_rcvsize
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <EE167593-39A6-4E29-B690-31D1D985DCC0@oracle.com>
Date:   Wed, 11 Mar 2020 10:57:37 -0400
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4570EF18-62A8-4301-B493-995D5CE7FD68@oracle.com>
References: <CAN-5tyHegg96s7mr1YeoPbVd0UA7_cd2GEPYNWx98uUcx-0ARw@mail.gmail.com>
 <FF0659E0-8F04-4005-96D0-5D513881EDFE@oracle.com>
 <CAN-5tyHQpS7AmPX1cDxKpD=5gyAM7+nmLX+iA29QV7sLwhoX9Q@mail.gmail.com>
 <EE167593-39A6-4E29-B690-31D1D985DCC0@oracle.com>
To:     Olga Kornievskaia <aglo@umich.edu>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003110095
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003110095
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 10, 2020, at 7:56 PM, Chuck Lever <chuck.lever@oracle.com> =
wrote:
>=20
>=20
>=20
>> On Mar 10, 2020, at 5:07 PM, Olga Kornievskaia <aglo@umich.edu> =
wrote:
>>=20
>> Hi Chuck,
>>=20
>> On Tue, Mar 10, 2020 at 3:57 PM Chuck Lever <chuck.lever@oracle.com> =
wrote:
>>>=20
>>> Hi Olga-
>>>=20
>>>> On Mar 10, 2020, at 2:58 PM, Olga Kornievskaia <aglo@umich.edu> =
wrote:
>>>>=20
>>>> Ever since commit 2c94b8eca1a26 "SUNRPC: Use au_rslack when =
computing
>>>> reply buffer size". It changed how "req->rq_rcvsize" is calculated. =
It
>>>> used to use au_cslack value which was nice and large and changed it =
to
>>>> au_rslack value which turns out to be too small.
>>>>=20
>>>> Since 5.1, v3 mount with sec=3Dkrb5p fails against an Ontap server
>>>> because client's receive buffer it too small.
>>>=20
>>> Can you be more specific? For instance, why is 100 bytes adequate =
for
>>> Linux servers, but not OnTAP?
>>=20
>> I don't know why Ontap sends more data than Linux server.
>=20
> Let's be sure we are fixing the right problem. Yes, au_rslack is
> smaller in v5.1, and that results in a behavioral regression. But
> exactly which part of the new calculation is incorrect is not yet
> clear. Simply bumping GSS_VERF_SLACK could very well plaster over
> the real problem.
>=20
>=20
>> The opaque_len is just a lot larger. For the first message Linux
>> opaque_len is 120bytes and Ontap it's 206. So it could be for =
instance
>> for FSINFO that sends the file handle, for Netapp the file handle is
>> 44bytes and for Linux it's only 28bytes.
>=20
> The maximum filehandle size should already be accounted for in the
> maxsize macro for FSINFO.
>=20
> Is this problem evident only with NFSv3 plus krb5p?
>=20
>=20
>>> Is this explanation for the current value not correct?
>>>=20
>>> 51 /* length of a krb5 verifier (48), plus data added before =
arguments when
>>> 52  * using integrity (two 4-byte integers): */
>>=20
>> I'm not sure what it is suppose to be. Isn't "data before arguments"
>> can vary in length and thus explain why linux and onto sizes are
>> different?
>> Looking at the network trace the krb5 verifier I see is 36bytes.
>=20
> GSS_VERF_SLACK is only for the extra length added by GSS data. The
> length of the RPC message itself is handled separately, see above.
>=20
> Can you post a Wireshark dissection of the problematic FSINFO reply?
> (Having a working reply from Linux and a failing reply from OnTAP
> would be even better).
>=20
>=20
>>>> For GSS, au_rslack is calculated from GSS_VERF_SLACK value which is
>>>> currently 100. And it's not enough. Changing it to 104 works and =
then
>>>> au_rslack is recalculated based on actual received mic.len and not
>>>> just the default buffer size.
>=20
> What are the computed au_ralign and au_rslack values after the first
> successful operation?
>=20
>=20
>>>> I would like to propose to change it to something a little larger =
than
>>>> 104, like 120 to give room if some other server might reply with
>>>> something even larger.
>>>=20
>>> Why does it need to be larger than 104?
>>=20
>> I don't know why 100 was chosen and given that I think arguments are
>> taken into the account and arguments can change. I think NetApp has
>> changed their file handle sizes (at some point, not in the near past
>> but i think so?). Perhaps they might want to do that again so the =
size
>> will change again.
>>=20
>> Honestly, I would have like for 100 to be 200 to be safe.
>=20
> To be safe, I would like to have a good understanding of the details,
> rather than guessing at an arbitrary maximum value. Let's choose a
> rational maximum and include a descriptive comment about why that =
value
> is the best choice.

As author of 2c94b8eca1a26 I'm interested in helping resolve this
issue. I've audited this code again, and reviewed the git log.

Interestingly, this commit:

commit adeb8133dd57f380e70a389a89a2ea3ae227f9e2
Author:     Olga Kornievskaia <aglo@citi.umich.edu>
AuthorDate: Mon Dec 4 20:22:34 2006 -0500
Commit:     Trond Myklebust <Trond.Myklebust@netapp.com>
CommitDate: Wed Dec 6 10:46:44 2006 -0500

    rpc: spkm3 update

changed GSS_VERF_SLACK from 56 to 100 without changing the documenting
comment or explaining the increase. That is the only change to
GSS_VERF_SLACK since 2006.

Also, au_rslack has always been set to GSS_VERF_SLACK. But I think
after 2c94b8eca1a26 ("SUNRPC: Use au_rslack when computing reply
buffer size"), GSS_VERF_SLACK is not the right symbolic constant to
use as an initial value of au_rslack.

Before that commit, rslack was not used to compute the receive buffer
slack, so the initial value was probably not interesting.

Since that commit, rslack is meant to be the size of GSS information
that _trails_ the RPC message payload. And ralign is intended to be
the size of the GSS information that _precedes_ that payload.


That doesn't address the problem of how to size the trailing GSS
information. I consulted RFC 2203 and 5403 hoping to find some
protocol-defined maximum for the size of the trailing GSS information
in integrity- and privacy-wrapped messages. Browsing through these
did not reveal any new wisdom (though I admit that I could have
misread these documents).

RFC 2203 Section 5.3.2.2 contains the structural definition of an
integrity-wrapped message:

      struct rpc_gss_integ_data {
          opaque databody_integ<>;
          opaque checksum<>;
      };

   The databody_integ field is created as follows.  A structure
   consisting of a sequence number followed by the procedure arguments
   is constructed. This is shown below as the type rpc_gss_data_t:

      struct rpc_gss_data_t {
          unsigned int seq_num;
          proc_req_arg_t arg;
      };

Note the use of empty angle brackets. These are variable-length opaques
with no pre-defined maximum size.

RFC 2203 Section 5.3.2.3 explains the construction of privacy-wrapped
messages:

   When data privacy is used, the request data is represented as
   follows:

      struct rpc_gss_priv_data {
          opaque databody_priv<>
      };

   The databody_priv field is created as follows.  The rpc_gss_data_t
   structure described earlier is constructed again in the same way as
   for the case of data integrity.  Next, the GSS_Wrap() call is invoked
   to encrypt the octet stream corresponding to the rpc_gss_data_t
   structure, using the same value for QOP (argument qop_req to
   GSS_Wrap()) as was used for the header checksum (in the verifier) and
   conf_req_flag (an argument to GSS_Wrap()) of TRUE.  The GSS_Wrap()
   call returns an opaque octet stream (representing the encrypted
   rpc_gss_data_t structure) and its length, and this is encoded as the
   databody_priv field. Since databody_priv has an XDR type of opaque,
   the length returned by GSS_Wrap() is encoded as the four octet
   length, followed by the encrypted octet stream (padded to a multiple
   of four octets).

And unfortunately this text is just as vague about the maximum size of
such messages. So:

x  The trailing information is not part of the RPC header verifier =
field,
so the use of GSS_VERF_SLACK is an arbitrary choice and not explanatory
as the initial setting for au_rslack. Pretty confusing, actually. I say
there should be a new symbolic constant defined for this value; maybe =
two:
one for integrity and one for privacy; but one large enough for either
is sufficient.

x  Also, there is no maximum size for these structures specified by the
protocol. Based on the RFCs, there is no way for the client to estimate
the initial reply size, and there is no way to sanity check the length
of the trailing GSS information in received GSS-wrapped messages, which
seems like a potential attack vector?

Thus GSS_VERF_SLACK is:
- a good symbolic initial value for au_ralign
- probably should be increased to RPC_MAX_AUTH_SIZE because that is the
largest size for that field according to RFC 5531 Section 8.2.
- probably should not be used as the initial value for au_rslack

Question is still: what maximum value is big enough to guarantee
interoperability? I've looked at libtirpc, no love there. Asking around
internally now.

I'm still interested in seeing what the Wireshark dissector says about
the failing OnTAP FSINFO response.


>>>> Thoughts? Will send an actual patch if no objections to this one.
>>>>=20
>>>> diff --git a/net/sunrpc/auth_gss/auth_gss.c =
b/net/sunrpc/auth_gss/auth_gss.c
>>>> index 24ca861..44ae6bc 100644
>>>> --- a/net/sunrpc/auth_gss/auth_gss.c
>>>> +++ b/net/sunrpc/auth_gss/auth_gss.c
>>>> @@ -50,7 +50,7 @@
>>>> #define GSS_CRED_SLACK         (RPC_MAX_AUTH_SIZE * 2)
>>>> /* length of a krb5 verifier (48), plus data added before arguments =
when
>>>> * using integrity (two 4-byte integers): */
>>>> -#define GSS_VERF_SLACK         100
>>>> +#define GSS_VERF_SLACK         120
>>>>=20
>>>> static DEFINE_HASHTABLE(gss_auth_hash_table, 4);
>>>> static DEFINE_SPINLOCK(gss_auth_hash_lock);
>>>=20
>>> --
>>> Chuck Lever
>=20
> --
> Chuck Lever

--
Chuck Lever



