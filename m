Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAC5233864
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jul 2020 20:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgG3S3o (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Jul 2020 14:29:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38084 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgG3S3o (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 Jul 2020 14:29:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UIH0Ff092441;
        Thu, 30 Jul 2020 18:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=rjTXjtRN+RvmM7uB1uYGDATjMnpebsR+N6LC1i86n6c=;
 b=IosGJ79NM9OCKI3rnkPoHVgwjFmXKk2lwODoDwA1AJpP/Ar3iylHk3fKzvHxwa+La0Mj
 5HLOfunRkBg5BZwa9+Fq6kgFY7+arwyVLCXEKcJ9Ldkq2UHbZtZQ/hZif9urtCqcfSca
 pELEPFO0f5J80Kq63JXZe0BA4yiIJp0w5A5gEf0dTMBUcPfjs81KtMvCsxLXsXPz3TSq
 8mp9mLR7OI1Bu8PdWxcalcgjuom+7zhSc7XmP2t4k+L2J2wfQRZR2kv+hPt5YyL5msnV
 dMnxCoJE5yLDMhbdRWkz8C2i9mhyXNxn2WCs8rzRZooDnZNSi9SOJ2jNtt4Tu4/U1KKp dg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 32hu1jnaew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Jul 2020 18:29:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UIIgAT049994;
        Thu, 30 Jul 2020 18:29:37 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 32hu5x8rws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jul 2020 18:29:37 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06UITaNQ028314;
        Thu, 30 Jul 2020 18:29:36 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Jul 2020 11:29:36 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: Fedora 32 rpc.gssd misbehavior
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <08c0450556bac1a745b567401482efe9ec6a6ac5.camel@redhat.com>
Date:   Thu, 30 Jul 2020 14:29:34 -0400
Cc:     Jeff Layton <jlayton@redhat.com>,
        Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Robbie Harwood <rharwood@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <44BF8895-5018-4743-A4DD-C0734448BE15@oracle.com>
References: <83856C49-309A-4AD6-9B27-9F93FDDE00DF@oracle.com>
 <48B9E144-41CA-4DF0-A88D-2F6652A0EBF1@oracle.com>
 <5ae72c7b0afa65d509db23686d72a1055f7cc6b4.camel@redhat.com>
 <5DE48B32-CB63-4753-B7F4-3CAC55A111D8@oracle.com>
 <3c25f1dff6bf822aaba36b812bb4773e97df975e.camel@redhat.com>
 <D39C21E9-791C-40F7-B9D1-DAC69210A437@oracle.com>
 <08c0450556bac1a745b567401482efe9ec6a6ac5.camel@redhat.com>
To:     Simo Sorce <simo@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300130
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300130
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 30, 2020, at 2:20 PM, Simo Sorce <simo@redhat.com> wrote:
>=20
> On Thu, 2020-07-30 at 14:07 -0400, Chuck Lever wrote:
>>> On Jul 30, 2020, at 1:57 PM, Simo Sorce <simo@redhat.com> wrote:
>>>=20
>>> On Thu, 2020-07-30 at 13:09 -0400, Chuck Lever wrote:
>>>>> On Jul 30, 2020, at 12:14 PM, Simo Sorce <simo@redhat.com> wrote:
>>>>>=20
>>>>> On Wed, 2020-07-29 at 14:27 -0400, Chuck Lever wrote:
>>>>>>> On Jul 29, 2020, at 1:19 PM, Chuck Lever =
<chuck.lever@oracle.com> wrote:
>>>>>>>=20
>>>>>>> Hi!
>>>>>>>=20
>>>>>>> I recently updated my test systems from EL7 to Fedora 32, and
>>>>>>> NFSv4.0 with Kerberos has stopped working.
>>>>>>>=20
>>>>>>> I mount with "klimt.ib" as before. The client workload stops
>>>>>>> dead when the server tries to perform its first CB_RECALL.
>>>>>>>=20
>>>>>>> I added some client instrumentation:
>>>>>>>=20
>>>>>>> kernel: NFSv4: Callback principal (nfs@klimt.ib.1015granger.net) =
does not match acceptor (nfs@klimt.ib).
>>>>>>> kernel: NFS: NFSv4 callback contains invalid cred
>>>>>>>=20
>>>>>>> I boosted gssd verbosity, and it says:
>>>>>>>=20
>>>>>>> rpc.gssd[986]: doing downcall: lifetime_rec=3D72226 =
acceptor=3Dnfs@klimt.ib
>>>>>>>=20
>>>>>>> But it knows the full hostname for the server:
>>>>>>>=20
>>>>>>> rpc.gssd[986]: Full hostname for 'klimt.ib' is =
'klimt.ib.1015granger.net'
>>>>>>>=20
>>>>>>>=20
>>>>>>> The acceptor appears to come from the Kerberos library. =
Shouldn't
>>>>>>> it be canonicalized? If so, should the Kerberos library do it, =
or
>>>>>>> should gssd? Since this behavior appeared after an upgrade, I
>>>>>>> suspect a Kerberos library regression. But it could be config-
>>>>>>> related, since both systems were re-imaged from the ground up.
>>>>>>>=20
>>>>>>> Also noticing some other problems on the server (missing =
hostname
>>>>>>> strings in debug messages, sssd_kcm infinite loops, and gssd
>>>>>>> sending garbage to the client after the NULL request that
>>>>>>> establishes the callback context).
>>>>>>>=20
>>>>>>> But let's look at the client acceptor problem first.
>>>>>>=20
>>>>>> I believe I found the problem.
>>>>>>=20
>>>>>> 8bffe8c5ec1a ("gssd: add /etc/nfs.conf support") added a number =
of gssd config
>>>>>> options to /etc/nfs.conf, including "avoid-dns". The default =
setting of avoid-
>>>>>> dns is 1. When I set this option on my client system explicitly =
to 0, NFSv4.0
>>>>>> with Kerberos works again.
>>>>>>=20
>>>>>> Is there a reason the default setting is 1?
>>>>>>=20
>>>>>=20
>>>>> Now that you mention DNS, this may be an interaction between a new
>>>>> default in Fedora 32 and how your environment is setup re DNS.
>>>>>=20
>>>>> In F32 we changed the option dns_canonicalize_hostname from 'true' =
to
>>>>> 'fallback'.
>>>>> This is a transitional state to eventually move it to 'false' at =
some
>>>>> point in the future.
>>>>>=20
>>>>> What it changes in practice is that it will first try the name =
passed
>>>>> in *as is* and only as a fallback try a CNAME if the name passed =
is not
>>>>> resolved as an A name. If you have principals in the KDC for both
>>>>> names, but you do not have keys in the keytab for both, you can =
have
>>>>> transitional issues.
>>>>>=20
>>>>> Additionally we discovered a bug that causes non qualified names =
to
>>>>> fail resolution with the 'fallback' option.
>>>>> If your name in the principal is really not qualified it will try =
to
>>>>> qualify it anyway, so if your principal is literally nfs/foo@FOO
>>>>> libgssapi may try to use nfs/foo.my.domdain@FOO, where "my.domain" =
is
>>>>> what is defined in resolv.conf search path.
>>>>>=20
>>>>> We are trying to address this regression.
>>>>>=20
>>>>> So try to set dns_canonicalize_hostname to true to see if that may
>>>>> influence your issue. If so, please let me know, as we still need =
to
>>>>> address this where possible.
>>>>=20
>>>> I set avoid-dns to 1 and dns_canonicalize_hostname to true. The
>>>> workload hang is not reproducible, and the acceptor is fully =
qualified.
>>>>=20
>>>> rpc.gssd[965]: doing downcall: lifetime_rec=3D86338 =
acceptor=3Dnfs@klimt.ib.1015granger.net
>>>=20
>>> Chuck,
>>> can you tell what does klimt.ib.1015granger.net resolve to (A names
>>> CNAMEs, not really interested in IP address)?
>>=20
>> [root@manet ~]# dig klimt.ib.1015granger.net
>>=20
>> ; <<>> DiG 9.11.20-RedHat-9.11.20-1.fc32 <<>> =
klimt.ib.1015granger.net
>> ;; global options: +cmd
>> ;; Got answer:
>> ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 55806
>> ;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 1, ADDITIONAL: =
2
>>=20
>> ;; OPT PSEUDOSECTION:
>> ; EDNS: version: 0, flags:; udp: 4096
>> ; COOKIE: 0a7a07d8b06eedeab886314f5f230a8c6f752fe4a24c2f97 (good)
>> ;; QUESTION SECTION:
>> ;klimt.ib.1015granger.net.	IN	A
>>=20
>> ;; ANSWER SECTION:
>> klimt.ib.1015granger.net. 10800	IN	A	192.168.2.55
>>=20
>> ;; AUTHORITY SECTION:
>> ib.1015granger.net.	10800	IN	NS	gateway.1015granger.net.
>>=20
>> ;; ADDITIONAL SECTION:
>> gateway.1015granger.net. 10800	IN	A	192.168.1.1
>>=20
>> ;; Query time: 0 msec
>> ;; SERVER: 192.168.1.1#53(192.168.1.1)
>> ;; WHEN: Thu Jul 30 13:59:40 EDT 2020
>> ;; MSG SIZE  rcvd: 135
>>=20
>> [root@manet ~]#
>=20
> so klimt is an A name, and it is a fqdn in the principal, so I am
> puzzled why the krb5.conf option would make a difference, unless
> 192.168.2.55 perhaps resolves to a different name and you have rdns =3D
> true ?

rdns is false on my NFS client.

[cel@manet ~]$ dig -x 192.168.2.55

; <<>> DiG 9.11.20-RedHat-9.11.20-1.fc32 <<>> -x 192.168.2.55
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 22491
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 1, ADDITIONAL: 2

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
; COOKIE: 868fe3a23c55fdee29cc812d5f231096a66a540a8064f2e8 (good)
;; QUESTION SECTION:
;55.2.168.192.in-addr.arpa.	IN	PTR

;; ANSWER SECTION:
55.2.168.192.IN-ADDR.ARPA. 10800 IN	PTR	=
klimt.ib.1015granger.net.

;; AUTHORITY SECTION:
2.168.192.IN-ADDR.ARPA.	10800	IN	NS	gateway.1015granger.net.

;; ADDITIONAL SECTION:
gateway.1015granger.net. 10800	IN	A	192.168.1.1

;; Query time: 0 msec
;; SERVER: 192.168.1.1#53(192.168.1.1)
;; WHEN: Thu Jul 30 14:25:26 EDT 2020
;; MSG SIZE  rcvd: 183

[cel@manet ~]$


>>> Also what ticket do you ultimately get in the ccache when this =
request
>>> is made ?
>>=20
>> I'm not exactly sure what you're asking, but:
>>=20
>> [root@manet ~]# klist FILE:/tmp/krb5ccmachine_1015GRANGER.NET
>> Ticket cache: FILE:/tmp/krb5ccmachine_1015GRANGER.NET
>> Default principal: host/manet.1015granger.net@1015GRANGER.NET
>>=20
>> Valid starting       Expires              Service principal
>> 07/30/2020 13:45:38  07/31/2020 13:45:38  =
krbtgt/1015GRANGER.NET@1015GRANGER.NET
>> 	renew until 08/06/2020 13:45:38
>> [root@manet ~]#
>=20
> I was asking what ticket you get to use to talk to klimt, this is the
> machine ccache but it only has the krbtgt for the machine host key.

I'm mounting with sec=3Dsys, so the machine host key is the only
key in play. The client uses that key for NFSv4.0 lease management
and callbacks.

It is the callback context that is the problem. The client is
required to match the server's principal to the client's
acceptor when authenticating a callback operation.


> And now that I reread the thread better I see:
>=20
> Callback principal (nfs@klimt.ib.1015granger.net) does not match
> acceptor (nfs@klimt.ib)
>=20
> do you use klimt.ib explicitly somewhere instad of the fqdn and rely =
on
> name expansion ?

Yes, I mount with "mount -o vers=3D4.0,sec=3Dsys klimt.ib:/export /mnt" =
.

When dns_canonicalize_hostname =3D true or avoid-dns =3D 0, gssd
properly canonicalizes the acceptor so that it matches the
server's callback principal.

--
Chuck Lever



