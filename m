Return-Path: <linux-nfs+bounces-21314-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKEhHKyR82la5AEAu9opvQ
	(envelope-from <linux-nfs+bounces-21314-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 19:30:20 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 139904A66F6
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 19:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD34C30115AA
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 17:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E402C0299;
	Thu, 30 Apr 2026 17:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="H0uRwY3o"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CD8477E34
	for <linux-nfs@vger.kernel.org>; Thu, 30 Apr 2026 17:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777570216; cv=pass; b=YgVqhU452EpJr1WeoQVNIbUMjlHPktjxdxggEu8KXgkXrlJxma+Er2Fi6ihoe0/c9bcqDGhWoV1SOYrUD2a0Df94XSEbVBCG1c4u0kB2Hj8A20ta18SMgDce+wAmc3SdMHBPkeC78DaMoHbis1WHo/exMtfhRUh/Z6F4KysA9A8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777570216; c=relaxed/simple;
	bh=iPVGo8wLWtiQLjKHKt6sVe+wtoN4F8hK8SJM9k5VYPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sg2U6ohxib2hu76YdimRq3ICTuiTBXB0w6CkujEKbUVD0y6m7YVzrYoUjXwqZXGtNppwP6J4w9An8yFqyi1QybU78Xc7GjhRa2BDD4Lgx2kdErVDX06E/KY2lyf3Pa8rnrCgiB5p4pgdMQYNHEOLARPEJsI0pHNO29F9mFm5VlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=H0uRwY3o; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a40502e63bso1135136e87.0
        for <linux-nfs@vger.kernel.org>; Thu, 30 Apr 2026 10:30:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777570210; cv=none;
        d=google.com; s=arc-20240605;
        b=I5mRqXeWHQFkXfc5fNTleT2oJ7eJYPO6Pts03EhucqW41GQ1PfSw4XrTIKK8l84yxt
         OP9Kkoads2GnoydgYUcsXlydtgIMaywcjM1OVdnSFr/igNZFEdkmxAdoKEWPQF9ONt4D
         F7gz6ILmPbsoCrE5wAdPHR2TDJ9RdvsbOfPJqhn4tY5+XLNBXFxT8soI/AXLYPfYj/tB
         PKDa4OW4Tu4RIqdqaajihPDjTq1EnRbwnBd76+xo0VU5JdV5rhrreF3zvVvRs4NM7S3r
         vZqByr4gBW7rd7ad6v3Fsh4QzIfpN8yoh6qeGTL53TBLuK2eCK6Ek3YU7mYTCeed5ibg
         dJOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L3n/eBIDHQ8frGWM4g8Jkhi2HqNJieLzaL7nNkBHPSw=;
        fh=EDOU3vQtlA2K0jVf+p1i9U6XmNOMBnIM2A6SBApZkr4=;
        b=dSr2ngcX9ugKT6QY6tX/ZteREqUIqzwbsvIxt3GYJ/gmVD/LOSrhn3+Seedm2QiN5Z
         l2Z+B1If+X4A/mxf/zSL9fOI0HH4qgr3y28Jp9O+2RVQifc0MU5KvsjSNdbGPdn1jlez
         dXoYar1ondiYO6HQMzxUQn1XDggWDFcVLW6iM/BwdqrmloK/TKA10TtReb+zwp1xTcS1
         U2bhCPbA9QaykboEYOCBk2r7SKb5/9hpn11iLr+6p/Jf6Q6G8UMiObvpZHTMefRR7rN5
         iXf+rbOKbu0jpkOKGA85V4WKF1y7UGeTMC6OL5UTxnU5qq+p78FQ9xHauQsTaZS2xLR+
         YIJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1777570210; x=1778175010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3n/eBIDHQ8frGWM4g8Jkhi2HqNJieLzaL7nNkBHPSw=;
        b=H0uRwY3o2BwGHDOrjEGqubB10oD9bnVuuTk4Yzqr1NtL/vUndtTAoh7zkIsbj61ips
         ZubyvDEzlvy4DgHLo1ZyZhq6IyOKmq3F5k/2Z5Xl5V4/kNGhtr9DK2cUkwQcH4Ly38tM
         leDwcF8aBdWeodl4ChT0Lu85atVaCVereRyCxIrABDI0VDIkpEQOCN6+/W4GB916IFZF
         N7WNhdToUZzqmg+HOnBWZqtKhZqR0OvGrFYDhwc7Pan5VMMWkAkwl20Rf34DJgx2Tda1
         njed1vul3p5z+97co8JYbAo4sbSb3OibxvQnxPQetvgjy9jA+l5tWQpNVo4wohcph+Zy
         YKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777570210; x=1778175010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L3n/eBIDHQ8frGWM4g8Jkhi2HqNJieLzaL7nNkBHPSw=;
        b=OPi/WYMQwiHE9NNGPNVqBLc7QiPZ8B/cFLnVIR5REa8lLBx8fT+5PBB6sfE9QK/k3q
         WUS4BbbZvGrLOU9+wBZXU7ImJorxLZNIKYUHbHJF+ojkiATwlQquSF1lvrdmeJd2ZN0Z
         5J4drh5bMRiZOfDqqbCHM5iucKLXbrcUz0mpQCGGveOOAYRUatrUvA5zDIrSrmm3Y/fw
         U7VMtbln6iy5ceuFPTlBX9wKemtuKBChdokqcWBrNZT/iUdpRyCxTIy6yFcvqevufPUv
         6WTZIXh1KSzIS92ztbVGnIeO+SDW/ewcmUT0tQw4nPgd2Ncblkywg6vEHJMd8Kb/hmCQ
         EQzA==
X-Gm-Message-State: AOJu0YygrS35t1bIb6lzRVahrcLDjvbBHvPHU1jecVbeFRW0KevALNSl
	49zWHfLY9SKMvP8NmGP/oQtGTj+wYCMFH61hP2ERn/WIHgfFkzsgsXlFSgP5Ksr/HD74IMwrDbt
	05Qovh+XxNSHAul0IOAz6KrCsyupxJ1Sg9A==
X-Gm-Gg: AeBDiet4OsZ4m+OW0VoIM44yq3MiGEmsbeJdbm6rYmZ0XXfYlNcLZcOWLCEyxTV2NR3
	LNrN2BnmvuYAYkl9XCzDaANHw9KYXgnVie2cC5TPzRvT+e+xBOP4SC8fFL1ANrJHn18yP3LqA9N
	OuvhglsiO7riUSn2q1cZmjUbxL8/vAv9v3NdwuhpPX4mPQUkb56NMdRqWHQO+m+hUEljPVMJmVV
	uF7l2D/BTmyyvmGAGkYcNms6cba0edsuDFAqI5r6p8r+BtkD7tOgcVd1nIv+KMLsSjlQY325Xmp
	Sxv8m0nu9YQCCDKNOw==
X-Received: by 2002:ac2:5333:0:b0:5a8:5276:f0db with SMTP id
 2adb3069b0e04-5a85276f10dmr1121797e87.15.1777570209757; Thu, 30 Apr 2026
 10:30:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2cb85a89-f896-4504-b1cf-e4494d344ffe@esat.kuleuven.be>
In-Reply-To: <2cb85a89-f896-4504-b1cf-e4494d344ffe@esat.kuleuven.be>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Thu, 30 Apr 2026 13:29:56 -0400
X-Gm-Features: AVHnY4KZP3aR4cgGjeIHJ67ZL-MhkJ-bP_Bp0ZyL4ll8oWStwgch11IKcU_uARU
Message-ID: <CAN-5tyGhC8q=iB_H6JaFZpwpWAqEz5NObVrzZ8m=3OzgLgJnpw@mail.gmail.com>
Subject: Re: NFS4ERR_SEQ_MISORDERED errors and NFS client very slow
To: Rik Theys <Rik.Theys@esat.kuleuven.be>
Cc: Linux Nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 139904A66F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[umich.edu,none];
	R_DKIM_ALLOW(-0.20)[umich.edu:s=google-2016-06-03];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-21314-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aglo@umich.edu,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[umich.edu:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Thu, Apr 30, 2026 at 2:54=E2=80=AFAM Rik Theys <Rik.Theys@esat.kuleuven.=
be> wrote:
>
> Hi,
>
> We have a Rocky 8 client running Linux 7.0.2 (kernel-ml from elrepo)
> that is an NFS client to a RHEL10 server.
>
> Lately we've noticed that NFS performance is very poor for certain
> workloads (We saw the same issue on the stock EL8 kernel, 6.18.20 and
> now 7.0.2). For example cloning git repositories is extremely slow.
>
> Looking at the server side there don't seem to be any saturations of the
> disk or network subsystems.
>
> I've taken a network dump between the client and server. In that dump I
> see that the server frequently responds to requests from the client with
> NFS4ERR_SEQ_MISORDERED (10063). What could be the cause of these
> mismatches? Is this always a client issue, or can this be caused by the
> server?

This might have been fixed by mentioned patch below. This patch will
be included in RHEL10.2 release.

If you have the ability to change the kernel on your NFS server I
would suggest trying some upstream version that has this patch
included to see if the problem goes away or wait until when RHEL10.2
comes out and test it.

commit 1cff14b7fc7f31363c39d0269563ce75c714f7ae
Author: NeilBrown <neil@brown.name>
Date:   Thu Oct 16 09:49:57 2025 -0400

    nfsd: ensure SEQUENCE replay sends a valid reply.

    nfsd4_enc_sequence_replay() uses nfsd4_encode_operation() to encode a
    new SEQUENCE reply when replaying a request from the slot cache - only
    ops after the SEQUENCE are replayed from the cache in ->sl_data.

    However it does this in nfsd4_replay_cache_entry() which is called
    *before* nfsd4_sequence() has filled in reply fields.

    This means that in the replayed SEQUENCE reply:
     maxslots will be whatever the client sent
     target_maxslots will be -1 (assuming init to zero, and
          nfsd4_encode_sequence() subtracts 1)
     status_flags will be zero

    The incorrect maxslots value, in particular, can cause the client to
    think the slot table has been reduced in size so it can discard its
    knowledge of current sequence number of the later slots, though the
    server has not discarded those slots.  When the client later wants to
    use a later slot, it can get NFS4ERR_SEQ_MISORDERED from the server.

    This patch moves the setup of the reply into a new helper function and
    call it *before* nfsd4_replay_cache_entry() is called.  Only one of the
    updated fields was used after this point - maxslots.  So the
    nfsd4_sequence struct has been extended to have separate maxslots for
    the request and the response.

    Reported-by: Olga Kornievskaia <okorniev@redhat.com>
    Closes: https://lore.kernel.org/linux-nfs/20251010194449.10281-1-okorni=
ev@redhat.com/
    Tested-by: Olga Kornievskaia <okorniev@redhat.com>
    Signed-off-by: NeilBrown <neil@brown.name>
    Reviewed-by: Jeff Layton <jlayton@kernel.org>
    Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

>
> Should the client not recover?
>
> Regards,
>
> Rik
>
> --
> Rik Theys
> System Engineer
> KU Leuven - Dept. Elektrotechniek (ESAT)
> Kasteelpark Arenberg 10 bus 2440  - B-3001 Leuven-Heverlee
> +32(0)16/32.11.07
> ----------------------------------------------------------------
> <<Any errors in spelling, tact or fact are transmission errors>>
>
>

