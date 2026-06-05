Return-Path: <linux-nfs+bounces-22317-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G0FGLEEZI2qbiQEAu9opvQ
	(envelope-from <linux-nfs+bounces-22317-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 05 Jun 2026 20:45:21 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C7464AB88
	for <lists+linux-nfs@lfdr.de>; Fri, 05 Jun 2026 20:45:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=JrSM6SA8;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22317-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22317-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 06BB6306FDB0
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jun 2026 18:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43CE3E16B9;
	Fri,  5 Jun 2026 18:43:33 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598D8377543
	for <linux-nfs@vger.kernel.org>; Fri,  5 Jun 2026 18:43:32 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780685013; cv=pass; b=E6huREBtZOWIhFtcUWaBA4hp8UXz3iiwBzjonLT9ZqcMtrlb7uW0RxtZfUedK4/ZZ0Q79PyAaARrcPMcw1HaGHeO3gAlkhMpaUXWAdOo/Vjg1J/ehEUZ9Kf6Tln9Jr0t90jVaznpVwfBKOwzVU/HTPNG0rbAe2elkZQ3Sz6lk9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780685013; c=relaxed/simple;
	bh=7Izk8KSCvltnRVCbkgaZl/gyziqwHLW8SWrq+qO9kdc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=FDJvnsgPT/VtOOgwdYe1Y6CHhGpDlYyaFnGkLL0E1X2K2HeKP7qwL8kwfo1a4dZ3tWloQm/dZFGmif0Sb7Q6x6rBH4+F1Jhb+KrqR66oh9I33vaLhf52chp9JUmhGH8lsiSPKCaCafhPmePE56Hamp15S1t1yZ9Iz9e2AIbN/KA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JrSM6SA8; arc=pass smtp.client-ip=209.85.208.42
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-68d233bf083so3181325a12.1
        for <linux-nfs@vger.kernel.org>; Fri, 05 Jun 2026 11:43:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780685011; cv=none;
        d=google.com; s=arc-20240605;
        b=fp+IRNrFDD5IE+94yA4jRZjYsxrzPHNL5SathaW7KBTE9D3gDxoqopD9O+vGncu5P0
         gQZRsqedXnjqoNiVSbLY/4TwJa9Y19vSm0kyrohzgrbrAhx3rjTldFGyhqNPVW37C+lY
         9a2LB/QHeVG9psXZO/RBLr0TqFlBOCaVyJtGxsGyrchMOaYInqP0aRWRYCkeyKEsykXz
         yZLIZHEJpXR+MYo6Whe4GUL+D/bpypUSo5NHPD81z6BDW+ihXQLnjPs42gcHeQbCsmaE
         UfTk83n21SZpwyE6FN3O+1pUMYhJTqYC2dytYN/+8wKfAVcKyq0x64W/3ZGanY/HoSDW
         o1Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=7Izk8KSCvltnRVCbkgaZl/gyziqwHLW8SWrq+qO9kdc=;
        fh=A3pMOUK00huGibGCZBFsLekFLVbB5hHGKjUNNKwO+5E=;
        b=Kc1B/5JJf+E8xeGmv0bFfOlfYuM4LAw6+747C1mFxNn35omfi9BI+C5/ziyXrZKYgU
         0ywtszZD8Qpb6ri3WtEgEVspN0uiirBLr/vrXBKRuS8eamnebvw/yNFjmDlPoVpG6oEW
         995GrslYEKNn58dVhsik5eD70BtfNVUlcHFjaq+zuadmv+v1Z9VuhS5Vcxr0doVK/uwM
         5i5chlVLQSk70PZu/St7TbvHubwcgS3Ne/GiK7Q3TXngHgZHFP66bZAtYkvqUE6BRMdj
         BGv4x1ezWgwGz9Phvxa8v66iRwLGmuPYnJZPuq2x8g5gtBQgsAN18j1zBpj71Q9D046i
         n3ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780685011; x=1781289811; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7Izk8KSCvltnRVCbkgaZl/gyziqwHLW8SWrq+qO9kdc=;
        b=JrSM6SA8XsBWeR4AOTND8xju9ytgNAZoeRGAwXreHIZ+pM4Aug8UoQYdBXEITgSWAA
         qyfnoe0khnDcKTydv1KOP4FhLA7Glyw8YR5v7hLiQ3ewNqCaxLcvKw9/VhWxFDl3qIE7
         CHZiZHngWiJI0iliI8TH38JCucViHWsmBdA8A50FYwbvJei6xVYTgjCGz7Mi/yE2Hbwr
         UJwMaYLyB1LDW/erqE65azMfQrdwUs+mxdn+INmpL+9rHgoTeM744aNSq6fvtnllYwDr
         3skvOhMPBjvfkiS+LOHZ/dHun8d+eUFem47ki7W8SGLjWljz/ICOvMB6au444d2Ajwqf
         Mfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780685011; x=1781289811;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Izk8KSCvltnRVCbkgaZl/gyziqwHLW8SWrq+qO9kdc=;
        b=L3UirUllsJB1+w3/5syF0Xdzeui6oprvyi9fFxq/2cOdpMykY2oSg5vo+7uMFLNUhq
         Iug+6CsgcvJRj+rVRsx/aJ07DEFZyMJiiEAwtzfBmBQ+DtEjiR9sCojGkOnyDnAHeCQt
         sNek1fyLNeXr1C7USST2P/Cig1/5redW9p9vq6fM8VRi7zYgh94g7FwsTSW8rNf253LD
         YmtZLyq5v1CcCwXNxrAm0feudMn+WEJACrm/p/935Jf6ZSUlt6nW1rV9ZUDZFwfH/GYz
         WNociP0W6ujpx1dngxJ/s4uez6CdssMV3nAwUgJYrVxwLlVytaHNOxdpn6uFXxFARF3m
         T8mQ==
X-Gm-Message-State: AOJu0Yzgnwp9Br9dmnJzXjgH01E+YQH5BiPhmJQWzJA2uhAHKLYKWX29
	LnPGT5iJIXm+6gwuPHGnaa5ZEnRTqXzo9ijLn0GdJCiYfAbAq9I68mGdkXQ6a5Gg6ifSpUqMhP6
	buI582BpMP7Y0fRImWytbrIIzSVwogKMy5cj0jCM=
X-Gm-Gg: Acq92OG6E+LvgmWj10tCx/A+zHaH5lxoV+yCeIuH0N16/uDlnTG5riCCAXFcyNVGlLc
	b37pkReRQB4biA9O7aI9bD+XQsvcVFqmVAtHN8ke/JjJ08MfSO4C351J06aIRJJ2bHah8bEh5DD
	2+3/uVQKodSHZmBdb8DJnNt5UFyKn3s75TPjJouU/DTK3oNBaEWyNfXHQNbXuA3H8YCGR34d3qN
	xje1C4h93fFhK74Y6x0WyivMxieeZdZ96x7bGGVTZ/r1krQbzKgvnJkipU77nEXBiyLZMlSVR24
	B4P+kuwCTfA/ul+eVA==
X-Received: by 2002:a05:6402:4515:b0:67d:a63a:deb2 with SMTP id
 4fb4d7f45d1cf-68fa4c088efmr2416062a12.5.1780685010680; Fri, 05 Jun 2026
 11:43:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Fri, 5 Jun 2026 20:43:00 +0200
X-Gm-Features: AVVi8CdVskqs-5xfHq9iFVDSHo1FE-V__YWZ6tFvlyXfoBnYNGPjrp7pGLYfE6c
Message-ID: <CAAvCNcDDFWyZezvE3yBB+5sWpYqDrYFk5k46ekS+ij-5Ajp44w@mail.gmail.com>
Subject: I/O read and write *latency*, why is it so much higher on NFSv4.2,
 compared to P9 and iSCSI?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TAGGED_FROM(0.00)[bounces-22317-lists,linux-nfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[danfshelton@gmail.com,linux-nfs@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danfshelton@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,iitbombay.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 16C7464AB88

Except from the freebsd hackers mailing list:

On Tue, 19 May 2026 at 00:39, Bakul Shah <bakul@iitbombay.org> wrote:
>
> On May 18, 2026, at 2:26=E2=80=AFPM, Dan Shelton <dan.f.shelton@gmail.com=
> wrote:
> >
> > On Fri, 20 Feb 2026 at 01:21, Bakul Shah <bakul@iitbombay.org> wrote:
> >>
> >> On Feb 19, 2026, at 11:45=E2=80=AFAM, Dan Shelton <dan.f.shelton@gmail=
.com> wrote:
> >>>
> >>> On Wed, 18 Feb 2026 at 22:45, Dan Shelton <dan.f.shelton@gmail.com> w=
rote:
> >>>>
> >>>> Hello,
> >>>>
> >>>> Has anyone tried a BHYVE with a disk as file on a NFSv4.2 mount?
> >>
> >> Yes. [I tried this on a 15.0-RELEASE-p3 host, nfsv4.2 mounting
> >> a filesystem from a 15.0-STABLE machine]
> >
> > How about the performance? Is it better than iSCSI?
>
> I don't know about iSCSI but comparing with p9fs:
>
> Test1:
> dd bs=3D1m count=3D4000 > /dev/null < large-file
>
> nfsV3:
> 32.3
> 46.3
> 51.3
>
> nfsV4:
> 129.1
> 59.9
> 48.8
>
> p9fs:
> 17.7
> 17.5
> 17.6
>
> Test2:
> find /usr/src/ > /dev/null
>
> nfsV3:
> 60.0
> 39.0
> 30.9
>
> nfsV4:
> 54.0
> 17.9
> 35.8
>
> p9fs:
> 6.9
> 6.5
> 6.6
>
>
> So slower in all cases. In addition the variability in nfs numbers is con=
cerning!
>
> p9fs doesn't cache but nfs does, so anything cached is served much faster=
.

How is the situation on Linux? How is read/write *latency* NFSv4.2
compared to iSCSI and P9FS?

Dan
--=20
Dan Shelton - Cluster Specialist Win/Lin/Bsd

