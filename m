Return-Path: <linux-nfs+bounces-17947-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD76D27B8B
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 19:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44567316062E
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 18:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1536D3C009F;
	Thu, 15 Jan 2026 18:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRqy9Oiq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A223B8D5F
	for <linux-nfs@vger.kernel.org>; Thu, 15 Jan 2026 18:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768501072; cv=pass; b=Y22PPLBYuC5OWd1MUfJJ0T/HxxYoXOFFWOKAwpwuXGhmlp3SzkA2hjmUf5jvn3PjNvK9QNEXsa5S83ELrby7xuUtgK27bAXOh8cvzDq+THvCRo/6wUVGyocKEEMUBpEDP6ecYuOmF1ITuS4vdJhppoRDLVveH4q2G/oB65jU4Mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768501072; c=relaxed/simple;
	bh=lrPbqnzgCOvE5NgsFSOuHcaOEuIUQeGDqGbHFIodw8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PuQ9SjB7LfQ/4++r7AR/FL/J2CSexQ6uebNLlM4wOfDXygMyNG9iLGAUwL9s21BiJ88ODyvfU7v1SdoT2doSMNGoVIYxIOdNhTss/Ca07QL4yvwKOxeFFTB+sbAjkRIfyY1jNR4OpxSUI7a5MhlOxoU+NKGNMhWXc6d3Nda8klQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRqy9Oiq; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64b9230f564so1674493a12.1
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jan 2026 10:17:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768501067; cv=none;
        d=google.com; s=arc-20240605;
        b=HDRIuW82kzGNedEg1kKSHfFfDvlrCXIG8iHBRJucgnfk/xFSa+7hRhGN1Smky7w5K6
         5NW5hG4ZKCCM55v6dYXzRFeyjEZmLWbXfps9/jBhpD8LocY4BChRmVLQIoyFW5NQq+bQ
         JgtKohGh+BAJJNQ20BC3iHw8I5TxdShrRmYYtWf4fcBTjp51sFDczvPXDniCKc0NI3f2
         vjQ+SmNp+tAr7Fzir/4gJhZxrRER3alqCb81wurv/bvLNE3USwgHbV0m7yj0tO31iVfN
         B7aN8DGiiEYz2ad4jZMw+OEY2Q+L9a9CW0lJANR9UdVUGaEUfCpljbbvepi6O+YWW2hF
         ALtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lrPbqnzgCOvE5NgsFSOuHcaOEuIUQeGDqGbHFIodw8A=;
        fh=toL6dI6ExlYXxuKXeP1Ll81sp6Q+7eG5CRmdYEgxV1k=;
        b=PrihinS4mnUbM0GpKkH9KynWHJqrWP6wDUbvNnPEdwlLJaUuiz1YH3PTaajxgmmIDL
         gY1u+p5rtzeea/xt73xrQU6Qr6g/muhzl/0SQLCh2O3yaP2rSutY/+GjQZgrMnaxU55s
         TbLQgFhDUFZVwt+Scvg8hojOhDCLpj/S+M/PFr4L/ShqHhP8k8SsndakE/Mgl5zjzxYl
         l7B2oCYQkTiQSl6ATUG4d6OE+v+vclQFZMgdP09fnr+4LoKPVkKn1/RqERLwmFhsJ6h1
         yUw0j/bfH1EerG4OO/xLRpKJr2BCzAoeaCicDpxjFth9+E2ZXGwXV/19ntkuFzLs6R8p
         L+RA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768501067; x=1769105867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrPbqnzgCOvE5NgsFSOuHcaOEuIUQeGDqGbHFIodw8A=;
        b=JRqy9OiqbHt3NQq3XCkGStTAlcxglCMEMq+vkPdztBR4c+MkrffxyXlppZJ7bL4sv3
         +FXHo4WCeS6ifCEJXW+UdjZqdayxLi0mNMYJfj32IOulawR+3uE9C6Ut2x3X5eVTlY8+
         6iRo29sMNevgrrtfjtiRzEF0k4plHYlK2kgxZb4KZPdGjfbpVgT/wXn6hxIwTOtPADbq
         2v6VOk25RJEEoHnf4r5a+RfNediJCsI/4TTnPiMJgJQLHdyofqjBzPnr34u+fCoLT989
         FV5CVbIQ4AFknrnsxqTVaClS78Bq+9klbvidUC90tZ/EK9JmXeohHKVG3ipODkA8GlnY
         LSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768501067; x=1769105867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lrPbqnzgCOvE5NgsFSOuHcaOEuIUQeGDqGbHFIodw8A=;
        b=gpu6yafwqr6Dv9YaRztf6knJHAVm6Odk3mbn12b6tWEaq0r08H/u3ckbWrT1kThmUU
         zqfzp4J5vF3Rgy3cD3r0PhRMQhlQQbvdCD8vvWFIS46wsmLheIuIlK/1kaJMPdO915Sm
         RavBL2NDYvU64FZxr6IxjpE7/O6FeiENF3Xae/EVjx3Ro6DLrYr6fI1w7U3rwqk4hykI
         KAEVALLCHlAKBqx64ybP5beCR6OTuAp+jUjVjS+hDupu1/POauksSb7Bt0BKV8ffAOG4
         SeEzvGJPTbkdNRqGfdntrm9osDocifJoxUYNXSJsUUBCtqiUGRId4rtnxXUZ4FelBkN8
         6BKA==
X-Forwarded-Encrypted: i=1; AJvYcCWBW3QsGwSruLu6+4RkjYBA+6NCo68sNALAUlmlXAXIhhzXABIxdz8fx0o8FJvUm/Tk1i+kTWbZwj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwonumnUkQo5i3pFFCZC8UFRDHftGrbDc2iZeUUq+rlXPX6FM36
	TUiZgtojAUXZp3REslHU/EJ4032G9Cq7WdV+zwOKL/5jVu8m1xybiMbF+IQKX8voXLrPTvtkdOM
	OFgvNT/fbKuzzY8GeWhWFSh6LKfKx+ik=
X-Gm-Gg: AY/fxX4faeOJJxK+u4fFLmq/ZekuVgfbGc1dzJ2Ta6e3f5SbfvZFxlaxoMEiSGvbx05
	36RkcmrvnLTRyvk0jm3yYCB7ZJiTowwca4t+TF3/HziAUr+jMlrqyPhDbGcTxl9pM3/wPmJLjP8
	uL6KDffPvJ0S2q7IBtj53jVkhzPpsLEhOH0dpdPaHLjeXcsaS5oO/ueHlgDq2vp31Ij9cl3sb+e
	La4DsRbZiFu3IvMMBRe+u3sQqh1sj0zouhu/XnzNPjOsdrdvea4/qzyPajDiNXLio2/FvPKcwPv
	FmPa8Xln7fDCZESE+W8dj8v8wuIHAQ==
X-Received: by 2002:a05:6402:510f:b0:64b:7eba:39ed with SMTP id
 4fb4d7f45d1cf-654525ccad4mr346097a12.13.1768501066374; Thu, 15 Jan 2026
 10:17:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
In-Reply-To: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 15 Jan 2026 19:17:35 +0100
X-Gm-Features: AZwV_QjhT3ZtgvkbHJB7796GEklGCbcNDL5CeRwrn_YYeN3X8FqPO-3_iRnRORw
Message-ID: <CAOQ4uxjOJMwv_hRVTn3tJHDLMQHbeaCGsdLupiZYcwm7M2rm3g@mail.gmail.com>
Subject: Re: [PATCH 00/29] fs: require filesystems to explicitly opt-in to
 nfsd export support
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, Gao Xiang <xiang@kernel.org>, 
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, 
	Carlos Maiolino <cem@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	Phillip Lougher <phillip@squashfs.org.uk>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Bharath SM <bharathsm@microsoft.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Mike Marshall <hubcap@omnibond.com>, 
	Martin Brandenburg <martin@omnibond.com>, Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Ryusuke Konishi <konishi.ryusuke@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Dave Kleikamp <shaggy@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, Jan Kara <jack@suse.cz>, 
	Andreas Gruenbacher <agruenba@redhat.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-unionfs@vger.kernel.org, 
	devel@lists.orangefs.org, ocfs2-devel@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-nilfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
	linux-mtd@lists.infradead.org, gfs2@lists.linux.dev, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 6:48=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> In recent years, a number of filesystems that can't present stable
> filehandles have grown struct export_operations. They've mostly done
> this for local use-cases (enabling open_by_handle_at() and the like).
> Unfortunately, having export_operations is generally sufficient to make
> a filesystem be considered exportable via nfsd, but that requires that
> the server present stable filehandles.

Where does the term "stable file handles" come from? and what does it mean?
Why not "persistent handles", which is described in NFS and SMB specs?

Not to mention that EXPORT_OP_PERSISTENT_HANDLES was Acked
by both Christoph and Christian:

https://lore.kernel.org/linux-fsdevel/20260115-rundgang-leihgabe-12018e93c0=
0c@brauner/

Am I missing anything?

Thanks,
Amir.

