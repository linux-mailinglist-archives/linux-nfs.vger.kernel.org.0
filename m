Return-Path: <linux-nfs+bounces-12348-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B13AD67A1
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jun 2025 08:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA3D03ACF19
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jun 2025 06:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868041EEA28;
	Thu, 12 Jun 2025 06:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="QYxji6OC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A471DFE20
	for <linux-nfs@vger.kernel.org>; Thu, 12 Jun 2025 06:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749708642; cv=none; b=uRnP+ELCSrHk2Xj+a6JA4vxPPw64YFt+cppKsLRsrxW80iL47uPDKyIOqjoC5LludSVrNY+K1pmdvcuOIhTtmceaapowbh63GOkqhyXNVFMt8OVmOsWM4FMBcWq7TEsAEnYCgAWjZdYymFlY+JT9o/8rxDwLDYl7sQ+pKD6+PLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749708642; c=relaxed/simple;
	bh=A4zc0EMiZ0JUl6RqVV9OyKZA1/ZylTuCgKp6RDdhuI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWdORIQpFgnFZW8uUvGylKCh3bjQdtlvTfuyieNHJPauEyHOMcfCYOdnxWeZpTty7PRR7seUlkSjzk41U+HGMmmJN1WKb1/tDGTuZUMRj1dt9GqPNY7k/Xths+Mf/yi1xUc6O68LB3wcqPhLz3PzA2RAQ10SsfgdT8/jn3Qdx7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=QYxji6OC; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7d09b0a5050so36239485a.3
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jun 2025 23:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1749708639; x=1750313439; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O0GS3Xn45yxp2jYxNXPognaFy6v44TiCH4udWlQ/Naw=;
        b=QYxji6OC7Ts5695m72aclbyPKpX52oS88+a2m4q0ycO4sAD5iULi/7ysEvXl7QAuuu
         YnaiHbM8z+42oVrvK5R1g4E8ZmSZeFBuTAZi1oDo00q8Sw48jiXdYmgNNI+9Q98aXvkE
         UODBjDBdrBxvC25L2X8Y5x0OmU62OCbfvTyOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749708639; x=1750313439;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O0GS3Xn45yxp2jYxNXPognaFy6v44TiCH4udWlQ/Naw=;
        b=ehrx9U9uXubomO6PbPl6gq/EuFS/MoAxM+tTOXIPxD45nUgFC1Uaf6r4jtNLExVR0B
         N5Y2+/N3VZEvCyNJt2UZW+EaRjft6d10shq+WZaM/eOdAyS/A3CNCAwwz9muY9h2puFY
         OmEiJka6r6CicCoN92mpjXzAOkJenBRaaiP8yAvmy305imeNXAakiKLYIMeZlOdukMKM
         F/qR2RgZ5CHSQvf7eAMuEV+FII+rXPiZH+ouNmfFh7KfAD2mPUNLfksQhD2AeUl2w8SH
         RcKN7m95EKJYxq1Lae3HhwY5BbFxw894aw7xNzbFLj65eWAbH+RD/04RWUEpTi5ZQxSh
         9F5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2bZ0c+4CIiRsVOj4AGMAyIN7YOthQGxZXMDt6fzwjz8vDUeSFnmfmOaQj4gaDca++wHaSSsn2kik=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBa6X9NoZIbboksuDzcfNgxgHomiMiqJtTEUTtu19MdNAIl3CU
	+XV8YWnbIoPqyCzXmw2u4hoSvkrlOdKPSOg8S70H8o2dyTiuT8zFZy8VoXItIOGP6QFZjkrwpoL
	ZlCgPKNtCyrKMGi0QN29sirk0GkqGBLNPl4rlE09+OQ==
X-Gm-Gg: ASbGnctJZFbh5/Be0T6RNRXdIAsuU+WxG7Gb+RzbLqdJj4N/VBktHK99ZdxP7ofc3Wh
	QrpgdmZ2LRgwGP68lB8Xd2NDgkCWWoSdnqPF3EzxGRtwmNjfVgEp6AKNH9QKMy2QVXhvZtLE610
	M6sAjGzYcMMkD2Xsh+9Rb4V3LpwGEK4kVkXDEgBf3BvRjb
X-Google-Smtp-Source: AGHT+IG8mJ6hovLPfrGSPVZZU8LTl3WPeV6J9EcHeo13rKs+RbYAbWrMSqN0W1KPVIpUi8ZQ5vNJpJ1Y0zewWcBaRQU=
X-Received: by 2002:a05:620a:27cf:b0:7d0:984a:d1b4 with SMTP id
 af79cd13be357-7d3b35ddb5cmr233276985a.17.1749708639529; Wed, 11 Jun 2025
 23:10:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611225848.1374929-1-neil@brown.name> <20250611225848.1374929-2-neil@brown.name>
 <20250611233842.GB1647736@ZenIV>
In-Reply-To: <20250611233842.GB1647736@ZenIV>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 12 Jun 2025 08:10:27 +0200
X-Gm-Features: AX0GCFtntii07X6oZYW-zPG_4E3lufAYRQgLIdh6AS0l6bl-_PMPPzxmVgXFsfY
Message-ID: <CAJfpeguiOZJ4dZU-mc0V8bwvWoJ-Q0JubYvYPpmr-f8uguF2LQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] VFS: change old_dir and new_dir in struct renamedata
 to dentrys
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: NeilBrown <neil@brown.name>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Kees Cook <kees@kernel.org>, 
	Joel Granados <joel.granados@kernel.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Steve French <smfrench@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, netfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, ecryptfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Jun 2025 at 01:38, Al Viro <viro@zeniv.linux.org.uk> wrote:

> Umm...  No objections, as long as overlayfs part is correct; it seems
> to be, but I hadn't checked every chunk there...

Overlayfs parts looks okay too.

A followup would be nice (e.g. make ovl_cleanup() take a dentry for
the directory as well, etc) so that there's no need to have local
variables for both the inode and dentry of the directory.

Thanks,
Miklos

