Return-Path: <linux-nfs+bounces-22689-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gao9LJFRNWo8swYAu9opvQ
	(envelope-from <linux-nfs+bounces-22689-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 16:26:25 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B554B6A6668
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 16:26:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ao7k+VkA;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22689-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22689-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0211F3006085
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 14:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A93327467F;
	Fri, 19 Jun 2026 14:26:20 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27700266576
	for <linux-nfs@vger.kernel.org>; Fri, 19 Jun 2026 14:26:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781879180; cv=none; b=BL0+WgllCIArZkN5ymhMsXeCAQj8wtqz7OX6ow119MBZcYnB37insCptrFAPe7mM5FHPrpkvHrdbhUu/NWGB52D2v1EGzYgr4z04R+6JWoTf0IaF/F1YcSFb89KHbzVOVGBMH2ThWBqUcO7TG+bgZow0tjSRLuNd7sUgVkJueQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781879180; c=relaxed/simple;
	bh=uwBFbYJFqeJW57ZnlHL1CpeJZLG0JtLzBzjahWGkvHI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HP2FCLdZkJ0C7FXAXw2Iv1OBI38nXf4YbXYdK/xlDMEbboYB3x/BhT3vb4+5jWjmL2IMrbslsns+eqcH9imtuERo+sXh67SwsdXJZotkRu+tZLhl3fCARmBnuW+3VDOhwMWlxpUzwkTU8MArjiPJwBi3W3wQ4soE6BauIZOfgjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ao7k+VkA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73FC51F000E9;
	Fri, 19 Jun 2026 14:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781879178;
	bh=qhf7vMAcxY+L3SOlP92n/fPlg6HBqNkzu136NgrH26Q=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=ao7k+VkAElgGdOe19FqgoDnt5h3sfdx7VvB+aR16Iiq2r360bZebxANFpRlu69wtS
	 7d9n1Wr8hjUBr+wV23op+e8dX8rkPrGnRV7l8Ze3HLmttZtNEGdvCacnq2r0JTfVTg
	 hMBGsTiaOW/aWMFBd2lcTf9JUoqCKBtAiSzfme90Y0h27YlE1bsZXcSbQtRxGerR2r
	 UtfbY8DbywyvnPpDnbSLgm5IPXVaSs6H+9xWob5ZdWgIk5Vc6yAICb2+TFceZVWm1Z
	 tvdtc3zcSZZiKFs+uIowEdXUqr6arhIbpEmB6UbRhb6hmRO31vt6CxC9fB6jEpiuC4
	 x1c8qHnJwguLg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9B535F4006F;
	Fri, 19 Jun 2026 10:26:17 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 19 Jun 2026 10:26:17 -0400
X-ME-Sender: <xms:iVE1auJC48BDeK4HzXB3qR4H7oH327IIH1ePVqQc9yHQpdgse8wk9w>
    <xme:iVE1ag9awc7ppwrCXYQ4JwZrNMakd82FAI41AHS0m0bgdJRfGkJWj3CAhYNjVEi0r
    vewyUGhNcXKP7PLzvfhziqUno9mj34GqTU_Fd4RgpOZEjUklPhmpVU>
X-ME-Proxy-Cause: dmFkZTGsg01ta4QOX1s6rAAQZv7hDKnjiZQtoBCI1YnPrmitGOUH31nUtCizt48kLUYZAy
    Gzyz/3XpfOkKI6mvua+9f2khX/2ZZIFCtaHzHmGY9uxo/ApnaxNakWlCvHVxRxJryi2OQk
    u0XoQwgxnb3MhavSRCayb/bJRXrRlOIiTRAxjr6zadxszkC+iIEtOBxemOIOsQgRtO/Zj6
    BTy4U82Wjtcsa3qg2eJu5+xd4UPA8obhCA6J62hQVVdPF9ETUxkR5PrcE2k7sT5HnCmo6H
    floUid7OMKQGDtwveFXFhZs7rGYACYHMVMJqqrCtdGaDDGDUVcfGIjwB6rTnoN19advtgQ
    s46euab3r4fpZVdlCEbXF7l0BYeboxyy7sWGqhOt6NfnQsObtgwWlrdfPOa4Xb3oIAL+fs
    CIbvMEPPkTIqwNjG/Lu0ygrpALU99t2GWe++pkyFKpvj7QHuhK5UX+SCwT7pTgf5EKAg+G
    haST/nsv/gU1jM4JxYy1h82AvCTzWMqcQsxLA6O55DRakWJomTt4EOizVjJe/63iuiySYx
    47qeklvFvsCKz4Zg5S5ampyG1+9r31/8e0LWgXiIqqVZsi+19drGmSlbStn/NuxEdNdylq
    VyALACjkxniR6m9fTpgAPeEgfbyMhIUM/s3gqO4KETCNB68oVkyqq78Oa0ew
X-ME-Proxy: <xmx:iVE1anFcykRJ-58WhDwgFISzQDuqOOK_Y1ypB80h1jCBBsxOtLgEeg>
    <xmx:iVE1apSX71z-7pCja82yUNQ3lQggX2bcl8mbzgUEbWd4MlzQHuzpEQ>
    <xmx:iVE1ataxImqzyDIkqf5SMz91R6BtT-9n5LUOsBEI4f9SNlSwnCV9NQ>
    <xmx:iVE1ak2ydfMCOhEWU37eLBwj5aedPXkr0jF1SdmA0FMcN-UVDHnR9g>
    <xmx:iVE1agoVUVWjBAAqS8jgQty0s2slF07uPnGmMQVr1KusPTp5KqrjzSjU>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5EFA7780AB8; Fri, 19 Jun 2026 10:26:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ALiCYJP0Nqoo
Date: Fri, 19 Jun 2026 10:25:57 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Vjaceslavs Klimovs" <vklimovs@gmail.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Nikhil Jha" <njha@janestreet.com>, linux-nfs@vger.kernel.org
Message-Id: <99fbd31e-0827-413a-a0d9-e39765de79a7@app.fastmail.com>
In-Reply-To: 
 <CAC_j7i1WXvMS6Q66w7-EGxZYFrdJ9R_DzA26xweP5=7z05KWzg@mail.gmail.com>
References: 
 <CAC_j7i1WXvMS6Q66w7-EGxZYFrdJ9R_DzA26xweP5=7z05KWzg@mail.gmail.com>
Subject: Re: [PATCH] nfsd: bound GSS session fore-channel slots to the GSS replay
 window
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.15 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,oracle.com,kernel.org];
	FORGED_RECIPIENTS(0.00)[m:vklimovs@gmail.com,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:njha@janestreet.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22689-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,app.fastmail.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B554B6A6668


On Thu, Jun 18, 2026, at 9:35 PM, Vjaceslavs Klimovs wrote:
> An RPCSEC_GSS context authenticates each RPC with a per-context
> sequence number, and the server enforces a fixed 128-entry
> replay/reorder window per context (GSS_SEQ_WIN,
> net/sunrpc/auth_gss/svcauth_gss.c).  A client mounting with nconnect
>> 1 round-robins a single context's sequence numbers across several
> TCP connections that drain at different rates, and every retransmit
> consumes a fresh sequence number.  The spread between the oldest
> in-flight and the newest issued sequence number can therefore exceed
> the number of in-flight RPCs; once it passes the window the server
> drops the lagging request, the hard mount retransmits, and a krb5p
> streaming write collapses into a retransmit storm (a stall to ~0 in
> the field; an EIO under the krb5-nfs-perf reproducer).
>
> The NFSv4.1 fore-channel slot count caps how many RPCs the client
> keeps in flight, so it is the effective ceiling on the
> sequence-number spread.  The default Linux client negotiates 64
> fore-channel slots (NFS4_DEF_SLOT_TABLE_SIZE), and commit
> 60aa6564317d ("nfsd: allocate new session-based DRC slots on demand.")
> lets the server grow the table far beyond that -- both exceed the
> 128-entry window once nconnect reordering and retransmits are
> accounted for.
>
> Bound a GSS-authenticated session's fore-channel slots to a quarter
> of the window, at both the initial CREATE_SESSION grant and on-demand
> growth, so the sequence-number spread stays inside the replay window.
> A quarter (32) keeps a 4x margin against overrun yet still allows
> enough in-flight RPCs to keep the per-byte krb5p crypto (AES plus
> HMAC) saturated across many server CPUs, so it does not cap
> streaming-write throughput on large machines.  sec=3Dsys has no
> per-context sequence window and keeps the full
> NFSD_MAX_SLOTS_PER_SESSION table.
>
> Signed-off-by: Vjaceslavs Klimovs <vklimovs@gmail.com>
> ---
>
> Symptom / impact
>   A production krb5p NFSv4.2 mount (vers=3D4.2, rsize=3Dwsize=3D1M, pr=
oto=3Dtcp,
>   nconnect=3D8, sec=3Dkrb5p, enctype aes256-cts-hmac-sha384-192) that =
used to
>   sustain ~1 GB/s on a 10 GbE link began stalling to ~0 after a 6.12 -=
> 6.18
>   upgrade.  sec=3Dsys over the same path is unaffected, and nconnect=3D=
1 does not
>   trigger it.
>
> Bisect
>   Onset is 60aa6564317d ("nfsd: allocate new session-based DRC slots on
>   demand.", v6.14).  Its parent caps the session slot table; the commi=
t lets
>   it grow on demand, so in-flight RPCs (already 64 from the client def=
ault)
>   climb past the 128-entry GSS window and storm.
>
> Reproduction / validation
>   Two-VM QEMU harness (one VM a KDC + nfsd server, the other a krb5p c=
lient;
>   nconnect=3D8; sequential write to a tmpfs-backed export):
>     unpatched 6.18.x : retransmit storm (hundreds of retransmits) -> E=
IO
>     patched          : clean, retrans 0
>   Confirmed at both 2 and 16 vCPU per VM.
>
> Why the cap is 32 (and why a server-side cap at all)
>   The krb5p throughput ceiling here is GSS crypto, not the slot count:=
 under
>   load ~7-9 cores sit ~99% in-kernel on both ends (AES-NI plus HMAC-SH=
A384
>   over every byte), and throughput scales with cores (~0.6 GB/s at 2 v=
CPU ->
>   ~2.0 GB/s at 16).  The slot count is a *secondary* lever, because it=
 caps
>   how many RPCs are in flight to feed that parallel crypto.  Measured =
at
>   16 vCPU, varying only the cap:
>     16 slots -> ~1.7 GB/s    32 -> ~2.0 GB/s    40 -> ~2.15 GB/s    sy=
s -> ~2.3
>   40 starts to graze the window again; 32 was the largest value that s=
tayed
>   clean (retrans 0) across the sweep, so it keeps a 4x window margin w=
ithout
>   throttling streaming writes on many-core servers.  (16 only looked "=
free"
>   at a 2-vCPU test point, where cores -- not slots -- were the bottlen=
eck.)
>
> Possible client-side follow-ups (not addressed by this patch)
>   This is a server-side defensive bound.  Two client behaviors look wo=
rth a
>   separate look:
>    - the default of 64 GSS fore-channel slots already over-commits a s=
ingle
>      128-entry context window once spread across nconnect links; and
>    - the v6.16 RFC2203 seqno cache (08d6ee6d8a10 "sunrpc: implement rf=
c2203
>      rpcsec_gss seqnum cache", plus follow-ups) -- the intended mitiga=
tion
>      for this storm -- in our testing converts a recoverable window gr=
aze
>      into a hard EIO at the 64-slot floor rather than recovering.  Cc =
Nikhil
>      Jha, who wrote it for the same workload.
>
>  fs/nfsd/nfs4state.c | 4 ++++
>  fs/nfsd/state.h     | 8 ++++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index c5dba49c9035..f077f1b8a780 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -3998,6 +3998,9 @@ nfsd4_create_session(struct svc_rqst *rqstp,
>         status =3D check_forechannel_attrs(&cr_ses->fore_channel, nn);
>         if (status)
>                 return status;
> +       if (rqstp->rq_authop->flavour =3D=3D RPC_AUTH_GSS &&
> +           cr_ses->fore_channel.maxreqs > NFSD_GSS_MAX_SLOTS_PER_SESS=
ION)
> +               cr_ses->fore_channel.maxreqs =3D NFSD_GSS_MAX_SLOTS_PE=
R_SESSION;
>         status =3D check_backchannel_attrs(&cr_ses->back_channel);
>         if (status)
>                 goto out_err;
> @@ -4511,6 +4514,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct
> nfsd4_compound_state *cstate,
>          */
>         if (seq->slotid =3D=3D session->se_fchannel.maxreqs - 1 &&
>             session->se_target_maxslots >=3D session->se_fchannel.maxr=
eqs &&
> +           rqstp->rq_authop->flavour !=3D RPC_AUTH_GSS &&
>             session->se_fchannel.maxreqs < NFSD_MAX_SLOTS_PER_SESSION)=
 {
>                 int s =3D session->se_fchannel.maxreqs;
>                 int cnt =3D DIV_ROUND_UP(s, 5);
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index aaf513ed9104..4bec489ed26b 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -278,6 +278,14 @@ static inline struct nfs4_delegation
> *delegstateid(struct nfs4_stid *s)
>   * A large number can be needed to get good throughput on high-latenc=
y servers.
>   */
>  #define NFSD_MAX_SLOTS_PER_SESSION     2048
> +/*
> + * Bound GSS sessions to a quarter of the 128-entry RPCSEC_GSS replay=
 window
> + * (GSS_SEQ_WIN): nconnect spreads one context seqno space across lin=
ks and
> + * each retransmit burns another, so cap both the initial grant and g=
rowth.
> + * 32 keeps a 4x margin against window overrun while still allowing e=
nough
> + * in-flight RPCs to saturate the per-byte GSS crypto across many CPU=
s.
> + */
> +#define NFSD_GSS_MAX_SLOTS_PER_SESSION 32
>  /* Maximum  session per slot cache size */
>  #define NFSD_SLOT_CACHE_SIZE           2048
>  /* Maximum number of NFSD_SLOT_CACHE_SIZE slots per session */

First, a few process-related notes.

- The diff body is mangled and cannot be applied with the usual
  automated tool chains. You should consult the material under
  Documentation/process/ to see how to configure your email
  client so that patch content is preserved when you post.

- There is already a set of fixes in nfsd-testing that hopes
  to manage session slot table growth better, though it does
  not directly target GSS request reordering.

- The patch applies to linux-6.18.y, not to upstream, and not
  to nfsd-testing. So I'm assuming you are looking for review
  comments rather than asking for this to be merged.

Now, second, why I'm responding: krb5p request reordering is a
well-known issue, and the nconnect configuration you are using
is common. The combination of these two settings is going to
make things worse, so it deserves some discussion.

But to be blunt, the proposed approach is an operational hack,
not a long-term solution that closes the re-ordering window.

- krb5i is also affected, but since it's not as compute-
  intensive, it's not as frequent a problem.

- Other NFS versions are affected when nconnect > 1, but they
  don't have a session slot table so the proposed solution
  can't help them.

- Even when nconnect =3D=3D 1 there is a non-zero chance that
  one request is delayed until it falls outside the GSS
  sequence number window. (More on this below)

- The cap should be relative to the GSS window size, not
  a fixed constant. It could be set at CREATE_SESSION
  time, but the server doesn't know how many transport
  connections the client might make at that time.

- The selection of 32 is arbitrary. My own studies of the
  reordering issue shows that there is no limit (other than
  1) that can make re-ordering impossible. (My testing
  increased the GSS window instead of limiting it).

The reason for that is structural: the GSS window bounds
relative lag, not concurrency, but the NFSv4.1 session slot
count controls concurrency.

Those are different quantities, which is why no ratio can
close that gap and prevent reordering.

The server window in svcauth_gss is a sliding bound: it
tracks sd_max, the highest GSS seqno it has accepted, and
rejects anything below (sd_max - GSS_SEQ_WIN). sd_max
advances every time any request makes forward progress. So
the quantity that kills a request is how far its seqno
has fallen behind the leading edge (its lag), not how many
requests are in flight.

Now hold one request still (slow link, queued behind a busy
nfsd thread, a dropped segment awaiting retransmit) and let
the other M-1 slots keep cycling. Each reuse issues a fresh,
higher seqno; the server accepts them; sd_max climbs. The
stalled request's seqno doesn't move. Its lag grows without
bound for as long as it stays stalled... until it crosses
128 and is dropped. This happens for any M =E2=89=A5 2. The only
genuinely safe value is M =3D 1 (strict serialization, lag is
always 0), which is useless. So there is no useful ratio,
exactly as you found.

What M actually buys is the rate the leading edge advances:
with M-1 slots cycling at ~one completion per RTT, the edge
moves ~(M-1) seqnos per RTT, so a stalled request survives
~128/(M-1) RTTs before it's fatal.

  Smaller M =3D slower edge =3D longer grace period =3D
     lower steady-state spread under systematic reorder.

That's all the 32 does: it widens the grace window and lowers
the typical spread enough that drops become rare under the
reproducer's reorder pattern. It is a probability knob, not
an invariant. "4x margin" is margin against the spread the
reproducer happens to produce, not against reordering.

---

Now I'm speaking generally here, not proposing a specific
fix.

Since lag is the controlled variable, only something that
bounds lag directly fixes it:

- Client-side spread throttling: the client knows the
  oldest unacked seqno and the newest issued; it can
  refuse to issue a seqno more than (GSS_SEQ_WIN - margin)
  ahead of the oldest outstanding. That bounds lag at the
  source regardless of nconnect or slot count. This is the
  structurally correct fix, and it's on the side that has
  the information.

- Per-connection (or per-slot) GSS contexts: give each
  transport its own seqno space so connections draining at
  different rates don't share one window. Removes the
  cross-connection reorder entirely; costs more context
  state and a spec/implementation change.

- Negotiated window size: make GSS_SEQ_WIN scale with the
  advertised slot count rather than being a fixed=C2=A0128. The
  server can't shrink replay protection safely, but a
  larger window for high-slot sessions trades memory for
  headroom. Still not a guarantee (lag is unbounded), but it
  moves the knob to where the slots actually are.

The server slot cap is defensible as a stopgap the server
might deploy unilaterally without trusting clients... but
it's treating the symptom (spread) one step removed from
the cause (unbounded lag, controllable only where seqnos are
issued).


--=20
Chuck Lever

