Return-Path: <linux-nfs+bounces-22429-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +4O2KfPxKGojOAMAu9opvQ
	(envelope-from <linux-nfs+bounces-22429-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jun 2026 07:11:15 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48998665DF7
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jun 2026 07:11:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=I4jtxxH3;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22429-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22429-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B4DE13011A63
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jun 2026 05:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399C2370D5C;
	Wed, 10 Jun 2026 05:11:12 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B483832B112
	for <linux-nfs@vger.kernel.org>; Wed, 10 Jun 2026 05:11:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781068272; cv=pass; b=kqZz0NCNwAxDBjJKfUVcAb5QsXqKGDjpy+aMvvSwtFWjJu3XeHUI1HNN6+tR7Snh/vt8/R9hJlVsbx3QGzSTAPE4okW2RFm6fwxbxHYLe131pXCVYZeOu+K5QTjSEsaTy5Z9Q28nplnI8FUjfbWoB7gr9LY/vqrGXVtYYVDD8IE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781068272; c=relaxed/simple;
	bh=RaoZu7AT59pWjSHSFhsYcGqd1OdcFRhOOHmZ9Wko9tQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AlVksTnLL+87eA+J8jDAT7Uxrgdrz/8G/FlcvBjwB6YSowGfHs08CS3cPx8YqZj66n2r04WVaa87k8OnymqpwvuBHJaZZZDUK1uxBVD0tvYjooKBDVMono5aYlCCzO4TrZzsMDD+MgXwYbJr9RZgP9Mo9OU9Ex/N1OcYkgGSoNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=I4jtxxH3; arc=pass smtp.client-ip=209.85.167.54
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aa69131836so5615413e87.3
        for <linux-nfs@vger.kernel.org>; Tue, 09 Jun 2026 22:11:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781068269; cv=none;
        d=google.com; s=arc-20240605;
        b=Sg3mdDii8XGXIzxP/y2uX14giPgPS4tfbuYK0/O/jI/Rjt6zQrJ9w82qz7e8q5iaZj
         wsL/B+tCn2wbfXVUWKazlSH7Fjmj7NbqELnxHyplEChiYdfhYa+PBw08uHV+jJsEa5N9
         AoiaLDEucYwqJPhf77m6JcwnprD1IMjgbZo2oppK9+pMae7biP3ajIsxbCGzCikD5n7+
         1eNFrEgbVLtZrKWGPd/X4Z0bwoJpWSkzFouvikUIOlsbK0m/tM3JkKd/Xt0+/Kp+d4lI
         NglMdZ21nvixx2ONaWcYqTtmAd8mmjSBWn7drOYLH3ZB9KikZeI/6ttUQVOhI/9NY9e7
         gckQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MjPZkuasfySIcKEliRg5Qwh1GS8tecOIWXm1vwJNGmE=;
        fh=eJePU3d4sDSUF8/oT6cyJQFnmhP6wh6dfbejUryr69c=;
        b=Po8oPN06vBPNEmJZiyTXlWMVWmZYt396si1F+JT3Bv20cvt/+vleHWbWoZan0nV8jo
         Rvi/i5ucpZ8I+PRVFteKYSoNRCL3MYEAVKoxE9v3N7pjjOl6o60L55uz2jVkpo+HbtLt
         gnWytoWbkMDkCqddjInqW3yzxkRugr8YUVh46Xp2xOI3UIC5vzigjZbYEo65TlWQJvwN
         kLkiTETzeYppmuJ9YfBq3YAUfCPivUDpYnc1LKBmB+Zf8F96rb1x+Rq102A+oXr885w7
         jCUAxpz/ZZxNhGmns5mFOWZrsTJsPkS3K1YhgdNDmGG16NgdOI4ItmORv/pXSvW9Kpb4
         jUkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781068269; x=1781673069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjPZkuasfySIcKEliRg5Qwh1GS8tecOIWXm1vwJNGmE=;
        b=I4jtxxH3dDAAvm3+VG+8ZyEjv1XPnsatmtSuTYI4bPFHiuLthRquM+KABcu3e8ICeF
         0aK13F+Boh2de5md/g0x4NtbDbO3MdOPTxi9ZjOcpjARZkpxWl8awQ9K/MX12xopVtwj
         79sRhXC+xcVwH5oGPDqE342GCdyvMInJPF45SURuLBmkhc7GdsFNN12oF7GEbVwxAXHQ
         o0QpvzRKjCOB4TQLm2iXg96B/q2JYn3+cHNv4W7MG9LaTsv54u8mi+m/UWTkRsNtpb/W
         A6Z3iolHJ3jqE4erXFSQWtr1bsTO9I+IlsjRs4jYjvINNhL81CLAS6K0E3ECDt3bFiaU
         b6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781068269; x=1781673069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MjPZkuasfySIcKEliRg5Qwh1GS8tecOIWXm1vwJNGmE=;
        b=OzIrHXIx5ANgnkf5ImJFjdkBkpl3WtgI/x7JbefDR4aQSSuUA7gcYu1kWnZBaGl33/
         QEppY+1r+UnCx5Oe93YZpy7bAeiNMU6qjILbebYgiAVhk6ERxJ8hYDplmzxy1yb2Eai9
         iXV6oMkT0qxG9S26OzHGdqW3UrACbamItrFooyWw+elMvrQF/OOaTPiSkygwmQc3qiIq
         riSZ1cW4zuVkj1gJtdDbhS/gUAKk1lYdBHOJJuGLQTQBmdvQirWpVFIx0S9NvMh3Eec/
         PYEYoSU1d5H3hK/4GLd6BFKOAITUeLuu8V4g3GEXA1Y4hBZtYCFAyEWod1a96sbJ1Mow
         kHng==
X-Forwarded-Encrypted: i=1; AFNElJ/VEfY2LxddXUbt1niF9/TgPnRVvJr/ievD5Fw3d9FJGDK6+x385X324xxY9e0/Y5RVIXA4Wy3dFZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbzoR+R97AeQGToaV6HY1+z/W9GC94hYAHFQnK/bO6fwrS4UTT
	tfT6xwdhDAxIpMITR6FZkU2FQFCpRWPkrGh0dC/hDITijC+iQ3o4ns6jTFADXAHZx1Nfs2pAH6+
	KdJQTgmfc/ODHB2FhaFHWsOu50YIi8QSzGChSDAfhkg==
X-Gm-Gg: Acq92OGrWUbaHX7hcuQxzm2LK80fQ5tp97KPGodoDCPRcSkN/CSBfQClNQjDvFE4ZRk
	02B6xWjBM/4/4ICI3I+DQ0bcJtDnuHFFGHWAYAz32q3LSzLb8RDKlj9DSheRwqbbXXWcEMLJRnc
	3v0iO4McXQIKI/VYIMhI8alYhyVI4xPyi83GcWsZ03m9OgEKrTF3U8+9XhdHioJkirueJm8KhtV
	q1vFTUlrHBHAuBrmSEhs09VVVD5OU4GcWLsESqLMpqsCMyiB4N2KWaNDHzKzjsTv4vEth4h6LWc
	9uIvLWW6/+KWEsCsLKqe+UxnFEBacLoOeVeQTbamzm2h62yNluNlrVHaZwmong==
X-Received: by 2002:a05:6512:61d9:10b0:5aa:75f2:c996 with SMTP id
 2adb3069b0e04-5aa87bb9a8emr4450473e87.16.1781068269041; Tue, 09 Jun 2026
 22:11:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507130117.252825-1-marco.crivellari@suse.com>
 <CAAofZF5_MRtySWTMs-J3T676FwjJiLDpYLRWmsFaSXePo3nZPg@mail.gmail.com> <d9242324-720c-448f-9723-e11f0158f4b1@app.fastmail.com>
In-Reply-To: <d9242324-720c-448f-9723-e11f0158f4b1@app.fastmail.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 10 Jun 2026 07:10:58 +0200
X-Gm-Features: AVVi8Cd4rl3lKg-JT9WcRLU1iz-_cOhVgv4WWgAm98_6Ch-TnEwssJeJ6D60Ox4
Message-ID: <CAAofZF6UbVgtzDkpaQusrHBg6u1q0E-49upzNL=Te-+PzDNNrQ@mail.gmail.com>
Subject: Re: [PATCH v2] xprtrdma: Move long delayed work on system_dfl_long_wq
To: Anna Schumaker <anna@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	netdev@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, 
	Trond Myklebust <trondmy@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22429-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:anna@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:netdev@vger.kernel.org,m:tj@kernel.org,m:jiangshanlai@gmail.com,m:frederic@kernel.org,m:bigeasy@linutronix.de,m:mhocko@suse.com,m:trondmy@kernel.org,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[marco.crivellari@suse.com,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,linutronix.de,suse.com,oracle.com,brown.name,redhat.com,talpey.com,davemloft.net,google.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 48998665DF7

On Tue, Jun 9, 2026 at 8:55=E2=80=AFPM Anna Schumaker <anna@kernel.org> wro=
te:
>
> Hi Marco,
>
> On Fri, Jun 5, 2026, at 4:12 AM, Marco Crivellari wrote:
> > Hi,
> >
> > On Thu, May 7, 2026 at 3:01=E2=80=AFPM Marco Crivellari
> > <marco.crivellari@suse.com> wrote:
> >> [...]
> >>  net/sunrpc/xprtrdma/transport.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > Gentle ping.
>
> Thanks for the ping! I've had the patch in my
> testing branch for a bit, and just pushed it
> out to my linux-next for the next merge.

Many thanks Anna!

--=20

Marco Crivellari

SUSE Labs

