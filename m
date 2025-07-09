Return-Path: <linux-nfs+bounces-12953-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BDEAFE5B3
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Jul 2025 12:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 625B6176AAB
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Jul 2025 10:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6198728C87F;
	Wed,  9 Jul 2025 10:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="D1JWyogI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFC428C862
	for <linux-nfs@vger.kernel.org>; Wed,  9 Jul 2025 10:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752056792; cv=none; b=jCQHGmJepvUAxh8l/f8gd1WRfTnkEuntyvdYWeRZeji4MqMFCwQt3BSbEUfU68evMnPixYdaag8zFPNV3bPyCP9sYzywbdBH+nrmx9oJEUJfnJzGlOpwZG/uhrPVMMhVy2DU9Ds/NGSDcm3HjY/0szBZSjb9PUE31b1oKU1yqho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752056792; c=relaxed/simple;
	bh=wbnVGbjHNz2co8d+fXBHn4JejafVFSAL2G4zjFDrvs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=egWx+lpa3/lMltN1kQslpTi/BvR6L0sxfMp73tjXDjJ13RTsTpaCvKlJLnhlCX26aicUp2u5JwR1suoHzCmbd4sWlzV62TYPAfvIF+GyApJKcKttsxK85qWZxfpCREEOoz8wTYjYVru4PD8x1T7Te+lNzknYoWQmZ9/0L/HTr5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=D1JWyogI; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-607434e1821so7541820a12.0
        for <linux-nfs@vger.kernel.org>; Wed, 09 Jul 2025 03:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1752056788; x=1752661588; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q7WBoHo27tCDa77Ry5M8MzBflIzY6f9OMpHwiXcLHSs=;
        b=D1JWyogIFCQUnqEHsgjBo5v8xFFmdw5nxvVF5+3jX7gn+gUeOqTuFIeiKGdQrPcuOe
         M4yWynuUfuCTAH6wUj4MplmTKljf3gHKXGf5xfcILfPbR3pFLhuFmcHc96MVKzh8NgV7
         aCT5PhNylYrNh35vuWZlau4iA0PQuT8a3ep3zn67Y6EUw3Iw80wrBCmMxtpAKaAvi0wf
         AdaERMFYNNo2PU9A1D8OA2KB+ZWwEwkSETbmCrFxUq1+GUwplKL3RB2p7bjd8t3u7zyM
         u3ahRHR1TCPLt5wdiucAaBLkAf47HkvJYZJVDlhCBoyY4Oyq/P8dK9RL9f3Qpa21B3jD
         g7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752056788; x=1752661588;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7WBoHo27tCDa77Ry5M8MzBflIzY6f9OMpHwiXcLHSs=;
        b=BJC5bPynubpmHXtbVAaZ6Mt2aExBGGjgaExKiszwO2johe6KPB945C5IkrVseAu5ck
         8DlSj+lcxJLTm+2GPecfRfLxKZWu2rfeevrERV1GFbet7xdjUNauBTXzfNQhzrcYfasj
         nF/6f8N9inu/yAXZ+spLvgj/9j2V6jezMiBKS+3RdqeQ7sZ8FG4qFZrXRNIyNCjmPfCh
         qSCh0aMmz5H+nkmRdZZEaX6r9IbOX9l2BpGrlfw1lhEbYt+k/jOiUAj8Nr/1qCVofdLT
         5qkilc3t008Birvt2mEUS6vGAmdk8NpQoq2SJ2Cds68KaEyV9IUmaSVAuXi8CyLlfcjU
         BykQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBZmUPPtU8gatjb36C5GhjBtl254Ltd2Y4B/q2X83h5YrB+gFVpq0IqGaV/3HpzSLriSf8MBzX0iM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdkHu59qtEYBWbRWwQJm9Mi0ZSin9bN8/MVMR3LP+X8fd/rnrr
	sZIRFu4ty2hyPiE7XOVrR6ZRYNQwostuGFNaIVkjF9ZZPHfH80T8V+xnxJnkMPHyBdRmKngGzmH
	nWHJbL/kQ4abFFNUyRo0141RJxV/X/TeR7ueJPM++oA==
X-Gm-Gg: ASbGnctQB17fWoLDG3+8sBAK9YPOTH9ppUCx6aPNq5SdzauxkLccNLKLjm6CV+l2gVe
	ePVmu0Z/9trh4aNb7A5GTftMOHO7/Yupi91lNrJ6MWonzfqjJejEYrU+dMrIBlR6+igc1SwYWb2
	Ol+NjIFbjbStau0WP9v29s/9ou1YFVyDIVh/LgPDYe6k9DcaNg1dajB1vnIyxUzkX7HlhVZ9W+j
	VmjAWRszg==
X-Google-Smtp-Source: AGHT+IGbqwygDCctWSd13zB7txA8nj1LhT4JGyQ85VQ1ULmFhI635wDH8IR1PaEr0MvmBrrgrCIFH+uxlqg39uXxl9g=
X-Received: by 2002:a17:907:1c15:b0:ae0:bdc2:9957 with SMTP id
 a640c23a62f3a-ae6cfbd985amr185279366b.61.1752056788493; Wed, 09 Jul 2025
 03:26:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701163852.2171681-1-dhowells@redhat.com>
In-Reply-To: <20250701163852.2171681-1-dhowells@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 9 Jul 2025 12:26:17 +0200
X-Gm-Features: Ac12FXwp4fbGLXVwqf6tAOr1y42YQrXGTBI6Q0Kfy3_DmIljAuOKBpuGHKZXSZ0
Message-ID: <CAKPOu+8z_ijTLHdiCYGU_Uk7yYD=shxyGLwfe-L7AV3DhebS3w@mail.gmail.com>
Subject: Re: [PATCH 00/13] netfs, cifs: Fixes to retry-related code
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.com>, netfs@lists.linux.dev, linux-afs@lists.infradead.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

David Howells <dhowells@redhat.com> wrote:
> Here are some miscellaneous fixes and changes for netfslib and cifs, if you
> could consider pulling them.  All the bugs fixed were observed in cifs, so
> they should probably go through the cifs tree unless Christian would much
> prefer for them to go through the VFS tree.

Hi David,

your commit 2b1424cd131c ("netfs: Fix wait/wake to be consistent about
the waitqueue used") has given me serious headaches; it has caused
outages in our web hosting clusters (yet again - all Linux versions
since 6.9 had serious netfs regressions). Your patch was backported to
6.15 as commit 329ba1cb402a in 6.15.3 (why oh why??), and therefore
the bugs it has caused will be "available" to all Linux stable users.

The problem we had is that writing to certain files never finishes. It
looks like it has to do with the cachefiles subrequest never reporting
completion. (We use Ceph with cachefiles)

I have tried applying the fixes in this pull request, which sounded
promising, but the problem is still there. The only thing that helps
is reverting 2b1424cd131c completely - everything is fine with 6.15.5
plus the revert.

What do you need from me in order to analyze the bug?

Max

