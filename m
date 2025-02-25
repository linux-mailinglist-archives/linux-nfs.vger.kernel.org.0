Return-Path: <linux-nfs+bounces-10345-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E310A44E09
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Feb 2025 21:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D703A70DF
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Feb 2025 20:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF9219992E;
	Tue, 25 Feb 2025 20:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="WSCJlJGs";
	dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="RZZfLqVP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mxout1.mail.janestreet.com (mxout1.mail.janestreet.com [38.105.200.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184871A9B58
	for <linux-nfs@vger.kernel.org>; Tue, 25 Feb 2025 20:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=38.105.200.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740516656; cv=none; b=o+f1xvESXdwK3XJq9brTi7LG7iwym+wDfCfkI7hOpjTvY5+bUKXiCKvmkIibtypxwlqEAuDsn5CUs2NGusl2lefWCYhykYxu8jL4zWT2L6P9kKsXI9hCNPtD5Cm/zNkum/ogOv6hVT/n5WEfIfRmHUjPSR34YeR3jfFmL9fiwJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740516656; c=relaxed/simple;
	bh=UHI3TFLPK5ZYqAXOsCmG0nKEKEzzdMdA9LpwLO+rxsI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=rT03tLZ7bNJqlyMzxSdScITOGANgAgYFwIWDy71SWnlgLMdhINzC9BhUw3J3gmfhgKujxcMTsNOfrTwlicpiB+KV5B4qwma/aC5RIDCIhXbnAzNh5S9Xh3BFhIkBHt3HwJjxr842bx8rILqXizKqI9dGrZwGRfLJy0unLt9oqDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com; spf=pass smtp.mailfrom=janestreet.com; dkim=pass (1024-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=WSCJlJGs; dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=RZZfLqVP; arc=none smtp.client-ip=38.105.200.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=janestreet.com
Received: from mail-yw1-f200.google.com ([209.85.128.200])
 	by mxgoog2.mail.janestreet.com with esmtps (TLS1.3:TLS_AES_128_GCM_SHA256:128)
 	(Exim 4.98)
 	id 1tn1tA-00000007Oc1-3Lkq
 	for linux-nfs@vger.kernel.org;
 	Tue, 25 Feb 2025 15:50:48 -0500
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-6fbbf78effdso3586667b3.0
         for <linux-nfs@vger.kernel.org>; Tue, 25 Feb 2025 12:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
         d=janestreet.com; s=google; t=1740516648; x=1741121448; darn=vger.kernel.org;
         h=content-transfer-encoding:to:subject:message-id:date:from
          :mime-version:from:to:cc:subject:date:message-id:reply-to;
         bh=UHI3TFLPK5ZYqAXOsCmG0nKEKEzzdMdA9LpwLO+rxsI=;
         b=WSCJlJGsbz1LIFF2fiMn3kahkcQ7YzFaQ/5yhu1Wx9RSvNK566VCPvdX7iBZKVP7Yh
          MWALXjxyLrL9+v1s7cZ7BPOYq9QxnJNCyqjLwALTw7gjxlGUC7SXL3VSEWz6kLvW4aFv
          jF95mcFwkloGXz20al+jW2Ku36+S/VALGdZqY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janestreet.com;
  s=waixah; t=1740516648;
  bh=UHI3TFLPK5ZYqAXOsCmG0nKEKEzzdMdA9LpwLO+rxsI=;
  h=From:Date:Subject:To;
  b=RZZfLqVPwcOMS9oVfrxN2REs5wSoL5pUkJb5sI02A45T3VFjWzsy78UIRKVaJ4r7D
  jPoPC3npn5z3To6se3Wn9AhadsyPNmu8VLJlGRwTVvavsM2SKzavzPnR8Oi0OO1f3D
  7JJ29OtriDOiv+LnU7aH1VesoLKPRPU/FxyBi8yzUEPHhOKj/BXGa4LBLmRYapx6M8
  h4FBmAc6lWYtMZoHUln7D7uFENSOyl7beibgKy6QskNQK9y4WL5Bk6WB5aYnbK+pu/
  6bx7M56QIAMydM2JsCehSb+PD0VITC/z8TD7oI/uKBbFDlFkb7rIz9CUKHysgwl8Vp
  QLx0/8alMUi5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
         d=1e100.net; s=20230601; t=1740516648; x=1741121448;
         h=content-transfer-encoding:to:subject:message-id:date:from
          :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
          :reply-to;
         bh=UHI3TFLPK5ZYqAXOsCmG0nKEKEzzdMdA9LpwLO+rxsI=;
         b=H0Xh17TLuo47b/yNsj0rRA1r7B6uSXtczgqRnblw+H4ZNj7TTtR1foul+RjuXmO742
          kMH2ltvjmwH9q1KbrJgfVoCJT7ONVB5Zf3ZfAJDhShFpNU4qbPRPYWxQdRW071zKFOga
          +UPdqPjqeLfa+MbaWovk51KM+Zk7sqUARuRPhccDN/wFIBuUE3s46loHaA/SIKU3vDu/
          3kKWW1Y57SnNfejgpQo2cn3n+jLhs7OW8qwqNiUpfkNOhB8A46l5tdXXx1Gi6xeghGtk
          RR1PaOsNq2sX7zV1Hhkuk6a9AQaDiwM4ra43FcWnsZ6NEXyRxd10fEOwOM4kEwTURAby
          15nw==
X-Gm-Message-State: AOJu0YxCSwIUkvFLrOgKKKW7ERS/nB5qhCIsIZ9f+0P6ZhDGzkujxRNa
 	T/FgKhxm7MwMhzmglt67S8NzNYjpi/YPbUcoaCyAmbxaSFcTJ7/u9bKPFTWLTqbZLAxcuH17lPL
 	l51DVxDt4LwiBwUYMiz79Lb5vyaYKHW572zDvXgMTZET6qyHIm000dwDFUQUeXENS57UByld9Zx
 	/Yyxz3q/b+sPUDp8ev+RJuvLDGk7hrAx6l2fb6D6p4Cg==
X-Gm-Gg: ASbGncsIk3zM17+T3CPu7rqnBW89X1AlMDlK218oGTaHA6IfGXHHTLrUTJnH8vPlzYk
 	IltzB61MmSY0aNmJlSDpZSHnkYEH8xs9ec+TricyXE/5JjDdG3OA3/ePeYNIWccv8DW/Fn4b3
X-Received: by 2002:a05:6902:27c8:b0:e5d:cc35:3e2d with SMTP id 3f1490d57ef6-e5e1915f687mr20009139276.4.1740516648081;
         Tue, 25 Feb 2025 12:50:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHunsSpwmBvsCmnMp/WNK+3FrpjwJAi5CVwIOU75jA/tYNrsGJFs5+VTblu6cWlhkNSEGnmnVlKCjQVet+1qjc=
X-Received: by 2002:a05:6902:27c8:b0:e5d:cc35:3e2d with SMTP id
  3f1490d57ef6-e5e1915f687mr20009125276.4.1740516647785; Tue, 25 Feb 2025
  12:50:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nikhil Jha <njha@janestreet.com>
Date: Tue, 25 Feb 2025 15:50:36 -0500
X-Gm-Features: AWEUYZmcZ7EmFmVDLbmgsMQBO2hQkv90cHoUw4BeJgkX2CJyDrQ6_uAjxhO6Cb4
Message-ID: <CAMZ31nmZv7sJ2tYv_RirExhw=DCDDUvXTcf7D5r9bFgkfWq3jw@mail.gmail.com>
Subject: Kerberized NFS: EACCES errors due to GSS sequence number handling
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

I'm writing to report what appears to be a bug in the Linux kernel's
handling of RPCSEC_GSS sequence numbers during NFS request
retransmissions. We've observed this causing spurious EACCES errors in
our environment when using NFS with Kerberos authentication, even
using a hard mount. We've been able to reliably reproduce the issue.

When the client retransmits an operation (for example, because the
server is slow to respond), a new GSS sequence number is associated
with the XID. In the current kernel code the original sequence number
is discarded. Subsequently, if a response to the original request is
received there will be a GSS sequence number mismatch. A mismatch will
trigger another retransmit, possibly repeating the cycle, and after
some number of failed retries EACCES is returned.

Looking at RFC2203, section 5.3.3.1 suggests that the client =E2=80=9Ccache
the RPCSEC_GSS sequence number of each request it sends=E2=80=9D and "compu=
te
the checksum of each sequence number in the cache to try to match the
checksum in the reply's verifier." From a quick look this is what
FreeBSD=E2=80=99s implementation does (rpc_gss_validate in
sys/rpc/rpcsec_gss/rpcsec_gss.c).

Thoughts?

Thanks,
Nikhil

