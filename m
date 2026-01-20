Return-Path: <linux-nfs+bounces-18169-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APmELMGPcWkLJAAAu9opvQ
	(envelope-from <linux-nfs+bounces-18169-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 03:47:29 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D836112F
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 03:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A8A697E1440
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Jan 2026 10:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E8B3A0B33;
	Tue, 20 Jan 2026 10:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="UarTPr01"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98143BFE40
	for <linux-nfs@vger.kernel.org>; Tue, 20 Jan 2026 10:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768906542; cv=pass; b=C54NcbRsh2rGM9+/+3lcpzt8qgMIZ6oKX4YV+DrNLzIBq24/MfDVAp/a6t5VLSDJRUnFMn4h4ht4UksJgqUQSzG8gOve9PZN6yRcanHmAKOf84gPXu/vpC5biv3Hu9diBcWKTm+3YB3g7kzI0v3ocq0zDbgpxd/IMleN1HhQ+ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768906542; c=relaxed/simple;
	bh=fIzQM+I1dKrQeWlW8RXDEsaXmZzlz/hUkp2KF5rWyuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PiEY/R60EufWAY64wx3Kp7nZq1KEar/gF+Ie97veOR8aP/k17/wOFfz/iabC6+q/QmXRQaGVRmHB3eHAGoOqpMcZOiqdsxYn6DP1GZR8PEvlij61T0zV46jbKvSXrAx7FRRSsvLujs/gIqoOgvfjJdMSeK8yuSlzIG7E2LUkQWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=UarTPr01; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5014b671367so65251831cf.3
        for <linux-nfs@vger.kernel.org>; Tue, 20 Jan 2026 02:55:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768906538; cv=none;
        d=google.com; s=arc-20240605;
        b=YfGQnWQqRo1q/rbNyFC3n5CD4gHCRVTLjLy5gMgrlB7qeFisvcea9kVv8ACwG6i/r3
         s/3AIPR86t5nKE23rDDpZiHAxGBiFqADM2TiweBhPA2QYGT8724GGejFP/i7F0RzI4mD
         dTA0qsPOWfsmAO5jd+b+ctdH4Ej3Gr8N81XsCPt7YpWTFqIYwOsgPfx2xwWC3iytktZs
         dSwSpV5woL8JGasR3kd/C/Cc4YcoLRw5KuCehM3sYW3dHoX3s2I7dF4KFLvSuelvrGX6
         zGPqNSUef8rGpXaouN6z1kBU6UYZuCAPCzpDg4mMZ25XIP9Fr3RthtycQxl2OIpziZ8/
         LWng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+858jRkeuTzyR7QbFNMkP0w0F921+ZC4VlN4hpyPROU=;
        fh=7QfuX+wHZYZFSPqeUOxUi4vqqDpfHKn8QSIp5lKqHrw=;
        b=ZZFKxc0NxTaisKb90dHIUgQMBAJsapZ6WyqTWgl/AIF+ytn6BcnI3gRWQYccpZ7aJK
         fSgiGzV+v7Pfo98zSwRobxbrDN5zdZItadF2P+frI/BjypdGoYXTtQtJU67NEudLaYDb
         9IJ6cz53PDoJVLKBxYbk7EORVlk/lB+E8XL8KAUTqCzKscVpx3SW8kd0g0qDa+pIktRQ
         m8nrHuz+vAJ0e6egMY5IUMUCg/y7UcRaunOemSLvaKwi5O1cuTc6j/azTcdyUEXBuENl
         h40lovFqTrS4kKtg75qan4GrQTwjAUDIY7W1Z6CTGJlvNQ/NiDO4Z/h9dWxtz3voEYQ5
         7DgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1768906538; x=1769511338; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+858jRkeuTzyR7QbFNMkP0w0F921+ZC4VlN4hpyPROU=;
        b=UarTPr015F7dRJLJacZZzl2NOK/uiKmtbKv2oceQ84MND3/ducGjUdBlaRQ98tpe8l
         iuWAxTZguNmQtI2E46ndHWUOmlqapQTRDAKQpzRsRC2qJqYZqEE63hOzLNwSX1lv5UJM
         uDEWvpK4Ov/L93nsSMEPmC0p+NZNnZ2Jtl50s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768906538; x=1769511338;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+858jRkeuTzyR7QbFNMkP0w0F921+ZC4VlN4hpyPROU=;
        b=fMHoC6nphbFuJX8ehoemHRHAGM9KfTDp5sNRajN4jI51pa8qewp+g7JZK8rbM67FcG
         r2gbpIAS2ZKZiUqzx1yd0ks4oGP0EMq1CtFk7wQ/eoTgA8TDXE28+RaIBfE111+bSxFl
         sftvKJvGfwn/DslN7uT+DVKWjdeqntgMU+i5EtHWRw8TTvtVo7aJTfy+BXmTAi3InmAb
         oc6gfemUAMIo7ql3MdGvWIvi8ORYzBCB8ALxmvavL7BYcJryCU4p00SaxW+ElbiLvzNV
         wRkZKKdALUNTTpnp0r8ckXA5nfRz96D41c6UID9iONVoKRbfTAZn8wYLU/e9IBghn4Pt
         dYxw==
X-Forwarded-Encrypted: i=1; AJvYcCXyzYfolAPmNS/72dxsad02/Zb8J2uX94YTzvltMk8mAavYd3iwaMWjiQ3FRopa/gGqk2xoCpJEpro=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ1A7pj0cuwxn+pkOEqLxGvjr9oSRevSovUmSldLgnxaj3ndON
	DSh15E4pDjtCvQSpW4O5QmyS76tOhE0bYhH1S+nhc+VNiq1DTLebr+yrfudPEWbUqrJziBhfDAZ
	l5sPVRPZ7aXNuISqwkQsRykoaUicSrFHS6buzhBf6AQ==
X-Gm-Gg: AY/fxX6Tjz4WE0VKqVAC8s3DVKLXiA2KyL3IWH5csbvNyNzu95pBL3AV3i/DCd30fKI
	nPsBDskBbqdhN8h1PQrmOwSXTLK3kd344CW5CrZt6kf1hm6XUQvyfHHcteg5tNJQKbB+2pVHxnj
	ItVwC3rgydqvNTydaG9DrmRhgbE2ULQWMeRzBsLcq31C9aGkWv6GwxR3QdHx/UyLb48N1/hBxiS
	8iwAei4kA4VAHgGZ/0ec/2UOh9IezLweNqUtZHFLrWsyWZ2p2WeeHDxS5ppVDQigw3J+193cDrO
	i+D55PJ3
X-Received: by 2002:a05:622a:f:b0:4f0:23b6:c285 with SMTP id
 d75a77b69052e-502a1f231b4mr161536681cf.41.1768906538583; Tue, 20 Jan 2026
 02:55:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1768573690.git.bcodding@hammerspace.com>
In-Reply-To: <cover.1768573690.git.bcodding@hammerspace.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 20 Jan 2026 11:55:26 +0100
X-Gm-Features: AZwV_QjAOHMTbnCyc1vnuEuGvNZiJz2bkDzfLZ1b6HoSesVSYIgHm3F1kdUgfiM
Message-ID: <CAJfpegt=eV=2OxgfiVYG7drw_yN14b7edJhj+bsF_ku7cVGuig@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] kNFSD Signed Filehandles
To: Benjamin Coddington <bcodding@hammerspace.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Eric Biggers <ebiggers@kernel.org>, Rick Macklem <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DATE_IN_PAST(1.00)[39];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[szeredi.hu,quarantine];
	TAGGED_FROM(0.00)[bounces-18169-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,brown.name,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,hammerspace.com:email]
X-Rspamd-Queue-Id: 02D836112F
X-Rspamd-Action: no action

On Fri, 16 Jan 2026 at 15:36, Benjamin Coddington
<bcodding@hammerspace.com> wrote:

>  Documentation/netlink/specs/nfsd.yaml | 12 ++++
>  fs/nfsd/export.c                      |  5 +-

Would this make sense as a generic utility (i.e. in fs/exportfs/)?

The ultimate use case for me would be unprivileged open_by_handle_at(2).

Thanks,
Miklos

