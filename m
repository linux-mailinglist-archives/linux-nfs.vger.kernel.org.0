Return-Path: <linux-nfs+bounces-20173-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id hT+8FwVvtmlnBgEAu9opvQ
	(envelope-from <linux-nfs+bounces-20173-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Mar 2026 09:34:13 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DCE2903E6
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Mar 2026 09:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2EE25300AB25
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Mar 2026 08:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AAD40DFD6;
	Sun, 15 Mar 2026 08:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9A8DYMn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0B1266B72
	for <linux-nfs@vger.kernel.org>; Sun, 15 Mar 2026 08:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773563649; cv=pass; b=sYQ8S2/kn/8oWWzXpALJDHGUg5m0LhQzXMfCO1QowheTk0JgF82ZBjg02v7RtM7MPx2fFu85/m9WpnTPflmmeEhYq44QjEC3I2wsPwX//1T79jlW8KyFebiq2gHjHquyqeI3gL1YCLKqGRsQnZttjSoHQY9SsoRJQhtWM3/5XO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773563649; c=relaxed/simple;
	bh=BaMOEUftxF7m13yPwbM7/Y8dY8OJU4PvP6Ik3QXQZus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Gt3BoYYbZIpt+5my8yhu98A2fLjSCCpUS0uUqSPg6yRTHrV3St572LqlFzmKPjcKvuiQEYZhNxC6CaACK7vcwAQCLqiWJJM+asyE9vg1ZBcYbzQ+dpWqlPQZSBS00Qcfvn+bCuGZInOhV6xyjjshAIpqTPch44iVji07350WGzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9A8DYMn; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-663a6bb0fa1so3985768a12.3
        for <linux-nfs@vger.kernel.org>; Sun, 15 Mar 2026 01:34:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773563644; cv=none;
        d=google.com; s=arc-20240605;
        b=cpvBkbYMBkLU084puEnaGwg9Ysd8jqkHkr5FdTa80SpchKfTAUylj9Kq2nw5sp/SQw
         7zIq7gAZxdMzSKPJpYKURY0mCtmKYl8LAikamR79j7oTZJouQf8tYpzmLxEoHDIhY8vI
         dVnfrpwkxNIL306UWTQDXtoKCkvJCSVx1oilzEpG8V0Trgl1VK5gHVTgRtp2bvKo64ag
         mRS2beSwFry0BOkVb6Gggf9SuH9DquZSLr2ZLaavE+GLsnvUlygV931Ila/tepwCQ1S4
         1Me/r1JjymLnDyZypFgHTJQzmo9uBi5bHuEIfBaFPn5Skvrq3FzsFbtjNHAhtqQ3qN6W
         7jkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BaMOEUftxF7m13yPwbM7/Y8dY8OJU4PvP6Ik3QXQZus=;
        fh=A3pMOUK00huGibGCZBFsLekFLVbB5hHGKjUNNKwO+5E=;
        b=NchNXxepynU4+v8MukqwNWtg7brzOp1hBoKS5Tzf4Ourc1nHjocIZJtokcx3znbU0q
         vTQVvOUCqkwuyBBWNPgptcbmscV8ElGryrG8AE6DWHUuqcJ2dqEJwI3Zfd0jgr9yR4lm
         tuZ5fvQqdsnjJZsK0jtXxMm748Zd24y42SnIJNUxoeCYt1Md8Lt26CGHkpdXegZg6tzD
         pPJACqG0cqQbGixBkftse6LUANKCRBuSTF4liGR9l4z/YwVdKgiqvdXcXw+ZKQ4acz/Q
         PJfcUJNR/EUCBGbYX7BwppO+2FQ8y9eUMmYpCOEXpbDnyknE+lI3lfcNG0akSFOevFss
         Kleg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773563644; x=1774168444; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BaMOEUftxF7m13yPwbM7/Y8dY8OJU4PvP6Ik3QXQZus=;
        b=g9A8DYMngkF5qHYW3auR4cyYajP2HYVhrVOLh3ap32QBEhXFeTf8wl2hwmMmQhXKcI
         1l40E/MXw65fV4IHae8H8W/YRwKyRAa7NvuN4ZULTkhWjzgWU2jquZRlKRh2NvrUG1Is
         3EDTL41w4CPVzAVtvmzEcZnML7Y8o3JRn1/2nQFy92lRqM/taeFJbi7kpx/ag++VEgmf
         WrJTmP8kG7lpFwSeOfAP12xVo1qp8zt0kWu0eicgONr2jeHlKT4LMEWyk+KoIKfT0+N5
         ehK7ik4USlccPcOinI37O1phzM/KZfOl40AmAs2A0TDt9SE5evbbpGgb8ZWOSeTxPyNP
         r05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773563644; x=1774168444;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BaMOEUftxF7m13yPwbM7/Y8dY8OJU4PvP6Ik3QXQZus=;
        b=P3gsT5nBDO9xw+KLXMUpJPbwZicEBftrKD67+Gau5a3d371I1ohIgVpu6hf89kttZm
         Cp610fJ+/EJtC+EMiDEbc2UsMyLs+1bsk9xDHd3/4tKiNc9hwB6/ge4gJtSfsIiAkiCt
         4Ka9Faa43FDQ7juCP0Zaju2Ig8YSo3n1dpEPGYh3feR2573SLBdJDcZ25/xz2WhY5fqm
         x4pjZWOHuQrVRPLturVY6a3RjRraUgyj9bEe91WhO1+vHELfO8Vh4ObXeSotoVYxZnvK
         YZ7hhSJnfTdwxKNXIyquITS412wFioNuPzkmKOyWWnqQ9qmLWxyVWbQF3taYWtJ8oG/E
         dWpA==
X-Gm-Message-State: AOJu0Ywu7kH05vBpttvg+TNTpWwWV753J5pApiwoE8TjmkuFcawdnjgJ
	JoMk24z/a1/Qi/6AqhO7a7jOhUpxbmQ4DAItyRxYLP/Ey2ZnPU3794nfU+0eL5YmPQTnDd8h3qT
	OMq5en7l9PGJcSSmPe+L9IvmgPRkbBmYNNKSJI58=
X-Gm-Gg: ATEYQzy9FlbZIn5CT8q06sM8SsTw+3L9RCpfRGkTUlmndtM+dF/VXn/dcdivW+j+9KH
	9UmqMBxS4x0FKTD+4ryiSlW9xsHKwfW3NmtJBTZTQc8usXAR56IHR1W0qtFbaHIQdhkfCAQwxAJ
	7d/mQVJeE76MqzNNIwUKr5xixSlsnT4aEpsxMckSprnak6h9jnvMG9GQcK1ZccBRP09ZkbMwZHR
	pTZU1KX4SJVmounbuPSfebu5vpjVQ/Pw14pFhmLEUFkscMWitYbvrZEgG9OuyHa/1ysuuhN/JlD
	sFus0Sa0kUBf250EbYI32mBfo1qSsNzMPXhYcQ4=
X-Received: by 2002:a05:6402:4303:b0:659:454b:7167 with SMTP id
 4fb4d7f45d1cf-663babcb570mr5487117a12.23.1773563644166; Sun, 15 Mar 2026
 01:34:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119005119.5147-1-cel@kernel.org> <CA+1jF5pF+K3s9N4p5mc4cxyzg=r5ow5R_T31Eab=DOW5AjBG-g@mail.gmail.com>
 <aSMsb350kJgqysbz@morisot.1015granger.net> <CA+1jF5rKuZhjj3POSrgFO8=uNS06gB2y5X+jmDhApDdXW_eLsQ@mail.gmail.com>
 <780e05c1-f790-41e5-a0e5-cf7484e31a92@oracle.com> <CA+1jF5rBpt60L3=j=t_msPj_4wMcUXxZW6X0k3sTKQ3mnMb3YQ@mail.gmail.com>
 <ca5ee0dc-9f44-49d9-a55f-d980ba57da68@oracle.com>
In-Reply-To: <ca5ee0dc-9f44-49d9-a55f-d980ba57da68@oracle.com>
From: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
Date: Sun, 15 Mar 2026 09:33:00 +0100
X-Gm-Features: AaiRm52B_q_0PePeUD3XWSra-eZU_i8JtZZpWbCBB44wfuoAs_w7kAQuv99g6js
Message-ID: <CA+1jF5o85HKW=7BbZcukedLbA67meyWj6jMrZaOe+sczqg8t0Q@mail.gmail.com>
Subject: Re: pynfs tests for set-acl-on-file/dir/dev creation time? Re: [PATCH
 v1] NFSD: NFSv4 file creation neglects setting ACL
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20173-lists,linux-nfs=lfdr.de];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aureliencouderc2002@gmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: E8DCE2903E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 8:28=E2=80=AFPM Calum Mackay <calum.mackay@oracle.c=
om> wrote:
>
> On 13/03/2026 7:48 am, Aur=C3=A9lien Couderc wrote:
> > https://git.linux-nfs.org/?p=3Dcdmackay/pynfs.git;a=3Dsummary appears t=
o
> > be down at the moment. Could you please post the URL of the commits
> > once the site is up again?
>
> hi Aur=C3=A9lien,
>
> The site seems to be up at the moment, albeit rather slow to respond.
>
> I don't look after the site itself, so I'm not sure if there are ongoing
> issues.

It works again for me, but there are no new changes for 2026. Did you
push your patches?

Aur=C3=A9lien
--=20
Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
Big Data/Data mining expert, chess enthusiast

