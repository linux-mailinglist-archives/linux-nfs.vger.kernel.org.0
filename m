Return-Path: <linux-nfs+bounces-19084-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oP7rKcZDmmm6aAMAu9opvQ
	(envelope-from <linux-nfs+bounces-19084-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Feb 2026 00:46:14 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 532AD16E459
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Feb 2026 00:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E39033026172
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Feb 2026 23:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97ACC310779;
	Sat, 21 Feb 2026 23:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxWuCmMl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C002246BC5
	for <linux-nfs@vger.kernel.org>; Sat, 21 Feb 2026 23:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771717567; cv=none; b=aavugq2bTOMVTXUu3couG1T0J/2hYun4lkJOC7nAtp4zr88TKQhgnVR9cMzjsknSoYCZFK5IgwDI0KT5MXS4qnU5GLwG4ybeiqYAir8AO7qyUW2jHJxQ7cOlSNNIU5cCd5mdFengQfOqDhJ7aMZId+47mfEwoSAzIYCqoxOEZQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771717567; c=relaxed/simple;
	bh=D8wEA4P1R/wLC0WQ2gaxmvJV8Zid0j4uMfM8HtVxkhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Txbe4BPIYiY4rEd06Io32cWgN/EVyCaGGpD2ehqwM4f2y2YBg7Etaw19yfLUeBIEkABybdgRNGURiHEwupLsNkUZ7liTPQih9sXzlRfs2/gGjFBFVLQ9xhCtxsFwhOkn2KMP4/bxuz05/9O+yH7moQkERCW7OsyK6kSDz96SDg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxWuCmMl; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4807068eacbso25584655e9.2
        for <linux-nfs@vger.kernel.org>; Sat, 21 Feb 2026 15:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771717564; x=1772322364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6c+2c5A4IdcQR95bgfQZwtsMpRnSCzmv5kOunEAmnw=;
        b=hxWuCmMlxuj3d20al60XWs0jh2KLvmk0/jpM7jG8sjLtUj+ARfwmScdZLER6DpfOAs
         J8nWVO9IM04A+Qm71FNtsxpTM5ftoWYuG5CoE6iS+dCZ9RSZYYoP+pmhOyAgz70sC2iv
         LDvuveFZpQZy2/IC/wLc5I7ZkcufMPCm48xDHV18rMz3EllbndGCICEYY+zKzP925M1P
         L1j7TU5F2mxburUB6vGNMZfdQFHuZXWbh2ZEHD6D3l3MvO7SPXGiDAny7QDzYV1siVBQ
         FXjjbYA1cLCF3c7I92iQNDo0U9X7Emu0pfWIOGTBeLkAV5YK+VPmQv02ynK/DYnajvGz
         T9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771717564; x=1772322364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a6c+2c5A4IdcQR95bgfQZwtsMpRnSCzmv5kOunEAmnw=;
        b=t3HFThcreXK+NKl597eXLSTrPvu0Vt/azV7ODK5/Ha0JL7bZuTSFv8C2D5Rssk1Qw3
         x0wd6RTbReE2PCBSeLJGFm5C8LpkVjadEikZrqIWGiVil1XgeIUsFDOZtBEiUIDJ1dFH
         CYcucYmHnMk8XM8QGZDKexEiw8iTqoHQSCgzHQX4R+B4Ge7oA3HkIgJEBKOZ2CZGTzhM
         KXhhjiDZKtth3DnT1orTFs470aKqTck50XFOWEA4F39tBYwkJrbPcVHMRElZ7TGpavR1
         YjBP5R59j/BPdq/DOXdsSI6+uUtdIseSjZ6dQPSJ4seq+LAdjyuCi/w4h/zbwW7XEHcl
         2/5w==
X-Forwarded-Encrypted: i=1; AJvYcCU2VjED1FoXQpsDKIHdvzdmKrH2eOKZTdlYRJBFFe0BXBO15PfDwEQz4Id+NFFOdysaMZTvGCymv9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA5fQ5kPahiqa9tn7rRhOaZF0YauWKKiOgPqM6XugIdHSGgk7i
	x3VtJO3ffNpxhUKkFyopBPRdGjuWvfqVo8l94UKI08x4+c7YH/xe1/qGWYiRzQ==
X-Gm-Gg: AZuq6aK/iq8jgffDc9z8vbvC5AGK/ykgnGgC1a/M6NgJWugYiMWV5JswOs/+mNPbh4l
	ltzyB/u/11hP3cUzZT7N/RckjsXSXhQ6h1izShOKnwgZhtlWcySIGr1gH3Yuj8/DNV8HmiyfQUX
	Syt0BSNS6sWB6tJ10DmQEpUaAmciGK7iiaodumIbX1Gv3wNF9tEloUtN2LK1yYWhc7YXE5EWLj9
	cOAPmQWKbWFoTIl91HS+469bTSxqVkpqVzjITivJmRbjS+BrTZ13KUfZC4LgCf39i5E85eqXyIU
	82nFiGtGXfixGzt6df+95U2mA+p8GB9wuTy8wA/S4E+RNBI6kV7fiT28+jYamFtB+Et5TbhG1sv
	GXKH7HC9NgTNwWB0m6GO9XchlwQmFhmqFVs00oWIrXEDn4Yor89QImLZ2f0D32Ot0S+LggF919h
	StqPhfBgaqelm/5E62kS/p60GnLq353Q==
X-Received: by 2002:a05:600c:4749:b0:480:69b6:dfed with SMTP id 5b1f17b1804b1-483a95e5ab8mr72338125e9.24.1771717564334;
        Sat, 21 Feb 2026 15:46:04 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-483a31c56d8sm251620925e9.8.2026.02.21.15.46.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Feb 2026 15:46:03 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: dorjoychy111@gmail.com
Cc: ceph-devel@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	v9fs@lists.linux.dev
Subject: Re: [PATCH v4 0/4] OPENAT2_REGULAR flag support in openat2
Date: Sun, 22 Feb 2026 02:45:53 +0300
Message-ID: <20260221234553.2024832-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAFfO_h7TJbB_170eoeobuanDKa2A+64o7-sb5Mpk3ts1oVUHtg@mail.gmail.com>
References: <CAFfO_h7TJbB_170eoeobuanDKa2A+64o7-sb5Mpk3ts1oVUHtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19084-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,get_maintainers.pl:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 532AD16E459
X-Rspamd-Action: no action

Dorjoy Chowdhury <dorjoychy111@gmail.com>:
> I am not sure if my patch series made it properly to the mailing
> lists. https://lore.kernel.org/linux-fsdevel/  is showing a broken
> series, only the 2/4, 3/4, 4/4 and I don't see cover-letter or 1/4.
> The patch series does have a big cc list (what I got from
> get_maintainers.pl excluding commit-signers) and I used git send-email
> to send to everyone. It's also showing properly in my gmail inbox. Is
> it just the website that's not showing it properly? Should I prune the
> cc list and resend? is there any limitations to sending patches to
> mailing lists with many cc-s via gmail?

I see all 5 emails on
https://lore.kernel.org/linux-fsdevel/CAFfO_h7TJbB_170eoeobuanDKa2A+64o7-sb5Mpk3ts1oVUHtg@mail.gmail.com/T/#t .

So this was some temporary problem on lore.kernel.org .

Sometimes gmail indeed rejects mails if you try to send too many emails
to too many people. So I suggest adding "--batch-size=1 --relogin-delay=20"
to your send-email invocation. I hope this will make probability of
rejection by gmail less. I usually add these flags.

If you still expirence some problems with gmail, then you may apply
for linux.dev email (go to linux.dev). They are free for Linux contributors.

-- 
Askar Safin

