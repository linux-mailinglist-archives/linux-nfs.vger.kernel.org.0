Return-Path: <linux-nfs+bounces-9868-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E419BA2737B
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Feb 2025 14:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BD7C7A485B
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Feb 2025 13:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBCA20D504;
	Tue,  4 Feb 2025 13:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YznYaHKn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5778320C494
	for <linux-nfs@vger.kernel.org>; Tue,  4 Feb 2025 13:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738675780; cv=none; b=QN04ZjOEXyy6gbBcKCFVqu+pJV4wNmwcA4ljntP7TrZ51u/OJFTlRKP5PlDEompt8VAanUdjlub3ypE1t49yO13L+JBHhZvkpB7+XrchVS/17GjOvuQvPZHTpdW6xEykhd5uLhOE4lR+gm02jsKX5h7Df/jLA0QiabhqSDyn5pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738675780; c=relaxed/simple;
	bh=PY/07+fcfLRpPtWcZdrXgrHu0OD5sEI6Rb3Frq8x2jM=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=u1ugx47b4qbZnlr/t6OzjpjsMbP0Yv1oI4hMob9zEDrPqDUm9T69EcCyKVj09SquHrZBk9XKpWWVIGGSj3Z16vppgHSBlP9F9YMr26ECP4yexkVgBLlqfh+F2243IJMeYrJjzm6LQVvPiodPO6MmgqjzanrPN2/J1f1KgvucAWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YznYaHKn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96FAC4CEE2;
	Tue,  4 Feb 2025 13:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738675779;
	bh=PY/07+fcfLRpPtWcZdrXgrHu0OD5sEI6Rb3Frq8x2jM=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=YznYaHKnv7N/+kdy0yHFz+sd5eF24YeyHYvouHkJvEFkddqEN8zyVS509FIk6FZhY
	 0ErVdoQUBtMwb0YL6mf9qRuImXo5O9gIlaYSSuwCBM1g4Kej5kCUD6r0X6hgXmphDk
	 dAtb6JDibvSvAzzzGuA/ljZhUeLhANnWgj9oXkxGw4XBpFd/oFRAoH485/91eRU2qX
	 4DzKSUX7Z67mTFfWlcZUBwIDUR/qrLTOQAv1BqBo1aOoDwKs65nvFULTbffMDvFr5b
	 T4omc7i5PoJtk9HKxOFzSAgRGX4YAQJ/Q27fcHk/co1reU42BMCu0FVWOjzHFP+6YV
	 4VmIvhsO9EI8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F0393380AA67;
	Tue,  4 Feb 2025 13:30:07 +0000 (UTC)
From: "rik.theys via Bugspray Bot" <bugbot@kernel.org>
Date: Tue, 04 Feb 2025 13:30:11 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-nfs@vger.kernel.org, cel@kernel.org, aglo@umich.edu, 
 trondmy@kernel.org, anna@kernel.org, jlayton@kernel.org
Message-ID: <20250204-b219737c7-947e192554be@bugzilla.kernel.org>
In-Reply-To: <20250130-b219737c0-091f27de8b7a@bugzilla.kernel.org>
References: <20250130-b219737c0-091f27de8b7a@bugzilla.kernel.org>
Subject: Re: warning in nfsd4_cb_done
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

rik.theys writes via Kernel.org Bugzilla:

Hi,

(In reply to Chuck Lever from comment #4)
> (In reply to Bugspray Bot from comment #3)
> > Olga Kornievskaia <aglo@umich.edu> replies to comment #1:
> > 
> > > First issue is the explicit use of NFS4ERR_BAD_XDR in the CB_GETATTR
> reply
> > > decoder. Should be EIO instead.
> > >
> > > Second issue is the CB_GETATTR reply decoder does not seem capable of
> > > handling a non-zero status code in the reply.
> > >
> > > Third issue is whether NFS4ERR_BADHANDLE means the server requested a
> > > CB_GETATTR for the wrong file, or if it is an expected situation.
> > 
> > Isn't this because 6.12.x is still missing the patch "NFSD: fix
> > decoding in nfs4_xdr_dec_cb_getattr" that just went into 6.14?
> 
> Yes, second and third issues are addressed by 1b3e26a5ccbf ("NFSD: fix
> decoding in nfs4_xdr_dec_cb_getattr").
> 
> The first issue has not yet been addressed upstream.

Is it possible this patch has not (yet) been sent to stable@vger.kernel.org so it ends up in 6.12.y?

Regards,
Rik

View: https://bugzilla.kernel.org/show_bug.cgi?id=219737#c7
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


