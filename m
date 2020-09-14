Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF283269737
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Sep 2020 22:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgINUz1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Sep 2020 16:55:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42326 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgINUzY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Sep 2020 16:55:24 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08EKdYUQ005208;
        Mon, 14 Sep 2020 20:55:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=Kc+wSOIut5+iLA/XkKwKfdAvKeE1dUVJvDc2m/eq2fg=;
 b=b6h471cT7Il7M35IOCTJMyOdkC5zRsfUV0137JJ6FIBfikFtrjn40tv/176IAoSlIE5n
 Ey0aIxQN8BYHJcKF2Gm8oiUWVl026qRtUqvgpN+mEDSnWCV/IQ+g3EMcwL94hTdM6jsz
 SCILtIF3AN/2ZwSmJfrfoD1s1hmtPC8lKPdPguUq9XyrWOFf8PkbSsAZyJCnnvVMiZrB
 hPkZTjorIUO4tRt8CCUHyutfPY51zOw7KXHxlZZv4mUKCR6nHzSyUwxVVMLQj/7xdoWQ
 sErj04UI36TkGZDIbnI7dSJO1TII2RN97KwPqggORODcHGNbFSjEbyPAKhpi1rk5bufM RA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 33gnrqs3tp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Sep 2020 20:55:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08EKeddZ141687;
        Mon, 14 Sep 2020 20:53:17 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 33h88wpcxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Sep 2020 20:53:17 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08EKrGe1012907;
        Mon, 14 Sep 2020 20:53:16 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 14 Sep 2020 20:53:16 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH RFC] NFSD: synchronously unhash a file on NFSv4 CLOSE
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200914205127.GD30007@fieldses.org>
Date:   Mon, 14 Sep 2020 16:53:15 -0400
Cc:     Trond Myklebust <trond.myklebust@primarydata.com>,
        Jeff Layton <jlayton@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <18B8C7A0-CDF9-4B5F-AABF-43189CE84CEC@oracle.com>
References: <159976711218.1334.14422329830210182280.stgit@klimt.1015granger.net>
 <20200914205127.GD30007@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9744 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009140163
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9744 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 bulkscore=0 suspectscore=0
 clxscore=1011 mlxlogscore=999 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009140163
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 14, 2020, at 4:51 PM, J. Bruce Fields <bfields@fieldses.org> =
wrote:
>=20
> On Thu, Sep 10, 2020 at 03:45:12PM -0400, Chuck Lever wrote:
>> I recently observed a significant slowdown in a long-running
>> test on NFSv4.0 mounts.
>>=20
>> An OPEN for write seems to block the NFS server from offering
>> delegations on that file for a few seconds. The problem is that
>> when that file is closed, the filecache retains an open-for-write
>> file descriptor until the laundrette runs. That keeps the inode's
>> i_writecount positive until the cached file is finally unhashed
>> and closed.
>>=20
>> Force the NFSv4 CLOSE logic to call filp_close() to eliminate
>> the underlying cached open-for-write file as soon as the client
>> closes the file.
>>=20
>> This minor change claws back about 80% of the performance
>> regression.
>=20
> That's really useful to know.  But mainly this makes me think that
> nfsd4_check_conflicting_opens() is wrong.
>=20
> I'm trying to determine whether a given file has a non-nfsd writer by
> counting the number of write opens nfsd holds on a given file and
> subtracting that from i_writecount.
>=20
> But the way I'm counting write opens probably isn't correct.

I entertained that possibility, but I couldn't figure out
a better way to count opens-for-write.


> --b.
>=20
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> fs/nfsd/nfs4state.c |    8 ++++++--
>> 1 file changed, 6 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 3ac40ba7efe1..0b3059b8b36c 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -613,10 +613,14 @@ static void __nfs4_file_put_access(struct =
nfs4_file *fp, int oflag)
>> 		if (atomic_read(&fp->fi_access[1 - oflag]) =3D=3D 0)
>> 			swap(f2, fp->fi_fds[O_RDWR]);
>> 		spin_unlock(&fp->fi_lock);
>> -		if (f1)
>> +		if (f1) {
>> +			=
nfsd_file_close_inode_sync(locks_inode(f1->nf_file));
>> 			nfsd_file_put(f1);
>> -		if (f2)
>> +		}
>> +		if (f2) {
>> +			=
nfsd_file_close_inode_sync(locks_inode(f2->nf_file));
>> 			nfsd_file_put(f2);
>> +		}
>> 	}
>> }

--
Chuck Lever



