Return-Path: <linux-nfs+bounces-20053-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COIvCTmBsmm6NAAAu9opvQ
	(envelope-from <linux-nfs+bounces-20053-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 10:02:49 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D0226F533
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 10:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF7D7318F0D7
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 08:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF5A385539;
	Thu, 12 Mar 2026 08:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="aGkXHi1t"
X-Original-To: linux-nfs@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC1B2868A9;
	Thu, 12 Mar 2026 08:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773305801; cv=none; b=HDMGuzaNMlsNxjmNXowFVFcvEw6Qr/Y3LvBPZ7dMuANTAWJHxYF8sk09zqqVdR9glOnX59i8DloTjd1as0zbcu8LvNg55gIXr5qV1GvboPF+ZfuydDFzYxqG7V+JbKJHcCrQc/zOwnskmaQpt+UCrJLJx2OKXHH5JG/KchE8XXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773305801; c=relaxed/simple;
	bh=udAADNla+gD5Kg7TNNkEjGVgcZhIt9VleXGFPsnbd1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ewBlAodNWd9DitDCu2agKxiKQ1nJQeK0hDM6ObTQJP+etnLoyUz4mkLNig318xAfMzeuC0omrjdn2/MJv3Pp+vtjsQjI2KoVwWdh0r8qEi6Ei66T2DfNdb2wPxbFAhnvTXB/V6yAlbecFW+RPy8AOirvRIuF8K1Z6sW0UpDGml8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=aGkXHi1t; arc=none smtp.client-ip=188.68.63.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from mors-relay-8201.netcup.net (localhost [127.0.0.1])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4fWhKl1x7bz3yl1;
	Thu, 12 Mar 2026 09:55:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1773305755;
	bh=udAADNla+gD5Kg7TNNkEjGVgcZhIt9VleXGFPsnbd1E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aGkXHi1tlw5rw4xnlTBGIkPAht7Z2SbsUnoN1gjmGTWD2b67dmovA2Kzl3bvcKIyw
	 kxwYRwskG+iLRhNieECEFgbTpoK1c2W2/YhcGAdeBZR78SQ7wZjpyBWxGa5TvbqGSh
	 P5MoxS4z8lAXt9nj9gRF8lU/jUoHO3Ql+eXDmzwpSJqych4+MZizZ6tZjiPh8y6Xp8
	 +Ot42dlDwrZHrOA8Da37V3FrLqptq8kdbcOfH9DoDcVIhKkqn0qQ/U1lh2hniSt1Aw
	 jkBhtN17EuBz0+QV7nMsJTfQpXMtg1jJV2gZZwKBacvRfRJ5xA5aiHlHB/JyITb4G8
	 kKeUfFnDZ4V6A==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4fWhKl1BM8z3yfx;
	Thu, 12 Mar 2026 09:55:55 +0100 (CET)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4fWhKk3dHwz8svH;
	Thu, 12 Mar 2026 09:55:54 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 8A99D61790;
	Thu, 12 Mar 2026 09:55:53 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <6ba41798-9c69-44f5-9a4e-09336c75a4b9@leemhuis.info>
Date: Thu, 12 Mar 2026 09:55:52 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression: Missing check in nfsd_permission() causes -ENOLCK No
 locks available
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>
Cc: 1128861@bugs.debian.org, Tj <tj.iam.tj@proton.me>,
 linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>,
 stable@vger.kernel.org
References: <c0f15088-3fc0-487a-9f24-cf89c158420d@proton.me>
 <177266540127.7472.3460090956713656639@noble.neil.brown.name>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
X-Enigmail-Draft-Status: N11222
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 MEK4
In-Reply-To: <177266540127.7472.3460090956713656639@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <177330575393.3930331.13341792167684566239@mxe9fb.netcup.net>
X-NC-CID: URiz7v8X2Yjl7b8Z2nfSBppfzzGFbIqUAbGcAHeTkCEdl1WsA3E=
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	TAGGED_FROM(0.00)[bounces-20053-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,leemhuis.info:dkim,leemhuis.info:mid];
	DMARC_NA(0.00)[leemhuis.info];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 06D0226F533
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/5/26 00:03, NeilBrown wrote:
> On Tue, 24 Feb 2026, Tj wrote:
>> Upstream commit 4cc9b9f2bf4dfe13fe573 "nfsd: refine and rename 
>> NFSD_MAY_LOCK" and
>>   stable v6.12.54 commit 18744bc56b0ec  (re)moves checks from 
>> fs/nfsd/vfs.c::nfsd_permission().
>>
>>   This causes NFS clients to see
>>
>> $ flock -e -w 4 /srv/NAS/test/debian-13.3.0-amd64-netinst.iso sleep 1
>> flock: /srv/NAS/test/debian-13.3.0-amd64-netinst.iso: No locks available
>>
>> Keeping the check in nfsd_permission() whilst also copying it to 
>> fs/nfsd/nfsfh.c::__fh_verify() resolves the issue.
>>
>> This was discovered on the Debian openQA infrastructure server when 
>> upgrading kernel from v6.12.48 to later v6.12.y where worker hosts (with 
>> any earlier or later kernel version) pass NFSv3 mounted ISO images to 
>> qemu-system-x86_64 and it reports:

Neil, thx for the explanation.

Jeff, do you have any opinion on what Neil suggested (see quote below).

But as Neil mentioned, it's a regression, so it must be handled some
way. And it looks like this stalled. Given that the commit in that
caused this is somewhat old, I wonder:

Is that something we expect other people to run into?

If yes, I'd say Linus expects us to fix this.

And if not: is there something the Debian openQA infra (a) can and (b)
is willing to do to work around this regression cleanly (by upgrading
Qemu or something like that maybe)? Then we maybe can leave things as
they are[1].

Ciao, Thorsten

[1] see the hand-holding aspect mention in
https://www.kernel.org/doc/html/next/process/handling-regressions.html#on-exceptions-to-the-no-regressions-rule

>> !!! : qemu-system-x86_64: -device 
>> scsi-cd,id=cd0-device,drive=cd0-overlay0,serial=cd0: Failed to get 
>> "consistent read" lock: No locks available
>> QEMU: Is another process using the image 
>> [/var/lib/openqa/pool/2/20260223-1-debian-testing-amd64-netinst.iso]?
>>
>> A simple reproducer with the server using:
>>
>> # cat /etc/exports.d/test.exports
>> /srv/NAS/test 
>> fdff::/64(fsid=0,rw,no_root_squash,sync,no_subtree_check,auth_nlm)
>>
>> and clients using:
>>
>> # mount -t nfs [fdff::2]:/srv/NAS/test /srv/NAS/test -o 
>> proto=tcp6,ro,fsc,soft
> 
> Linux has two quite different sorts of locks - flock and fcntl.
> flocks lock the whole file, shared or exclusive.
> fcntl can lock any byte-range (including the whole file), shared or
> exclusive.  flock and fcntl locks don't conflict.
> 
> exclusive flock locks only require read access to the file
> exclusive fcntl locks require write access to the file.
> 
> The NLM protocol only supports one type of byte-range lock.  It is
> natural to map fcntl locks onto NLM locks.  The early Linux NFS
> implementation handled flock locks entirely locally so different clients
> didn't conflict.  This could be confusing but was widely documented and
> understood.
> Some years ago Linux NFS was enhanced to handle flock locks like
> whole-file fcntl locks.  This means that clients with flock locks would
> conflict (maybe good) but that flock locks and fcntl locks would now
> conflict (maybe bad).
> You can still get the old behaviour with "-o local_lock=flock".
> 
> So if you open a file on NFS read-only and attempt an exclusive flock,
> that will be sent to the server as a full-range fcntl lock which should
> require write access.  If the server finds you don't have write access -
> you lose.
> 
> It would seems to make sense to tell qemu that the device is read-only. 
> Then it will hopefully only request a shared lock.  Can you try that?
> 
> Note that even before my patch, if the filesystem was exported read-only
> or mounted read-only on the server, then exclusive flock locks would
> fail.
> 
> I think that the current behaviour is correct, however I do understand
> that it is a regression and maybe that justifies incorrect behaviour.
> Maybe Jeff, as locking maintainer, would be willing to do something like
> 
> diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
> index dd0214dcb695..6c674fc51bab 100644
> --- a/fs/lockd/svcsubs.c
> +++ b/fs/lockd/svcsubs.c
> @@ -73,6 +73,14 @@ static inline unsigned int file_hash(struct nfs_fh *f)
>  
>  int lock_to_openmode(struct file_lock *lock)
>  {
> +	/*
> +	 * flock only requires READ access and to support
> +	 * clients which send flock locks via NLM we
> +	 * report O_RDONLY for full-file locks.
> +	 */
> +	if (lock->fl_start == 0 &&
> +	    lock->fl_end == NLM4_OFFSET_MAX)
> +		return O_RDONLY;
>  	return lock_is_write(lock) ? O_WRONLY : O_RDONLY;
>  }
>  
> 
> But I wouldn't encourage him to.
> 
> NeilBrown
> 
> 
>>
>> will trigger the error as shown above:
>>
>> $ flock -e -w 4 /srv/NAS/test/debian-13.3.0-amd64-netinst.iso sleep 1
>> flock: /srv/NAS/test/debian-13.3.0-amd64-netinst.iso: No locks available
>>
>> A simple test program calling fcntl() with the same arguments QEMU uses 
>> also fails in the same way.
>>
>> $ ./nfs3_range_lock_test 
>> /srv/NAS/test/debian-13.3.0-amd64-netinst.{iso,overlay}
>> Opened base file: /srv/NAS/test/debian-13.3.0-amd64-netinst.iso
>> Opened overlay file: /srv/NAS/test/debian-13.3.0-amd64-netinst.overlay
>> Attempting lock at 4 on /srv/NAS/test/debian-13.3.0-amd64-netinst.iso
>> fcntl(fd, F_GETLK, &fl) failed on base: No locks available
>> Attempting lock at 8 on /srv/NAS/test/debian-13.3.0-amd64-netinst.overlay
>> fcntl(fd, F_GETLK, &fl) failed on overlay: No locks available
>>
>>
>>
>>
> 


