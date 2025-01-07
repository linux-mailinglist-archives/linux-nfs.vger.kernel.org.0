Return-Path: <linux-nfs+bounces-8941-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 524DBA038AB
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 08:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D85F3188664A
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 07:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAF2185E7F;
	Tue,  7 Jan 2025 07:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUzuwj+F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7D217C9E8
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jan 2025 07:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736234285; cv=none; b=juJBFV5yviiYsAAJo1T44yd748e7rU2HneEYtbwmq16bZ2y+W3elnsBg8/2izF7Lw/U2kHaSUuCHJHSl8fMicqwpdh7dbcutJ8YFGnYa8gzFeREJllwbIhwq8exT9PJUs4R8S1Cd1ZsvXPk8MqMszKN0Mh8SmIYPBCETC++2rUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736234285; c=relaxed/simple;
	bh=MdJmLyqtJfoW2cgfU/8hsNf4vqrheI6rorsAhg8BmaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ieQRac4R+i0STdImxWjyeChMv5KK2ox+ICYjrvOmLkQouTslvEmdNd5QZdF5eU817WTeZ8RMTCN0G0sX1qI5rr7+8Nl8Qc9ilp/etcixwnWQqzwMC8q3vQcaA2oIEEYZqOscImV2QVZkgOHzyac96OMiEo5mV7w3p3JKI5wAi7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUzuwj+F; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d3f28881d6so22607164a12.1
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jan 2025 23:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736234279; x=1736839079; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MdJmLyqtJfoW2cgfU/8hsNf4vqrheI6rorsAhg8BmaM=;
        b=QUzuwj+Fo+NRmygSRse6Yk44QpO6FyN8dvMDex1xAlrVfa+NKTSjJOVPi2BlTrOlcC
         qtoIpCh9M13QNSOEEaChul8GTucudrM1UPGntwhMf/HoZjlacTSP81BLju+ptEcfMQL5
         BjBWsmPQpurBfiENSncbOQ1c9DWOR/CxTpfAA5bZQhds/M2OZU8kqDrR1K3FR33SpCvo
         Wts7XCU7aj/pprCZNFO30IntMTv9XuxWvs4x5CCgU0CwItPb2SPJeNTe6hxdp4DibGvl
         Oo8f97zTU1sN26TUk4yJZSv06ncvqdGWo5bt7RBSJVc/T9CnFf1ihPSgPPlic1H1Z0jn
         sHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736234279; x=1736839079;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MdJmLyqtJfoW2cgfU/8hsNf4vqrheI6rorsAhg8BmaM=;
        b=gWh/6YXhs3uST6cyw2f6EYfUE39PoRgxRhzE9I4pE4qTA2+uByfgP54SUIaCJ+dnkF
         nAB//0eG+4m04lx940LCimZITM1iXSE+U6sfFXS+lMXWoGOhhU0tivlxjjcKNKhweb4l
         PbplnbebQFE8Alr98QyiIN2OA8+OLjJEJgWa9t28z6xv81qNVruYb2OI2/Te0xJGp+qm
         k8BglItCNcx5B6olrFrdP3J7tTPGj1cOm7YJLGpliehAwF87KLBoBzfq3IAmVw4/n5kQ
         Flsk+WoT4Pe2Hma0MKhDnwXiXYdPCntEl8sazNZJnJkoPbkJLlVFfyCIY6L/tUfQTYrA
         dNQQ==
X-Gm-Message-State: AOJu0Yz96GG2jnHzhzV7ZHmfRKh/Q472bR+/n9ccq+qWdshTeToD5P33
	Lgp/1BVy6WipFn5o+11RfJzvYt8im6btrD/4rwPtgvlhkr2/oMwT8qaf09lse+HvfIIAn/gMLGF
	J1ihrskkUu5HFz6A+YgVixwBRJILBZw==
X-Gm-Gg: ASbGncuG6yVDOjJ4+ZGEipzgXwE+8gFzKAH0+0LMS0Fg4Y3UdrEJ7yPXyTV3iglojqk
	0+QXWDdKZG4MMoVyJdprHQLJTX49d+KWZRLVPeQc=
X-Google-Smtp-Source: AGHT+IEEP8mF6qoXcacFgLFwB/R5pVLSZsdrfsCsKhhS5wcbSQE+4Kkwu15G9WghAWRvBENjlL/bBmrWj4vkUmckMeg=
X-Received: by 2002:a05:6402:540b:b0:5d6:48ef:c19f with SMTP id
 4fb4d7f45d1cf-5d81de1c28fmr146264964a12.29.1736234279414; Mon, 06 Jan 2025
 23:17:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0Ucd6UQTCn_SZz_kutWwc=OUd6faHMjLx4Kj=Cmhjvs9pw@mail.gmail.com>
 <CAN-5tyHR_cfyVFmrj_m0i-2K-z_=SDGCpaYGEQZWEGw7CBWoUw@mail.gmail.com>
In-Reply-To: <CAN-5tyHR_cfyVFmrj_m0i-2K-z_=SDGCpaYGEQZWEGw7CBWoUw@mail.gmail.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Tue, 7 Jan 2025 08:16:00 +0100
Message-ID: <CALXu0Ud8SVPcLrd1pgjG0qtuVk2juy9mZr1td039qADiptmVXg@mail.gmail.com>
Subject: Re: NFS4.2 CLONE copy blocks into the same file?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 6 Jan 2025 at 16:21, Olga Kornievskaia <aglo@umich.edu> wrote:
>
> On Sun, Jan 5, 2025 at 1:46=E2=80=AFAM Cedric Blancher
> <cedric.blancher@gmail.com> wrote:
> >
> > Good morning!
> >
> > Can Linux nfsd NFS4.2 CLONE copy blocks within the same file?
>
> Linux server calls into the exported filesystem for support of
> clone/copy functionality (thru the same copy_file_range() VFS
> functionality).

That does not really answer the initial question: Can this copy blocks
within the same file, for example nfsclient-->linux-nfsd-->ext4fs?

Ced
--=20
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

