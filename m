Return-Path: <linux-nfs+bounces-18933-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UETVIjFJkGkJYQEAu9opvQ
	(envelope-from <linux-nfs+bounces-18933-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Feb 2026 11:06:41 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B2F13B9C3
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Feb 2026 11:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C6613010498
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Feb 2026 10:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035B726F471;
	Sat, 14 Feb 2026 10:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJWG/0TD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0EC24677D
	for <linux-nfs@vger.kernel.org>; Sat, 14 Feb 2026 10:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771063597; cv=pass; b=unO0d35EP05oiH6JrzMTuBBBvGZqCu5AVnw3ziU8rp8sfsQWetSKdUnt/PstdQrCYe7jrHYni89NO0atOosdY6nITBxZDIOjuwiAdX5acyyzOexbFa+EFaXI8GMBWBvHcKd4EhHooFyzg0bm76RPrHvyOSk6ztK5ghLYRj+0QUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771063597; c=relaxed/simple;
	bh=jY3VYgfZdwcEWaDFOTWHCBRqnN2ieQGX76J1TWV/hN8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=MYViDjjMXckgwvZMSmHnDBJ3DMEoeZ6TjPtIETgwSREX/AxT+ur732EPfXTohk9ypMn9KIitSkkFWcZZISIN3FPUiYP45VOtiDgOOSZ/Wo/JfYP64/6wQ2SzRXgX9H9EcqQEQ2TKQ6JFnLxdzEnRj6SluccjJIJbm5xqgmgT4mM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJWG/0TD; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so281005066b.2
        for <linux-nfs@vger.kernel.org>; Sat, 14 Feb 2026 02:06:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771063595; cv=none;
        d=google.com; s=arc-20240605;
        b=M0NzZ4xQE0PvlXuTPcwRMh64213+LmegN46HxlaGehdT92G0yYlC1+8ZkG2Erdbz6Z
         W/KVw4x/CD7S6iHVZ8bTjK8U7iH+dCjHRHI96iuaAr/ue/3l04wq0LEy08Qo+p2BxxaY
         L56T9/NKOj3Ifedlr/OGhDonnIT4oqJghQoTIKdrYp+YGusUVVqHU0zqU7E0uamtXkeD
         hF0py9NGbdBCUByjOMf5a0mLsnn6yMSB04lYaZxa/Gqn89cHctKfasiMnyI4RuZ9Gle8
         6yQ+pOo0tjgATLPxhcdjza4aQb1/a7CkUzgsPUVVzU0CGlwQsv3OtBxj7YfE6QZxWNOG
         6+cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=PGGVJbddt208w/rGIVrn/yfhIsOw/8PIkZU+nOzBAdQ=;
        fh=26Qk/izCJXItVgSgW2X1KpRUOtyYTtdBQo5jqq7McYA=;
        b=ffggzTRgzDR+s1uQ1lxp0lcNJCDqcPKAR/R/4LqsoWUkECmtEe3AcQDWRd8Brzt51Y
         6QxG1jGOdbMHe+YKycmuVuZRy5uEUapzIeHRLCbUQ8a7bjSYLaDZZ4HbmVxGF0sn2C3G
         T9wgi/hT1ovetaYeVAdGaFpGIV5y/4Zk4Wo1gfOwBbgPJSwWFEpLi7fZOb3ObKd6Gijl
         y6xExUysCcckRNTa65JinkDUurPfEQVJnvduRNgVAyYuogWg3fjQJpKPj++S8R1stVQI
         E/y6sFLIT9oaRcVZrccaHZNZuqtOd0EoNcwW3fMIXMvtbq8k1f10MT7mRoDmdvT4/fOg
         N8DA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771063595; x=1771668395; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PGGVJbddt208w/rGIVrn/yfhIsOw/8PIkZU+nOzBAdQ=;
        b=iJWG/0TDNqvsdOWejxmu1z4K6eR6SkFFPeweAMKUuf4LjlqhwlPSq5tZSYCbHIPKm1
         EltXd2Tsle99bwwM3BWsEjIOZ+nolbgkUOW7pdQB3oScmn5W6gdTWWtnF1vbCuKB2nOf
         we0xiWFbptRLuR1m/hb43AuR2tOT69JGivipnH8le1LKrV6Y8EMxSJVeaAF6KkG/75Jg
         Th1xMmTon+pabWXfcBFHEA1Uh3V3RC8EaYDqxLc7yl348ADM3jt9Gzme7RyUZgyvhBqC
         EOi/GKPhKPDijFB3bTJejzBSKCQij/BWO0zam99kZ7rACGVRhnrpWBaJr8uaVKdf4CWu
         Exfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771063595; x=1771668395;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PGGVJbddt208w/rGIVrn/yfhIsOw/8PIkZU+nOzBAdQ=;
        b=wGnf8HgLAh0rIvj7vB3pwfrI3JmTAakqX1tCNB26PNUqdiTQ9ArQ6fPAY8NQeXtxCf
         tp6yziuiHzNRl39B4m7J8yTy+SfkRx3Ze/KpHREWq9mb3g9sONIFoomCOlT01uXGQkFX
         9xCgzOTlLgYTuksiWuNT9eILjx44WJp37vipY2UoT/jhpPr8+/y95MtUlhBF+6XboXOl
         /4pOdic6wltu+1j5K/7b3/ZuBVbrYqLJQURKBveg9KRP8ccFikpsFurYJpISRm/fXXKf
         B/saXfIw1dJUl9cQ+e7NZwa7dxm1WubtG9JkxK7UjME+1sqPgpn0snUfjJZGUIBm/LQZ
         PdsA==
X-Forwarded-Encrypted: i=1; AJvYcCUgGo/2qP11IEUBHtNJcUqvvR5sCaixwDwtCYZHtGXmxJ1HrrCejnRSvKP3cqQ4X/2n4agodWB3CEg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw34lMM+QDiJ9ySb74h+lTNJ0diN4EXzhxpNEWrRC1ppqG5yjbt
	lTWKw+PP9Ssw1nMkhBiVfGcamiZLbMtQZDfIeCRUGHHWgzquARukI9BoBPhr//a6X+VBfLachZz
	WsL8dair2nzzB5VUwhPfkEW2l1gJBIKppTt3ah8U=
X-Gm-Gg: AZuq6aKvvkMemhfLZOi8KpEMz5aXeutTv9AiI59RlbWc9CX6+AYunFQPr9XdfgWS5TI
	DiXrPJeZ+Fd5lHn4qra4BDDrOlKnk7THbkuMt5qnj3LtjR/8fuA0haVA9TELQgB9PpYQ/mRJNqH
	/EAUBu4uhp2uxkxYhyWhLh6SQLHTkYTqbnIzyS8sZY1jKGDYRPhtH2vRKxsmik+0/Z4piRRI6mo
	Du5PL7rBsPDCVJGQtxX0LCO1xlXTHQKRavUpj5si8h2hJVmqeIfAhH/rMsnL01cdXidk52UiWtZ
	ArFlyQ==
X-Received: by 2002:a17:906:c14d:b0:b87:6d6b:1366 with SMTP id
 a640c23a62f3a-b8fb4462ebdmr258928566b.41.1771063594865; Sat, 14 Feb 2026
 02:06:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Sat, 14 Feb 2026 15:36:22 +0530
X-Gm-Features: AaiRm53SFCWgM_DXMfR7wPwL0TsGianlEbiEEbkirbl4xvQ7utf0iFrM8-H5s6I
Message-ID: <CANT5p=rDxeYKXoCJoWRwGGXv4tPCM2OuX+US_G3hm_tL3UyqtA@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] Namespace-aware upcalls from kernel filesystems
To: lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, keyrings@vger.kernel.org, 
	CIFS <linux-cifs@vger.kernel.org>, linux-nfs@vger.kernel.org, brauner@kernel.org, 
	David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18933-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nspmangalore@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,spinics.net:url]
X-Rspamd-Queue-Id: 06B2F13B9C3
X-Rspamd-Action: no action

Kernel filesystems sometimes need to upcall to userspace to get some
work done, which cannot be achieved in kernel code (or rather it is
better to be done in userspace). Some examples are DNS resolutions,
user authentication, ID mapping etc.

Filesystems like SMB and NFS clients use the kernel keys subsystem for
some of these, which has an upcall facility that can exec a binary in
userspace. However, this upcall mechanism is not namespace aware and
upcalls to the host namespaces (namespaces of the init process).

This can be an inconvenience or a blocker for container services,
which run most code from containers and do not like to host any
binaries in the host namespace. They now need to host an upcall
handler in the host namespace, which can switch to the appropriate
namespaces based on the parameters sent before getting the work done.

I tried to prototype a namespace aware upcall mechanism for kernel keys here:
https://www.spinics.net/lists/keyrings/msg17581.html
But it has not been successful so far. I'm seeking reviews on this
approach from security point of view.

Another option that I could think of is to host a device file in
devfs. The mount could register with keys subsystem by keeping an FD
open from inside a container. The keys subsystem could then upcall on
the "right" FD based on some parameter supplied to it.

Looking forward to hearing if there is a better approach to solving
this problem.

-- 
Regards,
Shyam

