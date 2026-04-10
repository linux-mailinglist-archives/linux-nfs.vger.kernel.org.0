Return-Path: <linux-nfs+bounces-20807-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKIiIfUK2WnnlQgAu9opvQ
	(envelope-from <linux-nfs+bounces-20807-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Apr 2026 16:36:37 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD673D8B79
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Apr 2026 16:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A089308EBAF
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Apr 2026 14:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BAD3D47A0;
	Fri, 10 Apr 2026 14:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="REGQiAUN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECBB30FC36
	for <linux-nfs@vger.kernel.org>; Fri, 10 Apr 2026 14:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775831444; cv=none; b=WCQiu2aoM25+H0GLyGm5GvMwP/rqfQc3bOpT0/WnwXXMGWrsKsClxn6PDCfmt5bYnnGolg0IIsOosZG/j3NNGwSctkHxa3PvnHpe25kRhAFI4M/1t2o8/LmDlzV6hwvUH51fQYkXbECfeOK3ZXBbaE8jDUrxEpdYPXQUalQPgqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775831444; c=relaxed/simple;
	bh=TQeeegfY0L21N3lRHnbJ5Dm4HiBHSorSFFIp2y8ypl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qy3KjYAtUuOP1ENAgMVbR7iTGFXpyVsdTpqDKWuXLeMD9zzpwrtZikpEMS2L0b0ApDpdbZaLvYrPcR0fbLR3AdSBM7Zg5DtMWMUZ18ZAA2waC9dWII0GwQihmR+TxnBqVHx0AK16mbarko0/OJU98onEgFqOgGJLp1pDp/LW2n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=REGQiAUN; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d4c12ff3d5so1859095a34.2
        for <linux-nfs@vger.kernel.org>; Fri, 10 Apr 2026 07:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1775831440; x=1776436240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDf17iELweSQBEB0PxUVBr9/blquXg+klPEZm7g/By4=;
        b=REGQiAUNmCnvfYER6ocZ3QFDECMvr9DYAf9IAZHez4pCKVqKV/fHPxJ3CYfUZAVYaB
         z2YsdFk4byWS/ytmrKfihrk7wbl6TUkq7cCwLz/8ewvajN+R+GbYBSjOWsRm82iw2FZc
         AkDXArQ4yKvW3VbdTYP5o6hZJeiiJEfir1ZEkAoSP/rS5grn33ccwpaISHS6RYmGMowH
         O2LGH+804giKjuwmavH+hK01ntIGfXjpB165YTE7ucRqYc1ax0v6pIIk8hMaGLpQnB/E
         dNw2hw6kKTsj5hjNuE1VlsqPxoMskUiDxe6+WO5N20SgA2Sg/o4lpl1Wsqdgfz9Mgi1g
         Io6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775831440; x=1776436240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mDf17iELweSQBEB0PxUVBr9/blquXg+klPEZm7g/By4=;
        b=Qhk5zt7zzOx+z8wv65QcdZxTfFtUDhCRh4yG0CptWir+5FcQF1pAfNXIhFoXNvtD4g
         Myi700q+wFOffFl8K6GtyR/NOu4w59xV8mvfMjM2HdnbRKIvSMXDzWcvWRVUHW88e4he
         /37VfgnJc9TE6cIPUnnjlOZGKlg6Ne/vwpUC1WLZu4GW/J7XLv9BABJbwHJ7+irbeV7x
         NOofV8/lkl72vKw2UYE8SpdlREhxLxcIekGLT1QW/PEhDXpLtwSeZrKKBnLtq1qs4rGo
         dVzR4nD7JkhMTsuxx2zBVz0J+vXTi3WoR1YDWxlihh4zaRtHx76lnc3lunhvSDWi7+QZ
         a/tA==
X-Forwarded-Encrypted: i=1; AJvYcCXAvTycQaNrbcEHhtl2gtRvYj4uMSR5i0opOGC20+4hMeaOy6AWr3TonuQjkDZL/tPNZ8/D5KLp7ys=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkjTWYwauYsBNn7buwBYOT9XvYLrNGuwJFFvqa2uKD1/HpZ6fM
	Y6Mer85Nj6Ldos2qmjJJmBfXYCzof4NCBbtwiNd4usRtcUWJvNJutwYtU3eY7EKG0OI=
X-Gm-Gg: AeBDietmOAZttQBw7Cxh2Wf/RBorIqid620Pu0D2aK7HZgP5XC7+j3MwLl0mHxbCnvm
	hS2PWd0QyGSuczVQFJJNTyGDTKY1wcx5czONLgG1arvXcVD+42zrfwmBAv5QrWebQPzCbxO3aLh
	BWTlxkqS7aTMpwhzEP6/6CcJATlD4KWz4bnpDFS+yRyJrIiNiVT+TA624B7DgV+cz/X1qDtSwTS
	fOxu8WrKhcto9nbUrAgzDjsvWOm+luh3VnKezaIwGqD6lngpXhAKn0ZQJvJhR5eWQSoKVxubR/f
	4q+Ja4Lvi1W9qWd3F3FgPYboK0MPArWNjzJqJKPM/pCNIjhjtNS/94Mv+6Kew6YVpd6Pb1L9ud1
	7lZu8/2QO0xQR1ufEnk16ZxPSmJFjNJNcsKcmbuI/j+kR7zQN9+ABUosDO7ZtmsGKoEBOyU/6mg
	auZpEGRMKMM3t91QDeXSTOo8jsze23RTcLrsy2SzTR/As=
X-Received: by 2002:a05:6820:750d:b0:67c:27a7:8c4b with SMTP id 006d021491bc7-68be8bde8f8mr1122751eaf.54.1775831440290;
        Fri, 10 Apr 2026 07:30:40 -0700 (PDT)
Received: from [192.168.254.51] ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-68bcacc9925sm1525379eaf.9.2026.04.10.07.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 07:30:39 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Ben Roberts <ben.roberts@gsacapital.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pNFS: deadlock in pnfs_send_layoutreturn
Date: Fri, 10 Apr 2026 10:30:38 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <B8730746-9646-4416-8417-D73B24FAB79A@hammerspace.com>
In-Reply-To: <20260408122534.537816-1-ben.roberts@gsacapital.com>
References: <20260408122534.537816-1-ben.roberts@gsacapital.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20807-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gsacapital.com:email,gsacapital.com:url,hammerspace.com:dkim,hammerspace.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1BD673D8B79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Ben,

Did you reproduce and diagnose this problem on a recent upstream kernel
version?  If not, you probably want to report the issue to your Red Hat
support channel directly instead of sending fixes upstream because the
maintainers will want to see patches and fixes against the upstream code.=

The code in 5.14.0-611.9.1.el9 may have different behaviors.

Ben

On 8 Apr 2026, at 8:25, Ben Roberts wrote:

> On a HPC cluster running 5.14.0-611.9.1.el9.x86_64, regular deadlocks w=
ere
> seen within pnfs_send_layoutreturn leading to userspace processes stuck=
 in
> uninterruptible sleep, ultimately requiring reboots to clear. This was
> occurring frequently, sometimes multiple times per day on specific host=
s
> with heavy load.  Claude code was tasked with hunting down any potentia=
l
> deadlocks within pnfs_send_layoutreturn, and identified the following
> condition. This patch has been running in production on top of the EL9
> kernel for over three months without any reoccurrence of the deadlock.
>
> The pnfs_send_layoutreturn() function can deadlock when memory
> allocation fails. The issue occurs in the error path where
> pnfs_put_layout_hdr() is called, which may trigger
> pnfs_layoutreturn_before_put_layout_hdr(), potentially causing
> a recursive call back to pnfs_send_layoutreturn().
>
> Call chain that triggers the deadlock:
> 1. pnfs_send_layoutreturn() - kzalloc() fails
> 2. Error path calls pnfs_put_layout_hdr(lo)
> 3. pnfs_put_layout_hdr() calls pnfs_layoutreturn_before_put_layout_hdr(=
)
> 4. If NFS_LAYOUT_RETURN_REQUESTED is still set, attempts another
>    layoutreturn, creating recursion/deadlock
>
> The fix ensures that NFS_LAYOUT_RETURN_REQUESTED is cleared in the
> allocation failure path before calling pnfs_put_layout_hdr(). This
> prevents pnfs_layoutreturn_before_put_layout_hdr() from attempting
> another layout return, breaking the recursion cycle.
>
> v2 fixes a syntax error introduced while composing the original mail.
>
> Signed-off-by: Ben Roberts <ben.roberts@gsacapital.com>
> Assisted-by: Claude:claude-sonnet-4-5
> ---
>  fs/nfs/pnfs.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
> index bc13d1e69449..47bda53b2b3a 100644
> --- a/fs/nfs/pnfs.c
> +++ b/fs/nfs/pnfs.c
> @@ -1361,6 +1361,7 @@ pnfs_send_layoutreturn(struct pnfs_layout_hdr *lo=
,
>  	if (unlikely(lrp =3D=3D NULL)) {
>  		status =3D -ENOMEM;
>  		spin_lock(&ino->i_lock);
> +		pnfs_clear_layoutreturn_info(lo);
>  		pnfs_clear_layoutreturn_waitbit(lo);
>  		spin_unlock(&ino->i_lock);
>  		put_cred(cred);
> --
> 2.43.0
>
> For details of how GSA uses your personal information, please see our P=
rivacy Notice here: https://www.gsacapital.com/privacy-notice
>
> This email and any files transmitted with it contain confidential and p=
roprietary information and is solely for the use of the intended recipien=
t.
> If you are not the intended recipient please return the email to the se=
nder and delete it from your computer and you must not use, disclose, dis=
tribute, copy, print or rely on this email or its contents.
> This communication is for informational purposes only.
> It is not intended as an offer or solicitation for the purchase or sale=
 of any financial instrument or as an official confirmation of any transa=
ction.
> Any comments or statements made herein do not necessarily reflect those=
 of GSA Capital.
> GSA Capital Partners LLP is authorised and regulated by the Financial C=
onduct Authority and is registered in England and Wales at Stratton House=
, 5 Stratton Street, London W1J 8LA, number OC309261.
> GSA Capital Services Limited is registered in England and Wales at the =
same address, number 5320529.

