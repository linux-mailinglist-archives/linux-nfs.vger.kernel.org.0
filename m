Return-Path: <linux-nfs+bounces-11289-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA46A9D93A
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Apr 2025 10:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFD724C046A
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Apr 2025 08:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8A221884A;
	Sat, 26 Apr 2025 08:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Saz8uESQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DFF1922D4
	for <linux-nfs@vger.kernel.org>; Sat, 26 Apr 2025 08:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745655163; cv=none; b=u5X3WPGSn/WWzCLevHYVPzxEBF7yVvEAoiqGiuMJOHyXHqAqg9NqTjN9XcnOqVYaOs2cnpb4+0Xtx1VQhgIDj6StKAdBaG8Z1nKEqKPvsuUtd5kl3xaALkZJL6mffXn0V8MDkzF2/cnfExIJ8QL0Gl7yJRC+64CLUbgWgI7tL+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745655163; c=relaxed/simple;
	bh=kocRxf9yEOEtTP+ZkM8kf273S/lbmABjzi2b89wIwWY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tqcSOSHpA0f80Z8+6am7wn+jbealtIrCKuJV0V4KdG4YMZV84sneJwuMp5VFyJRjeVdQBp2eDOeousYH9R7e49VTaGRg9KH9Wyxo2OYZcQfcnxHgpsq7TuSHYrf25gnLjJ1CSqnDVob7+hB8VIWeIc/2tFWoNqt3xLrtgR9NYmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Saz8uESQ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39c0e0bc733so2749911f8f.1
        for <linux-nfs@vger.kernel.org>; Sat, 26 Apr 2025 01:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745655160; x=1746259960; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ywLURDenPX0lIljZmfn/f7yli6vSUHStcK1oLhUId+c=;
        b=Saz8uESQ6F3lZINXU07mk1xoKUqP+cT2Hc2/+3Kyg2+2/YAbS5SLQsi4WTCf/OEUqT
         P9z/IgzaXjBpLdB+gXeZAaSIzVQtgkAxQw7cyzfHdluGeQRZF+eAzKPiyVXbZO78lHc4
         Q7VhCotbMQ3e7TQXpYHJDYvYTqP6lyfvfALwvgYi4nOZEjbnLj1M72jLaFjzwFx5IWZW
         fBq3eEulEfCWc/0NaBwEPX+wl4CuDRNHOM48sHPyJgOZ/LK7/ye1J82roA3776lPpfrR
         c8ot123FmEMitHrKSodMftR2te3qx55sv4M6v82kMfcuX4Br+q9cOigPtEG+/TJJbCOx
         i+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745655160; x=1746259960;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ywLURDenPX0lIljZmfn/f7yli6vSUHStcK1oLhUId+c=;
        b=rXnJSQfz3KbVnBweLmDBkQ6ZIEj+IxQgQSc7oxlq+OujbHke3BJp5Aub04aC5T046N
         g0nMgB+1RHtzaKRhQ692qkuNLYd7wMjO3igS+T2zk4yUS07prd5av2VQ0QhlUZI7hJao
         mpxxCz0rewmbevHn4slGSXq4yDMMOc/HCJNzjzqHJXi3ZWYsLfh0LUtl/E1zHMsUehd6
         t31GC6l8e02AKwsytB3Npc0BSljxn4SQyKyxyj1ds2fJVo7jNa9IaG3mMCF9L8qHTLFm
         Wc81DEwmqfh9aFII35WGUdzZ+IGtLjssoiBCT7ZCkgmDCIroyPW8pBCNqkPmuKa6Tbib
         Q+jg==
X-Gm-Message-State: AOJu0YwhcgHfk00EU9ILOp3osCEgf4QmG+MVp6HNCg61iBBR6ffWHPaJ
	YUE4RQz8U1qziMsCURlZqvAIGEVZUGxA/GdiP2Sp3xn++mTOiefL
X-Gm-Gg: ASbGncuBaDzy2q522Q56T+a0D/oVVVt918kj1/pfvWmgUDCmtPsJNRkgPKzXvt/QF4q
	FTqKpLIOl2fVOXOPLu7hBxdyjHOU2QTRr+eIXm9CFd6RktFpRv69hr7Ff0OX/Jr+csxtvy0Ledj
	QhxezgHbssxo0R2+P0RkpP2/hC0jTVJXEpSOv+O7Xz3QlDm9aD0F62OKMSWyHFqIBw3vfcBp+2U
	YfKY+6ugBqdpOoxrGg4WUn9lueoaocRyvev4fBQMBGhd+dsq97xktbPYCWr86mhzIJWcOV2uhiY
	7FILwzWYuJLZG4I6DWjM9E7TkpoScgiEYt7WhxKk4czk7yI0Fg7+o0KHFhRlVrGkrte8Gj0caA=
	=
X-Google-Smtp-Source: AGHT+IEWcbF8ozzE6QrdCUmn9y5GiBMURdxglV+u3KSDqGsetouEt+rGFJonyHaP5Zgn7RdZkp5klw==
X-Received: by 2002:a5d:598c:0:b0:391:2c67:798f with SMTP id ffacd0b85a97d-3a07ab8176emr1486136f8f.41.1745655160240;
        Sat, 26 Apr 2025 01:12:40 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073ca5473sm4751416f8f.31.2025.04.26.01.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 01:12:38 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 75DF7BE2DE0; Sat, 26 Apr 2025 10:12:37 +0200 (CEST)
Date: Sat, 26 Apr 2025 10:12:37 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Steve Dickson <steved@redhat.com>
Subject: nfsdctl: lockd configuration failure reported after updating to
 nfs-utils-2.8.3
Message-ID: <aAyVdfJT4uMUeA6s@eldamar.lan>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi

After updating in Debian nfs-utils to 2.8.3, a systemctl status
nfs-server.service shows:

nfsdctl: lockd configuration failure

For reproducing the case the nfs.conf is kept to the default
(commented) section. 

In Debian we do not use the system linux/lockd_netlink.h (where the
changes only seem to have merged upstream in 6.15-rc1) and use the
shipped copy in nfs-utils instead.

I do not see problems with mounts, so I suspect the problem a user
reported downstream in https://bugs.debian.org/1104096 is just
cosmetical?

nfsdctl nlm reports:

nfsdctl: nfsd not found

Regards,
Salvatore

