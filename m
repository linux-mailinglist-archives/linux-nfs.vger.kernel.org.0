Return-Path: <linux-nfs+bounces-7507-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A2A9B12F8
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Oct 2024 00:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2729282EF2
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Oct 2024 22:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D711AB536;
	Fri, 25 Oct 2024 22:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYjTqXwd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D34217F27
	for <linux-nfs@vger.kernel.org>; Fri, 25 Oct 2024 22:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729896451; cv=none; b=ZMqMNgI9yf0g5CA8OtCl9qt14rqEU1Qsz1a0ggwUxHZRjaOBBSpfxge7GVmzd34MszOV53sqnIy74LRUHD8jqtAuUdgZd25x33/obtF3cUPA9+L8FQA6eXOhexuuDZWoAFAtoo55pDaTcCr106p++Fm4RQF2S+myopK2HFfjwio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729896451; c=relaxed/simple;
	bh=fjOjHgIcwEZo3YErAQy+EZFgL4PXs4Rwe+nnPldqWBA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ZSSNAldJKEitL1eXdYDqYw/urd396kJVnMlDVBX3r+v8GRGyMCop14LLJxdLQn860jYlgpRVf5w2K7udEL6JktjLPHtS5aR2cxZI5jVuWkfQRxj2ZyTPw9CdRsoLrxKYNGk024Iogr4thQiSpCdursmHUdJR1d4rAaqxGAULdd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYjTqXwd; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c935d99dc5so3002663a12.1
        for <linux-nfs@vger.kernel.org>; Fri, 25 Oct 2024 15:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729896448; x=1730501248; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=58IW3zy0i1Z/WJCBZuyLCDZbNvYR62JfAjBJehckpRg=;
        b=BYjTqXwdq1qzttfYFVqrrLCjz2y4O0oUfujOt2YtQWcN9JFJMq1fjg7lIObkU+9wSJ
         rFgdyQ0vPIQ7Gir26jhX6V/s8r7rnPGMmbI4V6I3svnDlsnNQ1pOuiH8sPeHuY1Oc1PZ
         bUlvedixQs9ZhaKoauPBNT5xMaYTGPAFo19GjEgW/Rf2NKpSBktKBBCVU7G0rj6xXqMj
         tD7UPtNi254+Iw4BkPMMxoRz81RX5Kug5Cu4uoFKREiMWxbn2f+LBRpJjuhecOfnn3Xd
         kAZGZJu7w5EYZTKJ3GXISgsx1hFfwtjTaPXcfDprscLzMGgedW9mRSBQ5SUhxgI3IBtJ
         FuHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729896448; x=1730501248;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=58IW3zy0i1Z/WJCBZuyLCDZbNvYR62JfAjBJehckpRg=;
        b=i/yQ6GL8wD7y1XhLGeeErGCwercBwB9xd0K2SRvDdkC3dZTdUx4W10nhP9BKxEALpx
         PkcG71QBk5so4LSnqFoamlKL+eKCY1IFhs2pVZovM+obATbVQA9Ci774Fz+bfAZrOF7s
         voR1AmDCA2LvcgnF4uQfFEBZmIylYpk6bjrql8OTB+fJWsVZ3g7mfnhQ5Weh9NF+Uc+B
         d1riVj4rp2gq6mSJ+/gRfHblWH3KPw1M7ofJw36bIHDHGYZgob3b47yKoWb9QVmWwINc
         iCvcSAEQib623ykdiPV57DVRi+rrD4fNDuA+iA68KcF438uoLFXyS8OKqySOYwlxOr2s
         y2uw==
X-Gm-Message-State: AOJu0YxQ467aQ1uFx7nQLA4TD5PrlXYWPJXZBptgEwqD2HbbF0/lIx3K
	4S5RQrHi32iOYHHZJ0dW+pGeT3pJz2cHjNPn9TVQtUEIjiBPGHAPsbQSSFINhwvhnuzDn9WcrLb
	qtaCVdGCDniIlf+xeCpKh5TFysLCLTURHCw==
X-Google-Smtp-Source: AGHT+IHlDfF+n9cwxMcl4D1y8T2RI6GrZEe/b3VkjMU+1KYNc1kVPWn4FoUSuyEyRMEmaFSLMdVQ1vr+cmwEtJbhN8E=
X-Received: by 2002:a05:6402:4312:b0:5c5:b90a:5b78 with SMTP id
 4fb4d7f45d1cf-5cbbf879525mr639540a12.5.1729896447596; Fri, 25 Oct 2024
 15:47:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rick Macklem <rick.macklem@gmail.com>
Date: Fri, 25 Oct 2024 15:47:17 -0700
Message-ID: <CAM5tNy4RY-vMZU5zP=-X4F9ahPYHbAAyLkWKBbJc01jB_LD2jA@mail.gmail.com>
Subject: posting POSIX draft ACL patches
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

So, I've finally figured out how to use git format-patch. It took
me a lot of tries before I discovered all you do is specify "master.."
to make it work. (I still haven't tried to email them via gmail, but
I've found the doc for that.)

At this point, the patches are still in need of testing (I have yet to
test the nfsd case where file object creation specifies a POSIX draft
ACL, since neither FreeBSD nor Linux clients do that.)

Is it time to post the patch sets for others to try or should I wait a while?

A couple of questions...
The patches currently have a lot of dprintk()s I used for testing.
Should those be removed before posting or left in for now?

They are currently based on linux-6.11.0-rc6 (linux-next of a few
weeks ago). What do you guys do w.r.t. rebasing them?

There are three sets: common, client and server (common is
needed by both the others.
The other two sets implement client and server side for handling
the new attributes proposed in
https://datatracker.ietf.org/doc/draft-rmacklem-nfsv4-posix-acls/

Thanks in advance for any help, rick
ps: The problem I thought I had w.r.t. server side large ACLs does
      not appear to be a problem. It also appears that the nfsd always
       sets up a scratch buffer, so the server code doesn't do that, either.

