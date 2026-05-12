Return-Path: <linux-nfs+bounces-21507-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKboM3L3AmqvzAEAu9opvQ
	(envelope-from <linux-nfs+bounces-21507-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 11:48:34 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEC751E08E
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 11:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65E6730158A6
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 09:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47D239EF1A;
	Tue, 12 May 2026 09:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsvccSlk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5D8388374
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 09:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778579312; cv=pass; b=DmshD0qxLwFGYMUrSAFnrji5/fcgzeaDexkAcMenxaI0K0dP5es26OJpPbgH1nCjntcRBiH/rtihhEm0+E/nUSgXy3IgNraWSM5cwEHVbNHMBhy/EhBjuH2IiumEvWlrO/iPC9Jp30teYjj/g+8AZtrAsn/8kogybcJj8EwkF1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778579312; c=relaxed/simple;
	bh=EnMvHhz8tXE+6iiOZrFZehFgIcd2bW5dF4k9TxhGDoM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Jk2eRB5Q4VF+apMQC69OW4y18gahW6hQ4cjYt/gNwLXD9W/840CVSQjjLl4cRAMy4MDXZyvsroqZUGAwBEsTK9LvPV8Gpvdg8AoKLLguCQPHV7fSSUifB6NPVtn+07HcPOl21wHNpv/qPqknLM1E1eWEwiBsMd7TRL5m+dJdExE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsvccSlk; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-67cd93d8affso6509896a12.2
        for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 02:48:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778579309; cv=none;
        d=google.com; s=arc-20240605;
        b=YEbELbMvXrQnzF8ziN1ydBG2tokiB0W1Lbq7bukiE1gt+aZkYjUvfBAaG6BJ6uTLFS
         WK39eILpRBp21ZQ6j2n1SvPV0rLH3bFDYzHsTrI3b+FlXZnyGkO0LgT6WXonrnv3el5j
         M7gFCK6Ul585DTUX9JemG1jRfzaRaRYtmnkKMxggN8kHPUy5o2ET2eV1IBJKPENnoUcD
         UDynL0ovWi5VHLZVfKwXmk+/jqh+WedtogwMUs1jmL6x90ka2Q6BSriYyr1kz0FHhnLj
         flK0fCfH6FzkpAX7wfYGc9P3Z1jrf5u6Zt1IO7c2g9UrMTbkhgjs+nsXgzwVtbcfxKG8
         tXGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=EnMvHhz8tXE+6iiOZrFZehFgIcd2bW5dF4k9TxhGDoM=;
        fh=A6VhHI7NKHnmfjjs9vgKiwsl8TnYIjA9XaJXQoRXXsA=;
        b=SWjM8JdGKiYgHz0Y4hGFWZY6NH3bneLLajw2pytW6pTbhhiAGLENToI7tq/k9wvo7U
         bth52pEgJZ8mjwzO8xLhlcaZc9E2q8GstO4sgBFfRI1eT5McMLFGLX+IqgEVNw68eD8N
         AFDxwBLLD4B3XsizLeSE5RurM3C9z1qOZY1H3NZz8jsyxxI7gW2xhYc8b4BzDo17lbOZ
         PKgpoa68C2S7B8LBKaQL1Y3Bzw3iNnngnwwOfS1geUu/7Pd+2VR2dszvkgjSB1YAh9ju
         UufRhC0yzA+mtJs49V2CYo22R6nkrY7BcSIWzcNi6SccUzJKzOnOHBNFGRHv5DHnuw6G
         T/QA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778579309; x=1779184109; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EnMvHhz8tXE+6iiOZrFZehFgIcd2bW5dF4k9TxhGDoM=;
        b=LsvccSlkgsRFU+JyYYUupL0N0L4dY/Jh5eRnclyqU063/4PDYl0DsR8/iXF1m1x52r
         Zamk+xRLcMqZauPlG+34XcP7lMvB5KB+eSVrtixr094/Kt47B5Ztfvvj5ZWcz+7S84HL
         Mj5HCwaFDW5mvVlUo6B7TysXVWUfI+xVVgwK7ljLiynVNihPQN3py8L5NVIa9xuEhdYz
         cJ0zMfW5Mnt1q5XkPe9pnsuRiB398kju6Fp2wUZOpjgcaEwENCniPBofW0pNg5gY2n5Z
         acJF7ScDoFIKOST0p9JEgqqbOS6pb7cKvWWUmeW4W40gjpBJ1hVpcS1lca+3HX9lCttG
         dlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778579309; x=1779184109;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EnMvHhz8tXE+6iiOZrFZehFgIcd2bW5dF4k9TxhGDoM=;
        b=GqpQB/f1bXnvLyBevsJE30juudMUhB0CiplpGN/A/3CWDVThmoG8Z/hmmJGNiCaTMm
         euFZZrg2pj6jiYmv1wF/Gmf80nzGuF302kNvgrY6eEUivd8xvONahImHylRSRBeq+6og
         7XkMWFHyEmjUlNHjy3hoPDzcrimNN4PY+mBRh4G1KV2v4Ek3XbpaclT+MyYMOR472eGb
         xvwZheuYuv/chpGpLVAMN9FWJpOwoKuLrA9hEEuzNEPkwjCVjpPVMgqjZbD7nZoRlIJA
         6J3E2EeYmIF4riFBqNBLsS8VUI0fEzQ+tvsILh/9JRGgWaGj52cWBLVMANB0PCHsm9hh
         nncw==
X-Gm-Message-State: AOJu0YyAaZhhBQpstX7XHmZXbvyY86R++BwZKqmTGRP/7zlFRAO2y2RZ
	UD5qsUdSNedweiTNyepRSjJdVT0yqw79ndrjELqRCpUduZWGcMbw9b2ZuTOezyUQsUnOghrfg/d
	PLR4be8KbeoekPt01y0VZUO0QuyiIuxmZajQOuKo=
X-Gm-Gg: Acq92OFGGjoEPRVyGcsk5WzYQKdYv3urPbm38P8Bf+TDAPba+6ujEmYhPbMwXtYpnQ/
	t1187RW3qjyd7Y9sj7phUNv/w6kEAQk69sWYJfYvZ26brN/JTCi1KWfZK79o4a6CCleH3P7UapW
	nkwWatg7+CJdXpK3rC6Lmz4Zx0daLPzDyiRC/V8ZeJ/kwWpJo6d3z+Kcj+9B7kWTx3y3+G09Iak
	24hDUOjujuX9rbFsETEmmnz1Wns5Q79skSgZXR2K6I0bJZpKVDNewREltDTCLzrfP1aDKQJcrLS
	zzc+L0c=
X-Received: by 2002:a05:6402:5190:b0:67c:5745:ba00 with SMTP id
 4fb4d7f45d1cf-67d62015ac2mr16424350a12.0.1778579308874; Tue, 12 May 2026
 02:48:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lionel Cons <lionelcons1972@gmail.com>
Date: Tue, 12 May 2026 11:47:50 +0200
X-Gm-Features: AVHnY4LkaphoUrEkcdV3GzJW4XzUsDaxhdAqtDuNRZ4MAKO9uVmp8Yr7C6OOGxk
Message-ID: <CAPJSo4XdpOu_yNGpbMMQ0hAO+mdOy2-TsEke_vHGm60k6jp2Bw@mail.gmail.com>
Subject: Suggestions to drastically reduce Linux nfsd I/O latency on BTRFS?
To: linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 6EEC751E08E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-21507-lists,linux-nfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lionelcons1972@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

Are there suggestions on how to reduce Linux nfsd I/O latency on
BTRFS? Can putting nfsd into a realtime process class help? Other
ideas?

Lionel

