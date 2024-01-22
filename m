Return-Path: <linux-nfs+bounces-1282-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2AE8377BF
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jan 2024 00:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BD03284ACB
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 23:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF274BAA4;
	Mon, 22 Jan 2024 23:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OpyqnxQG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dzW8dzeB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OpyqnxQG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dzW8dzeB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A79E4B5A6
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jan 2024 23:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705966312; cv=none; b=Zvk1zhFIENrZaeEkNMbjKMumKiw2lMqiT4nAJSJlDiDBCcNyLb/NOoFlmuycaFBzYrdkBx95qFARfP9dJhr/cZ2EDYVlyavHTUreUODsYyJJwV9E1nwk6zsTe8/+HRuRDkWz2A+rQrO5QUjVOqR0ZaJlD5s8U2An7eLGuMOF7FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705966312; c=relaxed/simple;
	bh=1oZjXAywPdPdFjpTK/+AXN3jGDYFsYHFGgZLjjekYo0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=uHJlvKzC+r/gWRUFzaMRa8KEHSb54zVCmrkPID6VVvTJHPkJwZgEMHlRWX/Ec22iQM3m++++fe2OBoGLEqALpJ/D0W9hkDjJr45HFzqd48DBnYpl2gcbQTmYv9y7kr1SDDzi7THayTobFEVltbsmpLmpDOh9ak7xVFR7RAzOGVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OpyqnxQG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dzW8dzeB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OpyqnxQG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dzW8dzeB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8A9C42204B;
	Mon, 22 Jan 2024 23:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705966308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GbCHbO7v1MQSFieK8tBUTdWOlpv1HhRqjkEL1xWGiDw=;
	b=OpyqnxQGvC9xsf6g8oy6sizpN2brqEkX3b4KilL4Uhw1hxplgwRLBGZz3llWIXWVA7iVNg
	Cp5J5eD6cWjHbPHSXfGeXvCLQgSQCCQrTV3scB8sjDchsU19yntENVF5e0rMhSqKrU2mI+
	WK05ylSGmwShxcRvsP7NJU+tOJM3Hc0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705966308;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GbCHbO7v1MQSFieK8tBUTdWOlpv1HhRqjkEL1xWGiDw=;
	b=dzW8dzeBQR5Am3C0+RSkmZxEjC416KRkNmfWdRxuUORzZqOzaaFQZ9kLykXy7dLJE+M+Sy
	yi1ZChD42WLxCKDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705966308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GbCHbO7v1MQSFieK8tBUTdWOlpv1HhRqjkEL1xWGiDw=;
	b=OpyqnxQGvC9xsf6g8oy6sizpN2brqEkX3b4KilL4Uhw1hxplgwRLBGZz3llWIXWVA7iVNg
	Cp5J5eD6cWjHbPHSXfGeXvCLQgSQCCQrTV3scB8sjDchsU19yntENVF5e0rMhSqKrU2mI+
	WK05ylSGmwShxcRvsP7NJU+tOJM3Hc0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705966308;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GbCHbO7v1MQSFieK8tBUTdWOlpv1HhRqjkEL1xWGiDw=;
	b=dzW8dzeBQR5Am3C0+RSkmZxEjC416KRkNmfWdRxuUORzZqOzaaFQZ9kLykXy7dLJE+M+Sy
	yi1ZChD42WLxCKDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8326B136A4;
	Mon, 22 Jan 2024 23:31:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gIn4DuL6rmVsbwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 22 Jan 2024 23:31:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever III" <chuck.lever@oracle.com>
Cc: "Jeff Layton" <jlayton@kernel.org>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Olga Kornievskaia" <kolga@netapp.com>, "Tom Talpey" <tom@talpey.com>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: fix RELEASE_LOCKOWNER
In-reply-to: <3162C5BC-8E7C-4A9A-815C-09297B56FA17@oracle.com>
References: <170589589641.23031.16356786177193106749@noble.neil.brown.name>,
 <Za57adpDbKJavMRO@tissot.1015granger.net>,
 <170596063560.23031.1725209290511630080@noble.neil.brown.name>,
 <3162C5BC-8E7C-4A9A-815C-09297B56FA17@oracle.com>
Date: Tue, 23 Jan 2024 10:31:43 +1100
Message-id: <170596630337.23031.332959396445243083@noble.neil.brown.name>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 TO_DN_ALL(0.00)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Tue, 23 Jan 2024, Chuck Lever III wrote:
> 
> 
> > On Jan 22, 2024, at 4:57 PM, NeilBrown <neilb@suse.de> wrote:
> > 
> > On Tue, 23 Jan 2024, Chuck Lever wrote:
> >> On Mon, Jan 22, 2024 at 02:58:16PM +1100, NeilBrown wrote:
> >>> 
> >>> The test on so_count in nfsd4_release_lockowner() is nonsense and
> >>> harmful.  Revert to using check_for_locks(), changing that to not sleep.
> >>> 
> >>> First: harmful.
> >>> As is documented in the kdoc comment for nfsd4_release_lockowner(), the
> >>> test on so_count can transiently return a false positive resulting in a
> >>> return of NFS4ERR_LOCKS_HELD when in fact no locks are held.  This is
> >>> clearly a protocol violation and with the Linux NFS client it can cause
> >>> incorrect behaviour.
> >>> 
> >>> If NFS4_RELEASE_LOCKOWNER is sent while some other thread is still
> >>> processing a LOCK request which failed because, at the time that request
> >>> was received, the given owner held a conflicting lock, then the nfsd
> >>> thread processing that LOCK request can hold a reference (conflock) to
> >>> the lock owner that causes nfsd4_release_lockowner() to return an
> >>> incorrect error.
> >>> 
> >>> The Linux NFS client ignores that NFS4ERR_LOCKS_HELD error because it
> >>> never sends NFS4_RELEASE_LOCKOWNER without first releasing any locks, so
> >>> it knows that the error is impossible.  It assumes the lock owner was in
> >>> fact released so it feels free to use the same lock owner identifier in
> >>> some later locking request.
> >>> 
> >>> When it does reuse a lock owner identifier for which a previous RELEASE
> >>> failed, it will naturally use a lock_seqid of zero.  However the server,
> >>> which didn't release the lock owner, will expect a larger lock_seqid and
> >>> so will respond with NFS4ERR_BAD_SEQID.
> >>> 
> >>> So clearly it is harmful to allow a false positive, which testing
> >>> so_count allows.
> >>> 
> >>> The test is nonsense because ... well... it doesn't mean anything.
> >>> 
> >>> so_count is the sum of three different counts.
> >>> 1/ the set of states listed on so_stateids
> >>> 2/ the set of active vfs locks owned by any of those states
> >>> 3/ various transient counts such as for conflicting locks.
> >>> 
> >>> When it is tested against '2' it is clear that one of these is the
> >>> transient reference obtained by find_lockowner_str_locked().  It is not
> >>> clear what the other one is expected to be.
> >>> 
> >>> In practice, the count is often 2 because there is precisely one state
> >>> on so_stateids.  If there were more, this would fail.
> >>> 
> >>> It my testing I see two circumstances when RELEASE_LOCKOWNER is called.
> >>> In one case, CLOSE is called before RELEASE_LOCKOWNER.  That results in
> >>> all the lock states being removed, and so the lockowner being discarded
> >>> (it is removed when there are no more references which usually happens
> >>> when the lock state is discarded).  When nfsd4_release_lockowner() finds
> >>> that the lock owner doesn't exist, it returns success.
> >>> 
> >>> The other case shows an so_count of '2' and precisely one state listed
> >>> in so_stateid.  It appears that the Linux client uses a separate lock
> >>> owner for each file resulting in one lock state per lock owner, so this
> >>> test on '2' is safe.  For another client it might not be safe.
> >>> 
> >>> So this patch changes check_for_locks() to use the (newish)
> >>> find_any_file_locked() so that it doesn't take a reference on the
> >>> nfs4_file and so never calls nfsd_file_put(), and so never sleeps.
> >> 
> >> More to the point, find_any_file_locked() was added by commit
> >> e0aa651068bf ("nfsd: don't call nfsd_file_put from client states
> >> seqfile display"), which was merged several months /after/ commit
> >> ce3c4ad7f4ce ("NFSD: Fix possible sleep during
> >> nfsd4_release_lockowner()").
> > 
> > Yes.  To flesh out the history:
> > nfsd_file_put() was added in v5.4.  In earlier kernels check_for_locks()
> > would never sleep.  However the problem patch was backported 4.9, 4.14,
> > and 4.19 and should be reverted.
> 
> I don't see "NFSD: Fix possible sleep during nfsd4_release_lockowner()"
> in any of those kernels. All but 4.19 are now EOL.

I hadn't checked which were EOL.  Thanks for finding the 4.19 patch and
requesting a revert.

> 
> 
> > find_any_file_locked() was added in v6.2 so when this patch is
> > backported to 5.4, 5.10, 5.15, 5.17 - 6.1 it needs to include
> > find_and_file_locked()
> 
> I think I'd rather leave those unperturbed until someone hits a real
> problem. Unless you have a distribution kernel that needs to see
> this fix in one of the LTS kernels? The supported stable/LTS kernels
> are 5.4, 5.10, 5.15, and 6.1.

Why not fix the bug?  It's a real bug that a real customer really hit.
I've fixed it in all SLE kernels - we don't depend on LTS though we do
make use of the stable trees in various ways.

But it's your call.

Thanks,
NeilBrown


> 
> 
> > The patch should apply unchanged to stable kernels 6.2 and later.
> 
> I can add a Cc: stable #v6.2+
> 
> 
> --
> Chuck Lever
> 
> 
> 


