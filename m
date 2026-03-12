Return-Path: <linux-nfs+bounces-20068-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id D694CvbismnyQgAAu9opvQ
	(envelope-from <linux-nfs+bounces-20068-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 16:59:50 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B44275114
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 16:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47C4C301186D
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 15:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D230C2BE02A;
	Thu, 12 Mar 2026 15:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJPPurVV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3D33264D2
	for <linux-nfs@vger.kernel.org>; Thu, 12 Mar 2026 15:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773330869; cv=pass; b=KYnCqLy1+mZogevkSWsdbmPtclUfn5NzxcDBdQ8kKzizNcDc86oPc0u6Focl5V0bqe2haLFX2JLodaz6ZH9QHqjIFK+We5QQrZs5okOiB5GhhWOgf5iqZ5eMR7ijBnOfTzVxARXVpR4wPDXMfHklw9DxZ2SYb2JiOIo531Kfjao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773330869; c=relaxed/simple;
	bh=xRQ9RxoOagC+UbuuVdcPrUoQX/7LiLPSKHq71FYNf3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MVwUoDAcBrUtrGj7MBrPPnBN0716bIduZ0Ao/rsGocLN167j9NE6IJr/Hd8M/4yYsU0UT+X3lgQo1KKv99YQswtApbNe/kPr1JylpuF8i3xNE9qiZ7WjT9b+HKkJTczB25MQZhy1ba/X+3Ip1Xq8auViLDXSsXNPe4VcVYGMKW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJPPurVV; arc=pass smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-94dea0e029fso324264241.2
        for <linux-nfs@vger.kernel.org>; Thu, 12 Mar 2026 08:54:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773330867; cv=none;
        d=google.com; s=arc-20240605;
        b=LOWFtZjdYjqDb15XxkWQcIGIhwHBiChVImg5TUuUE7KwK4E8s7ucdVBUcRlx2THRyO
         02K8EgzJ1hn2pb00OdnJGRIDu5Sa8oqwerxZd89kYHZAhld0MtIAeLWQq6CUuxS4ySnD
         M5xSqDnwzF5HkhOMhhqtwoNQ38Gfe2qElljxuv3r1ndaT05ZkBq4TyNCg7HcNjGSZiUY
         hzK8F6YYZ4b7OWREyGT3FSOnF+7Wj1r0yadkBKHt9KA838FRtlYuuuMs85VJQWZuoZJq
         bJNbJc/CSbLbA+mPWcd5PjKQVvFnPUkdrwQlt95dowWY5PzHxUV6vQ3SB96RHYBjimFe
         iRDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+GW9HNl3VoMD61R2LszbWalRUfrPs8bujj+OuPBOZoU=;
        fh=2g1k6COxbKyyAzBTu6EiYZV+0mQuNtO4Vxo5VnYxFf4=;
        b=YDxFl4d/fq9CH7tkp68Oan8t7XIZQwxLFAFdjeoyZVb8KWaw//uMAng+m6knDomwq5
         FT215nHBJE6T+tLgTtBv6+2YO1dh11C40lOXUxoIniaL+kluH7KGO5BDe6oCZOE9HiUa
         M1TQEWu7TwItjTd/3esJLSqq5tI0jf5ZSsYlEEYgN026y8thw4h7a3LWstTjmfQ14Mxi
         06MowzzvdKT1ghmZd8JJreVsqhEPtTZpHbYUzb4kNB3AOAoq6j1cwaF2IU7hntztqdw+
         jCzMJUoYrE225ddxnb8BVi6Qe524DsgntRh3KhhV1G9w7JS6R8aEX86LjsZTE/0uZIzG
         62Vw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773330867; x=1773935667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GW9HNl3VoMD61R2LszbWalRUfrPs8bujj+OuPBOZoU=;
        b=DJPPurVV7GBCz9ALGvZiMM0n6gdQYMG/scLWMQOLjucK20KunPCgWJowDrXWi+i8Xi
         ZKZa0B1tizfDKNqgDJjGNYkpTHXht7X54wTiKeidfabYIxsO4EWctCSdEiwK3KpJ9kuI
         +/sgGlhjBP29+2LGAyISmYx5BNLAcjsyaI92J13KSWf6yPEfL7XDzOLyrGPOLurUWFI+
         G9KJmtjp10EiMzbtK0EImVi904chB2+LVIDYWFVbOP+Qpv64A0s3E7IU9GI3TlYpqF3t
         Kx6eUye1H4F+VdqdUtp7F4/5fx6t9mRUs7djPg4XTLYYruHzbJmRe0Xz13UZJSVuJCVt
         FRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773330867; x=1773935667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+GW9HNl3VoMD61R2LszbWalRUfrPs8bujj+OuPBOZoU=;
        b=czrOTSyPkBZxjnkIJSuBUjp7xy4M2zVgk2uSkD4yQFGGBfQbuyTmF1I+3QDEb3eFQD
         kdziSIMyj7g1cYzBoYRymylW6A4+adnW5CItaQRVkVk3R7rrMwJ8QG5J90E1wceIfEfM
         b24+wZmErR17T0qoK4VfuiEEd5aZmh50AInNSw/dlVXYUgQthW/LSvqPju7i9Zo/eNKs
         i2xQfsxMiuP4BcW3iSNT2gKOCqTFk7+SMV8LBhLizg6jpesHVetdHy+gRy4hdAVry6pL
         g4ZIQ/70PQCrrrbs7IKBvaKG6DkCG/RCwapiB1MQUYZs+Y77l6GXsWy09PeoHdXtVU6g
         ri+A==
X-Forwarded-Encrypted: i=1; AJvYcCUOXn53/lJ+v1Dv3cidoPIqmhYrX2RPZxNtalXhlEMBMS9l/R8skkLHRN2QxnftdSvH61yMJ8xzwkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx4G9egW/k9gg1YpoNrB5CfPos+UNXKmB4Jq9/PwJdW+dL3WTH
	K48n8RQnhpIHAqTlXAE9pBYH+s4pxI6g/nK/EBWc6qrGUwxp8WDm/dk+2qM7mYY4J0r8M8rGIxQ
	6CXu01yHREyJgzzkjV9TXZSnd4golSVI=
X-Gm-Gg: ATEYQzyGazL5JZV68kkoJohPjj45efVE39gOe8G72bXcSunodmCabmNkc450vgah5mR
	HFhumq9zFZkPtCox9zd3ozrQuKiBdCMMhLBUhxatbHR/FemJJNZd0Dn5jjPqMMZCLT6qma25CW2
	8tboUtm1Tzp7J3KlvrzdrqBA9OSRFySw84/LMMDFUcvl421eJpARIuqIFBWBKFZgGLWw1Gi+G0q
	nfcxmS9+yel+MnnMvsrSzNcrbnIWxyBgkyv7NXnZxkGnKmufieIy4ZY8WE/JIlAzN9p1h8Cn5ZI
	YNEl5l7U
X-Received: by 2002:a05:6102:1613:b0:5f8:e323:580d with SMTP id
 ada2fe7eead31-601deb4d094mr2688557137.11.1773330867550; Thu, 12 Mar 2026
 08:54:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303140725.86260-1-seanwascoding@gmail.com> <de652c45-9492-4bb8-a173-efce703b5174@app.fastmail.com>
In-Reply-To: <de652c45-9492-4bb8-a173-efce703b5174@app.fastmail.com>
From: Sean Chang <seanwascoding@gmail.com>
Date: Thu, 12 Mar 2026 23:54:15 +0800
X-Gm-Features: AaiRm530wpXoEJ0RfVzssU0-NmTo0KDz_Aq8_bT83Nj0JX-oY45ok05huyGafjM
Message-ID: <CAAb=EJViPvhD_ndONoU=OPcD_EXpA0Mh8500NJ9g9W_X0SpYRA@mail.gmail.com>
Subject: Re: [PATCH v2] sunrpc: simplify dprintk() macros and cleanup
 redundant debug guards
To: Chuck Lever <cel@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Chuck Lever <chuck.lever@oracle.com>, 
	David Laight <david.laight.linux@gmail.com>, Anna Schumaker <anna@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, netdev@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20068-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,oracle.com,gmail.com,kernel.org,intel.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: B8B44275114
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 5:47=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, Mar 03, 2026 at 10:07:25PM +0800, Sean Chang wrote:
> > Following David Laight's suggestion, simplify the macro definitions by
> > removing the unnecessary 'fmt' argument and using no_printk(__VA_ARGS__=
)
> > directly.
> >
> > Verification with .lst files under -O2 confirms that the compiler
> > successfully performs "dead code elimination". Even when variables
> > (like char buf[] in nfsfh.c) or static helper functions (like
> > nlmdbg_cookie2a() in svclock.c) are declared without #ifdef, they are
> > completely optimized out (no stack allocation, no symbol references in
> > the final executable) as they are only referenced within no_printk().
>
> Does this patch fixes also 202603110038.P6d14oxa-lkp@intel.com?
>

Hi Andy,
Regarding the LKP report:
I have reproduced the Sparse warning (void vs int mismatch) locally.
To resolve this, I'll use the do-while(0) form in v3 to ensure the macro
always evaluates to void:
-# define dfprintk(fac, ...)            no_printk(__VA_ARGS__)
-# define dfprintk_rcu(fac, ...)        no_printk(__VA_ARGS__)
+# define dfprintk(fac, ...)            do { no_printk(__VA_ARGS__); } whil=
e (0)
+# define dfprintk_rcu(fac, ...)        do { no_printk(__VA_ARGS__); } whil=
e (0)


On Thu, Mar 12, 2026 at 9:20=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
> Has a subsystem tree been chosen through which to merge these two patches=
?
>

Hi Chuck,
To make the review and merging process easier across different
subsystems, I will
send v3 as a 3-patch series:
[PATCH v3 1/3] sunrpc: Fix dprintk type mismatch using do-while(0)
    include/linux/sunrpc/debug.h
[PATCH v3 2/3] nfsd/lockd: Remove redundant debug checks
    fs/nfsd/nfsfh.c, fs/lockd/svclock.c
[PATCH v3 3/3] sunrpc/xprtrdma: Simplify variable declarations and debug ch=
ecks
    net/sunrpc/xprtrdma/svc_rdma_transport.c

Best Regards,
Sean

