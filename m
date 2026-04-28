Return-Path: <linux-nfs+bounces-21245-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIUwBTl48GlgTwEAu9opvQ
	(envelope-from <linux-nfs+bounces-21245-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 11:04:57 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA91480DBE
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 11:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB2EC306A1EF
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 08:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792363D4117;
	Tue, 28 Apr 2026 08:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pPNHvP9u"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082EE37F73C
	for <linux-nfs@vger.kernel.org>; Tue, 28 Apr 2026 08:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777365884; cv=pass; b=nSxELvp3vDj8s60j/8LDZz/SRC7LPD5qIbe6Kv6EdOKUuGn5uzUOKkdqiCY0E5Ps74NR2h5lm/brGtfu/kF3joTp1qfX0fbQMFhRQjezCWGvp7MjepXjXJi5nM+dh04XZQ1sNWd92GZI75nRK0B/S8tn5H8XokyNdbZ5nLLwiJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777365884; c=relaxed/simple;
	bh=ohBYr75idMg+l0XbYiAhtRXaJ6yKXM7FM/ziYJovye8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=bTn1OdMBbmT8KR41rTxm6i8Uz05nVO6/bl4V6l2Wr99XxrAgTg+jjSH03B43c30M4Cq0r7dnbblyIOVbLnHs3gUE7sAUvMF0f/i7ohU7o4cTaj1d8T/wHqqbwUh/3/hWY94uwqAWOaRP3bnBMowDCWtZZh6AfUi2RC5voAcvFp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pPNHvP9u; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ba6b39871a3so1402010466b.0
        for <linux-nfs@vger.kernel.org>; Tue, 28 Apr 2026 01:44:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777365881; cv=none;
        d=google.com; s=arc-20240605;
        b=NPkTWNIWQv1HKzBZ6p0Bagcc7onUs193n+6L1mmMqMl3tMwvQNdq6IfN2+/2MVnUyX
         6jWiD+HeozN4RbEnSqYJLNDsMcQOjsa71KXW9SqIX9Xe4xsIJ9V6YqYsXoBCIrFswm5u
         rimwrmIUyao8uvvMaULcrG6P7ariGiUnAFuxYGvCokPE36HxLPDlmY71N8V4sdkbRxrZ
         E1B820oYZ92TvsaQBuK8ihyAzOChmJ6V/RlkoTnxmfa1ZDL+qTUbxUUviJaY97AnNVUS
         7DrqLa2IO6enUIPrFTTLgOw+WUQtC6RyTKRQroRXY7RUN3m5KVGy+meGmmBGTgW3twby
         NJlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=ohBYr75idMg+l0XbYiAhtRXaJ6yKXM7FM/ziYJovye8=;
        fh=A3pMOUK00huGibGCZBFsLekFLVbB5hHGKjUNNKwO+5E=;
        b=SQZctxAmmIt/T+jILoRdYP6w1XBQHaxRoxOev/mN+SZP2tEbOLa9XKJg6L8eE+rbiV
         y6sLbAjZyYbXiXwQhLgwR0YKq/7LWAqYA3NyzK8wU12XKro7LmJolCpE1L3vbrzIq+zo
         ChhrMRbP4GIgi9jT6r3cGioSboEb4UR+0fZzTpMxgwGPLNu7U/SIlrhwyyirae+vQCPu
         JyiyzUIwzrhr6yWS9xNRh7FrPJieAAk3DAj2XuZ0Ey1WSFQcjXIZnbLdKcEtZesa56VN
         bltTmVn02bVCbVmjhBOllXEUOW2ZcDBDEfdhEfWYFsWhA5WH2s0p42Dzl+kctTtDAsmW
         kX4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777365881; x=1777970681; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ohBYr75idMg+l0XbYiAhtRXaJ6yKXM7FM/ziYJovye8=;
        b=pPNHvP9u9lIrVy8sibLBoNDsGJDOmPJn/KcKvsx53Ypv+QIq4r5eK1YwKeHbrQH5TZ
         hePRgAskFDAe+jnYW+MQEYxTLZOiWVvYx4ay8QKzi7xQ8cPp3IJtoFC50NNgEdLzn+YO
         JWWw1BfSqSKD5ix/ja3D8XTRE7wNIBNtv961c4h86e+SWvzbKuhI1aWFhTTCg1ye7/5d
         6OujXMPMQFgGQ8Au8XF4FNt7zJ0HF2pLAJvLWJURgSeF+Sela5NuKlO47NcqWVbgZpsZ
         +7ULUjyus+vuYvnGDUPS8apCyj9VagqKTP1cGbl/w4IpnXZ0VdKVhhZNyAwAKf7e4AAm
         h1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777365881; x=1777970681;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohBYr75idMg+l0XbYiAhtRXaJ6yKXM7FM/ziYJovye8=;
        b=EJ6Qp0poV4eKmZlMjzMuy+v/OlNr0pR5aq34IrEHtIkaLCo5Q3sjH1kFslOuxeV/Ar
         qJglhXrBGXYMENhmEZakDoxsA5mOMutoiBj6L1WC3csXhbFml1bTPvF06/JDn6XQEZZt
         0WJ/mm9t4B3uO38rxs+qnuSXnHw8KOVaBVP6NzFgGOR7kExrVBX4HIqWcFgl2JF89zyM
         M0qnQI9XIvMkTw5RWrJE0xQoxqaLAyJQOF6oBgDygyzSEyQjR3sp2NlVcaS5lVwVRbSD
         almztF0CySIrGsafNsfer+TQvHlhrSQJiQyDV+MsjqNruUQdfpfuVhuoDJ0++37SidSK
         BAuA==
X-Gm-Message-State: AOJu0YwH9q0bgLxBk31wQnvkV9PWAVvR18A8d09SFeLWozOvmkNX4X7s
	57voxmRf+TjoPxZNLq5BkSIdG8/0dGxWcWweaayGrr8FrlQ3Pm79i74nFdSnxi+2fyXcWZviZ1u
	UiVtyiqDWmQjZPF8OYw0yncbntlY2VqwO7/He
X-Gm-Gg: AeBDiesBMAdK4NhcN+bZsq0uZQ0jZfx0t0+NnzUsbfl+MA6S+s6dsBnrfZy9ne8opRC
	AKijXTeykbPbFdx/uMgNhS2GdMJYqBtp7ZtwBjijj2B08D3EjcnV1zSS1EeZ8q84HbRAZiN6oJV
	TCmVkkpDwTgIN4NZG6q9xuYbWrkqxGKtB+7h5gM/qj1Nq47L8xQUxZvfZJdFsjq1x9h8Pv4ivZx
	k39jCkfmGK9NnsWd6FHkiV9zbjsi1ARSQhNqA3YIDvtkwMaE0Xamfk2l9yxkI7MJYDpqeW01GFn
	ix94zFDdL2lyRznJTNuIEVwUjo3gWQLAEpjzuR7u24oTmS6J+A==
X-Received: by 2002:a17:907:74a:b0:ba2:6dd1:a12a with SMTP id
 a640c23a62f3a-bb80668d779mr106440966b.9.1777365880973; Tue, 28 Apr 2026
 01:44:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
Date: Tue, 28 Apr 2026 10:44:04 +0200
X-Gm-Features: AVHnY4Jfd5Gh_BC1tF6AXuWD0yuzdgc0MchT9RNf9aCLDaRuuy4xDQtzeY7xY_8
Message-ID: <CA+1jF5rm7u+CfBVOg-tS94Mx_kzM_sYoBUgbDBS-EMQOxkWuPw@mail.gmail.com>
Subject: Linux idmapper kernel and userland source code?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8CA91480DBE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-21245-lists,linux-nfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aureliencouderc2002@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

Where can I find the Linux NFS idmapper kernel and userland sources?

Aur=C3=A9lien
--=20
Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
Big Data/Data mining expert, chess enthusiast

