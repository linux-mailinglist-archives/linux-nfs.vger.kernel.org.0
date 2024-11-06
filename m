Return-Path: <linux-nfs+bounces-7720-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A298C9BF15F
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Nov 2024 16:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 330491F2225D
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Nov 2024 15:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AB71DFE3B;
	Wed,  6 Nov 2024 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcvyDC3J"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF7820127C;
	Wed,  6 Nov 2024 15:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730906236; cv=none; b=NqdFwL+4QNQvRV9i+gDvX0JISaSgPxm8TOHOEfc+PusEUQL1etHQu4hwrmHbTNFTW0cR3Ha86+zVSZTMpsRPPrbI+4ppXr9tAYobOSgbTuynX8tPAGSZFEfDOsgKg963oxQPUJtoPRpncqC7pQW4TdebuxavX+n42EzvY9/CY0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730906236; c=relaxed/simple;
	bh=S95d1DVGhFgHevrHa/QaulBHO7dmWGDwrOgPRxWXnoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Aj/T9YTPXpgkmCmqQPqnkazUH+KK/ky9nPlgHtAjz2lA88Pjez/xjsikS6Ogz1sz+DGTPXQjqUfYz0Ktv9uKsBLbFmMRYHfl53Bl1sMH/g6ob4WBiOLd2R1oHxT7QfRMeE8rloKH0Pd95Ksff3VWXfGS+L5CwqRn32iXiIczz6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcvyDC3J; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7aa086b077so876545666b.0;
        Wed, 06 Nov 2024 07:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730906233; x=1731511033; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S95d1DVGhFgHevrHa/QaulBHO7dmWGDwrOgPRxWXnoQ=;
        b=jcvyDC3J8VMWsE9ugGrPJoH7hEUJwmbNIe6tEUtiafqCQVN7Qm/vL9LhKqH23PKu/k
         1TU0rNcCjtg0xfmYBmo32rMqEopZGIQaYwHbUCyMe3TwiWxl8pRpaBTn1g4C1dxH40we
         43gG1a9OdPpDDDMeAVznGZ/b032tKdJTGN+TJacu9h/fuMECGxzZRcECijTCynbZunNJ
         BKFQK22P+9mWfpxtwZPRwp11G1uGZEPMzQd4NnUtJNms64RyxqZLMOLi8f0SkuECofdn
         jUHop6/PvfZ0h6hCu5/+mC4dQMBz6i7RHr9MBAiXXkz7u1lhHCkRqh+o5OXNC5dCdPA/
         oezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730906233; x=1731511033;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S95d1DVGhFgHevrHa/QaulBHO7dmWGDwrOgPRxWXnoQ=;
        b=U00AKLLBHEDA4uc03Wa/xtzJCY39Z7mhLSpF1oCC0jPR2dwMDKgPxdOcAYV9tAt0u4
         J2waCM+pHj3LaAKv9OJCiUXbt3li6fCvhNPKygogDKG+KHujqJHQTelibh3Wa4tt3Krx
         1gFlrzQgrWT83Uchn2JYixE/4Vn0WcYPkaZ5ATgM26/SJgkuudHH2STgF2qjeUbm4U9r
         5GrwUn4UtkWlkAg6p/09xrLpmkxaucEhcuBuQIiIPy9JYjiNp1doZ0kCYfQjlSAqji3o
         E1arWngY9/Coldx/qiic4W1C0RucTHpExtit/l1LpTXrYCTlyDpJoMSCFiujfb7WJHJb
         32ng==
X-Forwarded-Encrypted: i=1; AJvYcCWH0O1hth1Bc3UexhCnxrxl8cZpaKKH5KTtIdy9oCNsK13Hswas7wDRmDyplC5AQW65P/ehvvVolTSNoPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuWozPCdjJNGiW0RDwh87zFGjxQ+QBKSXgmsfQ7nQP6DVzjeqv
	vgfcWyLpDOLcXsDSA/CItNBxCoF7Mi0l8XV+xhKZjCur0qbc/zmjS/wuGdu+MsgoNTtXFcVZear
	wwX2hGhIvPECY+LIeOQs5THLVyrxCj46p
X-Google-Smtp-Source: AGHT+IHr44bjMjzGKzBJEYC3WA2Fb4CY7pBUnFZZAYKHoMYadxN7NXQbnXhIpjXlKlqQLFvzD5GEGF4NZ1YUJey2y5U=
X-Received: by 2002:a17:907:3e99:b0:a99:fb10:1285 with SMTP id
 a640c23a62f3a-a9e3a5a0e19mr2901369366b.20.1730906232637; Wed, 06 Nov 2024
 07:17:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030-bcwide-v3-0-c2df49a26c45@kernel.org>
In-Reply-To: <20241030-bcwide-v3-0-c2df49a26c45@kernel.org>
From: Sebastian Feld <sebastian.n.feld@gmail.com>
Date: Wed, 6 Nov 2024 16:16:35 +0100
Message-ID: <CAHnbEGJWtRgPHSRMqEVDgRhvYHeqcHEKxeY=B2mD3W_YjR6zpA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] nfsd: allow the use of multiple backchannel slots
To: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 3:50=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> A few more minor updates to the set to fix some small-ish bugs, and do a
> bit of cleanup. This seems to test OK for me so far.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Changes in v3:
> - add patch to convert se_flags to single se_dead bool
> - fix off-by-one bug in handling of NFSD_BC_SLOT_TABLE_MAX
> - don't reject target highest slot value of 0
> - Link to v2: https://lore.kernel.org/r/20241029-bcwide-v2-1-e9010b6ef55d=
@kernel.org
>
> Changes in v2:
> - take cl_lock when fetching fields from session to be encoded
> - use fls() instead of bespoke highest_unset_index()
> - rename variables in several functions with more descriptive names
> - clamp limit of for loop in update_cb_slot_table()
> - re-add missing rpc_wake_up_queued_task() call
> - fix slotid check in decode_cb_sequence4resok()
> - add new per-session spinlock
>

What does a NFSv4.1 client need to do to be compatible with this change?

Sebi
--=20
Sebastian Feld - IT secruity expert

