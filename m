Return-Path: <linux-nfs+bounces-22092-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFDME5/tGWrlzwgAu9opvQ
	(envelope-from <linux-nfs+bounces-22092-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 21:48:47 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E47C607F91
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 21:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC0A83002F97
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 19:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1611DDA18;
	Fri, 29 May 2026 19:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="XsCoM1Re"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982D44AEEF
	for <linux-nfs@vger.kernel.org>; Fri, 29 May 2026 19:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780083983; cv=none; b=Qbel+4sUhjKDPHQKQ8h2dw39OhhV+o8qLFGp9b7Tc4jsRbfb/W6IWyR/gUZ4tXiVZwCD9CUu0lUOAes3FIl5U432NDgkeQZCPpYsDugpX4VEUcusthtbZtx+FsDkc9rmXueiJ9IxjjYj5dZMCUGp9mA5ZmPI1+lbyI3CFhZn9zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780083983; c=relaxed/simple;
	bh=R+xr4cETJzYvV5p1uPjwAYBOH8ci0ca3RxZ2O9nvjv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rq/MSC384Izt2ws1lv1JVeP6k9AQDwY7d0tpBoiAu+o/aeybHfO87HrXObMQL2hg6VQM9JkxJKldMYyY+24PqXsav0+dPqIeQXDjFEjm2yu4a7WMo5CmyT6OMtLR6IKwzla9mG1TMWJv7NoChw2pzZ8cAbpzWR73OJ9XXKcXL5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=fail smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=XsCoM1Re; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammerspace.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-69d7aa0ac14so5114981eaf.3
        for <linux-nfs@vger.kernel.org>; Fri, 29 May 2026 12:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1780083980; x=1780688780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+xr4cETJzYvV5p1uPjwAYBOH8ci0ca3RxZ2O9nvjv0=;
        b=XsCoM1Re1N4GTzKg+RLKXGeUhZssxrw/vuO1qYvsznIx193ayLXdHO52F52rk2QGyZ
         oNkEpxQQ57CptUBPyxr0ZBKdFsqEI4xbIPdF+xkpJniJoEFA5rOvbBui5c0/BrVrgfE1
         gaPNw0DWTs4u7hszdZMdk9D3tQBY0qHtMn7TA0iq2rHj4RL7Ke3rnxur7avT1rOgtvSL
         ZkPY69J9cva+rmcWz9eL9zFdZZEJO0n+3e3L2wjYQ3Z9uTmos3FUCErbb4yeklQajFAU
         9rEwwz8Zs6qvoyv0P2aE5yZKgFpM90jleTzAkBGIRboajwAdFLrmjIUOuCfJy1sjynA2
         96NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780083980; x=1780688780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R+xr4cETJzYvV5p1uPjwAYBOH8ci0ca3RxZ2O9nvjv0=;
        b=VED3ZZsoG/gOtsyT2Dhic+fdtLYydx1ss6u2GTKVq1dCst7kaCnGNL5AH7aOly3Aw9
         ztMuFVFI3rbe5huzq+yIc1JbGD18V496SoelEFm51v5z6TC62mpvnKFx1Nf/BEyvS1lP
         isd6Vr2/L32oZzdSAmQ9kHcq945FHRIU3FXWdanwvBNBmz31SYSmKqdsw9EiVd2/fPtO
         ZaBAzJNuPNLNyTF8gPlnsUVA7RdOXNY2PnS5/uESfXXUfqQBH4iUSSBpgBOkfHKxuLyZ
         Gi4utVNJH8uoHazlS3GC8GJTTmonZ0Rfg3TyRR7B+OMPpV+vk1p4LoFrBJPz9QJuh6IV
         xMsQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Yv8u1xLFg4GgSkyvFyxGOcjzgrDxG48Oy8fEMO0Zo0K10sFJ3dkMFXF0crMQ1BjNUuGMwL6PSqDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY9EAHFLbC731v0Db8p3XBIV7VPx9CyFSIu6hQ3TC+XV7j8f5C
	9RbFSkccuCm+g0funZ//euDpzOI0b8AT6OEcj9+Kiz85rbdqsZV07e2hYSio50gvlj9RVpCBfmw
	HuY+P
X-Gm-Gg: Acq92OGRDRjiw3/1MnSvhAZ/LOzBwrKHraZyF4e41yhPTvU2RJ6v+/ee4g3UkfPsLSX
	yumdG0AMH8oZrm4s7WlRbBxQKcMbTNhBthYjrw7wkpEPTibSqiBWCEf1vT3i1Sz6X2xF1GB8LSO
	gYUJ/o0dReZiWrmX1nI6oCINSq8fZyI+MaDUT0VImaE0sj8irfRP/+sqf+JRVSecfekgM0T7ytE
	+QBy+6L2g+LksTdR1XoNaPJrKpwm3QUXUaeUJUbRCb26pOUY/Y2cE2DVKAPwQvxCBhPk2bXQZuE
	1rVCtdjq8m3ACSMSisqQXQyjK5evctqu97SAF9bCRn+zlVHbbvchv9D6tQ4R+m3MukGbsk+kFH5
	W3WfSfXtHWDuk8AzB+P+7MVPbaFVlTW663oc6dRCIUHsZnPZtZo9luwT47nt1LhqkgS0kul9IPg
	42jgidrPzIu+ItDSrtJqEFZBaDleL/w4Giue9o34DGTXazO1nYa42Msw==
X-Received: by 2002:a05:6820:620:b0:69d:4c06:978f with SMTP id 006d021491bc7-69e104439c0mr420674eaf.59.1780083980246;
        Fri, 29 May 2026 12:46:20 -0700 (PDT)
Received: from [192.168.254.51] ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e0677130fsm1653041eaf.2.2026.05.29.12.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 12:46:19 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Rick Macklem <rick.macklem@gmail.com>
Cc: Trond Myklebust <trondmy@kernel.org>,
 Benjamin Coddington <ben.coddington@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] nfs: return a write delegation when a SETATTR drops
 our write access
Date: Fri, 29 May 2026 15:46:18 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <92DCE3BE-6F5C-483C-A60E-78443BDAF67F@hammerspace.com>
In-Reply-To: <CAM5tNy54_NMkaj-x8Z_0TenMutrm0N=KvMKBER2+3Gou7DO7iQ@mail.gmail.com>
References: <cover.1779995818.git.bcodding@hammerspace.com>
 <64a9c99c387432399b4c4d9ce6dd4836b0170c15.1779995818.git.bcodding@hammerspace.com>
 <461703b49f85216f6f6b18656e290287b0f701a0.camel@kernel.org>
 <CAM5tNy54_NMkaj-x8Z_0TenMutrm0N=KvMKBER2+3Gou7DO7iQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22092-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,uoguelph.ca:email]
X-Rspamd-Queue-Id: 7E47C607F91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 29 May 2026, at 11:27, Rick Macklem wrote:

> On Fri, May 29, 2026 at 7:06=E2=80=AFAM Trond Myklebust <trondmy@kernel=
=2Eorg> wrote:
>>
>> CAUTION: This email originated from outside of the University of Guelp=
h. Do not click links or open attachments unless you recognize the sender=
 and know the content is safe. If you are unsure, forward the message to =
ITHelp@uoguelph.ca for review.
>>
>>
>> On Thu, 2026-05-28 at 15:22 -0400, Benjamin Coddington wrote:
>>> A client holding an OPEN_DELEGATE_WRITE delegation can satisfy a
>>> later
>>> open(O_WRONLY) from the cached delegation (can_open_delegated())
>>> without
>>> sending an OPEN to the server. That cached "open for write" assertion=

>>> is
>>> only valid while the delegation holder still has write access. A
>>> SETATTR
>>> that changes mode, owner, or group can revoke that access -- after
>>> which an
>>> open served from the delegation would bypass an access check the
>>> server
>>> would now fail, and, against a server that recalls the delegation on
>>> such a
>>> change, the SETATTR draws a CB_RECALL/NFS4ERR_DELAY/DELEGRETURN/retry=

>>> round
>>> trip.
>>>
>>> Before issuing such a SETATTR, check whether the proposed
>>> mode/owner/group
>>> would remove write access for the delegation's owning credential,
>>> judged by
>>> the resulting POSIX mode bits. If so, return the delegation first:
>>> the
>>> return is synchronous and flushes modified data, so the SETATTR
>>> proceeds on
>>> an open or special stateid and the next open revalidates access with
>>> the
>>> server. Permission changes that keep the holder's write access leave
>>> the
>>> delegation in place.
>>>
>>> Only the mode bits and the holder's fsuid/fsgid are consulted. An
>>> NFSv4 ACL
>>> cannot be evaluated by the client, a privileged caller may retain
>>> access the
>>> bits deny, and supplementary group membership is not checked, so the
>>> test is
>>> necessarily approximate -- but an inexact answer costs at most an
>>> unnecessary delegation return or a fall back to the server's recall,
>>> never
>>> incorrect access.
>>>
>>> RFC 8881 Section 10.4.4 permits a client to return a delegation
>>> voluntarily,
>>> performing the same pre-return state updates (data flush, pending
>>> truncation, CLOSE/OPEN/LOCK) it would on a recall. Commit
>>> c01d36457dcc
>>> ("NFSv4: Don't return the delegation when not needed by NFSv4.x
>>> (x>0)")
>>> stopped returning write delegations on SETATTR for NFSv4.1+, since
>>> the
>>> server can identify the delegation holder from the SEQUENCE clientid
>>> and
>>> need not recall. That holds for changes that do not affect the
>>> holder's
>>> access; restore a return only for the narrow case where the holder's
>>> own
>>> write access is removed.
>>
>> Hmmm... I'd argue that while recalling the delegation in this case is
>> mandatory for NFSv4.0, that is certainly not true for NFSv4.1.
>>
>> Furthermore, I'd argue that if the holder of a write delegation is jus=
t
>> changing the mode, then that should never result in a delegation recal=
l
>> for a well written NFSv4.1 server. The reason is this does not impact
>> the client's ability to cache data, metadata or lock state. It only
>> impacts its ability to rely on previously cached access data when
>> handling new opens.

> I'm not sure I completely agree with this statement. The case I would
> be concerned about is delayed writes sitting in the client.

Those stay safe on Linux. The client flushes cached writes on the delegat=
ion
(or open) stateid, and knfsd authorizes a WRITE from the stateid's grante=
d
access, not from a re-check of the current mode =E2=80=94 nfsd4_write() j=
ust rides
the already-open, write-capable nfsd_file resolved from the stateid, so a=

later mode change doesn't block the holder's writes. And if the server do=
es
recall, DELEGRETURN flushes the dirty data before the delegation goes bac=
k.
The only way to lose data is a server that neither honors the holder's
stateid writes nor recalls.

> Maybe an NFSv4.1/4.2 server should always allow writes from a
> client that holds a write delegation for the file, but I don't think th=
at
> is spelled out in RFC8881 (I'm never sure, given that monstrous
> document) and I'll admit that the FreeBSD server
> does not do that. The FreeBSD server currently does always allow the
> owner of the file to do writes, but does not do the same w.r.t. write
> delegation held by the client. (I'll think about adding that override,
> because it does seem reasonable.)
>
> What does the Linux knfsd currently do w.r.t. allowing writes
> from a client that holds a write delegation?

It allows them. WRITE resolves the delegation (or open) stateid to an ope=
n
write-capable nfsd_file and writes through it; there's no per-WRITE mode
check in nfsd4_write() -> nfsd_vfs_write(). So knfsd effectively already
does the override you're considering for FreeBSD, just implicitly =E2=80=94=
 write
authorization comes from the open/deleg stateid, the same principle as th=
e
truncate-via-stateid case.

> Certainly setting mode bits won't be a problem and clearing
> owner mode bits isn't a problem for the FreeBSD server.
>
> Oh, and one more quirky corner..
> If the server provided a non-empty ACE for the permissions
> field for the write delegation, these SETATTR changes either
> require the server to recall the delegation or the client to
> invalidate use of this ACE.
>
> I'd suggest that the client invalidate use of the ACE (if it
> ever uses it?) and leave delegation recall up to the server.

The Linux client never uses it =E2=80=94 decode_rw_delegation() parses th=
e
delegation's permissions ACE and discards it (decode_ace() is passed a NU=
LL
sink), and the client always does its own ACCESS. So there's nothing to
invalidate on our side, and agreed: the recall decision belongs to the
server.

=2E..

>> The exception might be if this is an attribute delegation, and the
>> result will be that the cred attached to the delegation will no longer=

>> be able to issue a SETATTR to update the atime/mtime on delegation
>> return.
> Lost me. What's an attribute delegation?

I'll let Trond give the canonical definition, but as I understand it: the=

*_ATTRS_DELEG delegation variants additionally delegate attribute authori=
ty
=E2=80=94 notably the timestamps =E2=80=94 so the client can hold and mod=
ify them and write
them back at DELEGRETURN. That return-time SETATTR is what Trond meant ab=
out
the holder's cred needing to retain access.

Ben

