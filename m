Return-Path: <linux-nfs+bounces-16519-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AEAC6CC55
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 05:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id D24802C5C8
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 04:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DBA2DF71B;
	Wed, 19 Nov 2025 04:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jn0dDYrJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB15307AC5
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 04:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763527823; cv=none; b=LLGeh5bw7rKI1Yw8pKIfsthSuhg9ITg0UnjeUzMNia20wEZbFukp1QWekgu7A7K3CP315LCUPAngWPIknso50z9/FsxKH0kFenJ4mwIEbnmoWj5kt2fsQvPUm73aNju7N946KkWDG3OHFOuc3bWbKmVlOKUwJq2Q0wErVhFojsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763527823; c=relaxed/simple;
	bh=uy5eSpV62p2H09YQGx8yG5S4D6+C+pY0E+tpBih96uA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UefGLYnOraAF13Em7bVJMWoRI1Zut3Y3lD0x8rjhSMDorPTDSUuxD1ccEOmHErM5peKqZnWg+g9jEYSEskeiIqSxPdfvSMxbkWUwwrVBObaMJj562XqpCSAekdjwjRLaaODB8ipJbnlBSYxqPWzXj+ONosfcgiQsOtOoxIyPZWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jn0dDYrJ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4777771ed1aso43424775e9.2
        for <linux-nfs@vger.kernel.org>; Tue, 18 Nov 2025 20:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763527820; x=1764132620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mDkvoxkCuh3RNYeupEaeAKJkLqKVA+WiXtH4iTHXg2c=;
        b=jn0dDYrJiR9XDvQ7V8vo1i5uSj4OnwTVKVxermvxSw+ke4S1d9V3eFNj3wtWIwMSgO
         E1atGmy8mG0Cz4oNb6Zj2W77zjZW2qDvkF3m1chDSVtGw1tmlw0DpZx0FHAyJk8QHDa0
         HbjTx3FlxWiDQC99KQezwKZRFETeUig7fvnPcgovxaGQUDljRKv2KiIH93j/trVY/L/y
         sejDFL+N4PpbJ/j7V0lnIkGgz/mwavczhlxAQZoBKDhmOEui/OxZLuiUDPZ2bV7FagNT
         76VUKKRtDLJw19wZh6OeGdGzbjE5KQ5IsZ/byAAW+aTedOImDyR4lUus4ZObVDtpPmB2
         zx1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763527820; x=1764132620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mDkvoxkCuh3RNYeupEaeAKJkLqKVA+WiXtH4iTHXg2c=;
        b=fElyyZ+LuQR4KYNYlw2YK7Z0VSs4qKvePno/5txKWIcPB+G9B8lEAgzcIvGt8HKeMi
         BSvZO3GS/3mpIp5rSUi3g7J0KiAO/oIy0IrsHj7ixvJQshn4FW0D3+vj11BA+8p+Y98c
         zzfLW1iBeM9MLotJTx6MdrBS8+cj2ju8WPcWdcIATpYEtRdqH3jRWT4NsYtYTABKVNEA
         zjZKFTYJuYil3uIzXTvySPAxTOMm90YKYeHE65sMeGzoynACy80HEL/HPxw2cjNZCOju
         YWkzvGk4+2K8HhiMqabH3mpgCdKuKI6nBWvqOKSh4tCwcoEUfTO1FF/PlGzyQGAdmk4l
         7/5g==
X-Forwarded-Encrypted: i=1; AJvYcCWwCEwrOFRRUS54jgeb/b72FzpNNAuBAhSlTbrghnBllPk4XhqjOw29jEqguJTe56v2+NscYCrugo4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz42NeJJ4NVIcKMKeU0hx7ILkaGO4EIFIglCRk4EUUDhZqvXFxT
	eX7S9wH2JY8t4t4JlEjLdl72p2SLiJP55CEh2esKxVDu0hEIVMzkwFN6
X-Gm-Gg: ASbGncvh/WUav7/1MuIUEMnC/ioH1edcMkb1qWPEqsAfTGs8YWQeRr2XWm0IqfYwQDS
	RXIbAvv3T5nImFLBXNx2aGLV+Ks8adTQ2VuFXkLO6/KQOSoEKK5UujE7vZpVuGKAWvW0XsmPg+y
	Ha3uWJWw5a9RWehBgLEm5mQZS5DysWlc2/M0fFtAHR9zPmkAqL+WimmSxb7bPbdT39ZwsIUv+ja
	xBUSN76Srs8Y6DoqkuZ7fMezTNfFqqIZ4L3rr+Go/U3kQKvyk5JD2xoNOtLogwksZ21TsVwLiH1
	Fs0bidNnMfZgsK6CuxvzF00z//5Yrae9rwwHDkneN2PPUp0sYNFr9RYFXThgh8YOvpiDSxDueC5
	sFKvU6bHGXV0CxmTmbS89sCXbVQJs2oqHPEiT6G5cI07tulgNHXb7GXGfuxr8v6fL0Tu76cT0Wv
	K2IDaRLNy5mj7JNiRb63yzgUZlYXJfMRM7yGdkewjtlvIQ
X-Google-Smtp-Source: AGHT+IGwH2FkmhtLEuoN+9sHrL7YCOIrIrpSZDkyGAZ4ZW1s1xHCUII58dtc7cgvRdhgt4WF/jjH9g==
X-Received: by 2002:a05:600c:1550:b0:477:7b16:5fa6 with SMTP id 5b1f17b1804b1-477b197ab08mr6588565e9.3.1763527819440;
        Tue, 18 Nov 2025 20:50:19 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b106b03bsm24955065e9.9.2025.11.18.20.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 20:50:18 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 258B0BE2EE7; Wed, 19 Nov 2025 05:50:17 +0100 (CET)
Date: Wed, 19 Nov 2025 05:50:17 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: "Tyler W. Ross" <TWR@tylerwross.com>
Cc: Scott Mayhew <smayhew@redhat.com>, Trond Myklebust <trondmy@kernel.org>,
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
Message-ID: <aR1MiaZYVc4kR8Yf@eldamar.lan>
References: <aRZL8kbmfbssOwKF@eldamar.lan>
 <fVv3cF7Ulh3cKUP17C98gh_uOv9BcMlMpsIh1Nv5_0tdw-75PKiPJgIEP5o2jBVry7orwz7jeiGQenfCbuUxyj5JFstbx3RTFYr223qDmV0=@tylerwross.com>
 <a6d1435b-f507-49eb-b80c-4322dc7e1157@oracle.com>
 <Y79HV0VGpScPYqI_dDxeItkX2UZwSdReaUOpIeMeZXq2HLsHf5J_PTQqr7HrBYygICRsn-OB89QPrxPzjgv2smuzTThUPy_3fq_N1NprlUg=@tylerwross.com>
 <4a63ad3d-b53a-4eab-8ffb-dd206f52c20e@oracle.com>
 <902ff4995d8e75ad1cd2196bf7d8da42932fba35.camel@kernel.org>
 <aRunktdq8sJ7Eecj@aion>
 <db8b1ef4-afbb-4c23-b7f1-9ae688cef363@TylerWRoss.com>
 <aRyyWy6hO1ueKf5_@aion>
 <85cd9202-dc22-41b8-8a20-e82cd118215f@TylerWRoss.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85cd9202-dc22-41b8-8a20-e82cd118215f@TylerWRoss.com>

Hi,

On Tue, Nov 18, 2025 at 11:43:29PM +0000, Tyler W. Ross wrote:
> On 11/18/25 10:52 AM, Scott Mayhew wrote:
> > Oh!  I see the problem.  If the automatically acquired service ticket
> > for a normal user is using aes256-cts-hmac-sha1-96, then I'm assuming
> > the machine credential is also using aes256-cts-hmac-sha1-96.
> > Run 'klist -ce /tmp/krb5ccmachine_IPA.TWRLAB.NET' to check.  You can't
> > use 'kvno -e' to choose a different encryption type.  Why are you doing
> > that?
> 
> Aha! Thank you!

Thanks to all helping to debug this issue when reported downstream in
Debian, your time invested is very much appreciated!

> That's exactly the case: the machine credential is
> aes256-cts-hmac-sha1-96.
> 
> So, taking a step back for context/background: this issue was escalated to
> me by someone attempting to use constrained delegation via gssproxy. In the
> course of troubleshooting that, we found (by examining the krb5kdc logs on
> the IPA server) that the NFS service ticket acquired by gssproxy had an
> aes256-cts-hmac-sha384-192 session key.
> 
> Not understanding that the machine and user tickets must having matching
> enctypes, I ended up down this rabbit hole thinking the problem
> was with the SHA2 enctypes. Sorry to bring you all with me on that
> misadventure.
> 
> 
> 
> The actual issue at hand then seems to be that gssproxy is requesting (and
> receiving) a service ticket with an unusable (for the NFS mount) enctype,
> when performing constrained delegation/S4U2Proxy.
> 
> krb5kdc logs of gssproxy performing S4U2Self and S4U2Proxy:Nov 18 18:06:51
> directory.ipa.twrlab.net krb5kdc[8463](info): TGS_REQ (8 etypes
> {aes256-cts-hmac-sha1-96(18), aes128-cts-hmac-sha1-96(17),
> aes256-cts-hmac-sha384-192(20), aes128-cts-hmac-sha256-128(19),
> UNSUPPORTED:des3-hmac-sha1(16), DEPRECATED:arcfour-hmac(23),
> camellia128-cts-cmac(25), camellia256-cts-cmac(26)}) 10.108.2.105: ISSUE:
> authtime 1763506600, etypes {rep=aes256-cts-hmac-sha1-96(18),
> tkt=aes256-cts-hmac-sha384-192(20), ses=aes256-cts-hmac-sha1-96(18)},
> host/nfsclient.ipa.twrlab.net@IPA.TWRLAB.NET for
> host/nfsclient.ipa.twrlab.net@IPA.TWRLAB.NET
> Nov 18 18:06:51 directory.ipa.twrlab.net krb5kdc[8463](info):
> ... PROTOCOL-TRANSITION s4u-client=jsmith@IPA.TWRLAB.NET
> Nov 18 18:06:51 directory.ipa.twrlab.net krb5kdc[8463](info): closing down
> fd 4
> Nov 18 18:06:51 directory.ipa.twrlab.net krb5kdc[8465](info): TGS_REQ (4
> etypes {aes256-cts-hmac-sha384-192(20), aes128-cts-hmac-sha256-128(19),
> aes256-cts-hmac-sha1-96(18), aes128-cts-hmac-sha1-96(17)}) 10.108.2.105:
> ISSUE: authtime 1763506600, etypes {rep=aes256-cts-hmac-sha1-96(18),
> tkt=aes256-cts-hmac-sha384-192(20), ses=aes256-cts-hmac-sha384-192(20)},
> host/nfsclient.ipa.twrlab.net@IPA.TWRLAB.NET for
> nfs/nfssrv.ipa.twrlab.net@IPA.TWRLAB.NET
> Nov 18 18:06:51 directory.ipa.twrlab.net krb5kdc[8465](info): ...
> CONSTRAINED-DELEGATION s4u-client=jsmith@IPA.TWRLAB.NET
> Nov 18 18:06:51 directory.ipa.twrlab.net krb5kdc[8465](info): closing down
> fd 11
> 
> 
> On the Fedora 43 client, gssproxy also acquires an
> aes256-cts-hmac-sha384-192 service ticket, but the machine credential is
> aes256-cts-hmac-sha384-192 and everything works as-ex
> pected.

I'm looping in here the gssproxy maintainer as well. Simon, this is
about https://bugs.debian.org/1120598 . I assume there is nothing on
gssroxy side which can be done to warn about the situation, quoting
again:

> The actual issue at hand then seems to be that gssproxy is requesting (and
> receiving) a service ticket with an unusable (for the NFS mount) enctype,
> when performing constrained delegation/S4U2Proxy.

?

Regards,
Salvatore

