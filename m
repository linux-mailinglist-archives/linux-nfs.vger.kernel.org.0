Return-Path: <linux-nfs+bounces-19787-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICkTKzBCqWkZ3gAAu9opvQ
	(envelope-from <linux-nfs+bounces-19787-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Mar 2026 09:43:28 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA2420DA3A
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Mar 2026 09:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44E7E301AB91
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Mar 2026 08:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACD43382C8;
	Thu,  5 Mar 2026 08:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DuRAsOq+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="O71YMrr7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8398D23C516
	for <linux-nfs@vger.kernel.org>; Thu,  5 Mar 2026 08:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772700064; cv=pass; b=MdFHB7Cz91eHe5k9sKWEifoxc8jH50cNrzqnp0BiQYey6Jwr+w3H462UmNgqLSns/RmfiLrJBH4Q+1mjXmmintARTthkgFO0zlQuYe1RJ96ccXRSI1gR+AN2FRKI8ISj6w70/ezTSUCdSHdWa82uACVBGHuEIVuLhqNu3zrOzRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772700064; c=relaxed/simple;
	bh=/fPzmjukNdIA39PT9q533jz5hvnPj2a94frU4suS68c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eL/yYHjdExZEi6kWD9O7UPvZJxruZdMIX8WOD00ibK4w85JlPMKrY9moGsp8UZABdzd5wWxvecBcIOz6xcFyQGE0ouEa+naBwCX8gpvcFy3GpK/cDBWVnggLN+usOnn5khbG3tSUm81OwbtW58sbS5uiAKXLQ7PbVKuysaSX23s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DuRAsOq+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=O71YMrr7; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772700061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WjwlZJsGgBP2MJ4Y+BlwbKQrifDwhQpRgaUp782Acxw=;
	b=DuRAsOq+bL7yrZWtWHjdqkUZ+YoKIdE7oqfAFkbhWi9Jjs9ISmPnI21CeWz3INLI6BSbjE
	ZN1VN9Q2gpVRGXzU1THIjKo/YlzbYuOEzUWAH39qDQYMVzbMqeUtzJfH0pQtLtVl+rh2rB
	wWk1A2B/0Q0gt/oRvlJscl6oBPCWEFk=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-qQFOlzUbMkClm7kTdlIjGw-1; Thu, 05 Mar 2026 03:40:59 -0500
X-MC-Unique: qQFOlzUbMkClm7kTdlIjGw-1
X-Mimecast-MFC-AGG-ID: qQFOlzUbMkClm7kTdlIjGw_1772700058
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-3870b9ec9a0so65726351fa.1
        for <linux-nfs@vger.kernel.org>; Thu, 05 Mar 2026 00:40:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772700058; cv=none;
        d=google.com; s=arc-20240605;
        b=lJSer28Gdq2oJR2Ro4R6inScN2xhiN9YMujP3lVXyEIM11qrY4hf+sfqD2wh5zU3RN
         wP286dZRQm41N1wLhtSKqIyTBkzJMIKYHlmSE3tJNPz4XxEbZ6ndDKPjZrrZl52GL4Ir
         yAbmYs8R3D09V6c+s51HOGqrUNr2YM4WFoK0AvSK29oyA/3kipSJOYCvzQIDXxB/omZ3
         SrmqUtRd96oXG2710u/nvSnxUD0HVEHlOhb87eeKU/68GBoA6yId47X6HVtZZs3BzHEg
         7uTMKETzo9fr3BYFMb91+zW+SWyo5jqHj53Cj1RpG1jw3Op9HfoHhG1z/HfKtBIkfy5+
         lOrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WjwlZJsGgBP2MJ4Y+BlwbKQrifDwhQpRgaUp782Acxw=;
        fh=w57hl1cYIjTpIV9hVy0wsd8XrDyQVzrGFhzn/MS3y6k=;
        b=ejIFcJEkGPUHVBiYGhQsKb3MRUcrOutClQ2aY9rhpbYhm3IOyCpI/xXiN8RabZDk7i
         bgDaxTpoX2P+bkSvESO+D6grJBDj/t/r3jypmdIW3Ajun44fuEN4Y4ZlHvTMuNtQmuvL
         33PjhNqZq+8FQOtFSSPwxdpDXIw5VfvK0IQPCfHwWXxsTI8ScqmvMPQgS8uNb7YZhnwp
         ZLfLPvoL6IVxJlEYSjgw9/+WkM7TwLV9JcROYqQ7F8ERDhcsvW/W3UzAG6SylA8zrOwE
         2xkqxFMq+q+PYDUSQMWklF782j2xM4+XpKcsrdyyxE/L9GY5Nwy6TGfZR8BUsV7zmKx/
         X0xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772700058; x=1773304858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjwlZJsGgBP2MJ4Y+BlwbKQrifDwhQpRgaUp782Acxw=;
        b=O71YMrr7ejOhNH09m2nw14Cf4NT1n+VKR9gAfyUU/iI3tzOva+6EGnWoF1zhvzNFkU
         4GTF/98V+HLfvTorlKmf+teZpz4ByU67Q08xq0oXHl/XgUv0qMrDuRslrLUvKQQTi72R
         rCqdnaBLz83I/1E9fmtJDkmui3vufZPp3CpQhm6iE6HlE79Dcgq6HFAl5PTgu0nXlkbc
         PDmPqS6iYusSlA02zK2pAsKF9Q0cJVMsh3ANeF93ZtSAfImEWbjFIL8Rgv1rt0Zvwdr4
         u4FWN6OtLcJ7YHIGGTuGF9VpKjWnxstd2zvU1Eqg1gZ1tT6/uKXOhGo1g9Ca/l9fREI3
         uKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772700058; x=1773304858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WjwlZJsGgBP2MJ4Y+BlwbKQrifDwhQpRgaUp782Acxw=;
        b=VuWohOWWKWcjprGb6nzDWUdto+WtuD044M23jP7w2wEIEETP4zFN3L6UN990slqln2
         q26LzrO3rhyxCZC/xsXr/ka/UWALa7/k8Avby3Nt7znTQzPiViIa3KtlHt4SAgz6XnNC
         UsDaAXU3F/HxoHs1NDvBdYVM7H3xwUiWGwpFWhfWFUEZG8yfottdw5e8RjSl7MnQnqV4
         TageQfvAVSUJIkSUf21ZwBdUN6Zecr8rfdPr2CigZpydCcJwnQZkvpcxdu++yQtLHtN6
         PNafLjEim4FcKzHwLKbCBGYE24XYbSu3AnQzEnA65lxJL/YI37ECb+B9X5gOhQHfu/9+
         Jl8w==
X-Forwarded-Encrypted: i=1; AJvYcCUoC1h8PwFrLEkva8Sk85VIegJOBFy5uYWQS0t+QUwFZfUwh/ElVYKnaYJsBZeT9pfCtKyBCJHu9oY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgCy1ZUKqozz3pk7MWAh4UOvC5YFTJEcSbHawWVDipZ/SbFOSo
	xxvW4XqyW4lX07QTb4ajG8D1ctWO7uDtUBlRKbooNhJ0r0+02guDZmYHYnyg+qicbz4ruxpaqEp
	crJloay17v7OweIOvBGg8YLPnajNffMXnxat6df5gGwKAo57SPhc6d/T+s2StmhLVZ/iolW1WYa
	udSDEU/g2B4qqBWSe7CKg07ovoK/iGC8EN7py4
X-Gm-Gg: ATEYQzyJxDUoOeQ307LduYn2MAVl8qcFPibwJ/rhOEu4NXdpIuyYGsTvJc14JVxnmdx
	+zLvSgOjwhKlEsupRJKNvrCxisR5PICGsha3uslpwWJF2B3bttjwElU3XG8X2FDoshXgqfZEEfj
	okpUSO+uNWddmOzBiHZUOqPKsyeR1Ixfv/AvzeY/MWDBKdpVtGznzIMdP5lId8OBPkmOp6z+GzV
	f/4j4YnXKl94fvndwjqqvsznZbvdV+PKwJ/zldT8VgcOTTbUHQ=
X-Received: by 2002:a05:651c:981:b0:386:46ac:835b with SMTP id 38308e7fff4ca-38a2c580f26mr35280181fa.16.1772700057379;
        Thu, 05 Mar 2026 00:40:57 -0800 (PST)
X-Received: by 2002:a05:651c:981:b0:386:46ac:835b with SMTP id
 38308e7fff4ca-38a2c580f26mr35280041fa.16.1772700056768; Thu, 05 Mar 2026
 00:40:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHj4cs9qsvcii+KuDWkRPMF6XdDfUwmnjn2Ox6TmGV1u4PpTJA@mail.gmail.com>
In-Reply-To: <CAHj4cs9qsvcii+KuDWkRPMF6XdDfUwmnjn2Ox6TmGV1u4PpTJA@mail.gmail.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 5 Mar 2026 16:40:42 +0800
X-Gm-Features: AaiRm51KTpiaHe8VGzN-UzejJJvgL-FUSghPsQVWJnSZXHIjzTTw2a0kPgoLdzE
Message-ID: <CAHj4cs8URj2fJ7KyP9ViAm6npVOaMiAErnw2uFyPYEU2wb7G_w@mail.gmail.com>
Subject: Re: [bug report] Most blktests block/ failed with "Timed out while
 waiting for udev queue to empty."
To: linux-block <linux-block@vger.kernel.org>, linux-nfs@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Ming Lei <ming.lei@redhat.com>, 
	Jens Axboe <axboe@kernel.dk>, Steved <steved@redhat.com>, atomlin@atomlin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0BA2420DA3A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19787-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yi.zhang@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[service.ping:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,linux-nfs.org:url]
X-Rspamd-Action: no action

CC linux-nfs
After analyzing the systemd-udevd logs I found that the udev rule
/usr/lib/udev/rules.d/99-nfs.rules triggers /usr/libexec/nfsrahead for
every new block device. In the current version, this binary takes
exactly 10 seconds to return an exit code 2 for non-NFS devices[2].
This latency, multiplied by thousands of test-generated events,
exhausts udev worker threads and blocks the event queue, leading to
the system-wide "Timed out while waiting for udev queue to empty"
error. In the previous version [1], the binary
/usr/libexec/nfsraheadprevious returns exit code 2 in 1 second.
After checking the changelog for the latest nfs-utils, seems it was
introduced from commit[3].

[1]
nfs-common-utils-2.8.4-4.rc3.fc44.x86_64    nfs-utils-2-8-5-rc3
Mar 04 10:27:39 (udev-worker)[53692]: 250:0: Starting
'/usr/libexec/nfsrahead 250:0'
Mar 04 10:27:39 (udev-worker)[53652]: 250:1: Processing device
(SEQNUM=3D120442, ACTION=3Dadd)
Mar 04 10:27:39 (udev-worker)[53652]: 250:1:
/usr/lib/udev/rules.d/99-nfs.rules:1 PROGRAM=3D"/usr/libexec/nfsrahead
%k": Running command "/usr/libexec/nfsrahead 250:1"
Mar 04 10:27:39 (udev-worker)[53652]: 250:1: Found callout binary:
"/usr/libexec/nfsrahead".
Mar 04 10:27:39 (udev-worker)[53652]: 250:1: Starting
'/usr/libexec/nfsrahead 250:1'
Mar 04 10:27:39 (udev-worker)[53692]: Successfully forked off
'(spawn)' as PID 67181.
Mar 04 10:27:39 (udev-worker)[53652]: Successfully forked off
'(spawn)' as PID 67182.
Mar 04 10:27:39 (udev-worker)[53692]: 250:0: Process
'/usr/libexec/nfsrahead 250:0' failed with exit code 2.
Mar 04 10:27:39 (udev-worker)[53692]: 250:0:
/usr/lib/udev/rules.d/99-nfs.rules:1 PROGRAM=3D"/usr/libexec/nfsrahead
%k": Command "/usr/libexec/nfsrahead 250:0" returned 2 (error)
Mar 04 10:27:39 (udev-worker)[53652]: 250:1: Process
'/usr/libexec/nfsrahead 250:1' failed with exit code 2.
Mar 04 10:27:39 (udev-worker)[53652]: 250:1:
/usr/lib/udev/rules.d/99-nfs.rules:1 PROGRAM=3D"/usr/libexec/nfsrahead
%k": Command "/usr/libexec/nfsrahead 250:1" returned 2 (error)
[2]
nfs-common-utils-2.8.5-0.rc3.fc44.x86_64  nfs-utils-2-8-6-rc3
Mar 04 06:07:14 (udev-worker)[2019]: 250:0:
/usr/lib/udev/rules.d/99-nfs.rules:1 PROGRAM=3D"/usr/libexec/nfsrahead
%k": Running command "/usr/libexec/nfsrahead 250:0"
Mar 04 06:07:14 (udev-worker)[2019]: 250:0: Found callout binary:
"/usr/libexec/nfsrahead".
Mar 04 06:07:14 (udev-worker)[2019]: 250:0: Starting
'/usr/libexec/nfsrahead 250:0'
Mar 04 06:07:14 (udev-worker)[2020]: nullb0:
/usr/lib/udev/rules.d/50-udev-default.rules:93 GROUP=3D"disk": Set group
ID: 6
Mar 04 06:07:14 (udev-worker)[2021]: null_blk: Device processed
(SEQNUM=3D10585, ACTION=3Dadd)
Mar 04 06:07:14 (udev-worker)[2021]: null_blk:
sd-device-monitor(worker): Passed 157 byte to netlink monitor.
Mar 04 06:07:14 (udev-worker)[2021]: Notify message sent to
'@18092807967873750410': "PROCESSED=3D1"
Mar 04 06:07:14 (udev-worker)[2019]: Successfully forked off '(spawn)'
as PID 2023.
Mar 04 06:07:14 (udev-worker)[2020]: nullb0: Setting permissions
/dev/nullb0, uid=3D0, gid=3D6, mode=3D0660
Mar 04 06:07:14 (udev-worker)[2020]: nullb0: Successfully created
symlink '/dev/block/250:0' to '/dev/nullb0'
Mar 04 06:07:14 (udev-worker)[2020]: nullb0: sd-device: Created
database file '/run/udev/data/b250:0' for
'/devices/virtual/block/nullb0'.
Mar 04 06:07:14 (udev-worker)[2020]: nullb0: sd-device: Created
database file '/run/udev/data/b250:0' for
'/devices/virtual/block/nullb0'.
Mar 04 06:07:14 (udev-worker)[2020]: nullb0: Device processed
(SEQNUM=3D10584, ACTION=3Dadd)
Mar 04 06:07:14 (udev-worker)[2020]: nullb0:
sd-device-monitor(worker): Passed 268 byte to netlink monitor.
Mar 04 06:07:14 (udev-worker)[2020]: Notify message sent to
'@18092807967873750410': "PROCESSED=3D1"
Mar 04 06:07:14 systemd-udevd[1300]: 250:0: Device is queued
(SEQNUM=3D10586, ACTION=3Dremove)
Mar 04 06:07:14 systemd-udevd[1300]: 250:0: SEQNUM=3D10586 blocked by SEQNU=
M=3D10583
Mar 04 06:07:14 systemd-udevd[1300]: nullb0: Device is queued
(SEQNUM=3D10587, ACTION=3Dremove)
Mar 04 06:07:14 systemd-udevd[1300]: nullb0: Device ready for
processing (SEQNUM=3D10587, ACTION=3Dremove)
Mar 04 06:07:14 systemd-udevd[1300]: nullb0:
sd-device-monitor(manager): Passed 233 byte to netlink monitor.
Mar 04 06:07:14 (udev-worker)[2021]: nullb0: Processing device
(SEQNUM=3D10587, ACTION=3Dremove)
Mar 04 06:07:14 (udev-worker)[2021]: Notify message sent to
'@18092807967873750410': "INOTIFY_WATCH_REMOVE=3D1"
Mar 04 06:07:14 (udev-worker)[2021]: nullb0: Device processed
(SEQNUM=3D10587, ACTION=3Dremove)
Mar 04 06:07:14 (udev-worker)[2021]: nullb0:
sd-device-monitor(worker): Passed 271 byte to netlink monitor.
Mar 04 06:07:14 (udev-worker)[2021]: Notify message sent to
'@18092807967873750410': "PROCESSED=3D1"
Mar 04 06:07:14 systemd-udevd[1300]: null_blk: Device is queued
(SEQNUM=3D10588, ACTION=3Dremove)
Mar 04 06:07:14 systemd-udevd[1300]: null_blk: Device ready for
processing (SEQNUM=3D10588, ACTION=3Dremove)
Mar 04 06:07:14 systemd-udevd[1300]: null_blk:
sd-device-monitor(manager): Passed 160 byte to netlink monitor.
Mar 04 06:07:14 (udev-worker)[2021]: null_blk: Processing device
(SEQNUM=3D10588, ACTION=3Dremove)
Mar 04 06:07:14 (udev-worker)[2021]: null_blk: Device processed
(SEQNUM=3D10588, ACTION=3Dremove)
Mar 04 06:07:14 (udev-worker)[2021]: null_blk:
sd-device-monitor(worker): Passed 160 byte to netlink monitor.
Mar 04 06:07:14 (udev-worker)[2021]: Notify message sent to
'@18092807967873750410': "PROCESSED=3D1"
Mar 04 06:07:14 systemd-udevd[1300]: null_blk: Device is queued
(SEQNUM=3D10589, ACTION=3Dadd)
Mar 04 06:07:14 systemd-udevd[1300]: null_blk: Device ready for
processing (SEQNUM=3D10589, ACTION=3Dadd)
Mar 04 06:07:14 systemd-udevd[1300]: null_blk:
sd-device-monitor(manager): Passed 157 byte to netlink monitor.
Mar 04 06:07:14 (udev-worker)[2021]: null_blk: Processing device
(SEQNUM=3D10589, ACTION=3Dadd)
Mar 04 06:07:14 (udev-worker)[2021]: null_blk: Device processed
(SEQNUM=3D10589, ACTION=3Dadd)
Mar 04 06:07:14 (udev-worker)[2021]: null_blk:
sd-device-monitor(worker): Passed 157 byte to netlink monitor.
Mar 04 06:07:14 (udev-worker)[2021]: Notify message sent to
'@18092807967873750410': "PROCESSED=3D1"
Mar 04 06:07:14 systemd-udevd[1300]: varlink: New incoming connection.
Mar 04 06:07:14 systemd-udevd[1300]: varlink-15-15: Setting state idle-serv=
er
Mar 04 06:07:14 systemd-udevd[1300]: varlink-15-15: Received message:
{"method":"io.systemd.service.Ping"}
Mar 04 06:07:14 systemd-udevd[1300]: varlink-15-15: Changing state
idle-server =E2=86=92 processing-method
Mar 04 06:07:14 systemd-udevd[1300]: Received io.systemd.service.Ping
Mar 04 06:07:14 systemd-udevd[1300]: varlink-15-15: Sending message: {}
Mar 04 06:07:14 systemd-udevd[1300]: varlink-15-15: Changing state
processing-method =E2=86=92 processed-method
Mar 04 06:07:14 systemd-udevd[1300]: varlink-15-15: Changing state
processed-method =E2=86=92 idle-server
Mar 04 06:07:14 systemd-udevd[1300]: varlink-15-15: Got POLLHUP from socket=
.
Mar 04 06:07:14 systemd-udevd[1300]: varlink-15-15: Changing state
idle-server =E2=86=92 pending-disconnect
Mar 04 06:07:14 systemd-udevd[1300]: varlink-15-15: Got POLLHUP from socket=
.
Mar 04 06:07:14 systemd-udevd[1300]: varlink-15-15: Changing state
pending-disconnect =E2=86=92 processing-disconnect
Mar 04 06:07:14 systemd-udevd[1300]: varlink-15-15: Changing state
processing-disconnect =E2=86=92 disconnected
Mar 04 06:07:24 (udev-worker)[2019]: 250:0: Process
'/usr/libexec/nfsrahead 250:0' failed with exit code 2.

[3]
https://git.linux-nfs.org/?p=3Dsteved/nfs-utils.git;a=3Dcommit;h=3D2b62ac4c=
273a647df07400dc1126fceb76ad96c0


On Tue, Mar 3, 2026 at 11:55=E2=80=AFPM Yi Zhang <yi.zhang@redhat.com> wrot=
e:
>
> Hi
>
> CKI reported that most blktests block/ failed at "udevadm settle"[2]
> on the latest linux-block/for-next[1] today.
> Seems it's one regression issue and I will try to bisect it tomorrow.
>
> [1]
> commit: for-next (7.0.0-rc2, upstream-block, b82c5e4f)
> [2]
> block/001 (stress device hotplugging)                        [failed]
>     runtime    ...  531.793s
>     --- tests/block/001.out 2026-03-02 23:17:54.816626772 +0000
>     +++ /mnt/tests/s3.amazonaws.com/arr-cki-prod-lookaside/lookaside/kern=
el-tests-public/kernel-tests-production.tar.gz/storage/blktests/blk/blktest=
s/results/nodev/block/001.out.bad
> 2026-03-02 23:26:52.842946157 +0000
>     @@ -1,4 +1,8 @@
>      Running block/001
>      Stressing sd
>     +Timed out while waiting for udev queue to empty.
>      Stressing sr
>     +Timed out while waiting for udev queue to empty.
>     +Timed out while waiting for udev queue to empty.
>     +Timed out while waiting for udev queue to empty.
>     ...
>     (Run 'diff -u tests/block/001.out
> /mnt/tests/s3.amazonaws.com/arr-cki-prod-lookaside/lookaside/kernel-tests=
-public/kernel-tests-production.tar.gz/storage/blktests/blk/blktests/result=
s/nodev/block/001.out.bad'
> to see the entire diff)
> >>> 2026-03-02 23:26:52 | End /mnt/tests/s3.amazonaws.com/arr-cki-prod-lo=
okaside/lookaside/kernel-tests-public/kernel-tests-production.tar.gz/storag=
e/blktests/blk/blktests/tests/block/001
> ** storage/blktests/tests/block/001 FAIL Score:1
> Uploading resultoutputfile.log .done
> >>> 2026-03-02 23:26:53 | Start to run test case  /mnt/tests/s3.amazonaws=
.com/arr-cki-prod-lookaside/lookaside/kernel-tests-public/kernel-tests-prod=
uction.tar.gz/storage/blktests/blk/blktests/tests/block/002 ...
> block/002 (remove a device while running blktrace)
> block/002 (remove a device while running blktrace)           [failed]
>     runtime    ...  361.751s
>     --- tests/block/002.out 2026-03-02 23:17:54.816626772 +0000
>     +++ /mnt/tests/s3.amazonaws.com/arr-cki-prod-lookaside/lookaside/kern=
el-tests-public/kernel-tests-production.tar.gz/storage/blktests/blk/blktest=
s/results/nodev/block/002.out.bad
> 2026-03-02 23:32:55.837327191 +0000
>     @@ -1,2 +1,5 @@
>      Running block/002
>     +Timed out while waiting for udev queue to empty.
>     +Timed out while waiting for udev queue to empty.
>     +Timed out while waiting for udev queue to empty.
>      Test complete
> >>> 2026-03-02 23:32:55 | End /mnt/tests/s3.amazonaws.com/arr-cki-prod-lo=
okaside/lookaside/kernel-tests-public/kernel-tests-production.tar.gz/storag=
e/blktests/blk/blktests/tests/block/002
> ** storage/blktests/tests/block/002 FAIL Score:1
> Uploading resultoutputfile.log .done
> >>> 2026-03-02 23:32:56 | Start to run test case  /mnt/tests/s3.amazonaws=
.com/arr-cki-prod-lookaside/lookaside/kernel-tests-public/kernel-tests-prod=
uction.tar.gz/storage/blktests/blk/blktests/tests/block/006 ...
> block/006 (run null-blk in blocking mode)
> block/006 (run null-blk in blocking mode)                    [failed]
>     runtime    ...  120.067s
>     --- tests/block/006.out 2026-03-02 23:17:54.817585748 +0000
>     +++ /mnt/tests/s3.amazonaws.com/arr-cki-prod-lookaside/lookaside/kern=
el-tests-public/kernel-tests-production.tar.gz/storage/blktests/blk/blktest=
s/results/nodev/block/006.out.bad
> 2026-03-02 23:34:57.275131017 +0000
>     @@ -1,2 +1,2 @@
>      Running block/006
>     -Test complete
>     +Timed out while waiting for udev queue to empty.
> modprobe with --wait option succeeded but still null_blk has references
>
>
>
>
> --
> Best Regards,
>   Yi Zhang



--=20
Best Regards,
  Yi Zhang


