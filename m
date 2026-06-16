Return-Path: <linux-nfs+bounces-22648-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8o4xCM3hMWperQUAu9opvQ
	(envelope-from <linux-nfs+bounces-22648-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jun 2026 01:52:45 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 88624695CAA
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jun 2026 01:52:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=P2AL17nv;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22648-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22648-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73ECA301725B
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 23:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC4C3D88EF;
	Tue, 16 Jun 2026 23:52:40 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9757121D596
	for <linux-nfs@vger.kernel.org>; Tue, 16 Jun 2026 23:52:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781653960; cv=none; b=PnrmUgCY6a4j2UQYrOxokav3J9kAEEwjDkGEmHWQkAi8WOttm+KkCJSm25WHXkXogpOsINJK6s3mmgZCMgHrRpqM4cOlPp/C4dDBz6R1l8IDQDtnF4HUKU43OOTa9Hls9GjUW7KvITavDTWsQmqGfzFW+kWSJgemQhJolKWSSmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781653960; c=relaxed/simple;
	bh=lStjC9LCIqnlSYTTHtozq5fQTNrzkwNhWPyy6lZ/k6Q=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=s94PB+kmywNwr0ntYO2+1YZMbLskX70Ok9lRAvh+11H9hwBIhPt9aB4EabzUGPDKmNucSg4D+jt1Em0xEH9Yz5xK1YcKwqROIj9Ds6J913g8aatd8m/RyZvYR/D/ERbqQhMMyD22ifnSKa1D/wyzZf6kKAJhdmmL9SQByKsIqYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2AL17nv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7E61F000E9
	for <linux-nfs@vger.kernel.org>; Tue, 16 Jun 2026 23:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781653959;
	bh=2PGFMcZQgbKQIiP0tOkTJWkJgankUzGNfIcpo79TfmM=;
	h=Date:From:To:In-Reply-To:References:Subject;
	b=P2AL17nvndOUdhICk6lA9kkNV4sTQqncFnf6bIpPhSwXhydQWuOxZpr+TNmCu23at
	 dgHh7oXZFc/3hmaurtHTcVAXnZBu17XbSVrF6oKZafTwvxNG5nPM38QXDZLwRFBan1
	 k+/oyxiNf+C5i3KwRiBkV57ejdgxSvLrkBIfGPjj1Ag7U7++ohQKgbGoEhLhPsPa5J
	 ZEHfriNm8ofFRekXxOC7YxApQ5t9+UDFX+HEXcuAmXyfXPJnbc5qREjdKX27BusrpX
	 Y9BopGBS/EWmFYKecRU9QnRsYLDjNxaDfO7da2xAOSk156sWW/eJkkqUKsHpvASm4a
	 8AXVPve5KxMOA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 41FFFF40073;
	Tue, 16 Jun 2026 19:52:38 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 16 Jun 2026 19:52:38 -0400
X-ME-Sender: <xms:xuExalMkkbhJGNOT-5IkG_bMBPfIPA-XbNvK8NSzJfBGTAHlDmRQBQ>
    <xme:xuExaizdgU7vaVwGSUzUvaEB512-IVrbt72_SeeYM3vlRapq3zKj7unrSlutjEXk5
    KmZTtdKyoZxfySKVbSDMnXTEmdfueu2vtensyVMPcGlSX__J8ANVeY>
X-ME-Proxy-Cause: dmFkZTGVQrd5dSRSiAW5GJeQyQ2RSBb1wa0g34jCC3OBnQ5HCrANrPgfrJfYJA/3StbLzR
    ALBLxiBNMuJXZxSyR1HEZl0sH8j0mO47H317C68JK1yQCIH07WzeYiIi9vElv8XHqV/AiJ
    626e8svWp8hsX24TU3IdTwblf4GU318Zce5Je2opBAkjxMgm81hZpNMuymP5rODbN9Usj4
    nqX0H9ygw8+t/dTK5Ugsg6GDfKaruhC2mSXr27D25cG2v41Y7ThfhW5WXKXBS8np7SfiE4
    e6+Z0SnMahsD2pATuW8M1ednHZSMGs5CrEWhHFvfXhz0VNpnlfI3ttU3YdCbJcXjo607P2
    xuis0ZvSmn8q5p7h5wOwj8+w9Me4kWFwfpe/R2l+Y5SvbjkNoQW4SkOMdDq+R6kCG7TEX3
    efSKF3epDyeHILQw/ezocSX2F7XlJZ7xOx2MBLQOr1rwVkc0BB13/SFfVPxG3/8V5kUKDJ
    f+HVLORWkenw3mVYRcqGLN3p6FiAd0b+nSWzRQaSE/jR2TPkwvYy07A9cNh9z0bNBj8VOR
    VI1C4/qPow/eJUiacEcfMtdHPp2CGe60nrs5nVK4h3mSm4Afa+PXz74irSWWoLtouwnfn6
    FNbPDoS24APDvK7figm+dBDZYOGbkadbBBbJ6FMmbSHHYSmqYgei5vSSpfew
X-ME-Proxy: <xmx:xuExatLL--stJn163-wziMUgt_acAFURq3v8kFmUTAqu4kI37KXRzA>
    <xmx:xuExag74tp0zGw6U-HPIBovbf6j7gp5f3nwpX02_MUfyeIlBDWhTdw>
    <xmx:xuExaoytDcW7FQFt-y4M49V89G3uOSaWfP5T64-VOUQYLdkJYasm0Q>
    <xmx:xuExasYtYKAHmT5ElqNp7N1-VrIFk-siUiL2zATBWvhj3qGncVeUig>
    <xmx:xuExaiRrbgZ1C4w9SJSy4i35ge266VnxJnmR5X3RdFHqdMSUlFdKo4xJ>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 22419780075; Tue, 16 Jun 2026 19:52:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 16 Jun 2026 19:52:17 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@poochiereds.net>, robbieko <robbieko@synology.com>,
 linux-nfs@vger.kernel.org
Message-Id: <9695b086-512d-4be6-9730-20d490519b15@app.fastmail.com>
In-Reply-To: <cb4eedd0becf980ed5d8113f54eb5d35ed56ae5c.camel@poochiereds.net>
References: <20260616054027.2360930-1-robbieko@synology.com>
 <cb4eedd0becf980ed5d8113f54eb5d35ed56ae5c.camel@poochiereds.net>
Subject: Re: [PATCH v3 1/3] nfsd: reject out-of-range useconds in NFSv2 SETATTR/CREATE
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.15 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22648-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jlayton@poochiereds.net,m:robbieko@synology.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[synology.com:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,app.fastmail.com:mid];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 88624695CAA



On Tue, Jun 16, 2026, at 3:18 PM, Jeff Layton wrote:
> On Tue, 2026-06-16 at 13:39 +0800, robbieko wrote:
>> From: Robbie Ko <robbieko@synology.com>
>> 
>> The NFSv2 sattr decoder converts the wire useconds to nanoseconds in
>> svcxdr_decode_sattr():
>> 
>> 	iap->ia_atime.tv_nsec = tmp2 * NSEC_PER_USEC;
>> 
>> tmp2 is a u32 and NSEC_PER_USEC is 1000, so the product is computed in
>> unsigned long. On ILP32 that is 32 bits, and an out-of-range useconds
>> value such as 4294968 wraps to tv_nsec == 704. The corruption therefore
>> happens during decode, before any proc function can inspect the value,
>> and a later range check on tv_nsec would see an in-range result and
>> accept it.
>> 
>> Guard the raw useconds before the multiplication and reject values
>> greater than 1000000. useconds == 1000000 is kept: it is the Sun
>> convention for "set to the current server time", and the in-tree Linux
>> NFSv2 client emits it in both the atime and the mtime field for a plain
>> touch / utimes(file, NULL) (see encode_sattr() and
>> xdr_encode_current_server_time() in fs/nfs/nfs2xdr.c). Rejecting 1000000
>> would turn that common operation into a hard decode failure for both
>> SETATTR and CREATE. 1000000 * NSEC_PER_USEC is 10^9, which does not wrap
>> on ILP32, so the Sun convention value passes through safely; only
>> genuinely out-of-range values (> 1000000) are rejected. The atime and
>> mtime guards are therefore symmetric.
>> 
>> The decoder only applied the Sun convention in the mtime block, which
>> clears ATTR_ATIME_SET|ATTR_MTIME_SET when mtime useconds == 1000000. If a
>> client puts 1000000 in the atime field but not in the mtime field, the
>> atime block stored an out-of-range tv_nsec (10^9) and left ATTR_ATIME_SET
>> set, so the bogus value reached the filesystem. Apply the convention in
>> the atime block as well, clearing ATTR_ATIME_SET so the server uses its
>> current time and ignores the value. Only ATTR_ATIME_SET is cleared there;
>> the mtime block keeps its existing behavior, where 1000000 means "set
>> both atime and mtime to now".
>> 
>> Signed-off-by: Robbie Ko <robbieko@synology.com>
>> ---
>>  fs/nfsd/nfsxdr.c | 31 +++++++++++++++++++++++++++++++
>>  1 file changed, 31 insertions(+)
>> 
>> diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
>> index ae71e0621317..48a4e89a5f41 100644
>> --- a/fs/nfsd/nfsxdr.c
>> +++ b/fs/nfsd/nfsxdr.c
>> @@ -172,14 +172,45 @@ svcxdr_decode_sattr(struct svc_rqst *rqstp, struct xdr_stream *xdr,
>>  	tmp1 = be32_to_cpup(p++);
>>  	tmp2 = be32_to_cpup(p++);
>>  	if (tmp1 != (u32)-1 && tmp2 != (u32)-1) {
>> +		/*
>> +		 * Guard the raw useconds before the unit conversion below.
>> +		 * tmp2 * NSEC_PER_USEC is computed in unsigned long, which is
>> +		 * 32 bits on ILP32, so an out-of-range value would wrap and
>> +		 * silently produce a bogus in-range tv_nsec. useconds ==
>> +		 * 1000000 is the Sun "set to current server time" convention
>> +		 * (see the mtime block below); allow it and reject anything
>> +		 * larger. Note 1000000 * NSEC_PER_USEC is 10^9, which does not
>> +		 * wrap on ILP32.
>> +		 */
>> +		if (tmp2 > 1000000)
>> +			return false;
>
> The logic looks fine, but rather than having these verbose comments
> above each use of 1000000, it'd be better to declare a constant and
> document its use once above that.
>
> Something like this (and consolidate the comments above that):
>
> #define		SUN_V2_SET_TO_NOW	1000000
>
> Though I think the current fashion is to use enums for this so they
> show up in the debugger.

The applied version of this patch defines such a symbolic constant.
Robbie, no need to resend.


-- 
Chuck Lever

