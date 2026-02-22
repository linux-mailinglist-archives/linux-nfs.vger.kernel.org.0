Return-Path: <linux-nfs+bounces-19086-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5YN2GyOummmUfwMAu9opvQ
	(envelope-from <linux-nfs+bounces-19086-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Feb 2026 08:20:03 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA84016E946
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Feb 2026 08:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12095300E5FA
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Feb 2026 07:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADF51D5147;
	Sun, 22 Feb 2026 07:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwtvKFVx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C531C1C8626
	for <linux-nfs@vger.kernel.org>; Sun, 22 Feb 2026 07:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771744796; cv=pass; b=SdfR6BA9ILcV2nucQZ0IT9IfAd8FQK3QK0Lo/tcIOZs4nd5biUr0jiDrdBjXsDvYaqxOrEWIQyD5kqVWtBJww+TDP+s8N82Y3L9k+h0AOsK/kb5qZ2x7FSBwyria4ibtxXo3RiSxRir31FemPgRjQHXH/RVyB6h4sqE3h60Z/sM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771744796; c=relaxed/simple;
	bh=0lDfK3AuaNxxPB1Mx5JPD44YULX91cix/sE9XtEee8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OdobE2f49SmPRRSGPjrUB2uGZU9+5EIYVxLPKfWcrPZtcBO93acWtv9mUcbr4owAudTUvK4e0utsD8lppXfDmsoMOYJk8xkQTgeVBxFnlFCruAj1e2aKIZkaXKX88sUUuJvANJjBuxguomLZbuwgoTGpWBdOFJ0/lKFdRqdHpSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwtvKFVx; arc=pass smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5663601fe8bso3199468e0c.1
        for <linux-nfs@vger.kernel.org>; Sat, 21 Feb 2026 23:19:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771744794; cv=none;
        d=google.com; s=arc-20240605;
        b=L+KXwLGNxjxtUDY5o65cHpyCTYihVnklEJWmPb3cFx18QAPcCxTh53xXdcoXZ3YreT
         OSkJtO3CSXHVIwvNX7ZDo9qjVUDR7s5JYX9gBsDVKdLebzWq0fa2B+LmzySR6rBYsrOq
         8K38Hy2cPz6VLG3CkCxguJevMl6l/dk6VuRVqHG92UFTIAYsUY/tSli+39yZAp8fwqzo
         eZsFEunDTtu/PCA8FeV5wsW3qTn/2BowIkX6XxcYUjvJ16Abt1tGqeR2ATeq+ktDbMYN
         omOqQkUTrG0otXpq9v7EGakUN7Gh/OuQF1IthBBgRK7sIzEmDpbmK0zmDMYepS2mjuLW
         nvRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OILCq3HcP44ucOZfdh81GCluvZoTsk6wk990N+3C0dA=;
        fh=FWZNi9K2XScL3fMhdaTqQ3qYS0CK4rZccHpXtKzOZAE=;
        b=IQwiHmiji6aLuay6yAPJw5zoDPtPeBtqFsycqBCz1jgoK5xCzRqM6QASRHkBO9U9Xj
         7QXLlzeWoBOEpvz4d9D3Da+HQSn1VrQnx6CYy5WLMAFy9K56HHQUavnj4gwZyhwfzdN2
         K7psXPCob2652srIoNFk0Qe5wZYXW0u24oY7ZUdWB7CTdTMJjrgF1MPP2lkubiuWWdsf
         TlrrZJCm+IeH/9shc2zutsY7/tvyLWf+XhUdHcnW8puSm9EqUYicnrG8y935iexdWnMP
         J5CT3iioRv0hOYQA9xhVp/S4KRWW9bKIGOLMhyxw8OcpIFqMxtSD1YtBWMPK5yHJobBU
         y+gw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771744794; x=1772349594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OILCq3HcP44ucOZfdh81GCluvZoTsk6wk990N+3C0dA=;
        b=iwtvKFVxJY411/9ogEeNuKuIL+swHngOLh4yrtBI6Td3Zvrhz9GAxS6djLXc2BeeOf
         nwptn4OPwALolDkNO4yfUKWVGz6BTUQ/ZjsrhDkQelUcEp3u211ABAUwyaGfWUa3xyIl
         8TncN5e/ul82aK3psRyH0mTUkoioWE7HxKEG5Tl+V4ZPPo1duell20yNXLiz/uGQbSYH
         7yGlXL3++eZgdVawMupcKZlupPjYixQ8Rl23W+szYf64S6Jow0ieM/ciHxBMW07CFwOu
         mPqgTy21kVuM+pHA2DPgrWsLpiGUpwbZYMi/pXNbvGHP1UIGZhLEeFn1TM96mjwZUN8t
         bpvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771744794; x=1772349594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OILCq3HcP44ucOZfdh81GCluvZoTsk6wk990N+3C0dA=;
        b=Trq0T2lHS4oU87dTBNV2jrVcvyBlh2tf4oijbv8V5dXI8vULlrGu94wQt47whHwWW8
         eHmrwF8Sjbvg9RdAe4QM/zlpNje2hYPUeXLzJWancgiUF5HJp9Ai9doAjgprKNVsOt12
         z5caR7iEwUymX7EUCoJD1XgBhJ1TsLc6S4X+ZNyzwj3ilINFGDgGr7bMNq+w+uw/aXS9
         aUu4CGOvpdX+7UV7dQSDWxcIUmnRI9bXSNSrCaOKY3c0IgbDAUeN0PNap4j93KllP7WX
         3Yuthn6SSTi+13kJMWu7t5YxkBMybt3j0PUQrERxQcx0cDme56L4Qx4u/HF6F2DUeEKH
         7WgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxlckya5sDH3gOaEdoTsKk92Qe9vwCRHxaxfXp4kRDx4t1VSK18y2RCYWXepbIa4BIB4qb7qOVpTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGwoPALlZsBCSwjOuenJeuYKfaYOWlFK5FBr9V61QuBl6QmGRs
	bGmAgXo3rNQYq2gOmS6b+c/qd1s/eWA/oXlGPkCjaP+KTExg/dV0KdFpUFx+y2D+z29o54cPrUT
	4rgpCiZP7sFeqjc4Shymuo1AG/jhhnMY=
X-Gm-Gg: AZuq6aLMr2nBrH+tQP9NgL8neXso8UqOBK6u2jnq1+e6OPGIKwa5CSn1ffYV2bE+WKZ
	YzXfaCrQTkzGjIvpf+fRtikUspZB4r+JB/JGtZFN3xgu/A/zyydsxu19kf3PerFLf2syWU8R8MQ
	HTs/NoS2BjAe4UPc3mR7RMu7MOSD2yIfMLx6M3LuRWaJ1OGBziey3+mTN6mY3CGnVr0xgo36FCn
	nZyrN2FnGfeSUQRO+dE+zRV/Usgt0ERWTVnm5IBJzfbr5WpDKQkBI3yPEpU2bd1q6TfiiPusVwE
	3ce4eVvjtOHcAaFdRbWIg6gGiFrOELHhdjflX7uRPZAKqpMHOzsX8Q==
X-Received: by 2002:a05:6123:2c6:b0:55a:ab0d:bf74 with SMTP id
 71dfb90a1353d-568e489e04bmr2702083e0c.13.1771744793575; Sat, 21 Feb 2026
 23:19:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFfO_h7TJbB_170eoeobuanDKa2A+64o7-sb5Mpk3ts1oVUHtg@mail.gmail.com>
 <20260221234553.2024832-1-safinaskar@gmail.com>
In-Reply-To: <20260221234553.2024832-1-safinaskar@gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Sun, 22 Feb 2026 13:19:42 +0600
X-Gm-Features: AaiRm51yAd7WZH0JTtET-y37usKeLDtT6X5Vgs22uOg_jqenzkdmMaQOnOQPf2k
Message-ID: <CAFfO_h4dNydbmKSTP8uD9X6ouEZTyJUGoTBXrEHWeHtD1B=p5w@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] OPENAT2_REGULAR flag support in openat2
To: Askar Safin <safinaskar@gmail.com>
Cc: ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-nfs@vger.kernel.org, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19086-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BA84016E946
X-Rspamd-Action: no action

On Sun, Feb 22, 2026 at 5:46=E2=80=AFAM Askar Safin <safinaskar@gmail.com> =
wrote:
>
> Dorjoy Chowdhury <dorjoychy111@gmail.com>:
> > I am not sure if my patch series made it properly to the mailing
> > lists. https://lore.kernel.org/linux-fsdevel/  is showing a broken
> > series, only the 2/4, 3/4, 4/4 and I don't see cover-letter or 1/4.
> > The patch series does have a big cc list (what I got from
> > get_maintainers.pl excluding commit-signers) and I used git send-email
> > to send to everyone. It's also showing properly in my gmail inbox. Is
> > it just the website that's not showing it properly? Should I prune the
> > cc list and resend? is there any limitations to sending patches to
> > mailing lists with many cc-s via gmail?
>
> I see all 5 emails on
> https://lore.kernel.org/linux-fsdevel/CAFfO_h7TJbB_170eoeobuanDKa2A+64o7-=
sb5Mpk3ts1oVUHtg@mail.gmail.com/T/#t .
>

Yes, indeed. They showed up after a while.

> So this was some temporary problem on lore.kernel.org .
>
> Sometimes gmail indeed rejects mails if you try to send too many emails
> to too many people. So I suggest adding "--batch-size=3D1 --relogin-delay=
=3D20"
> to your send-email invocation. I hope this will make probability of
> rejection by gmail less. I usually add these flags.
>

Understood. I did not know about these flags.

> If you still expirence some problems with gmail, then you may apply
> for linux.dev email (go to linux.dev). They are free for Linux contributo=
rs.
>

Alright.

Thank you!

Regards,
Dorjoy

