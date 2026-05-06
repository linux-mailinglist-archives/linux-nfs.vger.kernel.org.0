Return-Path: <linux-nfs+bounces-21410-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNSjOdlC+2lPYgMAu9opvQ
	(envelope-from <linux-nfs+bounces-21410-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 06 May 2026 15:32:09 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 453944DAFF3
	for <lists+linux-nfs@lfdr.de>; Wed, 06 May 2026 15:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E5FF3029242
	for <lists+linux-nfs@lfdr.de>; Wed,  6 May 2026 13:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B1E46AF2B;
	Wed,  6 May 2026 13:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+KN+8Kz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE103F1641
	for <linux-nfs@vger.kernel.org>; Wed,  6 May 2026 13:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778074153; cv=pass; b=rRIRwP2pZm0OwT0hVirLD28XIB8uiNDtG30rvugGmAlsNpiLwT5tZlveTdCiHIsMbXA4ZMvnyC5Xb9d5+akAyqqS3MW+SGfU4lAS7BQhfskwC6mai5RdITNBkntdCjIzpE2fvsTIPw40suA6RW008zKGDzsrKn9mGEJ8ZEWC9lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778074153; c=relaxed/simple;
	bh=k439PpZNnHrCN1o8OWLSLp2IWIkMikHSST/7Xs7Bs6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=MnVHGbT3S//25W69C4ros7f1RigiO6FuX3oEMPWrlirELsEJIy+hTKHD7mdkwtGdQtVBecxUxRR5TZX+Kg6Cy/k4VkNlGGIjk2pPNVozSjU+a7nUCxBsnb66QB3XT3L6Pq//Lhu9xr7Z1utDEBudDenZHM+CaQQoI1doUoQ3fgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+KN+8Kz; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-67c566cb519so7527323a12.3
        for <linux-nfs@vger.kernel.org>; Wed, 06 May 2026 06:29:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778074151; cv=none;
        d=google.com; s=arc-20240605;
        b=dL/5qL6o7cSAChxfac/p1v2Wh0sG4hiVseX99SBpvM6ZNrJF7TcAN7sYoYaUZ2aOgI
         G+hJgac6OK9FKBntymiAPi6/IQPt2DyleJY7TPj1mKJVW9hCAZMVwJSoKl8+rBWTCA5A
         51wEkcoLVg6Ej1gMK7c2708iRk7p9nqqj4r9Wt4kdw2+i/wPP8/uI3uRYJQz+WyCzlDL
         1cQCBASUtfF7m7gIVnL1eW1rh2Ind36Y3VO1URz6lH7uxbG2sJ+ym4iC7rl7X2YTKkao
         AGPcpXeR7Tp2TEzZg06teWYhozJpeVV7Wyk6m0yoXIuVxIG9W5m/YiRab+NahkKxXoro
         HbMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k439PpZNnHrCN1o8OWLSLp2IWIkMikHSST/7Xs7Bs6U=;
        fh=TXZPDbdeFVA7bLf05szft5I2KqrLBUDcN6HF7K4keJI=;
        b=fKtg+UvEIA8s1DmbYq7zSmuS8VckxSkUEVOY65utDlFBDm5SQFVwveTsvavFXMKaLv
         gmSpJaCwo5sLFhm/VlVzEDc2XNVmP6X9HOvavcVBc82ffPCet/W9GUL2kGDsqrmLBO+M
         X39/KhjMxa8VScsC0JY9VZsXDF3ZfKX+ZCEMR+2IEtCRJtt2Pb1Hf+JlB0n5zWcA0MD3
         hemF2bp9ff4ps+sITYlqYwLTVk4lO27BjIxrfWjfZSWssa9B9fdZabeLTqYZo9sbj93Z
         ZQ8IwBfvj9/hSTs28IbWP23qQ4Rnm01OCB+vhy/5ZnxKvgYRcRYSpx0rBXiFLustqJyy
         Ujlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778074151; x=1778678951; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k439PpZNnHrCN1o8OWLSLp2IWIkMikHSST/7Xs7Bs6U=;
        b=A+KN+8KzxqtepgJM8bCMgiPXgNokGWt0i9ERLYVqt5JaJzTZkPB4XzdOsI8+yKOEkT
         ZZcVVj8ebcGHfeXsiSLQYdEVjI0CcsYyf0TaTIxmgXD6BYn20vxqonqBsEn26k/L8nKY
         Mnd+cT42haboL8Daf5gAyrqg2Fu/QauUEdiMA+RiCRGMU870WdWlfIeD33mkeEMWmgP2
         Ml0at+nrkBGc4UQZhrEBN7qIPWuOe5NIKv9Q9Wdba7u91aJO2PJmbY1fwAz0khoBSvfA
         WiktfHKDedkRu/ozu8q8/HaTbUI+LbAsu6SMGKuzuV7u0RPEdBPNkoXatU6fslu0UaI9
         ZU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778074151; x=1778678951;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k439PpZNnHrCN1o8OWLSLp2IWIkMikHSST/7Xs7Bs6U=;
        b=i+FGx01nxhrgwC4px7g1EkKuLngoLSxZ6NaYE8fL6BqLtkdaAKvSzfAUpSdESgHbyi
         k8wcBaYT+7g/UKMQBPLDAvCd6utxhoySp5d+pxXwBwIyK0WS9CmMQK419sbm0fLzGXkk
         PSPerQtkyODSMiTI5BDvPgylKXuoMU4IeIcqI7tcf+P0ng2FSypuGJh55vy2GTz+iSjw
         CuQvOreQ98O6K/Zuz5nN8M4JbXP1hrRoP41IL+uhXd8IuC8icD7x84FOUhTSXz7biIWp
         iSBmrgmmjxkqtfIA2f+YUlTCfHCt3IKUpVikz+0IMqoXq4qscfCf40AznlAs0DxhAd1e
         +e6g==
X-Forwarded-Encrypted: i=1; AFNElJ/AXveJXYx/tu9qZFVewNhvC7vYI6cCTU+rDoy3cPqCR0IXFijyipYR9MnZUaKMWYVUnH6VvQOzTnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyryqXJYtZ2U0IM76dIX060m3DbMiK0eTrB9as4rANKCJl5Y8Ya
	2lhERETa/FXwHQ54fdkwHNN1EKm+l+YrTK3+zFmumcQfcAV+Ji832X3uh+WAyQw5NAAyqs3NLHC
	e+iQvioZCHeV3iChSOgAj26/53vj/enc=
X-Gm-Gg: AeBDiettcXMAemeaIi0fT78VXtZZU/lFXYhzYlFFi1MeJvsciPDbAFKddxlrEmNb8Bk
	OIuB48DZ+hMBTUEexgYJp8MoP12JuD+zVYPavbWnxa4d3OfUV0y5wNXhM+0UtGum+RJPRNqg6hx
	U6hNOpHg9BCzD2TUlWu5eNnHqnkWypSJUXaJlbYAmAN5LksySBU63tqLW7e2uV3rozNvGP7pFmx
	Zg4shp48e4ZV6t/Y6sT6AOfgu6kF4Qo2sPkSpDYFUp7BzDMhYwDxkUM3RIOLviqK6EdRE3bdwP9
	lwny+i/t1Jhz2hDKG6QGGB2CBZJS
X-Received: by 2002:a17:907:c1b:b0:bad:92f5:daea with SMTP id
 a640c23a62f3a-bc56b830dcemr192439066b.14.1778074150320; Wed, 06 May 2026
 06:29:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <45ca6e57.1a1cc.19dfc4104df.Coremail.guolingxing@supcon.com>
In-Reply-To: <45ca6e57.1a1cc.19dfc4104df.Coremail.guolingxing@supcon.com>
From: Lionel Cons <lionelcons1972@gmail.com>
Date: Wed, 6 May 2026 15:28:33 +0200
X-Gm-Features: AVHnY4J4FzFd2HT7R2TpsDmk8vx3dWhAgLSdbCbxQj2wMQ_t-3wavhOW6R2sj_o
Message-ID: <CAPJSo4Xu8ZRmL8dbhW7PQVV0tpADKLOpfzUL-TgTCR1bgg2fEQ@mail.gmail.com>
Subject: Re: [BUG] NFSv4.1 client hang in nfs4_drain_slot_tbl under concurrent
 workload against Windows NFS server
To: =?UTF-8?B?6YOt546y5YW0?= <guolingxing@supcon.com>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 453944DAFF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21410-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lionelcons1972@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,supcon.com:email,mail.gmail.com:mid]

On Wed, 6 May 2026 at 09:49, =E9=83=AD=E7=8E=B2=E5=85=B4 <guolingxing@supco=
n.com> wrote:
>
> Hi,
>
>
> We encountered a reproducible NFSv4.1 client hang issue under concurrent =
workload.
>
>
> Environment:
> - Two independent Linux clients (VMs)
> - Both mount the same Windows NFS server (NFSv4.1)
> - Kernel version: 6.1.78
> - Mount options: vers=3D4.1,soft,proto=3Dtcp,timeo=3D60,retrans=3D10

Which version of WindowsServer do you use, e.g what does the "ver"
command in cmd.exe output? How did you set up the user accounts, and
which authentication (AUTH_SYS, GSS, ...) do you use?
Which CPU architecture do you use? How much memory do you have on the
Linux NFS client?

Lionel

