Return-Path: <linux-nfs+bounces-12115-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56671ACE6C7
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 00:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D86543A466C
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 22:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD7722B5B1;
	Wed,  4 Jun 2025 22:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iDhfprN2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F88202961
	for <linux-nfs@vger.kernel.org>; Wed,  4 Jun 2025 22:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749076997; cv=none; b=VoHo404JfM/IT0/ktMCgf1uaSYxpaRcGBVnyV1dZVotNhj17i6bpyntDYwKwdJewRgqr7Hr+KRoSnJXJcz4Vy2luX88ZskS6TR0ANzDzDuEb31iEonlBIhEGgKeG+mYbCQSGdzC4g0pnq3Hr2pt+tvWYOlP0xhPvX3Fk4jTmmbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749076997; c=relaxed/simple;
	bh=xgJoKCYjO2H2MFiTmtQ6CXdrIWEYnh6cpD7HxwHRXkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mpYRz3lCr1XlF3VB7DxLAqORlM2NjqtnAuHku+OMJMTcdi61bf8FWpond6C/c3twdrYP8Z7cRQiSMUPz+XE604BM6Rm7UE1jqKxlO5RH2oTmhnqrCIDSqcGu7mMqcpqQT0n736VBenuBUJ8Fbn4xSlKFvCArnBLIVZSNVRFhwsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iDhfprN2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749076993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nR2A/AFEvvYmgHlboSsOjW1O14aFRn65d9h/ASaJYyw=;
	b=iDhfprN2o+Nk9j5LaCCUKZJ0Sj4JCt9lPgtF2j44vX71RWyIkDJrMGkmT8ON0cmit4VAPG
	t1i/k53mqenhM6+T1k87G9xZjtroI6rnCB5vrrKenA8AFgnLjmVWaoTJsKLQ0xZDOY97br
	ivPTIw3YbErj80Y+UzMQMa1Vhte3ZYY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-O0SNU55WOV-YqNJfwOETlg-1; Wed,
 04 Jun 2025 18:43:12 -0400
X-MC-Unique: O0SNU55WOV-YqNJfwOETlg-1
X-Mimecast-MFC-AGG-ID: O0SNU55WOV-YqNJfwOETlg_1749076991
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A52BC180035C;
	Wed,  4 Jun 2025 22:43:11 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.65.26])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7872D18002B1;
	Wed,  4 Jun 2025 22:43:11 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id 6EB4A34E1C5; Wed, 04 Jun 2025 18:43:09 -0400 (EDT)
Date: Wed, 4 Jun 2025 18:43:09 -0400
From: Scott Mayhew <smayhew@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Anthony Rossomano <trossoma2@gmail.com>, linux-nfs@vger.kernel.org
Subject: Re: Path for rpc_pipefs
Message-ID: <aEDL_b0XyH-abQty@aion>
References: <B7AF8E7A-65BC-4DF5-A590-00E4B2F0B5D5@gmail.com>
 <5e3f1c5595e266bcb91e0e6db0b308feae6497fc.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5e3f1c5595e266bcb91e0e6db0b308feae6497fc.camel@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, 04 Jun 2025, Jeff Layton wrote:

> On Tue, 2025-06-03 at 15:38 -0700, Anthony Rossomano wrote:
> > I wanted to get some input about changing the path to rpc_pipefs mount =
point. Can this be done and how to do it. The mount unit provided by nfs-ut=
ils pkg is cfg=E2=80=99d with path to /var/lib/nfs/rpc_pipefs but you can c=
hange the path for dependent services in /etc/nfs.conf. Can a new mount uni=
t be created to change the mount path? Env is Alma 8. Having trouble becaus=
e mount point is created early and need to remount /var elsewhere later, an=
d need to deal with the rpc_pipefs mount point. Changes to systemd dependen=
cies are not panning out. Thanks in advance for any input
>=20
> Most of the daemons that work with rpc_pipefs take a command-line
> parameter to change where the rpc_pipefs mountpoint is. Adding matching
> config options to nfs.conf would probably not be too difficult.
>=20
> I suggest pulling down the nfs-utils tree [1], and look at how the
> nfs.conf handling is done. Find the places where the rpc_pipefs
> directory path is set and have them check the config file for the
> default and fall back to the compile-time default if it's not set.
>=20
> FWIW, it looks like blkmapd already has a config file parameter for
> this, so mirroring that for the other daemons is probably what you want
> to aim for.

That shouldn't be necessary.  All of the daemons should be looking for
the "pipefs-directory" configuration in the "general" stanza of nfs.conf
(rpc.gssd will also look under the "gssd" stanza but it should bark at
you if you specify it there).

/usr/lib/systemd/system-generators/rpc-pipefs-generator will create
override units for rpc_pipefs.target and *-rpc_pipefs.mount (located in
/run/systemd/generator) whenever you specify a value that differs from
the default.  None of the systemd units should be depending directly on
the *-rpc_pipefs.mount unit.  Instead, they should be depending on
rpc_pipefs.target.

So it should just be a matter of changing the value in nfs.conf and
rebooting.  (If you don't want to reboot, then you can get the generator
to trigger by running 'systemctl daemon-reload', but then you still need
to stop the dependent services, stop the old *-rpc_pipefs.mount,
start the new *-rpc_pipefs.mount, and start the dependent services.)

For example:

root@fedora:~# grep rpc_pipefs /proc/mounts
sunrpc /var/lib/nfs/rpc_pipefs rpc_pipefs rw,relatime 0 0
root@fedora:~# nfsconf --get general pipefs-directory
/var/lib/nfs/rpc_pipefs
root@fedora:~# nfsconf --set general pipefs-directory /run/rpc_pipefs
root@fedora:~# nfsconf --get general pipefs-directory
/run/rpc_pipefs
root@fedora:~# reboot
root@fedora:~# Read from remote host fedora: Connection reset by peer
Connection to fedora closed.
client_loop: send disconnect: Broken pipe
scott@aion:~$ ssh root@fedora
root@fedora:~# grep rpc_pipefs /proc/mounts
sunrpc /run/rpc_pipefs rpc_pipefs rw,relatime 0 0
root@fedora:~# systemctl status rpc_pipefs.target
=E2=97=8F rpc_pipefs.target
     Loaded: loaded (/run/systemd/generator/rpc_pipefs.target; generated)
     Active: active since Wed 2025-06-04 18:34:44 EDT; 14s ago
 Invocation: 2c43c6c9694f4a0381cfebb38015e46f

Jun 04 18:34:44 fedora.smayhew.test systemd[1]: Reached target rpc_pipefs.t=
arget.
root@fedora:~# systemctl list-dependencies --after rpc_pipefs.target
rpc_pipefs.target
=E2=97=8F =E2=94=94=E2=94=80run-rpc_pipefs.mount
root@fedora:~# systemctl status run-rpc_pipefs.mount
=E2=97=8F run-rpc_pipefs.mount - RPC Pipe File System
     Loaded: loaded (/run/systemd/generator/run-rpc_pipefs.mount; generated)
     Active: active (mounted) since Wed 2025-06-04 18:34:44 EDT; 51s ago
 Invocation: 22d6bdec88c848479e4eb475eb191a53
      Where: /run/rpc_pipefs
       What: sunrpc
      Tasks: 0 (limit: 4641)
     Memory: 16K (peak: 1.3M)
        CPU: 2ms
     CGroup: /system.slice/run-rpc_pipefs.mount

Jun 04 18:34:44 fedora.smayhew.test systemd[1]: Mounting run-rpc_pipefs.mou=
nt - RPC Pipe File System...
Jun 04 18:34:44 fedora.smayhew.test systemd[1]: Mounted run-rpc_pipefs.moun=
t - RPC Pipe File System.



>=20
> [1]: git://git.linux-nfs.org/projects/steved/nfs-utils.git
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20


