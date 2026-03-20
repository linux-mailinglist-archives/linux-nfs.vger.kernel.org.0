Return-Path: <linux-nfs+bounces-20294-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOlnF0SIvWnQ+gIAu9opvQ
	(envelope-from <linux-nfs+bounces-20294-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Mar 2026 18:47:48 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD2B2DEE32
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Mar 2026 18:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6DC8304209D
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Mar 2026 17:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233FA3B19C0;
	Fri, 20 Mar 2026 17:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hY53LZ26"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8F33D6CB2
	for <linux-nfs@vger.kernel.org>; Fri, 20 Mar 2026 17:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774028637; cv=pass; b=dmvH5WrVFkXcqDzN7PdVgS1pNQXFaSwAMaFECfC+tnRlIgW+AKrhgLrHCXbRmUhsWpyHiwb8PuCaLiEbEOJcxwQvO0vggUs328yk8XiSIX5iBEkttWBAiwAQ5E381XU7Nn/Bw3L3tkmps2hud0JZX6sH0ZP9wRMNqUQqLtTtvsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774028637; c=relaxed/simple;
	bh=xdQJRwjK/sV/0zyDr7fhSs57NkGs44YTnOiMeU8wh3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a8iuJJ5G4RjbDSUfawyBEnuRccVfFc6UtGQQS0BP/R7WieU/E7ta2sFT9HIfLuCQSvTzW6D9L3gOOdfgopYuiwR9yxD/wIraWKA2HRKLT0xXcpixgxq0DV6wr4LuMKio4MUQ4RM6915F4cvN0ppVXMDzpkfVjSGGNtYtoFUzcK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hY53LZ26; arc=pass smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5637886c92aso435558e0c.0
        for <linux-nfs@vger.kernel.org>; Fri, 20 Mar 2026 10:43:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774028634; cv=none;
        d=google.com; s=arc-20240605;
        b=Wt3NiMm+XXx/QyQiV05KZFd1sTVzF5qJksJzlyZrBK0oW4taFzR085MhslwG+d6ZTS
         5HHlxI4PtCgnsBNr38gygzd5ZntJkJdwsfPF6/X6AdQg8ttAPneNFCB1RMQU4Ra88A/s
         3uG2dzPVeRvZTs7fhaaQZXDUdqIU2BiIyNdggOcTrT74qm3gB7Juw5//h1wSc8CI7Bv2
         WN58aPVVunaG8C4I0E0uOL36UzbFR1C6xhE/OMjJ/0QTz4kln5Ce5AIBEEewrTk5RFaE
         zwEFMYu7A7+Ooe1DoGv1VyVFxa3tSbfRa5FjT29qWW5ThZqf54LaMvMFcGLdBnTUA+v1
         WLcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xdQJRwjK/sV/0zyDr7fhSs57NkGs44YTnOiMeU8wh3o=;
        fh=w7qvSOaihJ/mtYMKirppMTPCNNKzmbqUQ2jn0vsGDR0=;
        b=c0mgKzGU7uxtuP2ayFs+qvDEo3bsI6QYcAI4VNOIac+w+V7D52ujm2T4Gor4lcqIIS
         316AnfRi88volmyDXzmgkGx5Nv/o5DJxf2aL+ShvdwbCJgdIvGZ7zazt8CnJr1RN0vAF
         8JNWCmWgJPRnhS3TKmb8n19tvotKGBVnzcQYVLuzNIAsogqyeL82tF+vDWbQP3hzMjTZ
         blGIUJB+bJuXGD4ntqRAEvQGtrFiqX0t70ponjWRivJKeK/nsNpl/8io2sT1F/VZ20zh
         7FOsHtx2AO2tFUDdedzCfHGhRr8Jl9pgVesLaORh/bqcfpajN32C6tVdYoe5d1rD3Qjf
         vgNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774028634; x=1774633434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdQJRwjK/sV/0zyDr7fhSs57NkGs44YTnOiMeU8wh3o=;
        b=hY53LZ26rjXa+Z/Yf9iL4Del9b2cbysT96iSkCNgX5fTpKoMEHYQu57m4HvrVU5BLM
         JYql8f3LMpgOM1Ocek3ZD7TF4VjnBRPnNpjStViOmGSnvc7LZ3xBsnqNkgZ3neLe8C+B
         E9KbTp5PAW8qmbYBg5eF9qy9C1EWpa5FffhJh+xRlLb76QaBwDOliBMQZ3Je+EBwOM/3
         gCbDIfYpwtHeWmr2tmQL/kii1mlrjfl6OBN5MNKQmKRvwaWrdT0hpXXe3UaOtZB5Ng9A
         Hpu7OsSiKWLOEW6v86gIbcLVOt3pErwt+ecUF4G3lMQk22nRYpZoluVt2O+pips53cuU
         yjqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774028634; x=1774633434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xdQJRwjK/sV/0zyDr7fhSs57NkGs44YTnOiMeU8wh3o=;
        b=Ab03kWrymXEcAcJ4bxHU3JdWeEhcTYEtKTrdlRN9BfbysEbkRPzzP7Utx7xINkZFup
         7wzjRLOa9VOOVH/zvUcSp77zHIzPZnaDxUfOlEGCiHqWzR15cs5DpO/jpYJwpSh8A+Yg
         h/UNR/D0hHgXgCXja2E/E1H6Z/HMn9KcjkLjpbF1HhD2tRTZQPx5tm47Mo3IMG04LCjm
         JHgV4BY2w8cAMHCLP3E4McH1whCjAwGBGtwqpw9H4lv4HOrMEVI4RxKnLX/MMENb5loT
         ivHwqOUq8AdQTDiLatQdy8vuM5McGWqdNY06+kaGigxKgEtdBbRGHJUANxvcb25KUwtI
         4KPA==
X-Forwarded-Encrypted: i=1; AJvYcCVGUcrO9u7z7f/LIToedJHKyTJFoJHriBY0eAk1X3V3ch6mirHy/n5WdD005smbUIs3w5ZCS43TAI8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Astk8pJ0PBIJL9X253mYZimNvMHRxrx96GhzU+HW0dkBtpjX
	BXPCD0MtCbGdsrYXF5pEviaCVonyTO+thBHpxV2xB6gsW3HD1FXOfZaPiIe4PQw0VcWiCkw+NI4
	xsymGQCpxwaBi96Wp/zI9v/JqMpK4tYY=
X-Gm-Gg: ATEYQzwKN/2xQUebjViK6wqgXVBfN+gnejRuO1f9vYcadL18/etRITu59j0pbajd/nf
	KbHQYxcZm9gsXPkyHAv5b2Jj29JnSHFSJgZxKt9lFl/rfdRGbEP2w4eeYKgb82iM31oN4ro6E2p
	U/DXasScQVO8z4HYfA2dP/IYDxH1SJ1hlQkMV7XQtKh0B+BTZUYXfqgN7hPW3FUo8ccW+U9r6EZ
	qD2IePuGlQXg/+xWjIVV48wwaEeG747RNMTnG8hZDy+eeMht5ZGVseOYAWen15TTA2Q04KkaSQ+
	2QQg7zw=
X-Received: by 2002:a05:6122:169f:b0:56c:c71a:e09a with SMTP id
 71dfb90a1353d-56cde43930emr1914893e0c.14.1774028634104; Fri, 20 Mar 2026
 10:43:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319141846.78222-1-seanwascoding@gmail.com> <ab04wi3x3JNVbvPm@black.igk.intel.com>
In-Reply-To: <ab04wi3x3JNVbvPm@black.igk.intel.com>
From: Sean Chang <seanwascoding@gmail.com>
Date: Sat, 21 Mar 2026 01:43:42 +0800
X-Gm-Features: AaiRm53AJV5D34Vu-3dquoTMOhJs2DUTyrNhZHGy1pa8coMdPVtsQQtp52EPLFs
Message-ID: <CAAb=EJUQtj08BjbzeovG2dHBfwb5vgza+HdM=ck-bn9n9Ha0BA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] sunrpc/nfs: cleanup redundant debug checks and
 refactor macros
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Chuck Lever <chuck.lever@oracle.com>, 
	David Laight <david.laight.linux@gmail.com>, Anna Schumaker <anna@kernel.org>, netdev@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20294-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,oracle.com,gmail.com,kernel.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.380];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BBD2B2DEE32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 8:08=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Thu, Mar 19, 2026 at 10:18:43PM +0800, Sean Chang wrote:
> > This series cleans up redundant IS_ENABLED(CONFIG_SUNRPC_DEBUG) guards
> > across sunrpc, nfsd, and lockd, as these checks are already handled
> > within the dprintk macros.
> >
> > Additionally, it refactors the nfs_errorf() macros into a safer
> > do-while(0) pattern and removes unused nfs_warnf() macros to improve
> > code maintainability.
>
> Shall we also revert the commit ebae102897e7 ("nfsd: Mark variable
> __maybe_unused to avoid W=3D1 build break") as it seems related to
> dprintk() issues?
>

That's a great catch. I've verified that with the new dprintk() refactoring=
,
those __maybe_unused attributes are indeed redundant. I will include a
new patch in v4 to remove them and properly credit the cleanup. Thanks!

Best Regards,
Sean

