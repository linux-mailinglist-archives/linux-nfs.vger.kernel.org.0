Return-Path: <linux-nfs+bounces-21446-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOlRDX7u/WlJkwAAu9opvQ
	(envelope-from <linux-nfs+bounces-21446-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 08 May 2026 16:09:02 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF164F7920
	for <lists+linux-nfs@lfdr.de>; Fri, 08 May 2026 16:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3927E300DE3D
	for <lists+linux-nfs@lfdr.de>; Fri,  8 May 2026 14:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C153806C2;
	Fri,  8 May 2026 14:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="LNVc8Hi2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAA9378D70
	for <linux-nfs@vger.kernel.org>; Fri,  8 May 2026 14:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778249338; cv=none; b=VV/xYicqVThBhLkCq+kkTh9SN2Vg62OOxtdHeFgW9+sd6lXbKB0EYlqtJdYDah3vpJeFQcXiwKe9EE7/qyRkHIjRhJHaibGLrUlub5CQ2Z2KaGqg9CmCsgpma1jfEB10sG2EkLLmdMT4jr3/jO7ix8G2WRByJfpzPO8mPuUN2T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778249338; c=relaxed/simple;
	bh=0dDILeb1jV4b/mcVF6T7QMAR3gacmf1Vgnw281L/ETQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tywMgJ60SBhxFCq8d2ZV3RxaOwRz6BpnLowRJZDNCaDDxYcS4FZIWUcjbt6d0SR7DQxahLK8ls3CW+dK1Ell5TXAf4zI9UPJ2IRQR4eGAs0b72cZY2sa19ODwOXK1xl8VU9ntl4Kw3zmh5dlvLkLWGS9SV90qcvInnNDQYLbnqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=fail smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=LNVc8Hi2; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammerspace.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-47cbd444fd0so1240695b6e.2
        for <linux-nfs@vger.kernel.org>; Fri, 08 May 2026 07:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1778249336; x=1778854136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dDILeb1jV4b/mcVF6T7QMAR3gacmf1Vgnw281L/ETQ=;
        b=LNVc8Hi2JydiQjWwf29ZQY1XdHkOm+qlyPlWU/PU56/c8WoOz6wxZ+xm6iUaQdoaWt
         N8Exa2j+SERWJXpoQdrlWOQ5MJuwIrxDprxHBYykJRQssu9VEmpWbySLRZnMzOB2fqME
         kehheasqfi5CZPDdidD5pRgGopA4yyUwC9pNc67IVqOBc4tKDIbviJ61s5aw9CtKs5Qq
         e08rQucxU6B/IBgrARfPomFcRXYMVFf3hUOCOLANa9gBoWqOLay6ID/qNMindr4fhMAX
         V9Pue+VtErJQ41xtwnrj9Bvso4MhdWwwrLgLwnEtaAlHkqH2lBH2Ich0+rEsTY4GoWjh
         DlRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778249336; x=1778854136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0dDILeb1jV4b/mcVF6T7QMAR3gacmf1Vgnw281L/ETQ=;
        b=PX4BCqe9Gc6D3XZxsDpBeoDEtwnP8imAXBp7mAHGR1glCbwhMXAuE/r0n0rhgEoG4H
         3d/+EOzN0lKH7BJ8UH/+k4cckgnKbBUkLqQaPdmtTH9bjlrigmsoi10sB3pA6CcCNCbq
         dNN7FGc3j3JypZJxuRnlsnxeJaUauSDkhw1btfNF2CRcfL3VqTpencWiD58R+UaEF67M
         z1sY7H6sSlc+EGBPMifaaQIX01RzZk0VokjH5FQ8LpM85RmSbKdqgisvhNEtH4yUftox
         E71nUlDKr2V3VFtYlquMOAr8e+Hg7IHlgCBD3zl1NdFJ4sgx/vHFPtlBJ0uZD3mNXWBR
         K+Jg==
X-Gm-Message-State: AOJu0YxWL+KL0HJQUl2sflZtSJj8s3iyFPud7YFcAsP4hgR3dasAoqOR
	rWzugTN/DJst4kVXxJtEyP6Fbltjs8I9LcWKPHHTcQhHB7YrXi0w+a8ArtZz8YhrL1hRUELfq4e
	48fFI
X-Gm-Gg: AeBDietFFTTBpx7QOyiiASfs5Gu3COdNrB+YJLjnMexkEVFhe/lxYstKOFzFIAmH6/0
	HOaB+hCwfcCIzoPac54hY1BrwPlGFPUvxtMML9ctAAzDwbUqUDFMASSvDlC9UDzRYVK/4ncEcdo
	1+K+dREaHdEBms3n5rNmHwbF/ihypJsiEhpGcDvO/ZZ1MBNm+YWmqFsWEWFaogQa+vkBOsEuj+E
	9bho5p75mjvuJm+OtRFsvIBO03YQWzuQcTdH8ugTvg6tVYKjN3z+XAkyIp+ewmgfUjoKqZEhefx
	INmqoMoefwn2q1VtzZfR8CSH6u8gvzo6AcMaeejufjYtzd4QzZ8is/JcDjwg6Q3kXrQ5jtbQ7b2
	EpuxmwxyZUAom6DEE36Wc02QBOrvZRq5OWOGsdHfTBsDW8AAtqT+hGNLbQt7li9J2XeU3E8YgFt
	w8reAXppbQqiMNihoCowyVlMrbGHn4R9gB1DFFJJTiYNc=
X-Received: by 2002:a05:6808:23d1:b0:47b:ccf2:91e1 with SMTP id 5614622812f47-48042264010mr7602460b6e.21.1778249335839;
        Fri, 08 May 2026 07:08:55 -0700 (PDT)
Received: from [192.168.254.51] ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48061e6eb84sm3416573b6e.0.2026.05.08.07.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 07:08:54 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: liezhi.yang@windriver.com, steved@redhat.com
Cc: linux-nfs@vger.kernel.org
Subject: Re: [nfs-utils PATCH] fh_key_file.c: Fix build error with musl
Date: Fri, 08 May 2026 10:08:52 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <CD3EAA3F-F758-4CAF-A692-065CA82917AC@hammerspace.com>
In-Reply-To: <20260508135732.524301-1-liezhi.yang@windriver.com>
References: <20260508135732.524301-1-liezhi.yang@windriver.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0CF164F7920
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21446-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hammerspace.com:mid,hammerspace.com:dkim]
X-Rspamd-Action: no action

On 8 May 2026, at 9:57, liezhi.yang@windriver.com wrote:

> From: Robert Yang <liezhi.yang@windriver.com>
>
> Fixed:
> error: implicit declaration of function 'strerror'

Giulio sent a patch for this already:
https://lore.kernel.org/linux-nfs/20260408173535.3992116-1-giulio.benetti=
@benettiengineering.com/

Steve D - did you pick that one up yet?

Ben

