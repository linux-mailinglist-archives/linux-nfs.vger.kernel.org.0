Return-Path: <linux-nfs+bounces-23125-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xc8JDCU6TGrShwEAu9opvQ
	(envelope-from <linux-nfs+bounces-23125-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 01:28:37 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E22D7164D5
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 01:28:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm2 header.b=Nf1TnuLo;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b="l w1r9JM";
	dmarc=pass (policy=none) header.from=ownmail.net;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23125-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23125-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 047A0302450F
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jul 2026 23:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F75A38AC72;
	Mon,  6 Jul 2026 23:28:33 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E45420863
	for <linux-nfs@vger.kernel.org>; Mon,  6 Jul 2026 23:28:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783380513; cv=none; b=A48YoPLikdnHwcIaOloN3xrsIUq0pk+/zr4yQTkrT5Ira4ncrjmc5wjNNk9HpYGeE+4xMx+eGeN04+Uorm1oVEBI8LefY6irpL54+Gc8z0gxhQTzlPebPplOZbJQB8W4pL0JM9rCetFGSbpYx0fNnYpkeHYeswysOIRslC+upAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783380513; c=relaxed/simple;
	bh=kWTSHvhr1sFZWdtJPWeza0EHAP2VDtt0LfBn1ovv/58=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=N+gyloREbgJvBJ9jRGhWtBxA3iq/bMHDvwYfLUOhf/5vqsRzT0GVoRbep9L9wy1v/86G2B2YQIDiC932D1+ZebyXV9hzIbF2aG0Ut2V7lF3EmL0i82Ofp+VYQjAqhrnAhidvKP0EQxX4541CXTCgtTCVd3cK18PwLIWtD+AoajU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Nf1TnuLo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lw1r9JMI; arc=none smtp.client-ip=103.168.172.156
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 33BA31400211;
	Mon,  6 Jul 2026 19:28:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 06 Jul 2026 19:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1783380511; x=1783466911; bh=4vMpT3GVodsdTNjRU+R66Nrk98wSG/Zu2np
	RYt21ntg=; b=Nf1TnuLo2OUrn2aifWnNL3ankIR/KN3u6odJWCJ16Xu90ZoQH6+
	m/o74GQ7d9y5M89wuYpzxVnCRDEBfAt1XJiKFM2+3gkCF2AnHKDzfawMjJ/WrG8V
	84KGlpQlZHxGSQ47bnO0o9FnB8/gJxkcuJ5KRrtP3j6b1tbPI2FS/4I8kaj8HIPU
	bNw2LmOV/huVNb0SwsI8wVSgxDjR9/4YAVc+coJdDfrG3DbgVza8lxGL9SbuOorV
	znaqDAl9Q5ZFcEKBlXAg/GUFHxTbwzhGIeU3b6YDWsuWX/kq6Ci7R+IBUD1pfagu
	iV6zM4eg0jNqm94BBBdqR76fqAMFeGrJQiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783380511; x=
	1783466911; bh=4vMpT3GVodsdTNjRU+R66Nrk98wSG/Zu2npRYt21ntg=; b=l
	w1r9JMI8Bkxa3VMzknCsIqNsdGBcW0INRuTKBF6oa5YhWPetitCL5Scb0CTftH9K
	S7l+6et6AA9LLsQFVKN04CFwb66eEnRy7WnlVTIm7Y0P3OsufzrrjGVnKQkQFw3J
	CIaWB4orso5cG/Lg6WVXwIHIIdAsC/HSTnNt4KH9FBfXQjtpzWrsx1cstaSdBmV3
	7NCAb1AARDljBjADrGeoApdXjof4IncSQqAR9VRaHtr+iNnkh7DFYDmiCutBU2WH
	ZMXZSyR6CVKtFljR8lB65r9kiQZ7DmmtwLSl99uUpUXLw/4j3Y8XU+UyhiU9DQ9y
	kkCo/NbVDbn8szW5HOELQ==
X-ME-Sender: <xms:HzpMajWeZcdB2n7oHtOpSBuVcwn3ATIrTdXYLkN-1JSgMei5ZkGmbw>
    <xme:HzpMavQ7tfjbeHHuaMnh0syFqFUzQtW1X609kldydZE3HyIEsfhAGXzRmVySNpdy9
    waCDtE7JwcIyjVgH7zh-eorelWIA6LVRCuVX4CpKYQRrUcC0R8>
X-ME-Received: <xmr:HzpMapMZu97tNyf4FrJ3-POFov3K-U0NrLkPUX1XQYtE2F33ybuyjg7a1q-9o4seLvX5g1rJL5rXIqGkA4v8p--Sb2yFlYE>
X-ME-Proxy-Cause: dmFkZTE3P7kCw0ubw1PF8CMlGxNXQ+eiJydmPKKX1SPSTosI5fDN84JdGGp9May30JjwbZ
    jqwo0xdy40NuA8YEOI7x37pCpJcrY3tBImm0w08NCx7fWis6YsQiBM2u7GDuwD9G+7AUVR
    0KA9wJJw+ots9vc7HkELJBvh7XD/cVM63DoTRlFpWdcTKxjsB0CXsB3NNJEgVRZgxf1uuB
    B6F4D6LQnuaycwcAajp3+NZHOpE5Kf+lahWCKQIQwfmlJAN9YMUk9EFEQja2kv97jBEHhY
    eNIUCwQb7el5RSzmX+r+4frw3dUiBuHtsupMWsxd7H9KrWPOnL4ZCzPWBmsNhNo5cRi9dc
    f0rmMUwMxMHR1/TOw+X5iQqboer6sqeiMXuFldZWsQ/XB7sNL3gvke01nlvB/fNF+a2vek
    0oIUc6CVOGucLtYkhhMmnHQUYOjQZCkzjV54n3/V082wkFxbAueFsXafUTrkOb0m1Wv/1h
    KY98v1VkD+U4Pvimij7PYZA/tSYGBYSTTB++O72rDOOJVkmU9uA8yCxBYzDogYXIt7cqBO
    sNuRgrjNWfO5+gK1dMaOrhNzQWvzHULc/OZC1QjdUSE37ZhGZqvve9besJYDtZMtrr/D2C
    v9YqmMIOOmF/xuwDlmxR5WFTAGmsuEi7GQj+iFJCJq7dd3Q7aalpwh1h4kaw
X-ME-Proxy: <xmx:HzpMalRlFeDeABp1vQjnyJkLTcVgt5py-Z_r04j-GUqw6JmCKDsHzw>
    <xmx:HzpMavhrC0obusNtlZeEqnPPsPhy60hxvIcjOK-1ODzUq_623pxxhA>
    <xmx:HzpMam_nrfFQX31S0-_Q14U2bnS6zcRZ61wcmrAawOWNwll_2EzQ4A>
    <xmx:HzpMauG6Vc-8COC62pa9wz2XMe6huWlYMbagjMqpFMt2nGxtQrzgTQ>
    <xmx:HzpMao1jWJlT-ak0RVnxOR9_aNSkOMZN6HN8eE_fcDHWKjBw3kjEXgdl>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 19:28:29 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 06/14] nfsd: in nfsd4_create_file() let VFS report if
 file was created.
In-reply-to: <8ef43a6cfb235b0ef449388d56a4faeab492160c.camel@kernel.org>
References: <20260705222032.1240057-1-neilb@ownmail.net>
  <20260705222032.1240057-7-neilb@ownmail.net>
  <8ef43a6cfb235b0ef449388d56a4faeab492160c.camel@kernel.org>
Date: Tue, 07 Jul 2026 09:28:25 +1000
Message-id: <178338050586.27465.16700298229223579148@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-23125-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:chuck.lever@oracle.com,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,messagingengine.com:dkim,noble.neil.brown.name:mid];
	FORGED_SENDER(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6E22D7164D5

On Tue, 07 Jul 2026, Jeff Layton wrote:
> On Mon, 2026-07-06 at 08:19 +1000, NeilBrown wrote:
> > From: NeilBrown <neil@brown.name>
> > 
> > nfsd4_create_file() currently assumes that if a lookup failed but then a
> > create succeeds, then the "create" operation actually created the file.
> > With atomic_open this may not be the case - some other actor might have
> > created the file between the lookup and the create.
> > 
> > So we move the call to nfsd4_vfs_create() earlier and set ->op_created
> > based on the FMODE_CREATED flag that it set.  Then use "!  ->op_created"
> > to trigger nfserr_exist handling.
> > 
> > The switch statement is split up into two if() statements.
> > First we check for the possibility of a successful exclusive
> > create and set ->op_create to true if appropriate.
> > Then we check for NFS4_CREATE_UNCHECKED to decide if a
> > pre-existing file means an error or success.
> > 
> > This allows us to combine the two fh_compose() calls to one place.
> > 
> > A subtle difference here is that we now must only pass O_EXCL to
> > dentry_create() for NFS4_CREATE_GUARDED.  For the EXCLUSIVE create modes
> > we want a successful open even if the file already exists.  We then
> > check the verifier after the open succeeded to see if it was exclusive.
> > 
> 
> Do we really want a successful open in the EXCLUSIVE cases?
> 
> Opens have side effects (notably, that they can cause delegation
> recalls). If you have two racing clients creating a file, the first
> gets an open and write delegation and then the second ends up
> immediately causing a delegrecall for the first, even though it may
> never touch the file again after the OPEN fails.
> 
> I think we may want to reconsider that logic, if possible: Maybe we
> should keep using O_EXCL in those cases and just re-drive the open
> without it if it fails and the verifier looks right? That's a bit
> uglier, but that may cause fewer delegation recalls.

Thanks for raising this.  My thinking was that next EXCLUSIVE creates
was weird.
If the server is re-exporting NFS, then think about what happens to the
verifier stored on the backend server.
First the verifier from the intermediate server is stored, 
then the nfs client on the intermediate server sends a SETATTR to remove it, 
then the intermediate server sets the verifier from the originating
client.
then the originating client removes it.

So 4 setattrs altogether.

Also if the intermediate server ever gets a retransmit of the OPEN
request, it will send an EXCLUSIVE open to the backend server which will
fail even if the verifier is still correct.

I agree that recalling a delegation needlessly is not good, but will it
happen often?  If the app checks for then name before trying the O_EXCL
open, then the delegation would not get recalled because the OPEN
wouldn't be tried.  I wonder how often that happens....

I think setting O_EXCL in the NFS4_CREATE_GUARDED case is important.
I'm open to discussion around the issues with O_EXCL and the
NFS4_CREATE_EXCLUSIVE case.

Maybe doing a lookup first when the exported fs is NFS would be an OK
compromise.

Thanks,
NeilBrown

