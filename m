Return-Path: <linux-nfs+bounces-20480-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4H5QKLnqxmloQAUAu9opvQ
	(envelope-from <linux-nfs+bounces-20480-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 21:38:17 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F80434B19B
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 21:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 50E463029B67
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 20:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137D734252C;
	Fri, 27 Mar 2026 20:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stwm.de header.i=@stwm.de header.b="kxlucF4w"
X-Original-To: linux-nfs@vger.kernel.org
Received: from email.studentenwerk.mhn.de (mailin.studentenwerk.mhn.de [141.84.225.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F304637999D
	for <linux-nfs@vger.kernel.org>; Fri, 27 Mar 2026 20:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.84.225.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774643894; cv=none; b=bPIYJkd0CyNqKafkFc/JDF3hh+D2hef2ddQ3zCGkVj5AII20rxNnNJWaScsTM5Rt/SsklaSHyiFmXb/eQg8BN9r4IkQJomzGExO/fMwVj/daVGRGx2I2xq/u9w8qB9awxH6U5tkgW9yKFUrONUGZnj9nZrQn0dq6eseyaQ0Hqk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774643894; c=relaxed/simple;
	bh=mMrYFDy/lAG5Cur3B08IW06WGZqT2YxPbIvGNNVyeMY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ZLmVCPsRGUd/Gr292y3VLjGBSD4v5S+tPSYrPrV5xFrxSVKiE9GfGxGwVJ4tvMKRewyKmAEf36cSfalO/XeiJd1D2oUeIOu4kmBp+qTdbxWV6d7S41oileTVaB+sLNHZhOGqi5Ww5Qq8v1AilLo4wFRpCIstktaRPq61ubP3mIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stwm.de; spf=pass smtp.mailfrom=stwm.de; dkim=pass (2048-bit key) header.d=stwm.de header.i=@stwm.de header.b=kxlucF4w; arc=none smtp.client-ip=141.84.225.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stwm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stwm.de
Received: from mailhub.studentenwerk.mhn.de (mailhub.studentenwerk.mhn.de [127.0.0.1])
	by email.studentenwerk.mhn.de (Postfix) with ESMTPS id 4fjCC35vV9zRhRQ;
	Fri, 27 Mar 2026 21:38:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwm.de; s=stwm-20170627;
	t=1774643887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zoCiC6DTP1lbiWKisQT6oqiuvvpLLVcwrzI5QptM4HY=;
	b=kxlucF4wnAOa1j5EhIn7DzRoVdKmRoWILLZNnM6t16BXuxL8cT+JpE6nVjEEwZ5ANjHX1r
	jOarlX79fYqJgosRAHC8mD5DAoBaX17k4aaxK6vdYDTrOU/dQaTNG8wCdLK5IsK1w06Mmv
	hqH8EVaRCx40TqHzdMwp8U+R70D/jfLmEOjsQxBF2Amq7vp66Q8bzuakaUV3xq1MSiKEiR
	FnT6e0seqwgU9y8yndLH/Z9HpqYTc+NENlhR/pQRC9dKRaeCnaTpt5PblHb/KYHauTA+tp
	F1nySBdRl7ji789xtdziO29/ZFY67patPF7BgrJDV68L2kxtLWBik7li5KA8Zw==
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 27 Mar 2026 21:38:07 +0100
From: Wolfgang Walter <linux@stwm.de>
To: Chuck Lever <cel@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: Re: 6.18.19 (and probably earlier): get BUG nfsd_file (Not tainted):
 Objects remaining on __kmem_cache_shutdown()
In-Reply-To: <d9a63d25-2cec-4dbc-af0e-6b1ae46266d8@app.fastmail.com>
References: <aa45976e7e85e06a426765c5a17865c1@stwm.de>
 <d9a63d25-2cec-4dbc-af0e-6b1ae46266d8@app.fastmail.com>
Message-ID: <e63939a5749c2cb27bfc33d223dbb954@stwm.de>
X-Sender: linux@stwm.de
Organization: =?UTF-8?Q?Studierendenwerk_M=C3=BCnchen_Oberbayern?=
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[stwm.de,quarantine];
	R_DKIM_ALLOW(-0.20)[stwm.de:s=stwm-20170627];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-20480-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@stwm.de,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[stwm.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0F80434B19B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am 2026-03-27 20:45, schrieb Chuck Lever:
> Hello Wolfgang -
> 
> On Fri, Mar 27, 2026, at 2:37 PM, Wolfgang Walter wrote:
>> Hello,
>> 
>> wenn rebooting our nfs-server I get almost always the following BUG:
>> 
>> Mar 27 18:27:40 rummelplatz kernel: BUG nfsd_file (Not tainted): 
>> Objects
>> remaining on __kmem_cache_shutdown()
>> Mar 27 18:27:40 rummelplatz kernel:
>> -----------------------------------------------------------------------------
>> Mar 27 18:27:40 rummelplatz kernel: Object 0x000000004cc0c6e6
>> @offset=144
>> Mar 27 18:27:40 rummelplatz kernel: Slab 0x00000000e17f7a52 objects=28
>> used=1 fp=0x00000000988570d2
>> flags=0x57ffffc0000200(workingset|node=1|zone=2|lastcpupid=0x1fffff)
>> Mar 27 18:27:40 rummelplatz kernel: Disabling lock debugging due to
>> kernel taint
> 
>> The kernel is vanilla stable 6.18.19. I built it myself.
> 
> Perhaps your kernel is missing commit 8072e34e1387 ("nfsd: fix
> nfsd_file reference leak in nfsd4_add_rdaccess_to_wrdeleg()").

This patch is included in stable 6.18.20 as commit

c07dc84ed67c5a182273171639bacbbb87c12175

=======================================================
commit c07dc84ed67c5a182273171639bacbbb87c12175
Author: Chuck Lever <chuck.lever@oracle.com>
Date:   Mon Dec 1 17:09:55 2025 -0500

     nfsd: fix nfsd_file reference leak in 
nfsd4_add_rdaccess_to_wrdeleg()

     commit 8072e34e1387d03102b788677d491e2bcceef6f5 upstream.

     nfsd4_add_rdaccess_to_wrdeleg() unconditionally overwrites
     fp->fi_fds[O_RDONLY] with a newly acquired nfsd_file. However, if
     the client already has a SHARE_ACCESS_READ open from a previous OPEN
     operation, this action overwrites the existing pointer without
     releasing its reference, orphaning the previous reference.

     Additionally, the function originally stored the same nfsd_file
     pointer in both fp->fi_fds[O_RDONLY] and fp->fi_rdeleg_file with
     only a single reference. When put_deleg_file() runs, it clears
     fi_rdeleg_file and calls nfs4_file_put_access() to release the file.

     However, nfs4_file_put_access() only releases fi_fds[O_RDONLY] when
     the fi_access[O_RDONLY] counter drops to zero. If another READ open
     exists on the file, the counter remains elevated and the nfsd_file
     reference from the delegation is never released. This potentially
     causes open conflicts on that file.

     Then, on server shutdown, these leaks cause 
__nfsd_file_cache_purge()
     to encounter files with an elevated reference count that cannot be
     cleaned up, ultimately triggering a BUG() in kmem_cache_destroy()
     because there are still nfsd_file objects allocated in that cache.

     Fixes: e7a8ebc305f2 ("NFSD: Offer write delegation for OPEN with 
OPEN4_SHARE_ACCESS_WRITE")
     Cc: stable@vger.kernel.org
     Reviewed-by: Jeff Layton <jlayton@kernel.org>
     Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
=======================================================

(in stable since v6.20.4)

Regards
-- 
Wolfgang Walter
Studierendenwerk München Oberbayern
Anstalt des öffentlichen Rechts

