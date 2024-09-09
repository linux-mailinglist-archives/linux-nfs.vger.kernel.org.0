Return-Path: <linux-nfs+bounces-6354-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F46697214A
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 19:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AEA01F260C9
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 17:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6EA1741EF;
	Mon,  9 Sep 2024 17:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kh6nMD+e"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459CC16F0E8
	for <linux-nfs@vger.kernel.org>; Mon,  9 Sep 2024 17:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725904023; cv=none; b=bNqTjNSxU3YK7j8oNgnvwAjT1pZ8Bl8jVwMGwR/MrnrB//J4O/oanv3LhmjL/eTFe6w4i1z/W0wSDFMLmBnv7JNCeFrSMVuosoS5AEO9A7Ll5x8xUG2QiQLzfZOkjreBh8QT7pRuptjR46nqnjm5crtxZudmQIQzB6vb611rDyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725904023; c=relaxed/simple;
	bh=Gj0uwNKEM5tjvwAW8Z2u/i7BRSWF4hNtOwS7OXsWi4g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a7Pd6bTcYKlikad8d4JtitLTC7EHdCV1aTOn2UShWXJxjOgX/ucgPWuZzchHPpUstmSdJmqdRImv0yA6OJ+mOnk1tu48MIvJy2pQ84cUayIHHeaIQIyEw2J5AiGceCybNDiW+l1Zet8n0WAzdrFkrtdfAU9lRhveQibT88fB2cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ovt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kh6nMD+e; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ovt.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2d876431c4aso4846326a91.0
        for <linux-nfs@vger.kernel.org>; Mon, 09 Sep 2024 10:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725904021; x=1726508821; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4UFCN+OBjYvXcl6IvxEv77iqHbcWMYYV9m8ZXJsZubM=;
        b=kh6nMD+ek3cnDKJbq9oV+ziXCL4Q7xQahqGZETPZuGeXxPEKW0rwIcHzY51cds7Psn
         kmRcKsBnH2X8VIdQWFNCMR0IK0zp46ut5OGBKReYHYYHLNYZMhxJPQnfywDucQNvg2Ka
         Wg43w/xj+eXbCLASaQlnU4cYykdEDu/3YdKtk9WRGFUuKiL8NH139pA6WXJ5aYBdRPmp
         zGWntsE/B/jObt888WIBeWIEYm3D9EeMTRZcPBmB5cFl/ytCnRNqY0qF05Pe4nz1Ktv9
         +O5m1J+PwA1ERpaoWfxTQ5Ave4+sVAQxw5ETtzczr5Dr/fFnp5+j2NerUOnLJy08bt43
         yQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725904021; x=1726508821;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4UFCN+OBjYvXcl6IvxEv77iqHbcWMYYV9m8ZXJsZubM=;
        b=mJplxm9a+92k2Be2W+1HWJ4vOY6A7/ELPu77+6gm7ChWRljLZO+pvO7WTCRGyXE7k/
         /4Bq+Hf5oDPJAP66qR+br7uwFGLnW/29YZIsKWPCqHGGNhbPbuXsCVvde2y4kL9bufAk
         OmziZYpEhVpRSfEnRV+avBE7wtw+80uZYHjHjms4YYQsFXo8f+arJaxFaFtQouNVcmCC
         xF+MEIRBLrfgd1rzXz5IuryiC1OtBR8z3NNYFr6b83j+DtqKPJs+fCFRAd5to8QAg9z1
         rbEYG0we9hp4XpTyo7jaRju92B0dUe0MGMajtVt9m37sRbCyrV9udslm31TQJrRXCHpl
         OYIw==
X-Forwarded-Encrypted: i=1; AJvYcCUF/WNTJyLrnT9a9A+k4z9rwjbnbRqATXa393bqo9XYxqLpRCCcBKxIaJjvP4vgc5jo5nztHbMFkjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwloUbLCWhateUo9LKU7GsuNmp/lo6DjcwQUIRi81rbQ8zKS6Ll
	yAMCD0oIx+yYF4GVqmoVgunjdBZPyih+Vzfdko21h5c27nsRUYDe7yNzcFpXT+eahQ==
X-Google-Smtp-Source: AGHT+IGxW+ZKzsuJWtCDZr+gEy4pvLGcgVQaVBtzH9PxxuBHg4PvlC0/sMrPC1YDKXJS+mhG/tayuao=
X-Received: from hmarynka.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1148])
 (user=ovt job=sendgmr) by 2002:a17:90b:384c:b0:2d8:a73a:b87d with SMTP id
 98e67ed59e1d1-2dad510c2d0mr26182a91.7.1725904021318; Mon, 09 Sep 2024
 10:47:01 -0700 (PDT)
Date: Mon,  9 Sep 2024 17:46:59 +0000
In-Reply-To: <8f2e20f2fc894398da371517c6c8111aba072fb1.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <8f2e20f2fc894398da371517c6c8111aba072fb1.camel@kernel.org>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240909174659.2163601-1-ovt@google.com>
Subject: [PATCH] NFSv4: fix a mount deadlock in NFS v4.1 client
From: Oleksandr Tymoshenko <ovt@google.com>
To: trondmy@kernel.org
Cc: anna@kernel.org, jbongio@google.com, linux-nfs@vger.kernel.org, 
	ovt@google.com, stable@vger.kernel.org, gonzo@bluezbox.com
Content-Type: text/plain; charset="UTF-8"

>> nfs41_init_clientid does not signal a failure condition from
>> nfs4_proc_exchange_id and nfs4_proc_create_session to a client which
>> may
>> lead to mount syscall indefinitely blocked in the following stack

> NACK. This will break all sorts of recovery scenarios, because it
> doesn't distinguish between an initial 'mount' and a server reboot
> recovery situation.
> Even in the case where we are in the initial mount, it also doesn't
> distinguish between transient errors such as NFS4ERR_DELAY or reboot
> errors such as NFS4ERR_STALE_CLIENTID, etc.

> Exactly what is the scenario that is causing your hang? Let's try to
> address that with a more targeted fix.

(re-sending with the correct subject, previous mistake was due to my tools failure)

The scenario is as follows: there are several NFS servers and several
production machines with multiple NFS mounts. This is a containerized
multi-tennant workflow so every tennant gets its own NFS mount to access their
data. At some point nfs41_init_clientid fails in the initial mount.nfs call
and all subsequent mount.nfs calls just hang in nfs_wait_client_init_complete
until the original one, where nfs4_proc_exchange_id has failed, is killed.

The cause of the nfs41_init_clientid failure in the production case is a timeout.
The following error message is observed in logs:
  NFS: state manager: lease expired failed on NFSv4 server <ip> with error 110


