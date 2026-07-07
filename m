Return-Path: <linux-nfs+bounces-23137-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4BDOKP0XTWr8uwEAu9opvQ
	(envelope-from <linux-nfs+bounces-23137-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 17:15:09 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF13B71D222
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 17:15:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=janestreet.com header.s=waixah header.b=0tSs2H8O;
	dmarc=pass (policy=quarantine) header.from=janestreet.com;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23137-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23137-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDE103186479
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jul 2026 14:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794C742CB12;
	Tue,  7 Jul 2026 14:44:00 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mxout5.mail.janestreet.com (mxout5.mail.janestreet.com [64.215.233.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222F0340402
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jul 2026 14:43:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783435440; cv=none; b=OR2YjRkn8iKFUO9nnWIpts7lSEuG5GCOaihvBtkIK2Kqsvdc6v6TNMiG1cKxaFSjehOIixZRqUo6l7h1vs28bACLv2WdsIdYNeiEwyEhWVL1fovDQ8K97tT5/d+FsCqkCDJ4qt2fg3tEKN3NJN6L3S+QZKBMGWV1YM3sk6+BHrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783435440; c=relaxed/simple;
	bh=40Daf0fu8ZWF9pRXTQPlIFxpcXc2283fkwYUip+uFhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q2eJ2N/SUN/RgzAHe3mU6UqzKDXJ2sF2HK8r95+9gwoFZYvtY3GJPOOIRNbZ/bPkuPSoGje1b/sBv5OcTCl7PxY7tGs4O9c9TEWvLR3RWv8IyUi6Qnt5Ign63vgBsqHZqwVZzjTfBnMcGiii1q7bdhb8tC+5gUui+DQNtVc6vkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com; spf=pass smtp.mailfrom=janestreet.com; dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=0tSs2H8O; arc=none smtp.client-ip=64.215.233.18
From: tilan@janestreet.com
To: trondmy@kernel.org
Cc: anna@kernel.org,
 	linux-nfs@vger.kernel.org,
 	tilan@janestreet.com
Subject: RE: RE:nfs: opening a file with O_WRONLY|O_CREAT flags can result in permission denied error
Date: Tue,  7 Jul 2026 10:43:57 -0400
Message-ID: <20260707144357.2920584-1-tilan@janestreet.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <122c658755fcb4b2d1264a7fd62fa8eda571f67b.camel@kernel.org>
References: <122c658755fcb4b2d1264a7fd62fa8eda571f67b.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janestreet.com;
  s=waixah; t=1783435438;
  bh=kkwe1a4A3UXVsLlktjJpKUt2ZGSuz3ajQt2wozfpq78=;
  h=From:To:Cc:Subject:Date:In-Reply-To:References;
  b=0tSs2H8Oqfpu038EbRlwutle2JBKS5pQws/kzjFAjYmhRQbje90SrvRxmvhHPc4xj
  /Bve4UzuIDYemNHudyJOVpauLBCEtMNYYqFLU9NpvPv9GGnYrJhBNlH1SyiyTWW1zZ
  2dVnYuhRuYKyQKmjTx9v5Tpn29I23clYRbhQnMnHK8wSBU3YNaZXv5Wl+kbhEO79K6
  0UwZ3ewProAub//SFBfebdXpocWKNXjI3iZozn+Vlsmv7bVRKf9ZROJiiaEqB7gVvb
  jXQIaR0lcrtjcdnqzX0GHwKaXSt1xlOIJbWs3QRE9IGYaXjDScYbH1qeYy+/oiHRfr
  /pjKHb0LaBUsA==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[janestreet.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[janestreet.com:s=waixah];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-23137-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[tilan@janestreet.com,linux-nfs@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,m:tilan@janestreet.com,s:lists@lfdr.de];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tilan@janestreet.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[janestreet.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,janestreet.com:from_mime,janestreet.com:dkim,janestreet.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EF13B71D222

>> Hello,
>> 
>> We recently noticed there is a behavior change w.r.t opening a file 
>> with the O_WRONLY|O_CREAT flags over the NFSv3 protocol after
>> upgrading
>> the kernel from 6.1 LTS to 6.12 LTS. From the packets capturing, it
>> seems
>> like the kernel would now issue an additional CREATE rpc call to the
>> remote NFS server regardless if the target file pre-exists or not.
>> The CREATE rpc request could return an EACCES error if the client
>> only has 
>> the write permission to the pre-existing file but no write permission
>> on 
>> the directory containing the pre-existing file. This causes the
>> openat 
>> syscall to fail with permission denied error which is not expected.
>> 
>> After doing some code tracing, it seems like the new behavior was
>> introduced as part of 7c6c5249f061 ("NFS: add atomic_open for NFSv3
>> to
>> handle O_TRUNC correctly."). We would like to confirm if the current 
>> behavior that we are observing with the 6.12 kernel is expected given
>> that the new behavior breaks existing user's application code. We 
>> currently have a workaround by explicitly remove the O_CREAT flag
>> when 
>> opening a pre-existing file for write, but would still prefer not
>> have
>> to apply this workaround when upgrading to the newer kernel.

> What server are you using?

The permission error was reproduced against a vendor appliance, running
the same test against NFSD seems to yield a different result
(no permission errors) due to differences in behavior from the CREATE 
RPC implementation.

NFSD behavior

  - CREATE RPC (UNCHECKED mode) returns the filehandle of the 
    existing file along with the file's attributes
	  
Vendor appliance

  - CREATE RPC (UNCHECKED mode) always attempts to create a new
    file and returns the new filehandle. This explains why we
    are seeing permission denied error from openat syscall.
	  
RFC 1813 states that 

  "UNCHECKED means that the file should be created without checking
  for the existence of a duplicate file in the same directory. In this
  case, how.obj_attributes is a sattr3 describing the initial
  attributes for the file."
	 
It seems like the vendor's implementation matches more closely to what
the "standard" describes, but the behavior might not be what a normal
user would expect. I guess there is no win-win situation here.

> NFSv3 CREATE is supposed to ignore the directory permissions if the
> file already exists. That is required in order to support basic POSIX
> open(O_CREAT) behaviour. Even with the old code, which did a lookup
> before deciding to send the CREATE, there was a potential for races
> that could have caused the client to send it against an existing file.

Is it expected that the kernel should always do a lookup before
deciding if the CREATE request should be made, from the code, it looks 
like the lookup happens after the atomic_open which does the CREATE rpc.
https://elixir.bootlin.com/linux/v6.12.91/source/fs/namei.c#L3573-L3581


Thanks,
Tian

