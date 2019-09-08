Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94A3CACF93
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Sep 2019 17:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbfIHPvp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Sep 2019 11:51:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42078 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfIHPvo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Sep 2019 11:51:44 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x88Fmujm062010;
        Sun, 8 Sep 2019 15:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=GjqYVX5oUfthQW4PL9HWs1FoFR7n9cNhuhRVOx5HQuc=;
 b=esj84nCYsbp9S1I/yys+xT2OKP914u14dIWdU9+jtxjl3Rj5KIsFI5gjsUIjyjvq7+tb
 MYwpiiAvJJqwKiISYnjOasOZaWXnsvkxaHObITXwNLJT9I1OaHGwRh1lP5TJVG8COC/G
 AKQeg01tYK9aHYGWQByWLI6wf7HH34Bh7ui2szjexW37H736YmmQhqTNXIjO/QMKUauS
 A/uN8R0CRrCRt6nrgxkpCeCClHdHyh25/6YzvXu+XPgiJLhl8ai5ZYcJdY1siAKtVr99
 2oc3GTdErjep+uCkPS3rfZDoaI4StLo63yjnMGJ0ogpIvYfm6i6npL9boQvcyGDDV44J ow== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2uw1jxrbaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 08 Sep 2019 15:49:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x88FhWWx073426;
        Sun, 8 Sep 2019 15:49:03 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2uv3wkfccs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 08 Sep 2019 15:49:03 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x88FmxVc016315;
        Sun, 8 Sep 2019 15:48:59 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 08 Sep 2019 08:48:59 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: Regression in 5.1.20: Reading long directory fails
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <1ebf86cff330eb15c02249f0dac415a8aff99f49.camel@hammerspace.com>
Date:   Sun, 8 Sep 2019 11:48:58 -0400
Cc:     "bcodding@redhat.com" <bcodding@redhat.com>,
        "tibbs@math.uh.edu" <tibbs@math.uh.edu>,
        Bruce Fields <bfields@fieldses.org>,
        "linux@stwm.de" <linux@stwm.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "km@cm4all.com" <km@cm4all.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3B2EEB3C-3305-4A50-A55B-51093A985284@oracle.com>
References: <ufak1bhyuew.fsf@epithumia.math.uh.edu>
 <4418877.15LTP4gqqJ@stwm.de> <ufapnkhqjwm.fsf@epithumia.math.uh.edu>
 <4198657.JbNDGbLXiX@h2o.as.studentenwerk.mhn.de>
 <ufad0ggrfrk.fsf@epithumia.math.uh.edu> <20190906144837.GD17204@fieldses.org>
 <ufapnkdw3s3.fsf@epithumia.math.uh.edu>
 <75F810C6-E99E-40C3-B5E1-34BA2CC42773@oracle.com>
 <A862CFCD-76A2-4373-8F44-F156DB38E6A5@redhat.com>
 <1ebf86cff330eb15c02249f0dac415a8aff99f49.camel@hammerspace.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9374 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909080172
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9374 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909080173
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 8, 2019, at 11:19 AM, Trond Myklebust <trondmy@hammerspace.com> =
wrote:
>=20
> On Sun, 2019-09-08 at 07:39 -0400, Benjamin Coddington wrote:
>> On 6 Sep 2019, at 16:50, Chuck Lever wrote:
>>=20
>>>> On Sep 6, 2019, at 4:47 PM, Jason L Tibbitts III <
>>>> tibbs@math.uh.edu>=20
>>>> wrote:
>>>>=20
>>>>>>>>> "JBF" =3D=3D J Bruce Fields <bfields@fieldses.org> writes:
>>>>=20
>>>> JBF> Those readdir changes were client-side, right?  Based on
>>>> that=20
>>>> I'd
>>>> JBF> been assuming a client bug, but maybe it'd be worth getting
>>>> a=20
>>>> full
>>>> JBF> packet capture of the readdir reply to make sure it's legit.
>>>>=20
>>>> I have been working with bcodding on IRC for the past couple of
>>>> days=20
>>>> on
>>>> this.  Fortunately I was able to come up with way to fill up a=20
>>>> directory
>>>> in such a way that it will fail with certainty and as a bonus
>>>> doesn't
>>>> include any user data so I can feel OK about sharing packet
>>>> captures.=20
>>>> I
>>>> have a capture alongside a kernel trace of the problematic
>>>> operation=20
>>>> in
>>>> https://www.math.uh.edu/~tibbs/nfs/.  Not that I can
>>>> particularly=20
>>>> tell
>>>> anything useful from that, but bcodding says that it seems to
>>>> point=20
>>>> to
>>>> some issue in sunrpc.
>>>>=20
>>>> And because I can easily reproduce this and I was able to do a=20
>>>> bisect:
>>>>=20
>>>> 2c94b8eca1a26cd46010d6e73a23da5f2e93a19d is the first bad commit
>>>> commit 2c94b8eca1a26cd46010d6e73a23da5f2e93a19d
>>>> Author: Chuck Lever <chuck.lever@oracle.com>
>>>> Date:   Mon Feb 11 11:25:41 2019 -0500
>>>>=20
>>>>   SUNRPC: Use au_rslack when computing reply buffer size
>>>>=20
>>>>   au_rslack is significantly smaller than (au_cslack << 2).
>>>> Using
>>>>   that value results in smaller receive buffers. In some cases
>>>> this
>>>>   eliminates an extra segment in Reply chunks (RPC/RDMA).
>>>>=20
>>>>   Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>>   Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>>>=20
>>>> :040000 040000 d4d1ce2fbe0035c5bd9df976b8c448df85dcb505=20
>>>> 7011a792dfe72ff9cd70d66e45d353f3d7817e3e M      net
>>>>=20
>>>> But of course, I can't say whether this is the actual bad commit
>>>> or
>>>> whether it just introduced a behavior change which alters the=20
>>>> conditions
>>>> under which the problem appears.
>>>=20
>>> The first place I'd start looking is the XDR constants at the head
>>> of=20
>>> fs/nfs/nfs4xdr.c
>>> having to do with READDIR.
>>>=20
>>> The report of behavior changes with the use of krb5p also makes
>>> this=20
>>> commit plausible.
>>=20
>> After sprinkling the printk's, we're coming up one word short in the=20=

>> receive
>> buffer.  I think we're not accounting for the xdr pad of buf->pages
>> for=20
>> NFS4
>> readdir -- but I need to check the RFCs.  Anyone know if v4 READDIR=20=

>> results
>> have to be aligned?
>>=20
>> Also need to check just why krb5i is the only auth that cares..
>>=20
>=20
> I'm not seeing that. If you look at commit 02ef04e432ba, you'll see
> that Chuck did add a 'padding term' to decode_readdir_maxsz in the
> NFSv4 case.
> The other thing to remember is that a readdir 'dirlist4' entry is
> always word aligned (irrespective of the length of the filename), so
> there is no padding that needs to be taken into account.
>=20
> I think we probably rather want to look at how auth->au_ralign is =
being
> calculated for the case of krb5i. I'm really not understanding why
> auth->au_ralign should not take into account the presence of the mic.
> Chuck?

I'm looking at gss_unwrap_resp_integ():

1971         auth->au_rslack =3D auth->au_verfsize + 2 + 1 + =
XDR_QUADLEN(mic.len);
1972         auth->au_ralign =3D auth->au_verfsize + 2;

au_ralign now sets the alignment of the _start_ of the RPC message body.
The MIC comes _after_ the RPC message body for krb5i.

If Ben is off by one quad, that's not the MIC, which is typically 32 =
octets,
isn't it?

Maybe some variable-length data item in the returned file attributes is =
missing
an XDR pad.

--
Chuck Lever



