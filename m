Return-Path: <linux-nfs+bounces-16538-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4365C6EF0E
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 14:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 8C56C2E86E
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 13:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA3D32721A;
	Wed, 19 Nov 2025 13:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NQLWKXO8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A008355024
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 13:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763559389; cv=none; b=UQLP7jrs3FfUoPe4T+a+q37uTa660oVkaHX9/Asj/aNtg547U8PbF2RCkUlnsoPW8SCc6e2VES5QaEAIvufeH4QTPGY/vGj09EzmEALNURwKGjdvaSta0ytqkVHNlZSCbWSZYwJs01dQ4Oz5zDbyhJedFl8TMOz5QnVeCtTueAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763559389; c=relaxed/simple;
	bh=pPXKHjO4NQ7VfCGBRA+prrjb6nqBroQ3WVmGWhxed80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQwnQorzl2hu+IjDvT0Wdlo453RxiakDb5LgwJWKpPdH5iE+zS5stVjiv+6ffOmiLeQVSOGhknSitLjZwvwjKJ/n/rlZ0Si1aVRA7waNUD6q+mzASNHZBs9NOmwes6MxyjtG7ykbaCVHW3iIB9skmLEU6Q3M0+SBvGDY7qdfTSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NQLWKXO8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763559387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0PRa9z0pKCuLKGL658u7Ew2t9bLbt3/kinAXsN6/RNk=;
	b=NQLWKXO83Qdip2BSkM5xy7RjLjTROBiYo+5KNtIVrxUba5INUA1uiMe/Ymu5d4VstzNZRb
	iZc05XyDNieFurzB861mxnCGpDJloczNZUqDEwbjyHFe5HWzmr1pNTxsrYazZdT3B393zM
	M3N93NxlDdp5+QvAJw0qmH8Wjmx8UOk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-SI8EuZZUPXmv0DY7NEWDyA-1; Wed,
 19 Nov 2025 08:36:23 -0500
X-MC-Unique: SI8EuZZUPXmv0DY7NEWDyA-1
X-Mimecast-MFC-AGG-ID: SI8EuZZUPXmv0DY7NEWDyA_1763559381
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 271E519560AD;
	Wed, 19 Nov 2025 13:36:21 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.81.26])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 20DC018004A3;
	Wed, 19 Nov 2025 13:36:20 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id 55CD950BB30; Wed, 19 Nov 2025 08:36:18 -0500 (EST)
Date: Wed, 19 Nov 2025 08:36:18 -0500
From: Scott Mayhew <smayhew@redhat.com>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: "Tyler W. Ross" <TWR@tylerwross.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	"1120598@bugs.debian.org" <1120598@bugs.debian.org>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Steve Dickson <steved@redhat.com>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Simon Josefsson <simon@josefsson.org>
Subject: Re: ls input/output error ("NFS: readdir(/) returns -5") on krb5
 NFSv4 client using SHA2
Message-ID: <aR3H0kYQrmmq0RMS@aion>
References: <fVv3cF7Ulh3cKUP17C98gh_uOv9BcMlMpsIh1Nv5_0tdw-75PKiPJgIEP5o2jBVry7orwz7jeiGQenfCbuUxyj5JFstbx3RTFYr223qDmV0=@tylerwross.com>
 <a6d1435b-f507-49eb-b80c-4322dc7e1157@oracle.com>
 <Y79HV0VGpScPYqI_dDxeItkX2UZwSdReaUOpIeMeZXq2HLsHf5J_PTQqr7HrBYygICRsn-OB89QPrxPzjgv2smuzTThUPy_3fq_N1NprlUg=@tylerwross.com>
 <4a63ad3d-b53a-4eab-8ffb-dd206f52c20e@oracle.com>
 <902ff4995d8e75ad1cd2196bf7d8da42932fba35.camel@kernel.org>
 <aRunktdq8sJ7Eecj@aion>
 <db8b1ef4-afbb-4c23-b7f1-9ae688cef363@TylerWRoss.com>
 <aRyyWy6hO1ueKf5_@aion>
 <85cd9202-dc22-41b8-8a20-e82cd118215f@TylerWRoss.com>
 <aR1MiaZYVc4kR8Yf@eldamar.lan>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aR1MiaZYVc4kR8Yf@eldamar.lan>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, 19 Nov 2025, Salvatore Bonaccorso wrote:

> Hi,
> 
> On Tue, Nov 18, 2025 at 11:43:29PM +0000, Tyler W. Ross wrote:
> > On 11/18/25 10:52 AM, Scott Mayhew wrote:
> > > Oh!  I see the problem.  If the automatically acquired service ticket
> > > for a normal user is using aes256-cts-hmac-sha1-96, then I'm assuming
> > > the machine credential is also using aes256-cts-hmac-sha1-96.
> > > Run 'klist -ce /tmp/krb5ccmachine_IPA.TWRLAB.NET' to check.  You can't
> > > use 'kvno -e' to choose a different encryption type.  Why are you doing
> > > that?
> > 
> > Aha! Thank you!
> 
> Thanks to all helping to debug this issue when reported downstream in
> Debian, your time invested is very much appreciated!

While I still assert that if you want to use the stronger encryption
types with NFS, then you should prioritize those encryption types higher
in your kerberos configuration... after discussing this yesterday with
Olga I think the above scenario should probably work too.

I just sent a patch that makes that happen, but I forgot to add
"--in-reply-to" my "git send-email" command, so here's the link:

https://lore.kernel.org/linux-nfs/20251119133231.3660975-1-smayhew@redhat.com/T/#u

-Scott

> 
> > That's exactly the case: the machine credential is
> > aes256-cts-hmac-sha1-96.
> > 
> > So, taking a step back for context/background: this issue was escalated to
> > me by someone attempting to use constrained delegation via gssproxy. In the
> > course of troubleshooting that, we found (by examining the krb5kdc logs on
> > the IPA server) that the NFS service ticket acquired by gssproxy had an
> > aes256-cts-hmac-sha384-192 session key.
> > 
> > Not understanding that the machine and user tickets must having matching
> > enctypes, I ended up down this rabbit hole thinking the problem
> > was with the SHA2 enctypes. Sorry to bring you all with me on that
> > misadventure.
> > 
> > 
> > 
> > The actual issue at hand then seems to be that gssproxy is requesting (and
> > receiving) a service ticket with an unusable (for the NFS mount) enctype,
> > when performing constrained delegation/S4U2Proxy.
> > 
> > krb5kdc logs of gssproxy performing S4U2Self and S4U2Proxy:Nov 18 18:06:51
> > directory.ipa.twrlab.net krb5kdc[8463](info): TGS_REQ (8 etypes
> > {aes256-cts-hmac-sha1-96(18), aes128-cts-hmac-sha1-96(17),
> > aes256-cts-hmac-sha384-192(20), aes128-cts-hmac-sha256-128(19),
> > UNSUPPORTED:des3-hmac-sha1(16), DEPRECATED:arcfour-hmac(23),
> > camellia128-cts-cmac(25), camellia256-cts-cmac(26)}) 10.108.2.105: ISSUE:
> > authtime 1763506600, etypes {rep=aes256-cts-hmac-sha1-96(18),
> > tkt=aes256-cts-hmac-sha384-192(20), ses=aes256-cts-hmac-sha1-96(18)},
> > host/nfsclient.ipa.twrlab.net@IPA.TWRLAB.NET for
> > host/nfsclient.ipa.twrlab.net@IPA.TWRLAB.NET
> > Nov 18 18:06:51 directory.ipa.twrlab.net krb5kdc[8463](info):
> > ... PROTOCOL-TRANSITION s4u-client=jsmith@IPA.TWRLAB.NET
> > Nov 18 18:06:51 directory.ipa.twrlab.net krb5kdc[8463](info): closing down
> > fd 4
> > Nov 18 18:06:51 directory.ipa.twrlab.net krb5kdc[8465](info): TGS_REQ (4
> > etypes {aes256-cts-hmac-sha384-192(20), aes128-cts-hmac-sha256-128(19),
> > aes256-cts-hmac-sha1-96(18), aes128-cts-hmac-sha1-96(17)}) 10.108.2.105:
> > ISSUE: authtime 1763506600, etypes {rep=aes256-cts-hmac-sha1-96(18),
> > tkt=aes256-cts-hmac-sha384-192(20), ses=aes256-cts-hmac-sha384-192(20)},
> > host/nfsclient.ipa.twrlab.net@IPA.TWRLAB.NET for
> > nfs/nfssrv.ipa.twrlab.net@IPA.TWRLAB.NET
> > Nov 18 18:06:51 directory.ipa.twrlab.net krb5kdc[8465](info): ...
> > CONSTRAINED-DELEGATION s4u-client=jsmith@IPA.TWRLAB.NET
> > Nov 18 18:06:51 directory.ipa.twrlab.net krb5kdc[8465](info): closing down
> > fd 11
> > 
> > 
> > On the Fedora 43 client, gssproxy also acquires an
> > aes256-cts-hmac-sha384-192 service ticket, but the machine credential is
> > aes256-cts-hmac-sha384-192 and everything works as-ex
> > pected.
> 
> I'm looping in here the gssproxy maintainer as well. Simon, this is
> about https://bugs.debian.org/1120598 . I assume there is nothing on
> gssroxy side which can be done to warn about the situation, quoting
> again:
> 
> > The actual issue at hand then seems to be that gssproxy is requesting (and
> > receiving) a service ticket with an unusable (for the NFS mount) enctype,
> > when performing constrained delegation/S4U2Proxy.
> 
> ?
> 
> Regards,
> Salvatore
> 


