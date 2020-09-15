Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B4F26AB85
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Sep 2020 20:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgIOSJG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Sep 2020 14:09:06 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42312 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727887AbgIOSIZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Sep 2020 14:08:25 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FDFdHl085509;
        Tue, 15 Sep 2020 13:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=uNesw8fleIIrcs6tSs/ZH+DJHN905jHUiWGcQuQyrO4=;
 b=NRChyMAK4L/0a0Goj3QCYzYpF/zgEqTehYSA0xby8oNTLn7QNtcmJ1KNCgKBD5jT/uwm
 mnG1T6JI5I65l9Uq9GFMt73cA7KtQmIEz9PL2JJUvGsZx30CL312fXAoDY1/1jD4HYPm
 /xXThEOHP7HMd3IOZZtr007vivbZPnfxD6Y8wNQQYvR+IrDAsll5IB4R2Ai0w5l3t2z1
 LZaqYmlMLBlr45dFDGMcO6YpBr+eTrnPZSW/2GoWggl6Ivj0Q/oE7Gdad31joxRQa7Cu
 ABFLhJfbKmXeG7py4K0qtYcUyEnnZwURUibfJcPZAB5t0caka0iotyWkYF0EzyrCVGRD xQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 33gp9m4wb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Sep 2020 13:18:37 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FDFQPK121929;
        Tue, 15 Sep 2020 13:18:37 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 33h884uv9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Sep 2020 13:18:37 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08FDIYEG008003;
        Tue, 15 Sep 2020 13:18:35 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Sep 2020 13:18:34 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH RFC] NFSD: synchronously unhash a file on NFSv4 CLOSE
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <18B8C7A0-CDF9-4B5F-AABF-43189CE84CEC@oracle.com>
Date:   Tue, 15 Sep 2020 09:18:31 -0400
Cc:     Trond Myklebust <trond.myklebust@primarydata.com>,
        Jeff Layton <jlayton@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <25B85F11-E8AA-444B-85F8-039135A43D39@oracle.com>
References: <159976711218.1334.14422329830210182280.stgit@klimt.1015granger.net>
 <20200914205127.GD30007@fieldses.org>
 <18B8C7A0-CDF9-4B5F-AABF-43189CE84CEC@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9744 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009150111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9744 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009150111
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 14, 2020, at 4:53 PM, Chuck Lever <chuck.lever@oracle.com> =
wrote:
>=20
>=20
>=20
>> On Sep 14, 2020, at 4:51 PM, J. Bruce Fields <bfields@fieldses.org> =
wrote:
>>=20
>> On Thu, Sep 10, 2020 at 03:45:12PM -0400, Chuck Lever wrote:
>>> I recently observed a significant slowdown in a long-running
>>> test on NFSv4.0 mounts.
>>>=20
>>> An OPEN for write seems to block the NFS server from offering
>>> delegations on that file for a few seconds. The problem is that
>>> when that file is closed, the filecache retains an open-for-write
>>> file descriptor until the laundrette runs. That keeps the inode's
>>> i_writecount positive until the cached file is finally unhashed
>>> and closed.
>>>=20
>>> Force the NFSv4 CLOSE logic to call filp_close() to eliminate
>>> the underlying cached open-for-write file as soon as the client
>>> closes the file.
>>>=20
>>> This minor change claws back about 80% of the performance
>>> regression.
>>=20
>> That's really useful to know.  But mainly this makes me think that
>> nfsd4_check_conflicting_opens() is wrong.
>>=20
>> I'm trying to determine whether a given file has a non-nfsd writer by
>> counting the number of write opens nfsd holds on a given file and
>> subtracting that from i_writecount.
>>=20
>> But the way I'm counting write opens probably isn't correct.
>=20
> I entertained that possibility, but I couldn't figure out
> a better way to count opens-for-write.

Also, the regression started long before nfsd4_check_conflicting_opens
was added.


>> --b.
>>=20
>>>=20
>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>> ---
>>> fs/nfsd/nfs4state.c |    8 ++++++--
>>> 1 file changed, 6 insertions(+), 2 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index 3ac40ba7efe1..0b3059b8b36c 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -613,10 +613,14 @@ static void __nfs4_file_put_access(struct =
nfs4_file *fp, int oflag)
>>> 		if (atomic_read(&fp->fi_access[1 - oflag]) =3D=3D 0)
>>> 			swap(f2, fp->fi_fds[O_RDWR]);
>>> 		spin_unlock(&fp->fi_lock);
>>> -		if (f1)
>>> +		if (f1) {
>>> +			=
nfsd_file_close_inode_sync(locks_inode(f1->nf_file));
>>> 			nfsd_file_put(f1);
>>> -		if (f2)
>>> +		}
>>> +		if (f2) {
>>> +			=
nfsd_file_close_inode_sync(locks_inode(f2->nf_file));
>>> 			nfsd_file_put(f2);
>>> +		}
>>> 	}
>>> }
>=20
> --
> Chuck Lever

--
Chuck Lever



