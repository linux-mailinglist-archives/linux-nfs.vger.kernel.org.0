Return-Path: <linux-nfs+bounces-21930-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8J1dLQGCFGqnNwcAu9opvQ
	(envelope-from <linux-nfs+bounces-21930-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 19:08:17 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 508965CD269
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 19:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE3003017271
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 17:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA303F7A95;
	Mon, 25 May 2026 17:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dhioHvSU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="B4IY6GkQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6223845DA
	for <linux-nfs@vger.kernel.org>; Mon, 25 May 2026 17:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779728865; cv=none; b=GL7fZxJg51GAWz4+bSs+bFbeAimMQbETVEhyE1rl4H2ZUdro4Mu+eN0FjKRr1GNK3bYfyhZk/OMYNL8Dc4KhmFXl6xF3Sm9Zqg+wpRCLx2nP/dmr8Ki2mZH1wyg/yP7PO7VGx85APdgPVM9aW7/UuHiIwI7bEQSuSZMCjzul/eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779728865; c=relaxed/simple;
	bh=EGS2JGmyeWkbOCbREIX2qtEvE51ujoNsVgCL48xBWXI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hbRa0gVdbhRfAi5Izx75Pj2MOEsVKRvQ0gdkkOjsg15tuq886IzWzoM5ZQt8Njci+BAk9rZkgVvMwZAx30juGRw769CIdCV5paPjQoyvQpiNvFallHHYDJrIXLx91cWxwAFsJgS4rrsg0Ssrz7CQla0cKf1541HlCS536JvAEeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dhioHvSU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=B4IY6GkQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779728861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QQ8f0KL2cvJbeqS1wq3el83kZ9Z8vH79ZAL6r1+vgks=;
	b=dhioHvSUW0LXwpL2ye6gY9aEtrH575Eode9Y3bZkyFDeYpbbTkYBTB9MM0JZkKtl1AeGiF
	GoG47VJHDsbLzrDndbsVcyDWtVD5D/9ES7k8HW9uIoQQ0Csb5CtsMlQ7xRiKMN1+vUvum+
	IwbtAkSnwz5Aia90ZNw4ZnOg9+/OCig=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-HOqu8SUWMGuK3RXW0rVYuw-1; Mon, 25 May 2026 13:07:40 -0400
X-MC-Unique: HOqu8SUWMGuK3RXW0rVYuw-1
X-Mimecast-MFC-AGG-ID: HOqu8SUWMGuK3RXW0rVYuw_1779728859
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7cb345d0591so64575327b3.2
        for <linux-nfs@vger.kernel.org>; Mon, 25 May 2026 10:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779728859; x=1780333659; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QQ8f0KL2cvJbeqS1wq3el83kZ9Z8vH79ZAL6r1+vgks=;
        b=B4IY6GkQoeA6mxx8zFvjIHv1rw5Br7ObA6BH4M64VQ4WU6Hqk1GAUiuxBN81Ysi8fR
         ZwDRoKuZnH2y3aD88NE7jRHEBpMqrXc8vy5r5h3UTA+HgtWjx4fq5ehhF5VbbP+7movw
         CLTuGQqyAkdTSdUBZyjv7Emf0tHIBhS00MOl7s7WeYGyoWn2jsXYdpP66s0MrFJJG4ea
         3IivF1Xp8tUen58bukrpcQRp3jpeOEkaWT7Hw7p7lyR6GpmYkqVAJNcuLG/MJacz00Y6
         tRDq2BUx5w3dsFFV76OzIuQ2jHxDC7lL0r/GBonXJnS4WDQun1sK6026uV0PscSu56e+
         ohsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779728859; x=1780333659;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QQ8f0KL2cvJbeqS1wq3el83kZ9Z8vH79ZAL6r1+vgks=;
        b=cgm0cMUP5WkDREmSdqA/IDZtPAg+jeBo0yDg68hv4EvXFfc0+0BmlEbRtKvWt8hApx
         2/dZd+bLiN0Oxk5ktBIHq/zm+Xpzr8OTXkZ/s+sX/5BYM02IcJVYpxUnGwY9sjXnQCEs
         OVQPJ7gDufGr5bpd8tMrkNYM8E/xngaS2Z8f6J79Xwv4nG6j/NvbV6aI1ZlYEEN7eqnw
         ww5fEXf84TRrLZowEJg9EuSnGrAKE5RE+nr4iDxY2i6603weCGiv9RUIVmaS6KCG2mlj
         qmlJYegzPhk30X4SV4u86enHNXi/Idsihtp6Rda3qeN+Cuk8zx8I5bV//pOOPJHx3f6i
         FlMg==
X-Forwarded-Encrypted: i=1; AFNElJ8PzX/Kw7M0ajeW+oIikOx2ZRXSyKpc5NE57JXrVq5crww537HK6RpbGtk9cGb+ChreAlxut0Wva4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwDtj6OVa27NCRxhSQqa+uFdHiZdW1DpCLk450/2l36iuEY0fb
	RCtXDyjE0ewRMpK45lxOEgm+K6Y655vRXCUSnk0CA3XoP7x7vunUASr4cHM61YeQyFY+ogl2WHY
	QYUQIu32uWXEiE9lniYyqTZJSAkClpD+HbTiwUsLZfIdM8m3GVsHRu96MvkhAmw==
X-Gm-Gg: Acq92OEaglAzlQbDd9WIVwCzwcCkNsD1/ubkRKuboryVWkvHh94wAC0iFHBCFmykFN6
	YlEDEIUeAHSaBOxy6wOJSciZlSY7OTXOZOZsSlfFdghPv5zwRcA84R2plYZKtSU3bG5Y/wDcnim
	psIPvEX7Kb7wG0h+9tCdIJ08Kf1BrIZuCXEnDODG7tKQyM0VwN7ON54o/ILc/L55kZi+mnv9NSs
	pmWbYK+WNDDc3m7U+oaz1OkeKHkfv0ryGMD3IRtUaxA4GGyUjPB4XnvzIzUdVketa7gou7CbQIe
	bu5oVapvei11CkUDXPv3RGrbamOysCfcIfixDMEzrBm4F1NEbT5HaILf67vH9ogWh/q+JRr46qX
	791oCfySndNmg8w8e7i00PRLgAE1BUpkPyZGafNorW/eGrjgMWTS0
X-Received: by 2002:a05:690c:3708:b0:7bf:9648:8c5c with SMTP id 00721157ae682-7d3345da2e5mr155237577b3.18.1779728859424;
        Mon, 25 May 2026 10:07:39 -0700 (PDT)
X-Received: by 2002:a05:690c:3708:b0:7bf:9648:8c5c with SMTP id 00721157ae682-7d3345da2e5mr155237227b3.18.1779728858828;
        Mon, 25 May 2026 10:07:38 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d389813ea8sm48480087b3.4.2026.05.25.10.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 10:07:38 -0700 (PDT)
Message-ID: <1bb537f6dc36b00788b613fb8f71579478418457.camel@redhat.com>
Subject: Re: [PATCH 04/17] nilfs2: replace get_zeroed_page() with kzalloc()
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Jan Kara <jack@suse.com>,
  Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, Joseph Qi
 <joseph.qi@linux.alibaba.com>,  Ryusuke Konishi
 <konishi.ryusuke@gmail.com>, Viacheslav Dubeyko <slava@dubeyko.com>, Trond
 Myklebust	 <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Chuck
 Lever	 <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown	 <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai
 Ngo	 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Alexander Viro	
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
	 <jack@suse.cz>, Dave Kleikamp <shaggy@kernel.org>, Theodore Ts'o
 <tytso@mit.edu>,  Miklos Szeredi <miklos@szeredi.hu>, Andreas Hindborg
 <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>,  Kees Cook
 <kees@kernel.org>, "Tigran A. Aivazian" <aivazian.tigran@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, linux-nilfs@vger.kernel.org, 
	linux-nfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
	linux-ext4@vger.kernel.org, linux-mm@kvack.org
Date: Mon, 25 May 2026 10:07:34 -0700
In-Reply-To: <20260523-b4-fs-v1-4-275e36a83f0e@kernel.org>
References: <20260523-b4-fs-v1-0-275e36a83f0e@kernel.org>
	 <20260523-b4-fs-v1-4-275e36a83f0e@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 (3.60.0-1.fc44app2) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21930-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,suse.com,fasheh.com,evilplan.org,linux.alibaba.com,gmail.com,dubeyko.com,oracle.com,brown.name,redhat.com,talpey.com,zeniv.linux.org.uk,suse.cz,mit.edu,szeredi.hu,debian.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vdubeyko@redhat.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,dubeyko.com:email]
X-Rspamd-Queue-Id: 508965CD269
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 2026-05-23 at 20:54 +0300, Mike Rapoport (Microsoft) wrote:
> nilfs_ioctl_wrap_copy() allocates a temporary buffer with
> get_zeroed_page().
>=20
> kzalloc() is a better API for such use and it also provides better
> scalability and more debugging possibilities.
>=20
> Replace use of get_zeroed_page() with kzalloc().
>=20
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  fs/nilfs2/ioctl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
> index e0a606643e87..b73f2c5d10f0 100644
> --- a/fs/nilfs2/ioctl.c
> +++ b/fs/nilfs2/ioctl.c
> @@ -69,7 +69,7 @@ static int nilfs_ioctl_wrap_copy(struct the_nilfs *nilf=
s,
>  	if (argv->v_index > ~(__u64)0 - argv->v_nmembs)
>  		return -EINVAL;
> =20
> -	buf =3D (void *)get_zeroed_page(GFP_NOFS);
> +	buf =3D kzalloc(PAGE_SIZE, GFP_NOFS);
>  	if (unlikely(!buf))
>  		return -ENOMEM;
>  	maxmembs =3D PAGE_SIZE / argv->v_size;
> @@ -107,7 +107,7 @@ static int nilfs_ioctl_wrap_copy(struct the_nilfs *ni=
lfs,
>  	}
>  	argv->v_nmembs =3D total;
> =20
> -	free_pages((unsigned long)buf, 0);
> +	kfree(buf);
>  	return ret;
>  }
> =20

Makes sense to me.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.


