Return-Path: <linux-nfs+bounces-18734-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKNdNPZmhGkh2wMAu9opvQ
	(envelope-from <linux-nfs+bounces-18734-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Feb 2026 10:46:30 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7260AF0FFA
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Feb 2026 10:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA569300F9F2
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Feb 2026 09:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E12A3A1A5F;
	Thu,  5 Feb 2026 09:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7wZYF6o"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248E128D8ED
	for <linux-nfs@vger.kernel.org>; Thu,  5 Feb 2026 09:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770284753; cv=pass; b=gT/m2OyC3K8lhd82lOxBf2W0ui0a5om7IqTLJEj6z0OMDxY3fUfwDvU3J3927wDnTa/3hMgWtBfHzRRj+mSp7a80shRIHs/QHl95hJpWNfZtJOhLaIPcEVocLThUn/qbtndhhohDrj4sLc/A4clY27boEZ2HOeXT+JkglNA5B/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770284753; c=relaxed/simple;
	bh=gTHjRNg48uqIhlFUjNVy6w29gFOiVNhUd1etS9WljNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NFsENoh4XI4q5jBQB3HDvxKMotvDVBnRiGnS1zUobp1DuSCw0VvclCKrtNQfvKhPqum2EBHzL61M40Tcz3spUbMPAlgLnmQmrB3RFlrWyRW+vggM7oiuz2w9BRARRDxaotMcHAizqeb0Ib1D5O8YcpWJOSJx0yCHIzT/bdkidu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7wZYF6o; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-658b511573cso1299077a12.0
        for <linux-nfs@vger.kernel.org>; Thu, 05 Feb 2026 01:45:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770284751; cv=none;
        d=google.com; s=arc-20240605;
        b=IHtLPhnk2VH3eY+6CSKc7b+rfaRykyGMjGtdNkKgdk+n7bPgCTie87MtaO61QeWmp7
         E8tY2hXzC1pMiRbp7yH/BOxwzorYoKsHdFMgE7mehj+LYoeqqAzsfDAaB/O2J2Ia4VJ8
         Lu+uh34jr5MnmrPQoMgeDGshnXcBP7vT/ux4gKjvop+THep29VBb66I3BZKxjLH704ON
         BYuDAt8ifDcF9e+x5a4HyI2XVxZu55btOPjXTjypicC9DI4Zm8rMpYpLWR1BTN5WBVlE
         n7vdktDOnODJzEths7GWHtAMUUPHRvkDArGAYts/e0eAFs56vVReLeb3eiUH7BMGYQTK
         p5Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gTHjRNg48uqIhlFUjNVy6w29gFOiVNhUd1etS9WljNU=;
        fh=dCwZFAtxNSPTjhJwzGKDvKudozQtWEgGD5xDu1Oxav4=;
        b=f+WZk/pTWnPiY+xaxaL9AgF0cjDSqIW/Itm1z4zQhLm8Lmu7Eg/848VxOJdoa3p50M
         LPjjJE97a7VzlQfsI3Njw9tTXIjp/mqwgKM9qREDqYW/TYhsxncAPt9wVSn9jW8GTdCT
         cuf9eK6ZzFrFnkm9zwyup+KaZEz/bqEMJ5GKW0RImFZzgwAuxKiZ19fzvUaHoMdxI9l4
         2slBGMnmvkTY7MHH9Z6+pOXN2Wd0hNtqL1Cm5L1nn9fNKlOuzbOSYBG4Z1Avg02VxGqU
         +Y2o/0I6tfjEthRkIryonBlsNPoSY+6sinE2mJkNvzujoSBHJtCM7uAOp+B2rgUAsDRA
         rEBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770284751; x=1770889551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTHjRNg48uqIhlFUjNVy6w29gFOiVNhUd1etS9WljNU=;
        b=X7wZYF6oGkxVE+gLTBtcX28o4eYBAX3e3P5/p1DkotCtFvnSm+dNdGmggiKQnap9HF
         uJoR8Y/7jQwtGKgtwXZNQtMOcaDouskzI9DbFRdinBwM2G8kpSDc+wVOPd9ayKvPaZtX
         qDZsWavmVfL8txVAZaxKDRyNO2gl3nDKYj6Y08WRzZFoXlLH4OBDdd4dCHPmAv9LaYhV
         aYyqyMoVjKFMXFsylm9qYTAL0LLdTNasCpSpfzLfkc3XzkPNORx9OBQJnvhWeWVvJgyV
         IFPElSh1GAM0WngNDgAYeJbIEwtbP3kxmdE1hnqP1mOoFVug/wkO0WrOFsaHCyIytL65
         aJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770284751; x=1770889551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gTHjRNg48uqIhlFUjNVy6w29gFOiVNhUd1etS9WljNU=;
        b=Au+ayu+dJeVSebUOy3sZMQrHI9Uo6eLTMIR0JasZSsg1DJiSRbNEq4HHK84fUpoXBa
         949supt7ohwgvjAPKNsGcaPJUPJAkcY3QZrprHqIuZzc6lDl7kBHWDMddqYUQPrCRee9
         VxoKgDPUyGVs0v4NMBpU5xPfZSLlcArn3YZCpyIiuYFbgfswMHftJxLqHx84tNQrTZsK
         bPOL1tcXY5Eh93+vf4PS/UvHdjdM6Rv+56lkxvcI8gygfGvmfa0Fob5MiiuHlzcKya/M
         QkLv85/zffxliPQOOa/Q6xOhrGY5q0aCP1ue52IQM2+mgUCM87qxqnIX35SLns2YIUS0
         DwUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhXuI6VwUmOHSw4OeXZfZHv/d9ZyvuvTt0uL2Cdd67P2Yf4P0qLz6IxIo5z/T1WrGXXvqW5B0bU78=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTBicFF0jPfydVE4i4ngjSI+7R45ID/qJUGRHW9yKbeeUxczvb
	4YJihpIYTCbu3tNUEDhcICN/kxaDrCCWdnxy/6ZeprcxJj0iQAdGXRxU7PFzZywnQXbn3XTt/Hv
	DvK/k/U2Zz8U8nwDX8tiK2hwyfjJx15g=
X-Gm-Gg: AZuq6aKRx3wR41YoQ3ScbIXRCKp/X3wL2Y7Tz/GbVmVFvov1BhoQoBh9MSwIKComlkC
	avwNuCMpsKVk9leldz8/XHoBR0lGeiCmGwo1IHrWMTDj3eskcxV8n0rFAGQ/9/WcezXZOzuKo7r
	KD2gaKiV/pVqGEwRgvDv4x18Cgig41FpagBh8O3MnscVXjFQ0hvR2stP3zY5cN9kbVxFIUNUc0G
	voGiSa3YNCosL7gB6JAhQu5YABkVdWyMLA2OuOD0a1dENMzipF8icFZ3hDRy5rfzl4qbljRbCJp
	8IsH9G/jZplaAlD2eWN7MN2QLo2Zig==
X-Received: by 2002:a17:907:7f92:b0:b87:31d1:4131 with SMTP id
 a640c23a62f3a-b8e9f64603cmr435430866b.60.1770284751163; Thu, 05 Feb 2026
 01:45:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204050726.177283-1-neilb@ownmail.net> <20260204050726.177283-13-neilb@ownmail.net>
In-Reply-To: <20260204050726.177283-13-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 5 Feb 2026 10:45:38 +0100
X-Gm-Features: AZwV_Qg7CM-kXxjB2Qin-euJkaOUd7ni190R_n_ZLhun34eHr5T-i9uF6CbqXdo
Message-ID: <CAOQ4uxi3bNYq1b4=qL-JLi19hRwurntfLZXhUMVL003NarBdGg@mail.gmail.com>
Subject: Re: [PATCH 12/13] ovl: remove ovl_lock_rename_workdir()
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, linux-kernel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18734-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,redhat.com,suse.cz,oracle.com,szeredi.hu,canonical.com,paul-moore.com,namei.org,hallyn.com,gmail.com,vger.kernel.org,lists.linux.dev,lists.ubuntu.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,brown.name:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7260AF0FFA
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 6:09=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
>
> From: NeilBrown <neil@brown.name>
>
> This function is unused.
>

I am confused.
What was this "fix" fixing an unused function:

e9c70084a64e5 ovl: fail ovl_lock_rename_workdir() if either target is unhas=
hed

What am I missing?

Otherwise, feel free to add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

