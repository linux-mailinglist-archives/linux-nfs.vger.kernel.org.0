Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00C87B01D6
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Sep 2019 18:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbfIKQma (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Sep 2019 12:42:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42382 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbfIKQm3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Sep 2019 12:42:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8BGdDSG081541;
        Wed, 11 Sep 2019 16:39:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=olnz9+MXBYY8sr/lCFzuy0miu2bi/5GOgOuSQtcf9jU=;
 b=ZPYsLw/hQQCsASCBb0UDw3kIRW70YqdjXLGdQxHFHzNB6eBB0JuDi2CndzJQcviQT1Kt
 f8zh/xWReXj+OUbW0ZGswwX8kaJdtbTPFA8VJs0/c6jyvt7ez3OedDDDDHYs2KjkUx7S
 vigOJ4gEcmgkw2rlHpfOzx26d2u3AnGcUe4ImGV/FCBTy1qAWcaxPO34BQvZ0X8hseQg
 6AbA8f610Jck0HIYi/Mk5KkscIsjenEf1Fmf/04tV42ny5MO5Jz2gRt7R+2ia9KQdA6/
 3fpFCbi8EG3ktSEF4gjb94kHdwisx0lCrwUNDh1XeVNxUeLZlDlLutH81/flWyuRWUtx uw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2uw1jybbjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Sep 2019 16:39:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8BGcR21101735;
        Wed, 11 Sep 2019 16:39:57 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2uxd6efnth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Sep 2019 16:39:56 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8BGdsbn030965;
        Wed, 11 Sep 2019 16:39:54 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Sep 2019 09:39:54 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: Regression in 5.1.20: Reading long directory fails
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <DD6B77EE-3E25-4A65-9D0E-B06EEAD32B31@redhat.com>
Date:   Wed, 11 Sep 2019 12:39:52 -0400
Cc:     Jason L Tibbitts III <tibbs@math.uh.edu>,
        Bruce Fields <bfields@fieldses.org>,
        Wolfgang Walter <linux@stwm.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        km@cm4all.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0089DF80-3A1C-4F0B-A200-28FF7CFD0C65@oracle.com>
References: <ufak1bhyuew.fsf@epithumia.math.uh.edu>
 <4418877.15LTP4gqqJ@stwm.de> <ufapnkhqjwm.fsf@epithumia.math.uh.edu>
 <4198657.JbNDGbLXiX@h2o.as.studentenwerk.mhn.de>
 <ufad0ggrfrk.fsf@epithumia.math.uh.edu> <20190906144837.GD17204@fieldses.org>
 <ufapnkdw3s3.fsf@epithumia.math.uh.edu>
 <75F810C6-E99E-40C3-B5E1-34BA2CC42773@oracle.com>
 <DD6B77EE-3E25-4A65-9D0E-B06EEAD32B31@redhat.com>
To:     Benjamin Coddington <bcodding@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9377 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909110153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9377 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909110154
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 11, 2019, at 12:25 PM, Benjamin Coddington =
<bcodding@redhat.com> wrote:
>=20
> On 6 Sep 2019, at 16:50, Chuck Lever wrote:
>=20
>>> On Sep 6, 2019, at 4:47 PM, Jason L Tibbitts III <tibbs@math.uh.edu> =
wrote:
>>>=20
>>>>>>>> "JBF" =3D=3D J Bruce Fields <bfields@fieldses.org> writes:
>>>=20
>>> JBF> Those readdir changes were client-side, right?  Based on that =
I'd
>>> JBF> been assuming a client bug, but maybe it'd be worth getting a =
full
>>> JBF> packet capture of the readdir reply to make sure it's legit.
>>>=20
>>> I have been working with bcodding on IRC for the past couple of days =
on
>>> this.  Fortunately I was able to come up with way to fill up a =
directory
>>> in such a way that it will fail with certainty and as a bonus =
doesn't
>>> include any user data so I can feel OK about sharing packet =
captures.  I
>>> have a capture alongside a kernel trace of the problematic operation =
in
>>> https://www.math.uh.edu/~tibbs/nfs/.  Not that I can particularly =
tell
>>> anything useful from that, but bcodding says that it seems to point =
to
>>> some issue in sunrpc.
>>>=20
>>> And because I can easily reproduce this and I was able to do a =
bisect:
>>>=20
>>> 2c94b8eca1a26cd46010d6e73a23da5f2e93a19d is the first bad commit
>>> commit 2c94b8eca1a26cd46010d6e73a23da5f2e93a19d
>>> Author: Chuck Lever <chuck.lever@oracle.com>
>>> Date:   Mon Feb 11 11:25:41 2019 -0500
>>>=20
>>>   SUNRPC: Use au_rslack when computing reply buffer size
>>>=20
>>>   au_rslack is significantly smaller than (au_cslack << 2). Using
>>>   that value results in smaller receive buffers. In some cases this
>>>   eliminates an extra segment in Reply chunks (RPC/RDMA).
>>>=20
>>>   Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>   Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>>=20
>>> :040000 040000 d4d1ce2fbe0035c5bd9df976b8c448df85dcb505 =
7011a792dfe72ff9cd70d66e45d353f3d7817e3e M      net
>>>=20
>>> But of course, I can't say whether this is the actual bad commit or
>>> whether it just introduced a behavior change which alters the =
conditions
>>> under which the problem appears.
>>=20
>> The first place I'd start looking is the XDR constants at the head of =
fs/nfs/nfs4xdr.c
>> having to do with READDIR.
>=20
> Well, one thing is that I wonder about decode_readdir_maxsz including
> decode_verifier_maxsz since it is part of READDIR4resok, and so should =
be
> included in the page data.. but that really doesn't matter here, I =
think we
> just end up with a larger head.  Moving the start of the tail two =
words
> forward doesn't seem to fix things..
>=20
> I think the mic's xdr_buf_subsegment is getting partially split =
between
> leftover space in the pages and the tail, so the checks for the length =
of
> the subbuf do not match the length of mic.  In that case, we usually =
just
> have extra room in the tail to copy it over, but now that rslack is =
not so
> slack, the only extra room (as determined in xdr_buf_read_netobj()) =
would be
> extra space in the page data, which we can't use.
>=20
> The problem is that xdr_buf_read_netobj() is using =
xdr_buf_subsegment() with
> an offset in the response data to the mic, but xdr_buf_subsegement() =
decides
> what to do based on offsets in the already set-up xdr_buf.  If the =
server's
> response leaves a hole in the page_len less than the mic, then the mic
> subsegment straddles the page and the tail.  Then we try to copy it to =
the
> end of the tail, but now there's not enough room.
>=20
> Instead, I think we want to make sure the mic falls squarely into the =
tail
> every time.

I'm not clear how you could do that. The length of the page data is not
known to the client before it parses the reply. Are you suggesting that
gss_unwrap should do it somehow?


> xdr_buf_read_netobj() is only used for the mic, so it seems like we =
can
> refactor it to just use the tail, or get rid of it altogether.  I'll =
see if
> I can do that.
>=20
> Read on, if you want some numbers to check my work..
>=20
> Here's how to reproduce:
> Init an xdr_buf of 176, so rq_rcvsize is:
> 4  RPC_REPHDRSIZE
> 19  auth->au_rslack
> 21  .p_replen
> -----
> 44<<2 =3D 176
>=20
> Then xdr_inline_pages() with:
> - offset 140:
>    21  resp.hdr
>     4  RPC_REPHDRSIZE
>    11  auth->au_ralign
>    -1  xdr pad fixup
>    -----
>    35<<2 =3D 140
>=20
> - base of 88 (that's static entries for . and ..)
> - len of 262056 (64 pages - base of 88)
>=20
> This gives us the following xdr_buf:
>=20
> struct xdr_buf {
>    head->iov_len =3D 140,
>    tail->iov_len =3D 32,
>    page_len =3D 262056,
>    buflen =3D 262232
> }
>=20
> Then, get a READDIR response of total length 232208:
>=20
> 56 bytes to GSS data
> 76 bytes to READDIR4resok
> 262044 bytes of READDIR4resok
> 32 bytes of mic
>=20
> That puts the mic at offset 262176.
>=20
> That all looks right, and the response is well-formed.
>=20
> Things go badly in xdr_read_netobj() with offset 262176:
>=20
> We return -ENOMEM when
> obj->len (28) is > than buf->buflen (262232) - buf->len (262208)
>=20
> Ben

--
Chuck Lever



