Return-Path: <linux-nfs+bounces-2669-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C652899FB2
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Apr 2024 16:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4ADBB233CC
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Apr 2024 14:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DB916EBE4;
	Fri,  5 Apr 2024 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyTyDWPN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6B716EBF2
	for <linux-nfs@vger.kernel.org>; Fri,  5 Apr 2024 14:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712327397; cv=none; b=sKE1phoyOYkphdb1/gG5LiiIP7xrDDiwSdyd39bY17nlj8nWI4wVjbEjdtDbJGCfHaj9sNrouvPpBSymnhEiVu+pi7R7wDqU//Z4uUYjJohZLlLKRItNvJkZLR5TUsXdn/y4yUA66ZUBXcwh368WkVBZ9u8EnMymJkR/LD3JCKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712327397; c=relaxed/simple;
	bh=cc0vdwoF/QVCKbHQr1lQbzIc/dNK+3Gz6YukFE6VU+I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=FBpYGreeZtOOfd1HgFpQqWz6Upg8YKhSyYghWMJK8HaM9jPjX8jXeAwJaZRk1GnM87Q/f/yClE8G9xDml2AvQl8hKm3B7Wz8dTwBhnfsMehhDqqnaqh1meJZTxrTakaf3UUhApfqP02HgsZsQ3TLyOgvMufoNlvyI89Ms5Ntc28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyTyDWPN; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-516c403c2e4so2159393e87.0
        for <linux-nfs@vger.kernel.org>; Fri, 05 Apr 2024 07:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712327392; x=1712932192; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cc0vdwoF/QVCKbHQr1lQbzIc/dNK+3Gz6YukFE6VU+I=;
        b=QyTyDWPNTihczbhs1vU0nsGskxkiyDRrV4qb5CYPlStrpQkof46JV6N19wztoBnOAy
         OFZ2wyQXcVyDLuQhTQtPlMabmE28ZIkrr8XvE5DvTsvWgDFG5S0LWZ5jEKPL2ptLKJqI
         nlYnjdbTOpR4qqenkQaFu0U5gAICWPDNg0q4ntd8WK+QlnvA+9rHsgkw58yr+KB0W5/z
         ix+VS75inDEeIEOLxYaeasjJUX96n1dQE1aVHrqu8xZhca87exKeLteeGU3uHiGbfFgG
         AkymP3oHdU5+tVFqpaxJdXRNJzysVWGornFwrty4lbRaFmwC4WbF+S7Zk2n1+CqD1/tG
         hWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712327392; x=1712932192;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cc0vdwoF/QVCKbHQr1lQbzIc/dNK+3Gz6YukFE6VU+I=;
        b=QaPHaj/8S+4xpG+aXtiXDuS2b8XCJukgZGXQEVsY+Xk85B9KfyAjcAX009gyc/2qq/
         jiulkAmZCjRF5Ramm0DyJiWJGfFsYSEJ3xbz3lgORjeK3B5JUp2pOz0Ieew37BSv3O/2
         XOyaI2AAaofUa3yNk4SjIXM7lRuNmrK59FWPkAsIDh5AjAmHRRaNc98RGTv3rxSTJRob
         xB6AgM8m7jIuYJ13Lk/2EdDwaFMF5f4SK2o6LpYKSd61i9TWWsRPbnEXk1rvag6nC0Ll
         7iYtRLBwVfCJXw3uhOR65MM1AiUODDJON+/tDip2E9BbhMGQeSzVUi9YVF1lgHKC3cw5
         qhyg==
X-Gm-Message-State: AOJu0YzfqR6kdnkMIHcWpZ9Ocl+OxRmhP4KOxLjBhXubGD8ORNs3iw64
	yYOGLSP+X9Ds9tysExnwCCbgiHridTMGuePSIhewo2/twrVe7NBGlmKY/+D8TNwYxFdM8Z6j6jy
	YQZF30c4nK9vgX2p50MTH7PfEHM2vue3Rhhc=
X-Google-Smtp-Source: AGHT+IH3cd6rpja2w6Q9AvM+0JS32weU/Pa4DK5U80BmlDOpZI/ULmkeqhAb6lk4OwyXjSq3Svp8T19bjQq+VG0sxsk=
X-Received: by 2002:ac2:5629:0:b0:516:d255:af2c with SMTP id
 b9-20020ac25629000000b00516d255af2cmr966356lff.13.1712327391998; Fri, 05 Apr
 2024 07:29:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Matt Turner <mattst88@gmail.com>
Date: Fri, 5 Apr 2024 10:29:38 -0400
Message-ID: <CAEdQ38GJgxponxNxkcv+t8mhwRPzOjan58MTBgOL8p9tY=rvTw@mail.gmail.com>
Subject: nfs-utils' .service files not usable with nfsv4-server.service
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Downstream bug: https://bugs.gentoo.org/928526

In Gentoo we allow disabling NFSv3 support, which entails nothing more
than not installing `nfs-server.service`. This has uncovered an issue
that many .service files reference `nfs-server.service` explicitly,
making them unusable with `nfsv4-server.service`.

> server ~ # grep nfs-server.service $(qlist nfs-utils | grep service)
> /usr/lib/systemd/system/rpc-statd-notify.service:After=nfs-server.service
> /usr/lib/systemd/system/nfs-mountd.service:BindsTo=nfs-server.service
> /usr/lib/systemd/system/rpc-svcgssd.service:PartOf=nfs-server.service
> /usr/lib/systemd/system/fsidd.service:Before=nfs-mountd.service nfs-server.service
> /usr/lib/systemd/system/fsidd.service:RequiredBy=nfs-mountd.service nfs-server.service
> /usr/lib/systemd/system/nfs-idmapd.service:BindsTo=nfs-server.service

The only service file that depends on nfsv4-server is nfsv4-exportd:

> server ~ # grep nfsv4-server.service $(qlist nfs-utils | grep service)
> /usr/lib/systemd/system/nfsv4-exportd.service:BindsTo=nfsv4-server.service

How should `nfsv4-server.service` be used?

Thanks,
Matt

