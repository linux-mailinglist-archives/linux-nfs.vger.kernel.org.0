Return-Path: <linux-nfs+bounces-18955-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DqOGzI7lGntAgIAu9opvQ
	(envelope-from <linux-nfs+bounces-18955-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 10:56:02 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8001814A96C
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 10:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 22F103004611
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 09:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B5131A81F;
	Tue, 17 Feb 2026 09:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrIQ6pfK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B248A31A7F9
	for <linux-nfs@vger.kernel.org>; Tue, 17 Feb 2026 09:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771322157; cv=pass; b=QVBuswPs0t9Y3BaDAJfpKZdgRxJgVMsiOJQcZ47Q0N6B3+CMU6I5Lzghs7FMogGq0TVUhjjt+vrXCZOZOrV4xLwtIBm2W+CpAbbb8mTqYT/7/XLXO7wbug0FVHATuT3t36LfBdWCdbKEEY+lbJuw31g8l6wwTy9itqeOVELaCag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771322157; c=relaxed/simple;
	bh=uQcxrS5XtLzaUDzx5mBZIEaJIdBq7YHFdQeDi+x5Y28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=loT//iudDlRexqjQWTspYNuDy/jwFcUpfbpGiC1OZVG71PnEbEype47Nwq/DeQRLkXFbyRjHc3n9p3OIPjhQoHYdzQjrCMZkvVkain7DmoHRjwaTvtqA9jjhm1AltQ/GR5qF1Kg9UZ/K+B0A7vnGWu8OyGBskIXrtG2zKgQheU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MrIQ6pfK; arc=pass smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5fdecf79484so688094137.1
        for <linux-nfs@vger.kernel.org>; Tue, 17 Feb 2026 01:55:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771322155; cv=none;
        d=google.com; s=arc-20240605;
        b=J5WXxRUcZuvCmc7BYCOvNeTGrDHfrAWy8wR/cGb0DgdR11XDCDQF99YNfhs4wyLnMW
         5B9EYY7oq1l4fwgmbQZRYSv726M74ckZo3Mnp2Gnq17kVF9o02MaQInuPhQ2F73dzQxe
         tWhhL2c4AIDfzHZuZ5BHAJ5u3JcjJld0e2eb1hE9Kw2Nl0gTAIByKxwpIUtR9sFXTCgh
         40xCimB5xtvlrkfWjuvaQlQns5KCdtPc6Eyk8scGbnf/Ykh6tzQ4K8nSYQUYj+yotKFg
         5Q4gP9B4/jrutdOykUynOzyC/PFIr0r57Tps2oYB2Qr0aLJxEfe44FBgBAISPiXACNJ1
         MxtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uQcxrS5XtLzaUDzx5mBZIEaJIdBq7YHFdQeDi+x5Y28=;
        fh=nfJPPjR5OH2jXoechLQUnNXC/4RBvBNySR5gTRKw2Rg=;
        b=ddJzhqBdUIhDynCYFCX9a/SUctSLM57NV0gWvkyU1FAzVHTVCqfaOGKg3FdWfv0kKU
         7OewCumYWKyYypGScUQyEvkwJ2K5xNRacouyE5IEN/jSxl8Q+3VFXD6KgmlB4UMmOYWU
         n6RIGWqpj6YKwYGVfx0+LtC8rwYqAqK2UULOvlijlohN8TYHXjm9F7zzJDle/6BMtnD1
         M9ERWDLUsVsuS2Rw0NUU2EwZijFyQXuP4YVAWzt2eJ3pE/k4sEefiPV7+s84klXcoVXb
         k0pjwKYQhOBvFamfSUCPpvJSWbWiDeu0otYEKvROUL+esUyOuu4MOQatyczsZx5a6092
         juig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771322155; x=1771926955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQcxrS5XtLzaUDzx5mBZIEaJIdBq7YHFdQeDi+x5Y28=;
        b=MrIQ6pfKM/YNhSYduwhPxzWa5RmJtXm959CSceSEV//q8COdGQ2p6/AwwWpJ1rtcp/
         QTCOQZAZZ2e9KAjV3NsAvhqxkshKRhlARd2J7UCh7D550iPSWSZgARWJcOFK9RRGNRuv
         XnQCWlHNYklgwHqKy1GkcxMWYg8Eufp6OOGgU/bHM5KkHXYB3K14RHkLieLQz+HnfCBA
         OtBhAqmpR0usvWGETI4f7liyW2mC3ANFz6NbpoBkwL7Vn7uy4iooVn2G2/hhepHL/XjV
         ePp7/L0urHDohTUgrDZNBd0t7JCdEyejfI+7Uh8lUuV3NqJjWiAn8nJaqju+/ARX0e7n
         UmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771322155; x=1771926955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uQcxrS5XtLzaUDzx5mBZIEaJIdBq7YHFdQeDi+x5Y28=;
        b=l30qCbxjAIeebd3H0I+ALHznmwd11jBjPhDB5l4++g5gpGZdZrOlSk5MiRHRA+5mhi
         qg4J7pk4AxicY8zsTitppQck9yG9bnG17EwjjVKyUZXxTm0tRaZhcoBl8d38NiRfxG7W
         Xv1z/5gG13V3losK/cOD243PbxTHrfyjNbQvpn+ElNRvqBlpHQlzFaF+2CmTXIBXA51O
         YEaJ9g+QEb0Odn5DdSKjiD0wuQMQZumrbDg0kvTkdVE4Jwr2nrmMS61f4IG2i34KFKRj
         IFoxM9/IOQvQ6Z+NLy1c1qoE2zaTYeJYjhLmU3DV12QZF4suMp3RZdcS5UmYMtlM4a6p
         TpAg==
X-Forwarded-Encrypted: i=1; AJvYcCUwmYYmfe8UNmD9j7iklx4vlVb38YrDGda3rlavDFjIAxp/32oFxh881NYcHI20IgiWURCdOIUuDQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMAo6MEHoFovlB4DjFpy2iGyYmsz/alXXA7ZA6wkRK9SkFtGSh
	t+zf/lEQZyzWKBF3SBUsop/BqMxevkjG4R70PUkFharWNmrZkvANQof0lyBgEKvVJ8iRZ9kOPz7
	K3yMd26Qi5ULQEJSk/EG3ZbGe+XpqFUg=
X-Gm-Gg: AZuq6aJfTwD1YR3a22GRa8u4C6jqFEPwU1CwnypAsPa7MB5by8gSlB1ZabwYLGwzQCk
	I3QbmsdMtFVuFleo9LkE3ojxEe5uKvPoj1slIEjDWvECw6A9fL/upceh41RY1zyu/Jh4wbKlmtL
	4hjskFOY2FdY+onw6AALjWFMN3eHufDWw57iEiMR4nr1F+dfOF/tLifd9AYMa71IowFt8+gOGrL
	BUXm1GagaedCeW7UoJPBddjjfi9f1mDJR62SGgmGf+BClz0n+/79VFSsm3gVWUilrPb1rrGjklu
	oMiuDPbPFBShJG7c
X-Received: by 2002:a05:6102:3f08:b0:5f5:4121:9b0a with SMTP id
 ada2fe7eead31-5fe16f5d356mr4577718137.36.1771322155559; Tue, 17 Feb 2026
 01:55:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216174950.455244-1-seanwascoding@gmail.com>
 <20260216174950.455244-2-seanwascoding@gmail.com> <2e3bf4db-cea6-4f55-a82b-4e99bb3f44fe@lunn.ch>
In-Reply-To: <2e3bf4db-cea6-4f55-a82b-4e99bb3f44fe@lunn.ch>
From: Sean <seanwascoding@gmail.com>
Date: Tue, 17 Feb 2026 17:55:43 +0800
X-Gm-Features: AaiRm53vZLvkKhlBjILeLIYC1fodHSKYlOPAnjQL4nEJLrwpsrtIJFsCO7n8eJg
Message-ID: <CAAb=EJVmDS7vKHsw77SARnD9uff-9vBrg97jo3tbYJS-z1KAgw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] nfs: fix unused variable warnings
To: Andrew Lunn <andrew@lunn.ch>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev, 
	trond.myklebust@hammerspace.com, anna@kernel.org, netdev@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18955-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8001814A96C
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 4:06=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
>
> There is no #ifdef'ery here. How is ptr not used? Is status always
> true, so the goto it always taken? But then rpcdata should also be
> unused?
>

If CONFIG_SUNRPC_DEBUG is not enabled, dprintk expands to
do {} while (0) during preprocessing. This means unsigned *ptr has
no remaining references in the function, as its only 'read' was inside
the macro.

Regarding rpcdata, the compiler's unused-variable check doesn't care if a
specific branch (like the goto out) might skip the variable's usage at runt=
ime.
As long as there is at least one valid code path where the variable is
referenced
which there is for rpcdata in the call to
rpc_clnt_probe_trunked_xprts() -> the warning is avoided.
For ptr, the macro expansion leaves it with zero references in any path.

Best regards,
Sean

