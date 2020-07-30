Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08B3233811
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jul 2020 20:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730355AbgG3SBV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Jul 2020 14:01:21 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47704 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgG3SBV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 Jul 2020 14:01:21 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UHvj6G016616;
        Thu, 30 Jul 2020 18:01:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=iFOmaZ+PCzIDEq+EGU22AAvQXIw0WyMFW66koCuDi/o=;
 b=D0sXszJsGZTtCmucL+WrJO7xXCKoGVOtFj5DmlsodCNlc5Q7jmhGMsE+z4yJ4Y82GDwX
 sqCCdsno4ZqHZHck52cFjftzlS1BXii/rMnldsDspqV8wSUmKhyeurpFhTqHsspUpk/J
 ENrzgd0A+k5X0HWh1/2V60MOXXnURtPR0yA9r7YU58CzfG7CHukfgodTK4NgWYSMEMzH
 1SAkDHecfTNfnlQbPnjPLxIntptPEQl9hLgZh3Gt/klnHPkitdTRnu5Trg2/Cg5bqfcS
 Cu0YNOU0sYU1/mPbgyIKIDAlDLiu0koxqvbUFHaLSkxoHwF3D7+/qtF/tQIuSPgsDLeD 8w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 32hu1jn5ab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Jul 2020 18:01:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UHrSIB100058;
        Thu, 30 Jul 2020 17:59:15 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 32hu5x4njj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jul 2020 17:59:15 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06UHxDtw025189;
        Thu, 30 Jul 2020 17:59:13 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Jul 2020 10:59:13 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: Fedora 32 rpc.gssd misbehavior
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <jlg7dulylq6.fsf@redhat.com>
Date:   Thu, 30 Jul 2020 13:59:12 -0400
Cc:     Jeff Layton <jlayton@redhat.com>,
        Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4EB4AE01-F6D4-4E8F-86BF-C8BB07E63517@oracle.com>
References: <83856C49-309A-4AD6-9B27-9F93FDDE00DF@oracle.com>
 <48B9E144-41CA-4DF0-A88D-2F6652A0EBF1@oracle.com>
 <5ae72c7b0afa65d509db23686d72a1055f7cc6b4.camel@redhat.com>
 <jlg7dulylq6.fsf@redhat.com>
To:     Robbie Harwood <rharwood@redhat.com>, Simo Sorce <simo@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 mlxscore=0 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300127
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 30, 2020, at 1:08 PM, Robbie Harwood <rharwood@redhat.com> =
wrote:
>=20
> Simo Sorce <simo@redhat.com> writes:
>=20
>> On Wed, 2020-07-29 at 14:27 -0400, Chuck Lever wrote:
>>>> On Jul 29, 2020, at 1:19 PM, Chuck Lever <chuck.lever@oracle.com> =
wrote:
>>>>=20
>>>> Hi!
>>>>=20
>>>> I recently updated my test systems from EL7 to Fedora 32, and
>>>> NFSv4.0 with Kerberos has stopped working.
>>>>=20
>>>> I mount with "klimt.ib" as before. The client workload stops
>>>> dead when the server tries to perform its first CB_RECALL.
>>>>=20
>>>> I added some client instrumentation:
>>>>=20
>>>>  kernel: NFSv4: Callback principal (nfs@klimt.ib.1015granger.net) =
does not match acceptor (nfs@klimt.ib).
>>>>  kernel: NFS: NFSv4 callback contains invalid cred
>>>>=20
>>>> I boosted gssd verbosity, and it says:
>>>>=20
>>>>  rpc.gssd[986]: doing downcall: lifetime_rec=3D72226 =
acceptor=3Dnfs@klimt.ib
>>>>=20
>>>> But it knows the full hostname for the server:
>>>>=20
>>>>  rpc.gssd[986]: Full hostname for 'klimt.ib' is =
'klimt.ib.1015granger.net'
>>>>=20
>>>>=20
>>>> The acceptor appears to come from the Kerberos library. Shouldn't
>>>> it be canonicalized? If so, should the Kerberos library do it, or
>>>> should gssd? Since this behavior appeared after an upgrade, I
>>>> suspect a Kerberos library regression. But it could be config-
>>>> related, since both systems were re-imaged from the ground up.
>>>>=20
>>>> Also noticing some other problems on the server (missing hostname
>>>> strings in debug messages, sssd_kcm infinite loops, and gssd
>>>> sending garbage to the client after the NULL request that
>>>> establishes the callback context).
>>>>=20
>>>> But let's look at the client acceptor problem first.
>>>=20
>>> I believe I found the problem.
>>>=20
>>> 8bffe8c5ec1a ("gssd: add /etc/nfs.conf support") added a number of =
gssd config
>>> options to /etc/nfs.conf, including "avoid-dns". The default setting =
of avoid-
>>> dns is 1. When I set this option on my client system explicitly to =
0, NFSv4.0
>>> with Kerberos works again.
>>>=20
>>> Is there a reason the default setting is 1?
>>>=20
>>=20
>> Now that you mention DNS, this may be an interaction between a new
>> default in Fedora 32 and how your environment is setup re DNS.
>>=20
>> In F32 we changed the option dns_canonicalize_hostname from 'true' to
>> 'fallback'.
>> This is a transitional state to eventually move it to 'false' at some
>> point in the future.
>>=20
>> What it changes in practice is that it will first try the name passed
>> in *as is* and only as a fallback try a CNAME if the name passed is =
not
>> resolved as an A name. If you have principals in the KDC for both
>> names, but you do not have keys in the keytab for both, you can have
>> transitional issues.
>>=20
>> Additionally we discovered a bug that causes non qualified names to
>> fail resolution with the 'fallback' option.
>> If your name in the principal is really not qualified it will try to
>> qualify it anyway, so if your principal is literally nfs/foo@FOO
>> libgssapi may try to use nfs/foo.my.domdain@FOO, where "my.domain" is
>> what is defined in resolv.conf search path.
>>=20
>> We are trying to address this regression.
>>=20
>> So try to set dns_canonicalize_hostname to true to see if that may
>> influence your issue. If so, please let me know, as we still need to
>> address this where possible.
>=20
> Also, please try setting `qualify_shortname =3D ""`.  (I did update =
the
> config file we ship with Fedora, but upstream's default turns that on.
> This is a temporary workaround while we merge something better
> upstream.)

For completeness, I tried:

avoid-dns =3D 1
dns_canonicalize_hostname =3D fallback
qualify_shortname =3D ""

which is the default configuration out of the shrink wrap.

The workload hangs as before, and the acceptor is unqualified:

rpc.gssd[985]: doing downcall: lifetime_rec=3D84046 =
acceptor=3Dnfs@klimt.ib


The test is:

Configured domain name is "1015granger.net"

Fully-qualified client hostname is "manet.ib.granger.net"

Fully-qualified server hostname is "klimt.ib.granger.net"

mount command is "mount -o vers=3D4.0,sec=3Dsys klimt.ib:/export /mnt"

In this case, both systems have keytabs and service principals, so
the client automatically attempts to establish a GSS context for
lease management and callback operations. The failure occurs because
the server's principal is nfs@klimt.ib.1015granger.net but the
acceptor now matches the server hostname from the mount command line,
which is not always fully qualified.


--
Chuck Lever



