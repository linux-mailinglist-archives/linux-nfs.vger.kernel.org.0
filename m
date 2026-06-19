Return-Path: <linux-nfs+bounces-22684-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +RaYKPucNGplcwYAu9opvQ
	(envelope-from <linux-nfs+bounces-22684-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 03:35:55 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1ADD6A38F3
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 03:35:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=AW4KcBkX;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22684-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22684-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 451003019938
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 01:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADD82E7BD6;
	Fri, 19 Jun 2026 01:35:52 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD63C2E62C4
	for <linux-nfs@vger.kernel.org>; Fri, 19 Jun 2026 01:35:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781832952; cv=pass; b=f5DwSf/Wlq+27bNfiGhpnIXq7u7Wc9C2zifQgsDi6SCtD6FqBuMuDI9f/ju2yAZayZLJzO/8WFjY1aEnLD67WSXIn9SX2IlJwAWz4QrZGMUvHuki/v8JF+EtEd7R5P55kp/xbEzQlQCqosMwrFrGluts1WFueu5NCp6eeFjTyE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781832952; c=relaxed/simple;
	bh=azJktYWEHPOJGAeRyxYDHX7z+wVnnDulLZdfgh+GF+8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=iaFHSm0O8qz2Kf+e3NDLOwcshaHZB1PcyeiSLE9wNPO1r6yUPAXmRnm4GBmaD4qyr/IikqtE88fpmB2B5StEzdhEP1NMrkx1E3d2SbmyJknri3h98y58dDU4BTkgru3fukFAOtgo9/BV3bfE2QfbUiuIvBgi1ZWxHxV7f12mv3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AW4KcBkX; arc=pass smtp.client-ip=209.85.167.41
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aa65757ef4so166615e87.2
        for <linux-nfs@vger.kernel.org>; Thu, 18 Jun 2026 18:35:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781832949; cv=none;
        d=google.com; s=arc-20240605;
        b=A+EHPlZSxkHmPW+HHAMZgKaJz9kb1DYg9ajbJ6ioE/LIpC6U/YbnOZnAar7ch2fxRg
         dymbpIyMpDd1Qn66y5KLW72TxvPof7dr7AMNLLRGXPFermy+QGp9M6VTLCxDcUXcON5i
         o2OOkjVNv/EwjcRWVfeLxMHu8Fz2xgIynBz/E6Zs2J8X+KXCEEN9zD61V1kqS2BWUNfE
         mc6Uto1NcYTa2GftEP+Hb83yGhDCKT/E76Xd3KDHx0psmGTh8+BBCURWFmuhOSyG/BCx
         Etzjv5FMuKKeaBK9NAsvxyCs2PDFf42a9NKRhKq4E6i0q76XfEMeuQPx8UHGZu1iy6Mh
         AdJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=74/f6CikBP2D/D3uEJ6UMZj0R/zuWLLtspIldJfltjk=;
        fh=GVr5/8o+IL1SBDnRfxGwNhCX7E4n3FhDLyaKd71rFyY=;
        b=hUz/QAPCVLpDAgfqnW05bZvVGfMhiF+drwqkkb/x0qYcTcZOGAr7vPMReUOnID9ZEc
         UxhgN4+C/6SV3rfNc3ivGtNIkwC6fH9evKBIjyxSxlqyTNrcwfNLZpS5hXr0kbmT2tMu
         tXJ6BnGyNelrlG96re18SJiD8IglUH8tIt5RQ9u24e70lHkJWPOd4C4l/Z86S/SMDYlE
         Qb7D9bSVIQEMxyMAj8zA/PlxClkB/k98lIQfwBnVdepzDgfIIAfoO+2yU85jfO0/FTgN
         iBWQrbzdJl/wrhnTJgL2S97U9SICJPjUfTwvlEipnF2Plgmgw874JufSIem/snGxG+6K
         dW8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781832949; x=1782437749; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=74/f6CikBP2D/D3uEJ6UMZj0R/zuWLLtspIldJfltjk=;
        b=AW4KcBkXUSXC40ZxLzJdi0KZMeJZAGRlSjfXJLIV55hiMs3pl1ih4kApW6tnbSHcx8
         tJuqHsfzqUVVYGEDiRFWBmC27Opfm+OxfiLuU8LSteVvBHVLpXJXtJWuMsP7NpPXGTUi
         4CvMwggnRjQuTVUfg+gZ4dkPUkg4kHqHR12Rw1uwkM1G10maQUF9pf4kqfbQhxy035IQ
         oZHYT359wyK9lShiVcART9TvWPkvszgzL0nYzs/NCrlKiwEqIyHmZaRTF43KbKdnRDqk
         K5w1SbeJjphbBQPogyBYAxxd28PVn/ssTphJ4fd+xQxuUhHrLCI/hSW4x6sEG3TZCogm
         YK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781832949; x=1782437749;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=74/f6CikBP2D/D3uEJ6UMZj0R/zuWLLtspIldJfltjk=;
        b=hL722vsD3wMNvyTygU/QZ6TgQ2xy/joLybe/ZyVQ9DMun72oOzV24LctkJ4SJUnxP0
         qKefnp4yVpPq5g7qIBZCaiCFhGvYePtaQ1FxU2Wb3V/Nhbn0qi4xPjhY5lEe8CiTlWrf
         YLF3QQkPhxzkUtpq5Hh5qU6IqmFtnpXBNOEUmPHhyKVVei0EwGqH5P4h55pa3hvxDkni
         4iAJ3mk4bueuC/jZU0WBu0PdIW0KcLqEfbv8qA0KuVbBehEoh+0NwH/hPRhKKmNZrceB
         LxDTkM35qRDGwrX/2Mht75u3Dx5Sm9UQg4Njm1co6Z67W/naNXJnw+rhuKLxURSCN/dC
         vcQg==
X-Forwarded-Encrypted: i=1; AFNElJ/Cl94u6GVc4iuXsU4tWKsL5GE6+LCvz29gfrUTnLqvlyx+cgn3PhiO0qQb5ZoUnFWSK6DW7Qo55bA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLdyeMLnuKIQ+3uK0o2y0K3Vkc7i/IuFeOYad5IPAKkBjpVbfx
	vNFt811uTa+TynXZelAGIZCe6CTd3+cG/3CQXClzfm/H0WS11SrG/rTinK3FmW2UKnarWnIDQiw
	IlxJzm52jx/zYXAvaz31n0h0Sm1se0uY=
X-Gm-Gg: AfdE7ckicsWGlIz7o9ZRp4SGpslt4fts1zngNzMjOy+n2/AIT5yKea96Yt/4+3slWzN
	McNBwaZpzNy+r3MUsVHn7dMQFMyrd2DW46dVXUkwWWh85w+PugGQWSjC6d2AniGpt54LqD5Jbgz
	1RHTWRrywuoTrpxNVDMV6f3YCrWIdMNAwuSh5FcRxQZ5sj0L0XhWjwYiANBqoXiBzUAakxw2E5w
	dW+AkMz7EB2JKERWY+3Wz2AZzBHvQXTuuMvE8xatWBzXAHiwkS/qTcFbqit11dnlfQ1qxWpgW30
	r25l1WRZhrSsL4jMil6crGVkZAHeDQ==
X-Received: by 2002:ac2:5691:0:b0:5ad:441e:f3ec with SMTP id
 2adb3069b0e04-5ad562244d5mr270078e87.0.1781832948906; Thu, 18 Jun 2026
 18:35:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Vjaceslavs Klimovs <vklimovs@gmail.com>
Date: Thu, 18 Jun 2026 18:35:37 -0700
X-Gm-Features: AVVi8CdIhI3vFUJ-51bTXkb9gLw7DJIbdokJ4U_taPMiaYFMpC24OO-0CcT1qt4
Message-ID: <CAC_j7i1WXvMS6Q66w7-EGxZYFrdJ9R_DzA26xweP5=7z05KWzg@mail.gmail.com>
Subject: [PATCH] nfsd: bound GSS session fore-channel slots to the GSS replay window
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Tom Talpey <tom@talpey.com>, Nikhil Jha <njha@janestreet.com>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22684-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:njha@janestreet.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[vklimovs@gmail.com,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vklimovs@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F1ADD6A38F3

An RPCSEC_GSS context authenticates each RPC with a per-context
sequence number, and the server enforces a fixed 128-entry
replay/reorder window per context (GSS_SEQ_WIN,
net/sunrpc/auth_gss/svcauth_gss.c).  A client mounting with nconnect
> 1 round-robins a single context's sequence numbers across several
TCP connections that drain at different rates, and every retransmit
consumes a fresh sequence number.  The spread between the oldest
in-flight and the newest issued sequence number can therefore exceed
the number of in-flight RPCs; once it passes the window the server
drops the lagging request, the hard mount retransmits, and a krb5p
streaming write collapses into a retransmit storm (a stall to ~0 in
the field; an EIO under the krb5-nfs-perf reproducer).

The NFSv4.1 fore-channel slot count caps how many RPCs the client
keeps in flight, so it is the effective ceiling on the
sequence-number spread.  The default Linux client negotiates 64
fore-channel slots (NFS4_DEF_SLOT_TABLE_SIZE), and commit
60aa6564317d ("nfsd: allocate new session-based DRC slots on demand.")
lets the server grow the table far beyond that -- both exceed the
128-entry window once nconnect reordering and retransmits are
accounted for.

Bound a GSS-authenticated session's fore-channel slots to a quarter
of the window, at both the initial CREATE_SESSION grant and on-demand
growth, so the sequence-number spread stays inside the replay window.
A quarter (32) keeps a 4x margin against overrun yet still allows
enough in-flight RPCs to keep the per-byte krb5p crypto (AES plus
HMAC) saturated across many server CPUs, so it does not cap
streaming-write throughput on large machines.  sec=sys has no
per-context sequence window and keeps the full
NFSD_MAX_SLOTS_PER_SESSION table.

Signed-off-by: Vjaceslavs Klimovs <vklimovs@gmail.com>
---

Symptom / impact
  A production krb5p NFSv4.2 mount (vers=4.2, rsize=wsize=1M, proto=tcp,
  nconnect=8, sec=krb5p, enctype aes256-cts-hmac-sha384-192) that used to
  sustain ~1 GB/s on a 10 GbE link began stalling to ~0 after a 6.12 -> 6.18
  upgrade.  sec=sys over the same path is unaffected, and nconnect=1 does not
  trigger it.

Bisect
  Onset is 60aa6564317d ("nfsd: allocate new session-based DRC slots on
  demand.", v6.14).  Its parent caps the session slot table; the commit lets
  it grow on demand, so in-flight RPCs (already 64 from the client default)
  climb past the 128-entry GSS window and storm.

Reproduction / validation
  Two-VM QEMU harness (one VM a KDC + nfsd server, the other a krb5p client;
  nconnect=8; sequential write to a tmpfs-backed export):
    unpatched 6.18.x : retransmit storm (hundreds of retransmits) -> EIO
    patched          : clean, retrans 0
  Confirmed at both 2 and 16 vCPU per VM.

Why the cap is 32 (and why a server-side cap at all)
  The krb5p throughput ceiling here is GSS crypto, not the slot count: under
  load ~7-9 cores sit ~99% in-kernel on both ends (AES-NI plus HMAC-SHA384
  over every byte), and throughput scales with cores (~0.6 GB/s at 2 vCPU ->
  ~2.0 GB/s at 16).  The slot count is a *secondary* lever, because it caps
  how many RPCs are in flight to feed that parallel crypto.  Measured at
  16 vCPU, varying only the cap:
    16 slots -> ~1.7 GB/s    32 -> ~2.0 GB/s    40 -> ~2.15 GB/s    sys -> ~2.3
  40 starts to graze the window again; 32 was the largest value that stayed
  clean (retrans 0) across the sweep, so it keeps a 4x window margin without
  throttling streaming writes on many-core servers.  (16 only looked "free"
  at a 2-vCPU test point, where cores -- not slots -- were the bottleneck.)

Possible client-side follow-ups (not addressed by this patch)
  This is a server-side defensive bound.  Two client behaviors look worth a
  separate look:
   - the default of 64 GSS fore-channel slots already over-commits a single
     128-entry context window once spread across nconnect links; and
   - the v6.16 RFC2203 seqno cache (08d6ee6d8a10 "sunrpc: implement rfc2203
     rpcsec_gss seqnum cache", plus follow-ups) -- the intended mitigation
     for this storm -- in our testing converts a recoverable window graze
     into a hard EIO at the 64-slot floor rather than recovering.  Cc Nikhil
     Jha, who wrote it for the same workload.

 fs/nfsd/nfs4state.c | 4 ++++
 fs/nfsd/state.h     | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c5dba49c9035..f077f1b8a780 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3998,6 +3998,9 @@ nfsd4_create_session(struct svc_rqst *rqstp,
        status = check_forechannel_attrs(&cr_ses->fore_channel, nn);
        if (status)
                return status;
+       if (rqstp->rq_authop->flavour == RPC_AUTH_GSS &&
+           cr_ses->fore_channel.maxreqs > NFSD_GSS_MAX_SLOTS_PER_SESSION)
+               cr_ses->fore_channel.maxreqs = NFSD_GSS_MAX_SLOTS_PER_SESSION;
        status = check_backchannel_attrs(&cr_ses->back_channel);
        if (status)
                goto out_err;
@@ -4511,6 +4514,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct
nfsd4_compound_state *cstate,
         */
        if (seq->slotid == session->se_fchannel.maxreqs - 1 &&
            session->se_target_maxslots >= session->se_fchannel.maxreqs &&
+           rqstp->rq_authop->flavour != RPC_AUTH_GSS &&
            session->se_fchannel.maxreqs < NFSD_MAX_SLOTS_PER_SESSION) {
                int s = session->se_fchannel.maxreqs;
                int cnt = DIV_ROUND_UP(s, 5);
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index aaf513ed9104..4bec489ed26b 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -278,6 +278,14 @@ static inline struct nfs4_delegation
*delegstateid(struct nfs4_stid *s)
  * A large number can be needed to get good throughput on high-latency servers.
  */
 #define NFSD_MAX_SLOTS_PER_SESSION     2048
+/*
+ * Bound GSS sessions to a quarter of the 128-entry RPCSEC_GSS replay window
+ * (GSS_SEQ_WIN): nconnect spreads one context seqno space across links and
+ * each retransmit burns another, so cap both the initial grant and growth.
+ * 32 keeps a 4x margin against window overrun while still allowing enough
+ * in-flight RPCs to saturate the per-byte GSS crypto across many CPUs.
+ */
+#define NFSD_GSS_MAX_SLOTS_PER_SESSION 32
 /* Maximum  session per slot cache size */
 #define NFSD_SLOT_CACHE_SIZE           2048
 /* Maximum number of NFSD_SLOT_CACHE_SIZE slots per session */

