Return-Path: <linux-nfs+bounces-2631-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CCB8977AA
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Apr 2024 20:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4D40288C2A
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Apr 2024 18:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3767152DF9;
	Wed,  3 Apr 2024 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPjDA//e"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED5A29427
	for <linux-nfs@vger.kernel.org>; Wed,  3 Apr 2024 17:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712167195; cv=none; b=T4LqzHhZ35BVfcK+P86AXF9PmLtfZudv40uBOVz9l0b8eMiwpW+hwN+dbnDQdYaLROXbv5O+j+2KMSRbofqPChOAw37v+FYnrqYMvnbwZMpLoz42liRC6WpIZlA/slFmrhC2l1LZ0JFNAD08SZqgQCQJQ2QDkaWWQF1D5ZW0TUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712167195; c=relaxed/simple;
	bh=EnfQ7N2F/tzmP45r6603UvUh5C9ZfP+czFoWuhplxxE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=pnIEosXwvhOsu5l934EEQR07ZYGEO+7mLys2FisYI5z0LszCe9t37gLKZ/kBMphOp+NX/4sY7ivN38y8Rf21Sq/BH1tEVYRJrjoffQ1YfGbqDcrKBJ2R4u/KMxN3zF6N4Q78TvUVBcEY/Y4YltJhAcb5NxB7FxYoQ74wQJGO6ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPjDA//e; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-516c5c39437so120222e87.1
        for <linux-nfs@vger.kernel.org>; Wed, 03 Apr 2024 10:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712167192; x=1712771992; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R8fEqlqDOhxC2utxg7ry9l4oahEOF8pNGNnW5Bvf4Yo=;
        b=YPjDA//eCqDMUZVpUoC7Dw4kjF4QwKPCWhT8NgctJmbog/ee+upvWYtxqxp0+dfMBx
         Xg2eSV6soBpNxUg05dJAQkJl0ECpv18vClKJ+ig9yUcoO8gJoEp2deUCYvQ1RYrB2Nrx
         ZotagAsTta12CTEQTk0c5wKlm0PTCby7m2pWcov1WB64DQu1X6CfyWGwBoU+u9qHr7/s
         2JWNMTRp0rX2HWiTDWEDA1fjWjWbf/sDFXEiSguJmyf0h2BmvsI4Vz7Ui27JHDObo20B
         bBENgVe6Lx1z9pfZJ0LL/Apa6/fV+PyF/9ts9ijo8/0TA53tlHhRxzHYd0t+LfY4GFWi
         Q5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712167192; x=1712771992;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R8fEqlqDOhxC2utxg7ry9l4oahEOF8pNGNnW5Bvf4Yo=;
        b=uKPhrgAByI3IVuvkQRiz10gOySiZ9t1Ep7N7C32+faHANZLSJ7+7y45tCNWK7M143G
         iE3i3qYYsHH5cSStdsA5AdTPuq4oUdgDr/9vxvDZH6ICn0ruxHeqhhQc7osXwEBs5P2P
         f6LOO9ODULJbVnGQeUJ0yWnOybG6eKXg659rH+jkIkxvKDmQK+c63Zi3zJzqISewT96S
         RagxssylvHS95gI2bMT/jnP4tJFsytYBsqBpWfUXRNFPqYryt+oYRdMWuUPdsCT0wDvf
         r+NyL5jYME9c+EwFLKzSWCH13jqfvBTnuWY8yez4zmMewh/dHxvM0wE9PnMu46pdSJ7z
         sQnw==
X-Gm-Message-State: AOJu0Yx+iNqTaeoDYfBeKO7YlMh951+O05Dsys7zYfa+Zi808Uub6srT
	mdwujHtsaNOQ2N3hbFYVFLQd0dNFHIrwKjk5WqymFcIAvwc3lCQiCTmgPdwMhAHzTSW7rStgu9E
	CrL2R+Ox1leHCcQ8bste6BQ5UmOReSHWH
X-Google-Smtp-Source: AGHT+IFPf8BVLMrbBPSniktWiDHhcE/Wckt65hlrHc9flkhn1jSP90WAZIeGg0DRkG/qrgw7VEd5VjhWHC1xTB4g5Hg=
X-Received: by 2002:a05:6512:547:b0:513:d381:65d6 with SMTP id
 h7-20020a056512054700b00513d38165d6mr169908lfl.17.1712167192030; Wed, 03 Apr
 2024 10:59:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Wed, 3 Apr 2024 19:59:16 +0200
Message-ID: <CALXu0UfExxAtoqnFUYbMG=Mpwc0HU3qtb0vuiygXLf6bt=4AaA@mail.gmail.com>
Subject: Linux NFSv4.1 client with Linux NFSv4.1 server, getting block size of
 exported filesystem?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Good evening!

Assuming a Linux 6.6 NFSv4.1 client and a Linux 6.6 NFSv4.1 server,
can the NFSv4.1 client obtain the exact block size of the exported
filesystem (e.g. ReiserFS, btrfs, ext4, ...) via fstatat()/stat()?

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

