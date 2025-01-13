Return-Path: <linux-nfs+bounces-9190-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 532AEA0C58E
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jan 2025 00:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 078AC3A22EC
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 23:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB1F1D356E;
	Mon, 13 Jan 2025 23:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IWiCBFIY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC7216EC19
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jan 2025 23:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736810445; cv=none; b=Z/vCFRivlwMizt5GnxZwfo9sdeSCcNQ/taX6tdh4kKtXOqkLKFUu+kd4O3A18tYRHNrRfWAW+6fKDZUNJ+F6h+FM5S/ovgtKcfsjStmNHrxr6E04p1lq6XnX+qyWZgG0X/OSI3SODghfd7bskvESrgUAO69wplBvyvS/gPkv09U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736810445; c=relaxed/simple;
	bh=CzSJbnXfOI/V9QFlUS9n9LtlTbbl/DUMNR0K6wAx3eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HObgFn36Dqj4hhp+7vQNFsmdnpJlQiP12lU3y9VUsX1mGM1VbhXcRva2zQv6Sr0YK1MyXM+SiOtgSyn/pdQOeDEwEdTUWNwHRCPTbTtPF0kmOLqcUpMqWUdvL7yPdHCTZ0Z1U1aiRNqYjM6OcmvQBk84nqfClhz1MzTWK2X+4hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IWiCBFIY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736810435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3BSY5EGbeP4i6pZ0BwIfM6cihWTAgQDX/BSENFxcGHg=;
	b=IWiCBFIYYOCyiSQaQZa0TDS09rTSGVpaEH9NRsBxswmJBsoTm2QdYJi+J/cPAY5MooCtsN
	U0r1hf78pybQIZ2sdUrAj9Tix+xSJggSbf8oL8SUONUj7hItJDSkDhTwUzY8kdG+PYF4fK
	NazO2oyWX77oAUnXr9nsiWba6W0hLUk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-Z0LmLg0XMb-lTC_-aDNIBw-1; Mon,
 13 Jan 2025 18:20:33 -0500
X-MC-Unique: Z0LmLg0XMb-lTC_-aDNIBw-1
X-Mimecast-MFC-AGG-ID: Z0LmLg0XMb-lTC_-aDNIBw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6770F195608A;
	Mon, 13 Jan 2025 23:20:32 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.64.152])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 29CFA19560A3;
	Mon, 13 Jan 2025 23:20:31 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id 139D62EA891; Mon, 13 Jan 2025 18:20:29 -0500 (EST)
Date: Mon, 13 Jan 2025 18:20:29 -0500
From: Scott Mayhew <smayhew@redhat.com>
To: steved@redhat.com
Cc: jlayton@kernel.org, yoyang@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [nfs-utils PATCH v3 0/3] version handling fixes for nfsdctl and
 rpc.nfsd
Message-ID: <Z4WfveqvKb5s9tc7@aion>
References: <20250113231319.951885-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="XC11gdYd2UEiHAlz"
Content-Disposition: inline
In-Reply-To: <20250113231319.951885-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


--XC11gdYd2UEiHAlz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, 13 Jan 2025, Scott Mayhew wrote:

> Two changes in how nfsdctl does version handling and one for rpc.nfsd.
> 
> The first patch makes the 'nfsdctl version' command behave according to
> the man page for w.r.t handling +4/-4, e.g.
> 
> # utils/nfsdctl/nfsdctl
> nfsdctl> threads 0
> nfsdctl> version
> +3.0 +4.0 +4.1 +4.2
> nfsdctl> version -4
> nfsdctl> version
> +3.0 -4.0 -4.1 -4.2
> nfsdctl> version +4
> nfsdctl> version
> +3.0 +4.0 +4.1 +4.2
> nfsdctl> version -4 +4.2
> nfsdctl> version
> +3.0 -4.0 -4.1 +4.2
> nfsdctl> ^D
> 
> The second patch makes nfsdctl's handling of the nfsd version options in
> nfs.conf behave like rpc.nfsd's.  This is important since the systemd
> service file will fall back to rpc.nfsd if nfsdctl fails.  Note that the
> v3 version of this patch also makes 'nfsdctl autostart' fail with an
> error if no versions and no minor versions are enabled in nfs.conf.
> 
> The third patch (also new in this v3 posting) makes rpc.nfsd consider
> the 'minorvers' bit field when determining whether any versions have
> been enabled.  This takes care of two scenarios:
> 1) When vers4=y but vers4.0=vers4.1=vers4.2=n
> 2) When vers2=vers3=vers4=n but any of vers4.0/vers4.1/vers4.2=y

Test script and results for test patches attached.

> 
> -Scott
> 
> Scott Mayhew (3):
>   nfsdctl: tweak the version subcommand behavior
>   nfsdctl: tweak the nfs.conf version handling
>   nfsd: fix version sanity check
> 
>  utils/nfsd/nfsd.c       | 29 +++++++++++---
>  utils/nfsdctl/nfsdctl.c | 86 +++++++++++++++++++++++++++++++++++------
>  2 files changed, 98 insertions(+), 17 deletions(-)
> 
> -- 
> 2.45.2
> 
> 

--XC11gdYd2UEiHAlz
Content-Type: application/x-sh
Content-Disposition: attachment; filename="test.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/bash=0A#=0ANFSD=3Dutils/nfsd/nfsd=0ANFSDCTL=3Dutils/nfsdctl/nfsdctl=
=0ANFSDRES=3D$(mktemp /tmp/nfsd.XXXXXX)=0ANFSDCTLRES=3D$(mktemp /tmp/nfsdct=
l.XXXXXX)=0A=0Acleanup()=0A{=0A	reset=0A	rm -f $NFSDRES $NFSDCTLRES=0A}=0A=
=0Areset()=0A{=0A	$NFSDCTL threads 0=0A	echo "+3 +4 +4.0 +4.1 +4.2" >/proc/=
fs/nfsd/versions=0A}=0A=0Acheck()=0A{=0A	$NFSDCTL threads 0=0A	$NFSD 16=0A	=
$NFSDCTL version >$NFSDRES=0A	$NFSDCTL threads 0=0A	$NFSDCTL autostart=0A	$=
NFSDCTL version >$NFSDCTLRES=0A	echo=0A	echo "/etc/nfs.conf:"=0A	cat /etc/n=
fs.conf=0A	echo=0A	echo -n "nfsd:    "=0A	cat $NFSDRES=0A	echo -n "nfsdctl:=
 "=0A	cat $NFSDCTLRES=0A	if ! diff -q $NFSDRES $NFSDCTLRES; then=0A		exit 1=
=0A	fi=0A	echo=0A}=0A=0Atrap cleanup EXIT INT=0A=0Ai=3D0=0Afor c3 in \  \#;=
 do=0A  for v3 in n y; do=0A    for c4 in \  \#; do=0A      for v4 in n y; =
do=0A        for c40 in \  \#; do=0A          for v40 in n y; do=0A        =
    for c41 in \  \#; do=0A              for v41 in n y; do=0A             =
   for c42 in \  \#; do=0A                  for v42 in n y; do=0A          =
          (( i++ ))=0A                    echo -e "test $i: ${c3}vers3=3D$v=
3 ${c4}vers4=3D$v4 ${c40}vers4.0=3D$v40 ${c41}vers4.1=3D$v41 ${c42}vers4.2=
=3D$v42"=0A                    echo -e "[nfsd]\n${c3}vers3=3D$v3\n${c4}vers=
4=3D$v4\n${c40}vers4.0=3D$v40\n${c41}vers4.1=3D$v41\n${c42}vers4.2=3D$v42" =
>/etc/nfs.conf=0A		    reset=0A                    check=0A		  done=0A		don=
e=0A              done=0A	    done=0A	  done=0A	done=0A      done=0A    don=
e=0A  done=0Adone=0A
--XC11gdYd2UEiHAlz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="test.out"

test 1:  vers3=n  vers4=n  vers4.0=n  vers4.1=n  vers4.2=n
nfsd: no version specified
nfsdctl: no version specified

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
 vers4.0=n
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 2:  vers3=n  vers4=n  vers4.0=n  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
 vers4.0=n
 vers4.1=n
 vers4.2=y

nfsd:    -3.0 -4.0 -4.1 +4.2
nfsdctl: -3.0 -4.0 -4.1 +4.2

test 3:  vers3=n  vers4=n  vers4.0=n  vers4.1=n #vers4.2=n
nfsd: no version specified
nfsdctl: no version specified

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
 vers4.0=n
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 4:  vers3=n  vers4=n  vers4.0=n  vers4.1=n #vers4.2=y
nfsd: no version specified
nfsdctl: no version specified

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
 vers4.0=n
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 5:  vers3=n  vers4=n  vers4.0=n  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
 vers4.0=n
 vers4.1=y
 vers4.2=n

nfsd:    -3.0 -4.0 +4.1 -4.2
nfsdctl: -3.0 -4.0 +4.1 -4.2

test 6:  vers3=n  vers4=n  vers4.0=n  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
 vers4.0=n
 vers4.1=y
 vers4.2=y

nfsd:    -3.0 -4.0 +4.1 +4.2
nfsdctl: -3.0 -4.0 +4.1 +4.2

test 7:  vers3=n  vers4=n  vers4.0=n  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
 vers4.0=n
 vers4.1=y
#vers4.2=n

nfsd:    -3.0 -4.0 +4.1 -4.2
nfsdctl: -3.0 -4.0 +4.1 -4.2

test 8:  vers3=n  vers4=n  vers4.0=n  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
 vers4.0=n
 vers4.1=y
#vers4.2=y

nfsd:    -3.0 -4.0 +4.1 -4.2
nfsdctl: -3.0 -4.0 +4.1 -4.2

test 9:  vers3=n  vers4=n  vers4.0=n #vers4.1=n  vers4.2=n
nfsd: no version specified
nfsdctl: no version specified

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
 vers4.0=n
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 10:  vers3=n  vers4=n  vers4.0=n #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
 vers4.0=n
#vers4.1=n
 vers4.2=y

nfsd:    -3.0 -4.0 -4.1 +4.2
nfsdctl: -3.0 -4.0 -4.1 +4.2

test 11:  vers3=n  vers4=n  vers4.0=n #vers4.1=n #vers4.2=n
nfsd: no version specified
nfsdctl: no version specified

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
 vers4.0=n
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 12:  vers3=n  vers4=n  vers4.0=n #vers4.1=n #vers4.2=y
nfsd: no version specified
nfsdctl: no version specified

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
 vers4.0=n
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 13:  vers3=n  vers4=n  vers4.0=n #vers4.1=y  vers4.2=n
nfsd: no version specified
nfsdctl: no version specified

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
 vers4.0=n
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 14:  vers3=n  vers4=n  vers4.0=n #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
 vers4.0=n
#vers4.1=y
 vers4.2=y

nfsd:    -3.0 -4.0 -4.1 +4.2
nfsdctl: -3.0 -4.0 -4.1 +4.2

test 15:  vers3=n  vers4=n  vers4.0=n #vers4.1=y #vers4.2=n
nfsd: no version specified
nfsdctl: no version specified

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
 vers4.0=n
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 16:  vers3=n  vers4=n  vers4.0=n #vers4.1=y #vers4.2=y
nfsd: no version specified
nfsdctl: no version specified

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
 vers4.0=n
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 17:  vers3=n  vers4=n  vers4.0=y  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
 vers4.0=y
 vers4.1=n
 vers4.2=n

nfsd:    -3.0 +4.0 -4.1 -4.2
nfsdctl: -3.0 +4.0 -4.1 -4.2

test 18:  vers3=n  vers4=n  vers4.0=y  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
 vers4.0=y
 vers4.1=n
 vers4.2=y

nfsd:    -3.0 +4.0 -4.1 +4.2
nfsdctl: -3.0 +4.0 -4.1 +4.2

test 19:  vers3=n  vers4=n  vers4.0=y  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
 vers4.0=y
 vers4.1=n
#vers4.2=n

nfsd:    -3.0 +4.0 -4.1 -4.2
nfsdctl: -3.0 +4.0 -4.1 -4.2

test 20:  vers3=n  vers4=n  vers4.0=y  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
 vers4.0=y
 vers4.1=n
#vers4.2=y

nfsd:    -3.0 +4.0 -4.1 -4.2
nfsdctl: -3.0 +4.0 -4.1 -4.2

test 21:  vers3=n  vers4=n  vers4.0=y  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
 vers4.0=y
 vers4.1=y
 vers4.2=n

nfsd:    -3.0 +4.0 +4.1 -4.2
nfsdctl: -3.0 +4.0 +4.1 -4.2

test 22:  vers3=n  vers4=n  vers4.0=y  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
 vers4.0=y
 vers4.1=y
 vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 23:  vers3=n  vers4=n  vers4.0=y  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
 vers4.0=y
 vers4.1=y
#vers4.2=n

nfsd:    -3.0 +4.0 +4.1 -4.2
nfsdctl: -3.0 +4.0 +4.1 -4.2

test 24:  vers3=n  vers4=n  vers4.0=y  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
 vers4.0=y
 vers4.1=y
#vers4.2=y

nfsd:    -3.0 +4.0 +4.1 -4.2
nfsdctl: -3.0 +4.0 +4.1 -4.2

test 25:  vers3=n  vers4=n  vers4.0=y #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
 vers4.0=y
#vers4.1=n
 vers4.2=n

nfsd:    -3.0 +4.0 -4.1 -4.2
nfsdctl: -3.0 +4.0 -4.1 -4.2

test 26:  vers3=n  vers4=n  vers4.0=y #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
 vers4.0=y
#vers4.1=n
 vers4.2=y

nfsd:    -3.0 +4.0 -4.1 +4.2
nfsdctl: -3.0 +4.0 -4.1 +4.2

test 27:  vers3=n  vers4=n  vers4.0=y #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
 vers4.0=y
#vers4.1=n
#vers4.2=n

nfsd:    -3.0 +4.0 -4.1 -4.2
nfsdctl: -3.0 +4.0 -4.1 -4.2

test 28:  vers3=n  vers4=n  vers4.0=y #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
 vers4.0=y
#vers4.1=n
#vers4.2=y

nfsd:    -3.0 +4.0 -4.1 -4.2
nfsdctl: -3.0 +4.0 -4.1 -4.2

test 29:  vers3=n  vers4=n  vers4.0=y #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
 vers4.0=y
#vers4.1=y
 vers4.2=n

nfsd:    -3.0 +4.0 -4.1 -4.2
nfsdctl: -3.0 +4.0 -4.1 -4.2

test 30:  vers3=n  vers4=n  vers4.0=y #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
 vers4.0=y
#vers4.1=y
 vers4.2=y

nfsd:    -3.0 +4.0 -4.1 +4.2
nfsdctl: -3.0 +4.0 -4.1 +4.2

test 31:  vers3=n  vers4=n  vers4.0=y #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
 vers4.0=y
#vers4.1=y
#vers4.2=n

nfsd:    -3.0 +4.0 -4.1 -4.2
nfsdctl: -3.0 +4.0 -4.1 -4.2

test 32:  vers3=n  vers4=n  vers4.0=y #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
 vers4.0=y
#vers4.1=y
#vers4.2=y

nfsd:    -3.0 +4.0 -4.1 -4.2
nfsdctl: -3.0 +4.0 -4.1 -4.2

test 33:  vers3=n  vers4=n #vers4.0=n  vers4.1=n  vers4.2=n
nfsd: no version specified
nfsdctl: no version specified

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
#vers4.0=n
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 34:  vers3=n  vers4=n #vers4.0=n  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
#vers4.0=n
 vers4.1=n
 vers4.2=y

nfsd:    -3.0 -4.0 -4.1 +4.2
nfsdctl: -3.0 -4.0 -4.1 +4.2

test 35:  vers3=n  vers4=n #vers4.0=n  vers4.1=n #vers4.2=n
nfsd: no version specified
nfsdctl: no version specified

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
#vers4.0=n
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 36:  vers3=n  vers4=n #vers4.0=n  vers4.1=n #vers4.2=y
nfsd: no version specified
nfsdctl: no version specified

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
#vers4.0=n
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 37:  vers3=n  vers4=n #vers4.0=n  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
#vers4.0=n
 vers4.1=y
 vers4.2=n

nfsd:    -3.0 -4.0 +4.1 -4.2
nfsdctl: -3.0 -4.0 +4.1 -4.2

test 38:  vers3=n  vers4=n #vers4.0=n  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
#vers4.0=n
 vers4.1=y
 vers4.2=y

nfsd:    -3.0 -4.0 +4.1 +4.2
nfsdctl: -3.0 -4.0 +4.1 +4.2

test 39:  vers3=n  vers4=n #vers4.0=n  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
#vers4.0=n
 vers4.1=y
#vers4.2=n

nfsd:    -3.0 -4.0 +4.1 -4.2
nfsdctl: -3.0 -4.0 +4.1 -4.2

test 40:  vers3=n  vers4=n #vers4.0=n  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
#vers4.0=n
 vers4.1=y
#vers4.2=y

nfsd:    -3.0 -4.0 +4.1 -4.2
nfsdctl: -3.0 -4.0 +4.1 -4.2

test 41:  vers3=n  vers4=n #vers4.0=n #vers4.1=n  vers4.2=n
nfsd: no version specified
nfsdctl: no version specified

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
#vers4.0=n
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 42:  vers3=n  vers4=n #vers4.0=n #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
#vers4.0=n
#vers4.1=n
 vers4.2=y

nfsd:    -3.0 -4.0 -4.1 +4.2
nfsdctl: -3.0 -4.0 -4.1 +4.2

test 43:  vers3=n  vers4=n #vers4.0=n #vers4.1=n #vers4.2=n
nfsd: no version specified
nfsdctl: no version specified

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
#vers4.0=n
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 44:  vers3=n  vers4=n #vers4.0=n #vers4.1=n #vers4.2=y
nfsd: no version specified
nfsdctl: no version specified

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
#vers4.0=n
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 45:  vers3=n  vers4=n #vers4.0=n #vers4.1=y  vers4.2=n
nfsd: no version specified
nfsdctl: no version specified

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
#vers4.0=n
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 46:  vers3=n  vers4=n #vers4.0=n #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
#vers4.0=n
#vers4.1=y
 vers4.2=y

nfsd:    -3.0 -4.0 -4.1 +4.2
nfsdctl: -3.0 -4.0 -4.1 +4.2

test 47:  vers3=n  vers4=n #vers4.0=n #vers4.1=y #vers4.2=n
nfsd: no version specified
nfsdctl: no version specified

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
#vers4.0=n
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 48:  vers3=n  vers4=n #vers4.0=n #vers4.1=y #vers4.2=y
nfsd: no version specified
nfsdctl: no version specified

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
#vers4.0=n
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 49:  vers3=n  vers4=n #vers4.0=y  vers4.1=n  vers4.2=n
nfsd: no version specified
nfsdctl: no version specified

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
#vers4.0=y
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 50:  vers3=n  vers4=n #vers4.0=y  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
#vers4.0=y
 vers4.1=n
 vers4.2=y

nfsd:    -3.0 -4.0 -4.1 +4.2
nfsdctl: -3.0 -4.0 -4.1 +4.2

test 51:  vers3=n  vers4=n #vers4.0=y  vers4.1=n #vers4.2=n
nfsd: no version specified
nfsdctl: no version specified

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
#vers4.0=y
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 52:  vers3=n  vers4=n #vers4.0=y  vers4.1=n #vers4.2=y
nfsd: no version specified
nfsdctl: no version specified

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
#vers4.0=y
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 53:  vers3=n  vers4=n #vers4.0=y  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
#vers4.0=y
 vers4.1=y
 vers4.2=n

nfsd:    -3.0 -4.0 +4.1 -4.2
nfsdctl: -3.0 -4.0 +4.1 -4.2

test 54:  vers3=n  vers4=n #vers4.0=y  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
#vers4.0=y
 vers4.1=y
 vers4.2=y

nfsd:    -3.0 -4.0 +4.1 +4.2
nfsdctl: -3.0 -4.0 +4.1 +4.2

test 55:  vers3=n  vers4=n #vers4.0=y  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
#vers4.0=y
 vers4.1=y
#vers4.2=n

nfsd:    -3.0 -4.0 +4.1 -4.2
nfsdctl: -3.0 -4.0 +4.1 -4.2

test 56:  vers3=n  vers4=n #vers4.0=y  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
#vers4.0=y
 vers4.1=y
#vers4.2=y

nfsd:    -3.0 -4.0 +4.1 -4.2
nfsdctl: -3.0 -4.0 +4.1 -4.2

test 57:  vers3=n  vers4=n #vers4.0=y #vers4.1=n  vers4.2=n
nfsd: no version specified
nfsdctl: no version specified

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
#vers4.0=y
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 58:  vers3=n  vers4=n #vers4.0=y #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
#vers4.0=y
#vers4.1=n
 vers4.2=y

nfsd:    -3.0 -4.0 -4.1 +4.2
nfsdctl: -3.0 -4.0 -4.1 +4.2

test 59:  vers3=n  vers4=n #vers4.0=y #vers4.1=n #vers4.2=n
nfsd: no version specified
nfsdctl: no version specified

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
#vers4.0=y
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 60:  vers3=n  vers4=n #vers4.0=y #vers4.1=n #vers4.2=y
nfsd: no version specified
nfsdctl: no version specified

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
#vers4.0=y
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 61:  vers3=n  vers4=n #vers4.0=y #vers4.1=y  vers4.2=n
nfsd: no version specified
nfsdctl: no version specified

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
#vers4.0=y
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 62:  vers3=n  vers4=n #vers4.0=y #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
#vers4.0=y
#vers4.1=y
 vers4.2=y

nfsd:    -3.0 -4.0 -4.1 +4.2
nfsdctl: -3.0 -4.0 -4.1 +4.2

test 63:  vers3=n  vers4=n #vers4.0=y #vers4.1=y #vers4.2=n
nfsd: no version specified
nfsdctl: no version specified

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
#vers4.0=y
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 64:  vers3=n  vers4=n #vers4.0=y #vers4.1=y #vers4.2=y
nfsd: no version specified
nfsdctl: no version specified

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=n
#vers4.0=y
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 65:  vers3=n  vers4=y  vers4.0=n  vers4.1=n  vers4.2=n
nfsd: no version specified
nfsdctl: no version specified

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
 vers4.0=n
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 66:  vers3=n  vers4=y  vers4.0=n  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
 vers4.0=n
 vers4.1=n
 vers4.2=y

nfsd:    -3.0 -4.0 -4.1 +4.2
nfsdctl: -3.0 -4.0 -4.1 +4.2

test 67:  vers3=n  vers4=y  vers4.0=n  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
 vers4.0=n
 vers4.1=n
#vers4.2=n

nfsd:    -3.0 -4.0 -4.1 +4.2
nfsdctl: -3.0 -4.0 -4.1 +4.2

test 68:  vers3=n  vers4=y  vers4.0=n  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
 vers4.0=n
 vers4.1=n
#vers4.2=y

nfsd:    -3.0 -4.0 -4.1 +4.2
nfsdctl: -3.0 -4.0 -4.1 +4.2

test 69:  vers3=n  vers4=y  vers4.0=n  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
 vers4.0=n
 vers4.1=y
 vers4.2=n

nfsd:    -3.0 -4.0 +4.1 -4.2
nfsdctl: -3.0 -4.0 +4.1 -4.2

test 70:  vers3=n  vers4=y  vers4.0=n  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
 vers4.0=n
 vers4.1=y
 vers4.2=y

nfsd:    -3.0 -4.0 +4.1 +4.2
nfsdctl: -3.0 -4.0 +4.1 +4.2

test 71:  vers3=n  vers4=y  vers4.0=n  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
 vers4.0=n
 vers4.1=y
#vers4.2=n

nfsd:    -3.0 -4.0 +4.1 +4.2
nfsdctl: -3.0 -4.0 +4.1 +4.2

test 72:  vers3=n  vers4=y  vers4.0=n  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
 vers4.0=n
 vers4.1=y
#vers4.2=y

nfsd:    -3.0 -4.0 +4.1 +4.2
nfsdctl: -3.0 -4.0 +4.1 +4.2

test 73:  vers3=n  vers4=y  vers4.0=n #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
 vers4.0=n
#vers4.1=n
 vers4.2=n

nfsd:    -3.0 -4.0 +4.1 -4.2
nfsdctl: -3.0 -4.0 +4.1 -4.2

test 74:  vers3=n  vers4=y  vers4.0=n #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
 vers4.0=n
#vers4.1=n
 vers4.2=y

nfsd:    -3.0 -4.0 +4.1 +4.2
nfsdctl: -3.0 -4.0 +4.1 +4.2

test 75:  vers3=n  vers4=y  vers4.0=n #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
 vers4.0=n
#vers4.1=n
#vers4.2=n

nfsd:    -3.0 -4.0 +4.1 +4.2
nfsdctl: -3.0 -4.0 +4.1 +4.2

test 76:  vers3=n  vers4=y  vers4.0=n #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
 vers4.0=n
#vers4.1=n
#vers4.2=y

nfsd:    -3.0 -4.0 +4.1 +4.2
nfsdctl: -3.0 -4.0 +4.1 +4.2

test 77:  vers3=n  vers4=y  vers4.0=n #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
 vers4.0=n
#vers4.1=y
 vers4.2=n

nfsd:    -3.0 -4.0 +4.1 -4.2
nfsdctl: -3.0 -4.0 +4.1 -4.2

test 78:  vers3=n  vers4=y  vers4.0=n #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
 vers4.0=n
#vers4.1=y
 vers4.2=y

nfsd:    -3.0 -4.0 +4.1 +4.2
nfsdctl: -3.0 -4.0 +4.1 +4.2

test 79:  vers3=n  vers4=y  vers4.0=n #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
 vers4.0=n
#vers4.1=y
#vers4.2=n

nfsd:    -3.0 -4.0 +4.1 +4.2
nfsdctl: -3.0 -4.0 +4.1 +4.2

test 80:  vers3=n  vers4=y  vers4.0=n #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
 vers4.0=n
#vers4.1=y
#vers4.2=y

nfsd:    -3.0 -4.0 +4.1 +4.2
nfsdctl: -3.0 -4.0 +4.1 +4.2

test 81:  vers3=n  vers4=y  vers4.0=y  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
 vers4.0=y
 vers4.1=n
 vers4.2=n

nfsd:    -3.0 +4.0 -4.1 -4.2
nfsdctl: -3.0 +4.0 -4.1 -4.2

test 82:  vers3=n  vers4=y  vers4.0=y  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
 vers4.0=y
 vers4.1=n
 vers4.2=y

nfsd:    -3.0 +4.0 -4.1 +4.2
nfsdctl: -3.0 +4.0 -4.1 +4.2

test 83:  vers3=n  vers4=y  vers4.0=y  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
 vers4.0=y
 vers4.1=n
#vers4.2=n

nfsd:    -3.0 +4.0 -4.1 +4.2
nfsdctl: -3.0 +4.0 -4.1 +4.2

test 84:  vers3=n  vers4=y  vers4.0=y  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
 vers4.0=y
 vers4.1=n
#vers4.2=y

nfsd:    -3.0 +4.0 -4.1 +4.2
nfsdctl: -3.0 +4.0 -4.1 +4.2

test 85:  vers3=n  vers4=y  vers4.0=y  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
 vers4.0=y
 vers4.1=y
 vers4.2=n

nfsd:    -3.0 +4.0 +4.1 -4.2
nfsdctl: -3.0 +4.0 +4.1 -4.2

test 86:  vers3=n  vers4=y  vers4.0=y  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
 vers4.0=y
 vers4.1=y
 vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 87:  vers3=n  vers4=y  vers4.0=y  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
 vers4.0=y
 vers4.1=y
#vers4.2=n

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 88:  vers3=n  vers4=y  vers4.0=y  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
 vers4.0=y
 vers4.1=y
#vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 89:  vers3=n  vers4=y  vers4.0=y #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
 vers4.0=y
#vers4.1=n
 vers4.2=n

nfsd:    -3.0 +4.0 +4.1 -4.2
nfsdctl: -3.0 +4.0 +4.1 -4.2

test 90:  vers3=n  vers4=y  vers4.0=y #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
 vers4.0=y
#vers4.1=n
 vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 91:  vers3=n  vers4=y  vers4.0=y #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
 vers4.0=y
#vers4.1=n
#vers4.2=n

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 92:  vers3=n  vers4=y  vers4.0=y #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
 vers4.0=y
#vers4.1=n
#vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 93:  vers3=n  vers4=y  vers4.0=y #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
 vers4.0=y
#vers4.1=y
 vers4.2=n

nfsd:    -3.0 +4.0 +4.1 -4.2
nfsdctl: -3.0 +4.0 +4.1 -4.2

test 94:  vers3=n  vers4=y  vers4.0=y #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
 vers4.0=y
#vers4.1=y
 vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 95:  vers3=n  vers4=y  vers4.0=y #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
 vers4.0=y
#vers4.1=y
#vers4.2=n

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 96:  vers3=n  vers4=y  vers4.0=y #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
 vers4.0=y
#vers4.1=y
#vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 97:  vers3=n  vers4=y #vers4.0=n  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
#vers4.0=n
 vers4.1=n
 vers4.2=n

nfsd:    -3.0 +4.0 -4.1 -4.2
nfsdctl: -3.0 +4.0 -4.1 -4.2

test 98:  vers3=n  vers4=y #vers4.0=n  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
#vers4.0=n
 vers4.1=n
 vers4.2=y

nfsd:    -3.0 +4.0 -4.1 +4.2
nfsdctl: -3.0 +4.0 -4.1 +4.2

test 99:  vers3=n  vers4=y #vers4.0=n  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
#vers4.0=n
 vers4.1=n
#vers4.2=n

nfsd:    -3.0 +4.0 -4.1 +4.2
nfsdctl: -3.0 +4.0 -4.1 +4.2

test 100:  vers3=n  vers4=y #vers4.0=n  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
#vers4.0=n
 vers4.1=n
#vers4.2=y

nfsd:    -3.0 +4.0 -4.1 +4.2
nfsdctl: -3.0 +4.0 -4.1 +4.2

test 101:  vers3=n  vers4=y #vers4.0=n  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
#vers4.0=n
 vers4.1=y
 vers4.2=n

nfsd:    -3.0 +4.0 +4.1 -4.2
nfsdctl: -3.0 +4.0 +4.1 -4.2

test 102:  vers3=n  vers4=y #vers4.0=n  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
#vers4.0=n
 vers4.1=y
 vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 103:  vers3=n  vers4=y #vers4.0=n  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
#vers4.0=n
 vers4.1=y
#vers4.2=n

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 104:  vers3=n  vers4=y #vers4.0=n  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
#vers4.0=n
 vers4.1=y
#vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 105:  vers3=n  vers4=y #vers4.0=n #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
#vers4.0=n
#vers4.1=n
 vers4.2=n

nfsd:    -3.0 +4.0 +4.1 -4.2
nfsdctl: -3.0 +4.0 +4.1 -4.2

test 106:  vers3=n  vers4=y #vers4.0=n #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
#vers4.0=n
#vers4.1=n
 vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 107:  vers3=n  vers4=y #vers4.0=n #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
#vers4.0=n
#vers4.1=n
#vers4.2=n

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 108:  vers3=n  vers4=y #vers4.0=n #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
#vers4.0=n
#vers4.1=n
#vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 109:  vers3=n  vers4=y #vers4.0=n #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
#vers4.0=n
#vers4.1=y
 vers4.2=n

nfsd:    -3.0 +4.0 +4.1 -4.2
nfsdctl: -3.0 +4.0 +4.1 -4.2

test 110:  vers3=n  vers4=y #vers4.0=n #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
#vers4.0=n
#vers4.1=y
 vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 111:  vers3=n  vers4=y #vers4.0=n #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
#vers4.0=n
#vers4.1=y
#vers4.2=n

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 112:  vers3=n  vers4=y #vers4.0=n #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
#vers4.0=n
#vers4.1=y
#vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 113:  vers3=n  vers4=y #vers4.0=y  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
#vers4.0=y
 vers4.1=n
 vers4.2=n

nfsd:    -3.0 +4.0 -4.1 -4.2
nfsdctl: -3.0 +4.0 -4.1 -4.2

test 114:  vers3=n  vers4=y #vers4.0=y  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
#vers4.0=y
 vers4.1=n
 vers4.2=y

nfsd:    -3.0 +4.0 -4.1 +4.2
nfsdctl: -3.0 +4.0 -4.1 +4.2

test 115:  vers3=n  vers4=y #vers4.0=y  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
#vers4.0=y
 vers4.1=n
#vers4.2=n

nfsd:    -3.0 +4.0 -4.1 +4.2
nfsdctl: -3.0 +4.0 -4.1 +4.2

test 116:  vers3=n  vers4=y #vers4.0=y  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
#vers4.0=y
 vers4.1=n
#vers4.2=y

nfsd:    -3.0 +4.0 -4.1 +4.2
nfsdctl: -3.0 +4.0 -4.1 +4.2

test 117:  vers3=n  vers4=y #vers4.0=y  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
#vers4.0=y
 vers4.1=y
 vers4.2=n

nfsd:    -3.0 +4.0 +4.1 -4.2
nfsdctl: -3.0 +4.0 +4.1 -4.2

test 118:  vers3=n  vers4=y #vers4.0=y  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
#vers4.0=y
 vers4.1=y
 vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 119:  vers3=n  vers4=y #vers4.0=y  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
#vers4.0=y
 vers4.1=y
#vers4.2=n

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 120:  vers3=n  vers4=y #vers4.0=y  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
#vers4.0=y
 vers4.1=y
#vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 121:  vers3=n  vers4=y #vers4.0=y #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
#vers4.0=y
#vers4.1=n
 vers4.2=n

nfsd:    -3.0 +4.0 +4.1 -4.2
nfsdctl: -3.0 +4.0 +4.1 -4.2

test 122:  vers3=n  vers4=y #vers4.0=y #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
#vers4.0=y
#vers4.1=n
 vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 123:  vers3=n  vers4=y #vers4.0=y #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
#vers4.0=y
#vers4.1=n
#vers4.2=n

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 124:  vers3=n  vers4=y #vers4.0=y #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
#vers4.0=y
#vers4.1=n
#vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 125:  vers3=n  vers4=y #vers4.0=y #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
#vers4.0=y
#vers4.1=y
 vers4.2=n

nfsd:    -3.0 +4.0 +4.1 -4.2
nfsdctl: -3.0 +4.0 +4.1 -4.2

test 126:  vers3=n  vers4=y #vers4.0=y #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
#vers4.0=y
#vers4.1=y
 vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 127:  vers3=n  vers4=y #vers4.0=y #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
#vers4.0=y
#vers4.1=y
#vers4.2=n

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 128:  vers3=n  vers4=y #vers4.0=y #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
 vers4=y
#vers4.0=y
#vers4.1=y
#vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 129:  vers3=n #vers4=n  vers4.0=n  vers4.1=n  vers4.2=n
nfsd: no version specified
nfsdctl: no version specified

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
 vers4.0=n
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 130:  vers3=n #vers4=n  vers4.0=n  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
 vers4.0=n
 vers4.1=n
 vers4.2=y

nfsd:    -3.0 -4.0 -4.1 +4.2
nfsdctl: -3.0 -4.0 -4.1 +4.2

test 131:  vers3=n #vers4=n  vers4.0=n  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
 vers4.0=n
 vers4.1=n
#vers4.2=n

nfsd:    -3.0 -4.0 -4.1 +4.2
nfsdctl: -3.0 -4.0 -4.1 +4.2

test 132:  vers3=n #vers4=n  vers4.0=n  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
 vers4.0=n
 vers4.1=n
#vers4.2=y

nfsd:    -3.0 -4.0 -4.1 +4.2
nfsdctl: -3.0 -4.0 -4.1 +4.2

test 133:  vers3=n #vers4=n  vers4.0=n  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
 vers4.0=n
 vers4.1=y
 vers4.2=n

nfsd:    -3.0 -4.0 +4.1 -4.2
nfsdctl: -3.0 -4.0 +4.1 -4.2

test 134:  vers3=n #vers4=n  vers4.0=n  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
 vers4.0=n
 vers4.1=y
 vers4.2=y

nfsd:    -3.0 -4.0 +4.1 +4.2
nfsdctl: -3.0 -4.0 +4.1 +4.2

test 135:  vers3=n #vers4=n  vers4.0=n  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
 vers4.0=n
 vers4.1=y
#vers4.2=n

nfsd:    -3.0 -4.0 +4.1 +4.2
nfsdctl: -3.0 -4.0 +4.1 +4.2

test 136:  vers3=n #vers4=n  vers4.0=n  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
 vers4.0=n
 vers4.1=y
#vers4.2=y

nfsd:    -3.0 -4.0 +4.1 +4.2
nfsdctl: -3.0 -4.0 +4.1 +4.2

test 137:  vers3=n #vers4=n  vers4.0=n #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
 vers4.0=n
#vers4.1=n
 vers4.2=n

nfsd:    -3.0 -4.0 +4.1 -4.2
nfsdctl: -3.0 -4.0 +4.1 -4.2

test 138:  vers3=n #vers4=n  vers4.0=n #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
 vers4.0=n
#vers4.1=n
 vers4.2=y

nfsd:    -3.0 -4.0 +4.1 +4.2
nfsdctl: -3.0 -4.0 +4.1 +4.2

test 139:  vers3=n #vers4=n  vers4.0=n #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
 vers4.0=n
#vers4.1=n
#vers4.2=n

nfsd:    -3.0 -4.0 +4.1 +4.2
nfsdctl: -3.0 -4.0 +4.1 +4.2

test 140:  vers3=n #vers4=n  vers4.0=n #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
 vers4.0=n
#vers4.1=n
#vers4.2=y

nfsd:    -3.0 -4.0 +4.1 +4.2
nfsdctl: -3.0 -4.0 +4.1 +4.2

test 141:  vers3=n #vers4=n  vers4.0=n #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
 vers4.0=n
#vers4.1=y
 vers4.2=n

nfsd:    -3.0 -4.0 +4.1 -4.2
nfsdctl: -3.0 -4.0 +4.1 -4.2

test 142:  vers3=n #vers4=n  vers4.0=n #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
 vers4.0=n
#vers4.1=y
 vers4.2=y

nfsd:    -3.0 -4.0 +4.1 +4.2
nfsdctl: -3.0 -4.0 +4.1 +4.2

test 143:  vers3=n #vers4=n  vers4.0=n #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
 vers4.0=n
#vers4.1=y
#vers4.2=n

nfsd:    -3.0 -4.0 +4.1 +4.2
nfsdctl: -3.0 -4.0 +4.1 +4.2

test 144:  vers3=n #vers4=n  vers4.0=n #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
 vers4.0=n
#vers4.1=y
#vers4.2=y

nfsd:    -3.0 -4.0 +4.1 +4.2
nfsdctl: -3.0 -4.0 +4.1 +4.2

test 145:  vers3=n #vers4=n  vers4.0=y  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
 vers4.0=y
 vers4.1=n
 vers4.2=n

nfsd:    -3.0 +4.0 -4.1 -4.2
nfsdctl: -3.0 +4.0 -4.1 -4.2

test 146:  vers3=n #vers4=n  vers4.0=y  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
 vers4.0=y
 vers4.1=n
 vers4.2=y

nfsd:    -3.0 +4.0 -4.1 +4.2
nfsdctl: -3.0 +4.0 -4.1 +4.2

test 147:  vers3=n #vers4=n  vers4.0=y  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
 vers4.0=y
 vers4.1=n
#vers4.2=n

nfsd:    -3.0 +4.0 -4.1 +4.2
nfsdctl: -3.0 +4.0 -4.1 +4.2

test 148:  vers3=n #vers4=n  vers4.0=y  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
 vers4.0=y
 vers4.1=n
#vers4.2=y

nfsd:    -3.0 +4.0 -4.1 +4.2
nfsdctl: -3.0 +4.0 -4.1 +4.2

test 149:  vers3=n #vers4=n  vers4.0=y  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
 vers4.0=y
 vers4.1=y
 vers4.2=n

nfsd:    -3.0 +4.0 +4.1 -4.2
nfsdctl: -3.0 +4.0 +4.1 -4.2

test 150:  vers3=n #vers4=n  vers4.0=y  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
 vers4.0=y
 vers4.1=y
 vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 151:  vers3=n #vers4=n  vers4.0=y  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
 vers4.0=y
 vers4.1=y
#vers4.2=n

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 152:  vers3=n #vers4=n  vers4.0=y  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
 vers4.0=y
 vers4.1=y
#vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 153:  vers3=n #vers4=n  vers4.0=y #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
 vers4.0=y
#vers4.1=n
 vers4.2=n

nfsd:    -3.0 +4.0 +4.1 -4.2
nfsdctl: -3.0 +4.0 +4.1 -4.2

test 154:  vers3=n #vers4=n  vers4.0=y #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
 vers4.0=y
#vers4.1=n
 vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 155:  vers3=n #vers4=n  vers4.0=y #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
 vers4.0=y
#vers4.1=n
#vers4.2=n

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 156:  vers3=n #vers4=n  vers4.0=y #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
 vers4.0=y
#vers4.1=n
#vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 157:  vers3=n #vers4=n  vers4.0=y #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
 vers4.0=y
#vers4.1=y
 vers4.2=n

nfsd:    -3.0 +4.0 +4.1 -4.2
nfsdctl: -3.0 +4.0 +4.1 -4.2

test 158:  vers3=n #vers4=n  vers4.0=y #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
 vers4.0=y
#vers4.1=y
 vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 159:  vers3=n #vers4=n  vers4.0=y #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
 vers4.0=y
#vers4.1=y
#vers4.2=n

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 160:  vers3=n #vers4=n  vers4.0=y #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
 vers4.0=y
#vers4.1=y
#vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 161:  vers3=n #vers4=n #vers4.0=n  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
#vers4.0=n
 vers4.1=n
 vers4.2=n

nfsd:    -3.0 +4.0 -4.1 -4.2
nfsdctl: -3.0 +4.0 -4.1 -4.2

test 162:  vers3=n #vers4=n #vers4.0=n  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
#vers4.0=n
 vers4.1=n
 vers4.2=y

nfsd:    -3.0 +4.0 -4.1 +4.2
nfsdctl: -3.0 +4.0 -4.1 +4.2

test 163:  vers3=n #vers4=n #vers4.0=n  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
#vers4.0=n
 vers4.1=n
#vers4.2=n

nfsd:    -3.0 +4.0 -4.1 +4.2
nfsdctl: -3.0 +4.0 -4.1 +4.2

test 164:  vers3=n #vers4=n #vers4.0=n  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
#vers4.0=n
 vers4.1=n
#vers4.2=y

nfsd:    -3.0 +4.0 -4.1 +4.2
nfsdctl: -3.0 +4.0 -4.1 +4.2

test 165:  vers3=n #vers4=n #vers4.0=n  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
#vers4.0=n
 vers4.1=y
 vers4.2=n

nfsd:    -3.0 +4.0 +4.1 -4.2
nfsdctl: -3.0 +4.0 +4.1 -4.2

test 166:  vers3=n #vers4=n #vers4.0=n  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
#vers4.0=n
 vers4.1=y
 vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 167:  vers3=n #vers4=n #vers4.0=n  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
#vers4.0=n
 vers4.1=y
#vers4.2=n

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 168:  vers3=n #vers4=n #vers4.0=n  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
#vers4.0=n
 vers4.1=y
#vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 169:  vers3=n #vers4=n #vers4.0=n #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
#vers4.0=n
#vers4.1=n
 vers4.2=n

nfsd:    -3.0 +4.0 +4.1 -4.2
nfsdctl: -3.0 +4.0 +4.1 -4.2

test 170:  vers3=n #vers4=n #vers4.0=n #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
#vers4.0=n
#vers4.1=n
 vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 171:  vers3=n #vers4=n #vers4.0=n #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
#vers4.0=n
#vers4.1=n
#vers4.2=n

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 172:  vers3=n #vers4=n #vers4.0=n #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
#vers4.0=n
#vers4.1=n
#vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 173:  vers3=n #vers4=n #vers4.0=n #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
#vers4.0=n
#vers4.1=y
 vers4.2=n

nfsd:    -3.0 +4.0 +4.1 -4.2
nfsdctl: -3.0 +4.0 +4.1 -4.2

test 174:  vers3=n #vers4=n #vers4.0=n #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
#vers4.0=n
#vers4.1=y
 vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 175:  vers3=n #vers4=n #vers4.0=n #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
#vers4.0=n
#vers4.1=y
#vers4.2=n

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 176:  vers3=n #vers4=n #vers4.0=n #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
#vers4.0=n
#vers4.1=y
#vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 177:  vers3=n #vers4=n #vers4.0=y  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
#vers4.0=y
 vers4.1=n
 vers4.2=n

nfsd:    -3.0 +4.0 -4.1 -4.2
nfsdctl: -3.0 +4.0 -4.1 -4.2

test 178:  vers3=n #vers4=n #vers4.0=y  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
#vers4.0=y
 vers4.1=n
 vers4.2=y

nfsd:    -3.0 +4.0 -4.1 +4.2
nfsdctl: -3.0 +4.0 -4.1 +4.2

test 179:  vers3=n #vers4=n #vers4.0=y  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
#vers4.0=y
 vers4.1=n
#vers4.2=n

nfsd:    -3.0 +4.0 -4.1 +4.2
nfsdctl: -3.0 +4.0 -4.1 +4.2

test 180:  vers3=n #vers4=n #vers4.0=y  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
#vers4.0=y
 vers4.1=n
#vers4.2=y

nfsd:    -3.0 +4.0 -4.1 +4.2
nfsdctl: -3.0 +4.0 -4.1 +4.2

test 181:  vers3=n #vers4=n #vers4.0=y  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
#vers4.0=y
 vers4.1=y
 vers4.2=n

nfsd:    -3.0 +4.0 +4.1 -4.2
nfsdctl: -3.0 +4.0 +4.1 -4.2

test 182:  vers3=n #vers4=n #vers4.0=y  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
#vers4.0=y
 vers4.1=y
 vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 183:  vers3=n #vers4=n #vers4.0=y  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
#vers4.0=y
 vers4.1=y
#vers4.2=n

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 184:  vers3=n #vers4=n #vers4.0=y  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
#vers4.0=y
 vers4.1=y
#vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 185:  vers3=n #vers4=n #vers4.0=y #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
#vers4.0=y
#vers4.1=n
 vers4.2=n

nfsd:    -3.0 +4.0 +4.1 -4.2
nfsdctl: -3.0 +4.0 +4.1 -4.2

test 186:  vers3=n #vers4=n #vers4.0=y #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
#vers4.0=y
#vers4.1=n
 vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 187:  vers3=n #vers4=n #vers4.0=y #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
#vers4.0=y
#vers4.1=n
#vers4.2=n

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 188:  vers3=n #vers4=n #vers4.0=y #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
#vers4.0=y
#vers4.1=n
#vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 189:  vers3=n #vers4=n #vers4.0=y #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
#vers4.0=y
#vers4.1=y
 vers4.2=n

nfsd:    -3.0 +4.0 +4.1 -4.2
nfsdctl: -3.0 +4.0 +4.1 -4.2

test 190:  vers3=n #vers4=n #vers4.0=y #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
#vers4.0=y
#vers4.1=y
 vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 191:  vers3=n #vers4=n #vers4.0=y #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
#vers4.0=y
#vers4.1=y
#vers4.2=n

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 192:  vers3=n #vers4=n #vers4.0=y #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=n
#vers4.0=y
#vers4.1=y
#vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 193:  vers3=n #vers4=y  vers4.0=n  vers4.1=n  vers4.2=n
nfsd: no version specified
nfsdctl: no version specified

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
 vers4.0=n
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 194:  vers3=n #vers4=y  vers4.0=n  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
 vers4.0=n
 vers4.1=n
 vers4.2=y

nfsd:    -3.0 -4.0 -4.1 +4.2
nfsdctl: -3.0 -4.0 -4.1 +4.2

test 195:  vers3=n #vers4=y  vers4.0=n  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
 vers4.0=n
 vers4.1=n
#vers4.2=n

nfsd:    -3.0 -4.0 -4.1 +4.2
nfsdctl: -3.0 -4.0 -4.1 +4.2

test 196:  vers3=n #vers4=y  vers4.0=n  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
 vers4.0=n
 vers4.1=n
#vers4.2=y

nfsd:    -3.0 -4.0 -4.1 +4.2
nfsdctl: -3.0 -4.0 -4.1 +4.2

test 197:  vers3=n #vers4=y  vers4.0=n  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
 vers4.0=n
 vers4.1=y
 vers4.2=n

nfsd:    -3.0 -4.0 +4.1 -4.2
nfsdctl: -3.0 -4.0 +4.1 -4.2

test 198:  vers3=n #vers4=y  vers4.0=n  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
 vers4.0=n
 vers4.1=y
 vers4.2=y

nfsd:    -3.0 -4.0 +4.1 +4.2
nfsdctl: -3.0 -4.0 +4.1 +4.2

test 199:  vers3=n #vers4=y  vers4.0=n  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
 vers4.0=n
 vers4.1=y
#vers4.2=n

nfsd:    -3.0 -4.0 +4.1 +4.2
nfsdctl: -3.0 -4.0 +4.1 +4.2

test 200:  vers3=n #vers4=y  vers4.0=n  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
 vers4.0=n
 vers4.1=y
#vers4.2=y

nfsd:    -3.0 -4.0 +4.1 +4.2
nfsdctl: -3.0 -4.0 +4.1 +4.2

test 201:  vers3=n #vers4=y  vers4.0=n #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
 vers4.0=n
#vers4.1=n
 vers4.2=n

nfsd:    -3.0 -4.0 +4.1 -4.2
nfsdctl: -3.0 -4.0 +4.1 -4.2

test 202:  vers3=n #vers4=y  vers4.0=n #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
 vers4.0=n
#vers4.1=n
 vers4.2=y

nfsd:    -3.0 -4.0 +4.1 +4.2
nfsdctl: -3.0 -4.0 +4.1 +4.2

test 203:  vers3=n #vers4=y  vers4.0=n #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
 vers4.0=n
#vers4.1=n
#vers4.2=n

nfsd:    -3.0 -4.0 +4.1 +4.2
nfsdctl: -3.0 -4.0 +4.1 +4.2

test 204:  vers3=n #vers4=y  vers4.0=n #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
 vers4.0=n
#vers4.1=n
#vers4.2=y

nfsd:    -3.0 -4.0 +4.1 +4.2
nfsdctl: -3.0 -4.0 +4.1 +4.2

test 205:  vers3=n #vers4=y  vers4.0=n #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
 vers4.0=n
#vers4.1=y
 vers4.2=n

nfsd:    -3.0 -4.0 +4.1 -4.2
nfsdctl: -3.0 -4.0 +4.1 -4.2

test 206:  vers3=n #vers4=y  vers4.0=n #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
 vers4.0=n
#vers4.1=y
 vers4.2=y

nfsd:    -3.0 -4.0 +4.1 +4.2
nfsdctl: -3.0 -4.0 +4.1 +4.2

test 207:  vers3=n #vers4=y  vers4.0=n #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
 vers4.0=n
#vers4.1=y
#vers4.2=n

nfsd:    -3.0 -4.0 +4.1 +4.2
nfsdctl: -3.0 -4.0 +4.1 +4.2

test 208:  vers3=n #vers4=y  vers4.0=n #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
 vers4.0=n
#vers4.1=y
#vers4.2=y

nfsd:    -3.0 -4.0 +4.1 +4.2
nfsdctl: -3.0 -4.0 +4.1 +4.2

test 209:  vers3=n #vers4=y  vers4.0=y  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
 vers4.0=y
 vers4.1=n
 vers4.2=n

nfsd:    -3.0 +4.0 -4.1 -4.2
nfsdctl: -3.0 +4.0 -4.1 -4.2

test 210:  vers3=n #vers4=y  vers4.0=y  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
 vers4.0=y
 vers4.1=n
 vers4.2=y

nfsd:    -3.0 +4.0 -4.1 +4.2
nfsdctl: -3.0 +4.0 -4.1 +4.2

test 211:  vers3=n #vers4=y  vers4.0=y  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
 vers4.0=y
 vers4.1=n
#vers4.2=n

nfsd:    -3.0 +4.0 -4.1 +4.2
nfsdctl: -3.0 +4.0 -4.1 +4.2

test 212:  vers3=n #vers4=y  vers4.0=y  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
 vers4.0=y
 vers4.1=n
#vers4.2=y

nfsd:    -3.0 +4.0 -4.1 +4.2
nfsdctl: -3.0 +4.0 -4.1 +4.2

test 213:  vers3=n #vers4=y  vers4.0=y  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
 vers4.0=y
 vers4.1=y
 vers4.2=n

nfsd:    -3.0 +4.0 +4.1 -4.2
nfsdctl: -3.0 +4.0 +4.1 -4.2

test 214:  vers3=n #vers4=y  vers4.0=y  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
 vers4.0=y
 vers4.1=y
 vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 215:  vers3=n #vers4=y  vers4.0=y  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
 vers4.0=y
 vers4.1=y
#vers4.2=n

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 216:  vers3=n #vers4=y  vers4.0=y  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
 vers4.0=y
 vers4.1=y
#vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 217:  vers3=n #vers4=y  vers4.0=y #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
 vers4.0=y
#vers4.1=n
 vers4.2=n

nfsd:    -3.0 +4.0 +4.1 -4.2
nfsdctl: -3.0 +4.0 +4.1 -4.2

test 218:  vers3=n #vers4=y  vers4.0=y #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
 vers4.0=y
#vers4.1=n
 vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 219:  vers3=n #vers4=y  vers4.0=y #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
 vers4.0=y
#vers4.1=n
#vers4.2=n

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 220:  vers3=n #vers4=y  vers4.0=y #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
 vers4.0=y
#vers4.1=n
#vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 221:  vers3=n #vers4=y  vers4.0=y #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
 vers4.0=y
#vers4.1=y
 vers4.2=n

nfsd:    -3.0 +4.0 +4.1 -4.2
nfsdctl: -3.0 +4.0 +4.1 -4.2

test 222:  vers3=n #vers4=y  vers4.0=y #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
 vers4.0=y
#vers4.1=y
 vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 223:  vers3=n #vers4=y  vers4.0=y #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
 vers4.0=y
#vers4.1=y
#vers4.2=n

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 224:  vers3=n #vers4=y  vers4.0=y #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
 vers4.0=y
#vers4.1=y
#vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 225:  vers3=n #vers4=y #vers4.0=n  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
#vers4.0=n
 vers4.1=n
 vers4.2=n

nfsd:    -3.0 +4.0 -4.1 -4.2
nfsdctl: -3.0 +4.0 -4.1 -4.2

test 226:  vers3=n #vers4=y #vers4.0=n  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
#vers4.0=n
 vers4.1=n
 vers4.2=y

nfsd:    -3.0 +4.0 -4.1 +4.2
nfsdctl: -3.0 +4.0 -4.1 +4.2

test 227:  vers3=n #vers4=y #vers4.0=n  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
#vers4.0=n
 vers4.1=n
#vers4.2=n

nfsd:    -3.0 +4.0 -4.1 +4.2
nfsdctl: -3.0 +4.0 -4.1 +4.2

test 228:  vers3=n #vers4=y #vers4.0=n  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
#vers4.0=n
 vers4.1=n
#vers4.2=y

nfsd:    -3.0 +4.0 -4.1 +4.2
nfsdctl: -3.0 +4.0 -4.1 +4.2

test 229:  vers3=n #vers4=y #vers4.0=n  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
#vers4.0=n
 vers4.1=y
 vers4.2=n

nfsd:    -3.0 +4.0 +4.1 -4.2
nfsdctl: -3.0 +4.0 +4.1 -4.2

test 230:  vers3=n #vers4=y #vers4.0=n  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
#vers4.0=n
 vers4.1=y
 vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 231:  vers3=n #vers4=y #vers4.0=n  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
#vers4.0=n
 vers4.1=y
#vers4.2=n

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 232:  vers3=n #vers4=y #vers4.0=n  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
#vers4.0=n
 vers4.1=y
#vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 233:  vers3=n #vers4=y #vers4.0=n #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
#vers4.0=n
#vers4.1=n
 vers4.2=n

nfsd:    -3.0 +4.0 +4.1 -4.2
nfsdctl: -3.0 +4.0 +4.1 -4.2

test 234:  vers3=n #vers4=y #vers4.0=n #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
#vers4.0=n
#vers4.1=n
 vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 235:  vers3=n #vers4=y #vers4.0=n #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
#vers4.0=n
#vers4.1=n
#vers4.2=n

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 236:  vers3=n #vers4=y #vers4.0=n #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
#vers4.0=n
#vers4.1=n
#vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 237:  vers3=n #vers4=y #vers4.0=n #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
#vers4.0=n
#vers4.1=y
 vers4.2=n

nfsd:    -3.0 +4.0 +4.1 -4.2
nfsdctl: -3.0 +4.0 +4.1 -4.2

test 238:  vers3=n #vers4=y #vers4.0=n #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
#vers4.0=n
#vers4.1=y
 vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 239:  vers3=n #vers4=y #vers4.0=n #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
#vers4.0=n
#vers4.1=y
#vers4.2=n

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 240:  vers3=n #vers4=y #vers4.0=n #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
#vers4.0=n
#vers4.1=y
#vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 241:  vers3=n #vers4=y #vers4.0=y  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
#vers4.0=y
 vers4.1=n
 vers4.2=n

nfsd:    -3.0 +4.0 -4.1 -4.2
nfsdctl: -3.0 +4.0 -4.1 -4.2

test 242:  vers3=n #vers4=y #vers4.0=y  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
#vers4.0=y
 vers4.1=n
 vers4.2=y

nfsd:    -3.0 +4.0 -4.1 +4.2
nfsdctl: -3.0 +4.0 -4.1 +4.2

test 243:  vers3=n #vers4=y #vers4.0=y  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
#vers4.0=y
 vers4.1=n
#vers4.2=n

nfsd:    -3.0 +4.0 -4.1 +4.2
nfsdctl: -3.0 +4.0 -4.1 +4.2

test 244:  vers3=n #vers4=y #vers4.0=y  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
#vers4.0=y
 vers4.1=n
#vers4.2=y

nfsd:    -3.0 +4.0 -4.1 +4.2
nfsdctl: -3.0 +4.0 -4.1 +4.2

test 245:  vers3=n #vers4=y #vers4.0=y  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
#vers4.0=y
 vers4.1=y
 vers4.2=n

nfsd:    -3.0 +4.0 +4.1 -4.2
nfsdctl: -3.0 +4.0 +4.1 -4.2

test 246:  vers3=n #vers4=y #vers4.0=y  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
#vers4.0=y
 vers4.1=y
 vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 247:  vers3=n #vers4=y #vers4.0=y  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
#vers4.0=y
 vers4.1=y
#vers4.2=n

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 248:  vers3=n #vers4=y #vers4.0=y  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
#vers4.0=y
 vers4.1=y
#vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 249:  vers3=n #vers4=y #vers4.0=y #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
#vers4.0=y
#vers4.1=n
 vers4.2=n

nfsd:    -3.0 +4.0 +4.1 -4.2
nfsdctl: -3.0 +4.0 +4.1 -4.2

test 250:  vers3=n #vers4=y #vers4.0=y #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
#vers4.0=y
#vers4.1=n
 vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 251:  vers3=n #vers4=y #vers4.0=y #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
#vers4.0=y
#vers4.1=n
#vers4.2=n

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 252:  vers3=n #vers4=y #vers4.0=y #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
#vers4.0=y
#vers4.1=n
#vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 253:  vers3=n #vers4=y #vers4.0=y #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
#vers4.0=y
#vers4.1=y
 vers4.2=n

nfsd:    -3.0 +4.0 +4.1 -4.2
nfsdctl: -3.0 +4.0 +4.1 -4.2

test 254:  vers3=n #vers4=y #vers4.0=y #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
#vers4.0=y
#vers4.1=y
 vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 255:  vers3=n #vers4=y #vers4.0=y #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
#vers4.0=y
#vers4.1=y
#vers4.2=n

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 256:  vers3=n #vers4=y #vers4.0=y #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=n
#vers4=y
#vers4.0=y
#vers4.1=y
#vers4.2=y

nfsd:    -3.0 +4.0 +4.1 +4.2
nfsdctl: -3.0 +4.0 +4.1 +4.2

test 257:  vers3=y  vers4=n  vers4.0=n  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
 vers4.0=n
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 258:  vers3=y  vers4=n  vers4.0=n  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
 vers4.0=n
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 259:  vers3=y  vers4=n  vers4.0=n  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
 vers4.0=n
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 260:  vers3=y  vers4=n  vers4.0=n  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
 vers4.0=n
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 261:  vers3=y  vers4=n  vers4.0=n  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
 vers4.0=n
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 262:  vers3=y  vers4=n  vers4.0=n  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
 vers4.0=n
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 263:  vers3=y  vers4=n  vers4.0=n  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
 vers4.0=n
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 264:  vers3=y  vers4=n  vers4.0=n  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
 vers4.0=n
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 265:  vers3=y  vers4=n  vers4.0=n #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
 vers4.0=n
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 266:  vers3=y  vers4=n  vers4.0=n #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
 vers4.0=n
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 267:  vers3=y  vers4=n  vers4.0=n #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
 vers4.0=n
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 268:  vers3=y  vers4=n  vers4.0=n #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
 vers4.0=n
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 269:  vers3=y  vers4=n  vers4.0=n #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
 vers4.0=n
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 270:  vers3=y  vers4=n  vers4.0=n #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
 vers4.0=n
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 271:  vers3=y  vers4=n  vers4.0=n #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
 vers4.0=n
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 272:  vers3=y  vers4=n  vers4.0=n #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
 vers4.0=n
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 273:  vers3=y  vers4=n  vers4.0=y  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
 vers4.0=y
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 274:  vers3=y  vers4=n  vers4.0=y  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
 vers4.0=y
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 275:  vers3=y  vers4=n  vers4.0=y  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
 vers4.0=y
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 276:  vers3=y  vers4=n  vers4.0=y  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
 vers4.0=y
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 277:  vers3=y  vers4=n  vers4.0=y  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
 vers4.0=y
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 278:  vers3=y  vers4=n  vers4.0=y  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
 vers4.0=y
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 279:  vers3=y  vers4=n  vers4.0=y  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
 vers4.0=y
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 280:  vers3=y  vers4=n  vers4.0=y  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
 vers4.0=y
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 281:  vers3=y  vers4=n  vers4.0=y #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
 vers4.0=y
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 282:  vers3=y  vers4=n  vers4.0=y #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
 vers4.0=y
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 283:  vers3=y  vers4=n  vers4.0=y #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
 vers4.0=y
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 284:  vers3=y  vers4=n  vers4.0=y #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
 vers4.0=y
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 285:  vers3=y  vers4=n  vers4.0=y #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
 vers4.0=y
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 286:  vers3=y  vers4=n  vers4.0=y #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
 vers4.0=y
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 287:  vers3=y  vers4=n  vers4.0=y #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
 vers4.0=y
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 288:  vers3=y  vers4=n  vers4.0=y #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
 vers4.0=y
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 289:  vers3=y  vers4=n #vers4.0=n  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
#vers4.0=n
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 290:  vers3=y  vers4=n #vers4.0=n  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
#vers4.0=n
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 291:  vers3=y  vers4=n #vers4.0=n  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
#vers4.0=n
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 292:  vers3=y  vers4=n #vers4.0=n  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
#vers4.0=n
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 293:  vers3=y  vers4=n #vers4.0=n  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
#vers4.0=n
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 294:  vers3=y  vers4=n #vers4.0=n  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
#vers4.0=n
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 295:  vers3=y  vers4=n #vers4.0=n  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
#vers4.0=n
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 296:  vers3=y  vers4=n #vers4.0=n  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
#vers4.0=n
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 297:  vers3=y  vers4=n #vers4.0=n #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
#vers4.0=n
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 298:  vers3=y  vers4=n #vers4.0=n #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
#vers4.0=n
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 299:  vers3=y  vers4=n #vers4.0=n #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
#vers4.0=n
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 300:  vers3=y  vers4=n #vers4.0=n #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
#vers4.0=n
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 301:  vers3=y  vers4=n #vers4.0=n #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
#vers4.0=n
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 302:  vers3=y  vers4=n #vers4.0=n #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
#vers4.0=n
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 303:  vers3=y  vers4=n #vers4.0=n #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
#vers4.0=n
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 304:  vers3=y  vers4=n #vers4.0=n #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
#vers4.0=n
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 305:  vers3=y  vers4=n #vers4.0=y  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
#vers4.0=y
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 306:  vers3=y  vers4=n #vers4.0=y  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
#vers4.0=y
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 307:  vers3=y  vers4=n #vers4.0=y  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
#vers4.0=y
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 308:  vers3=y  vers4=n #vers4.0=y  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
#vers4.0=y
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 309:  vers3=y  vers4=n #vers4.0=y  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
#vers4.0=y
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 310:  vers3=y  vers4=n #vers4.0=y  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
#vers4.0=y
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 311:  vers3=y  vers4=n #vers4.0=y  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
#vers4.0=y
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 312:  vers3=y  vers4=n #vers4.0=y  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
#vers4.0=y
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 313:  vers3=y  vers4=n #vers4.0=y #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
#vers4.0=y
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 314:  vers3=y  vers4=n #vers4.0=y #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
#vers4.0=y
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 315:  vers3=y  vers4=n #vers4.0=y #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
#vers4.0=y
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 316:  vers3=y  vers4=n #vers4.0=y #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
#vers4.0=y
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 317:  vers3=y  vers4=n #vers4.0=y #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
#vers4.0=y
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 318:  vers3=y  vers4=n #vers4.0=y #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
#vers4.0=y
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 319:  vers3=y  vers4=n #vers4.0=y #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
#vers4.0=y
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 320:  vers3=y  vers4=n #vers4.0=y #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=n
#vers4.0=y
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 321:  vers3=y  vers4=y  vers4.0=n  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
 vers4.0=n
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 322:  vers3=y  vers4=y  vers4.0=n  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
 vers4.0=n
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 323:  vers3=y  vers4=y  vers4.0=n  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
 vers4.0=n
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 324:  vers3=y  vers4=y  vers4.0=n  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
 vers4.0=n
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 325:  vers3=y  vers4=y  vers4.0=n  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
 vers4.0=n
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 326:  vers3=y  vers4=y  vers4.0=n  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
 vers4.0=n
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 327:  vers3=y  vers4=y  vers4.0=n  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
 vers4.0=n
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 328:  vers3=y  vers4=y  vers4.0=n  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
 vers4.0=n
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 329:  vers3=y  vers4=y  vers4.0=n #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
 vers4.0=n
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 330:  vers3=y  vers4=y  vers4.0=n #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
 vers4.0=n
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 331:  vers3=y  vers4=y  vers4.0=n #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
 vers4.0=n
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 332:  vers3=y  vers4=y  vers4.0=n #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
 vers4.0=n
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 333:  vers3=y  vers4=y  vers4.0=n #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
 vers4.0=n
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 334:  vers3=y  vers4=y  vers4.0=n #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
 vers4.0=n
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 335:  vers3=y  vers4=y  vers4.0=n #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
 vers4.0=n
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 336:  vers3=y  vers4=y  vers4.0=n #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
 vers4.0=n
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 337:  vers3=y  vers4=y  vers4.0=y  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
 vers4.0=y
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 338:  vers3=y  vers4=y  vers4.0=y  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
 vers4.0=y
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 339:  vers3=y  vers4=y  vers4.0=y  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
 vers4.0=y
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 340:  vers3=y  vers4=y  vers4.0=y  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
 vers4.0=y
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 341:  vers3=y  vers4=y  vers4.0=y  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
 vers4.0=y
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 342:  vers3=y  vers4=y  vers4.0=y  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
 vers4.0=y
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 343:  vers3=y  vers4=y  vers4.0=y  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
 vers4.0=y
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 344:  vers3=y  vers4=y  vers4.0=y  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
 vers4.0=y
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 345:  vers3=y  vers4=y  vers4.0=y #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
 vers4.0=y
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 346:  vers3=y  vers4=y  vers4.0=y #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
 vers4.0=y
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 347:  vers3=y  vers4=y  vers4.0=y #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
 vers4.0=y
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 348:  vers3=y  vers4=y  vers4.0=y #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
 vers4.0=y
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 349:  vers3=y  vers4=y  vers4.0=y #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
 vers4.0=y
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 350:  vers3=y  vers4=y  vers4.0=y #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
 vers4.0=y
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 351:  vers3=y  vers4=y  vers4.0=y #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
 vers4.0=y
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 352:  vers3=y  vers4=y  vers4.0=y #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
 vers4.0=y
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 353:  vers3=y  vers4=y #vers4.0=n  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
#vers4.0=n
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 354:  vers3=y  vers4=y #vers4.0=n  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
#vers4.0=n
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 355:  vers3=y  vers4=y #vers4.0=n  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
#vers4.0=n
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 356:  vers3=y  vers4=y #vers4.0=n  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
#vers4.0=n
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 357:  vers3=y  vers4=y #vers4.0=n  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
#vers4.0=n
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 358:  vers3=y  vers4=y #vers4.0=n  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
#vers4.0=n
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 359:  vers3=y  vers4=y #vers4.0=n  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
#vers4.0=n
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 360:  vers3=y  vers4=y #vers4.0=n  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
#vers4.0=n
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 361:  vers3=y  vers4=y #vers4.0=n #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
#vers4.0=n
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 362:  vers3=y  vers4=y #vers4.0=n #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
#vers4.0=n
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 363:  vers3=y  vers4=y #vers4.0=n #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
#vers4.0=n
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 364:  vers3=y  vers4=y #vers4.0=n #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
#vers4.0=n
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 365:  vers3=y  vers4=y #vers4.0=n #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
#vers4.0=n
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 366:  vers3=y  vers4=y #vers4.0=n #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
#vers4.0=n
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 367:  vers3=y  vers4=y #vers4.0=n #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
#vers4.0=n
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 368:  vers3=y  vers4=y #vers4.0=n #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
#vers4.0=n
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 369:  vers3=y  vers4=y #vers4.0=y  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
#vers4.0=y
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 370:  vers3=y  vers4=y #vers4.0=y  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
#vers4.0=y
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 371:  vers3=y  vers4=y #vers4.0=y  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
#vers4.0=y
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 372:  vers3=y  vers4=y #vers4.0=y  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
#vers4.0=y
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 373:  vers3=y  vers4=y #vers4.0=y  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
#vers4.0=y
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 374:  vers3=y  vers4=y #vers4.0=y  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
#vers4.0=y
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 375:  vers3=y  vers4=y #vers4.0=y  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
#vers4.0=y
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 376:  vers3=y  vers4=y #vers4.0=y  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
#vers4.0=y
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 377:  vers3=y  vers4=y #vers4.0=y #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
#vers4.0=y
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 378:  vers3=y  vers4=y #vers4.0=y #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
#vers4.0=y
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 379:  vers3=y  vers4=y #vers4.0=y #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
#vers4.0=y
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 380:  vers3=y  vers4=y #vers4.0=y #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
#vers4.0=y
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 381:  vers3=y  vers4=y #vers4.0=y #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
#vers4.0=y
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 382:  vers3=y  vers4=y #vers4.0=y #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
#vers4.0=y
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 383:  vers3=y  vers4=y #vers4.0=y #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
#vers4.0=y
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 384:  vers3=y  vers4=y #vers4.0=y #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
 vers4=y
#vers4.0=y
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 385:  vers3=y #vers4=n  vers4.0=n  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
 vers4.0=n
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 386:  vers3=y #vers4=n  vers4.0=n  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
 vers4.0=n
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 387:  vers3=y #vers4=n  vers4.0=n  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
 vers4.0=n
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 388:  vers3=y #vers4=n  vers4.0=n  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
 vers4.0=n
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 389:  vers3=y #vers4=n  vers4.0=n  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
 vers4.0=n
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 390:  vers3=y #vers4=n  vers4.0=n  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
 vers4.0=n
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 391:  vers3=y #vers4=n  vers4.0=n  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
 vers4.0=n
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 392:  vers3=y #vers4=n  vers4.0=n  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
 vers4.0=n
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 393:  vers3=y #vers4=n  vers4.0=n #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
 vers4.0=n
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 394:  vers3=y #vers4=n  vers4.0=n #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
 vers4.0=n
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 395:  vers3=y #vers4=n  vers4.0=n #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
 vers4.0=n
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 396:  vers3=y #vers4=n  vers4.0=n #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
 vers4.0=n
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 397:  vers3=y #vers4=n  vers4.0=n #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
 vers4.0=n
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 398:  vers3=y #vers4=n  vers4.0=n #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
 vers4.0=n
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 399:  vers3=y #vers4=n  vers4.0=n #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
 vers4.0=n
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 400:  vers3=y #vers4=n  vers4.0=n #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
 vers4.0=n
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 401:  vers3=y #vers4=n  vers4.0=y  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
 vers4.0=y
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 402:  vers3=y #vers4=n  vers4.0=y  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
 vers4.0=y
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 403:  vers3=y #vers4=n  vers4.0=y  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
 vers4.0=y
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 404:  vers3=y #vers4=n  vers4.0=y  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
 vers4.0=y
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 405:  vers3=y #vers4=n  vers4.0=y  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
 vers4.0=y
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 406:  vers3=y #vers4=n  vers4.0=y  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
 vers4.0=y
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 407:  vers3=y #vers4=n  vers4.0=y  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
 vers4.0=y
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 408:  vers3=y #vers4=n  vers4.0=y  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
 vers4.0=y
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 409:  vers3=y #vers4=n  vers4.0=y #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
 vers4.0=y
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 410:  vers3=y #vers4=n  vers4.0=y #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
 vers4.0=y
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 411:  vers3=y #vers4=n  vers4.0=y #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
 vers4.0=y
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 412:  vers3=y #vers4=n  vers4.0=y #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
 vers4.0=y
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 413:  vers3=y #vers4=n  vers4.0=y #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
 vers4.0=y
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 414:  vers3=y #vers4=n  vers4.0=y #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
 vers4.0=y
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 415:  vers3=y #vers4=n  vers4.0=y #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
 vers4.0=y
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 416:  vers3=y #vers4=n  vers4.0=y #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
 vers4.0=y
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 417:  vers3=y #vers4=n #vers4.0=n  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
#vers4.0=n
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 418:  vers3=y #vers4=n #vers4.0=n  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
#vers4.0=n
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 419:  vers3=y #vers4=n #vers4.0=n  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
#vers4.0=n
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 420:  vers3=y #vers4=n #vers4.0=n  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
#vers4.0=n
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 421:  vers3=y #vers4=n #vers4.0=n  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
#vers4.0=n
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 422:  vers3=y #vers4=n #vers4.0=n  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
#vers4.0=n
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 423:  vers3=y #vers4=n #vers4.0=n  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
#vers4.0=n
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 424:  vers3=y #vers4=n #vers4.0=n  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
#vers4.0=n
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 425:  vers3=y #vers4=n #vers4.0=n #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
#vers4.0=n
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 426:  vers3=y #vers4=n #vers4.0=n #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
#vers4.0=n
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 427:  vers3=y #vers4=n #vers4.0=n #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
#vers4.0=n
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 428:  vers3=y #vers4=n #vers4.0=n #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
#vers4.0=n
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 429:  vers3=y #vers4=n #vers4.0=n #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
#vers4.0=n
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 430:  vers3=y #vers4=n #vers4.0=n #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
#vers4.0=n
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 431:  vers3=y #vers4=n #vers4.0=n #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
#vers4.0=n
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 432:  vers3=y #vers4=n #vers4.0=n #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
#vers4.0=n
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 433:  vers3=y #vers4=n #vers4.0=y  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
#vers4.0=y
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 434:  vers3=y #vers4=n #vers4.0=y  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
#vers4.0=y
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 435:  vers3=y #vers4=n #vers4.0=y  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
#vers4.0=y
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 436:  vers3=y #vers4=n #vers4.0=y  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
#vers4.0=y
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 437:  vers3=y #vers4=n #vers4.0=y  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
#vers4.0=y
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 438:  vers3=y #vers4=n #vers4.0=y  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
#vers4.0=y
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 439:  vers3=y #vers4=n #vers4.0=y  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
#vers4.0=y
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 440:  vers3=y #vers4=n #vers4.0=y  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
#vers4.0=y
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 441:  vers3=y #vers4=n #vers4.0=y #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
#vers4.0=y
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 442:  vers3=y #vers4=n #vers4.0=y #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
#vers4.0=y
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 443:  vers3=y #vers4=n #vers4.0=y #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
#vers4.0=y
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 444:  vers3=y #vers4=n #vers4.0=y #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
#vers4.0=y
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 445:  vers3=y #vers4=n #vers4.0=y #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
#vers4.0=y
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 446:  vers3=y #vers4=n #vers4.0=y #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
#vers4.0=y
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 447:  vers3=y #vers4=n #vers4.0=y #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
#vers4.0=y
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 448:  vers3=y #vers4=n #vers4.0=y #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=n
#vers4.0=y
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 449:  vers3=y #vers4=y  vers4.0=n  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
 vers4.0=n
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 450:  vers3=y #vers4=y  vers4.0=n  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
 vers4.0=n
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 451:  vers3=y #vers4=y  vers4.0=n  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
 vers4.0=n
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 452:  vers3=y #vers4=y  vers4.0=n  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
 vers4.0=n
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 453:  vers3=y #vers4=y  vers4.0=n  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
 vers4.0=n
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 454:  vers3=y #vers4=y  vers4.0=n  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
 vers4.0=n
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 455:  vers3=y #vers4=y  vers4.0=n  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
 vers4.0=n
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 456:  vers3=y #vers4=y  vers4.0=n  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
 vers4.0=n
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 457:  vers3=y #vers4=y  vers4.0=n #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
 vers4.0=n
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 458:  vers3=y #vers4=y  vers4.0=n #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
 vers4.0=n
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 459:  vers3=y #vers4=y  vers4.0=n #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
 vers4.0=n
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 460:  vers3=y #vers4=y  vers4.0=n #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
 vers4.0=n
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 461:  vers3=y #vers4=y  vers4.0=n #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
 vers4.0=n
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 462:  vers3=y #vers4=y  vers4.0=n #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
 vers4.0=n
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 463:  vers3=y #vers4=y  vers4.0=n #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
 vers4.0=n
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 464:  vers3=y #vers4=y  vers4.0=n #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
 vers4.0=n
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 465:  vers3=y #vers4=y  vers4.0=y  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
 vers4.0=y
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 466:  vers3=y #vers4=y  vers4.0=y  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
 vers4.0=y
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 467:  vers3=y #vers4=y  vers4.0=y  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
 vers4.0=y
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 468:  vers3=y #vers4=y  vers4.0=y  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
 vers4.0=y
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 469:  vers3=y #vers4=y  vers4.0=y  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
 vers4.0=y
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 470:  vers3=y #vers4=y  vers4.0=y  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
 vers4.0=y
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 471:  vers3=y #vers4=y  vers4.0=y  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
 vers4.0=y
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 472:  vers3=y #vers4=y  vers4.0=y  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
 vers4.0=y
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 473:  vers3=y #vers4=y  vers4.0=y #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
 vers4.0=y
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 474:  vers3=y #vers4=y  vers4.0=y #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
 vers4.0=y
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 475:  vers3=y #vers4=y  vers4.0=y #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
 vers4.0=y
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 476:  vers3=y #vers4=y  vers4.0=y #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
 vers4.0=y
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 477:  vers3=y #vers4=y  vers4.0=y #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
 vers4.0=y
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 478:  vers3=y #vers4=y  vers4.0=y #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
 vers4.0=y
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 479:  vers3=y #vers4=y  vers4.0=y #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
 vers4.0=y
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 480:  vers3=y #vers4=y  vers4.0=y #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
 vers4.0=y
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 481:  vers3=y #vers4=y #vers4.0=n  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
#vers4.0=n
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 482:  vers3=y #vers4=y #vers4.0=n  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
#vers4.0=n
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 483:  vers3=y #vers4=y #vers4.0=n  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
#vers4.0=n
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 484:  vers3=y #vers4=y #vers4.0=n  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
#vers4.0=n
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 485:  vers3=y #vers4=y #vers4.0=n  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
#vers4.0=n
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 486:  vers3=y #vers4=y #vers4.0=n  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
#vers4.0=n
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 487:  vers3=y #vers4=y #vers4.0=n  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
#vers4.0=n
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 488:  vers3=y #vers4=y #vers4.0=n  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
#vers4.0=n
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 489:  vers3=y #vers4=y #vers4.0=n #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
#vers4.0=n
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 490:  vers3=y #vers4=y #vers4.0=n #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
#vers4.0=n
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 491:  vers3=y #vers4=y #vers4.0=n #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
#vers4.0=n
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 492:  vers3=y #vers4=y #vers4.0=n #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
#vers4.0=n
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 493:  vers3=y #vers4=y #vers4.0=n #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
#vers4.0=n
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 494:  vers3=y #vers4=y #vers4.0=n #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
#vers4.0=n
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 495:  vers3=y #vers4=y #vers4.0=n #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
#vers4.0=n
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 496:  vers3=y #vers4=y #vers4.0=n #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
#vers4.0=n
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 497:  vers3=y #vers4=y #vers4.0=y  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
#vers4.0=y
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 498:  vers3=y #vers4=y #vers4.0=y  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
#vers4.0=y
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 499:  vers3=y #vers4=y #vers4.0=y  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
#vers4.0=y
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 500:  vers3=y #vers4=y #vers4.0=y  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
#vers4.0=y
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 501:  vers3=y #vers4=y #vers4.0=y  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
#vers4.0=y
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 502:  vers3=y #vers4=y #vers4.0=y  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
#vers4.0=y
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 503:  vers3=y #vers4=y #vers4.0=y  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
#vers4.0=y
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 504:  vers3=y #vers4=y #vers4.0=y  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
#vers4.0=y
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 505:  vers3=y #vers4=y #vers4.0=y #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
#vers4.0=y
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 506:  vers3=y #vers4=y #vers4.0=y #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
#vers4.0=y
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 507:  vers3=y #vers4=y #vers4.0=y #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
#vers4.0=y
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 508:  vers3=y #vers4=y #vers4.0=y #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
#vers4.0=y
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 509:  vers3=y #vers4=y #vers4.0=y #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
#vers4.0=y
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 510:  vers3=y #vers4=y #vers4.0=y #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
#vers4.0=y
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 511:  vers3=y #vers4=y #vers4.0=y #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
#vers4.0=y
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 512:  vers3=y #vers4=y #vers4.0=y #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
 vers3=y
#vers4=y
#vers4.0=y
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 513: #vers3=n  vers4=n  vers4.0=n  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
 vers4.0=n
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 514: #vers3=n  vers4=n  vers4.0=n  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
 vers4.0=n
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 515: #vers3=n  vers4=n  vers4.0=n  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
 vers4.0=n
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 516: #vers3=n  vers4=n  vers4.0=n  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
 vers4.0=n
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 517: #vers3=n  vers4=n  vers4.0=n  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
 vers4.0=n
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 518: #vers3=n  vers4=n  vers4.0=n  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
 vers4.0=n
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 519: #vers3=n  vers4=n  vers4.0=n  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
 vers4.0=n
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 520: #vers3=n  vers4=n  vers4.0=n  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
 vers4.0=n
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 521: #vers3=n  vers4=n  vers4.0=n #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
 vers4.0=n
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 522: #vers3=n  vers4=n  vers4.0=n #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
 vers4.0=n
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 523: #vers3=n  vers4=n  vers4.0=n #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
 vers4.0=n
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 524: #vers3=n  vers4=n  vers4.0=n #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
 vers4.0=n
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 525: #vers3=n  vers4=n  vers4.0=n #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
 vers4.0=n
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 526: #vers3=n  vers4=n  vers4.0=n #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
 vers4.0=n
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 527: #vers3=n  vers4=n  vers4.0=n #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
 vers4.0=n
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 528: #vers3=n  vers4=n  vers4.0=n #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
 vers4.0=n
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 529: #vers3=n  vers4=n  vers4.0=y  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
 vers4.0=y
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 530: #vers3=n  vers4=n  vers4.0=y  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
 vers4.0=y
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 531: #vers3=n  vers4=n  vers4.0=y  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
 vers4.0=y
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 532: #vers3=n  vers4=n  vers4.0=y  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
 vers4.0=y
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 533: #vers3=n  vers4=n  vers4.0=y  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
 vers4.0=y
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 534: #vers3=n  vers4=n  vers4.0=y  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
 vers4.0=y
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 535: #vers3=n  vers4=n  vers4.0=y  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
 vers4.0=y
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 536: #vers3=n  vers4=n  vers4.0=y  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
 vers4.0=y
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 537: #vers3=n  vers4=n  vers4.0=y #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
 vers4.0=y
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 538: #vers3=n  vers4=n  vers4.0=y #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
 vers4.0=y
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 539: #vers3=n  vers4=n  vers4.0=y #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
 vers4.0=y
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 540: #vers3=n  vers4=n  vers4.0=y #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
 vers4.0=y
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 541: #vers3=n  vers4=n  vers4.0=y #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
 vers4.0=y
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 542: #vers3=n  vers4=n  vers4.0=y #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
 vers4.0=y
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 543: #vers3=n  vers4=n  vers4.0=y #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
 vers4.0=y
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 544: #vers3=n  vers4=n  vers4.0=y #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
 vers4.0=y
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 545: #vers3=n  vers4=n #vers4.0=n  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
#vers4.0=n
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 546: #vers3=n  vers4=n #vers4.0=n  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
#vers4.0=n
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 547: #vers3=n  vers4=n #vers4.0=n  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
#vers4.0=n
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 548: #vers3=n  vers4=n #vers4.0=n  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
#vers4.0=n
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 549: #vers3=n  vers4=n #vers4.0=n  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
#vers4.0=n
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 550: #vers3=n  vers4=n #vers4.0=n  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
#vers4.0=n
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 551: #vers3=n  vers4=n #vers4.0=n  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
#vers4.0=n
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 552: #vers3=n  vers4=n #vers4.0=n  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
#vers4.0=n
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 553: #vers3=n  vers4=n #vers4.0=n #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
#vers4.0=n
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 554: #vers3=n  vers4=n #vers4.0=n #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
#vers4.0=n
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 555: #vers3=n  vers4=n #vers4.0=n #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
#vers4.0=n
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 556: #vers3=n  vers4=n #vers4.0=n #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
#vers4.0=n
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 557: #vers3=n  vers4=n #vers4.0=n #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
#vers4.0=n
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 558: #vers3=n  vers4=n #vers4.0=n #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
#vers4.0=n
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 559: #vers3=n  vers4=n #vers4.0=n #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
#vers4.0=n
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 560: #vers3=n  vers4=n #vers4.0=n #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
#vers4.0=n
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 561: #vers3=n  vers4=n #vers4.0=y  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
#vers4.0=y
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 562: #vers3=n  vers4=n #vers4.0=y  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
#vers4.0=y
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 563: #vers3=n  vers4=n #vers4.0=y  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
#vers4.0=y
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 564: #vers3=n  vers4=n #vers4.0=y  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
#vers4.0=y
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 565: #vers3=n  vers4=n #vers4.0=y  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
#vers4.0=y
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 566: #vers3=n  vers4=n #vers4.0=y  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
#vers4.0=y
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 567: #vers3=n  vers4=n #vers4.0=y  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
#vers4.0=y
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 568: #vers3=n  vers4=n #vers4.0=y  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
#vers4.0=y
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 569: #vers3=n  vers4=n #vers4.0=y #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
#vers4.0=y
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 570: #vers3=n  vers4=n #vers4.0=y #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
#vers4.0=y
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 571: #vers3=n  vers4=n #vers4.0=y #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
#vers4.0=y
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 572: #vers3=n  vers4=n #vers4.0=y #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
#vers4.0=y
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 573: #vers3=n  vers4=n #vers4.0=y #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
#vers4.0=y
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 574: #vers3=n  vers4=n #vers4.0=y #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
#vers4.0=y
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 575: #vers3=n  vers4=n #vers4.0=y #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
#vers4.0=y
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 576: #vers3=n  vers4=n #vers4.0=y #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=n
#vers4.0=y
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 577: #vers3=n  vers4=y  vers4.0=n  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
 vers4.0=n
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 578: #vers3=n  vers4=y  vers4.0=n  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
 vers4.0=n
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 579: #vers3=n  vers4=y  vers4.0=n  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
 vers4.0=n
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 580: #vers3=n  vers4=y  vers4.0=n  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
 vers4.0=n
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 581: #vers3=n  vers4=y  vers4.0=n  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
 vers4.0=n
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 582: #vers3=n  vers4=y  vers4.0=n  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
 vers4.0=n
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 583: #vers3=n  vers4=y  vers4.0=n  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
 vers4.0=n
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 584: #vers3=n  vers4=y  vers4.0=n  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
 vers4.0=n
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 585: #vers3=n  vers4=y  vers4.0=n #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
 vers4.0=n
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 586: #vers3=n  vers4=y  vers4.0=n #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
 vers4.0=n
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 587: #vers3=n  vers4=y  vers4.0=n #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
 vers4.0=n
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 588: #vers3=n  vers4=y  vers4.0=n #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
 vers4.0=n
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 589: #vers3=n  vers4=y  vers4.0=n #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
 vers4.0=n
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 590: #vers3=n  vers4=y  vers4.0=n #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
 vers4.0=n
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 591: #vers3=n  vers4=y  vers4.0=n #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
 vers4.0=n
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 592: #vers3=n  vers4=y  vers4.0=n #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
 vers4.0=n
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 593: #vers3=n  vers4=y  vers4.0=y  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
 vers4.0=y
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 594: #vers3=n  vers4=y  vers4.0=y  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
 vers4.0=y
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 595: #vers3=n  vers4=y  vers4.0=y  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
 vers4.0=y
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 596: #vers3=n  vers4=y  vers4.0=y  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
 vers4.0=y
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 597: #vers3=n  vers4=y  vers4.0=y  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
 vers4.0=y
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 598: #vers3=n  vers4=y  vers4.0=y  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
 vers4.0=y
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 599: #vers3=n  vers4=y  vers4.0=y  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
 vers4.0=y
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 600: #vers3=n  vers4=y  vers4.0=y  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
 vers4.0=y
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 601: #vers3=n  vers4=y  vers4.0=y #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
 vers4.0=y
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 602: #vers3=n  vers4=y  vers4.0=y #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
 vers4.0=y
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 603: #vers3=n  vers4=y  vers4.0=y #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
 vers4.0=y
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 604: #vers3=n  vers4=y  vers4.0=y #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
 vers4.0=y
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 605: #vers3=n  vers4=y  vers4.0=y #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
 vers4.0=y
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 606: #vers3=n  vers4=y  vers4.0=y #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
 vers4.0=y
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 607: #vers3=n  vers4=y  vers4.0=y #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
 vers4.0=y
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 608: #vers3=n  vers4=y  vers4.0=y #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
 vers4.0=y
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 609: #vers3=n  vers4=y #vers4.0=n  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
#vers4.0=n
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 610: #vers3=n  vers4=y #vers4.0=n  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
#vers4.0=n
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 611: #vers3=n  vers4=y #vers4.0=n  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
#vers4.0=n
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 612: #vers3=n  vers4=y #vers4.0=n  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
#vers4.0=n
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 613: #vers3=n  vers4=y #vers4.0=n  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
#vers4.0=n
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 614: #vers3=n  vers4=y #vers4.0=n  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
#vers4.0=n
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 615: #vers3=n  vers4=y #vers4.0=n  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
#vers4.0=n
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 616: #vers3=n  vers4=y #vers4.0=n  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
#vers4.0=n
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 617: #vers3=n  vers4=y #vers4.0=n #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
#vers4.0=n
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 618: #vers3=n  vers4=y #vers4.0=n #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
#vers4.0=n
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 619: #vers3=n  vers4=y #vers4.0=n #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
#vers4.0=n
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 620: #vers3=n  vers4=y #vers4.0=n #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
#vers4.0=n
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 621: #vers3=n  vers4=y #vers4.0=n #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
#vers4.0=n
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 622: #vers3=n  vers4=y #vers4.0=n #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
#vers4.0=n
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 623: #vers3=n  vers4=y #vers4.0=n #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
#vers4.0=n
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 624: #vers3=n  vers4=y #vers4.0=n #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
#vers4.0=n
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 625: #vers3=n  vers4=y #vers4.0=y  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
#vers4.0=y
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 626: #vers3=n  vers4=y #vers4.0=y  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
#vers4.0=y
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 627: #vers3=n  vers4=y #vers4.0=y  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
#vers4.0=y
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 628: #vers3=n  vers4=y #vers4.0=y  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
#vers4.0=y
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 629: #vers3=n  vers4=y #vers4.0=y  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
#vers4.0=y
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 630: #vers3=n  vers4=y #vers4.0=y  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
#vers4.0=y
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 631: #vers3=n  vers4=y #vers4.0=y  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
#vers4.0=y
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 632: #vers3=n  vers4=y #vers4.0=y  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
#vers4.0=y
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 633: #vers3=n  vers4=y #vers4.0=y #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
#vers4.0=y
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 634: #vers3=n  vers4=y #vers4.0=y #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
#vers4.0=y
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 635: #vers3=n  vers4=y #vers4.0=y #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
#vers4.0=y
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 636: #vers3=n  vers4=y #vers4.0=y #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
#vers4.0=y
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 637: #vers3=n  vers4=y #vers4.0=y #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
#vers4.0=y
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 638: #vers3=n  vers4=y #vers4.0=y #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
#vers4.0=y
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 639: #vers3=n  vers4=y #vers4.0=y #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
#vers4.0=y
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 640: #vers3=n  vers4=y #vers4.0=y #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
 vers4=y
#vers4.0=y
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 641: #vers3=n #vers4=n  vers4.0=n  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
 vers4.0=n
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 642: #vers3=n #vers4=n  vers4.0=n  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
 vers4.0=n
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 643: #vers3=n #vers4=n  vers4.0=n  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
 vers4.0=n
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 644: #vers3=n #vers4=n  vers4.0=n  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
 vers4.0=n
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 645: #vers3=n #vers4=n  vers4.0=n  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
 vers4.0=n
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 646: #vers3=n #vers4=n  vers4.0=n  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
 vers4.0=n
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 647: #vers3=n #vers4=n  vers4.0=n  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
 vers4.0=n
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 648: #vers3=n #vers4=n  vers4.0=n  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
 vers4.0=n
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 649: #vers3=n #vers4=n  vers4.0=n #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
 vers4.0=n
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 650: #vers3=n #vers4=n  vers4.0=n #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
 vers4.0=n
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 651: #vers3=n #vers4=n  vers4.0=n #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
 vers4.0=n
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 652: #vers3=n #vers4=n  vers4.0=n #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
 vers4.0=n
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 653: #vers3=n #vers4=n  vers4.0=n #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
 vers4.0=n
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 654: #vers3=n #vers4=n  vers4.0=n #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
 vers4.0=n
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 655: #vers3=n #vers4=n  vers4.0=n #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
 vers4.0=n
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 656: #vers3=n #vers4=n  vers4.0=n #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
 vers4.0=n
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 657: #vers3=n #vers4=n  vers4.0=y  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
 vers4.0=y
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 658: #vers3=n #vers4=n  vers4.0=y  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
 vers4.0=y
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 659: #vers3=n #vers4=n  vers4.0=y  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
 vers4.0=y
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 660: #vers3=n #vers4=n  vers4.0=y  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
 vers4.0=y
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 661: #vers3=n #vers4=n  vers4.0=y  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
 vers4.0=y
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 662: #vers3=n #vers4=n  vers4.0=y  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
 vers4.0=y
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 663: #vers3=n #vers4=n  vers4.0=y  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
 vers4.0=y
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 664: #vers3=n #vers4=n  vers4.0=y  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
 vers4.0=y
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 665: #vers3=n #vers4=n  vers4.0=y #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
 vers4.0=y
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 666: #vers3=n #vers4=n  vers4.0=y #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
 vers4.0=y
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 667: #vers3=n #vers4=n  vers4.0=y #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
 vers4.0=y
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 668: #vers3=n #vers4=n  vers4.0=y #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
 vers4.0=y
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 669: #vers3=n #vers4=n  vers4.0=y #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
 vers4.0=y
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 670: #vers3=n #vers4=n  vers4.0=y #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
 vers4.0=y
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 671: #vers3=n #vers4=n  vers4.0=y #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
 vers4.0=y
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 672: #vers3=n #vers4=n  vers4.0=y #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
 vers4.0=y
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 673: #vers3=n #vers4=n #vers4.0=n  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
#vers4.0=n
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 674: #vers3=n #vers4=n #vers4.0=n  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
#vers4.0=n
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 675: #vers3=n #vers4=n #vers4.0=n  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
#vers4.0=n
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 676: #vers3=n #vers4=n #vers4.0=n  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
#vers4.0=n
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 677: #vers3=n #vers4=n #vers4.0=n  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
#vers4.0=n
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 678: #vers3=n #vers4=n #vers4.0=n  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
#vers4.0=n
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 679: #vers3=n #vers4=n #vers4.0=n  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
#vers4.0=n
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 680: #vers3=n #vers4=n #vers4.0=n  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
#vers4.0=n
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 681: #vers3=n #vers4=n #vers4.0=n #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
#vers4.0=n
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 682: #vers3=n #vers4=n #vers4.0=n #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
#vers4.0=n
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 683: #vers3=n #vers4=n #vers4.0=n #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
#vers4.0=n
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 684: #vers3=n #vers4=n #vers4.0=n #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
#vers4.0=n
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 685: #vers3=n #vers4=n #vers4.0=n #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
#vers4.0=n
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 686: #vers3=n #vers4=n #vers4.0=n #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
#vers4.0=n
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 687: #vers3=n #vers4=n #vers4.0=n #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
#vers4.0=n
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 688: #vers3=n #vers4=n #vers4.0=n #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
#vers4.0=n
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 689: #vers3=n #vers4=n #vers4.0=y  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
#vers4.0=y
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 690: #vers3=n #vers4=n #vers4.0=y  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
#vers4.0=y
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 691: #vers3=n #vers4=n #vers4.0=y  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
#vers4.0=y
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 692: #vers3=n #vers4=n #vers4.0=y  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
#vers4.0=y
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 693: #vers3=n #vers4=n #vers4.0=y  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
#vers4.0=y
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 694: #vers3=n #vers4=n #vers4.0=y  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
#vers4.0=y
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 695: #vers3=n #vers4=n #vers4.0=y  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
#vers4.0=y
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 696: #vers3=n #vers4=n #vers4.0=y  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
#vers4.0=y
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 697: #vers3=n #vers4=n #vers4.0=y #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
#vers4.0=y
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 698: #vers3=n #vers4=n #vers4.0=y #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
#vers4.0=y
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 699: #vers3=n #vers4=n #vers4.0=y #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
#vers4.0=y
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 700: #vers3=n #vers4=n #vers4.0=y #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
#vers4.0=y
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 701: #vers3=n #vers4=n #vers4.0=y #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
#vers4.0=y
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 702: #vers3=n #vers4=n #vers4.0=y #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
#vers4.0=y
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 703: #vers3=n #vers4=n #vers4.0=y #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
#vers4.0=y
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 704: #vers3=n #vers4=n #vers4.0=y #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=n
#vers4.0=y
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 705: #vers3=n #vers4=y  vers4.0=n  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
 vers4.0=n
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 706: #vers3=n #vers4=y  vers4.0=n  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
 vers4.0=n
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 707: #vers3=n #vers4=y  vers4.0=n  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
 vers4.0=n
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 708: #vers3=n #vers4=y  vers4.0=n  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
 vers4.0=n
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 709: #vers3=n #vers4=y  vers4.0=n  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
 vers4.0=n
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 710: #vers3=n #vers4=y  vers4.0=n  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
 vers4.0=n
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 711: #vers3=n #vers4=y  vers4.0=n  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
 vers4.0=n
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 712: #vers3=n #vers4=y  vers4.0=n  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
 vers4.0=n
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 713: #vers3=n #vers4=y  vers4.0=n #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
 vers4.0=n
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 714: #vers3=n #vers4=y  vers4.0=n #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
 vers4.0=n
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 715: #vers3=n #vers4=y  vers4.0=n #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
 vers4.0=n
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 716: #vers3=n #vers4=y  vers4.0=n #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
 vers4.0=n
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 717: #vers3=n #vers4=y  vers4.0=n #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
 vers4.0=n
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 718: #vers3=n #vers4=y  vers4.0=n #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
 vers4.0=n
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 719: #vers3=n #vers4=y  vers4.0=n #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
 vers4.0=n
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 720: #vers3=n #vers4=y  vers4.0=n #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
 vers4.0=n
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 721: #vers3=n #vers4=y  vers4.0=y  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
 vers4.0=y
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 722: #vers3=n #vers4=y  vers4.0=y  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
 vers4.0=y
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 723: #vers3=n #vers4=y  vers4.0=y  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
 vers4.0=y
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 724: #vers3=n #vers4=y  vers4.0=y  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
 vers4.0=y
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 725: #vers3=n #vers4=y  vers4.0=y  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
 vers4.0=y
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 726: #vers3=n #vers4=y  vers4.0=y  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
 vers4.0=y
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 727: #vers3=n #vers4=y  vers4.0=y  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
 vers4.0=y
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 728: #vers3=n #vers4=y  vers4.0=y  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
 vers4.0=y
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 729: #vers3=n #vers4=y  vers4.0=y #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
 vers4.0=y
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 730: #vers3=n #vers4=y  vers4.0=y #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
 vers4.0=y
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 731: #vers3=n #vers4=y  vers4.0=y #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
 vers4.0=y
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 732: #vers3=n #vers4=y  vers4.0=y #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
 vers4.0=y
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 733: #vers3=n #vers4=y  vers4.0=y #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
 vers4.0=y
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 734: #vers3=n #vers4=y  vers4.0=y #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
 vers4.0=y
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 735: #vers3=n #vers4=y  vers4.0=y #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
 vers4.0=y
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 736: #vers3=n #vers4=y  vers4.0=y #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
 vers4.0=y
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 737: #vers3=n #vers4=y #vers4.0=n  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
#vers4.0=n
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 738: #vers3=n #vers4=y #vers4.0=n  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
#vers4.0=n
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 739: #vers3=n #vers4=y #vers4.0=n  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
#vers4.0=n
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 740: #vers3=n #vers4=y #vers4.0=n  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
#vers4.0=n
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 741: #vers3=n #vers4=y #vers4.0=n  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
#vers4.0=n
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 742: #vers3=n #vers4=y #vers4.0=n  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
#vers4.0=n
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 743: #vers3=n #vers4=y #vers4.0=n  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
#vers4.0=n
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 744: #vers3=n #vers4=y #vers4.0=n  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
#vers4.0=n
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 745: #vers3=n #vers4=y #vers4.0=n #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
#vers4.0=n
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 746: #vers3=n #vers4=y #vers4.0=n #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
#vers4.0=n
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 747: #vers3=n #vers4=y #vers4.0=n #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
#vers4.0=n
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 748: #vers3=n #vers4=y #vers4.0=n #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
#vers4.0=n
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 749: #vers3=n #vers4=y #vers4.0=n #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
#vers4.0=n
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 750: #vers3=n #vers4=y #vers4.0=n #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
#vers4.0=n
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 751: #vers3=n #vers4=y #vers4.0=n #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
#vers4.0=n
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 752: #vers3=n #vers4=y #vers4.0=n #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
#vers4.0=n
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 753: #vers3=n #vers4=y #vers4.0=y  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
#vers4.0=y
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 754: #vers3=n #vers4=y #vers4.0=y  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
#vers4.0=y
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 755: #vers3=n #vers4=y #vers4.0=y  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
#vers4.0=y
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 756: #vers3=n #vers4=y #vers4.0=y  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
#vers4.0=y
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 757: #vers3=n #vers4=y #vers4.0=y  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
#vers4.0=y
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 758: #vers3=n #vers4=y #vers4.0=y  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
#vers4.0=y
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 759: #vers3=n #vers4=y #vers4.0=y  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
#vers4.0=y
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 760: #vers3=n #vers4=y #vers4.0=y  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
#vers4.0=y
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 761: #vers3=n #vers4=y #vers4.0=y #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
#vers4.0=y
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 762: #vers3=n #vers4=y #vers4.0=y #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
#vers4.0=y
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 763: #vers3=n #vers4=y #vers4.0=y #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
#vers4.0=y
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 764: #vers3=n #vers4=y #vers4.0=y #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
#vers4.0=y
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 765: #vers3=n #vers4=y #vers4.0=y #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
#vers4.0=y
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 766: #vers3=n #vers4=y #vers4.0=y #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
#vers4.0=y
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 767: #vers3=n #vers4=y #vers4.0=y #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
#vers4.0=y
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 768: #vers3=n #vers4=y #vers4.0=y #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=n
#vers4=y
#vers4.0=y
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 769: #vers3=y  vers4=n  vers4.0=n  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
 vers4.0=n
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 770: #vers3=y  vers4=n  vers4.0=n  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
 vers4.0=n
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 771: #vers3=y  vers4=n  vers4.0=n  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
 vers4.0=n
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 772: #vers3=y  vers4=n  vers4.0=n  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
 vers4.0=n
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 773: #vers3=y  vers4=n  vers4.0=n  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
 vers4.0=n
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 774: #vers3=y  vers4=n  vers4.0=n  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
 vers4.0=n
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 775: #vers3=y  vers4=n  vers4.0=n  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
 vers4.0=n
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 776: #vers3=y  vers4=n  vers4.0=n  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
 vers4.0=n
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 777: #vers3=y  vers4=n  vers4.0=n #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
 vers4.0=n
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 778: #vers3=y  vers4=n  vers4.0=n #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
 vers4.0=n
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 779: #vers3=y  vers4=n  vers4.0=n #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
 vers4.0=n
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 780: #vers3=y  vers4=n  vers4.0=n #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
 vers4.0=n
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 781: #vers3=y  vers4=n  vers4.0=n #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
 vers4.0=n
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 782: #vers3=y  vers4=n  vers4.0=n #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
 vers4.0=n
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 783: #vers3=y  vers4=n  vers4.0=n #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
 vers4.0=n
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 784: #vers3=y  vers4=n  vers4.0=n #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
 vers4.0=n
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 785: #vers3=y  vers4=n  vers4.0=y  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
 vers4.0=y
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 786: #vers3=y  vers4=n  vers4.0=y  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
 vers4.0=y
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 787: #vers3=y  vers4=n  vers4.0=y  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
 vers4.0=y
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 788: #vers3=y  vers4=n  vers4.0=y  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
 vers4.0=y
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 789: #vers3=y  vers4=n  vers4.0=y  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
 vers4.0=y
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 790: #vers3=y  vers4=n  vers4.0=y  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
 vers4.0=y
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 791: #vers3=y  vers4=n  vers4.0=y  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
 vers4.0=y
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 792: #vers3=y  vers4=n  vers4.0=y  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
 vers4.0=y
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 793: #vers3=y  vers4=n  vers4.0=y #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
 vers4.0=y
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 794: #vers3=y  vers4=n  vers4.0=y #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
 vers4.0=y
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 795: #vers3=y  vers4=n  vers4.0=y #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
 vers4.0=y
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 796: #vers3=y  vers4=n  vers4.0=y #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
 vers4.0=y
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 797: #vers3=y  vers4=n  vers4.0=y #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
 vers4.0=y
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 798: #vers3=y  vers4=n  vers4.0=y #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
 vers4.0=y
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 799: #vers3=y  vers4=n  vers4.0=y #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
 vers4.0=y
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 800: #vers3=y  vers4=n  vers4.0=y #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
 vers4.0=y
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 801: #vers3=y  vers4=n #vers4.0=n  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
#vers4.0=n
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 802: #vers3=y  vers4=n #vers4.0=n  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
#vers4.0=n
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 803: #vers3=y  vers4=n #vers4.0=n  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
#vers4.0=n
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 804: #vers3=y  vers4=n #vers4.0=n  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
#vers4.0=n
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 805: #vers3=y  vers4=n #vers4.0=n  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
#vers4.0=n
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 806: #vers3=y  vers4=n #vers4.0=n  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
#vers4.0=n
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 807: #vers3=y  vers4=n #vers4.0=n  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
#vers4.0=n
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 808: #vers3=y  vers4=n #vers4.0=n  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
#vers4.0=n
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 809: #vers3=y  vers4=n #vers4.0=n #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
#vers4.0=n
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 810: #vers3=y  vers4=n #vers4.0=n #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
#vers4.0=n
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 811: #vers3=y  vers4=n #vers4.0=n #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
#vers4.0=n
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 812: #vers3=y  vers4=n #vers4.0=n #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
#vers4.0=n
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 813: #vers3=y  vers4=n #vers4.0=n #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
#vers4.0=n
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 814: #vers3=y  vers4=n #vers4.0=n #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
#vers4.0=n
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 815: #vers3=y  vers4=n #vers4.0=n #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
#vers4.0=n
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 816: #vers3=y  vers4=n #vers4.0=n #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
#vers4.0=n
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 817: #vers3=y  vers4=n #vers4.0=y  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
#vers4.0=y
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 818: #vers3=y  vers4=n #vers4.0=y  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
#vers4.0=y
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 819: #vers3=y  vers4=n #vers4.0=y  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
#vers4.0=y
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 820: #vers3=y  vers4=n #vers4.0=y  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
#vers4.0=y
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 821: #vers3=y  vers4=n #vers4.0=y  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
#vers4.0=y
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 822: #vers3=y  vers4=n #vers4.0=y  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
#vers4.0=y
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 823: #vers3=y  vers4=n #vers4.0=y  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
#vers4.0=y
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 824: #vers3=y  vers4=n #vers4.0=y  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
#vers4.0=y
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 825: #vers3=y  vers4=n #vers4.0=y #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
#vers4.0=y
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 826: #vers3=y  vers4=n #vers4.0=y #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
#vers4.0=y
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 827: #vers3=y  vers4=n #vers4.0=y #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
#vers4.0=y
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 828: #vers3=y  vers4=n #vers4.0=y #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
#vers4.0=y
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 829: #vers3=y  vers4=n #vers4.0=y #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
#vers4.0=y
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 830: #vers3=y  vers4=n #vers4.0=y #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
#vers4.0=y
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 831: #vers3=y  vers4=n #vers4.0=y #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
#vers4.0=y
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 832: #vers3=y  vers4=n #vers4.0=y #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=n
#vers4.0=y
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 833: #vers3=y  vers4=y  vers4.0=n  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
 vers4.0=n
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 834: #vers3=y  vers4=y  vers4.0=n  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
 vers4.0=n
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 835: #vers3=y  vers4=y  vers4.0=n  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
 vers4.0=n
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 836: #vers3=y  vers4=y  vers4.0=n  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
 vers4.0=n
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 837: #vers3=y  vers4=y  vers4.0=n  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
 vers4.0=n
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 838: #vers3=y  vers4=y  vers4.0=n  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
 vers4.0=n
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 839: #vers3=y  vers4=y  vers4.0=n  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
 vers4.0=n
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 840: #vers3=y  vers4=y  vers4.0=n  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
 vers4.0=n
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 841: #vers3=y  vers4=y  vers4.0=n #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
 vers4.0=n
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 842: #vers3=y  vers4=y  vers4.0=n #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
 vers4.0=n
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 843: #vers3=y  vers4=y  vers4.0=n #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
 vers4.0=n
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 844: #vers3=y  vers4=y  vers4.0=n #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
 vers4.0=n
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 845: #vers3=y  vers4=y  vers4.0=n #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
 vers4.0=n
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 846: #vers3=y  vers4=y  vers4.0=n #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
 vers4.0=n
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 847: #vers3=y  vers4=y  vers4.0=n #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
 vers4.0=n
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 848: #vers3=y  vers4=y  vers4.0=n #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
 vers4.0=n
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 849: #vers3=y  vers4=y  vers4.0=y  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
 vers4.0=y
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 850: #vers3=y  vers4=y  vers4.0=y  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
 vers4.0=y
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 851: #vers3=y  vers4=y  vers4.0=y  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
 vers4.0=y
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 852: #vers3=y  vers4=y  vers4.0=y  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
 vers4.0=y
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 853: #vers3=y  vers4=y  vers4.0=y  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
 vers4.0=y
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 854: #vers3=y  vers4=y  vers4.0=y  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
 vers4.0=y
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 855: #vers3=y  vers4=y  vers4.0=y  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
 vers4.0=y
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 856: #vers3=y  vers4=y  vers4.0=y  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
 vers4.0=y
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 857: #vers3=y  vers4=y  vers4.0=y #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
 vers4.0=y
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 858: #vers3=y  vers4=y  vers4.0=y #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
 vers4.0=y
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 859: #vers3=y  vers4=y  vers4.0=y #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
 vers4.0=y
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 860: #vers3=y  vers4=y  vers4.0=y #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
 vers4.0=y
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 861: #vers3=y  vers4=y  vers4.0=y #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
 vers4.0=y
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 862: #vers3=y  vers4=y  vers4.0=y #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
 vers4.0=y
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 863: #vers3=y  vers4=y  vers4.0=y #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
 vers4.0=y
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 864: #vers3=y  vers4=y  vers4.0=y #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
 vers4.0=y
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 865: #vers3=y  vers4=y #vers4.0=n  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
#vers4.0=n
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 866: #vers3=y  vers4=y #vers4.0=n  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
#vers4.0=n
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 867: #vers3=y  vers4=y #vers4.0=n  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
#vers4.0=n
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 868: #vers3=y  vers4=y #vers4.0=n  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
#vers4.0=n
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 869: #vers3=y  vers4=y #vers4.0=n  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
#vers4.0=n
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 870: #vers3=y  vers4=y #vers4.0=n  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
#vers4.0=n
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 871: #vers3=y  vers4=y #vers4.0=n  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
#vers4.0=n
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 872: #vers3=y  vers4=y #vers4.0=n  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
#vers4.0=n
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 873: #vers3=y  vers4=y #vers4.0=n #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
#vers4.0=n
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 874: #vers3=y  vers4=y #vers4.0=n #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
#vers4.0=n
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 875: #vers3=y  vers4=y #vers4.0=n #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
#vers4.0=n
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 876: #vers3=y  vers4=y #vers4.0=n #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
#vers4.0=n
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 877: #vers3=y  vers4=y #vers4.0=n #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
#vers4.0=n
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 878: #vers3=y  vers4=y #vers4.0=n #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
#vers4.0=n
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 879: #vers3=y  vers4=y #vers4.0=n #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
#vers4.0=n
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 880: #vers3=y  vers4=y #vers4.0=n #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
#vers4.0=n
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 881: #vers3=y  vers4=y #vers4.0=y  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
#vers4.0=y
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 882: #vers3=y  vers4=y #vers4.0=y  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
#vers4.0=y
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 883: #vers3=y  vers4=y #vers4.0=y  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
#vers4.0=y
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 884: #vers3=y  vers4=y #vers4.0=y  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
#vers4.0=y
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 885: #vers3=y  vers4=y #vers4.0=y  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
#vers4.0=y
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 886: #vers3=y  vers4=y #vers4.0=y  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
#vers4.0=y
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 887: #vers3=y  vers4=y #vers4.0=y  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
#vers4.0=y
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 888: #vers3=y  vers4=y #vers4.0=y  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
#vers4.0=y
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 889: #vers3=y  vers4=y #vers4.0=y #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
#vers4.0=y
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 890: #vers3=y  vers4=y #vers4.0=y #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
#vers4.0=y
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 891: #vers3=y  vers4=y #vers4.0=y #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
#vers4.0=y
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 892: #vers3=y  vers4=y #vers4.0=y #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
#vers4.0=y
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 893: #vers3=y  vers4=y #vers4.0=y #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
#vers4.0=y
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 894: #vers3=y  vers4=y #vers4.0=y #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
#vers4.0=y
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 895: #vers3=y  vers4=y #vers4.0=y #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
#vers4.0=y
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 896: #vers3=y  vers4=y #vers4.0=y #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
 vers4=y
#vers4.0=y
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 897: #vers3=y #vers4=n  vers4.0=n  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
 vers4.0=n
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 898: #vers3=y #vers4=n  vers4.0=n  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
 vers4.0=n
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 899: #vers3=y #vers4=n  vers4.0=n  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
 vers4.0=n
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 900: #vers3=y #vers4=n  vers4.0=n  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
 vers4.0=n
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 901: #vers3=y #vers4=n  vers4.0=n  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
 vers4.0=n
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 902: #vers3=y #vers4=n  vers4.0=n  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
 vers4.0=n
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 903: #vers3=y #vers4=n  vers4.0=n  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
 vers4.0=n
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 904: #vers3=y #vers4=n  vers4.0=n  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
 vers4.0=n
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 905: #vers3=y #vers4=n  vers4.0=n #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
 vers4.0=n
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 906: #vers3=y #vers4=n  vers4.0=n #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
 vers4.0=n
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 907: #vers3=y #vers4=n  vers4.0=n #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
 vers4.0=n
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 908: #vers3=y #vers4=n  vers4.0=n #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
 vers4.0=n
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 909: #vers3=y #vers4=n  vers4.0=n #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
 vers4.0=n
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 910: #vers3=y #vers4=n  vers4.0=n #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
 vers4.0=n
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 911: #vers3=y #vers4=n  vers4.0=n #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
 vers4.0=n
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 912: #vers3=y #vers4=n  vers4.0=n #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
 vers4.0=n
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 913: #vers3=y #vers4=n  vers4.0=y  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
 vers4.0=y
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 914: #vers3=y #vers4=n  vers4.0=y  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
 vers4.0=y
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 915: #vers3=y #vers4=n  vers4.0=y  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
 vers4.0=y
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 916: #vers3=y #vers4=n  vers4.0=y  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
 vers4.0=y
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 917: #vers3=y #vers4=n  vers4.0=y  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
 vers4.0=y
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 918: #vers3=y #vers4=n  vers4.0=y  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
 vers4.0=y
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 919: #vers3=y #vers4=n  vers4.0=y  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
 vers4.0=y
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 920: #vers3=y #vers4=n  vers4.0=y  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
 vers4.0=y
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 921: #vers3=y #vers4=n  vers4.0=y #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
 vers4.0=y
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 922: #vers3=y #vers4=n  vers4.0=y #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
 vers4.0=y
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 923: #vers3=y #vers4=n  vers4.0=y #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
 vers4.0=y
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 924: #vers3=y #vers4=n  vers4.0=y #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
 vers4.0=y
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 925: #vers3=y #vers4=n  vers4.0=y #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
 vers4.0=y
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 926: #vers3=y #vers4=n  vers4.0=y #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
 vers4.0=y
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 927: #vers3=y #vers4=n  vers4.0=y #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
 vers4.0=y
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 928: #vers3=y #vers4=n  vers4.0=y #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
 vers4.0=y
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 929: #vers3=y #vers4=n #vers4.0=n  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
#vers4.0=n
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 930: #vers3=y #vers4=n #vers4.0=n  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
#vers4.0=n
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 931: #vers3=y #vers4=n #vers4.0=n  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
#vers4.0=n
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 932: #vers3=y #vers4=n #vers4.0=n  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
#vers4.0=n
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 933: #vers3=y #vers4=n #vers4.0=n  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
#vers4.0=n
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 934: #vers3=y #vers4=n #vers4.0=n  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
#vers4.0=n
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 935: #vers3=y #vers4=n #vers4.0=n  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
#vers4.0=n
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 936: #vers3=y #vers4=n #vers4.0=n  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
#vers4.0=n
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 937: #vers3=y #vers4=n #vers4.0=n #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
#vers4.0=n
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 938: #vers3=y #vers4=n #vers4.0=n #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
#vers4.0=n
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 939: #vers3=y #vers4=n #vers4.0=n #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
#vers4.0=n
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 940: #vers3=y #vers4=n #vers4.0=n #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
#vers4.0=n
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 941: #vers3=y #vers4=n #vers4.0=n #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
#vers4.0=n
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 942: #vers3=y #vers4=n #vers4.0=n #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
#vers4.0=n
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 943: #vers3=y #vers4=n #vers4.0=n #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
#vers4.0=n
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 944: #vers3=y #vers4=n #vers4.0=n #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
#vers4.0=n
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 945: #vers3=y #vers4=n #vers4.0=y  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
#vers4.0=y
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 946: #vers3=y #vers4=n #vers4.0=y  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
#vers4.0=y
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 947: #vers3=y #vers4=n #vers4.0=y  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
#vers4.0=y
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 948: #vers3=y #vers4=n #vers4.0=y  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
#vers4.0=y
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 949: #vers3=y #vers4=n #vers4.0=y  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
#vers4.0=y
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 950: #vers3=y #vers4=n #vers4.0=y  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
#vers4.0=y
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 951: #vers3=y #vers4=n #vers4.0=y  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
#vers4.0=y
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 952: #vers3=y #vers4=n #vers4.0=y  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
#vers4.0=y
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 953: #vers3=y #vers4=n #vers4.0=y #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
#vers4.0=y
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 954: #vers3=y #vers4=n #vers4.0=y #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
#vers4.0=y
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 955: #vers3=y #vers4=n #vers4.0=y #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
#vers4.0=y
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 956: #vers3=y #vers4=n #vers4.0=y #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
#vers4.0=y
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 957: #vers3=y #vers4=n #vers4.0=y #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
#vers4.0=y
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 958: #vers3=y #vers4=n #vers4.0=y #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
#vers4.0=y
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 959: #vers3=y #vers4=n #vers4.0=y #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
#vers4.0=y
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 960: #vers3=y #vers4=n #vers4.0=y #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=n
#vers4.0=y
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 961: #vers3=y #vers4=y  vers4.0=n  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
 vers4.0=n
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 -4.0 -4.1 -4.2
nfsdctl: +3.0 -4.0 -4.1 -4.2

test 962: #vers3=y #vers4=y  vers4.0=n  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
 vers4.0=n
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 963: #vers3=y #vers4=y  vers4.0=n  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
 vers4.0=n
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 964: #vers3=y #vers4=y  vers4.0=n  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
 vers4.0=n
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 -4.0 -4.1 +4.2
nfsdctl: +3.0 -4.0 -4.1 +4.2

test 965: #vers3=y #vers4=y  vers4.0=n  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
 vers4.0=n
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 966: #vers3=y #vers4=y  vers4.0=n  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
 vers4.0=n
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 967: #vers3=y #vers4=y  vers4.0=n  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
 vers4.0=n
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 968: #vers3=y #vers4=y  vers4.0=n  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
 vers4.0=n
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 969: #vers3=y #vers4=y  vers4.0=n #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
 vers4.0=n
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 970: #vers3=y #vers4=y  vers4.0=n #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
 vers4.0=n
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 971: #vers3=y #vers4=y  vers4.0=n #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
 vers4.0=n
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 972: #vers3=y #vers4=y  vers4.0=n #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
 vers4.0=n
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 973: #vers3=y #vers4=y  vers4.0=n #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
 vers4.0=n
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 -4.0 +4.1 -4.2
nfsdctl: +3.0 -4.0 +4.1 -4.2

test 974: #vers3=y #vers4=y  vers4.0=n #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
 vers4.0=n
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 975: #vers3=y #vers4=y  vers4.0=n #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
 vers4.0=n
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 976: #vers3=y #vers4=y  vers4.0=n #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
 vers4.0=n
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 -4.0 +4.1 +4.2
nfsdctl: +3.0 -4.0 +4.1 +4.2

test 977: #vers3=y #vers4=y  vers4.0=y  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
 vers4.0=y
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 978: #vers3=y #vers4=y  vers4.0=y  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
 vers4.0=y
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 979: #vers3=y #vers4=y  vers4.0=y  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
 vers4.0=y
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 980: #vers3=y #vers4=y  vers4.0=y  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
 vers4.0=y
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 981: #vers3=y #vers4=y  vers4.0=y  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
 vers4.0=y
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 982: #vers3=y #vers4=y  vers4.0=y  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
 vers4.0=y
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 983: #vers3=y #vers4=y  vers4.0=y  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
 vers4.0=y
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 984: #vers3=y #vers4=y  vers4.0=y  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
 vers4.0=y
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 985: #vers3=y #vers4=y  vers4.0=y #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
 vers4.0=y
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 986: #vers3=y #vers4=y  vers4.0=y #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
 vers4.0=y
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 987: #vers3=y #vers4=y  vers4.0=y #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
 vers4.0=y
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 988: #vers3=y #vers4=y  vers4.0=y #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
 vers4.0=y
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 989: #vers3=y #vers4=y  vers4.0=y #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
 vers4.0=y
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 990: #vers3=y #vers4=y  vers4.0=y #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
 vers4.0=y
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 991: #vers3=y #vers4=y  vers4.0=y #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
 vers4.0=y
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 992: #vers3=y #vers4=y  vers4.0=y #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
 vers4.0=y
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 993: #vers3=y #vers4=y #vers4.0=n  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
#vers4.0=n
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 994: #vers3=y #vers4=y #vers4.0=n  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
#vers4.0=n
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 995: #vers3=y #vers4=y #vers4.0=n  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
#vers4.0=n
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 996: #vers3=y #vers4=y #vers4.0=n  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
#vers4.0=n
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 997: #vers3=y #vers4=y #vers4.0=n  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
#vers4.0=n
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 998: #vers3=y #vers4=y #vers4.0=n  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
#vers4.0=n
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 999: #vers3=y #vers4=y #vers4.0=n  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
#vers4.0=n
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 1000: #vers3=y #vers4=y #vers4.0=n  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
#vers4.0=n
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 1001: #vers3=y #vers4=y #vers4.0=n #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
#vers4.0=n
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 1002: #vers3=y #vers4=y #vers4.0=n #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
#vers4.0=n
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 1003: #vers3=y #vers4=y #vers4.0=n #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
#vers4.0=n
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 1004: #vers3=y #vers4=y #vers4.0=n #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
#vers4.0=n
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 1005: #vers3=y #vers4=y #vers4.0=n #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
#vers4.0=n
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 1006: #vers3=y #vers4=y #vers4.0=n #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
#vers4.0=n
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 1007: #vers3=y #vers4=y #vers4.0=n #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
#vers4.0=n
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 1008: #vers3=y #vers4=y #vers4.0=n #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
#vers4.0=n
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 1009: #vers3=y #vers4=y #vers4.0=y  vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
#vers4.0=y
 vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 -4.1 -4.2
nfsdctl: +3.0 +4.0 -4.1 -4.2

test 1010: #vers3=y #vers4=y #vers4.0=y  vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
#vers4.0=y
 vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 1011: #vers3=y #vers4=y #vers4.0=y  vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
#vers4.0=y
 vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 1012: #vers3=y #vers4=y #vers4.0=y  vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
#vers4.0=y
 vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 -4.1 +4.2
nfsdctl: +3.0 +4.0 -4.1 +4.2

test 1013: #vers3=y #vers4=y #vers4.0=y  vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
#vers4.0=y
 vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 1014: #vers3=y #vers4=y #vers4.0=y  vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
#vers4.0=y
 vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 1015: #vers3=y #vers4=y #vers4.0=y  vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
#vers4.0=y
 vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 1016: #vers3=y #vers4=y #vers4.0=y  vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
#vers4.0=y
 vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 1017: #vers3=y #vers4=y #vers4.0=y #vers4.1=n  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
#vers4.0=y
#vers4.1=n
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 1018: #vers3=y #vers4=y #vers4.0=y #vers4.1=n  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
#vers4.0=y
#vers4.1=n
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 1019: #vers3=y #vers4=y #vers4.0=y #vers4.1=n #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
#vers4.0=y
#vers4.1=n
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 1020: #vers3=y #vers4=y #vers4.0=y #vers4.1=n #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
#vers4.0=y
#vers4.1=n
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 1021: #vers3=y #vers4=y #vers4.0=y #vers4.1=y  vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
#vers4.0=y
#vers4.1=y
 vers4.2=n

nfsd:    +3.0 +4.0 +4.1 -4.2
nfsdctl: +3.0 +4.0 +4.1 -4.2

test 1022: #vers3=y #vers4=y #vers4.0=y #vers4.1=y  vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
#vers4.0=y
#vers4.1=y
 vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 1023: #vers3=y #vers4=y #vers4.0=y #vers4.1=y #vers4.2=n

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
#vers4.0=y
#vers4.1=y
#vers4.2=n

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2

test 1024: #vers3=y #vers4=y #vers4.0=y #vers4.1=y #vers4.2=y

/etc/nfs.conf:
[nfsd]
#vers3=y
#vers4=y
#vers4.0=y
#vers4.1=y
#vers4.2=y

nfsd:    +3.0 +4.0 +4.1 +4.2
nfsdctl: +3.0 +4.0 +4.1 +4.2


--XC11gdYd2UEiHAlz--


