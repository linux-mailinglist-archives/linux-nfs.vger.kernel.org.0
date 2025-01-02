Return-Path: <linux-nfs+bounces-8873-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A7F9FFA7F
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jan 2025 15:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06383162A68
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jan 2025 14:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833781AC44D;
	Thu,  2 Jan 2025 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrnXevwU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF653FE4
	for <linux-nfs@vger.kernel.org>; Thu,  2 Jan 2025 14:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735828412; cv=none; b=fkkt5cKWupgMKYv60Y6/8UNnrqSpOr6RYBnMgOncdjf3dM1h4IqiJ0qIe3JLUs4WDt+DuWwoDcwFB02qE0uRjFpQbW2TUZTYfSI+2cct2VRgWvksIFfqhH1xYvobf8+ElojkQCon/eMd1N09rCUK7zMujifT/YwTMd1eSXHbicU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735828412; c=relaxed/simple;
	bh=ZK6sXrMTFzzHJ4l50bv70crI9DGY/4/vZwoEtDIBk0M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=iDRp2nGUY8q37XsMtC/mKcyKZPMBKkG+eYVZ3PpbOYuzBzOAVJGvRtZPX0aEJwCL7+FzZLcKxfSiV/XD4jFW23zplCF1txnd9d6JaJZx4kX5wFWpMfgA1Q4Qn5KybyoiJyOKTgJMQzULBLoIt2eNpaQaPuPTWQV7jcQ8czIbDqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrnXevwU; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d3ecae02beso13950602a12.0
        for <linux-nfs@vger.kernel.org>; Thu, 02 Jan 2025 06:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735828409; x=1736433209; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zD9LX7qp9dfgTijeHjhY8FUa98fHPLIVwlX8qxng1tk=;
        b=mrnXevwUzkv/TYiN5MkQp8FsWRLNMq4IRdiPB4EuDsgMkKWz1xN+HfN1fxGTLlpBny
         8nTDxpZQqq92+4pr7wZ1shJTngQJsLrMzLnpHsYGBNKJTtKdhaJqmTx1zf9gIdb0x1W4
         TfWJfTWKxUEwi91ZeLotEyBkS5qYQHkO0YUPK/7ubGZSGOG0DFamTfp7Kk/kS8LQrGRk
         W7kXIzrg2py4Jcu8LV7nhmRlOr9EfSznu9E0Oe/rIgVfZZWjZDO+sT2/8xuW+2A+8xBg
         Zd4YsgAH9xmHEUWgHoxNF7cTRw3YKU0W0CRm+9ihmMV14bkUWlOM/IxMLaAZ1cqbSPE0
         Jqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735828409; x=1736433209;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zD9LX7qp9dfgTijeHjhY8FUa98fHPLIVwlX8qxng1tk=;
        b=bbEkekiUBiEyTwGCWyBXF8zycLw5YjPuvj2BdEi2oPUL5LU1jIbtGMOBaowLkVC7tF
         QF5pYNccfFgCRO2xxYsDPTttHH++ipdYBzsfba8PSehu+ht/kXcXpWSWc0g647RHjTBh
         E8UemauSogmW/f8IdckAbP5mvEg3H5zYU/5Hq8B7eX4co8EQ1dK/of0Cbc1Bnyuxbbs6
         GZJ7Woxd8lmdXcBUYQof7iRkvNZVFW51ok05h+4WjdJd0HCeZFHwQkPK+7WJ+Y6Shx0n
         s1/LLF9nbAxHNJU90YA4RD2pSUCJEP5Yme/0Hk5uvF/Ei+/XWX5/tI0q94kMITEYscXs
         moYg==
X-Gm-Message-State: AOJu0YwmeW7pHE9tVk2AwyWpM3RvwF9uxVxTNeNiuRXyByF2Ygix4pLX
	aOU22yUR3VGxkUOm4fqIvHqLDoj2KrMs3JO1QVONwlts4wEkaAPISSruTYpX+naQdrynDaxnx3R
	diyWtk3jJwOiSq/MbWRkOoqRft5BR1aIQYDk=
X-Gm-Gg: ASbGncvwTjFhKihVm7cSZUHeD3md147wXK0pGBTvdvKk+Dv/olYLGEg9mNhph3H44Tp
	Vqg0WOJFhX9PIiuQGvIfLxOcGA30Cy0waGbxaKQ==
X-Google-Smtp-Source: AGHT+IEodOYK4noGlDVvHtyM1NUydVwXOOIIXIYpLgw/vUN7H9pTcQvZq4qtlYcnJgq/RzffzRXYEJB/6GghvHgk5yw=
X-Received: by 2002:a05:6402:26d0:b0:5d2:7346:3ecb with SMTP id
 4fb4d7f45d1cf-5d81dd8afccmr39577426a12.12.1735828408821; Thu, 02 Jan 2025
 06:33:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Thu, 2 Jan 2025 15:32:52 +0100
Message-ID: <CALXu0UdnOg5KO7HS-tCCxqkWPDs5U4MRFqea69uSRyAC1wmqXA@mail.gmail.com>
Subject: Why is NFSv4.2 READ_PLUS off for RDMA transport?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Good afternoon!

Why is NFSv4.2 READ_PLUS off for RDMA transport?

fs/nfs/nfs4client.c has this code:
 1084  void nfs4_server_set_init_caps(struct nfs_server *server)
 1085  {
 1086          /* Set the basic capabilities */
...
 1090          if (server->nfs_client->cl_proto == XPRT_TRANSPORT_RDMA)
 1091                  server->caps &= ~NFS_CAP_READ_PLUS;

Why?

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

