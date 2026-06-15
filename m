Return-Path: <linux-nfs+bounces-22559-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tCSUAnkWMGoKNQUAu9opvQ
	(envelope-from <linux-nfs+bounces-22559-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jun 2026 17:12:57 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F84E68784D
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jun 2026 17:12:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=asFGbu86;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22559-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22559-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AFC03125687
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jun 2026 15:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71566400DFE;
	Mon, 15 Jun 2026 15:08:00 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F28400DF1
	for <linux-nfs@vger.kernel.org>; Mon, 15 Jun 2026 15:07:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781536080; cv=none; b=Sa0z4pUzW2rlNz9j211njwD8RHh/xGDJOqNxHbZDxMeBvzFH7gxyzewD+nwCVw49npuZZm3iKVFk/d7+BG3aVPOw/4MaMKnG7KhL6AxT2hg+PMolQ46p6iLW0woI/mpevH5Fzg3MWKJbqH1QLots6TAk3yi+hoMKuKeM1xdsoJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781536080; c=relaxed/simple;
	bh=PynesXexXCDYuG+ezihJpBnM/5sqzxsvv40mSwZFvPM=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Ibvp4YRuNuuRIAIXJah2uXl9WpT1la6eRDOyYQwmFocztSVP8r9/mRWoEuXfSjV7ElAVIqbjX98f7sktFL/aYmtv3s308CCTvjLIRnhDkkAsW3Rc5BBKOwHrX6hCpNtRrDXKbT+iyiJOyGHVgl+fCHm8ZlekzOCNV3vckoJG8XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asFGbu86; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34601F00A3A;
	Mon, 15 Jun 2026 15:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781536078;
	bh=RPWaQ1pk51TdYBLrTVBdOW4WGg3A91lWl7TlImFOFik=;
	h=Date:From:To:In-Reply-To:References:Subject;
	b=asFGbu86mfarVZfKtEopn2zyHEmZ+vnXt3GBWsIptiGpywHMs/ws6NyhgZ1N5r4nL
	 wb1qWCNi4zsltVBgch/HcfoKZoKe8Kt+WBMrjv6DQnNvUfu1N+uVfdYlY/UABA3U/4
	 rkAgW4BvC9+zbkHo4LHr582lmK0lRI57RfDj9iA35X90LQKHUk4cy/dafxHBdniBjf
	 glhvb4YQFvlZmVltuequx7PlQZ3Wwv1FAPBUe6GgUQX14pWNiHLSk+frtgxgo2RAoF
	 KLS9WR9EPJsHCpQHVyt7pA4M5KMbxGj1b4e+ZO7s8bmav63PYkfGcHkJtUxCrlzjGL
	 +/bQOh89wTFNg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id D9A37F40068;
	Mon, 15 Jun 2026 11:07:57 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 15 Jun 2026 11:07:57 -0400
X-ME-Sender: <xms:TRUwahIWjz9Quzo4VuM8l4D76wZOKIvfa0ZX8JUZxP4_PkhGzyT4IQ>
    <xme:TRUwan9l522pX-NZsdoWBtQ_OR2Twq7KuT2GEJ-KOkYBzmtZ1jmfAokRhiQh_eyze
    _CDFWwMeMlkbkdxUFaq6o0k1o9UjAAOb9DzPK-oj5oe-jNzQEcT-FA>
X-ME-Proxy-Cause: dmFkZTFrjTiyHaVE5jNgAG72muVJ74QCyojOrasa52QXRP26TSWqPyPZz45JkIARZ9tvul
    aKVE069kae3PNGpth60Wv/8LaBD6g14dUyotryqoQmmoMsvbwvJvWv8ZWTh7QXbKkUdQho
    LYvLIyfdpQspWZwfIli+uCagty/gA9pEZ4e1u3UyDlTShMjLEI9noUn+omaEebOk9ra9Al
    kKbjOGl8nE1tbfI5GM9bh5vRJPdEmFOJp6he8d7xmfbRbT3aVsf+ewmO5RRbubHYDYkGvG
    9MyHsfsNmAnzS9h6zjbYl57D4ANIzREJEjQNVJvZUMmuHPmjO1XJnbBrdF2H9T3wLR4Id2
    hguXbmqTcrgLJIPBhKM46iYh/SAotm3VKBUS/jCQd4kX3RAD3YJlJ+SR4ee1JQDZx3wU7o
    PjDn6N0V/PlyFTVRlIKRpMtGAWwNGVk2L7RtONGY9XICJoGw4zeUpQDRE365EGebA1hEZj
    GvvvbnkW8oB/eG5n2qQDvMaavc2vHF61g28zYNH2hkFiz7J7Sd5ZDUoX2DJ2chJZ+Xn9G1
    du9Jj3CoUNZmV1Jb2fAaXymC+LUK0z3QjOBUbXxFJdR+CGUq2SYxM+P2xB/ql9cXe2Xvx+
    KlpQAsSwYINn4P7ZZwXtP+5rKwMvi8n0by922UpqMq5IzGMW+vwNBu7SazBA
X-ME-Proxy: <xmx:TRUwar0l8_x-8baUCBgWZn5-ROcZ6rTi1V_UlvB5AJQGuplhohMlGg>
    <xmx:TRUwaoAohf-3e8vi7lCHh0nLspCd9qX-W62fgvlvzWO-scOX0Jl1dQ>
    <xmx:TRUwaje8261j0qaM-TPMuyQCSLeXKd2Y6wi03DxD-IlFjyqCDOBOtA>
    <xmx:TRUwath49EPB1wPt71PphUSuBrLxtEcp9NI-R9EZ0oQkZa8O8bq5Bw>
    <xmx:TRUwaro2XiYaWPaxK9AxjOS09Hcf2DQonXYknn0q5FlvdgG4hAIP606Y>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AA0E1780070; Mon, 15 Jun 2026 11:07:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A62qhbDjYYHF
Date: Mon, 15 Jun 2026 11:07:37 -0400
From: "Chuck Lever" <cel@kernel.org>
To: robbieko <robbieko@synology.com>, linux-nfs@vger.kernel.org
Message-Id: <3d50191e-b225-4e8d-9795-3d0ae715115c@app.fastmail.com>
In-Reply-To: <20260615011520.1477943-1-robbieko@synology.com>
References: <20260615011520.1477943-1-robbieko@synology.com>
Subject: Re: [PATCH v2 1/2] nfsd: reject out-of-range nseconds in setattr atime/mtime
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.15 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS(0.00)[m:robbieko@synology.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22559-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,sashiko.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,synology.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1F84E68784D



On Sun, Jun 14, 2026, at 9:14 PM, robbieko wrote:
> From: Robbie Ko <robbieko@synology.com>
>
> A client can send a SETATTR (and, for NFSv3, a file creation) carrying
> an atime or mtime whose nseconds field is out of range. The value is
> well-formed on the wire and decodes cleanly into a valid uint32, but it
> is not a valid timespec64: tv_nsec must be less than NSEC_PER_SEC.
>
> Nothing in the path clamps it. notify_change() runs the time through
> timestamp_truncate(), which does not reduce tv_nsec below NSEC_PER_SEC
> when the filesystem supports nanosecond granularity (s_time_gran == 1),
> and the inode atime/mtime setters store it verbatim (only ctime is
> normalized, via inode_set_ctime_to_ts()).
>
> The un-normalized value then corrupts on-disk metadata. ext4's
> ext4_encode_extra_time() shifts tv_nsec left by EXT4_EPOCH_BITS; an
> out-of-range value overflows the 32-bit extra field and clobbers the
> seconds-epoch bits, so the stored seconds (and thus the year) are wrong
> on read-back. XFS with bigtime mis-stores the timestamp for the same
> reason. There is no WARN_ON anywhere in the path to catch it.
>
> Validate the client-supplied atime/mtime in nfsd_setattr(), which is
> the common choke point for SETATTR and for the create paths (via
> nfsd_create_setattr()), and covers both NFSv2 and NFSv3. The check is
> done up front, before any resources are acquired, so no cleanup path is
> involved; RFC 1813 Section 2.6 leaves error precedence to the
> implementation. Return NFS3ERR_INVAL, which RFC 1813 lists for SETATTR
> and describes as the error for a value the server 'can not store ... in
> its own representation'. The client maps this to EINVAL.
>
> tv_nsec is a long, so the comparison casts it to unsigned long (the same
> width) rather than to u32, matching timespec64_valid(). A u32 cast would
> be wrong on both ends: on 32-bit it cannot widen, and on 64-bit it would
> truncate the NFSv2 value (svcxdr_decode_sattr() computes tv_nsec as
> tmp2 * NSEC_PER_USEC, which can exceed the u32 range). The unsigned long
> cast also rejects a value that became negative when an out-of-range u32
> wire nseconds was assigned to a 32-bit long.
>
> RFC 1094 does not define NFSERR_INVAL for NFSv2; its stat enum has no
> value 22. Map nfserr_inval to nfserr_io in nfsd_map_status() so the
> NFSv2 reply stays within the RFC 1094 status set, the same way that
> function already folds other internal statuses with no NFSv2 equivalent.
> NFSv3 (and NFSv4) leave the INVAL status as is, since it is valid there.
>
> Only client-supplied times are checked: SET_TO_SERVER_TIME requests
> carry no client value and are filled in by the server. The NFSv2 Sun
> 'set both to now' convention clears ATTR_[AM]TIME_SET in the SETATTR
> proc before nfsd_setattr() runs, so it is unaffected. The sattrguard3
> ctime is deliberately left alone: an out-of-range guard simply never
> matches the object's ctime and yields NFS3ERR_NOT_SYNC via the existing
> guardtime comparison, which is the protocol-correct outcome rather than
> rejecting the request.
>
> NFSv4 already rejects such values in nfsd4_decode_nfstime4(), so they do
> not reach this check on that path.
>
> The lack of validation is long-standing and predates the git history of
> this code, so no Fixes: tag is provided. This is a data-integrity fix
> and is a candidate for LTS backport.
>
> Signed-off-by: Robbie Ko <robbieko@synology.com>
> ---
>  fs/nfsd/nfsproc.c |  1 +
>  fs/nfsd/vfs.c     | 14 ++++++++++++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index 8873033d1e82..3c8da3f1af6c 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -33,6 +33,7 @@ static __be32 nfsd_map_status(__be32 status)
>  		break;
>  	case nfserr_symlink:
>  	case nfserr_wrong_type:
> +	case nfserr_inval:
>  		status = nfserr_io;
>  		break;
>  	}
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index eafdf7b7890f..dd0bbf7aad1b 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -515,6 +515,20 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
> 
>  	trace_nfsd_vfs_setattr(rqstp, fhp, iap, guardtime);
> 
> +	/*
> +	 * Reject a client-supplied atime or mtime whose tv_nsec is out of
> +	 * range. Such a value is well-formed on the wire but is not a valid
> +	 * timespec64; storing it verbatim can corrupt on-disk timestamps
> +	 * (for example, ext4 packs tv_nsec << 2 alongside epoch bits).
> +	 * Reject it before acquiring any resources. RFC 1813 Section 2.6
> +	 * leaves error precedence to the implementation.
> +	 */
> +	if (((iap->ia_valid & ATTR_ATIME_SET) &&
> +	     (unsigned long)iap->ia_atime.tv_nsec >= NSEC_PER_SEC) ||
> +	    ((iap->ia_valid & ATTR_MTIME_SET) &&
> +	     (unsigned long)iap->ia_mtime.tv_nsec >= NSEC_PER_SEC))
> +		return nfserr_inval;
> +
>  	if (iap->ia_valid & ATTR_SIZE) {
>  		accmode |= NFSD_MAY_WRITE|NFSD_MAY_OWNER_OVERRIDE;
>  		ftype = S_IFREG;

nfsd3_proc_create() and nfsd_create_locked() call
vfs_create()/vfs_mkdir()/vfs_mknod() before nfsd_create_setattr()
reaches this new nfserr_inval return. The server then reports failure
for the invalid timestamp but leaves the new object behind, so
retries can hit EXIST and clients observe a failed non-idempotent
operation that actually modified the namespace.

But this is not strictly new behavior. "post-create setattr fails,
object left behind" is a long-standing property of this path. Any
failure in nfsd_create_setattr() (commit_metadata, fh_update,
uid/gid) already orphans the object. However, this patch adds one
new, client-triggerable way to hit it. So it's a fresh trigger of
an existing wart, not a brand-new class of bug.

The trade is corruption vs. orphan. Pre-patch, that same input
created the object and stored a corrupt timestamp (the bug the
patch targets). Post-patch it creates the object and reports
failure. Neither is good; the orphan is the lesser evil but it
is still avoidable.


Moreover, on 32-bit platforms, svcxdr_decode_sattr() computes
tmp2 * NSEC_PER_USEC before this check, and that multiplication
is 32-bit unsigned long on ILP32. A wire useconds value such as
4294968 wraps to tv_nsec == 704, so this >= NSEC_PER_SEC test
accepts an out-of-range client value and stores a bogus timestamp
instead of rejecting it.


The sashiko.dev review is based on a branch that does not have
Jeff's fix for CB_GETATTR for this exact issue, so it's
effectively a false positive.


In summary: I don't agree with adding the check in nfsd_setattr().
The incoming values need to be checked closer to the protocol-
specific code because each NFS version has to solve a slightly
different problem.

For NFSv2, the incoming value needs a decode-time guard on the
raw microseconds, because its decode does a unit conversion that
silently corrupts an out-of-range value on 32-bit before any proc
function can see it.

For NFSv3, the check should happen in nfsd3_proc_setattr(), and
in nfsd3_proc_create() before creation is attempted.

NFSv4 (SETATTR, CREATE, and CB_GETATTR) all seem to be covered by
the current implementation and don't need the extra check in
nfsd_setattr().


-- 
Chuck Lever

