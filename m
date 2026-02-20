Return-Path: <linux-nfs+bounces-19070-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGFOJqDkmGn3NwMAu9opvQ
	(envelope-from <linux-nfs+bounces-19070-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Feb 2026 23:48:00 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9E816B4D4
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Feb 2026 23:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 64C87300678C
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Feb 2026 22:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CE719DF8D;
	Fri, 20 Feb 2026 22:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YdaW2WuQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7DA3101BA
	for <linux-nfs@vger.kernel.org>; Fri, 20 Feb 2026 22:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771627677; cv=pass; b=RrQM9EYGZ0DTJlmOPjGbh2NyA7pper6La3CIzmmq8C+cpD/rpOwGy9lModh5DDoDwbZINE7CDosc1wzGEWsZMwqRcRlz6ZR4ef68Zz9DVYSM7aZIX63e1QNUBAsiFTGrYPDiyGSxVDZOtiJxNqEJES1XojHimuAbVNSTKSvnyfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771627677; c=relaxed/simple;
	bh=cSO5ddvam+3etx0tA+nKexvNvZkPWOiJ4oLj72nGz0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQVygIfmmGjHQ5g1z4yv2ctJ+3z+d/NIAjTlZ5l/k3Clm+0f8T9pYWRVErDRXs5U8+iqilOsXy21uH7CyamsLAoMk5iv0zjWLCdQxc9YvQhg9oReQh0Q/NP84AEsczF3BfBwAfIo5cn1dnkLlyhHxWQcDkKzQs40EajtAEVSuT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YdaW2WuQ; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-352dda4a34eso1100043a91.1
        for <linux-nfs@vger.kernel.org>; Fri, 20 Feb 2026 14:47:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771627676; cv=none;
        d=google.com; s=arc-20240605;
        b=hlBIvZqhhpGBD4REhUvK+eyGIBAfowrM1w9QmSxkBF3gzxirDyLu6nyKABd5ifxFvu
         aRY30yLIF36ySh4Qj2wTRwAjOsLYwp97mFFzO7fel/GShLWUzlGISrkZjWzXjDiuOIpn
         gBWT1+/NC5XLm/nqzaYPLeyLTwlKLUEe31MYBGq3ZqqRRG+jXlCb3zEzFuT6uLuAab0l
         e3grvS0KtwwcImxr0k1FZntymDco+/VTCCpj6tz0ue6dnR3eXKHyIswx8RU5yfxh6hNm
         ZPzx91TsTwbA37hTu8mvBGKZ38lj2wXrM9eVL32rvw+to2dIbQ4GDpIqllHiHsmmaA4s
         CSGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DDXd3tXPluWk2oCytZ/1RJVm/UKOezpDOPY6avX6ips=;
        fh=ynD+d7Dix5sWarPsniQC5WukCvbml3SlrnJtrfFjv9E=;
        b=cOzEVanlt0+qiLwNC6IAS3ZTiXKt4ym9sUd+CudIguj8Ar9UMujpl7FKxfHeZjVqzE
         RZ6ErTFZ6MVxQuN4rf0x99Yr81iaYACvCqqSbQTio/XECfMfSi8ca4YdQD8jUX9wuxJm
         GAksi1Ap0NbdulJRhF+M2Y6+3y38ZWSvi3JTIXeNWtQuHxrQo21ix97Q5ACDcz3HfUjq
         L20k/AvrrA/eelQd42kFmXQtTX4J0JSa6bsQ2vV0MMb1gYzcyUscU/xK5LQODDQx5KyT
         4y5ouGpbeiYH4xcW5chHpcCGRkz/FMoRTUblp4bBOrdgOOoVzUdGQx0XjDstrUr03/Ph
         mL7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1771627676; x=1772232476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDXd3tXPluWk2oCytZ/1RJVm/UKOezpDOPY6avX6ips=;
        b=YdaW2WuQ41wM5N1ATcsiXfFOfi8o+6IN5OMQAoEAgbdAjJkGfZ63rBEdcJ8rnXF3yy
         zZPc6a4bONe+ldk+YsvYsyF2kj29Z3wp3gNZOieGr1bx02kYKEQmVczXkyhrdPBmsOu+
         02nizDc9/b0WQGtrOR1H3GqDf0CUX/xKMH2X8B4mZpv+1BEK8dbBgL7id+rR5kElX7Bx
         n0PhraKR1StZolJE3zbIKZZSH2znoCletYgDWkfimFsMFY3R/x3k3KRCEkMEvmLYEC89
         hBRTOgyFJXJMoXD0XtDvmQ6JKkjmqmwBDtqojqDUbUMVLPW7sn6eTqD1FLjRPj4//pn+
         8/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771627676; x=1772232476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DDXd3tXPluWk2oCytZ/1RJVm/UKOezpDOPY6avX6ips=;
        b=VpnNbllw+RBKotVhEUl/acWuANqIMc/3pZedr37cuKsEEreIqhU9+I6UI8UjHBTfaZ
         RPNoGDd1QAtTRksr4N/Dfi8Sl+ZGhamWJQ2fUH9aPk4yeQyjtldhISOsZm6rUXp8AeMu
         DXyPW6YTkIfclLAiY2MzczT0BXi+ER38yIXyZaO6YPyDc2olkU88SNmSfSRG6BkIGWqR
         s0HMVAN9q3lQCpV5VZAQD3RenJEKYWm1eCmb1lfRNXylDV8xWLD2/pvwvt+yhdb3N+uY
         KhyvZtf6axdCFvcRBb6557nQn0Bun0tgVGGzV3Yr0Q7uQ7h8DDB5JbjBQ1kjKRO6MG4C
         GBAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWX/r83dDScn7hCw971IR5lU4GbhKY37mgPaK9uhKzsS1ILJbzaAz9j8Ez2vrH5fX99GuTvPe5y+rc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx08KxxMnY1e5RRG2Wv4vqz+4i4qftFLOtqVwuVqS86WFJ10qN6
	K9k1Cv9QmGWRIh8I11nfOd2LVm5En6jZUdjRJQZRQxQAyiA/G5hrpFUnRHALxs9BQn3zWe7eoV0
	KYAEUsY6RgI9G9SB2nKpdpu8VY2XvFzh6EJ9NMkJA
X-Gm-Gg: AZuq6aJOfBo0fVewxtdH0HzJmjD2Ts+RXuM3ZqefNtV1SI8CyGPm7bmGc12Y6WFKrjw
	IRPZgXTzeyU9YRQC1/q8IwjyIilqKBpHoIN3OEtJyrrsdKPeDM8fD2at/1HRgEeXmC4Ih/lN/6p
	rIcr3bUNytwAG1ulhiwwN/fKmpjMxoiXhYXAU4imwxSdGsPoec4ki95nDkCDxEHb9GCYUyjg77z
	5y+/V52HrNl1h7iJCwV2E67Hal06qrdH+RCfEn6NeR3iP9esWcJKqcG9BZWl8b1exZRnFSq4YC9
	NvtBqiw=
X-Received: by 2002:a17:90b:3a08:b0:34c:fe7e:84fe with SMTP id
 98e67ed59e1d1-358ae8c0983mr894544a91.28.1771627675691; Fri, 20 Feb 2026
 14:47:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204050726.177283-1-neilb@ownmail.net> <20260204050726.177283-6-neilb@ownmail.net>
In-Reply-To: <20260204050726.177283-6-neilb@ownmail.net>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 20 Feb 2026 17:47:42 -0500
X-Gm-Features: AaiRm531rz23NInLiaMybHfJxR35OGBc7KTvM6WC-U0WofFc5pma3F6ygsFUv1A
Message-ID: <CAHC9VhThChVk1Dk+f-KANGj7Tu7zzHCiA==taeQ+=nQaH6a7sg@mail.gmail.com>
Subject: Re: [PATCH 05/13] selinux: Use simple_start_creating() / simple_done_creating()
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, John Johansen <john.johansen@canonical.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, linux-kernel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19070-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,redhat.com,suse.cz,oracle.com,szeredi.hu,gmail.com,canonical.com,namei.org,hallyn.com,vger.kernel.org,lists.linux.dev,lists.ubuntu.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[paul-moore.com:url,paul-moore.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,brown.name:email,ownmail.net:email]
X-Rspamd-Queue-Id: 2C9E816B4D4
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 12:08=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> From: NeilBrown <neil@brown.name>
>
> Instead of explicitly locking the parent and performing a lookup in
> selinux, use simple_start_creating(), and then use
> simple_done_creating() to unlock.
>
> This extends the region that the directory is locked for, and also
> performs a lookup.
> The lock extension is of no real consequence.
> The lookup uses simple_lookup() and so always succeeds.  Thus when
> d_make_persistent() is called the dentry will already be hashed.
> d_make_persistent() handles this case.
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  security/selinux/selinuxfs.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)

Unless I'm missing something, there is no reason why I couldn't take
just this patch into the SELinux tree once the merge window closes,
yes?

--=20
paul-moore.com

