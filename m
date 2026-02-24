Return-Path: <linux-nfs+bounces-19156-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEi7CgQYnWlTMwQAu9opvQ
	(envelope-from <linux-nfs+bounces-19156-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 04:16:20 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AEE181566
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 04:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EB2A304DF2D
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 03:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E17A28CF5F;
	Tue, 24 Feb 2026 03:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJtA40K9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9A7274652
	for <linux-nfs@vger.kernel.org>; Tue, 24 Feb 2026 03:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771902977; cv=pass; b=Zj8dKNxAPdsTU01slewnd8a8vG8k5MIYfUz1o6SEqlGfghivso1dTUZtVVfaQiu0y3pKN33sr2LRqbPYf2uOZLCwdn9XaW1rEm+IMoK65Rzq1ELxL/k/0puu7pkq3d2q+0D2FwljctsNevUzIS5Un76tINP7m+5bSpm4ZT26its=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771902977; c=relaxed/simple;
	bh=/DZt0xtYa5lr6976gZvjB7WdGufQG5+fQI8ZuixrTvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Avt+oU8kNyAvDHtXwvAna4W/xPl4nDwbSc20J4mQNF5RmGWfoP86D3ReNF+ghE6h+G6uLdLMgYR4x63gfJuNurbJovVl1R+gnCPqBt3EgjtPAbLTe5TitF9ZOqSEz7Voc6VvU6BoeZFmxNKweuQWCbhHUpPtkPxMHmt8w8OlrYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJtA40K9; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b885e8c6727so880926266b.1
        for <linux-nfs@vger.kernel.org>; Mon, 23 Feb 2026 19:16:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771902974; cv=none;
        d=google.com; s=arc-20240605;
        b=Erw2egUKwdwxzQWBxklcp1MVEBCBCk0HJQ157+6kdO469o5D460ywxrdNuxd0CjZdi
         nYvbJKbytREy2c1CQH6yOBu1xwPFDIcOso9iwq2cqhZOwGDCyFpKdW1aqXBT/BU7j9A2
         FrnbnVPdiSQMJsgDoOoR1NyUl3giPUWleKfuxZW61Il8BsMlvhULu0TNG+AY+cw4Oa0g
         SyimjYVuRl47keUm+gQxdQCA/oZ76qvvzPuod8Rua6YYDxnouHFZw55FRDRid84uz4WT
         srWQ9l2KpkrZrZCPJafpNKpyE0SicH/asH1CXL1Yzwitzt1OPYQNY/OM6IH7qCvJtXEx
         20Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/DZt0xtYa5lr6976gZvjB7WdGufQG5+fQI8ZuixrTvM=;
        fh=I9Tq67/gLOLskA+95KhLxNGyebooYG3OqNfCSXjYurQ=;
        b=TUh6wYDn3x5qB8U/5dti1c1diwU5hNCY2d4VioBQfvNFCLN3xkr6x2E//GhIKNGOqd
         gU5Jq2s/pFzGL7iNSdHMsevhqMZRk+my3Sq3LL9yrldZanadkci2XOuayF+g2u7zvtB7
         fI+L4U3FsmyxClN14iBb41osVdkcrofY26aGc4HuU3wczBOlB2XiNm6jcphiNd7OvL0X
         VVyWI+Exj+J+V3FEden/AWnwONwQcOTwnZo8R8aXKFFnu4yK2qkBzjeC/oUyTlAQaC32
         Qk/RXAq/iFw+k4iTKU/3dvdnKCmjIGOdkyGsYjBOB1vCwowvFKVgo+yQ129k83NZ2jW4
         Yq5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771902974; x=1772507774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/DZt0xtYa5lr6976gZvjB7WdGufQG5+fQI8ZuixrTvM=;
        b=EJtA40K9HAoSdu5Nf5Nq2aG9PozmLTjJXiVzaSxUyZRnHGlsmpYrUVq/RE7WvoHJPa
         no/pdzQxnix8+xy8EOWY06jvz1LcZ4pWLu1F6rSQxFy12H/n/olMkaZg/r4zn/yiAj5s
         UKa1/Vfmc0yGnCsnK8aVMhdkc/EUlUgIQPR9ADi/gkvxat9lWFnOLpzRaSdrHUSSWXvP
         FWGJWa0DRFgIe2GFB7xjQjcgICPCoFCsooilZP4uExpbXEdORWr5lJPz5pSJNw/Zk5Lo
         CjK0Gqc4Bz53LuDP46VFJfRsdYjgtXuh23ulzt/IrTDzLwUSQdGtLu47rGMkfxvgda/O
         aiWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771902974; x=1772507774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/DZt0xtYa5lr6976gZvjB7WdGufQG5+fQI8ZuixrTvM=;
        b=FEXB/TQa/XsdABd1HTFwIWaLdrtyu3fQ1a1ofbyQXAE+t6hNiXYIi8BPwCzng/cVXz
         wovfyfPSeK+c9dEXyhV1SaoEUSKOlAEW7w6QYVSc18k2fWrb/wt6n9hr78kYlnNE8rqU
         qj2mZVCVdUbWJMZFIEl9F/Sg/QCTfD9ucdiRWMdAtIJbYefYzayx74SXUWZD3r/AtDH4
         vRw+UvuIOou2C0011IYKaVt9WDjh4YmH47QMIJSI2XPQdXsSFN39D7il4CbDomffSDvu
         MxFGppXyYKiSCt5Z+oB1omj+/VFAGPtOm4zaC2J3nsRhle11GQn0o4uhmO1sJeP1pkkW
         IT+w==
X-Forwarded-Encrypted: i=1; AJvYcCVFP8vHHglfJmWrtfwTfJPx9p/O8BS+BwWfAFM8KJH6g24E+7Zjn/5pGxkinvZfGOyoe/Nyt9lHwqY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz91S2XRy3FqLvXYiW4P5vrlz9uzD68bW2WaU94W1w4976SKcwH
	3A6irFVAsGsjS5BTy0VJzXU60CEa1uJRialjW7hI6gbQkCOimgq6XuMlX3URCMGpT7qAdKqEM7l
	AKZhtkDXUXKXMReksTzBriiWGANUh8Fw=
X-Gm-Gg: AZuq6aJ49hu10L4kKpz34hPpG688w2s+So8JGpcTmXAo6pU45cG3fKnK24ZEYvdaBvZ
	K2yb9nQ4Dr7tfhYn2Y2Y+GLkEyV4g7iSa5kSy3SVCjb+GzKi5MOo4meZ7N30mvUVQHaMtBIqadn
	LsW/7+6ZPwNkxV+0YFpVYMz0T+dnXicRxmrmAyLoabnbeq9p8u2jEodBCP2aDsPyS4Grt1CZvdc
	XsYe4W5TRwsY6xnk+XiLPyBqW6LnW/ltHfcf9k4/a6pw9yiYdVMsGnsl2kps1tWS5k4X5bnpsgn
	Nq1ogw==
X-Received: by 2002:a17:907:268c:b0:b8e:380:5669 with SMTP id
 a640c23a62f3a-b905448b905mr922119166b.32.1771902973804; Mon, 23 Feb 2026
 19:16:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANT5p=rDxeYKXoCJoWRwGGXv4tPCM2OuX+US_G3hm_tL3UyqtA@mail.gmail.com>
 <7570f43c-8f6c-4419-a8b8-141efdb1363a@app.fastmail.com> <CANT5p=rpJDx0xXfeS3G01VEWGS4SzTeFqm2vO6tEnq9kS=+iOw@mail.gmail.com>
 <510c1f0a-4f42-4ce5-ab85-20d491019c53@app.fastmail.com>
In-Reply-To: <510c1f0a-4f42-4ce5-ab85-20d491019c53@app.fastmail.com>
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Tue, 24 Feb 2026 08:45:57 +0530
X-Gm-Features: AaiRm51Gum82xCPbCea-rxtnj6tTimqhg7EvD-Mp_KEO3nKBntLMk04j3n-RZRE
Message-ID: <CANT5p=q05gni_jd4=KHsmR0LnF5HE9gNfo17q6f8ngsjY5EZdw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Namespace-aware upcalls from kernel filesystems
To: Chuck Lever <cel@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, keyrings@vger.kernel.org, 
	CIFS <linux-cifs@vger.kernel.org>, linux-nfs@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19156-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nspmangalore@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A3AEE181566
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 7:51=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
>
>
> On Mon, Feb 16, 2026, at 11:14 PM, Shyam Prasad N wrote:
> > On Sat, Feb 14, 2026 at 9:10=E2=80=AFPM Chuck Lever <cel@kernel.org> wr=
ote:
> >>
> >>
> >> On Sat, Feb 14, 2026, at 5:06 AM, Shyam Prasad N wrote:
> >> > Kernel filesystems sometimes need to upcall to userspace to get some
> >> > work done, which cannot be achieved in kernel code (or rather it is
> >> > better to be done in userspace). Some examples are DNS resolutions,
> >> > user authentication, ID mapping etc.
> >> >
> >> > Filesystems like SMB and NFS clients use the kernel keys subsystem f=
or
> >> > some of these, which has an upcall facility that can exec a binary i=
n
> >> > userspace. However, this upcall mechanism is not namespace aware and
> >> > upcalls to the host namespaces (namespaces of the init process).
> >>
> >> Hello Shyam, we've been introducing netlink control interfaces, which
> >> are namespace-aware. The kernel TLS handshake mechanism now uses
> >> this approach, as does the new NFSD netlink protocol.
> >>
> >>
> >> --
> >> Chuck Lever
> >
> > Hi Chuck,
> >
> > Interesting. Let me explore this a bit more.
> > I'm assuming that this is the file that I should be looking into:
> > fs/nfsd/nfsctl.c
>
> Yes, clustered towards the end of the file. NFSD's use of netlink
> is as a downcall-style administrative control plane.
>
> net/handshake/netlink.c uses netlink as an upcall for driving
> kernel-initiated TLS handshake requests up to a user daemon. This
> mechanism has been adopted by NFSD, the NFS client, and the NVMe
> over TCP drivers. An in-kernel QUIC implementation is planned and
> will also be using this.
>
>
> > And that there would be a corresponding handler in nfs-utils?
>
> For NFSD, nfs-utils has a new tool called nfsdctl.
>
> The TLS handshake user space components are in ktls-utils. See:
> https://github.com/oracle/ktls-utils
>
> --
> Chuck Lever

Thanks Chuck. Will explore this in more detail.

--=20
Regards,
Shyam

