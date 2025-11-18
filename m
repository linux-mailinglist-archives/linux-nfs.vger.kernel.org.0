Return-Path: <linux-nfs+bounces-16493-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 09800C6B10E
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Nov 2025 18:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F0284EC734
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Nov 2025 17:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5792A353888;
	Tue, 18 Nov 2025 17:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P485/J7m"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF11349B0B
	for <linux-nfs@vger.kernel.org>; Tue, 18 Nov 2025 17:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763488384; cv=none; b=Qtu3VObY108gFuySgl/AAuGXdfuFhcFk0AhtXH4SwkfrwXmUd8sxs622S1MzclfqT2iSKd59IEZiByeXWN9yc+DOeujZwcaqDCCVXxKAdCMJCsgiw8KtjU2gcB3i4vWuhHJwu1AiX8DnVCtshFxnAS/5jR8GDUod3nX5tlp+/nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763488384; c=relaxed/simple;
	bh=oMnhAE1V1fXLVwhUz27gpxmt+ditmKfZvOxZorHT2LQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpfOkaEjk5fZ4Adrvrdaa7+jzZC1n2QlVEk+7U/Fj2mDCc4dH8G7m24itECb/yj3Es4h49pD850nt+0l46fhSyA5uvlzcqG+bcxxbGRELvtmM7AW76SifFvsN2fE1/pN7OChj9LyZMb34ynJvEdpF4/mMM+7GB3VxtCPCQpc9uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P485/J7m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763488381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vu/csfEFnyEkBBsr41ROQz63TVw41GbcSZBaDhOBGCU=;
	b=P485/J7mNMIjDm6sAzll285DYN7ZJg4qz82nl6HfLMhIXnBoSqUzac0mw/JhZDUosEQLZv
	XbgY5EdQrS15TMCZjfEcXRdrkb5JnYOjC8NTKExuqwuFZIgmrAB43S3+23WIGRvk2lxwBq
	Fpxd76aJLfc6jfjVd4t7FTrr9rwcjLQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503-EpWiH5ygPf26TUpakK7_ZQ-1; Tue,
 18 Nov 2025 12:52:31 -0500
X-MC-Unique: EpWiH5ygPf26TUpakK7_ZQ-1
X-Mimecast-MFC-AGG-ID: EpWiH5ygPf26TUpakK7_ZQ_1763488349
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6394F19560A2;
	Tue, 18 Nov 2025 17:52:29 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.81.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3E7319560B0;
	Tue, 18 Nov 2025 17:52:28 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id 3112F50AFE4; Tue, 18 Nov 2025 12:52:27 -0500 (EST)
Date: Tue, 18 Nov 2025 12:52:27 -0500
From: Scott Mayhew <smayhew@redhat.com>
To: "Tyler W. Ross" <TWR@tylerwross.com>
Cc: Trond Myklebust <trondmy@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Salvatore Bonaccorso <carnil@debian.org>,
	"1120598@bugs.debian.org" <1120598@bugs.debian.org>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Steve Dickson <steved@redhat.com>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ls input/output error ("NFS: readdir(/) returns -5") on krb5
 NFSv4 client using SHA2
Message-ID: <aRyyWy6hO1ueKf5_@aion>
References: <aRZL8kbmfbssOwKF@eldamar.lan>
 <de44bf50-0c87-4062-b974-0b879868c0f5@oracle.com>
 <AVpI5XolCCA38sGzxlfk6azQI9oUAxafUVl9B7B1WgJEmGgSAQq5nvulQO6P_RQqjBp3adqasHFsodhAAxai0dcp5scRMJk0dLsGMQeSiew=@tylerwross.com>
 <fVv3cF7Ulh3cKUP17C98gh_uOv9BcMlMpsIh1Nv5_0tdw-75PKiPJgIEP5o2jBVry7orwz7jeiGQenfCbuUxyj5JFstbx3RTFYr223qDmV0=@tylerwross.com>
 <a6d1435b-f507-49eb-b80c-4322dc7e1157@oracle.com>
 <Y79HV0VGpScPYqI_dDxeItkX2UZwSdReaUOpIeMeZXq2HLsHf5J_PTQqr7HrBYygICRsn-OB89QPrxPzjgv2smuzTThUPy_3fq_N1NprlUg=@tylerwross.com>
 <4a63ad3d-b53a-4eab-8ffb-dd206f52c20e@oracle.com>
 <902ff4995d8e75ad1cd2196bf7d8da42932fba35.camel@kernel.org>
 <aRunktdq8sJ7Eecj@aion>
 <db8b1ef4-afbb-4c23-b7f1-9ae688cef363@TylerWRoss.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <db8b1ef4-afbb-4c23-b7f1-9ae688cef363@TylerWRoss.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, 18 Nov 2025, Tyler W. Ross wrote:

> On 11/17/25 3:54 PM, Scott Mayhew wrote:
> > FWIW I have both Debian Trixie and Sid/Forky VMs, and krb5{,i,p} is
> > working across the board for me.  Normally I just use a plain MIT KDC,
> > so I tried IPA and that works fine too.
>=20
> Did you confirm the enctype used?

Yes.  This is how I was testing:

root@forky:~# uname -r
6.17.7+deb14+1-amd64
root@forky:~# systemctl restart rpc-gssd
root@forky:~# klist -ce /tmp/krb5ccmachine_SMAYHEW.TEST
klist: No credentials cache found (filename: /tmp/krb5ccmachine_SMAYHEW.TES=
T)
root@forky:~# for serv in forky trixie rawhide rhel10 rhel9; do for flav in=
 krb5 krb5i krb5p; do mount -o v4.2,sec=3D$flav $serv.smayhew.test:/export =
/mnt/t; ls -lR /mnt/t >/dev/null; umount /mnt/t; done; done
root@forky:~# klist -ce /tmp/krb5ccmachine_SMAYHEW.TEST
Ticket cache: FILE:/tmp/krb5ccmachine_SMAYHEW.TEST
Default principal: nfs/forky.smayhew.test@SMAYHEW.TEST

Valid starting     Expires            Service principal
11/14/25 14:53:03  11/15/25 14:53:03  krbtgt/SMAYHEW.TEST@SMAYHEW.TEST
        Etype (skey, tkt): aes256-cts-hmac-sha384-192, aes256-cts-hmac-sha3=
84-192
11/14/25 14:53:03  11/15/25 14:53:03  nfs/forky.smayhew.test@SMAYHEW.TEST
        Etype (skey, tkt): aes256-cts-hmac-sha384-192, aes256-cts-hmac-sha3=
84-192
11/14/25 14:53:03  11/15/25 14:53:03  nfs/trixie.smayhew.test@SMAYHEW.TEST
        Etype (skey, tkt): aes256-cts-hmac-sha384-192, aes256-cts-hmac-sha3=
84-192
11/14/25 14:53:03  11/15/25 14:53:03  nfs/rawhide.smayhew.test@SMAYHEW.TEST
        Etype (skey, tkt): aes256-cts-hmac-sha384-192, aes256-cts-hmac-sha3=
84-192
11/14/25 14:53:04  11/15/25 14:53:03  nfs/rhel10.smayhew.test@SMAYHEW.TEST
        Etype (skey, tkt): aes256-cts-hmac-sha384-192, aes256-cts-hmac-sha3=
84-192
11/14/25 14:53:05  11/15/25 14:53:03  nfs/rhel9.smayhew.test@SMAYHEW.TEST
        Etype (skey, tkt): aes256-cts-hmac-sha384-192, aes256-cts-hmac-sha3=
84-192

>=20
> My repro steps, from initial mounted state:
> kinit
> kvno -e aes256-cts-hmac-sha384-192 <nfs spn>
> ls /mnt/example
>=20
> On my Debian Sid VM, if I do kinit and then immediately ls, the issue=20
> does not occur. klist shows the acquired service ticket has an
> aes256-cts-hmac-sha1-96 session key.

Oh!  I see the problem.  If the automatically acquired service ticket
for a normal user is using aes256-cts-hmac-sha1-96, then I'm assuming
the machine credential is also using aes256-cts-hmac-sha1-96.
Run 'klist -ce /tmp/krb5ccmachine_IPA.TWRLAB.NET' to check.  You can't
use 'kvno -e' to choose a different encryption type.  Why are you doing
that?  Is it because you want to use the stronger encryption types?  In
that case, the proper way to do this would be to manually add this line
to the "[libdefaults]" stanza of your /etc/krb5.conf:

  permitted_enctypes =3D aes256-cts-hmac-sha384-192 aes128-cts-hmac-sha256-=
128 aes256-cts-hmac-sha1-96 aes128-cts-hmac-sha1-96

and get rid of allowed-enctypes settings that you may have added to
/etc/nfs.conf.  Then unmount, run 'systemctl restart rpc-gssd', remount,
etc. and your system should be using aes256-cts-hmac-sha384-192 by default.

RHEL/CentOS/Fedora all ship a package called "crypto-policies" that
include system-wide configurations for various crypto packages.  For
kerberos, it drops a config snippet in /etc/krb5.conf.d similar to what
I have above.  AFAICT Suse has this package too, but it appears Debian
does not.

Without the permitted_enctypes setting, the kerberos library will fall
back to the default settings, which according to krb5.conf(5)=20

---8<---
       permitted_enctypes
              Identifies the encryption types that servers will permit for =
ses=E2=80=90
              sion keys and for ticket and authenticator encryption, ordere=
d by
              preference from highest to lowest.   Starting  in  release  1=
=2E18,
              this  tag also acts as the default value for default_tgs_enct=
ypes
              and default_tkt_enctypes.  The default  value  for  this  tag=
  is
              aes256-cts-hmac-sha1-96                   aes128-cts-hmac-sha=
1-96
              aes256-cts-hmac-sha384-192             aes128-cts-hmac-sha256=
-128
              des3-cbc-sha1    arcfour-hmac-md5   camellia256-cts-cmac   ca=
mel=E2=80=90
              lia128-cts-cmac.
---8<---

If I remove that line from my krb5.conf and use 'kvno -e' like your
test, then I can reproduce the behavior you're seeing:

root@forky:~# systemctl restart rpc-gssd
root@forky:~# mount -o v4.2,sec=3Dkrb5 trixie.smayhew.test:/export /mnt/t
root@forky:~# klist -ce /tmp/krb5ccmachine_SMAYHEW.TEST=20
Ticket cache: FILE:/tmp/krb5ccmachine_SMAYHEW.TEST
Default principal: nfs/forky.smayhew.test@SMAYHEW.TEST

Valid starting     Expires            Service principal
11/18/25 17:41:29  11/19/25 17:15:04  krbtgt/SMAYHEW.TEST@SMAYHEW.TEST
	Etype (skey, tkt): aes256-cts-hmac-sha1-96, camellia256-cts-cmac=20
11/18/25 17:41:29  11/19/25 17:15:04  nfs/trixie.smayhew.test@SMAYHEW.TEST
	Etype (skey, tkt): aes256-cts-hmac-sha1-96, aes256-cts-hmac-sha384-192=20
root@forky:~# su - smayhew
smayhew@forky:~$ kinit
Password for smayhew@SMAYHEW.TEST:=20
smayhew@forky:~$ kvno -e aes256-cts-hmac-sha384-192 nfs/trixie.smayhew.test
nfs/trixie.smayhew.test@SMAYHEW.TEST: kvno =3D 1
smayhew@forky:~$ klist -ce=20
Ticket cache: KEYRING:persistent:1052000003:1052000003
Default principal: smayhew@SMAYHEW.TEST

Valid starting     Expires            Service principal
11/18/25 17:41:53  11/19/25 17:20:27  nfs/trixie.smayhew.test@SMAYHEW.TEST
	Etype (skey, tkt): aes256-cts-hmac-sha384-192, aes256-cts-hmac-sha384-192=
=20
11/18/25 17:41:39  11/19/25 17:20:27  krbtgt/SMAYHEW.TEST@SMAYHEW.TEST
	Etype (skey, tkt): aes256-cts-hmac-sha1-96, camellia256-cts-cmac=20
smayhew@forky:~$ ls /mnt/t
ls: reading directory '/mnt/t': Input/output error
smayhew@forky:~$=20
logout
root@forky:~# grep overflow /sys/kernel/debug/tracing/trace
              ls-2032    [002] .....  3025.593816: rpc_xdr_overflow: task:0=
0000009@00000006 nfsv4 READDIR requested=3D8 p=3D00000000dfba8950 end=3D000=
00000b97e329e xdr=3D[00000000389cc91a,132]/4008/[00000000b97e329e,4]/988

-Scott
>=20
>=20
> TWR
>=20


