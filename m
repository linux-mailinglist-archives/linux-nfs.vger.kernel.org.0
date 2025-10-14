Return-Path: <linux-nfs+bounces-15245-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 109D5BDA2CD
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Oct 2025 16:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F93D188C502
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Oct 2025 14:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21631D8E1A;
	Tue, 14 Oct 2025 14:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="RFF3//Pk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93702FFDC6
	for <linux-nfs@vger.kernel.org>; Tue, 14 Oct 2025 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760453868; cv=none; b=S0q9DDRfOIkztgAV4A0QRX3xpTgrrNoa1tLwsbD7nr4CdSOR6pS0F3utFBad6MVk8UYBnDk0W6d3QnOeSn7LvI2sWIBl7Doi0TuxB1z6s1rKe3u18ENf6z3YtaeNC5DRXeRpxy6/6bbLh7Xw5DDYkKrARbhfCeckLReSToI009Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760453868; c=relaxed/simple;
	bh=+tzt8fP1PaPTFtZYUWfDJVmzV9YdxO1PrPtW0nK/F3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mn42tzK4tkFyPFnoq92dZPyZYgzR+ungAkVt72eHiOTE3HETugKjRh9RokM/iSzl20GxNXYsojceDvYDmV5NzWXDXv+Bu9lgO2K4K0CP/JV6ew/J20ZiH3n8jYT+vLhhqK0MY1Jkb6iIbpAMtY48YAsCU1XufektwL73UXbBGsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=RFF3//Pk; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-362acd22c78so45869351fa.2
        for <linux-nfs@vger.kernel.org>; Tue, 14 Oct 2025 07:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1760453865; x=1761058665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XiHT03rQ+XXvG3PgbkDRCYBI0FocYhi6rZFV2HnKD3c=;
        b=RFF3//PkmlxZjONzKVOdDPtuIt3WItYcW67+jlMJkuursKAMUHhiWvrviPJhCrlMar
         +W2aCUx8QP+UtT8N6JII752hbGMy5WYBXy/5GkilNFOm61eyfwsilPwB7IPBias4AkiO
         xbe0/QZWsKWVDRncukv2jUL9OGixPBlCvJFKGlOjP7toZPVDMjNf3vKLKYQSAKv1p6xd
         A2Zlku2D8c5JpovHZUBmkiTbXx+b1bFanVLeiVwhMK2fiMLQBK/LYi31UWzEhnHXX/14
         142tiPfJ1czIGKqMEg4u/zYIsAv+g/14mG0gDaRLGYN1thPH9C3ZrgaWe/bn6xFlAL/s
         gojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760453865; x=1761058665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XiHT03rQ+XXvG3PgbkDRCYBI0FocYhi6rZFV2HnKD3c=;
        b=Nxcrs2kQF9WaXZ22Si1AJdkHKLwON2yRP9/bvLIYLA4m0PlDRHckMopISDK1TPlNMY
         N5k721KL3wcI5rp4TFvI8VYnunRaUcKFHFVrEIB0wPSKuVclbM5Vp5cdV567rDBZJ1Oc
         znb+7/o2zdqT9THtlKZGJ4A4FNTUW5WVzlfqMPHOEhcC7M/HlZ4DxcDWd5naeCGyaskc
         KwTv9I6k2vB9IGmK/7YJ6KmYRUDlnoclGIXGzH+rGqiZMhBpiN3O6hMHbqMcRnlSqBqW
         E9KX8t1xHFm7oB0qk+biGLx+Aah4gG9du2TTsfcrmjMMOxUuWlGPdLIp5RRt51th4jtb
         lE7A==
X-Forwarded-Encrypted: i=1; AJvYcCWJTE9EVJN/RZQ1bmJjMfr6PQFpxCQildVA7sBbHiXQcuWH13d/XKJwjqVtpMqr0i4tKy0V6B8ASt4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze0kF8EOtR6A5dtGkJpioe7/xbes/s2oeFioHxcuwHYY90ZJK1
	EjFo3oo+kzt2c50PN5zPfmFPwrNYd3/uvmC9tcg8dGMmvej//m//KdOMAzZ8xKNm9LqRAo1oYVz
	ZhbT4D5vOzsOiqPUqdVUio1v9q0VEW2g=
X-Gm-Gg: ASbGncs/o24LaB1EpvmpTnjWccAa11Dy5LhUm60eazXnDq6GjGvCdJVi7Y21MiTxlde
	BJCK57PmQi4W96Rw3EYroOgJeAIbRD51oOsd4DhGB2FABQzJqV2bTCfsg/oANIQkROcBctAYC11
	mz4glRdfbyw0hGuTyh+ldEZs24NNtkXctjjESp3gjYs++dCOjwDKjU/uogznOS0fQUSfv/0x7h+
	0vQWDwCAQEicN/ac6WPBL8vLb7G5mbcH8Q7+ssb67LdlLyWh4yW5dJgykmT
X-Google-Smtp-Source: AGHT+IFQRj3MK8lc84r6wGUK8+GND54vFJAAzYhADIGSnB+wJMlunOljp0kGbZaKg34bRyYE90N3tEnCGJZyPeBQQdw=
X-Received: by 2002:a05:651c:2343:20b0:376:5ac5:9c41 with SMTP id
 38308e7fff4ca-3765ac5a290mr27221931fa.23.1760453864489; Tue, 14 Oct 2025
 07:57:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014000544.1567520-1-neilb@ownmail.net> <20251014000544.1567520-2-neilb@ownmail.net>
In-Reply-To: <20251014000544.1567520-2-neilb@ownmail.net>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Tue, 14 Oct 2025 10:57:32 -0400
X-Gm-Features: AS18NWA51ericm7Kwzpg04vod1wN32bUtpuFeszRm9oH7t-KdGUcLJIo_5vgFkk
Message-ID: <CAN-5tyHB0O-WQdqYDKONQ2unKHV2H1n__SD_qN9XGAYvx6=Apw@mail.gmail.com>
Subject: Re: [PATCH 1/2] nfsd: ensure SEQUENCE replay sends a valid reply.
To: NeilBrown <neil@brown.name>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 8:06=E2=80=AFPM NeilBrown <neilb@ownmail.net> wrote=
:
>
> From: NeilBrown <neil@brown.name>
>
> nfsd4_enc_sequence_replay() uses nfsd4_encode_operation() to encode a
> new SEQUENCE reply when replaying a request from the slot cache - only
> ops after the SEQUENCE are replay from the cache in ->sl_data.
>
> However it does this in nfsd4_replay_cache_entry() which is called
> *before* nfsd4_sequence() has filled in reply fields.
>
> This means that in the replayed SEQUENCE reply:
>  maxslots will be whatever the client sent
>  target_maxslots will be -1 (assuming init to zero, and
>       nfsd4_encode_sequence() subtracts 1)
>  status_flags will be zero
>
> which might mislead the client.

This also fixes the problem I described in my proposed patch. I would
have liked to see a bit more detail mentioning that it leads to the
client shrinking its slot table and then a hung client due to the
server's SEQ_MISORDERED error. I think having details in the commit
message might be useful for later connecting the symptoms to this
patch.

Tested-by: Olga Kornievskaia <okorniev@redhat.com>

> This patch moves the setup of the reply to *before*
> nfsd4_replay_cache_entry() is called.  Only one of the updated fields is
> used after this point - maxslots.  So that field is copied to
> client_maxslots so that can be used as needed.
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/nfsd/nfs4state.c | 41 +++++++++++++++++++++++------------------
>  1 file changed, 23 insertions(+), 18 deletions(-)
>
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index c9053ef4d79f..1c01836e8507 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4360,6 +4360,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4=
_compound_state *cstate,
>         struct nfs4_client *clp;
>         struct nfsd4_slot *slot;
>         struct nfsd4_conn *conn;
> +       u32 client_maxslots;
>         __be32 status;
>         int buflen;
>         struct net *net =3D SVC_NET(rqstp);
> @@ -4398,6 +4399,27 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd=
4_compound_state *cstate,
>         dprintk("%s: slotid %d\n", __func__, seq->slotid);
>
>         trace_nfsd_slot_seqid_sequence(clp, seq, slot);
> +
> +       /* prepare reply so that it is ready for nfsd4_replay_cache_entry=
() */
> +       client_maxslots =3D seq->maxslots;
> +       seq->maxslots =3D max(session->se_target_maxslots, client_maxslot=
s);
> +       seq->target_maxslots =3D session->se_target_maxslots;
> +
> +       switch (clp->cl_cb_state) {
> +       case NFSD4_CB_DOWN:
> +               seq->status_flags =3D SEQ4_STATUS_CB_PATH_DOWN;
> +               break;
> +       case NFSD4_CB_FAULT:
> +               seq->status_flags =3D SEQ4_STATUS_BACKCHANNEL_FAULT;
> +               break;
> +       default:
> +               seq->status_flags =3D 0;
> +       }
> +       if (!list_empty(&clp->cl_revoked))
> +               seq->status_flags |=3D SEQ4_STATUS_RECALLABLE_STATE_REVOK=
ED;
> +       if (atomic_read(&clp->cl_admin_revoked))
> +               seq->status_flags |=3D SEQ4_STATUS_ADMIN_STATE_REVOKED;
> +
>         status =3D check_slot_seqid(seq->seqid, slot->sl_seqid, slot->sl_=
flags);
>         if (status =3D=3D nfserr_replay_cache) {
>                 status =3D nfserr_seq_misordered;
> @@ -4425,7 +4447,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4=
_compound_state *cstate,
>
>         if (session->se_target_maxslots < session->se_fchannel.maxreqs &&
>             slot->sl_generation =3D=3D session->se_slot_gen &&
> -           seq->maxslots <=3D session->se_target_maxslots)
> +           client_maxslots <=3D session->se_target_maxslots)
>                 /* Client acknowledged our reduce maxreqs */
>                 free_session_slots(session, session->se_target_maxslots);
>
> @@ -4495,23 +4517,6 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd=
4_compound_state *cstate,
>         }
>
>  out:
> -       seq->maxslots =3D max(session->se_target_maxslots, seq->maxslots)=
;
> -       seq->target_maxslots =3D session->se_target_maxslots;
> -
> -       switch (clp->cl_cb_state) {
> -       case NFSD4_CB_DOWN:
> -               seq->status_flags =3D SEQ4_STATUS_CB_PATH_DOWN;
> -               break;
> -       case NFSD4_CB_FAULT:
> -               seq->status_flags =3D SEQ4_STATUS_BACKCHANNEL_FAULT;
> -               break;
> -       default:
> -               seq->status_flags =3D 0;
> -       }
> -       if (!list_empty(&clp->cl_revoked))
> -               seq->status_flags |=3D SEQ4_STATUS_RECALLABLE_STATE_REVOK=
ED;
> -       if (atomic_read(&clp->cl_admin_revoked))
> -               seq->status_flags |=3D SEQ4_STATUS_ADMIN_STATE_REVOKED;
>         trace_nfsd_seq4_status(rqstp, seq);
>  out_no_session:
>         if (conn)
> --
> 2.50.0.107.gf914562f5916.dirty
>
>

