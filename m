Return-Path: <linux-nfs+bounces-18953-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SM9yG73rk2ls9wEAu9opvQ
	(envelope-from <linux-nfs+bounces-18953-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 05:17:01 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE38148B08
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 05:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E6683014877
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 04:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418D61EB5C2;
	Tue, 17 Feb 2026 04:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+HXpIHG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C070518D636
	for <linux-nfs@vger.kernel.org>; Tue, 17 Feb 2026 04:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771301816; cv=pass; b=H+LjEOr+XByOyoCFspb2Tc4eGf4u2F0b/mHI9LVwOMHc/Z8jOahi1SV+xOyttDwP2bwFt7LD75EPpVKZ6w8QWGl8yOrSYCJEjFxu9czu2fSwIK4HxcxTaTT30rGFqIjE0V+aYKObIvcfOgK8fJ1P4bw/E2Ry7ZBSxK3Py2GUmOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771301816; c=relaxed/simple;
	bh=qe+7XX/L5syn+cLvVHmf9Bl620oz//ebyw08Uel5J18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KG39l69hfxcbMI/OQ/jnbnW3YIF9RoLTI+vLcrB8qcshOP2jTTrKx1p7UhvlMIotg2AE242dUU7ZFAHvJLEmBhXt6fKJCCLsRvfNO2irbjY4vr0kfktTIbvl4ZTiPgAd+aZyCbS/MlwDkJS9t2XYbbMMKMoqGf5Q+c9EQp9UkKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+HXpIHG; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b8d7f22d405so412308466b.0
        for <linux-nfs@vger.kernel.org>; Mon, 16 Feb 2026 20:16:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771301813; cv=none;
        d=google.com; s=arc-20240605;
        b=SN+2yovcGULrb3lkkMUvhpcQTaV02Fl4Z/br/4TUZ97rPCL70uy/9IIhhAQ1qSWWhG
         sxX2J3ANJIKITec4A/Lnj/ah3Zi38VcxaGag0JzMlWUtUNI12zDsvmWO/hBMCq5qXxzk
         fXNuoISJ6jJagsKUeUd4zT2a0OfGsXbUETUh4MT2nEtHBWHLj6NAf6CWTEVmYoIzjHWG
         08TAN5VPLiJwp2fxY8RyeR73t248FiPlLfnTlvIJEdDlr/coMl2anjS1tlor8/LCwyX0
         yyRblefvMgh6AzqMU5C52NexgQKkDKGg0x3B5N+59avRldoyn/8TGkYDHrgEHe7EuzIv
         QJBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qe+7XX/L5syn+cLvVHmf9Bl620oz//ebyw08Uel5J18=;
        fh=4Q++BKEdpfCc9P/Ffgy9HC/14FkDvzTVuHi1JeYh7IE=;
        b=JZaid1hHaX7DrkmL5dkF22QvlgvTxqHcAslfH2AAFgXCBFy6Oi0ZBmiCKWlzVMyPFf
         4YkMpjANwsjRQAn+AQvo2HirTUTfoyAsH1CYFhouo1WPOwxgDvW2IuCxkvWx9/fwt5Bp
         BMMfc2zXFvfSxgi+lKf57FyL4q1MZa6PfmBbxj0g093Wy6d1KIv5SgTuzkiYBN8fcM6N
         SDM8vXHy36Cj/q/Bcbyo2oNnIDjLzosM3dLlzK0bACehIb1iyO9cjgzzOu8pwUun1WWk
         jQmBmcwJt9MZMlpPTnkax+4u6X5O59VgbSDNTTAzE2jIJjz41l8XFuplvMNnI5ZgJFrD
         DbFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771301813; x=1771906613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qe+7XX/L5syn+cLvVHmf9Bl620oz//ebyw08Uel5J18=;
        b=B+HXpIHG0tSTxiI9EhZ0HTLNVrd3JB4Xvv9hlsXrPnUq9zZhsBfOYL7wVgqO8iCBF5
         SWKUfVzoc4N1pQmQ1IQKOUlIsVnZj+lfAjxA7H4GHZyI3kpkMzeRiX3YobR2jN2wqRz8
         WQTQcHTJBcgBnEvVz5XSNNPrZqz1f6/m2R5rlNI/0PZiYY+MGywlsDPuYgzXF3FLKGgJ
         kzo1KOc5b7GMMQTnuV75QA6P9bj8PLhz2JzuIeMuak0GyoHUiteY8AlgXuYF7Vqrc1wl
         cjTs4XuGF3YfbzY6i4QuSuaGGVPokJYkg9lnYv84pHCSpu8bT7DRa0zHVScqPqV4E9wm
         NGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771301813; x=1771906613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qe+7XX/L5syn+cLvVHmf9Bl620oz//ebyw08Uel5J18=;
        b=wLVg8rdx5184CJE/1K+LdfWU2jS6xtZ9zLk9DrDR+JOMSXqVMaIi7NvpnWbhNm6sV4
         9Tx2EOFRnTCHeFMetesvkfsZJyjdwL428dMVrOHiXyoR6gPO+szv9cCQa/HG+1wiLpfL
         YCC7OGT9L9hwrBq5C8Gu9u+0ZXOn5IMNfKR0yG4WzkSdLQZbidSya2wF/v2wDSBVyiHb
         ephUUvEpZkG8aWBF61NH+4gs2TFfF1wYOBDz6AZEKbTGOJvYD0+Ji17jjHEs+S8jREvD
         fObG0izyIsvPIOneO9y3yJdjM3QaWvp2u1nMOSF/tOGIABJwWV/ya60bQitexw99TOc3
         ceIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsooEQM70iV0ruW1hd6GOwyhoDN+vu/yLwa6sqHzopIN4z240u8LdwHeAmsqY8P/DEsi9IS3aP6d4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsMIhx+X1a1a8HyIAhnn72+ZcSlmKNb/6An1DpCZH/UjnCo3p8
	J3uRltrk0srFSkrVbshMUxgdNb3+8fKJJ4aJiFuXBnNmlE6EQfX9iCKHAnYVfFhKZa5JB4J1erw
	HnU3RlOJHveaWWp4PhNvlv4MrxbiDqr4=
X-Gm-Gg: AZuq6aIKVELjwRojI94njp20FjZukfeG5EwzaAm7E2OFEw33aaRkHBv+zOi7Tt+ifbF
	eW9Meom6a1UUgUZKv3a+wf8uJRZDN7i8iLZz2B9fQcXr/doP8E6wbjtN4hyg8dqyv6tEND21Vv6
	uu+Phcay03kdzsw/PxEKLqz0LElPDTmdJ2fQirGBw+Zb4UrWGrx5uoPaQzQeCRTHevdfGYYHuWH
	mg1WnK9dshicR2bmJs/f39EVQ+KzY4/IxFgKN1E3Ei+hy3WGcvNinnBdzujmTWyHifHnacIIvFa
	HkB2GQ==
X-Received: by 2002:a17:907:3da2:b0:b87:d186:19e3 with SMTP id
 a640c23a62f3a-b8fb44a3778mr761877266b.43.1771301812795; Mon, 16 Feb 2026
 20:16:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANT5p=rDxeYKXoCJoWRwGGXv4tPCM2OuX+US_G3hm_tL3UyqtA@mail.gmail.com>
 <aZJmthYtk33KYDud@melos.hm.i.d.cx>
In-Reply-To: <aZJmthYtk33KYDud@melos.hm.i.d.cx>
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Tue, 17 Feb 2026 09:46:41 +0530
X-Gm-Features: AaiRm51QHtefjwH_4aVN8UbkRPTl2or_N2X9XdmE9IAJs0YnwmTtQVL_DTyVRpY
Message-ID: <CANT5p=p6yw3eYJVXZc2CA2fBgBYpZ4W0uKivt2tCmtgos3GVdw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Namespace-aware upcalls from kernel filesystems
To: David Leadbeater <dgl@dgl.cx>
Cc: lsf-pc@lists.linux-foundation.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, keyrings@vger.kernel.org, 
	CIFS <linux-cifs@vger.kernel.org>, linux-nfs@vger.kernel.org, brauner@kernel.org, 
	David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18953-lists,linux-nfs=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: DDE38148B08
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 6:25=E2=80=AFAM David Leadbeater <dgl@dgl.cx> wrote=
:
>
> On Sat, Feb 14, 2026 at 03:36:22PM +0530, Shyam Prasad N wrote:
> > I tried to prototype a namespace aware upcall mechanism for kernel keys=
 here:
> > https://www.spinics.net/lists/keyrings/msg17581.html
> > But it has not been successful so far. I'm seeking reviews on this
> > approach from security point of view.
>
> I have more context from the containers side, but to me this doesn't
> appear safe. Entering the right namespaces isn't enough to safely run
> code within a container. The container runtime may have set up seccomp
> or other limits which this upcall won't respect.

Hi David,
Thanks for these comments.
Let me look into seccomp to see if kernel will have any visibility into it.

>
> I would like to see a solution to this though, we currently have custom
> callback code to make this work. I'm not familiar enough with the
> interfaces but an approach where something registers also seems
> desirable because it is able to preserve backwards compatibility, which
> changing the namespace the upcall runs in doesn't.

Ack. Will explore the options and get back to this thread.

>
> David
>


--=20
Regards,
Shyam

