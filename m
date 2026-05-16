Return-Path: <linux-nfs+bounces-21655-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPvhIQl+CGqBsAMAu9opvQ
	(envelope-from <linux-nfs+bounces-21655-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 16 May 2026 16:24:09 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D897355C0D2
	for <lists+linux-nfs@lfdr.de>; Sat, 16 May 2026 16:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2082D3007E20
	for <lists+linux-nfs@lfdr.de>; Sat, 16 May 2026 14:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88C7284896;
	Sat, 16 May 2026 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXMzcZ/d"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795F0213E9C
	for <linux-nfs@vger.kernel.org>; Sat, 16 May 2026 14:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778941446; cv=pass; b=pfiI3qTfCc7R6Ya9B/dj/6Spf3nMmv2kWTqDcwGwtF8NXItncaMSs5LD5j4r9lpW/lxv3mroTg8Njqkk+QfDuoK0R0mEG/RvqIgDTZxmCVCzOOpATWbVxKiaDzIQz7rJUQcdWjyB1XilYyb1KjFucubXgeJpDaANW4PNfun+q3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778941446; c=relaxed/simple;
	bh=Cy2H8iVbufjpz4FmEqb/TVZVTARxMSZsLjqw4O6jQPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CcrluCsJ/k0X9bL9fiLbSc8+K8jIFI+mFKH2JBDppSS7+3jlQBiQrN1e/q1Ja28SUdRgnHqN7AXd36orGAsx4ktb0j5LDNXlgFTn3UGu3J6v/oOI72/yP6XyGkwUN+9CUTM4YdB+c3oJxLFggHBvZnWOb9Dj/Mw1SJ1kJ7VNj+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXMzcZ/d; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-67cd93d8affso1116007a12.2
        for <linux-nfs@vger.kernel.org>; Sat, 16 May 2026 07:24:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778941444; cv=none;
        d=google.com; s=arc-20240605;
        b=OM9QFz2kfIABLF9byHRBxEEQxY6Ce8bt0Oc82NGe7gfA6GYiYkwpV7DxyH3F0xlNuU
         908RUl8+dr6Y6Hw1GzJRi0xo5iDLPwcnKbG+jsbchCEw060FymjJySDiDz/Vv1bHkI4M
         AykEPM5PHf0x+i3mexRfaeCWFJlSrnJBHo4mseKaJ7w4tdmObi6oiQ7ZuD3yytKFuLXG
         U2cU5/7G8D4a8qmwKNMcuTy2XrktuLCQhCKT2F3zhODTm8FUKb0+lO+DkHsnDAdF8S0j
         7XMDabRwTHy0C1KBYUyovuFYKzkQXo9SXAq9s6QI6VyavM9p6IpWGB2UAZAVbLNTfQOx
         P4Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cy2H8iVbufjpz4FmEqb/TVZVTARxMSZsLjqw4O6jQPA=;
        fh=WElbpfUku35abJPI0JmxBaE8g49Rfq2l2wqomxnHDuE=;
        b=XURWhQWH3wyG9FGJpH0x1nLHxw3Msn02pVV5M8S7I91++DUgk5FvkBWVcdNYVzvXjM
         NuX893L6ZjtJo4V0HWfZ3ERtkxfNU1bmeRuFOl3AHUWESwjIisq2mPX5O/hmz6jl6iuC
         pCYKA8xy4pE2nTwTHM1HlSJ2MLQxqOcxmkS4gVZN2svkgf7oehFX7s4ZI0eeVuLJpr43
         VO5MaA1OiFvhWuZwkCCQKjmgpMN1AjtBmNNSpe/fSlYcebj98wKCMxj47P9DTa85WKLL
         b8FH3iWri7ifyX80W/xDVK+5jltHQjAdm7oOGKHzVTyrAapKfY+PH7B1yjJW3iDsn8ki
         dCFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778941444; x=1779546244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cy2H8iVbufjpz4FmEqb/TVZVTARxMSZsLjqw4O6jQPA=;
        b=EXMzcZ/dPqcvdQBMtO2uFonyhIctIg/fNiiORpbYLxUAbcktqhROR8tSr8635XbPzL
         aeRoC9mG41Y1aEuxRiwxm+AnB55RmDD8ReQ3evWLdC88GMiMPFxxgJWHvBJBspN6TT7s
         2yI+I/UklYAgVT4isgbg7bUggovxji0TO86IsAAGzxlGBk80GOWoJhp9QZaYYQCf7v7L
         8UCPyn4afzb97K49JpofX+Pc8xPi+05GM6yPq1v1GrR2tn2zbsgq9HpH2oEqoEDImteT
         64bHnM8kRVNw8P5fnTvDzIiM2ArA/GSZCC1RdgQqMUYtlOKpF1ifenW9mx0C1uQ+Q5Oe
         qxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778941444; x=1779546244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cy2H8iVbufjpz4FmEqb/TVZVTARxMSZsLjqw4O6jQPA=;
        b=U9VbE6ngUrgu1n+yTqNW46quTHb0HsQtvijSmvYufgy9PhVQmELLGbeYHv1wP0/qxq
         GYZG0oKEl+sb8AsJ3fajCgdPCTaKKIf7dTDlLBXle+V2QNk9crHsH3D33GWCpNNKOj6B
         vsyfiUEyrnqvqo6+7lw7VHqSG3o7nRP+/DRtfvQQgx94+SCnzqom9Y11m/BhKr8By7B7
         Lov8b+EuNNIGL53fpCz7tyRiypKcXAUr3hSNtHuuDpqaY2SqAGZMvDAy9EBV8Yuh9M7M
         ejMcOEMRPI5TeyVRoPUNbnf5Dv+xzg0iPqPTA1jkgIbkEG89w68C6fftMHhr/EsPS+Es
         VlXQ==
X-Forwarded-Encrypted: i=1; AFNElJ/YR5zhTUo+nUHisl8LJPmoSbc/z8koz94mXZaYRa5hqzTk3Z7EfUmLBmQA7XkGynlx80yYRn6Vrq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRQxTyROS+PzGrkaSmYtts9SEgH82XLP8npDjM49avMNJLc17x
	Sx4lgdgJkgb0PIt5Gkj1ShLZI81aKvXNHvb6ZOsQdPAq863YNOp8nHkCMD3j+VP8gbKKJpUTIKE
	RIf89z4whHEke0LT+xNylwq3yb1hbzd00
X-Gm-Gg: Acq92OG0oq+47b/LMeXU+wcwLykBIjoqESrJp4rB5KuOMil1vssOnVYMHvLDvhRou7f
	IsfWeUcsBvLeAm1eITSQshIL8HLJAznRCxs3VXSK19NCE9uveo1NwDOAbeazCzdrwpVqDno6DFN
	NsL0/vlqL6kr5GuwDrhZ4SvGGp8fWtAuLKfmsv1jzGEjqRqI/CynIsuK7igAZI4S7Ot9MjxQtkS
	3mx1RFV1IqkBeIZgAqSqcdnsCF3XkmsonHjO/BL4hrogtpNybdASDRtMxkWmsM/jSV9egMS1qAd
	UIgImLYbrFpu/ZUp4CR0FSladjZoacznMtPVE/is8WCYjlFNZg==
X-Received: by 2002:a05:6402:40c3:b0:66a:19bd:5cb8 with SMTP id
 4fb4d7f45d1cf-683bd18c6cfmr4265532a12.18.1778941443720; Sat, 16 May 2026
 07:24:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <45ca6e57.1a1cc.19dfc4104df.Coremail.guolingxing@supcon.com> <CAPJSo4Xu8ZRmL8dbhW7PQVV0tpADKLOpfzUL-TgTCR1bgg2fEQ@mail.gmail.com>
In-Reply-To: <CAPJSo4Xu8ZRmL8dbhW7PQVV0tpADKLOpfzUL-TgTCR1bgg2fEQ@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Sat, 16 May 2026 07:23:51 -0700
X-Gm-Features: AVHnY4J72w_50THdt7UxT5-QIdG6hW1IyMKLV5Ol8vjmtzBgCMxUWNIxu3wMiwY
Message-ID: <CAM5tNy4A-a4q-t_z7v_sHFW0VeyPLu_yEJ4RQ4DxXVAF-5kROg@mail.gmail.com>
Subject: Re: [BUG] NFSv4.1 client hang in nfs4_drain_slot_tbl under concurrent
 workload against Windows NFS server
To: Lionel Cons <lionelcons1972@gmail.com>
Cc: =?UTF-8?B?6YOt546y5YW0?= <guolingxing@supcon.com>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D897355C0D2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21655-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rickmacklem@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,supcon.com:email]
X-Rspamd-Action: no action

On Wed, May 6, 2026 at 6:32=E2=80=AFAM Lionel Cons <lionelcons1972@gmail.co=
m> wrote:
>
> On Wed, 6 May 2026 at 09:49, =E9=83=AD=E7=8E=B2=E5=85=B4 <guolingxing@sup=
con.com> wrote:
> >
> > Hi,
> >
> >
> > We encountered a reproducible NFSv4.1 client hang issue under concurren=
t workload.
> >
> >
> > Environment:
> > - Two independent Linux clients (VMs)
> > - Both mount the same Windows NFS server (NFSv4.1)
> > - Kernel version: 6.1.78
> > - Mount options: vers=3D4.1,soft,proto=3Dtcp,timeo=3D60,retrans=3D10
Just fyi, "soft" mounts are often going to be troublesome for NFSv4.1.
(Whenever an RPC times out and doesn't wait for a reply from the server,
it will leave a session slot messed up.)

rick

>
> Which version of WindowsServer do you use, e.g what does the "ver"
> command in cmd.exe output? How did you set up the user accounts, and
> which authentication (AUTH_SYS, GSS, ...) do you use?
> Which CPU architecture do you use? How much memory do you have on the
> Linux NFS client?
>
> Lionel
>

