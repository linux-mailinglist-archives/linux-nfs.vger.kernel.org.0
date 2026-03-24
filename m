Return-Path: <linux-nfs+bounces-20363-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FNEKrnIwmmIlgQAu9opvQ
	(envelope-from <linux-nfs+bounces-20363-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2026 18:24:09 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E760319F33
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2026 18:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7EF4F3019FD2
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2026 17:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A186C407110;
	Tue, 24 Mar 2026 17:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="PClXNsTb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544D33D7D76
	for <linux-nfs@vger.kernel.org>; Tue, 24 Mar 2026 17:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774372908; cv=pass; b=swpRmaPD8yb+IiIWYsCnN01G80NRpbcsWKcfHGqWOyutsjzTOh2uCUeQN/MsKk8Ly4jCWS4btdX/hH/bWWO6hkRVk/XyYc7+bY41esH9M93rK0bT1QYYWKdTaE/8aUr4DNNj0oBI6lndRufRVzy5xGArXjm8TYmiZLynMn57ibI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774372908; c=relaxed/simple;
	bh=1NQ9zqpclREAJEvYW4TY1T5Eh2x1xfvh6tz5PU7G3jo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nsSJYO+72g8epAiUX8J7kWxHISPrKUgGBnsul867rC8lQGsYg6KrvoF1a1zIReZ0P4h2rKsvNjf/pcGmr5LsxGw+Fcw+oXScFbw4STsWC7i97PjfW8B7q6vtzDvEL5rnb0sDK70fWI5mk18HR30KH53msmVKz6Kums8bJ6RdgRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=PClXNsTb; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38be66a9fc0so41103301fa.1
        for <linux-nfs@vger.kernel.org>; Tue, 24 Mar 2026 10:21:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774372904; cv=none;
        d=google.com; s=arc-20240605;
        b=ivric2IBgkB4/s8xz0ViVAtb3+OT+YoWixNoYxgN80JOhQ5w1gSnCFKu9eqwZB8W8+
         BZ9RjpxzoU7mat7pqAhOHDQXoq/0QAwiaDpUPxHYQ8RUjJ4PmqKQv4PQAO4dB8seBZBY
         Xzv6CXdy5WqiqFEvTtVMBCaPlZSXCXCMPPHzgpLl9Uz6OJSrTSsJLpH3Z2cSgirHzszj
         MHz8wLDpc3wYaOJ+eCCdV+jtMI5iYvZNdZe7PfwUQxnzCyJmzuiVMbeb4oOHSaun0rhZ
         zo24aPhogUFcO+pA3qrVTwzMu7qAejJNvP5fPznCQ9r2/IdvDr5TkgcIqPpSvnnSHUYp
         vrUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4dkq8+ckVQdCCiFoexzLSsF2u+5U3jOekIfM1h/eA9c=;
        fh=Y9837kGXRUkNwrEEdzO4s2fVMj+XVg7lP2ail4p250U=;
        b=c4m/Zj5sG+iA1iVG34m9wgGoOaWGW1fgggyZeM0Djk2szm6yky8eSw6yaPYT4IdjjQ
         hMtKAZDPKovsGRRTdNmD3qkqaME+Zz59Gbohg/5i4hCIk0+7mVNlrtYWWG60EVHAfyKt
         xKrSmlzPVqh5aLgLktpnuDeJ6bEy4Dz9S4MwVcsRp9mhqnpwOAZrQn6ncpcsk3O4rY//
         QDwxcaR7CBLWtTGsoJ+m4BdXU1qn2aWingGjC+YakNnLHxZh1QMNyepx1D32rLuD3Gyf
         VGA9A9Q95wZJLTmXEU+nccZ+M+FxTnmUQ+SR5DBTlmcwcjezLByYf6MPvCSJaHWOLjId
         eE+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1774372904; x=1774977704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dkq8+ckVQdCCiFoexzLSsF2u+5U3jOekIfM1h/eA9c=;
        b=PClXNsTb0WoYv8MgqTfxssIuYWA/2Oncd1QJfhIQrWSdWMaD8h0tAdfO9SN8adhTrH
         nO55Tw7DBt4Sc8fHXPHZnrRah2h8uffXX+MV1/vsQfLt6NBc2n8TPcryRFzycCCyfiiZ
         h5MX4KEsYaOICCPhmH/WCDD1InkMcHKvLQN0cC26xC49ex0r0u3dL/TLwycVT5urucxS
         aWfy7mpkFijMSO3Su9eopHNjXcUyzmrTmAp0kJMBpJlw9fk5nMYa3qC4YvkDhZN38uHM
         MzEXkwQ1vu9DNvGyxn4LAvbmtXzjfHG4x5peNcpCJ3ncAdzUx3ndWfKMs/2zG0CNm0PN
         WlxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774372904; x=1774977704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4dkq8+ckVQdCCiFoexzLSsF2u+5U3jOekIfM1h/eA9c=;
        b=raZzgFKKWDmC6CTDUgboxZtxy9beHNKQDeHO2BiW7bMnzhUujOTPd/dXBlyppP/Mn4
         3Eaaf/W3+gBjF6oEpYPbWynZTQuE3B1SfqXdgenxnfHsACC0yd6/lvutjiJnq4jDsJ8C
         B3TW/u64Q5tjT11Dtd0Da+49KxevbQXDUpmA4G6PfTWEV5wJ67W33jPr1U9escZ25Axc
         QkfVHYcNVsceL6tYkAkpSX7Ow7lQX5ViUv6wZTRbVrx1sDp68y1gUjm5GWU2yCWCtDL5
         F7h+ciSDeLnK27v5ZRgGiTjkrDuzQJkdz/dYaUROf7OOREl1UujHsjSPDI1jvuAdtFym
         oUaA==
X-Forwarded-Encrypted: i=1; AJvYcCU1Qig8czwjnxU3WgITZ5J72ZxhFPxDq6TPqggf7rOaKQ7dioikniOldaB7lZsYPd1HfPTe4RTIdj4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv3hwOtc5Lcbd6fxsOyR348/4F9ontvO/ngrl4FUC3+iHw6sxX
	oLA2jDXe4V5MGsJPwSEPS3sdHxlCBOg3DkTPkO9VpHvtYlu0Xvfx5wgcHGJRVWqI1LpjdU063CT
	NFU6N9N0fpKBwVsVUySwpn8iaKrLJYLbcig==
X-Gm-Gg: ATEYQzyAb32gw6tjdXLtLm2pybquRiHOxvCWdtPdoo63nCXk58D+ys0ABM3l101sVcy
	nnyYTpOb2T+bbyJAC/mCMUY0JjVMAHQep5B+M6Ld9jNnlfPXn7fBGoqOcriNJuzK0ih8kaKgMNQ
	nsyYRbOKVrmyAY+EMbqQLJ9n9YlSZ1IecSqsbM8sx0xdCrrw89aliRDkwMyKGnnHwYbfGJ9ICro
	8JMzlrDhtKfFNEhhPnDiH1xruOV7BABb+tlqUcgPsNyyEzd4Mkkt34AJ+6SB8Xh1q/PffMXfHyo
	lBWLn+Uv+CdcV3YPyX2KmsX8+8lXUj5s97JEjglBA0JjS0voAlU=
X-Received: by 2002:a05:651c:234d:10b0:38a:291c:dbcc with SMTP id
 38308e7fff4ca-38c43173e8dmr499501fa.19.1774372904210; Tue, 24 Mar 2026
 10:21:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312171526.85759-1-okorniev@redhat.com>
In-Reply-To: <20260312171526.85759-1-okorniev@redhat.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Tue, 24 Mar 2026 13:21:32 -0400
X-Gm-Features: AaiRm50xYnAKZxV29Ohb1IQK-CRolX1Z0e9yr2LgEvbRqT6qxU6Ay940cGZw22k
Message-ID: <CAN-5tyGWe+VVt3b-JegY7O0N_=zjbnnHRKDv0nStjcf9aa7smg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] NFS: fix writeback in presence of errors
To: Olga Kornievskaia <okorniev@redhat.com>
Cc: trondmy@kernel.org, anna.schumaker@oracle.com, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[umich.edu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[umich.edu:s=google-2016-06-03];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20363-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[umich.edu:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aglo@umich.edu,linux-nfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9E760319F33
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 1:15=E2=80=AFPM Olga Kornievskaia <okorniev@redhat.=
com> wrote:
>
> After running xfstest generic/751, in certain conditions, can have
> a writeback IO stuck while experiencing one of the two patterns.
>
> Pattern#1: writeback IO experiences ENOSPC on an offset smaller
> than the filesize. Example,
> write offset=3D0 len=3D4096 how=3Dunstable OK
> write offset=3D8192 len=3D4096 how=3Dunstable OK
> write offset=3D12288 len=3D4096 how=3Dunstable ENOSPC
> write offset=3D4096 len=3D4096 how=3Dunstable ENOSPC
> client sends a commit and receives a verifier which is different
> from the last successful write. It marks pages dirty and writeback
> retries. But it again send writes unstable and gets into the same
> pattern, running into the ENOSPC error and sending a commit because
> writes were sent at unstable.

The patch doesn't actually fix this pattern. I mistakenly thought it
was. I continue working on trying to find the solution but it looks
like the same approach does not work (ie marking the request in some
way so that the next time writeback happens it does so sync doesn't
work as each time writeback creates a new request and thus the
requests that was marked is not useful).

> Pattern#2: an unstable write followed by a short write and ENOSPC.
> write offset=3D0 len=3D4096 how=3Dunstable OK
> write offset=3D4096 len=3D4096 how=3Dunstable returns OK but count=3D100
> write offset=3D4197 len=3D3996 how=3Dstable returns ENOSPC
> client send a commit and receives a verifier different from
> the last unstable write. The same behaviour is retried in a loop.

This pattern the patch does fix though.

>
> Instead, this patch proposes to identify those conditions and mark
> requests to be done synchronously instead.
>
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> ---
>  fs/nfs/pagelist.c        | 2 ++
>  fs/nfs/write.c           | 2 ++
>  include/linux/nfs_page.h | 1 +
>  3 files changed, 5 insertions(+)
>
> diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
> index a9373de891c9..b835b197a223 100644
> --- a/fs/nfs/pagelist.c
> +++ b/fs/nfs/pagelist.c
> @@ -1186,6 +1186,8 @@ static int __nfs_pageio_add_request(struct nfs_page=
io_descriptor *desc,
>
>         nfs_page_group_lock(req);
>
> +       if (test_bit(PG_SYNC, &req->wb_flags))
> +               desc->pg_ioflags |=3D FLUSH_STABLE;
>         subreq =3D req;
>         subreq_size =3D subreq->wb_bytes;
>         for(;;) {
> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> index 1ed4b3590b1a..78f412851d59 100644
> --- a/fs/nfs/write.c
> +++ b/fs/nfs/write.c
> @@ -1554,6 +1554,7 @@ static void nfs_writeback_result(struct rpc_task *t=
ask,
>         if (resp->count < argp->count) {
>                 static unsigned long    complain;
>
> +               set_bit(PG_SYNC, &hdr->req->wb_flags);
>                 /* This a short write! */
>                 nfs_inc_stats(hdr->inode, NFSIOS_SHORTWRITE);
>
> @@ -1837,6 +1838,7 @@ static void nfs_commit_release_pages(struct nfs_com=
mit_data *data)
>                 /* We have a mismatch. Write the page again */
>                 dprintk(" mismatch\n");
>                 nfs_mark_request_dirty(req);
> +               set_bit(PG_SYNC, &req->wb_flags);
>                 atomic_long_inc(&NFS_I(data->inode)->redirtied_pages);
>         next:
>                 nfs_unlock_and_release_request(req);
> diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
> index afe1d8f09d89..e28599bebd44 100644
> --- a/include/linux/nfs_page.h
> +++ b/include/linux/nfs_page.h
> @@ -37,6 +37,7 @@ enum {
>         PG_REMOVE,              /* page group sync bit in write path */
>         PG_CONTENDED1,          /* Is someone waiting for a lock? */
>         PG_CONTENDED2,          /* Is someone waiting for a lock? */
> +       PG_SYNC,                /* writeback must write stable */
>  };
>
>  struct nfs_inode;
> --
> 2.52.0
>
>

