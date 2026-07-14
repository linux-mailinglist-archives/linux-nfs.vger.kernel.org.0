Return-Path: <linux-nfs+bounces-23318-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ogl5FEN+Vmp37QAAu9opvQ
	(envelope-from <linux-nfs+bounces-23318-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jul 2026 20:21:55 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D8E757CDB
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jul 2026 20:21:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=paul-moore.com header.s=google header.b=Xxwjrwpw;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23318-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23318-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=paul-moore.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F38E30A29A7
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jul 2026 18:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26904331ECD;
	Tue, 14 Jul 2026 18:21:01 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8191639CD1F
	for <linux-nfs@vger.kernel.org>; Tue, 14 Jul 2026 18:20:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784053261; cv=pass; b=gHsaAhbAYnwJc0IXdLukMjl2p/7yN5R5Jt/8DW3Ya3Yot1nzP4+Yb9Xg4jPiOW6b7MGnMTmAHVHjJSiBurK12zzKcb1HiikbVt2CmDPf5HoF0wdX4g35GskG+VvdAiimr7A2M4DoNYvDQmUzx0hBOfCok8o0wfp7Iv6Y2h8BntU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784053261; c=relaxed/simple;
	bh=eyZy6tmw/y/uvyziqXobYIoPKaaMSPBA830VuHdiOAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nt4HCK0lpHE4Xi54p2J2bYuozDERTlkT+etBzKYkypC5HkWYtRIz322L5aZPuOFA7pPucV/X7eFHpfDiVQCWHZOC3+K/3i9oFbM8msWf4qumButl2CEUZwbAx+KzMjHLjLlnaXspSazqX7wXzPJkV+7awi6xSLxK//h0D1znP6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Xxwjrwpw; arc=pass smtp.client-ip=209.85.216.45
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3847e8b0f3aso3875021a91.3
        for <linux-nfs@vger.kernel.org>; Tue, 14 Jul 2026 11:20:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784053258; cv=none;
        d=google.com; s=arc-20260327;
        b=kXuZVmhMMk1k6BepY7CQjoQxNzQ/EJi+JY/0Smb9h0SUW+2TEORTlErNVkB/9R4YFV
         Ezt+dPFqkYapfuZ9Ci8u7MDE8S9xG/8KmyBfhuVnwMa604++84OHcMFPJ2A3oHRST5xc
         J6uSALfT4UF18Lb5vUR3LFZVL4xd/bVUSHF5OiYmNE3ZGhdDjkzfuEc4P3Wv1RFO85DC
         gC5IPn23IAo1P+Tk8Wo48F2us0PhHV367NllOQvKeTtC3qmDpq5lxzH1+BatvCF8s0sk
         PrfgkdB9f9Zlx7k5XKBudtRso1OD/U3mMpBlVPFwW6PUw2U2TDZ8KLss4Ejqy9sTliQe
         JyOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nmo5BFmH0BGw3SSnYVB0DqqeTBkMC36HDpza4IBAqYc=;
        fh=h5OhEH3/VrPpV5NIl3vAM5AoiBnaGpagRe8vzbe5GNs=;
        b=TXPgz1cAUnmOmkuNMdlnRTMdZCKeaJGC+KIym6ociwXRzd4slmG7P9edxl5Z4DVZxE
         1zxHy5rQi1PJVa0ELKftBSzEk35WzjQxEMuCV9tNTDb7x/qVUpmixDNn2wit1sXFNZpu
         rkuGYXteVwlPrR5PpePqMcYBt4eAb6l+7LC6F6vCWlVV35zvBfqQtzbdp8hFshrMzrnI
         K5LtvcOGW9erQ7WFDSHsKvEumcnbs/kQ8xLg6DWGWzEKsQ97Y48/YF9VxV6084BIuJdt
         vkGbLpAmb9BhqJe7il6fsL0AzVWtIX5exaOpwMUYj6fbkWBORLWk1HiRd5uT2uWeOLq2
         j88Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1784053258; x=1784658058; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nmo5BFmH0BGw3SSnYVB0DqqeTBkMC36HDpza4IBAqYc=;
        b=XxwjrwpwddNtjMiY/N4jN7v7hIiCg8tSyykK1TBcJBDG9Vc6wL3WGkdGPcGmUm/EQN
         vRJgBXpkTbfLChABGIUf4vz1yD6Vb+sZccuEwzF+K8CRyzfmXdY7DcCsy6/kEbqGx60q
         ObkmpJCzyhMhzo5oB/sIL9o7hcDOkgUvS5SKqCQdWA2eZ1uF8UhrbmYrcErSlZhFXT29
         zl931IA7XeCFOzaGtRouf75Tu72PShr3ChV4JUxqYIlg+0kJ6pmpJpIGfyfWYP/SSUDs
         ixaAFzE/sXRVasF+dMD7rTbsKAkEPiSzNR1M+j3ogvKEgi3GIw/WCYzynDoKPFk4zhmH
         vLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784053258; x=1784658058;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nmo5BFmH0BGw3SSnYVB0DqqeTBkMC36HDpza4IBAqYc=;
        b=r6Quo7Dfl02Dq1zH1Js2824PU56JGyPeb3131znqE7zBTEcTTVro1CaBBjtkIqfCoI
         ZVQO3t3m4nzSL7Ljw065ineLLBcmqkldIUNxhlijNoEyyoaJWGamuH+HWQdyRDyAtp5k
         JDg9imBKum1Phn4pg9pvNQ+MRNzsVh3zSFuzriUnziiuGip46/4Bs4RvPnx+Iw9Wh3mx
         kPai5wotpCdt5xffXM+0PHIf28D0qJd3bKCPoJl7Dx00Bab6YtK5+V5x6C967z/WhoPT
         FVzcaSn1qMkPQPDnwhXNKW9lVcWP8ABXbjm7FwNv1dbmSfiI+hbwuybdYQXHKM3WN81L
         b1XQ==
X-Gm-Message-State: AOJu0YxMxb4etA1+x/E38R9zLJ0lC7edrwY4bNPnwVOFtwFWjcB/dAtM
	2zCPh4BqfEGRFAyhUZHvtOgiswIPv9fjbzWrYZ/6Dq0hhUxo5iTVOSnySrGGmamSQBbbqQAkghA
	CmnKz6R8wzU4w6ZTagfb0rF8NOoztBM2nspcavRXOij73yDIWE179W/2m
X-Gm-Gg: AfdE7ckV/AjN/zLBSKQOMFTSK10ou9RaImuw3V/iP5WJx4m2z3nId+Nk7OElv4PbanA
	sce69434HWNt7l3jzouWGCwEEl86xRW9blSiiyiGEfZpKmKx0novRAyEJ5FSVEmJTR/MhLXWl79
	l+CdvEa0Jnspc2/vaPifrHyQ/HDPT3NdbtkTftPnvE7R+0sPgshm8D9BgVoPbGGkNmJ23ISK5X6
	zY5iOgGxB+3lF55JC5oNNl2aGbbQMupOyURFtGPwHgl9iJllxPXpBI3AKepavxuF10kBSVX
X-Received: by 2002:a17:90b:2f0f:b0:38d:f710:63f0 with SMTP id
 98e67ed59e1d1-38df7106443mr8092118a91.43.1784053257798; Tue, 14 Jul 2026
 11:20:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703102759.9626-1-achillesgaikwad@gmail.com>
 <20260707152305.15324-1-achillesgaikwad@gmail.com> <CAHC9VhSWWhMjs282cOTT45gn0pa8bDSxD0H24_is7k4tXmGJxQ@mail.gmail.com>
 <ac4f209c-f465-4938-adae-ecd00ecab175@app.fastmail.com> <CAHC9VhQYjj3--K6KkDJBf6LfXqtj4TPh5LsMBpPYc0-Zz6wTMA@mail.gmail.com>
 <CAEjxPJ7dttPDxQDa_xXFd1H-QT_vkUwjtnH+=3cmG5dhSiaAXw@mail.gmail.com>
 <CAHC9VhSyCuiPBRWz_vUbx7+L5yLiXkjKX+7UyCLr82-_gAj2NQ@mail.gmail.com>
 <CAEjxPJ4+wgUDY3YxajZ=2D3WLzgat_Mqvr05VtJ4KrXW7_kuXA@mail.gmail.com>
 <CAHC9VhSxpAx+G35fbcMjJ1PfqJxDZYpTEu=qpO+0PQe=nkX5-g@mail.gmail.com>
 <CAHC9VhRq+Vth-4D4OHFAY_6hXqmj=MgTc_2G=3Ehr6bAQzp26Q@mail.gmail.com> <CAHC9VhQy4LOgQg0mk+s5sjHOzMe1sxPUgJ2W7vRT8ms4znZp+Q@mail.gmail.com>
In-Reply-To: <CAHC9VhQy4LOgQg0mk+s5sjHOzMe1sxPUgJ2W7vRT8ms4znZp+Q@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 14 Jul 2026 14:20:44 -0400
X-Gm-Features: AUfX_myy9lHcOpd_cDyjYmBWTe6s3i0pZ8Os5e9WcvXk9QQAvyVGAEYp6ElR_c8
Message-ID: <CAHC9VhR+pWFnt=1pBJTky78br7NsfVcZE=V4UkfkfTbMvBo+mQ@mail.gmail.com>
Subject: Re: [PATCH v2] NFSv4.2: fix nfs4_listxattr size accounting
To: linux-nfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>, jlayton@kernel.org, 
	chuck.lever@oracle.com
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Achilles Gaikwad <achillesgaikwad@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23318-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-nfs@vger.kernel.org,m:anna@kernel.org,m:jlayton@kernel.org,m:chuck.lever@oracle.com,m:stephen.smalley.work@gmail.com,m:achillesgaikwad@gmail.com,m:trondmy@kernel.org,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:stephensmalleywork@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[paul@paul-moore.com,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,mail.gmail.com:mid,paul-moore.com:from_mime,paul-moore.com:url,paul-moore.com:email,paul-moore.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A2D8E757CDB

On Fri, Jul 10, 2026 at 6:20=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> ... and scratch that, the offending commit was that one.
>
>    commit 01c2305795a3b6b164df48e72b12022a68fd60c1
>    Author: Jeff Layton <jlayton@kernel.org>
>    Date:   Wed Mar 25 10:40:32 2026 -0400
>
>    nfsd: add netlink upcall for the nfsd.fh cache
>
>    Add netlink-based cache upcall support for the expkey (nfsd.fh) cache,
>    following the same pattern as the existing svc_export netlink support.
>
>    Add expkey to the cache-type enum, a new expkey attribute-set with
>    client, fsidtype, fsid, negative, expiry, and path fields, and the
>    expkey-get-reqs / expkey-set-reqs operations to the nfsd YAML spec
>    and generated headers.
>
>    Implement nfsd_nl_expkey_get_reqs_dumpit() which snapshots pending
>    expkey cache requests and sends each entry's seqno, client name,
>    fsidtype, and fsid over netlink.
>
>    Implement nfsd_nl_expkey_set_reqs_doit() which parses expkey cache
>    responses from userspace (client, fsidtype, fsid, expiry, and path
>    or negative flag) and updates the cache via svc_expkey_lookup() /
>    svc_expkey_update().
>
>    Wire up the expkey_notify() callback in svc_expkey_cache_template
>    so cache misses trigger NFSD_CMD_CACHE_NOTIFY multicast events with
>    NFSD_CACHE_TYPE_EXPKEY.
>
>    Signed-off-by: Jeff Layton <jlayton@kernel.org>
>    Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Playing around with it some this morning on a current Fedora Rawhide
system, I can reproduce the problem with a simple command line:

 %  mount -t nfs localhost:/mnt/test /mnt/nfs_test
 mount.nfs: Connection refused for localhost:/mnt/test on /mnt/nfs_test

... adding an explicit "vers=3D{4,4.1,4.2}" has no effect; versions 2
and 3 are no supported on my kernel builds.  There is nothing obvious
in dmesg.  I've run with SELinux both in permissive mode and disabled
and encountered the same problem.  This doesn't appear to be related
to SELinux, it may simply be that we are the first ones to hit this.

As there was some earlier discussion about this being a wonky
interaction with userspace, here are some of the relevant packages on
my system:

nfs-common-utils-2.9.1-4.rc4.fc45.x86_64
nfs-client-utils-2.9.1-4.rc4.fc45.x86_64
nfsv4-client-utils-2.9.1-4.rc4.fc45.x86_64
nfs-utils-2.9.1-4.rc4.fc45.x86_64

My next step is to try disabling portions of the NFS file handle cache
upcall to see if that is the issue, but it would be nice if the NFS
devs could take a look at this too.  I'm happy to test things out or
answer any questions about my test system.

--=20
paul-moore.com

