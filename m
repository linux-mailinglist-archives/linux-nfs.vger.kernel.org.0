Return-Path: <linux-nfs+bounces-2128-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D80886D80C
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Mar 2024 00:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8799BB21F54
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Feb 2024 23:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C9813E7C4;
	Thu, 29 Feb 2024 23:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LDoRExXk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D896744374
	for <linux-nfs@vger.kernel.org>; Thu, 29 Feb 2024 23:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709250749; cv=none; b=J6y4DfDNudQyk+0nn0D6zZD8O2wm4F9Zy1+3ab8A+kV7J8D5vUOJgn2Mcx1TpiEJwnFJhP5FpHGzNdP8I/LXycNflnNqt9JMpn+ejl3PmcbW+wrn/ddn31BX9lm3yuRCbN6D+3ScYXEXQ1mtjCWFyCZkRCUv84sClG+dFjOuITE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709250749; c=relaxed/simple;
	bh=JH3x5AlqazxA7s9HV1/FHp0BaHbZ8OdRMdkbzJO2hls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKNAiKb67pZr/zwGpei3DuNfn3l5pG5hTxAw1ZIyQInyTfv/L9OuqwIJLsVXlgvwvgQwX9LRoDrMj2kCDMylh+euJd7/wJc5vkI9f/bEeTHI2cdHYY0Ej+92c5uj2UjoVZVHt5IJwFJadjCXJTo4FCiNx9WIym0APkWr9ZtbcH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LDoRExXk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709250746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GDOFyXSyknH2+UPcIbKs/Jsp6Z3XVSjQaEt87q9gM8E=;
	b=LDoRExXkvOMBGpqmRnc+vAE9q5/Wd9nd7g4RsxedvnYAv14qHZcQrWB0yIhw7ct9HDvmFj
	OTqhFMzk5e2cg0HjzKw5ia6fb0Y/SfJ4oHp/Wt/u9372F4U4oDKZiwsIy0kPSHaj2JkTk3
	QGTOL1KFLGERjW/SrS2VntK66pdlcqA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-xkFyZPgHPSadc6b07FCWJw-1; Thu, 29 Feb 2024 18:52:23 -0500
X-MC-Unique: xkFyZPgHPSadc6b07FCWJw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E4BCE88D586;
	Thu, 29 Feb 2024 23:52:22 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.16.176])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CD9AD492BE2;
	Thu, 29 Feb 2024 23:52:22 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id 60D2B12BD35; Thu, 29 Feb 2024 18:52:22 -0500 (EST)
Date: Thu, 29 Feb 2024 18:52:22 -0500
From: Scott Mayhew <smayhew@redhat.com>
To: Orion Poplawski <orion@nwra.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Cannot initiate mount with sec=krb5 as root from EL9 clients
Message-ID: <ZeEYttbCcrqTUO9z@aion>
References: <8b16410b-6b2b-406e-a669-41abee137932@nwra.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b16410b-6b2b-406e-a669-41abee137932@nwra.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On Thu, 29 Feb 2024, Orion Poplawski wrote:

> We are starting to add some EL9 clients into the mix on our network.  Autofs
> mounts are working fine when initiated by a regular user, but they are failing
> when initiated by root.  This works fine from our EL8 clients.
> 
> Client:
> kernel 5.14.0-362.18.1.el9_3.x86_64
> nfs-utils-2.5.4-20.el9.x86_64
> 
> Keytab name: FILE:/etc/krb5.keytab
> KVNO Principal
> ---- --------------------------------------------------------------------------
>    1 host/client.fqdn@NWRA.COM (aes256-cts-hmac-sha1-96)
>    1 host/client.fqdn@NWRA.COM (aes128-cts-hmac-sha1-96)
> 
> Server:
> kernel 4.18.0-513.18.1.el8_9.x86_64
> nfs-utils-2.3.3-59.el8.x86_64
> 
> Keytab name: FILE:/etc/krb5.keytab
> KVNO Principal
> ---- --------------------------------------------------------------------------
>    1 host/server.fqdn@NWRA.COM (aes256-cts-hmac-sha1-96)
>    1 host/server.fqdn@NWRA.COM (aes128-cts-hmac-sha1-96)
>    1 nfs/server.fqdn@NWRA.COM (aes256-cts-hmac-sha1-96)
>    1 nfs/server.fqdn@NWRA.COM (aes128-cts-hmac-sha1-96)
> 
> Client rpc.gssd:
> 
> rpc.gssd[778]:
>                                handle_gssd_upcall(0x7f15a0299840): 'mech=krb5
> uid=0 enctypes=20,19,26,25,18,17' (nfs/clnt3)
> rpc.gssd[778]: start_upcall_thread(0x7f15a0299840): created thread id
> 0x7f159f1fe640
> rpc.gssd[778]: krb5_use_machine_creds(0x7f159f1fe640): uid 0 tgtname (null)
> rpc.gssd[778]: No key table entry found for client$@NWRA.COM while getting
> keytab entry for 'client$@NWRA.COM'
> rpc.gssd[778]: No key table entry found for CLIENT$@NWRA.COM while getting
> keytab entry for 'SRV-MRY01$@NWRA.COM'
> rpc.gssd[778]: No key table entry found for root/client.fqdn@NWRA.COM while
> getting keytab entry for 'root/client.fqdn@NWRA.COM'
> rpc.gssd[778]: No key table entry found for nfs/client.fqdn@NWRA.COM while
> getting keytab entry for 'nfs/client.fqdn@NWRA.COM'
> rpc.gssd[778]: find_keytab_entry(0x7f159f1fe640): Success getting keytab entry
> for 'host/client.fqdn@NWRA.COM'
> rpc.gssd[778]: gssd_get_single_krb5_cred(0x7f159f1fe640): Credentials in CC
> 'FILE:/tmp/krb5ccmachine_NWRA.COM' are good until Fri Mar  1 10:39:34 2024
> rpc.gssd[778]: gssd_get_single_krb5_cred(0x7f159f1fe640): Credentials in CC
> 'FILE:/tmp/krb5ccmachine_NWRA.COM' are good until Fri Mar  1 10:39:34 2024
> rpc.gssd[778]: create_auth_rpc_client(0x7f159f1fe640): creating tcp client for
> server server.fqdn
> rpc.gssd[778]: create_auth_rpc_client(0x7f159f1fe640): creating context with
> server nfs@server.fqdn
> rpc.gssd[778]: WARNING: Failed to create krb5 context for user with uid 0 for
> server nfs@server.fqdn
> rpc.gssd[778]: WARNING: Failed to create machine krb5 context with cred cache
> FILE:/tmp/krb5ccmachine_NWRA.COM for server server.fqdn
> rpc.gssd[778]: WARNING: Machine cache prematurely expired or corrupted trying
> to recreate cache for server server.fqdn
> rpc.gssd[778]: No key table entry found for client$@NWRA.COM while getting
> keytab entry for 'client$@NWRA.COM'
> rpc.gssd[778]: No key table entry found for CLIENT$@NWRA.COM while getting
> keytab entry for 'SRV-MRY01$@NWRA.COM'
> rpc.gssd[778]: No key table entry found for root/client.fqdn@NWRA.COM while
> getting keytab entry for 'root/client.fqdn@NWRA.COM'
> rpc.gssd[778]: No key table entry found for nfs/client.fqdn@NWRA.COM while
> getting keytab entry for 'nfs/client.fqdn@NWRA.COM'
> rpc.gssd[778]: find_keytab_entry(0x7f159f1fe640): Success getting keytab entry
> for 'host/client.fqdn@NWRA.COM'
> rpc.gssd[778]: gssd_get_single_krb5_cred(0x7f159f1fe640): Credentials in CC
> 'FILE:/tmp/krb5ccmachine_NWRA.COM' are good until Fri Mar  1 10:39:34 2024
> rpc.gssd[778]: gssd_get_single_krb5_cred(0x7f159f1fe640): Credentials in CC
> 'FILE:/tmp/krb5ccmachine_NWRA.COM' are good until Fri Mar  1 10:39:34 2024
> rpc.gssd[778]: create_auth_rpc_client(0x7f159f1fe640): creating tcp client for
> server server.fqdn
> rpc.gssd[778]: create_auth_rpc_client(0x7f159f1fe640): creating context with
> server nfs@server.fqdn
> rpc.gssd[778]: WARNING: Failed to create krb5 context for user with uid 0 for
> server nfs@server.fqdn
> rpc.gssd[778]: WARNING: Failed to create machine krb5 context with cred cache
> FILE:/tmp/krb5ccmachine_NWRA.COM for server server.fqdn
> rpc.gssd[778]: ERROR: Failed to create machine krb5 context with any
> credentials cache for server server.fqdn
> rpc.gssd[778]: do_error_downcall(0x7f159f1fe640): uid 0 err -13
> 
> mount.nfs4: mount(2): Permission denied
> mount.nfs4: access denied by server while mounting
> 
> I don't seem to be getting any useful information from rpc.gssd on the server.
> 
> Please include me in replies.

I'm pretty sure this is the same issue that would be addressed by the
patches that I sent to the list yesterday would address:
https://lore.kernel.org/linux-nfs/20240228222253.1080880-1-smayhew@redhat.com/T/#t

There's a couple things you could check.

1. On the NFS server, increase the rpc debug logging just a little:
# rpcdebug -m rpc -s auth

and then after a failure, look for lines like this in the journal:
Feb 29 18:14:44 rhel8.smayhew.test kernel: svc: svc_authenticate (6)
Feb 29 18:14:44 rhel8.smayhew.test kernel: gss_kerberos_mech: unsupported krb5 enctype 20
Feb 29 18:14:44 rhel8.smayhew.test kernel: RPC:       gss_import_sec_context_kerberos: returning -22
Feb 29 18:14:44 rhel8.smayhew.test kernel: RPC:       gss_delete_sec_context deleting 0000000090f401ca

2. On the NFS client, increase the rpc-verbosity in the gssd stanza in
/etc/nfs.conf (I have mine set to 3 but I think 1 would suffice) and
then 'systemctl restart rpc-gssd'.

then after a failure, look for a line like this in the journal:
Feb 29 18:14:44 rhel9.smayhew.test rpc.gssd[1700]: authgss_refresh: RPC: Unable to receive errno: Connection reset by peer

If you see both of those, then it's almost certainly the same issue.

A quick solution would be to do this on your NFS server:

# echo "mac@Kerberos = -HMAC-SHA2-*" >/usr/share/crypto-policies/policies/modules/NFS.pmod
# update-crypto-policies --set DEFAULT:NFS
# systemctl restart gssproxy

but note that would be turning off the SHA2 enctypes for everything
krb5-related, not just NFS.  Note you can always revert that later
simply by:

# update-crypto-policies --set DEFAULT
# systemctl restart gssproxy

Or, you could test the patches I sent to the list yesterday (this would
be on the client, not the server).  The problem is those patches don't
apply cleanly to the current version of nfs-utils shipped in EL9.  At a
quick glance, it looks like nfs-utils would need:

49567e7d configure: check for rpc_gss_seccreate
15cd5666 gssd: handle KRB5_AP_ERR_BAD_INTEGRITY for user credentials
2bfb59c6 gssd: handle KRB5_AP_ERR_BAD_INTEGRITY for machine credentials
3abf6b52 gssd: switch to using rpc_gss_seccreate()
f05af7d9 gssd: revert commit 513630d720bd
20c07979 gssd: revert commit a5f3b7ccb01c
14ee4878 gssd: handle KRB5_AP_ERR_BAD_INTEGRITY for user credentials
4b272471 gssd: handle KRB5_AP_ERR_BAD_INTEGRITY for machine credentials
75b04a9b gssd: fix handling DNS lookup failure
f066f87b gssd: enable forcing cred renewal using the keytab

and you'd also need to patch libtirpc to include:

22b1c0c gssapi: fix rpc_gss_seccreate passed in cred

-Scott

> 
> -- 
> Orion Poplawski
> he/him/his  - surely the least important thing about me
> Manager of IT Systems                      720-772-5637
> NWRA, Boulder/CoRA Office             FAX: 303-415-9702
> 3380 Mitchell Lane                       orion@nwra.com
> Boulder, CO 80301                 https://www.nwra.com/



