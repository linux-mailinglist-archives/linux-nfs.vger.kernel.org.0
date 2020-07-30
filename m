Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B020A233930
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jul 2020 21:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgG3TlQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Jul 2020 15:41:16 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33288 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbgG3TlQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 Jul 2020 15:41:16 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UJb0Tr029925;
        Thu, 30 Jul 2020 19:41:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=R2wmzwVzKDRyH1hMFuaVqiVyfhvwFeE2Zc/uM1BAkwc=;
 b=UiskQYOmaVSsYfVv7VHjhnwOSO1lOs9RnuiSUALCc8dKBG6zZMzzmOWLLGnk+buoWpz3
 zHLvY48ouEjKoT+qqfZJT/67XP3wjQhYtY461kISmNuXWSRTsDZ14d8moc8E/btnZKsH
 6bC1VXRfBiwkeXUDHMdWL3R9QB2qnD28+oEPIei6+4kKOi4Fplt6G+1np0eO15iETFoi
 m4z5ajn0lCVEthV78qnfSF3oVD3/WboLOJ/xsKqhzmSNZAgiMGWXUfRzu6imCbx5aCJf
 tWjAbjsQJHrRVwJh9IeirkRkJzYCAvxEKTCfJOo9/mWosl8sSkbAyEoMVafu0Tfh1U0b Ag== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 32hu1jnncy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Jul 2020 19:41:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UJcp8k138435;
        Thu, 30 Jul 2020 19:39:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 32hu5xu342-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jul 2020 19:39:11 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06UJd8Vn003691;
        Thu, 30 Jul 2020 19:39:08 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Jul 2020 12:39:07 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: Fedora 32 rpc.gssd misbehavior
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <ee4b7c47bc37a53afd751159ae39d01d7cd3ee34.camel@redhat.com>
Date:   Thu, 30 Jul 2020 15:39:06 -0400
Cc:     Robbie Harwood <rharwood@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0A4076D1-46BD-4B48-9667-60D679221210@oracle.com>
References: <83856C49-309A-4AD6-9B27-9F93FDDE00DF@oracle.com>
 <48B9E144-41CA-4DF0-A88D-2F6652A0EBF1@oracle.com>
 <5ae72c7b0afa65d509db23686d72a1055f7cc6b4.camel@redhat.com>
 <jlg7dulylq6.fsf@redhat.com>
 <4EB4AE01-F6D4-4E8F-86BF-C8BB07E63517@oracle.com>
 <ee4b7c47bc37a53afd751159ae39d01d7cd3ee34.camel@redhat.com>
To:     Simo Sorce <simo@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007300135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300135
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 30, 2020, at 3:10 PM, Simo Sorce <simo@redhat.com> wrote:
>=20
> On Thu, 2020-07-30 at 13:59 -0400, Chuck Lever wrote:
>>> On Jul 30, 2020, at 1:08 PM, Robbie Harwood <rharwood@redhat.com> =
wrote:
>>>=20
>>> Simo Sorce <simo@redhat.com> writes:
>>>=20
>>>> On Wed, 2020-07-29 at 14:27 -0400, Chuck Lever wrote:
>>>>>> On Jul 29, 2020, at 1:19 PM, Chuck Lever <chuck.lever@oracle.com> =
wrote:
>>>>>>=20
>>>>>> Hi!
>>>>>>=20
>>>>>> I recently updated my test systems from EL7 to Fedora 32, and
>>>>>> NFSv4.0 with Kerberos has stopped working.
>>>>>>=20
>>>>>> I mount with "klimt.ib" as before. The client workload stops
>>>>>> dead when the server tries to perform its first CB_RECALL.
>>>>>>=20
>>>>>> I added some client instrumentation:
>>>>>>=20
>>>>>> kernel: NFSv4: Callback principal (nfs@klimt.ib.1015granger.net) =
does not match acceptor (nfs@klimt.ib).
>>>>>> kernel: NFS: NFSv4 callback contains invalid cred
>>>>>>=20
>>>>>> I boosted gssd verbosity, and it says:
>>>>>>=20
>>>>>> rpc.gssd[986]: doing downcall: lifetime_rec=3D72226 =
acceptor=3Dnfs@klimt.ib
>>>>>>=20
>>>>>> But it knows the full hostname for the server:
>>>>>>=20
>>>>>> rpc.gssd[986]: Full hostname for 'klimt.ib' is =
'klimt.ib.1015granger.net'
>>>>>>=20
>>>>>>=20
>>>>>> The acceptor appears to come from the Kerberos library. Shouldn't
>>>>>> it be canonicalized? If so, should the Kerberos library do it, or
>>>>>> should gssd? Since this behavior appeared after an upgrade, I
>>>>>> suspect a Kerberos library regression. But it could be config-
>>>>>> related, since both systems were re-imaged from the ground up.
>>>>>>=20
>>>>>> Also noticing some other problems on the server (missing hostname
>>>>>> strings in debug messages, sssd_kcm infinite loops, and gssd
>>>>>> sending garbage to the client after the NULL request that
>>>>>> establishes the callback context).
>>>>>>=20
>>>>>> But let's look at the client acceptor problem first.
>>>>>=20
>>>>> I believe I found the problem.
>>>>>=20
>>>>> 8bffe8c5ec1a ("gssd: add /etc/nfs.conf support") added a number of =
gssd config
>>>>> options to /etc/nfs.conf, including "avoid-dns". The default =
setting of avoid-
>>>>> dns is 1. When I set this option on my client system explicitly to =
0, NFSv4.0
>>>>> with Kerberos works again.
>>>>>=20
>>>>> Is there a reason the default setting is 1?
>>>>>=20
>>>>=20
>>>> Now that you mention DNS, this may be an interaction between a new
>>>> default in Fedora 32 and how your environment is setup re DNS.
>>>>=20
>>>> In F32 we changed the option dns_canonicalize_hostname from 'true' =
to
>>>> 'fallback'.
>>>> This is a transitional state to eventually move it to 'false' at =
some
>>>> point in the future.
>>>>=20
>>>> What it changes in practice is that it will first try the name =
passed
>>>> in *as is* and only as a fallback try a CNAME if the name passed is =
not
>>>> resolved as an A name. If you have principals in the KDC for both
>>>> names, but you do not have keys in the keytab for both, you can =
have
>>>> transitional issues.
>>>>=20
>>>> Additionally we discovered a bug that causes non qualified names to
>>>> fail resolution with the 'fallback' option.
>>>> If your name in the principal is really not qualified it will try =
to
>>>> qualify it anyway, so if your principal is literally nfs/foo@FOO
>>>> libgssapi may try to use nfs/foo.my.domdain@FOO, where "my.domain" =
is
>>>> what is defined in resolv.conf search path.
>>>>=20
>>>> We are trying to address this regression.
>>>>=20
>>>> So try to set dns_canonicalize_hostname to true to see if that may
>>>> influence your issue. If so, please let me know, as we still need =
to
>>>> address this where possible.
>>>=20
>>> Also, please try setting `qualify_shortname =3D ""`.  (I did update =
the
>>> config file we ship with Fedora, but upstream's default turns that =
on.
>>> This is a temporary workaround while we merge something better
>>> upstream.)
>>=20
>> For completeness, I tried:
>>=20
>> avoid-dns =3D 1
>> dns_canonicalize_hostname =3D fallback
>> qualify_shortname =3D ""
>>=20
>> which is the default configuration out of the shrink wrap.
>>=20
>> The workload hangs as before, and the acceptor is unqualified:
>>=20
>> rpc.gssd[985]: doing downcall: lifetime_rec=3D84046 =
acceptor=3Dnfs@klimt.ib
>>=20
>>=20
>> The test is:
>>=20
>> Configured domain name is "1015granger.net"
>>=20
>> Fully-qualified client hostname is "manet.ib.granger.net"
>>=20
>> Fully-qualified server hostname is "klimt.ib.granger.net"
>>=20
>> mount command is "mount -o vers=3D4.0,sec=3Dsys klimt.ib:/export =
/mnt"
>>=20
>> In this case, both systems have keytabs and service principals, so
>> the client automatically attempts to establish a GSS context for
>> lease management and callback operations. The failure occurs because
>> the server's principal is nfs@klimt.ib.1015granger.net but the
>> acceptor now matches the server hostname from the mount command line,
>> which is not always fully qualified.
>=20
> Ok, TBH I personally consider the syntax you  are currently using as
> working by accident and that you should really sue the FQDN on the
> command line (I assume it works that way, right?), however I =
understand
> this is also technically a regression, that said I do not think we can
> really fix this case because your "shortname" is not short (it has a
> dot in it) so the heuristicts won't trigger to qualify it even when =
you
> set qualify_shortname=3D"".
>=20
> I have the feeling we'll break this case, and our answer will have to
> be "use the fqdn on the command line".

See previous e-mail. Using the shrink wrap default settings, which
includes qualify_shortname=3D"", results in a hang on callback, as
originally observed.

Users will notice this and complain: klimt.ib works for the NFSv3
case and the NFSv4.1 case, and for NFSv4.0 when there is no keytab,
but NFSv4.0,sec=3D* with a keytab eventually hangs.


--
Chuck Lever



